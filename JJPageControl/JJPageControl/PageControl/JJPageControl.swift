//
//  JJPageControl.swift
//  JJPageControl
//  
//  https://github.com/zxhkit/JJPageControl
//  Created by xuanhe on 2022/9/1.
//

import UIKit

enum JJPageControlAliment {
    case Center
    case Left
    case Right
}

protocol JJPageControlDelegate {
    func jj_pageControlClick(pageControl: JJPageControl, index: Int)
}

class JJPageControl: UIControl {
    
    /// 闭包点击事件
    var clickPointClosure: ((_ num : Int) -> Void)?

    /// 当前点的大小
    var currentPointSize: CGSize = CGSize(width: 6, height: 6) {
        didSet{
            assert((currentPointSize.width >= 1 && currentPointSize.height >= 1), "Parameter value is not valid. currentPointSize must be greater than 1.")
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    /// 其他点的大小
    var otherPointSize: CGSize = CGSize(width: 6, height: 6) {
        didSet{
            assert((otherPointSize.width >= 1 && otherPointSize.height >= 1), "Parameter value is not valid. otherPointSize must be greater than 1.")
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    /// 点-切圆角
    var pointCornerRadius:CGFloat = 3 {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    /// 位置
    var pageAliment: JJPageControlAliment = .Center {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    /// 分页数量
    var numberOfPages: Int = 0 {
        didSet{
            if oldValue != numberOfPages {
                createPointView()
            }
        }
    }
    
    /// 当前点所在下标
    var currentPage: Int = 0 {
        didSet{
            if currentPage >= 0 {
                exchangePointView(oldValue, currentPage)
            }else{
                currentPage = 0
            }
        }
    }
    ///点的间距
    var controlSpacing: CGFloat = 8 {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    ///左右间距
    var leftAndRightSpacing: CGFloat = 10 {
        didSet{
            if leftAndRightSpacing < 0 {
                leftAndRightSpacing = 0
            }else{
                if numberOfPages > 0 {
                    createPointView()
                }
            }
        }
    }
    /// 其他点未选中颜色
    var otherColor: UIColor = .gray {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    /// 当前点颜色
    var currentColor: UIColor = .orange {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    /// 其他点背景图片
    var otherBkImage: UIImage? {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    /// 当前点背景图片
    var currentBkImage: UIImage? {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    ///当前选中点的layer宽
    var currentLayerBorderWidth: CGFloat = 1 {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    
    ///其他点的layer宽
    var otherLayerBorderWidth: CGFloat = 1 {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    
    ///当前选中点的layer颜色
    var currentLayerBorderColor: UIColor? {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    ///其他选中点的layer颜色
    var otherLayerBorderColor: UIColor? {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    
    
    /// 当只有一个点的时候是否隐藏
    var isHidesForSinglePage = false {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    /// 是否可以点击 默认不可以点击
    var isCanClickPoint = false {
        didSet{
            if numberOfPages > 0 {
                createPointView()
            }
        }
    }
    
    /// 重写设置frame
    override var frame:CGRect {
        didSet{
            let mainWidth = (CGFloat(numberOfPages) - 1) * otherPointSize.width + (CGFloat(numberOfPages) - 1) * controlSpacing + currentPointSize.width + leftAndRightSpacing * 2

            if frame.width < mainWidth {
                frame.size.width = mainWidth
            }
            let max_height = max(otherPointSize.height, currentPointSize.height)
            if frame.height < max_height {
                frame.size.height = max_height
            }
            createPointView()
        }
    }
    
    /// 协议代理
    var delegate:JJPageControlDelegate?
        
    private var dots = [UIImageView]()
    
    /// 创建视图
    private func createPointView() {
        /// 先清除视图
        clearView()
        
        if numberOfPages <= 0 {
            return
        }
        
        if isHidesForSinglePage == true ,numberOfPages == 1{
            return
        }
        //居中控件
        var startX:CGFloat = 0
        var startY_current:CGFloat = 0
        var startY_other:CGFloat = 0

        
        let mainWidth = (CGFloat(numberOfPages) - 1) * otherPointSize.width + (CGFloat(numberOfPages) - 1) * controlSpacing + currentPointSize.width + leftAndRightSpacing * 2 + 1
        if frame.width < mainWidth {
            frame.size.width = mainWidth
        }else{
            if pageAliment == .Left {
                startX = leftAndRightSpacing
            } else if pageAliment == .Center {
                startX = (self.frame.size.width - mainWidth)/2.0
            } else {
                startX = frame.width - mainWidth
            }
        }
        
        let max_height = max(otherPointSize.height, currentPointSize.height)
        if frame.height < max_height {
            frame.size.height = max_height
            startY_current = max_height - currentPointSize.height
            startY_other = max_height - otherPointSize.height

        } else {
            startY_current = (frame.height - max_height)/2.0 + (max_height - currentPointSize.height)
            startY_other = (frame.height - max_height)/2.0 + (max_height - otherPointSize.height)
        }
        
        for page in 0..<numberOfPages {
            if page == currentPage {
                let currentPoint = UIImageView(frame: CGRect(x: startX, y: startY_current, width: currentPointSize.width, height: currentPointSize.height))
                currentPoint.layer.masksToBounds = true
                currentPoint.layer.cornerRadius = pointCornerRadius
                currentPoint.tag = 1000 + page
                currentPoint.backgroundColor = currentColor
                currentPoint.isUserInteractionEnabled = true
                currentPoint.image = currentBkImage
                
                if self.currentLayerBorderColor != nil {
                    currentPoint.layer.borderColor = self.currentLayerBorderColor?.cgColor
                    currentPoint.layer.borderWidth = self.currentLayerBorderWidth
                }else{
                    currentPoint.layer.borderWidth = 0
                }
                
                if isCanClickPoint == true {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickAction(_:)))
                    currentPoint.addGestureRecognizer(tapGesture)
                }
                
                addSubview(currentPoint)
                
                startX = currentPoint.frame.maxX + controlSpacing
                if let _ = currentBkImage {
                    currentPoint.backgroundColor = .clear
                }
                dots.append(currentPoint)
            }else{
                let otherPoint = UIImageView(frame: CGRect(x: startX, y: startY_other, width: otherPointSize.width, height: otherPointSize.height))
                otherPoint.layer.masksToBounds = true
                otherPoint.layer.cornerRadius = pointCornerRadius
                otherPoint.tag = 1000 + page
                otherPoint.backgroundColor = otherColor
                otherPoint.isUserInteractionEnabled = true
                otherPoint.image = otherBkImage
                
                if self.otherLayerBorderColor != nil {
                    otherPoint.layer.borderColor = self.otherLayerBorderColor?.cgColor
                    otherPoint.layer.borderWidth = self.otherLayerBorderWidth
                }else{
                    otherPoint.layer.borderWidth = 0
                }
                
                if isCanClickPoint == true {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickAction(_:)))
                    otherPoint.addGestureRecognizer(tapGesture)
                }
                addSubview(otherPoint)
                
                startX = otherPoint.frame.maxX + controlSpacing
                
                if let _ = otherBkImage {
                    otherPoint.backgroundColor = .clear
                }
                dots.append(otherPoint)
            }
        }
    }
    
    
    @objc private func clickAction(_ recognizer: UITapGestureRecognizer) {
        
        if let tag = recognizer.view?.tag {
            let index = tag - 1000
            if index >= 0 {
                currentPage = index
                delegate?.jj_pageControlClick(pageControl: self, index: index)
                if let closure = self.clickPointClosure {
                    closure(index)
                }
            }
        }
    }
    
    
    
    func clearView() {
        // subviews.forEach { subView in
        //     subView.removeFromSuperview()
        // }
        
        subviews.forEach { $0.removeFromSuperview()}
        dots.removeAll()
    }
    
    func exchangePointView(_ oldPage: Int, _ newPage: Int) {
        if oldPage == newPage {
            return
        }
        if oldPage > dots.count {
            return
        }
        if newPage > dots.count {
            return
        }
        
        
        let oldDot = dots[oldPage]
        let oldFrame = oldDot.frame
        
        let newDot = dots[newPage]
        let newFrame = newDot.frame
        
        newDot.image = currentBkImage
        if let _ = currentBkImage {
            newDot.backgroundColor = .clear
        }else{
            newDot.backgroundColor = currentColor
        }
        
        oldDot.image = otherBkImage
        if let _ = otherBkImage {
            oldDot.backgroundColor = .clear
        }else{
            oldDot.backgroundColor = otherColor
        }
        
        if self.currentLayerBorderColor != nil {
            newDot.layer.borderColor = self.currentLayerBorderColor?.cgColor
            newDot.layer.borderWidth = self.currentLayerBorderWidth
        }else{
            newDot.layer.borderWidth = 0
        }
        
        if self.otherLayerBorderColor != nil {
            oldDot.layer.borderColor = self.otherLayerBorderColor?.cgColor
            oldDot.layer.borderWidth = self.otherLayerBorderWidth
        }else{
            oldDot.layer.borderWidth = 0
        }
        
        var oldMinx = oldFrame.minX
        var newMinx = newFrame.minX
        
        UIView.animate(withDuration: 0.25) {
            if newPage < oldPage {
                oldMinx = oldMinx + (self.currentPointSize.width - self.otherPointSize.width)
            }
            oldDot.frame = CGRect(x: oldMinx, y: newFrame.minY, width: self.otherPointSize.width, height: self.otherPointSize.height)
            
            if newPage > oldPage {
                newMinx = newMinx - (self.currentPointSize.width - self.otherPointSize.width)
            }
            newDot.frame = CGRect(x: newMinx, y: oldFrame.minY, width: self.currentPointSize.width, height: self.currentPointSize.height)
            
            
            if newPage - oldPage > 1 {  //往右滑动
                for index in (oldPage+1)..<newPage {
                    if index < self.dots.count {
                        let point = self.dots[index]
                        point.frame = CGRect(x: point.frame.minX - (self.currentPointSize.width - self.otherPointSize.width),
                                             y: point.frame.minY,
                                             width: self.otherPointSize.width,
                                             height: self.otherPointSize.height)
                    }else{
                        return
                    }
                }
            }
            
            if newPage - oldPage < -1 {  //往左滑动
                for index in (newPage+1)..<oldPage {
                    if index < self.dots.count {
                        let point = self.dots[index]
                        point.frame = CGRect(x: point.frame.minX + (self.currentPointSize.width - self.otherPointSize.width),
                                             y: point.frame.minY,
                                             width: self.otherPointSize.width,
                                             height: self.otherPointSize.height)
                    }else{
                        return
                    }
                }
            }
        } completion: { finshed in
            if finshed == false {  //执行代码和执行过程中代码一样
                if newPage < oldPage {
                    oldMinx = oldMinx + (self.currentPointSize.width - self.otherPointSize.width)
                }
                oldDot.frame = CGRect(x: oldMinx, y: newFrame.minY, width: self.otherPointSize.width, height: self.otherPointSize.height)
                
                if newPage > oldPage {
                    newMinx = newMinx - (self.currentPointSize.width - self.otherPointSize.width)
                }
                newDot.frame = CGRect(x: newMinx, y: oldFrame.minY, width: self.currentPointSize.width, height: self.currentPointSize.height)
                
                
                if newPage - oldPage > 1 {  //往右滑动
                    for index in (oldPage+1)..<newPage {
                        if index < self.dots.count {
                            let point = self.dots[index]
                            point.frame = CGRect(x: point.frame.minX - (self.currentPointSize.width - self.otherPointSize.width),
                                                 y: point.frame.minY,
                                                 width: self.otherPointSize.width,
                                                 height: self.otherPointSize.height)
                        }else{
                            return
                        }
                    }
                }
                
                if newPage - oldPage < -1 {  //往左滑动
                    for index in (newPage+1)..<oldPage {
                        if index < self.dots.count {
                            let point = self.dots[index]
                            point.frame = CGRect(x: point.frame.minX + (self.currentPointSize.width - self.otherPointSize.width),
                                                 y: point.frame.minY,
                                                 width: self.otherPointSize.width,
                                                 height: self.otherPointSize.height)
                        }else{
                            return
                        }
                    }
                }
            }
        }
    }
}

