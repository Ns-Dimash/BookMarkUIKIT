//
//  ViewController.swift
//  BookmarkUiKit
//
//  Created by Dimash Nsanbaev on 5/2/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var bgImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var label:UILabel = {
        let label = UILabel()
        label.text = "Save all interesting links in one app"
        label.textColor = .white
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    
    lazy var button:UIButton = {
        let button = UIButton()
        button.setTitle("Let’s start collecting", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(secondPage), for: .touchUpInside)
        return button
    }()
    
    @objc func secondPage(){
        let SecondVC = SecondViewController()
        navigationController?.pushViewController(SecondVC, animated: false)
    }
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for remove nav bar back with arrow
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        
        [bgImage,label,button].forEach {
            view.addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints(){
        bgImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(bgImage.snp.bottom)
            make.width.equalTo(358)
            make.height.equalTo(92)
            make.leading.equalToSuperview().inset(20)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.width.equalTo(358)
            make.height.equalTo(58)
            make.centerX.equalToSuperview()
        }
        
    }
}

