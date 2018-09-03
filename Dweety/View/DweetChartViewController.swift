//
//  DweetChartViewController.swift
//  Dweety
//
//  Created by Mohamed EL Meseery on 9/3/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit
import Charts

class DweetChartViewController: UIViewController, ShowsAlert {

    @IBOutlet weak var dweetChartView: BarChartView!
    @IBOutlet weak var dweetActivityIndicator: UIActivityIndicatorView!
    
    var viewModel : DweetChartViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DweetChartViewModel.init(withChartView: dweetChartView)
        viewModel?.getDweets(meanwhile: {
            // Show Activity Indicator
            dweetActivityIndicator.startAnimating()
        }, onCompletion: { [unowned self] (error) in
            self.dweetActivityIndicator.stopAnimating()
            if let error = error {
                self.showAlert(message: error.localizedDescription)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
