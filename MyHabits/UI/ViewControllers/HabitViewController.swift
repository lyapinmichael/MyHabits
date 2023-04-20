//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 17.03.2023.
//

import UIKit

final class HabitViewController: UIViewController {
    
    // MARK: - Public properties
    
    var delegate: HabitsViewControllerDelegate?
    
    var habit: Habit? 
    // MARK: - Private properties
    
    private lazy var habitView: HabitView = {
       let habitView = HabitView()
        habitView.delegate = self
        
        habitView.translatesAutoresizingMaskIntoConstraints = false
        return habitView
    }()
    
    private lazy var cancelBarButton: UIBarButtonItem = {
        let cancelButton = UIBarButtonItem()
        cancelButton.tintColor = UIColor(named: "Purple")
        cancelButton.title = "Отмена"
        cancelButton.target = self
        cancelButton.action = #selector(close)
        
        return cancelButton
    }()
    
    private lazy var saveBarButton: UIBarButtonItem = {
        let saveButton = UIBarButtonItem()
        saveButton.tintColor = UIColor(named: "Purple")
        saveButton.title = "Сохранить"
        
        let titleAttributes: [NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 17, weight: .semibold)]
        saveButton.setTitleTextAttributes(titleAttributes, for: .normal)
        saveButton.setTitleTextAttributes(titleAttributes, for: .highlighted)
        
        saveButton.target = self
        saveButton.action = #selector(save)
        
        return saveButton
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    // MARK:  - Private methods
    
    private func setup() {
        title = "Создать"
        view.backgroundColor = UIColor(named: "PickedBackgroundWhite")
    
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = saveBarButton
        
        view.addSubview(habitView)
        setConstraints()
        
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            habitView.topAnchor.constraint(equalTo: view.topAnchor),
            habitView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func emptyTitleAlert() {
        let alertTitle = "Ой!"
        let alertMessage = "Пожалуйста, напишите, какую привычку вы хотите выработать."
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let handler: ((UIAlertAction) -> Void) = {_ in
        }
        let action = UIAlertAction(title: "Закрыть", style: .default, handler: handler)
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    // MARK: - Public methods
    
    func modify(_ habit: Habit) {
        
        habitView.setup(habit)
    
    }
    
    // MARK: - Objc actions
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
    @objc private func save() {
        
        habitView.endEditing(true)
        
        guard habitView.title != nil else {
            emptyTitleAlert()
            return
        }
        
        if let delegate = delegate as? HabitsViewController {
            
            let habit = Habit(name: habitView.title!,
                              date: habitView.date!,
                              color: habitView.color!)
            let habitsStore = HabitsStore.shared
            habitsStore.habits.append(habit)
            delegate.update()
            
        } else if let delegate = delegate as? HabitDetailsViewController {
            guard let habit = delegate.habit else {fatalError("No habit")}
            
            
            var habitsStore = HabitsStore.shared.habits
            guard let index = habitsStore.firstIndex(where: {$0 == habit}) else {fatalError("Habit not found in HabitsStore")}
            
            habit.name = habitView.title!
            habit.date = habitView.date!
            habit.color = habitView.color!
            delegate.update(with: habit)
            delegate.delegate?.update() //вот это место мне не нравится
            
            habitsStore[index] = habit
        }
        
        dismiss(animated: true)
    }

}
