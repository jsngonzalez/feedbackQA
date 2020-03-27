//
//  InicioViewController.swift
//  FeedBackQA
//
//  Created by User on 3/27/20.
//

import UIKit

class InicioFeeBack: UIViewController {

    
    static func getController() -> InicioFeeBack {
            let storyboard = UIStoryboard.init(name: "MainFeedBack", bundle: Bundle(for: self))
            let homeVC = storyboard.instantiateViewController(withIdentifier: "InicioFeeBack") as! InicioFeeBack
            return homeVC
    }
    
    @IBOutlet weak var img1: UIImageView!
    
    var imgScreenshot:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("Listo!! ya quedo cargado")
        
        img1.image = imgScreenshot
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
