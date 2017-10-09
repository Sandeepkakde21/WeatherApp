//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sandeep on 08/10/17.
//  Copyright © 2017 Green Leaves. All rights reserved.
//

let BASE_URL_TMAX = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmax/ranked/"
let BASE_URL_TMIN = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmin/ranked/"
let BASE_URL_RAINFALL = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Rainfall/ranked/"
let BASR_URL_MEANTEMP = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmean/ranked/"
let BASR_URL_SUNSHINE = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Sunshine/ranked/"

let TMAX = "Temp Max"
let TMIN = "Temp Min"
let RAINFALL = "Rainfall"
let TMEAN = "Mean Temp"
let SUNSHINE = "Sunshine"

let CITY_ENGLAND = "England"
let CITY_UK = "UK"
let CITY_WALES = "Wales"
let CITY_SCOTLAND = "Scotland"

import UIKit


class ViewController: UIViewController {
    let apiCall = APICall()
    let writeFile = WriteFile()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Initialization
    
    func initialize() -> Void {
        self.getAllDataForCity(CityName: CITY_ENGLAND as NSString)
//        self.getAllDataForCity(CityName: CITY_UK as NSString)
//        self.getAllDataForCity(CityName: CITY_WALES as NSString)
//        self.getAllDataForCity(CityName: CITY_SCOTLAND as NSString)
    }
    
    func getAllDataForCity(CityName cityName:NSString) -> Void {
        //Temp max
        self.getFile(FilePath: BASE_URL_TMAX + (cityName as String) + ".txt" as (NSString), Region: cityName, WeatherParameter: TMAX as NSString)
//        //Temp min
//        self.getFile(FilePath: BASE_URL_TMIN + (cityName as String) + ".txt" as (NSString), Region: cityName, WeatherParameter: TMIN as NSString)
//        //RAINFALL
//        self.getFile(FilePath: BASE_URL_RAINFALL + (cityName as String) + ".txt" as (NSString), Region: cityName, WeatherParameter: RAINFALL as NSString)
//        //SUNSHINE
//        self.getFile(FilePath: BASR_URL_SUNSHINE + (cityName as String) + ".txt" as (NSString), Region: cityName, WeatherParameter: SUNSHINE as NSString)
//        //TMEAN
//        self.getFile(FilePath: BASR_URL_MEANTEMP + (cityName as String) + ".txt" as (NSString), Region: cityName, WeatherParameter: TMEAN as NSString)
    }
    
    func getFile(FilePath fileUrl:(NSString), Region region:NSString, WeatherParameter weatherParameter:NSString) -> Void {
        apiCall.getFileData(Filepath: fileUrl) { (success, fileData, error) in
            if success {
                DispatchQueue.main.async {
                    self.writeFile.convertFileDataIntoArray(FileData: fileData, Region: region, WeatherParameter: weatherParameter)
                }
            }else {
                print(error?.localizedDescription ?? "file Error")
                
            }
        }
    }
}

