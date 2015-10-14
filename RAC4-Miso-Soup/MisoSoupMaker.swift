//
//  MisoSoupMaker.swift
//  RAC4-Miso-Soup
//
//  Created by Daniel Zhang (張道博) on 9/23/15.
//  Copyright © 2015 Daniel Zhang (張道博). All rights reserved.
//

import Foundation
import ReactiveCocoa

typealias Ingredients = Array<String>
typealias SaucePan = Array<String>

func noop(){}

/**

Miso Soup Maker.

Combines the ingredients for my miso soup recipe according to dependencies on the temperature.

The ingredients and the temperatures are represented as RAC Signals.

Mirin helps to complement the saltiness of the miso.

*/

class MisoSoupMaker {

    struct Temperature {
        let boiling = 212 as Int
        let cooled = 140 as Int
    }

    let name = "miso soup (味噌汁)"
    var ingredients: Ingredients = ["water (水)", "dashi (ダシ)", "tofu (豆腐)", "wakame (ワカメ)", "mirin (みりん)", "miso (味噌)", "green onion (青葱)"]

    /// Holds the cooked ingredients.
    var saucePan = SaucePan()

    /**

    A pot of miso soup begins to be prepared on instantiation.
    
    */
    init()
    {
        print("Cooking \(name)")
        cookMisoSoup()
    }

    /**

    Add all the ingredients with respect to the state of the water temperature.
    
    */
    func cookMisoSoup()
    {
        addIngredient(boilIsComplete: false, coolingIsComplete: false)
    }

    /**

    Boil the water. 
    When the boiling is complete ingredients requiring the water to be boiled can continue to be added.
    When the water is cooled enough, the ingredients requiring the cooler temperature can be added.
    
    */
    func observeWaterTemperature()
    {
        print("Watching the water.")

        let temp = Temperature()
        temperatureSignal().observeOn(UIScheduler()).observeNext { event in
            if let result = event {
                if result == temp.boiling {
                    print("Water is boiling.")
                    self.addIngredient(boilIsComplete: true, coolingIsComplete: false)
                } else if result == temp.cooled {
                    print("Water has cooled.")
                    self.addIngredient(boilIsComplete: true, coolingIsComplete: true)
                }
            }
        }
    }

    /**

    Continue to add ingredients until there are none remaining.
    Ingredients are added in order and with dependencies where ingredient adding cannot continue until a condition is met.

    - parameter boilIsComplete Bool indicating that the water has reached the boiling temperature.
    - parameter coolingIsComplete Bool indicating that the water has cooled off after boiling.

    */
    func addIngredient(boilIsComplete boilIsComplete: Bool, coolingIsComplete: Bool)
    {
        if ingredients.count <= 0 {
            return
        }

        // Grab the next ingredient.
        ingredientsSignal().observeNext { ingredient in
            print("Adding ingredient \(ingredient).")
            self.saucePan.append(ingredient)
            print("Saucepan contains \(self.saucePan)")

            if !boilIsComplete && !coolingIsComplete && self.saucePan.contains("water (水)") && self.saucePan.count == 1 {
                // Let the water come to a boil before adding the dashi, tofu, wakame, and mirin.
                self.observeWaterTemperature() // let the water boil
            } else if boilIsComplete && !coolingIsComplete && self.saucePan.count == 5 {
                // Don't add more ingredients until the water has cooled.
                noop()
            } else {
                self.addIngredient(boilIsComplete: boilIsComplete, coolingIsComplete: coolingIsComplete)
            }
        }
    }

    // ------------------------------------------------------------
    // MARK: - Signals -
    // ------------------------------------------------------------

    /**

    Represents ingredients being added to a cooking pot.
    - returns: Signal

    */
    func ingredientsSignal() -> Signal<String, NoError> {
        return Signal {sink in
            NSTimer.schedule(delay: 2.0) { _ in
                if self.ingredients.count > 0 {
                    sendNext(sink, self.ingredients[0])
                    self.ingredients.removeFirst()
                } else {
                    print("Disposing ingredient signal.")
                    sendCompleted(sink)
                }
            }
            return nil
        }
    }

    /**

    Represents temperature that is dependent on time.
    - returns: Signal
    
    */
    func temperatureSignal() -> Signal<Int?, NoError> {
        return Signal{ sink in
            var count = 0
            var timer = NSTimer()
            timer = NSTimer.schedule(repeatInterval: 1.0) { _ in
                if count == 10 {
                    sendNext(sink, Temperature().boiling)
                } else if count == 30 {
                    sendNext(sink, Temperature().cooled)
                } else if count == 39 {
                    print("Disposing temperature signal.")
                    sendCompleted(sink)
                    timer.invalidate()
                } else {
                    sendNext(sink, nil)
                }
                count++
            }
            return nil
            
        }
    }
}
