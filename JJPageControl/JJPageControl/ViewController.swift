//
//  ViewController.swift
//  JJPageControl
//
//  https://github.com/zxhkit/JJPageControl
//  Created by xuanhe on 2022/9/1.
//

import UIKit

class ViewController: UIViewController {

    
    
    var scrollView1 = UIScrollView()
    var scrollView2 = UIScrollView()
    var scrollView3 = UIScrollView()
    var scrollView4 = UIScrollView()

    
    var pageControl1 = JJPageControl()
    var pageControl2 = JJPageControl()
    var pageControl3 = JJPageControl()
    var pageControl4 = JJPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView1 = UIScrollView(frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: 100))
        scrollView1.contentSize = CGSize(width: UIScreen.main.bounds.size.width*7, height: 100)
        scrollView1.delegate = self
        scrollView1.tag = 10001
        scrollView1.isPagingEnabled = true
        for index in 0..<7 {
            scrollView1.addSubview(createImgView(index: index))
        }
        view.addSubview(scrollView1)
        
        
        scrollView2 = UIScrollView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.size.width, height: 100))
        scrollView2.contentSize = CGSize(width: UIScreen.main.bounds.size.width*7, height: 100)
        scrollView2.delegate = self
        scrollView2.tag = 10002
        scrollView2.isPagingEnabled = true
        for index in 0..<7 {
            scrollView2.addSubview(createImgView(index: index))
        }
        view.addSubview(scrollView2)
        
        scrollView3 = UIScrollView(frame: CGRect(x: 0, y: 340, width: UIScreen.main.bounds.size.width, height: 100))
        scrollView3.contentSize = CGSize(width: UIScreen.main.bounds.size.width*7, height: 100)
        scrollView3.delegate = self
        scrollView3.tag = 10003
        scrollView3.isPagingEnabled = true
        for index in 0..<7 {
            scrollView3.addSubview(createImgView(index: index))
        }
        view.addSubview(scrollView3)
        
        
        scrollView4 = UIScrollView(frame: CGRect(x: 0, y: 480, width: UIScreen.main.bounds.size.width, height: 100))
        scrollView4.contentSize = CGSize(width: UIScreen.main.bounds.size.width*7, height: 100)
        scrollView4.delegate = self
        scrollView4.tag = 10004
        scrollView4.isPagingEnabled = true
        for index in 0..<7 {
            scrollView4.addSubview(createImgView(index: index))
        }
        view.addSubview(scrollView4)
        
        
        
        pageControl1.frame = CGRect(x: 0, y: 160, width: UIScreen.main.bounds.size.width, height: 30)
        pageControl1.numberOfPages = 7
        pageControl1.delegate = self
        pageControl1.otherPointSize = CGSize(width: 12, height: 12)
        pageControl1.currentPointSize = CGSize(width: 12, height: 12)
        pageControl1.currentLayerBorderColor = UIColor.red
        pageControl1.otherLayerBorderColor = UIColor.blue
        pageControl1.currentColor = .clear
        pageControl1.otherColor = .clear
        pageControl1.currentLayerBorderWidth = 2
        pageControl1.otherLayerBorderWidth = 2
        pageControl1.tag = 901
        pageControl1.pointCornerRadius = 6;

        view.addSubview(pageControl1)
        
        pageControl2.frame = CGRect(x: 0, y: 300, width: UIScreen.main.bounds.size.width, height: 30)
        pageControl2.currentColor = UIColor(red: 98/255.0, green: 152/255.0, blue: 19/255.0, alpha: 1)
        pageControl2.otherColor = UIColor(red: 14/255.0, green: 65/255.0, blue: 190/255.0, alpha: 1)
        pageControl2.pointCornerRadius = 2
        pageControl2.currentPointSize = CGSize(width: 6, height: 12)
        pageControl2.otherPointSize = CGSize(width: 10, height: 6)
        pageControl2.pageAliment = .Center
        pageControl2.numberOfPages = 7
        pageControl2.delegate = self
        pageControl2.isUserInteractionEnabled = true
        pageControl2.controlSpacing = 3
        pageControl2.leftAndRightSpacing = 10
        pageControl2.isCanClickPoint = true

        pageControl2.tag = 902
        view.addSubview(pageControl2)
        
        
        pageControl3.frame = CGRect(x: 0, y: 440, width: UIScreen.main.bounds.size.width, height: 30)
        pageControl3.numberOfPages = 7
        pageControl3.delegate = self
        pageControl3.currentPointSize = CGSize(width: 18, height: 18)
        pageControl3.otherPointSize = CGSize(width: 18, height: 18)
        pageControl3.controlSpacing = 12
        pageControl3.currentBkImage = UIImage(named: "image1")
        pageControl3.otherBkImage = UIImage(named: "image2")
        pageControl3.isUserInteractionEnabled = true
        pageControl3.isCanClickPoint = true

        pageControl3.tag = 903
        view.addSubview(pageControl3)
        
        pageControl4.frame = CGRect(x: 0, y: 580, width: UIScreen.main.bounds.size.width, height: 30)
        pageControl4.numberOfPages = 7
        pageControl4.delegate = self
        pageControl4.otherPointSize = CGSize(width: 15, height: 4)
        pageControl4.currentPointSize = CGSize(width: 4, height: 4)
        pageControl4.pointCornerRadius = 1
        pageControl4.tag = 904
        pageControl4.isUserInteractionEnabled = true
        pageControl4.isCanClickPoint = true

        pageControl4.clickPointClosure = { num in
            print("clickPointClosure: ????????????\(num)???")
        }
        
        view.addSubview(pageControl4)        
        
    }


}



private func createImgView(index:Int) -> UIView {
    let view = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width * CGFloat(index), y: 0, width: UIScreen.main.bounds.size.width, height: 100))
    view.layer.borderWidth = 1
    return view
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / UIScreen.main.bounds.size.width)
        
        let tag = scrollView.tag
        
        switch tag {
        case 10001:
            pageControl1.currentPage = currentIndex
        case 10002:
            pageControl2.currentPage = currentIndex
        case 10003:
            pageControl3.currentPage = currentIndex
        case 10004:
            pageControl4.currentPage = currentIndex
        default:
            return
        }
    }
}


extension ViewController:JJPageControlDelegate{
    func jj_pageControlClick(pageControl: JJPageControl, index: Int) {
        
        print("??????:????????????\(index)???")
        
    }
    
}
