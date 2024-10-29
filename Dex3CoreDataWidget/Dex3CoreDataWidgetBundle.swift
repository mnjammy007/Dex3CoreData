//
//  Dex3CoreDataWidgetBundle.swift
//  Dex3CoreDataWidget
//
//  Created by Apple on 29/10/24.
//

import WidgetKit
import SwiftUI

@main
struct Dex3CoreDataWidgetBundle: WidgetBundle {
    var body: some Widget {
        Dex3CoreDataWidget()
        Dex3CoreDataWidgetControl()
        Dex3CoreDataWidgetLiveActivity()
    }
}
