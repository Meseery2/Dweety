//
//  DweetChartViewController.swift
//  Dweety
//
//  Created by Mohamed EL Meseery on 9/3/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit
import Charts

class DweetChartViewController: UIViewController {

    @IBOutlet weak var dweetChartView: BarChartView!
    @IBOutlet weak var dweetActivityIndicator: UIActivityIndicatorView!
    
    var viewModel : DweetGraphViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DweetGraphViewModel.init(withGraphView: dweetChartView)
        viewModel?.startDweeting(meanwhile: {
            // Show Activity Indicator
            dweetActivityIndicator.startAnimating()
        }, onCompletion: { [unowned self] (error) in
            self.dweetActivityIndicator.stopAnimating()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
