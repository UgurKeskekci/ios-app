//
//  AboutVC.swift
//  UgurKeskekci_HW1
//
//  Created by Ugur on 11.03.2024.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!

    var textAtTop: String = ""
    var textAtCenter: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
        topLabel.text = textAtTop
        centerLabel.text = textAtCenter
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToStartVC", sender: self)
    }
}
