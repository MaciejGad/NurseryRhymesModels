import XCTest
import Models

final class BookTests: BaseTestCase {

    func testEncodeBook() throws {
        //given
        let sut = Book(id: "five-little-ducks-books", title: "Five Little Ducks Went Out One Day!", author: "Margaret Bateson-Hill", coverImage: URL(string: "https://images-na.ssl-images-amazon.com/images/I/61i7xJAXwDL._SX258_BO1,204,203,200_.jpg"), url: URL(string: "https://www.amazon.com/Five-Little-Ducks-Went-Out/dp/1857143957")!)
        
        //when
        let data = try jsonEncoder.encode(sut)
        
        //then
        let json = String(data: data, encoding: .utf8)
        XCTAssertNotNil(json)
        XCTAssertEqual(json, bookJSON)
    }
    
    func testDecodeBook() throws {
        //given
        guard let data = bookJSON.data(using: .utf8) else {
            XCTFail("Can't convert json to data")
            return
        }
        
        //when
        let sut = try jsonDecoder.decode(Book.self, from: data)
        
        //then
        XCTAssertEqual(sut.id, "five-little-ducks-books")
        XCTAssertEqual(sut.title, "Five Little Ducks Went Out One Day!")
        XCTAssertEqual(sut.author, "Margaret Bateson-Hill")
        XCTAssertEqual(sut.coverImage, URL(string: "https://images-na.ssl-images-amazon.com/images/I/61i7xJAXwDL._SX258_BO1,204,203,200_.jpg"))
        XCTAssertEqual(sut.url.absoluteString, "https://www.amazon.com/Five-Little-Ducks-Went-Out/dp/1857143957")
    }
    
    static var allTests = [
        ("testEncodeBook", testEncodeBook),
        ("testDecodeBook", testDecodeBook),
    ]
}

fileprivate let bookJSON = #"{"author":"Margaret Bateson-Hill","coverImage":"https:\/\/images-na.ssl-images-amazon.com\/images\/I\/61i7xJAXwDL._SX258_BO1,204,203,200_.jpg","id":"five-little-ducks-books","title":"Five Little Ducks Went Out One Day!","url":"https:\/\/www.amazon.com\/Five-Little-Ducks-Went-Out\/dp\/1857143957"}"#
