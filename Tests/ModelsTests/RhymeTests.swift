import XCTest
import Models

final class RhymeTests: BaseTestCase {
    
    func testEncodeRhyme() throws {
        //given
        let sut = Rhyme(id: "five-little-ducks", title: "Five Little Ducks Went Swimming One Day", author: nil, text: rhymeText, image: URL(string: "https://placeducky.com/real/281/276.png"))
       
        //when
        let data = try jsonEncoder.encode(sut)
        
        //then
        let json = String(data: data, encoding: .utf8)
        XCTAssertNotNil(json)
        XCTAssertEqual(json, rhymeJSON)
    }
    
    func testDecodeRhyme() throws {
        //given
        guard let data = rhymeJSON.data(using: .utf8) else {
            XCTFail("Can't convert json to data")
            return
        }
        
        //when
        let sut = try jsonDecoder.decode(Rhyme.self, from: data)
        
        //then
        XCTAssertEqual(sut.id, "five-little-ducks")
        XCTAssertEqual(sut.title, "Five Little Ducks Went Swimming One Day")
        XCTAssertEqual(sut.text, rhymeText)
        XCTAssertEqual(sut.image, URL(string: "https://placeducky.com/real/281/276.png"))
        XCTAssertNil(sut.author)
    }
    
    static var allTests = [
        ("testEncodeRhyme", testEncodeRhyme),
        ("testDecodeRhyme", testDecodeRhyme),
    ]
}

fileprivate let rhymeText = """
Five little ducks went swimming one day,
Over the hills and far away,
And Mummy Duck said “Quack, quack, quack”
But only four little ducks came back.
"""

fileprivate let rhymeJSON = #"{"id":"five-little-ducks","image":"https:\/\/placeducky.com\/real\/281\/276.png","text":"Five little ducks went swimming one day,\nOver the hills and far away,\nAnd Mummy Duck said “Quack, quack, quack”\nBut only four little ducks came back.","title":"Five Little Ducks Went Swimming One Day"}"#
