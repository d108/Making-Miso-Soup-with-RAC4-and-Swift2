//
//  AppDelegate.swift
//  RAC4-Miso-Soup
//
//  Created by Daniel Zhang (張道博) on 9/16/15.
//  Copyright © 2015 ikiApps.com. All rights reserved.
//

import Cocoa
import ReactiveCocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application

        _ = MisoSoupMaker()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}