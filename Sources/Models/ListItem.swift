import Foundation

public struct ListItem: Codable, Identifiable {
    public let id: Rhyme.ID
    public let title: String
    public let image: URL?
    public let author: String?
}
