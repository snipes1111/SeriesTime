//
//  Data.swift
//  SerialTime
//
//  Created by user on 30/12/2022.
//

import Foundation

struct SeriesItems {
    
    public static var arrayOfSeries: [Series] = {
        var array: [Series] = []
        array.append(Series(image: "saul", name: "Better call Saul", season: 1, episode: 1))
        array.append(Series(image: "dead", name: "All of Us Are Dead", season: 1, episode: 1))
        array.append(Series(image: "cosmic", name: "Space Force", season: 1, episode: 1))
        array.append(Series(image: "papa", name: "The Young Pope", season: 1, episode: 1))
        array.append(Series(image: "rick", name: "Rick and Morty", season: 1, episode: 1))

        return array
    }()
    
    public static var arrayOfEndedSeries: [Series] = {
        var array: [Series] = []
        array.append(Series(image: "got", name: "Game of Thrones", season: 1, episode: 1))
        array.append(Series(image: "cabinet", name: "Guillermo del Toro's Cabinet of Curiosities", season: 1, episode: 1))
        array.append(Series(image: "supernatural", name: "Supernatural", season: 1, episode: 1))
        array.append(Series(image: "deryl", name: "The Walking Dead", season: 1, episode: 1))
        array.append(Series(image: "detective", name: "True Detective", season: 1, episode: 1))

        return array
    }()
    
    public static let arrayOfAllSeries = [arrayOfSeries, arrayOfEndedSeries]
    
    
    
}
