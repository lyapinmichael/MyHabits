//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 19.03.2023.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static let id = "progressCell"
    
    // MARK: - Private Properties
    
    private lazy var progressCellView: UIView = {
        let view = UIView(frame: contentView.frame)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        view.heightAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
        view.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.font = Fonts.footnoteSB
        label.textColor = .systemGray
        label.text = "Все получится!"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.footnoteSB
        label.textColor = .systemGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
       let progressBar = UIProgressView()
        progressBar.progressTintColor = UIColor(named: "Purple")
        progressBar.progressViewStyle = .default
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    // MARK: - Override init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
    
        setup()
        setConstraints()
        updateProgress(HabitsStore.shared.todayProgress)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setup() {
        contentView.addSubview(progressCellView)
        progressCellView.addSubview(label)
        progressCellView.addSubview(progressBar)
        progressCellView.addSubview(progressLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: progressCellView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: progressCellView.leadingAnchor, constant: 12),
            
            progressLabel.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: progressCellView.trailingAnchor, constant: -12),
            
            progressBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            progressBar.leadingAnchor.constraint(equalTo: progressCellView.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: progressCellView.trailingAnchor, constant: -12),
            progressBar.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    // MARK: - Public methods
    
    func updateProgress(_ newValue: Float) {
        progressBar.setProgress(newValue, animated: true)
        progressLabel.text = String(format: "%.0f", newValue*100) + "%"
    }
    
}
