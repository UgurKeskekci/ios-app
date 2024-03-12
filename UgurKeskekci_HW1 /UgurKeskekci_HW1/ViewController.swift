//
//  ViewController.swift
//  UgurKeskekci_HW1
//
//  Created by Ugur on 10.03.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        mImageView.image = UIImage(named: "calculation")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        mImageView.addGestureRecognizer(tapGesture)
        mImageView.isUserInteractionEnabled = true

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(imageLongPressed))
        mImageView.addGestureRecognizer(longPressGesture)
        
        updateTitleLabel()
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mImageView.image = UIImage(named: "calculation")
        case 1:
            mImageView.image = UIImage(named: "whtr")
        case 2:
            mImageView.image = UIImage(named: "player")
        case 3:
            mImageView.image = UIImage(named: "about")
        default:
            break
        }
        
        updateTitleLabel()
    }

    @objc func imageTapped() {
        let newIndex = (segmentedControl.selectedSegmentIndex + 1) % segmentedControl.numberOfSegments
        segmentedControl.selectedSegmentIndex = newIndex
        segmentChanged(segmentedControl)
    }

    @objc func imageLongPressed() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "ShowCalculationVC", sender: self)
            print("Open CalculationVC")
        case 1:
            performSegue(withIdentifier: "ShowWhtrVC", sender: self)
            print("Open WhtrVC")
        case 2:
            print("Open PlayerVC")
            performSegue(withIdentifier: "ShowPlayerVC", sender: self)
        case 3:
            performSegue(withIdentifier: "ShowAboutVC", sender: self)
            print("Open AboutVC")
        default:
            break
        }
    }

    func updateTitleLabel() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            titleLabel.text = "Calculation Controller"
        case 1:
            titleLabel.text = "WHtR Controller"
        case 2:
            titleLabel.text = "Player Controller"
        case 3:
            titleLabel.text = "About Controller"
        default:
            break
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAboutVC" {
            if let aboutVC = segue.destination as? AboutVC {
                aboutVC.textAtTop = "About Controller"
                aboutVC.textAtCenter = "CTIS 480: Homework I"
            }
        }
    }
}
