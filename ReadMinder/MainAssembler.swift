//
//  MainAssembler.swift
//  ReadMinder.iOS
//
//  Created by Andrew Malyarchuk on 11.02.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation
import Swinject

class MainAssembler {
    
    var resolver: Resolver {
        return assembler.resolver
    }
    
    private let assembler: Assembler
    
    init(container: Container) {
        assembler = Assembler(container: container)
        assembler.apply(assemblies: [])
    }
    
}
