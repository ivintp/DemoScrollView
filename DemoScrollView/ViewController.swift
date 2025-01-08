//
//  ViewController.swift
//  DemoScrollView
//
//  Created by AppStation on 01/01/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    
    var color: [UIColor] = [UIColor.red, UIColor.green, UIColor.blue, UIColor.black, UIColor.yellow]
    var index = 0
    var totalNumbers = 10
   
    override func viewDidLoad() {
        super.viewDidLoad()
        cellCreation()
        scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        pageController.currentPage = index
        pageController.numberOfPages = totalNumbers
        width.constant = scrollView.bounds.width*CGFloat(totalNumbers)
    }
       
    @IBAction func pageControllerAction(_ sender: UIPageControl) {
        index = sender.currentPage
        updateButtons(index)
    }
    @IBAction func leftButtonMove(_ sender: Any) {
        index -= 1
        updateButtons(index)
    }
    
    @IBAction func rightButtonMove(_ sender: Any) {
        index += 1
        updateButtons(index)
    }
    
    func cellCreation(){
        for index in 0..<totalNumbers{
            var frame: CGRect = self.scrollView.bounds
            frame.origin.x = self.scrollView.bounds.width*CGFloat(index)
            let view = UIView(frame: frame)
            view.backgroundColor = color[index % color.count]
            scrollView.addSubview(view)
        }
    }
}
extension ViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        index = Int((scrollView.contentOffset.x / scrollView.frame.size.width).rounded())
        updateButtons(index)
    }
    
    func updateButtons(_ index:Int){
        pageController.currentPage = index
        scrollView.contentOffset.x = self.view.bounds.width*CGFloat(index)
        leftButton.isEnabled = index != 0
        rightButton.isEnabled = index != totalNumbers-1

    }
}
