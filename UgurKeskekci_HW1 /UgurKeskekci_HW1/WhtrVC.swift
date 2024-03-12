import UIKit

class WhtrVC: UIViewController {

    @IBOutlet weak var waistTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var whtrResultLabel: UILabel!
    @IBOutlet weak var generalResultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        guard let waistText = waistTextField.text, let waist = Double(waistText),
              let heightText = heightTextField.text, let height = Double(heightText) else {
            showAlert(message: "Please enter valid values for waist and height.")
            return
        }

        let whtr = (waist / height) * 100
        displayResults(whtr: whtr)
    }

    @IBAction func genderSwitchChanged(_ sender: UISwitch) {
        genderLabel.text = sender.isOn ? "Male" : "Female"
    }

    @IBAction func unwindToStartVC(_ unwindSegue: UIStoryboardSegue) {
      
    }

    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    func displayResults(whtr: Double) {
        var healthStatus: String
        var category: String

        if genderSwitch.isOn { // Male
            category = "Men"
            healthStatus = calculateHealthStatusForMen(whtr: whtr)
        } else { // Female
            category = "Women"
            healthStatus = calculateHealthStatusForWomen(whtr: whtr)
        }

        let whtrResultText = "WHtR (\(category)): \(String(format: "%.2f", whtr))"
        let generalResultText = "Health Status: \(healthStatus)"

        whtrResultLabel.text = whtrResultText
        generalResultLabel.text = generalResultText
    }

    func calculateHealthStatusForMen(whtr: Double) -> String {
        switch whtr {
        case ..<35: return "Abnormally Slim to Underweight"
        case 35..<43: return "Extremely Slim"
        case 43..<46: return "Slender and Healthy"
        case 46..<53: return "Healthy, Normal Weight"
        case 53..<58: return "Overweight"
        case 58..<63: return "Extremely Overweight/Obese"
        default: return "Highly Obese"
        }
    }

    func calculateHealthStatusForWomen(whtr: Double) -> String {
        switch whtr {
        case ..<35: return "Abnormally Slim to Underweight"
        case 35..<42: return "Extremely Slim"
        case 42..<46: return "Slender and Healthy"
        case 46..<49: return "Healthy, Normal Weight"
        case 49..<54: return "Overweight"
        case 54..<58: return "Seriously Overweight"
        default: return "Highly Obese"
        }
    }
}
