//
//  HabitView.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 19.03.2023.
//

import UIKit

class HabitView: UIView {

    // MARK: - Public properties
    
    var title: String?
    var color: UIColor?
    var date: Date?
    
    weak var delegate: UIViewController?
    
    // MARK: - Private properties

    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "НАЗВАНИЕ"
        title.font = Fonts.footnoteSB
        
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var titleField: UITextField = {
        let titleField = UITextField()
        titleField.delegate = self
        titleField.returnKeyType = .done
        titleField.placeholder = "Бегать по утрам, спать 8 часов и т. п."
        titleField.textColor = UIColor(named: "Blue")
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        return titleField
    }()
    
    private lazy var colorLabel: UILabel = {
        let color = UILabel()
        color.text = "ЦВЕТ"
        color.font = Fonts.footnoteSB
            
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    private lazy var colorCircleView: UIView = {
        let colorCircle = UIView(frame: CGRect(x: .zero, y: .zero, width: 24, height: 24))
        colorCircle.backgroundColor = UIColor(named: "Orange")
        colorCircle.layer.cornerRadius = colorCircle.frame.size.height / 2
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(popColorPicker))
        colorCircle.addGestureRecognizer(tapRecognizer)
        
        colorCircle.translatesAutoresizingMaskIntoConstraints = false
        colorCircle.heightAnchor.constraint(equalToConstant: colorCircle.frame.size.height).isActive = true
        colorCircle.widthAnchor.constraint(equalToConstant: colorCircle.frame.size.width).isActive = true
        return colorCircle
    }()
    
    private lazy var colorPicker: UIColorPickerViewController = {
        let colorPicker = UIColorPickerViewController()
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        return colorPicker
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "ВРЕМЯ"
        timeLabel.font = Fonts.footnoteSB
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    private lazy var dailyLabel: UILabel = {
        let dailyLabel = UILabel()
        dailyLabel.text = "Каждый день в"
        dailyLabel.font = Fonts.body
        
        dailyLabel.translatesAutoresizingMaskIntoConstraints = false
        return  dailyLabel
    }()
    
    private lazy var dailyTime: UILabel = {
        let dailyTime = UILabel()
        dailyTime.font = Fonts.body
        dailyTime.textColor = UIColor(named: "Purple")
    
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        dailyTime.text = formatter.string(from: date)
        
        dailyTime.translatesAutoresizingMaskIntoConstraints = false
        return dailyTime
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.addTarget(self, action: #selector(pickTime(_:)), for: .valueChanged)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        return timePicker
    }()
    
//    private lazy var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 16
//        
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
    
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
//        addSubview(stackView)
//        stackView.addArrangedSubview(titleLabel)
//        stackView.addArrangedSubview(titleField)
//        stackView.addArrangedSubview(colorLabel)
//        stackView.addArrangedSubview(colorCircleView)
//        stackView.addArrangedSubview(timeLabel)
//        stackView.addArrangedSubview(dailyLabel)
//        stackView.addArrangedSubview(timePicker)
        
        addSubview(titleLabel)
        addSubview(titleField)
        addSubview(colorLabel)
        addSubview(colorCircleView)
        addSubview(timeLabel)
        addSubview(dailyLabel)
        addSubview(dailyTime)
        addSubview(timePicker)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapRecognizer)
        
        date = Date()
        color = colorCircleView.backgroundColor
        
    }
    
    // MARK: Constraints
    
    private func setConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            titleField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            colorLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
            colorLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            colorLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            colorCircleView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20),
            colorCircleView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            
            timeLabel.topAnchor.constraint(equalTo: colorCircleView.bottomAnchor, constant: 20),
            timeLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            dailyLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            dailyLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            //            dailyLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            dailyTime.centerYAnchor.constraint(equalTo: dailyLabel.centerYAnchor),
            dailyTime.leadingAnchor.constraint(equalTo: dailyLabel.trailingAnchor, constant: 8),
            
            timePicker.topAnchor.constraint(equalTo: dailyLabel.bottomAnchor, constant: 20),
            timePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            
        ])
    }
    
    // MARK: - Objc actions
    
    @objc private func pickTime(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dailyTime.text = dateFormatter.string(from: sender.date)
        date = sender.date
    }
    
    @objc private func popColorPicker() {
        
        UIView.animate(withDuration: 0.2,
                       delay: 0.02,
                       animations: {
            self.colorCircleView.alpha = 0.7
        }, completion: {_ in
            self.colorCircleView.alpha = 1
        })
        
        delegate?.present(colorPicker, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    @objc private func save() {
        
    }
    
}

// MARK: - TextField delegate extension

extension HabitView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        title = nil
        
        textField.placeholder = nil
        textField.font = Fonts.headline
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard textField.text != "" else {
            textField.font = Fonts.body
            textField.placeholder = "Бегать по утрам, спать 8 часов и т. п."
            return
        }
        
        title = textField.text
    }
    
}

extension HabitView: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.color = viewController.selectedColor
        self.colorCircleView.backgroundColor = viewController.selectedColor
    }
    
}
