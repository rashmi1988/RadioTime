//
//  AdViewController.swift
//  RadioTime
//
//  Created by Rashmi on 16/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

import UIKit
import SnapKit

protocol AdProtocol: AnyObject {
    func playSongAfterAd()
}

class AdViewController: UIViewController {
    
    private let lblTimer = UILabel()
    private let lblMessage = UILabel()
    private let btnPremiumSubscription = UIButton()
    private var timerCount = 10
    weak var delegate: AdProtocol?
    //private var timer = Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        setupView()
    }
    
    func setupView() {
        lblTimer.text = "The song will play after 10 seconds"
        lblTimer.font = UIFont.boldSystemFont(ofSize: 40)
        lblTimer.numberOfLines = 0
        self.title = "Go premium"
        lblTimer.textColor = .white
        
        lblMessage.text = "Hate to wait? Go premium to remove ads"
        lblMessage.font = UIFont.boldSystemFont(ofSize: 30)
        lblMessage.textColor = .white
        lblMessage.numberOfLines = 0
        
        btnPremiumSubscription.setTitle("Subscribe", for: .normal)
        btnPremiumSubscription.setTitleColor(.white, for: .normal)
        btnPremiumSubscription.addTarget(self, action: #selector(AdViewController.onTapBtnSubscription), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [lblTimer, lblMessage, btnPremiumSubscription])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.left.equalTo(view).offset(20)
            maker.right.equalTo(view).offset(-20)
            maker.top.equalTo(view).offset(100)
            maker.bottom.equalTo(view).offset(-100)
        }
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AdViewController.timerAction), userInfo: nil, repeats: true)
    }

    @objc func onTapBtnSubscription () {
        let alertController = UIAlertController(title: "Under development", message: "Feature coming soon, stay tuned!", preferredStyle: UIAlertController.Style.alert)
        let alertActionOK = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (action) in
            self.goBack()
        }
        alertController.addAction(alertActionOK)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func timerAction () {
        timerCount-=1
        if timerCount == 0 {
            goBack()
            return
        }
        lblTimer.text = "The song will play after \(timerCount) seconds"
    }
    
    func goBack() {
        delegate?.playSongAfterAd()
        self.dismiss(animated: true, completion: nil)
    }
}
