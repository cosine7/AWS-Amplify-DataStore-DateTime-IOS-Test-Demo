//
//  ViewController.swift
//  DateTimeTest
//
//  Created by lcx on 2021/11/6.
//

import UIKit
import Amplify

class ViewController: UIViewController {
    @IBOutlet weak var dateTime: UITextField!
    
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.preferredDatePickerStyle = .wheels
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: nil,
            action: #selector(doneButtonPressed)
        )
        toolBar.setItems([doneButton], animated: true)
        dateTime.inputAccessoryView = toolBar
        dateTime.inputView = datePicker
    }

    @objc private func doneButtonPressed() {
        let date = datePicker.date
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        // https://nsdateformatter.com/
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss a"
        dateTime.text = formatter.string(from: date)
        view.endEditing(true)
        
        DispatchQueue.global().async {
            // let now = Temporal.DateTime.now()
            // above is how to get current time
            let dateTime = Temporal.DateTime(date)
            let item = DateTimeTest(dateTime: dateTime)
            
            Amplify.DataStore.save(item) { result in
                switch(result) {
                case .success(let savedItem):
                    print("Saved item: \(savedItem.id)")
                case .failure(let error):
                    print("Could not save item to DataStore: \(error)")
                }
            }
        }
    }
}

