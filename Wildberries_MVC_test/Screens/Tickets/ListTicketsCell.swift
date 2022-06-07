//
//  ListTicketsCell.swift
//  Wildberries_MVC_test
//
//  Created by Misha on 05.06.2022.
//

import UIKit

final class ListTicketsCell: UITableViewCell {
    
    private var startCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var endCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var startDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var endDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var isButtonPressed: Bool = false
    
    var didTapLike: ((Bool) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(startCityLabel)
        contentView.addSubview(endCityLabel)
        contentView.addSubview(startDateLabel)
        contentView.addSubview(endDateLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likeButton)
        
        setupConstraints()
        
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Ticket) {
        self.startCityLabel.text = model.startCity
        self.endCityLabel.text = model.endCity
        self.startDateLabel.text = "Туда: \(DateService.convertDate(date: model.startDate))"
        self.endDateLabel.text = "Обратно: \(DateService.convertDate(date:model.endDate))"
        self.priceLabel.text = "\(String(describing: model.price)) руб"
    }
    
    private func setupConstraints() {
        
        startCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        startCityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        
        endCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        endCityLabel.leadingAnchor.constraint(equalTo: startCityLabel.trailingAnchor, constant: 20).isActive = true

        startDateLabel.topAnchor.constraint(equalTo: startCityLabel.bottomAnchor, constant: 20).isActive = true
        startDateLabel.leadingAnchor.constraint(equalTo: startCityLabel.leadingAnchor).isActive = true
        startDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        endDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 10).isActive = true
        endDateLabel.leadingAnchor.constraint(equalTo: startDateLabel.leadingAnchor).isActive = true
        endDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        likeButton.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 20).isActive = true
        likeButton.leadingAnchor.constraint(equalTo: endDateLabel.leadingAnchor).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
    @objc func likeButtonPressed() {
        if isButtonPressed == false {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
            isButtonPressed = true
        } else if isButtonPressed == true {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .white
            isButtonPressed = false
        }
        didTapLike?(isButtonPressed)
    }
}
