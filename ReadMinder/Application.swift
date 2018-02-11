//
//  AppDelegate.swift
//  ReadMinder
//
//  Created by Andrew Malyarchuk on 05.02.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class Application: UIResponder {

    var window: UIWindow?
    let assembler = MainAssembler(container: .init())

}

extension Application: UIApplicationDelegate {
    
}
