//
//  HomeViewController.swift
//  PlayersApp
//
//  Created by sergio blanco martin on 03/12/2019.
//  Copyright © 2019 sergio blanco martin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

enum typeSport: Int {
    case football = 0
    case tennis = 1
    case golf = 2
    case formuleOne = 3
}

enum keysSport: String {
    case football = "Football"
    case tennis = "Tennis"
    case golf = "Golf"
    case formuleOne = "Formula 1"
}

protocol HomeViewControllerDelegate {}

class HomeViewController: UIViewController {
    
    //MARK: Properties
    fileprivate lazy var viewModel: HomeViewModelDelegate = HomeViewModel(delegate: self)
    
    var arrayPlayers: [Player]?
    var titleSport: String?
    var name: String?
    var surname: String?
    var image: String?
    var sportsNumber = 4
    var sportSections: [String] = []
    var playersAll: [[String]] = []
    var footballArray: [[String]] = []
    var golfArray: [[String]] = []
    var tennisArray: [[String]] = []
    var formuleOneArray: [[String]] = []
    var chosenArray: [[String]] = []
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showPlayers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.configureTableView()
    }
    
    //MARK: Private methods
    private func configureTableView() {
        self.tableView?.register(UINib(nibName: PlayerCell.identifier, bundle: nil),
                                 forCellReuseIdentifier: PlayerCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    func showPlayers() {
        self.showSpinner()
        self.viewModel.getPlayers { (result, error) in
            
            for results in result! {
                self.titleSport = results.title
                self.sportSections.append(self.titleSport ?? "")
                
                self.arrayPlayers = results.players
                
                for player in self.arrayPlayers! {
                    self.name = player.name
                    self.surname = player.surname
                    self.image = player.image

                    let array: [String] = [self.name ?? "",
                                           self.surname ?? "",
                                           self.image ?? "",
                                           self.titleSport ?? ""]
                    
                    self.playersAll.append(array)
                }
            }
            
            for player in self.playersAll {
                switch player[3] {
                case keysSport.football.rawValue:
                    self.footballArray.append(player)
                case keysSport.tennis.rawValue:
                    self.tennisArray.append(player)
                case keysSport.golf.rawValue:
                    self.golfArray.append(player)
                case keysSport.formuleOne.rawValue:
                    self.formuleOneArray.append(player)
                default:
                    return
                }
            }
            
            self.tableView.reloadData()
            self.removeSpinner()
        }
    }
}

//MARK: TableViewDelegate & TableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
     func numberOfSections(in tableView: UITableView) -> Int {
        return sportSections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return PlayerCell.estimateHeightSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myView = UIView()
        myView.backgroundColor = UIColor.lightGray
        
        let myLabel = UILabel()
        let font = UIFont.boldSystemFont(ofSize: 20)
        myLabel.font = font
        
        myLabel.textAlignment = .center
        myLabel.text = self.sportSections[section]
        myLabel.frame = CGRect(x: 0, y: 0, width: 400, height: 40)
        
        myView.addSubview(myLabel)
        return myView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case typeSport.football.rawValue:
            chosenArray = footballArray
        case typeSport.tennis.rawValue:
            chosenArray = tennisArray
        case typeSport.golf.rawValue:
            chosenArray = golfArray
        case typeSport.formuleOne.rawValue:
            chosenArray = formuleOneArray
        default:
            return 0
        }
        return chosenArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PlayerCell.estimateHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: PlayerCell.identifier, for: indexPath) as! PlayerCell
        
        switch indexPath.section {
        case typeSport.football.rawValue:
            chosenArray = footballArray
        case typeSport.tennis.rawValue:
            chosenArray = tennisArray
        case typeSport.golf.rawValue:
            chosenArray = golfArray
        case typeSport.formuleOne.rawValue:
            chosenArray = formuleOneArray
        default:
            return UITableViewCell()
        }
        
        let playerName = "\(chosenArray[indexPath.row][0])" + " " + "\(chosenArray[indexPath.row][1])"
        cell.titleLabel.text = playerName
        
        let imageURL : String = chosenArray[indexPath.row][2]
        Alamofire.request(imageURL, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                cell.imagePlayer.image = UIImage(data: responseData.data!)
            })

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeFadeAnimation(duration: 0.7, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}

//MARK: HomeViewControllerDelegate
extension HomeViewController: HomeViewControllerDelegate {}

//MARK: AnimationCell
typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

final class Animator {
    private var hasAnimatedAllCells = false
    private let animation: Animation
    
    init(animation: @escaping Animation) {
        self.animation = animation
    }
    
    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else {
            return
        }
        
        animation(cell, indexPath, tableView)
    }
}

enum AnimationFactory {
    static func makeFadeAnimation(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, _ in
            cell.alpha = 0
            
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
        }
    }
}
