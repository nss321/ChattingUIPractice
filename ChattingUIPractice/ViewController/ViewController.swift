//
//  ViewController.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/11/25.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController, ViewPresenstableProtocol {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    lazy var dim = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.3)
        $0.isHidden = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    let chattingList = mockChatList
    
    let cellHeight: CGFloat = 80
    
    var searchingResult: [ChatRoom] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configSearchBar()
        setConstraints()
    }
    
    func searchingKeyword(targetList list: [ChatRoom], forWhat item: String) {
        searchingResult.removeAll()
        print("current: \(item)")
        chattingList.forEach {
            if "\($0.chatroomImage)".lowercased().contains(item.lowercased()) {
                print("matched keyword: \(item)")
                searchingResult.append($0)
            }
        }
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setConstraints() {
        view.addSubview(dim)
        dim.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func toggleDimWhenKeyboardShowing() {
        dim.isHidden.toggle()
    }
}

// MARK: TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchBar.searchTextField.isEditing ? searchingResult.count : mockChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var row = chattingList[indexPath.row]
        
        
        // MARK: 추상화,,를하든 뭘하든 리팩토링 필요해보임.
        if searchBar.searchTextField.isEditing {
            row = searchingResult[indexPath.row]
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
        } else {
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
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ChattingViewController") as! ChattingViewController
        vc.chatRoom = searchBar.searchTextField.isEditing ? searchingResult[indexPath.row] : chattingList[indexPath.row]
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchingResult = mockChatList
        } else {
            searchingKeyword(targetList: mockChatList, forWhat: searchText)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        toggleDimWhenKeyboardShowing()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        toggleDimWhenKeyboardShowing()
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        view.endEditing(true)
        
        print("return key")
        
        guard let currentText = searchBar.searchTextField.text else {
            print("failed to unwrapping searchbar text")
            return
        }
        
        print(currentText)
        if currentText.isEmpty {
            showSimpleAlert(title: "공백 입력!", message: "검색창이 공백입니당다리") { _ in
                self.resetSearchBarState()
            }
            resetSearchBarState()
            
        } else if searchingResult.isEmpty {
            showSimpleAlert(title: "검색 결과 없음", message: "찾으시는 결과를 찾을 수 없어요 ;<") { _ in
                self.resetSearchBarState()
            }
            resetSearchBarState()
        }
        
    }
    
    func resetSearchBarState() {
        view.endEditing(true)
        searchBar.searchTextField.text = ""
        tableView.reloadData()
    }
    

}

