//
//  CommonExtensions.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/2/21.
//

extension Double {
    func getDateStringFromUTC(dateValue: Double?) -> String {
        var localDate = ""
        if let timeResult = (dateValue) {
            let date = Date(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeZone = .current
            localDate = dateFormatter.string(from: date)
        }
        return localDate
    }
}


extension String {
    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
}


struct DeviceInfo {
    struct Orientation {
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
}
