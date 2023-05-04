//
//  SecondViewController.swift
//  BookmarkUiKit
//
//  Created by Dimash Nsanbaev on 5/3/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    var items: [(name: String, link: String)] = []
    
    lazy var table:UITableView = {
        let tab = UITableView()
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tab.isHidden = true
        return tab
    }()
    
    lazy var centerLabel:UILabel = {
        let label = UILabel()
        label.text = "Save your first bookmark"
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    
    lazy var button:UIButton = {
        let button = UIButton()
        button.setTitle("Add bookmark", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(openAlert), for: .touchUpInside)
        return button
    }()
    @objc func openAlert(){
        
        
        //
        let alertController = UIAlertController(title: "Change", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Bookmark title"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Bookmark link"
            textField.keyboardType = .numberPad
        }
        
        // Create the "Add" action
        //        let addAction = UIAlertAction(title: "Save", style: .default) { [self] (_) in
        //            // Get the text fields
        //            guard let nameTextField = alertController.textFields?[0],
        //                  let quantityTextField = alertController.textFields?[1] else {
        //                return
        //            }
        //
        //            // Create a new item and add it to the array
        //            let newItem = "\(nameTextField.text ?? "") (\(quantityTextField.text ?? ""))"
        //            self.items.append(newItem)
        //
        //            // Reload the table view
        //            self.table.reloadData()
        //            if !items.isEmpty{
        //                centerLabel.isHidden = true
        //                table.isHidden = false
        //                self.title = "List"
        //
        //            }
        //        }
        
        let addAction = UIAlertAction(title: "Save", style: .default) { [self] _ in
            guard let name = alertController.textFields?[0].text,
                  let link = alertController.textFields?[1].text else {
                return
            }
            
            self.items.append((name: name, link: link))
            self.table.reloadData()
            if !items.isEmpty{
                centerLabel.isHidden = true
                table.isHidden = false
                self.title = "List"
                
            }
        }
        
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Bookmark App"
        [centerLabel,button,table].forEach{
            view.addSubview($0)
        }
        table.delegate = self
        table.dataSource = self
        setupConstraints()
        
    }
    
    
    private func setupConstraints(){
        table.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(button.snp.top)
        }
        
        centerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(358)
            make.height.equalTo(92)
        }
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.width.equalTo(358)
            make.height.equalTo(58)
            make.centerX.equalToSuperview()
        }
        
        
    }
}

extension SecondViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        
        // Set the left text of the cell to the item name
        cell.textLabel?.text = item.name
        
        // Add a button to the right side of the cell with an icon that opens the item link
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"share"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(openLink(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        cell.accessoryView = button
        
        return cell
    }
    @objc func openLink(_ sender: UIButton) {
        guard let cell = sender.superview as? UITableViewCell, let indexPath = table.indexPath(for: cell) else { return }
        let item = items[indexPath.row]
        guard let url = URL(string: item.link) else { return }
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(items[indexPath.row])")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the item from the data source array
            items.remove(at: indexPath.row)
            
            // Update the table view to reflect the change
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
