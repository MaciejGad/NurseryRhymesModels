import Foundation

public struct Rhyme: Codable, Identifiable {
    public let id: String
    public let title: String
    public let author: String?
    public let text: String
    public let image: URL?
    
    public init(id: Rhyme.ID, title: String, author: String?, text: String, image: URL?) {
        self.id = id
        self.title = title
        self.author = author
        self.text = text
        self.image = image
    }
}

extension Rhyme {
    public func toListItem() -> ListItem {
        ListItem(rhymeId: id, title: title, image: image, author: author)
    }
}
