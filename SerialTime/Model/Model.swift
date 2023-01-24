//
//  Model.swift
//  SerialTime
//
//  Created by user on 29/12/2022.
//

import Foundation

struct Series {
    var image: String?
    var name: String?
    var season: Int?
    var episode: Int?
    var seriesDescription: String {
        return "Season \(season ?? 1), episode \(episode ?? 1)"
    }
}
