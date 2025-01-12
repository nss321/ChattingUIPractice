//
//  ViewController.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/11/25.
//

import UIKit

class ViewController: UIViewController, ViewPresenstableProtocol {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    let chattingList = mockChatList
    
    let cellHeight: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configSearchBar()
    }
}

// MARK: TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = chattingList[indexPath.row]
        
        switch row.chatroomImage.count {
        case 0:
            print("0명")
            let cell = tableView.dequeueReusableCell(withIdentifier: SingleChattingListTableViewCell.identifier, for: indexPath) as! SingleChattingListTableViewCell
            cell.config(row: row)
            cell.profileImage.layer.cornerRadius = (cellHeight - 24) / 2
            return cell
        case 1:
            print("2명")
            let cell = tableView.dequeueReusableCell(withIdentifier: SingleChattingListTableViewCell.identifier, for: indexPath) as! SingleChattingListTableViewCell
            cell.config(row: row)
            cell.profileImage.layer.cornerRadius = (cellHeight - 24) / 2
            return cell
        case 2:
            print("3명")
            let cell = tableView.dequeueReusableCell(withIdentifier: ThreePeopleTableViewCell.identifier, for: indexPath) as! ThreePeopleTableViewCell
            cell.config(row: row)
            cell.firstProfileImageView.layer.cornerRadius = (cellHeight - 44) / 2
            cell.secondProfileImageView.layer.cornerRadius = (cellHeight - 44) / 2
            return cell
        case 3:
            print("4명")
            let cell = tableView.dequeueReusableCell(withIdentifier: FourPeopleTableViewCell.identifier, for: indexPath) as! FourPeopleTableViewCell
            cell.config(row: row)
            cell.firstProfileImageView.layer.cornerRadius = (cellHeight - 48) / 2
            cell.secondProfileImageView.layer.cornerRadius = (cellHeight - 48) / 2
            cell.thirdProfileImageView.layer.cornerRadius = (cellHeight - 48) / 2
            return cell
        case 4:
            print("5명 이상")
            let cell = tableView.dequeueReusableCell(withIdentifier: FiveMoreTableViewCell.identifier, for: indexPath) as! FiveMoreTableViewCell
            cell.config(row: row)
            cell.firstProfileImageView.layer.cornerRadius = (cellHeight - 52) / 2
            cell.secondProfileImageView.layer.cornerRadius = (cellHeight - 52) / 2
            cell.thirdProfileImageView.layer.cornerRadius = (cellHeight - 52) / 2
            cell.fourthProfileImageView.layer.cornerRadius = (cellHeight - 52) / 2
            return cell
        default :
            print("디폴트")
            let cell = tableView.dequeueReusableCell(withIdentifier: SingleChattingListTableViewCell.identifier, for: indexPath) as! SingleChattingListTableViewCell
            cell.config(row: row)
            cell.profileImage.layer.cornerRadius = (cellHeight - 24) / 2
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ChattingViewController") as! ChattingViewController
        vc.chatRoom = chattingList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: SingleChattingListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SingleChattingListTableViewCell.identifier)
        tableView.register(UINib(nibName: ThreePeopleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ThreePeopleTableViewCell.identifier)
        tableView.register(UINib(nibName: FourPeopleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FourPeopleTableViewCell.identifier)
        tableView.register(UINib(nibName: FiveMoreTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FiveMoreTableViewCell.identifier)
    }
}

// MARK: SearchBar Delegate
extension ViewController: UISearchBarDelegate {
    func configSearchBar() {
        let userInterfaceStyle = self.traitCollection.userInterfaceStyle
        let borderColor = userInterfaceStyle == .dark ? UIColor.black.cgColor : UIColor.white.cgColor
        searchBar.delegate = self
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "친구 이름을 검색해보세요",
            attributes: [.foregroundColor : UIColor.secondaryLabel])
        searchBar.layer.borderColor = borderColor
        searchBar.layer.borderWidth = 1
    }
}

