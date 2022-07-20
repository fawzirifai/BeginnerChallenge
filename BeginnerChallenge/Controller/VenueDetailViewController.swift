//
//  VenueDetailViewController.swift
//  BeginnerChallenge
//
//  Created by Penguin eers on 19/07/2022.
//

import UIKit

class VenueDetailViewController: UIViewController {
    
    var venue: Venue?
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var campusIdLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var centerPointLabel: UILabel!
    @IBOutlet var UpdateStatusLabel: UILabel!
    @IBOutlet var isBLELabel: UILabel!
    @IBOutlet var isMixLabel: UILabel!
    @IBOutlet var isWiFiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let venue = venue {
            idLabel.text = "\(venue.ID)"
            campusIdLabel.text = "\(venue.campusId)"
            pointsLabel.text = "\(venue.Points)"
            centerPointLabel.text = "\(venue.CenterPoint)"
            UpdateStatusLabel.text = "\(venue.UpdateStatus)"
            isBLELabel.text = "\(venue.isBLE)"
            isMixLabel.text = "\(venue.isMix)"
            isWiFiLabel.text = "\(venue.isWiFi)"
        }
    }

}
