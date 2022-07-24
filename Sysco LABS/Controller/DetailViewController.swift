//
//  DetailViewController.swift
//  Sysco LABS
//
//  Created by AsankaTipple on 7/24/22.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var orbitalPeriodLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    
    var planetName: String = ""
    var orbitalPeriod: String = ""
    var gravity: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planetNameLabel.text = planetName
        orbitalPeriodLabel.text = orbitalPeriod
        gravityLabel.text = gravity
    }
}
