# JJPageControl
一个Swift版好用的自定义PageControl

将项目工程中的JJPageControl拖拽到你的项目中.

```
    var pageControl2 = JJPageControl()
    pageControl2.frame = CGRect(x: 0, y: 300, width: UIScreen.main.bounds.size.width, height: 30)
    pageControl2.currentColor = UIColor.red
    pageControl2.otherColor = UIColor.blue
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
```

实现代理方法:
```
extension ViewController:JJPageControlDelegate{
    func jj_pageControlClick(pageControl: JJPageControl, index: Int) {
        
    print("带击了第\(index)个")
        
    }
    
}
```

修改当前选中
```

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / UIScreen.main.bounds.size.width)
        let tag = scrollView.tag        
        switch tag {
        case 10002:
            pageControl2.currentPage = currentIndex
        default:
            return
        }
    }
}

```
