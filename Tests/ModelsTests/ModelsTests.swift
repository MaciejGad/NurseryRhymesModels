import XCTest
import Models

final class ModelsTests: XCTestCase {
    var jsonEncoder: JSONEncoder!
    var jsonDecoder: JSONDecoder!
    
    override func setUp() {
        jsonEncoder = JSONEncoder()
        if #available(iOS 11.0, *) {
            jsonEncoder.outputFormatting = [.sortedKeys]
        }
        jsonDecoder = JSONDecoder()
    }
    
    override func tearDown() {
        jsonEncoder = nil
        jsonDecoder = nil
    }
    
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
    
    func testEncodeListItem() throws {
        //given
        let rhyme = Rhyme(id: "five-little-ducks", title: "Five Little Ducks Went Swimming One Day", author: nil, text: rhymeText, image: URL(string: "https://placeducky.com/real/281/276.png"))
        
        //when
        let sut = rhyme.toListItem()
        let data = try jsonEncoder.encode(sut)
        
        //then
        XCTAssertEqual(sut.rhymeId, rhyme.id)
        XCTAssertEqual(sut.title, rhyme.title)
        XCTAssertEqual(sut.author, rhyme.author)
        XCTAssertEqual(sut.image, rhyme.image)
        
        let json = String(data: data, encoding: .utf8)
        XCTAssertNotNil(json)
        print(json!)
        XCTAssertEqual(json, listItemJSON)
    }

    func testEncodeList() throws {
        //given
        let rhyme = Rhyme(id: "five-little-ducks", title: "Five Little Ducks Went Swimming One Day", author: nil, text: rhymeText, image: URL(string: "https://placeducky.com/real/281/276.png"))
        
        //when
        let sut = List(results: [rhyme.toListItem()])
        let data = try jsonEncoder.encode(sut)
        
        //then
        let json = String(data: data, encoding: .utf8)
        XCTAssertNotNil(json)
        print(json!)
        XCTAssertEqual(json, listJSON)
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
    
    func testDecodeListItem() throws {
        //given
        guard let data = listItemJSON.data(using: .utf8) else {
            XCTFail("Can't convert json to data")
            return
        }
        
        //when
        let sut = try jsonDecoder.decode(ListItem.self, from: data)
        
        //then
        XCTAssertEqual(sut.rhymeId, "five-little-ducks")
        XCTAssertEqual(sut.title, "Five Little Ducks Went Swimming One Day")
        XCTAssertEqual(sut.image, URL(string: "https://placeducky.com/real/281/276.png"))
        XCTAssertNil(sut.author)
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
        XCTAssertEqual(listItem.rhymeId, "five-little-ducks")
        XCTAssertEqual(listItem.title, "Five Little Ducks Went Swimming One Day")
        XCTAssertEqual(listItem.image, URL(string: "https://placeducky.com/real/281/276.png"))
        XCTAssertNil(listItem.author)
    }
    
    static var allTests = [
        ("testEncodeRhyme", testEncodeRhyme),
        ("testEncodeListItem", testEncodeListItem),
        ("testEncodeList", testEncodeList),
        ("testDecodeRhyme", testDecodeRhyme),
        ("testDecodeListItem", testDecodeListItem),
        ("testDecodeList", testDecodeList)
    ]
}

fileprivate let rhymeText = """
Five little ducks went swimming one day,
Over the hills and far away,
And Mummy Duck said “Quack, quack, quack”
But only four little ducks came back.
"""

fileprivate let rhymeJSON = #"{"id":"five-little-ducks","image":"https:\/\/placeducky.com\/real\/281\/276.png","text":"Five little ducks went swimming one day,\nOver the hills and far away,\nAnd Mummy Duck said “Quack, quack, quack”\nBut only four little ducks came back.","title":"Five Little Ducks Went Swimming One Day"}"#

fileprivate let listItemJSON = #"{"image":"https:\/\/placeducky.com\/real\/281\/276.png","rhymeId":"five-little-ducks","title":"Five Little Ducks Went Swimming One Day"}"#

fileprivate let listJSON = #"{"results":[{"image":"https:\/\/placeducky.com\/real\/281\/276.png","rhymeId":"five-little-ducks","title":"Five Little Ducks Went Swimming One Day"}]}"#
