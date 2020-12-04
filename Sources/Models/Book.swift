import Foundation

public struct Book: Codable, Identifiable {
    public let id: String
    public let title: String
    public let author: String?
    public let coverImage: URL?
    public let urls: [URL]
    
    public init(id: Book.ID, title: String, author: String?, coverImage: URL?, urls: [URL]) {
        self.id = id
        self.title = title
        self.author = author
        self.coverImage = coverImage
        self.urls = urls
    }
}
