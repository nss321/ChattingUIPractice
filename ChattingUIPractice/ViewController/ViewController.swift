//
//  ViewController.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/11/25.
//

import UIKit

class ViewController: UIViewController {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SingleChattingListTableViewCell.identifier, for: indexPath) as! SingleChattingListTableViewCell
        
        cell.config(row: row)
        cell.profileImage.layer.cornerRadius = (cellHeight - 24) / 2
        
        return cell
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

