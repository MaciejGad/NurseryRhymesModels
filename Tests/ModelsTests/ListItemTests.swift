import XCTest
import Models

final class ListItemTests: BaseTestCase {
    
    func testEncodeListItem() throws {
        //given
        let rhyme = Rhyme(id: "five-little-ducks", title: "Five Little Ducks Went Swimming One Day", author: nil, text: "", image: URL(string: "https://placeducky.com/real/281/276.png"))
        
        //when
        let sut = rhyme.toListItem()
        let data = try jsonEncoder.encode(sut)
        
        //then
        XCTAssertEqual(sut.id, rhyme.id)
        XCTAssertEqual(sut.title, rhyme.title)
        XCTAssertEqual(sut.author, rhyme.author)
        XCTAssertEqual(sut.image, rhyme.image)
        
        let json = String(data: data, encoding: .utf8)
        XCTAssertNotNil(json)
        XCTAssertEqual(json, listItemJSON)
    }

    func testDecodeListItem() throws {
        //given
        guard let data = listItemJSON.data(using: .utf8) else {
            XCTFail("Can't convert json to data")
            return
        }
        
        //when
        let sut = try jsonDecoder.decode(ListItem.self, from: data)
        
        //then
        XCTAssertEqual(sut.id, "five-little-ducks")
        XCTAssertEqual(sut.title, "Five Little Ducks Went Swimming One Day")
        XCTAssertEqual(sut.image, URL(string: "https://placeducky.com/real/281/276.png"))
        XCTAssertNil(sut.author)
    }
    
    static var allTests = [
        ("testEncodeListItem", testEncodeListItem),
        ("testDecodeListItem", testDecodeListItem),
    ]
}

fileprivate let listItemJSON = #"{"id":"five-little-ducks","image":"https:\/\/placeducky.com\/real\/281\/276.png","title":"Five Little Ducks Went Swimming One Day"}"#
