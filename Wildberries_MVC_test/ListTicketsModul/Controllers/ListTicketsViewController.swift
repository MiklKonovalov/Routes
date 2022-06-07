//
//  ViewController.swift
//  Wildberries_MVC_test
//
//  Created by Misha on 05.06.2022.
//

import UIKit

struct Likes {
    let id: Int
    let isLike: Bool
}

final class ListTicketsViewController: UIViewController {
     
    var listTicketsNetworkService = ListTicketsNetworkService()
    
    var tickets: [Ticket] = []
    
    var likesDict: [Int:Bool] = [:]
    
    var likesArray: [Likes] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = .white
        tableView.allowsSelection = false
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
            
    //Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .white

        view.addSubview(tableView)
            
        setupTableView()
        
        listTicketsNetworkService.getTickets { response in
            DispatchQueue.main.async {
                self.tickets = response.data
                self.tableView.reloadData()
            }
        }
    }

    //Functions
        
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
            
        tableView.register(ListTicketsModulCell.self, forCellReuseIdentifier: "cellId")
            
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            
    }
    
}

extension ListTicketsViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailModulViewController = DetailModulViewController(index: indexPath.row
        )
        detailModulViewController.modalPresentationStyle = .fullScreen
        self.present(detailModulViewController, animated: true, completion: nil)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListTicketsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ListTicketsModulCell
        let ticket = tickets[indexPath.row]
        cell.configure(with: ticket)
        
        if cell.isButtonPressed == true {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.likeButton.tintColor = .red
        } else if cell.isButtonPressed == false {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.likeButton.tintColor = .white
        }
        
        likesDict = UserDefaults.standard.object(forKey: "Like") as? [Int : Bool] ?? [Int:Bool]()
        print(likesDict)
        
        cell.didTapLike = { isLiked in
            self.likesDict.updateValue(isLiked, forKey: indexPath.row)
            cell.isButtonPressed = isLiked
            UserDefaults.standard.set(isLiked, forKey: "Like")
            print(self.likesDict)
        }
        
        cell.backgroundColor = UIColor.systemBlue
        return cell
    }
    
}

extension ListTicketsViewController {

    func convertDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        guard let date = dateFormatter.date(from: date) else { return "Нет даты" }
        dateFormatter.dateFormat = "dd MMMM"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
