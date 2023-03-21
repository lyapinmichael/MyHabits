//
//  TodayViewController.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 17.03.2023.
//

import UIKit

final class HabitsViewController: UIViewController {

    // MARK: - Private properties
    
    private lazy var plusBarButtonItem: UIBarButtonItem = {
        let plus = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(presentHabitView)
        )
        
        plus.tintColor = UIColor(named: "Purple")
        return plus
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "PickedBackgroundWhite")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: ProgressCollectionViewCell.id)
        
        collectionView.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: HabitCollectionViewCell.id)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        title = "Сегодня"
        navigationItem.rightBarButtonItem = plusBarButtonItem
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    // MARK: - Public methods
    
    func update() {
        collectionView.reloadData()
    }
    
    func updateProgress() {
        guard let progressCell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? ProgressCollectionViewCell else { return }
        
        progressCell.updateProgress(HabitsStore.shared.todayProgress)
    }
    
    // MARK: - @Objc actions
    
    @objc private func presentHabitView() {
        
        let habitViewController = HabitViewController()
        habitViewController.delegate = self
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(named: "PickedNavBarWhite")
        
        let habitNavigationController = UINavigationController(rootViewController: habitViewController)
        habitNavigationController.navigationBar.standardAppearance = navBarAppearance
        habitNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        habitNavigationController.modalPresentationStyle = .overFullScreen
        present(habitNavigationController, animated: true)
    }

}

// MARK: - CollectionView datasource

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgressCollectionViewCell.id,
                for: indexPath) as! ProgressCollectionViewCell
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitCollectionViewCell.id,
                for: indexPath) as! HabitCollectionViewCell
            cell.setup(with: HabitsStore.shared.habits[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
    
    
}

// MARK: - CollectionView delegate

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Insets.top, left: Insets.side, bottom: 0, right: Insets.side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width - Insets.side * 2
        
        if indexPath.section == 0 {
            return CGSize(width: width, height: 64)
        } else {
            return CGSize(width: width, height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            let habit = HabitsStore.shared.habits[indexPath.row]
            
            let detailsViewController = HabitDeatilsViewController()
            detailsViewController.update(with: habit)
            
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
}
