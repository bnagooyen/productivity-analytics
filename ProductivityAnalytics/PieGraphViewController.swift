//
//  PieGraphViewController.swift
//  ProductivityAnalytics
//
//  Created by Brian Nguyen on 8/4/16.
//  Copyright © 2016 BrianNguyen. All rights reserved.
//

// pie graph of total tasks completed

import UIKit
import Parse
import Charts

class PieGraphViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var pieChart: PieChartView!
    
    var completedCount = 0
    var notCompletedCount = 0
    var completionCounts = [Double]()
    let completionStatus = ["Completed", "Not Completed"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pieChart.delegate = self
        pieChart.descriptionText = "test"
        pieChart.descriptionTextColor = UIColor.blackColor()
        
        
        
        var query = PFQuery(className: "Task")
        query.whereKey("userId", equalTo: PFUser.currentUser()!.objectId!)
        
        
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        if object["completed"] as! Bool == true{
                            
                            self.completedCount += 1
                            
                        } else if object["completed"] as! Bool == false {
                            
                            self.notCompletedCount += 1
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
                
            }
            
            
                self.completionCounts.append(Double(self.completedCount))
                self.completionCounts.append(Double(self.notCompletedCount))
                print(self.completionCounts)
        }
        
        
        
    }
    
    
    func setData(dataPoints: [String], values: [Double]){
        
        
        
        var dataEntries = [ChartDataEntry]()
        
        for i in 0..<dataPoints.count{
            
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
            
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Completion Ratio")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChart.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        setData(completionStatus, values: completionCounts)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
