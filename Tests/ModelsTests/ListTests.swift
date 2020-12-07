import XCTest
import Models

final class ListsTests: BaseTestCase {
    
    func testEncodeList() throws {
        //given
        let rhyme = Rhyme(id: "five-little-ducks", title: "Five Little Ducks Went Swimming One Day", author: nil, text: "", image: URL(string: "https://placeducky.com/real/281/276.png"))
        
        //when
        let sut = List(results: [rhyme.toListItem()])
        let data = try jsonEncoder.encode(sut)
        
        //then
        let json = String(data: data, encoding: .utf8)
        XCTAssertNotNil(json)
        XCTAssertEqual(json, listJSON)
    }
    
    func testDecodeList() throws {
        //given
        guard let data = listJSON.data(using: .utf8) else {
            XCTFail("Can't convert json to data")
            return
        }
        
        //when
        let sut = try jsonDecoder.decode(List.self, from: data)
        
        //then
        XCTAssertEqual(sut.results.count, 1)
        let listItem = sut.results[0]
        XCTAssertEqual(listItem.id, "five-little-ducks")
        XCTAssertEqual(listItem.title, "Five Little Ducks Went Swimming One Day")
        XCTAssertEqual(listItem.image, URL(string: "https://placeducky.com/real/281/276.png"))
        XCTAssertNil(listItem.author)
    }
    
    static var allTests = [
        ("testEncodeList", testEncodeList),
        ("testDecodeList", testDecodeList)
    ]
}

fileprivate let listJSON = #"{"results":[{"id":"five-little-ducks","image":"https:\/\/placeducky.com\/real\/281\/276.png","title":"Five Little Ducks Went Swimming One Day"}]}"#
