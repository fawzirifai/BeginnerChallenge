//
//  VenueTableViewController.swift
//  BeginnerChallenge
//
//  Created by Penguin eers on 19/07/2022.
//

import UIKit

class VenueTableViewController: UITableViewController {
    
    var venues = [Venue]()
    @IBOutlet weak var languageButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Settings.shared.language == .en ? "Venues" : "الأماكن"
        languageButton.title = Settings.shared.language.rawValue
        loadData()
    }
    
    @IBAction func languageButtonTapped() {
        let alert = UIAlertController(title: nil, message: "Select a language", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "English", style: .default) { _ in
            Settings.shared.language = .en
            self.languageButton.title = "en"
            self.title = "Venues"
            self.tableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Arabic", style: .default) { _ in
            Settings.shared.language = .ar
            self.languageButton.title = "ar"
            self.title = "الأماكن"
            self.tableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) {_ in
        })
        self.present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Venue", for: indexPath)
        cell.textLabel?.text = venues[indexPath.row].localizedName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let venueDetailViewController = storyboard?.instantiateViewController(withIdentifier: "Venue Detail") as? VenueDetailViewController {
            venueDetailViewController.venue = venues[indexPath.row]
            navigationController?.pushViewController(venueDetailViewController, animated: true)
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://sec.penguinin.com:9090/api/AuthAPI.svc/GetToken") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let decodedBody = ["Name": "PIF", "Key": "UGVuZ3VpbklOX1Blbk5hdl9QSUY="]
        guard let encodedBody =  try? JSONEncoder().encode(decodedBody) else { return }
        request.httpMethod = "POST"
        request.httpBody = encodedBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let authToken = try JSONDecoder().decode(TokenResponse.self, from: data)
                    guard let url = URL(string: "https://sec.penguinin.com:9090/api/DataAPI.svc/GetVenues") else { return }
                    var request = URLRequest(url: url)
                    request.setValue("Bearer " + authToken.Token, forHTTPHeaderField: "Authorization")
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    let decodedBody = ["LanguageCode": "", "LastUpdateDate": "1/1/2001 01:00:00 AM"]
                    guard let encodedBody =  try? JSONEncoder().encode(decodedBody) else { return }
                    request.httpMethod = "POST"
                    request.httpBody = encodedBody
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        do {
                            if let data = data {
                                self.venues = try JSONDecoder().decode(Response.self, from: data).GetVenuesResult
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        } catch {}
                    }
                    task.resume()
                }
            } catch {}
        }
        task.resume()
    }
}
