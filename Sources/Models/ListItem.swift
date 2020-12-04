import Foundation

public struct ListItem: Codable {
    public let rhymeId: Rhyme.ID
    public let title: String
    public let image: URL?
    public let author: String?
}
