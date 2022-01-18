//
//  SettingViewController.swift
//  Prework
//
//  Created by Henry Liu on 1/18/22.
//

import UIKit

class SettingViewController: UIViewController {

    
    @IBOutlet weak var selectRegionButton: UIButton!
    @IBOutlet var regionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Region Setting"
    }
    
    func showHideOptions() {
        regionButtons.forEach { button in
            UIView.animate(withDuration: 0.2) {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func selectRegionAction(_ sender: Any) {
        showHideOptions()
    }
    
    @IBAction func US(_ sender: Any) {
        showHideOptions()
        UserDefaults.standard.set("en_US", forKey: "regionPreference")
    }
    
    @IBAction func CN(_ sender: Any) {
        showHideOptions()
        UserDefaults.standard.set("zh_CN", forKey: "regionPreference")
    }
    
    @IBAction func EU(_ sender: Any) {
        showHideOptions()
        UserDefaults.standard.set("es_ES", forKey: "regionPreference")
    }
}
