//
//  BLogView.swift
//  BLoger
//
//  Created by lin bo on 2019/3/21.
//  Copyright © 2019 lin bo. All rights reserved.
//

import UIKit
import SnapKit

class BLogView: UIView {

    fileprivate var timer: Timer? // 刷新定时器
    fileprivate var autoShowLog: Bool = false // 是否自动刷新日志（状态）
    fileprivate var isMoving: Bool = false // 页面正在拖动

    fileprivate var relushTime: UInt = 0 // 10
    fileprivate var relushNowTime: UInt = 0   // 0/1/2/3...
    
    fileprivate let cancelBtn: UIButton = {
        
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("❌", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate let midView: UIView = {
        
        let lb = UILabel()
        lb.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        lb.textColor = .white
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textAlignment = .center
        lb.text = "Drag me"
        
        let view = UIView()
        view .addSubview(lb)
        lb.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return view
    }()
    
    fileprivate let rightBtn: UIButton = {
        
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Auto", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(RefreshAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate let textView: UITextView = {
        
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textColor = .white
        tv.font = UIFont.systemFont(ofSize: 10)
        tv.isEditable = false
        return tv
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        textView.layoutManager.allowsNonContiguousLayout = false
        
        addSubview(textView)
        addSubview(cancelBtn)
        addSubview(midView)
        addSubview(rightBtn)
        
        textView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(2)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            } else {
                make.top.equalToSuperview().offset(10)
            }
            make.width.height.equalTo(30)
        }
        
        midView.snp.makeConstraints { (make) in
            make.left.equalTo(cancelBtn.snp.right).offset(10)
            make.height.equalTo(cancelBtn)
            make.top.equalTo(cancelBtn)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.left.equalTo(midView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(midView)
            make.height.equalTo(midView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    /// 显示到页面，这是一个单例，若不指定View，默认显示到Window
    ///
    /// - Parameter inView: 指定View
    func show(inView: UIView? = nil) {
        
        var tmpView: UIView? = inView
        if inView == nil {
            tmpView = UIApplication.shared.keyWindow
        }
        
        guard let disView = tmpView else {
            return
        }
        
        let maxHeight = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) - 40
        
        self.frame = CGRect(x: 0, y: 0, width: min(maxHeight * 0.8, disView.bounds.size.width - 20), height: min(maxHeight, disView.bounds.size.height - 20))
        self.center = disView.center
        disView.addSubview(self)
        
        // 不延迟 会有卡顿
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.start()
        }
    }
    
    /// 隐藏Log View
    func dismiss() {
        
        self.stop()
        self.removeFromSuperview()
    }
    
    @objc fileprivate func cancelAction(_ sender: UIButton) {
        
        self.removeFromSuperview()
        
        stop()
    }
    
    @objc fileprivate func RefreshAction(_ sender: UIButton) {
        
        if autoShowLog {
            stop()
            sender.setTitle("Auto", for: .normal)
            
        }else {
            start()
            sender.setTitle("Stop", for: .normal)
        }
    }
    
    fileprivate func start(_ interval: TimeInterval = 10.0) {
        
        stop()
        
        relushTime = UInt(interval)
        relushNowTime = 0
        
        autoShowLog = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(repet), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    fileprivate func stop() {
        
        autoShowLog = false
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc fileprivate func repet() {
        
        if isMoving {
            return
        }
        
        if relushTime > 0 {
            
            rightBtn.setTitle("\(relushTime - relushNowTime % relushTime)s", for: .normal)
            relushNowTime = relushNowTime + 1
            if (relushNowTime % relushTime) != 1 {
                
                return
            }
        }
        
        guard let str = BLoger.shared.getNewDoc() else {
            return
        }
        
        textView.text = str
        textView.scrollRangeToVisible(NSRange.init(location: textView.text.lengthOfBytes(using: .utf8), length: 1))
    }
    
    func adapterScreen() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            var rect = self.frame
            if let superview = self.superview {
                rect.origin.x = min(rect.origin.x, superview.bounds.size.width - 100)
                rect.origin.y = min(rect.origin.y, superview.bounds.size.height - 60)
            }
            
            rect.origin.x = max(rect.origin.x, -rect.size.width + 100)
            rect.origin.y = max(rect.origin.y, 20)
            self.frame = rect
        }
    }
}

extension BLogView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取手指
        let touch = (touches as NSSet).anyObject() as! UITouch
        let nowLocation = touch.location(in: self)
        let preLocation = touch.previousLocation(in: self)
        
        //获取两个手指的偏移量
        let offsetX = nowLocation.x - preLocation.x
        let offsetY = nowLocation.y - preLocation.y
        
        var center = self.center
        center.x += offsetX
        center.y += offsetY
        
        self.center = center
        
        isMoving = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        adapterScreen()
        
        isMoving = false
    }
}
