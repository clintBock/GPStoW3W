import Foundation
import CoreLocation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gpsLocation: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var wordsLabel: UILabel!
    
    
    @IBAction func convertGpstoW3W(_ sender: UIButton) {
        var longtitude : Double;
        var latitude : Double;
        
        longtitude = Double(round(1000*(locationManager.location?.coordinate.longitude ?? -1))/1000)
        latitude = Double(round(1000*(locationManager.location?.coordinate.latitude ?? -1))/1000)
        let apiCall = URL(string: "https://api.what3words.com/v2/reverse?coords=\(latitude),\(longtitude)&display=full&format=json&key=BJEVPZLZ")
        var latitudeString:String = String(format:"%f", latitude)
        var longtitudeString:String = String(format:"%f", longtitude)

        

        gpsLocation.text = latitudeString + " " + longtitudeString
    
        
        let task = URLSession.shared.dataTask(with: apiCall!) { (data, response, error) in
            
            if let data = data {
                do {
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    if let json = jsonSerialized, let threewords = json["words"] {
                        
                        self.wordsLabel.text = threewords as! String
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
        
    }
    
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

