//
//  ViewController.swift
//  Project1
//
//  Created by Адиль Медеуев on 17.12.2020.
//

import UIKit

class ViewController: UITableViewController {
    var pics = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "K/DA Pictures viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasPrefix("kda") {
                pics.append(item)
            }
        }
        pics.shuffle()
        if let backgroundImage = UIImage(named: pics.randomElement() ?? "kda-ahri.jpg") {
            let imageView = UIImageView(image: backgroundImage)
            imageView.contentMode = .scaleAspectFill
            tableView.backgroundView = imageView
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pics[indexPath.row]
        cell.layer.cornerRadius = 8
        if let image = UIImage(named: pics[indexPath.row]) {
            cell.imageView?.image = image
        }
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pics[indexPath.row]
            vc.imageTitle = "\(indexPath.row + 1) out of \(pics.count)"
            //showDetailViewController(vc, sender: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

