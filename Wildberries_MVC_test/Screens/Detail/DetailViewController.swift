//
//  DetailViewController.swift
//  Wildberries_MVC_test
//
//  Created by Misha on 06.06.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var ticketService = TicketService()
    
    private var tickets: [Ticket] = []
    
    private var index: Int
    
    private var isLike: Bool
    
    var likeDidChange: ((Bool) -> ())?
    
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
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("Сделать любимым", for: .normal)
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.turn.up.backward.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: -Init
    
    init(index: Int, isLike: Bool) {
        self.index = index
        self.isLike = isLike
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        
        view.addSubview(backButton)
        view.addSubview(startCityLabel)
        view.addSubview(endCityLabel)
        view.addSubview(startDateLabel)
        view.addSubview(endDateLabel)
        view.addSubview(priceLabel)
        view.addSubview(likeButton)
        
        setupConstraints()
        
        ticketService.getTickets { tickets in
            DispatchQueue.main.async {
                self.tickets = tickets
                let ticket = tickets[self.index]
                self.configure(with: ticket)
                self.reloadInputViews()
            }
        }

        if isLike == true {
            self.likeButton.setTitle("Любимый перелёт", for: .normal)
            self.likeButton.backgroundColor = .red
        } else {
            self.likeButton.setTitle("Сделать любимым", for: .normal)
            self.likeButton.backgroundColor = .white
        }
    }
    
    //MARK: -Methods
    
    private func configure(with model: Ticket) {
        self.startCityLabel.text = "Откуда: \(model.startCity)"
        self.endCityLabel.text = "Куда: \(model.endCity)"
        self.startDateLabel.text = "Туда: \(DateService.convertDate(date: model.startDate))"
        self.endDateLabel.text = "Обратно: \(DateService.convertDate(date:model.endDate))"
        self.priceLabel.text = "\(String(describing: model.price)) руб"
    }
    
    private func setupConstraints() {
        
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        startCityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        startCityLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        endCityLabel.topAnchor.constraint(equalTo: startCityLabel.bottomAnchor, constant: 30).isActive = true
        endCityLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        startDateLabel.topAnchor.constraint(equalTo: endCityLabel.bottomAnchor, constant: 30).isActive = true
        startDateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        endDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 30).isActive = true
        endDateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 30).isActive = true
        priceLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        likeButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30).isActive = true
        likeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    //MARK: -Selectors
    
    @objc func likeButtonPressed() {
        if isLike == false {
            self.likeButton.setTitle("Любимый перелёт", for: .normal)
            self.likeButton.backgroundColor = .red
            isLike = true
        } else {
            self.likeButton.setTitle("Сделать любимым", for: .normal)
            self.likeButton.backgroundColor = .white
            isLike = false
        }
        likeDidChange?(isLike)
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
        
    }
}
