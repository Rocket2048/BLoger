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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        BLoger.shared.shankShow = sw.isOn
        
        if sw2.isOn {
            BLogAutoTask.shared.start()
        }else {
            BLogAutoTask.shared.stop()
        }
    }

    @IBAction func btnAction(_ sender: Any) {
        
        BLoger.shared.showLogView()
    }
    
    @IBAction func btnAction1(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func swAction(_ sender: UISwitch) {
        
        if sender.tag == 1 {
            BLoger.shared.shankShow = sender.isOn
        }
        
        if sender.tag == 2 {
            if sender.isOn {
                BLogAutoTask.shared.start()
            }else {
                BLogAutoTask.shared.stop()
            }
        }
    }

}

