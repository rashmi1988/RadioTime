//
//  Song.swift
//  RadioTime
//
//  Created by Rashmi on 13/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

import Foundation

struct Song : Codable {
	let sid : String?
	let album : String?
	let name : String?
	let artist : String?
	let image_url : String?
	let link_url : String?
	let preview_url : String?
	let played_at : String?

	enum CodingKeys: String, CodingKey {

		case sid = "sid"
		case album = "album"
		case name = "name"
		case artist = "artist"
		case image_url = "image_url"
		case link_url = "link_url"
		case preview_url = "preview_url"
		case played_at = "played_at"
	}

	/*init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sid = try values.decodeIfPresent(String.self, forKey: .sid)
		album = try values.decodeIfPresent(String.self, forKey: .album)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		artist = try values.decodeIfPresent(String.self, forKey: .artist)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
		link_url = try values.decodeIfPresent(String.self, forKey: .link_url)
		preview_url = try values.decodeIfPresent(String.self, forKey: .preview_url)
		played_at = try values.decodeIfPresent(String.self, forKey: .played_at)
	}*/

}
