//
//  Repositorio.swift
//  GitMobile
//
//  Created by Mariana Medeiro on 30/04/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import Foundation
import CoreData

class Repositorio: NSManagedObject {

    @NSManaged var labels: String
    @NSManaged var nomeRepositorio: String
    @NSManaged var numero: NSNumber

}
