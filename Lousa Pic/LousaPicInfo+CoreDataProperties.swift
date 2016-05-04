//
//  LousaPicInfo+CoreDataProperties.swift
//  Lousa Pic
//
//  Created by Daniel Griso Filho on 5/4/16.
//  Copyright © 2016 Daniel Griso Filho. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LousaPicInfo {

    @NSManaged var materia: String?
    @NSManaged var observacoes: String?
    @NSManaged var image: NSData?
    @NSManaged var date: String?

}
