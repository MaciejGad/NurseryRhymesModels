import Foundation

public struct List: Codable {
    public let results: [ListItem]
    
    public init(results: [ListItem]) {
        self.results = results
    }
}



