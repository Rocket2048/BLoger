//
//  ViewController.swift
//  BLoger
//
//  Created by ok@linbok.com on 03/26/2019.
//  Copyright (c) 2019 ok@linbok.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sw: UISwitch!
    @IBOutlet weak var sw2: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "BLoger Demo \(String(describing: navigationController?.viewControllers.count))"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        sw.isOn = BLoger.shared.shankShow
        sw2.isOn = BLogAutoTask.shared.started
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
   
    }

    @IBAction func btnAction(_ sender: Any) {
        
        BLoger.shared.showLogView()
        BLog("点击弹出Log窗口")

    }
    
    @IBAction func btnAction1(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        navigationController?.pushViewController(vc, animated: true)

        BLog("点击进入下一个页面")
    }
    
    @IBAction func swAction(_ sender: UISwitch) {
        
        if sender.tag == 1 {
            
            BLog(sender.isOn ? "摇一摇开" : "摇一摇关")

            BLoger.shared.shankShow = sender.isOn
        }
        
        if sender.tag == 2 {

            BLog(sender.isOn ? "自动测试开" : "自动测试关")

            if sender.isOn {
                BLogAutoTask.shared.start()
            }else {
                BLogAutoTask.shared.stop()
            }
        }
    }

}

