import XCTest
import Models

final class BookListForRhymeTests: BaseTestCase {
    
    func testEncodeBookListForRhyme() throws {
        //given
        let book = Book(id: "five-little-ducks-books", title: "Five Little Ducks Went Out One Day!", author: "Margaret Bateson-Hill", coverImage: URL(string: "https://images-na.ssl-images-amazon.com/images/I/61i7xJAXwDL._SX258_BO1,204,203,200_.jpg"), urls: [URL(string: "https://www.amazon.com/Five-Little-Ducks-Went-Out/dp/1857143957")].compactMap{$0})
        let rhymeId: Rhyme.ID = "five-little-ducks"
        
        let sut = BookListForRhyme(rhymeId: rhymeId, books: [book])
        
        //when
        let data = try jsonEncoder.encode(sut)
        
        //then
        let json = String(data: data, encoding: .utf8)
        XCTAssertNotNil(json)
        XCTAssertEqual(json, bookListJSON)
    }
    
    
    func testDecodeBookListForRhyme() throws {
        //given
        guard let data = bookListJSON.data(using: .utf8) else {
            XCTFail("Can't convert json to data")
            return
        }
        
        //when
        let sut = try jsonDecoder.decode(BookListForRhyme.self, from: data)
        
        //then
        XCTAssertEqual(sut.rhymeId, "five-little-ducks")
        XCTAssertEqual(sut.books.count, 1)
        let book = sut.books[0]
        XCTAssertEqual(book.id, "five-little-ducks-books")
        XCTAssertEqual(book.title, "Five Little Ducks Went Out One Day!")
        XCTAssertEqual(book.author, "Margaret Bateson-Hill")
        XCTAssertEqual(book.coverImage, URL(string: "https://images-na.ssl-images-amazon.com/images/I/61i7xJAXwDL._SX258_BO1,204,203,200_.jpg"))
        XCTAssertEqual(book.urls.count, 1)
        let bookUrl = book.urls[0]
        XCTAssertEqual(bookUrl.absoluteString, "https://www.amazon.com/Five-Little-Ducks-Went-Out/dp/1857143957")
    }
    
    static var allTests = [
        ("testEncodeBookListForRhyme", testEncodeBookListForRhyme),
        ("testDecodeBookListForRhyme", testDecodeBookListForRhyme)
    ]
}

fileprivate let bookListJSON = #"{"books":[{"author":"Margaret Bateson-Hill","coverImage":"https:\/\/images-na.ssl-images-amazon.com\/images\/I\/61i7xJAXwDL._SX258_BO1,204,203,200_.jpg","id":"five-little-ducks-books","title":"Five Little Ducks Went Out One Day!","urls":["https:\/\/www.amazon.com\/Five-Little-Ducks-Went-Out\/dp\/1857143957"]}],"rhymeId":"five-little-ducks"}"#
