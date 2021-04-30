//
//  User.swift
//  FocusApp
//
//  Created by Nour Altunaib on 4/30/21.
//

import Foundation
import Combine

class Task: ObservableObject {
    @Published var tasks: String {
        didSet {
            UserDefaults.standard.set(tasks, forKey: "tasks")
        }
    }
    
    init() {
        self.tasks = UserDefaults.standard.object(forKey: "tasks") as? String ?? ""
    }
}
