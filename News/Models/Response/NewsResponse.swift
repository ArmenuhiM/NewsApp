//
//  NewsResponse.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/2/21.
//

struct NewsResponse: Codable {
    let category: String?
    let title: String?
    let body: String?
    let shareUrl: String?
    let coverPhotoUrl: String?
    let date: Double?
    let gallery: [Gallery]?
    let video: [Video]?
}



struct Gallery: Codable {
    let title: String?
    let thumbnailUrl: String?
    let contentUrl: String?
}


struct Video: Codable {
    let title: String?
    let thumbnailUrl: String?
    let youtubeId: String?
}



class APIPreferencesLoader {
  static private var plistURL: URL {
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documents.appendingPathComponent("api_preferences.plist")
  }

  static func load() -> [NewsResponse] {
    let decoder = PropertyListDecoder()

    guard let data = try? Data.init(contentsOf: plistURL),
      let preferences = try? decoder.decode([NewsResponse].self, from: data)
    else { return [NewsResponse(category: "", title: "", body: "", shareUrl: "", coverPhotoUrl: "", date: 0.0, gallery: [], video: [])] }

    return preferences
  }
}



extension APIPreferencesLoader {
  static func copyPreferencesFromBundle() {
    if let path = Bundle.main.path(forResource: "api_preferences", ofType: "plist"),
      let data = FileManager.default.contents(atPath: path),
      FileManager.default.fileExists(atPath: plistURL.path) == false {

      FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
    }
  }
}


extension APIPreferencesLoader {
  static func write(preferences: [NewsResponse]) {
    let encoder = PropertyListEncoder()

    if let data = try? encoder.encode(preferences) {
      if FileManager.default.fileExists(atPath: plistURL.path) {
        try? data.write(to: plistURL)
      } else {
        FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
      }
    }
  }
}
