//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 19.03.2023.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {

    // MARK: - Public properties
    
    static let id = "habitCell"
    
    // MARK: - Private Properties
    
    private var state: Bool? {
        willSet {
            switch newValue {
            case true:
                circle.image = UIImage(systemName: "checkmark.circle.fill")
            default:
                circle.image = UIImage(systemName: "circle")
            }
        }
    }
    
    private lazy var habitCellView: UIView = {
        let view = UIView(frame: contentView.frame)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        view.heightAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
        view.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var habitLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.headline
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.caption
        label.textColor = .systemGray2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.footnoteRG
        label.textColor = .systemGray
        label.text = "Счетчик: "
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var circle: UIImageView = {
        let circle = UIImageView(frame: CGRect(x: .zero, y: .zero, width: 40, height: 40))
        circle.image = UIImage(systemName: "circle")
        
        circle.heightAnchor.constraint(equalToConstant: circle.frame.height).isActive = true
        circle.widthAnchor.constraint(equalToConstant: circle.frame.width).isActive = true
        
        circle.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleCircle(_:)))
        circle.addGestureRecognizer(tapRecognizer)
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()
    
    // MARK: - Override init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setup() {
        contentView.addSubview(habitCellView)
        habitCellView.addSubview(habitLabel)
        habitCellView.addSubview(timeLabel)
        habitCellView.addSubview(countLabel)
        habitCellView.addSubview(circle)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            habitLabel.topAnchor.constraint(equalTo: habitCellView.topAnchor, constant: 16),
            habitLabel.leadingAnchor.constraint(equalTo: habitCellView.leadingAnchor, constant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: habitCellView.leadingAnchor, constant: 20),
            
            countLabel.bottomAnchor.constraint(equalTo: habitCellView.bottomAnchor, constant: -16),
            countLabel.leadingAnchor.constraint(equalTo: habitCellView.leadingAnchor, constant: 20),
            
            circle.centerYAnchor.constraint(equalTo: habitCellView.centerYAnchor),
            circle.trailingAnchor.constraint(equalTo: habitCellView.trailingAnchor, constant: -16)
            
        ])
    }
    
    // MARK: - Public methods
    
    func setup(with habit: Habit) {
        
        habitLabel.text = habit.name
        habitLabel.textColor = habit.color
        
        timeLabel.text = habit.dateString
        
        circle.tintColor = habit.color
        
        update(with: habit)
    }
    
    func update(with habit: Habit) {
        state = habit.isAlreadyTakenToday
        countLabel.text? += "\(habit.trackDates.count)"
    }
    
    // MARK: - Objc actions
    
    @objc private func toggleCircle(_ sender: UIImageView) {
        
        guard let superView = superview as? UICollectionView else { return }
        
        let index = superView.indexPath(for: self)!.row
        let habit = HabitsStore.shared.habits[index]
        
        guard state == false else { return }
        
        HabitsStore.shared.track(habit)
        update(with: habit)
    
    }
}
