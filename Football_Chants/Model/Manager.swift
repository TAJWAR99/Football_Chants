//
//  Manager.swift
//  Football_Chants
//
//  Created by Sihan on 4/10/23.
//

import Foundation

enum JobType: String {
    case manager = "Manager"
    case headCoach = "Head Coach"
}

struct Manager {
    let name: String
    let job: JobType
}
