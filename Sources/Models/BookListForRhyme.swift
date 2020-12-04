import Foundation

public struct BookListForRhyme: Codable {
    public let rhymeId: Rhyme.ID
    public let books: [Book]
    
    public init(rhymeId: Rhyme.ID, books: [Book]) {
        self.rhymeId = rhymeId
        self.books = books
    }
}
