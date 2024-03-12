//
//  CalculationVC.swift
//  UgurKeskekci_HW1
//
//  Created by Ugur on 11.03.2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class CalculationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

         let shapes = ["Sphere", "Cone", "Cylinder"]
        var selectedShapeIndex = 0
        
   
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return shapes.count
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return shapes[row]
       }
       
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedShapeIndex = row
        updateShapeImage()
        updateUIBasedOnShape()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shapePickerView: UIPickerView!
    @IBOutlet weak var shapeImageView: UIImageView!
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var mainView: UIView!
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        guard let radiusText = radiusTextField.text, !radiusText.isEmpty else {
            showAlert(message: "Radius cannot be empty.")
            return
        }

        calculateAndDisplayResults()
        }
    @IBAction func closePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToViewController", sender: self)
    }

    
    func showAlert(message: String) {
           let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(okAction)
           present(alert, animated: true, completion: nil)
       }
    
    
    func updateShapeImage() {
            let shapeImageName = shapes[selectedShapeIndex].lowercased()
            shapeImageView.image = UIImage(named: shapeImageName)
        }
    func updateUIBasedOnShape() {
       
        heightLabel.isHidden = true
        heightTextField.isHidden = true
        radiusLabel.isHidden = true
        radiusTextField.isHidden = true

        switch selectedShapeIndex {
        case 0: // Sphere
            radiusLabel.isHidden = false
            radiusTextField.isHidden = false
        case 1: // Cone
            radiusLabel.isHidden = false
            radiusTextField.isHidden = false
            heightLabel.isHidden = false
            heightTextField.isHidden = false
        case 2: // Cylinder
            radiusLabel.isHidden = false
            radiusTextField.isHidden = false
            heightLabel.isHidden = false
            heightTextField.isHidden = false
        default:
            break
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
          let characterSet = CharacterSet(charactersIn: string)
          return allowedCharacters.isSuperset(of: characterSet)
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                shapePickerView.delegate = self
                shapePickerView.dataSource = self
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                mainView.addGestureRecognizer(tapGesture)
        
        updateShapeImage()
              updateUIBasedOnShape()
     }

    @objc func handleTap() {
           view.endEditing(true)
       }
   
    
    func configureUI() {
        titleLabel.backgroundColor = UIColor.blue
        titleLabel.text = "Calculation"
    }
    
    func calculateAndDisplayResults() {
        guard let radiusText = radiusTextField.text, let radius = Double(radiusText) else {
            showAlert(message: "Invalid radius.")
            return
        }

        switch selectedShapeIndex {
        case 0: // Sphere
            calculateAndDisplaySphereResults(radius: radius)
        case 1: // Cone
            guard let heightText = heightTextField.text, let height = Double(heightText) else {
                showAlert(message: "Radius or heigh cannot be empty.")
                return
            }
            calculateAndDisplayConeResults(radius: radius, height: height)
        case 2: // Cylinder
            guard let heightText = heightTextField.text, let height = Double(heightText) else {
                showAlert(message: "Radius or heigh cannot be empty.")
                return
            }
            calculateAndDisplayCylinderResults(radius: radius, height: height)
        default:
            break
        }
    }

    func calculateAndDisplaySphereResults(radius: Double) {
        let area = 4 * Double.pi * radius
        let volume = (4/3) * Double.pi * pow(radius, 3)

        displayResults(area: area, volume: volume)
    }

    func calculateAndDisplayConeResults(radius: Double, height: Double) {
        let slantHeight = sqrt(pow(radius, 2) + pow(height, 2))
        let area = Double.pi * radius * (radius + slantHeight)
        let volume = (1/3) * Double.pi * pow(radius, 2) * height

        displayResults(area: area, volume: volume)
    }

    func calculateAndDisplayCylinderResults(radius: Double, height: Double) {
        let area = 2 * Double.pi * radius * (radius + height)
        let volume = Double.pi * pow(radius, 2) * height

        displayResults(area: area, volume: volume)
    }

    func displayResults(area: Double, volume: Double) {
        let formattedArea = String(format: "%.2f", area)
        let formattedVolume = String(format: "%.2f", volume)

        let resultMessage = "Area: \(formattedArea)\nVolume: \(formattedVolume)"

        let alertController = UIAlertController(title: "Calculation Results", message: resultMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }

  

}
