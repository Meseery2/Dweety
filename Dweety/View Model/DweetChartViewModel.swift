//
//  DweetGraphViewModel.swift
//  Dweety
//
//  Created by Mohamed EL Meseery on 9/3/18.
//  Copyright © 2018 Meseery. All rights reserved.
//
import Charts

typealias completionCallback = (Error?) -> Void

class DweetChartViewModel {
    // MARK: - Section Dependencies.
    let thing : String = "nsemi"
    var dweetAPIworker : DweetAPIWorker?
    
    var chartView : ChartViewBase?
    var chartViewData : BarChartData?
    var temperatureDataSet,xDataSet,yDataSet,zDataSet : BarChartDataSet?

    // MARK: - Section Initialization.
    init(withChartView chartView:ChartViewBase) {
        self.chartView = chartView
        setupGraphView()
        setupGraphViewData()
    }
    
    // MARK: - Section Dweeting.
    public func getDweets(meanwhile
        meanWhileCallback:() -> Void,
                              onCompletion
        completion:@escaping (Error?)->Void) {
        meanWhileCallback()
        getDweetsUpdateGraph { [weak self] (error) in
            completion(error)
            self?.scheduleNextBatch()
        }
    }
    
    public func scheduleNextBatch() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {[weak self] _ in
            self?.getDweetsUpdateGraph()
        }
    }
    
    private func getDweetsUpdateGraph(onCompletion
        completion : completionCallback? = nil) {
        if  dweetAPIworker == nil{
            dweetAPIworker = DweetAPIWorker()
        }
        dweetAPIworker?.getDweets(for:thing,
                                  ifSucceeded: {[weak self] (dweets) in
                                    if let dweets = dweets {
                                        self?.updateGraph(withDweets: dweets)
                                    }
                                    completion?(nil)
            }, ifFailed: { (error) in
                // Show Error
                completion?(error)
        })
    }
}

// MARK: - Section Private Operations.
extension DweetChartViewModel {
    fileprivate func setupGraphView(){
        chartView?.chartDescription?.text = "Dweets Data"
        chartView?.chartDescription?.font = .systemFont(ofSize: 16, weight: .light)
        chartView?.backgroundColor = UIColor.mainColor
        chartView?.animate(xAxisDuration: 3, yAxisDuration: 3)
        chartView?.noDataTextColor = .white
        chartView?.xAxis.drawGridLinesEnabled = false
    }
    
    fileprivate func setupGraphViewData() {
        chartViewData = BarChartData.init()
        chartViewData?.setValueFont(.systemFont(ofSize: 14, weight: .light))
        chartViewData?.barWidth = 0.09
        
        temperatureDataSet = BarChartDataSet.init()
        temperatureDataSet?.label = "Temperature"
        temperatureDataSet?.setColor(UIColor.white)
        chartViewData?.addDataSet(temperatureDataSet)
        
        xDataSet = BarChartDataSet.init()
        xDataSet?.label = "X"
        xDataSet?.setColor(UIColor.grayColor)
        chartViewData?.addDataSet(xDataSet)
        
        yDataSet = BarChartDataSet.init()
        yDataSet?.label = "Y"
        yDataSet?.setColor(UIColor.redColor)
        chartViewData?.addDataSet(yDataSet)
        
        zDataSet = BarChartDataSet.init()
        zDataSet?.label = "Z"
        zDataSet?.setColor(UIColor.greenColor)
        chartViewData?.addDataSet(zDataSet)
        chartView?.data = chartViewData
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

            self.chartViewData?.groupBars(fromX: Double(0), groupSpace: 0.08, barSpace: 0.03)
            self.chartView?.notifyDataSetChanged()
        
    }
}
