import Foundation

public struct Book: Codable, Identifiable {
    public let id: String
    public let title: String
    public let author: String?
    public let coverImage: URL?
    public let url: URL
    
    public init(id: Book.ID, title: String, author: String?, coverImage: URL?, url: URL) {
        self.id = id
        self.title = title
        self.author = author
        self.coverImage = coverImage
        self.url = url
    }
}
