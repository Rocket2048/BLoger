//
//  ViewController+ShankExt.swift
//  BLoger
//
//  Created by lin bo on 2019/3/22.
//  Copyright © 2019 lin bo. All rights reserved.
//

import UIKit

extension UIViewController {
        
    //开始摇晃
    override open func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
    }
    
    //摇晃结束
    override open func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {

        #if RELEASE

        #else
        
        if BLoger.shared.shankShow {
            if #available(iOS 10.0, *) {
                let imp = UIImpactFeedbackGenerator.init(style: .medium)
                imp.impactOccurred()
                
            } else {
                // Fallback on earlier versions
            }
            BLoger.shared.showLogView()
        }
        
        #endif
    }
    
    //摇晃被意外终止
    override open func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        
    }

}
