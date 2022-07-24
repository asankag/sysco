//
//  ViewController.swift
//  Sysco LABS
//
//  Created by AsankaTipple on 7/23/22.
//

import UIKit
import RxSwift

class PlanetsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = PlanetViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        configureTableView()
    }
    
    fileprivate func configureTableView () {

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let request =  APIRequest()
        let result : Observable<[results]> = self.viewModel.send(apiRequest: request)
        _ = result.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { ( row, model, cell) in
            cell.textLabel?.text = model.name + " - [" + model.climate + "]"
        }.disposed(by: disposeBag)
    
        // hadle selection
        tableView.rx.modelSelected(results.self)
            .subscribe(onNext: { [weak self] selectedItems in
                
                guard let strongSelf = self else { return }
                
                guard let detailViewController = strongSelf.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                    fatalError("DetailViewController not found")
                }
                detailViewController.planetName = selectedItems.name
                detailViewController.orbitalPeriod = selectedItems.orbital_period
                detailViewController.gravity = selectedItems.gravity
                strongSelf.navigationController?.pushViewController(detailViewController, animated: true)
                        
            }).disposed(by: disposeBag)
    }
}
extension PlanetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
