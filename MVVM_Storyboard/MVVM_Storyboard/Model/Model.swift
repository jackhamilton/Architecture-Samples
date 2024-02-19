// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let model = try Model(json)

import Foundation

// MARK: - Model
struct Model: Codable {
    let contentItems: [ContentItem]

    enum CodingKeys: String, CodingKey {
        case contentItems = "content_items"
    }
}

// MARK: Model convenience initializers and mutators

extension Model {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Model.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        contentItems: [ContentItem]? = nil
    ) -> Model {
        return Model(
            contentItems: contentItems ?? self.contentItems
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ContentItem
struct ContentItem: Codable, Identifiable {
    let id = UUID()
    let title: String?
    let imageURL: String?
    let description: String

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image_url"
        case description
    }
}

// MARK: ContentItem convenience initializers and mutators

extension ContentItem {
    init(data: Data) throws {
        let contentItem = try newJSONDecoder().decode(ContentItem.self, from: data)
        self.title = contentItem.title
        self.imageURL = contentItem.imageURL
        self.description = contentItem.description
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        title: String?? = nil,
        imageURL: String?? = nil,
        description: String? = nil
    ) -> ContentItem {
        return ContentItem(
            title: title ?? self.title,
            imageURL: imageURL ?? self.imageURL,
            description: description ?? self.description
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
