//
//  DemoScrollViewController.swift
//  DemoScrollView
//
//  Created by AppStation on 07/01/25.
//

import UIKit

class DemoScrollViewController: UIViewController {


    @IBOutlet weak var mainView: UIView!
    
    let topView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstarins()
    
    }

    func addConstarins(){
//      MARK: - Top View
        mainView.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: self.mainView.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        topView.backgroundColor = .gray
        
    }
}
