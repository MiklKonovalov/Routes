//
//  ViewController.swift
//  Wildberries_MVC_test
//
//  Created by Misha on 05.06.2022.
//

import UIKit

final class ListTicketsViewController: UIViewController {
    
    var ticketService = TicketService()
    
    var tickets: [Ticket] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = .white
        tableView.allowsSelection = false
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
            
    //MARK: -Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .white

        setupTableView()
        
        fetchTickets()
    
    }

    //MARK: -Methods
    
    private func fetchTickets() {
        
        ticketService.getTickets { [weak self] tickets in
            guard let self = self else { return }
            self.tickets = tickets
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
            
        tableView.register(ListTicketsModulCell.self, forCellReuseIdentifier: "cellId")
            
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            
    }
    
}

//MARK: -UITableViewDelegate
extension ListTicketsViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let ticket = tickets[indexPath.row]
        let detailModulViewController = DetailModulViewController(index: indexPath.row, isLike: ticket.isLiked ?? false)
        detailModulViewController.modalPresentationStyle = .fullScreen
        self.present(detailModulViewController, animated: true, completion: nil)
        
        detailModulViewController.likeDidChange = { isLike in
            self.tickets[indexPath.row].isLiked = isLike
            self.tableView.reloadData()
        }
    }
}

//MARK: -UITableViewDataSource
extension ListTicketsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ListTicketsModulCell
        let ticket = tickets[indexPath.row]
        cell.configure(with: ticket)
        
        if ticket.isLiked ?? false {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.likeButton.tintColor = .red
        } else  {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.likeButton.tintColor = .white
        }

        cell.didTapLike = { isLiked in
            var ticket = self.tickets[indexPath.row]
            ticket.isLiked = isLiked
            self.tickets[indexPath.row] = ticket
            tableView.reloadData()
        }
        
        cell.backgroundColor = UIColor.systemBlue
        return cell
    }    
}

