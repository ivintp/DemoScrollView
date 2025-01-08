//
//  ScrollViewController.swift
//  DemoScrollView
//
//  Created by AppStation on 02/01/25.
//

import UIKit

class ScrollViewController: UIViewController{
    
    @IBOutlet var mainView: UIView!
    var bottomView = UIView()
    var topView = UIView()
    var rightButton = UIButton(frame: CGRect(x: 250, y: 10, width: 50, height: 50))
    var leftButton = UIButton(frame: CGRect(x: 70, y: 10, width: 50, height: 50))
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:90,y: 670, width:200, height:50))
    let scrollView = UIScrollView(frame: CGRect(x:0, y:90, width:393,height: 690))
    var colors:[UIColor] = [UIColor.red, UIColor.white, UIColor.green, UIColor.yellow, UIColor.brown]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    
    var index = 0
    var totalItems = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constarinsTagrget()
        scrollPages()
        selector()
        configurePageControl()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        self.mainView.addSubview(pageControl)
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * CGFloat(totalItems),height: self.scrollView.frame.size.height)
        rightButton.setImage(UIImage(named: "sideButtonRight"), for: .normal)
        leftButton.setImage(UIImage(named: "sideButton"), for: .normal)
    }
    func scrollPages(){
        for index in 0..<totalItems {
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            let subView = UIView(frame: frame)
            subView.backgroundColor = colors[index % colors.count]
            self.scrollView.addSubview(subView)
        }
    }
    func constarinsTagrget(){
        //        MARK: - Bottom view constrains
        mainView.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        //         MARK: - TOP VIEW CONSTRAINS
        mainView.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: self.mainView.topAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        //           MARK: - ScrollView Constrains
        mainView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topView.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor).isActive = true
    }
    func selector(){
        self.leftButton.addTarget(self, action: #selector(buttonLeftConfiguration), for: .touchUpInside)
        self.rightButton.addTarget(self, action: #selector(buttonRightConfiguration), for: .touchUpInside)
        self.pageControl.addTarget(self, action: #selector(pageControlAction), for: .valueChanged)
    }
    @objc func pageControlAction(_ sender: UIPageControl){
        index = sender.currentPage
        updateButton(index)
    }
    @objc func buttonLeftConfiguration(){
        index -= 1
        scrollView.contentOffset.x = self.view.bounds.width*CGFloat(index)
        updateButton(index)
        self.bottomView.addSubview(leftButton)
    }
    @objc func buttonRightConfiguration(){
        index += 1
        updateButton(index)
        self.bottomView.addSubview(rightButton)
    }
    func configurePageControl() {
        buttonRightConfiguration()
        buttonLeftConfiguration()
        bottomView.layer.backgroundColor = UIColor.gray.cgColor
        topView.layer.backgroundColor = UIColor.gray.cgColor
        self.pageControl.numberOfPages = totalItems
        self.pageControl.currentPage = index
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.red
        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
    }
   
}
extension ScrollViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        index = Int((scrollView.contentOffset.x / scrollView.frame.size.width).rounded())
       updateButton(index)
        }
    func updateButton(_ index: Int){
        pageControl.currentPage = index
        scrollView.contentOffset.x = self.view.bounds.width*CGFloat(index)
        rightButton.isEnabled = index != totalItems-1
        leftButton.isEnabled = index != 0
    }
}
