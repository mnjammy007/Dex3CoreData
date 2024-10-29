//
//  Dex3CoreDataWidgetLiveActivity.swift
//  Dex3CoreDataWidget
//
//  Created by Apple on 29/10/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Dex3CoreDataWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Dex3CoreDataWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Dex3CoreDataWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Dex3CoreDataWidgetAttributes {
    fileprivate static var preview: Dex3CoreDataWidgetAttributes {
        Dex3CoreDataWidgetAttributes(name: "World")
    }
}

extension Dex3CoreDataWidgetAttributes.ContentState {
    fileprivate static var smiley: Dex3CoreDataWidgetAttributes.ContentState {
        Dex3CoreDataWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Dex3CoreDataWidgetAttributes.ContentState {
         Dex3CoreDataWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Dex3CoreDataWidgetAttributes.preview) {
   Dex3CoreDataWidgetLiveActivity()
} contentStates: {
    Dex3CoreDataWidgetAttributes.ContentState.smiley
    Dex3CoreDataWidgetAttributes.ContentState.starEyes
}
