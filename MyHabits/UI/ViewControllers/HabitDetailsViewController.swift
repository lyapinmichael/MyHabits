//
//  HabitDeatilsViewController.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 21.03.2023.
//

import UIKit

final class HabitDetailsViewController: UIViewController {

    // MARK: - Public properties
    var delegate: HabitsViewController?
    
    var habit: Habit?
    
    // MARK: - Private properties
    
    private enum CellID: String {
        case baseCell = "baseCell"
    }
    
    private lazy var detailsTableView: UITableView  = {
        let detailsTable = UITableView(frame: view.frame, style: .plain)
        detailsTable.backgroundColor = .systemGray6
        
        detailsTable.delegate = self
        detailsTable.dataSource = self
        
        detailsTable.register(UITableViewCell.self,
                                  forCellReuseIdentifier: CellID.baseCell.rawValue)
        
        detailsTable.translatesAutoresizingMaskIntoConstraints = false
        return detailsTable
    }()
    
    private lazy var modifyBarButton: UIBarButtonItem = {
       let modify = UIBarButtonItem()
        modify.title = "Править"
        modify.target = self
        modify.action = #selector(presentHabitView)
        
        return modify
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       
    }
    
    // MARK: - Private methods
    
    private func setup() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
        navigationItem.rightBarButtonItem = modifyBarButton
        view.addSubview(detailsTableView)

    }
    
    // MARK: - Public Methods
    
    func update(with habit: Habit) {
        navigationItem.title = habit.name
        self.habit = habit
    }
    
    // MARK: - Objc actions
    
    @objc private func presentHabitView() {
        let habitViewController = HabitViewController()
        habitViewController.delegate = self
        
        guard habit != nil else {fatalError("No habit")}
        
        habitViewController.modify(habit!)
        
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

// MARK: - TableView data source extension

extension HabitDetailsViewController: UITableViewDataSource {
    
    private func setupCell (_ cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        
        guard let habit = self.habit else { fatalError("No habit") }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        let allDates = HabitsStore.shared.dates.sorted { $0 > $1 }
        let date = allDates[indexPath.row]
        let today = Date()
        
        var content = cell.defaultContentConfiguration()
        
        if today.isToday(date) {
            content.text = "Сегодня"
        } else if today.isYesterday(date){
            content.text = "Вчера"
        } else {
            content.text = formatter.string(from: date)
        }
        

        cell.contentConfiguration = content
        cell.selectionStyle = .none
        cell.accessoryView = UIImageView(image: UIImage(systemName: "checkmark"))
        cell.accessoryView?.tintColor = UIColor(named: "Purple")

        if habit.trackDates.contains(where: {$0.isToday(date)} ) {
            cell.accessoryView?.isHidden = false
        } else {
            cell.accessoryView?.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: CellID.baseCell.rawValue) else { fatalError("TablView cell broken") }
        
        return setupCell(cell, at: indexPath)
    }
    
    
}

//MARK: - TableView delegate extension

extension HabitDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "АКТИВНОСТЬ"
    }
}
