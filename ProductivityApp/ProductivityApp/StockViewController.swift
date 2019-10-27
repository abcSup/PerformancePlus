//
//  ViewController.swift
//  calhacks-test-1
//
//  Created by Tan Zi Fan on 10/26/19.
//  Copyright © 2019 abcSup. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Highcharts
import SCLAlertView

class StockViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    @IBAction func summaryButtonPressed(_ sender: Any) {
        print("Pressed")
        let alert = SCLAlertView()
        alert.showInfo("You have requested a summary of your trading history.", subTitle: "")
        AF.request("https://calhacks-fitbit-server.appspot.com/docu", method: .get)
    }
    
    let data = [
        Stock(title: "AAPL", subtitle: "Apple Inc.", price: 246.58, change: 3.0),
        Stock(title: "GOOG", subtitle: "Alphabet Inc.", price: 1265.13, change: 4.14),
        Stock(title: "NKE", subtitle: "Nike, Inc.", price: 90.92, change: -0.58),
    ]
    
    @IBOutlet weak var chartView: HIChartView!
    @IBOutlet weak var askTextField: UITextField!
    
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var unitTextField: UITextField!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sellButton: UIButton!
    
    var unitPrice: Double! = 246.62
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        askTextField.delegate = self
        askTextField.returnKeyType = .done
        
        setupViews()
    }
    
    func setupViews() {
        unitPriceLabel.isHidden = true
        unitPriceLabel.text = "@ " + String(unitPrice)
        totalPriceLabel.isHidden = true
        totalPriceLabel.text = "0 $"
        unitTextField.isHidden = true
        buyButton.isHidden = true
        sellButton.isHidden = true
    }
    
    func showTrade() {
        unitPriceLabel.isHidden = false
        totalPriceLabel.isHidden = false
        unitTextField.isHidden = false
        buyButton.isHidden = false
        sellButton.isHidden = false
    }
    
    
    @IBAction func unitTextFieldEditingChanged(_ sender: Any) {
        if unitTextField.text != "" {
            let total = Double(unitTextField.text!)! * unitPrice
            totalPriceLabel.text = String(total) + "$"
        }
        else
        {
            totalPriceLabel.text = "0 $"
        }
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        let alert = SCLAlertView()
        _ = alert.showSuccess("Congratulations", subTitle: "Trade completed")
    }
    
    @IBAction func sellButtonPressed(_ sender: Any) {
        let alert = SCLAlertView()
        _ = alert.showSuccess("Congratulations", subTitle: "Trade completed")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.askTextField {
            updateGraph(ticker: textField.text!)
        }
        textField.resignFirstResponder()
        return true
    }
    
    func updateGraph(ticker: String) {
        AF.request("https://www.blackrock.com/tools/hackathon/performance?identifiers=" + ticker, method: .get)
            .responseJSON { response in
                let json = JSON(response.value)

                // print(json)
                let resultMap = json["resultMap"]["RETURNS"][0]
                guard let success = resultMap["success"].bool else {
                    return
                }
                
                if (success)
                {
                    let performanceChart = resultMap["performanceChart"]
                    let ticker = resultMap["ticker"].string!
                    let data = performanceChart.arrayValue.map { [$0[0].number!, $0[1].number!] }
                    self.setupGraph(ticker: ticker, data: data)
                    self.showTrade()
                }
        }
    }

    func setupGraph(ticker: String, data: [[NSNumber]])
    {
        let chart = HIChart()
        let options = HIOptions()
        chart.type = "column"
        options.chart = chart
        
        let title = HITitle()
        title.text = ticker + " Stock Return"

        //let subtitle = HISubtitle()
        //subtitle.text = "Team statistics"
        //options.title = title
        //options.subtitle = subtitle
        
        let xAxis = HIXAxis()
        xAxis.type = "datetime"
        options.xAxis = [xAxis]

        let yAxis = HIYAxis()
        yAxis.visible = NSNumber(booleanLiteral: false)
        // yAxis.title = HITitle()
        // yAxis.title.text = "Exchange rate"
        options.yAxis = [yAxis]
        
        // turn off hamburger
        options.exporting = HIExporting()
        options.exporting.enabled = NSNumber(booleanLiteral: false)
        
        let legend = HILegend()
        legend.enabled = NSNumber(booleanLiteral: false)
        
        let plotOptions = HIPlotOptions()
        plotOptions.area = HIArea()
        plotOptions.area.fillColor = HIColor(
            linearGradient: ["x1": 0, "x2": 0, "y1": 0, "y2": 1],
            stops: [
                [0, "rgb(47,126,216)"],
                [1, "rgba(47,126,216,0)"]
        ])
        plotOptions.area.marker = HIMarker()
        plotOptions.area.marker.radius = 2
        plotOptions.area.lineWidth = 1;
        let state = HIStates()
        state.hover = HIHover()
        state.hover.lineWidth = 1;
        plotOptions.area.states = state;
        
        let area = HIArea()
        area.name = "Stock Return"
        area.data = data
        
        options.chart = chart
        options.title = title
        options.legend = legend
        options.plotOptions = plotOptions
        options.series = [area]
        
        self.chartView.options = options
    }
    
    // MARK: UITableViewDelegate UITableViewDataSource
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Stocks"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stock", for: indexPath) as! StockTableViewCell
        let stock = data[indexPath.row]
        
        // Configure the cell’s contents.
        cell.titleLabel!.text = stock.title
        cell.subtitleLabel!.text = stock.subtitle
        cell.priceLabel!.text = String(stock.price)
        let sign = stock.change < 0 ? "- " : "+ "
        cell.changeLabel!.text = sign + String(abs(stock.change))
        if (stock.change < 0) {
            cell.changeLabel!.backgroundColor = .red
        } else {
            cell.changeLabel!.backgroundColor = .green
        }
        cell.changeLabel.clipsToBounds = true
        cell.changeLabel.layer.cornerRadius = 5.0
            
        return cell
    }
}

