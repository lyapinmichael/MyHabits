//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 17.03.2023.
//

import UIKit

final class InfoViewController: UIViewController {

    // MARK: - Private properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let stackView = UIView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var infoTitle: UILabel = {
        let infoTitle = UILabel()
        infoTitle.font = Fonts.title
        infoTitle.text = Info.title
        
        infoTitle.translatesAutoresizingMaskIntoConstraints = false
        return infoTitle
    }()
    
    private lazy var infoText: UILabel = {
        let infoText = UILabel()
        infoText.font = Fonts.body
        infoText.sizeToFit()
        infoText.numberOfLines = 0
        infoText.text = Info.body
        
        infoText.translatesAutoresizingMaskIntoConstraints = false
        return infoText
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Private methods
    
    private func setup() {
       
        title = "Информация"
        
        addSubviews()
        setConstraints()
        setupContentSubviews()
        
    }
    
    private func addSubviews() {

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: safeArea.widthAnchor)
            
        ])
    }
    
    private func setupContentSubviews() {
        contentView.addSubview(infoTitle)
        contentView.addSubview(infoText)
        
        NSLayoutConstraint.activate([
            infoTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            infoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            infoText.topAnchor.constraint(equalTo: infoTitle.bottomAnchor, constant: 20),
            infoText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            scrollView.bottomAnchor.constraint(equalTo: infoText.bottomAnchor, constant: 20)
            
        ])
    }

}
