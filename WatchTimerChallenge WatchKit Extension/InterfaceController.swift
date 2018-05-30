//
//  InterfaceController.swift
//  WatchTimerChallenge WatchKit Extension
//
//  Created by Eduardo Vital Alencar Cunha on 04/09/17.
//  Copyright © 2017 VCode. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet var button: WKInterfaceButton!
    @IBOutlet var lapTable: WKInterfaceTable!

    var timerState = state.initial
    var lapCounter = 0
    var dater = Date()

    enum state {
        case initial,
        running
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        self.timer.setDate(Date(timeIntervalSinceNow: 61))
        self.lapTable.setRowTypes([])
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func startTimer() {
        switch timerState {
        case .initial:
            self.lapCounter = 0
            self.lapTable.setRowTypes([])

            self.dispatchStartButton()

            self.dater = Date(timeIntervalSinceNow: 60)
            self.timer.setDate(self.dater)

            self.changeButtonStateToRunning()

            self.timerState = .running
        case .running:
            self.addLap()
        }
    }

    func changeButtonStateToRunning() {
        self.timer.start()
        self.button.setTitle("Volta")
        self.button.setBackgroundColor(.darkGray)
    }

    func dispatchStartButton() {
        let dispatchTime = DispatchTime.now() + 60
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.button.setTitle("Iniciar")
            self.button.setBackgroundColor(.green)

            self.timerState = .initial
        }
    }

    func addLap() {
        self.lapTable.insertRows(at: IndexSet(integer: 0), withRowType: "lapRow")
        let row = self.lapTable.rowController(at: 0) as! LapRowContoller

        self.lapCounter += 1

        row.lapNumber.setText("Volta " + String(self.lapCounter))
        row.lapTime.setDate(self.dater)
        print(2)
    }


}
