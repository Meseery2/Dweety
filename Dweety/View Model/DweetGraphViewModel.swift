//
//  DweetGraphViewModel.swift
//  Dweety
//
//  Created by Mohamed EL Meseery on 9/3/18.
//  Copyright © 2018 Meseery. All rights reserved.
//
import Charts

class DweetGraphViewModel {
    // MARK: - Section Dependencies.
    let thing : String = "nsemi"
    var dweetAPIworker : DweetAPIWorker?
    
    var graphView : ChartViewBase?
    var graphViewData : BarChartData?
    var temperatureDataSet,xDataSet,yDataSet,zDataSet : BarChartDataSet?

    // MARK: - Section Initialization.
    init(withGraphView graphView:ChartViewBase) {
        self.graphView = graphView
        setupGraphView()
        setupGraphViewData()
    }
    
    // MARK: - Section Dweeting.
    public func startDweeting(meanwhile meanWhileCallback:() -> Void,
                              onCompletion completion:@escaping (Error?)->Void) {
        meanWhileCallback()
        dweetAPIworker = DweetAPIWorker()
        dweetAPIworker?.getDweets(for:thing,
                                  ifSucceeded: {[weak self] (dweets) in
            if let dweets = dweets {
                self?.updateGraph(withDweets: dweets)
            }
            completion(nil)
        }, ifFailed: { (error) in
            // Show Error
            completion(error)
        })
    }
}

// MARK: - Section Private Operations.
extension DweetGraphViewModel {
    fileprivate func setupGraphView(){
        graphView?.chartDescription?.text = "Dweets Data"
        graphView?.chartDescription?.font = .systemFont(ofSize: 16, weight: .light)
        graphView?.backgroundColor = UIColor.mainColorDarker
        graphView?.animate(xAxisDuration: 3, yAxisDuration: 3)
    }
    
    fileprivate func setupGraphViewData() {
        graphViewData = BarChartData.init()
        graphViewData?.setValueFont(.systemFont(ofSize: 14, weight: .light))
        graphViewData?.barWidth = 0.4
        
        temperatureDataSet = BarChartDataSet.init()
        temperatureDataSet?.label = "Temperature"
        temperatureDataSet?.setColor(UIColor.white)
        graphViewData?.addDataSet(temperatureDataSet)
        
        xDataSet = BarChartDataSet.init()
        xDataSet?.label = "X"
        xDataSet?.setColor(UIColor.grayColor)
        graphViewData?.addDataSet(xDataSet)
        
        yDataSet = BarChartDataSet.init()
        yDataSet?.label = "Y"
        yDataSet?.setColor(UIColor.redColor)
        graphViewData?.addDataSet(yDataSet)
        
        zDataSet = BarChartDataSet.init()
        zDataSet?.label = "Z"
        zDataSet?.setColor(UIColor.greenColor)
        graphViewData?.addDataSet(zDataSet)
        graphView?.data = graphViewData
    }
    
    
    fileprivate func updateGraph(withDweets dweets: [Dweet]) {
        for (i,dweet) in dweets.enumerated() {
            let temperatureEntry = BarChartDataEntry.init(x: Double(i), y: dweet.content?.temperature ?? 0.0)
            let _ = temperatureDataSet?.addEntryOrdered(temperatureEntry)
            let xEntry = BarChartDataEntry.init(x: Double(i), y: dweet.content?.accelerometerData?.x ?? 0.0)
            let _ = xDataSet?.addEntryOrdered(xEntry)
            let yEntry = BarChartDataEntry.init(x: Double(i), y: dweet.content?.accelerometerData?.y ?? 0.0)
            let _ = yDataSet?.addEntryOrdered(yEntry)
            let zEntry = BarChartDataEntry.init(x: Double(i), y: dweet.content?.accelerometerData?.z ?? 0.0)
            let _ = zDataSet?.addEntryOrdered(zEntry)
        }
        
        graphViewData?.groupBars(fromX: Double(0), groupSpace: 0.08, barSpace: 0.03)
        graphView?.notifyDataSetChanged()
    }
}
