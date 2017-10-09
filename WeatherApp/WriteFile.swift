//
//  WriteFile.swift
//  WeatherApp
//
//  Created by Sandeep on 08/10/17.
//  Copyright © 2017 Green Leaves. All rights reserved.
//

import UIKit
class  WeatherData {
    var year: NSString?
    var value: NSString?
}

class WriteFile: NSObject {
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        super.init()
    }
    
    //MARK: Declaration of static Variables
    var csvData = "Region,  Weather_parameter,  year,  key,  value\n"
    var arrMonth:[String] = ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC","WIN","SPR","SUM","AUT"," ANN"]
    
    //MARK: File Conversion
    
    public func convertFileDataIntoArray(FileData fileData:NSString?, Region region:NSString?,WeatherParameter weatherParam:NSString?) ->Void {
        var isAddToFile = false
        if fileData != nil {
            let arrFileLine = fileData?.components(separatedBy: "\n")
            //ignore first text lines and get actual data ,File is read by horizontal line
            for strline in arrFileLine! {
                var trimmedString = strline.trimmingCharacters(in: .whitespacesAndNewlines)
                //Please comment below line of code if you want to specify static 4 spaces in text file as header of txt file having 4 space divider and uncomment index incement by 2 and 4
                trimmedString = trimmedString.components(separatedBy: .whitespacesAndNewlines)
                    .filter { !$0.isEmpty }
                    .joined(separator: " ")
                if isAddToFile {
                    let arrSepratedData = trimmedString.components(separatedBy: " ") as NSArray
                    var index = 0
                    var indexForMonth = 0
                    var month = ""
                    while index < arrSepratedData.count {
                        let objweatherData = WeatherData()
                        objweatherData.value = arrSepratedData[index] as? NSString
                        index+=1
                        //Here first logic is cansider with header space so index is incremented by 2 and 4
                        //index+=2
                        if index<arrSepratedData.count {
                            objweatherData.year = arrSepratedData[index] as? NSString
                        }
                        index+=1
                        //index+=4
                        if indexForMonth < arrMonth.count {
                            month = arrMonth[indexForMonth]
                            indexForMonth+=1
                        }
                        if let weatherValue =  objweatherData.value, let weatherYear =  objweatherData.year  {
                            var year = weatherYear
                            var value = weatherValue
                            if weatherValue.isEqual(to: "") {
                                value = "N/A"
                            }
                            if weatherYear.isEqual(to: "") {
                                year = "N/A"
                            }
                            let newLine = "\(region!),\(weatherParam!),\(year),\(month),\(value)\n"
                            print(newLine)
                            csvData.append(newLine)
                        }
                    }
                }
                if strline .contains("JAN  Year") {
                    isAddToFile = true
                }
            }
            self.wirteToCSV()
        }
    }
    
    //MARK: File Read ,write ,create function
    private func getCSVFilePath() -> NSURL {
        let fileName = "weather.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        print(path ?? "")
        return path! as NSURL
    }
    
    private func wirteToCSV() ->Void {
        do {
            try csvData.write(to: getCSVFilePath() as URL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
    }
}

