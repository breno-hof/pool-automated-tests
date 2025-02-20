Feature: Create Pool
	Scenario: Making a HTTP request for Pool API creates a new Pool
		Given a request with <name>, <location>, <volume>, <material>, <heating_type> and <maintenance_frequency>
		When making a POST HTTP request for Pool API
		Then should create a new Pool
		Then should delete this new Pool

		Examples:
			| name            | location                  | volume  | material     | heating_type | maintenance_frequency |
			| "Avira Kade"    | "Lisbon, Portugal"        | 1000.00 | "tile"       | "eletric"    | "weekly"              |
			| "Torin Vale"    | "Boise, Idaho"            | 2000.00 | "tile"       | "eletric"    | "biweekly"            |
			| "Lysara Wren"   | "Kyoto, Japan"            | 3000.00 | "tile"       | "eletric"    | "monthly"             |
			| "Jelrik Stone"  | "Cape Town, South Africa" | 1000.00 | "tile"       | "gas"        | "weekly"              |
			| "Cenora Bliss"  | "Montreal, Canada"        | 2000.00 | "tile"       | "gas"        | "biweekly"            |
			| "Drayce Holt"   | "Santiago, Chile"         | 3000.00 | "tile"       | "gas"        | "monthly"             |
			| "Mirene Thalor" | "Oslo, Norway"            | 4000.00 | "tile"       | "solar"      | "weekly"              |
			| "Gavix Rune"    | "Phoenix, Arizona"        | 5000.00 | "tile"       | "solar"      | "biweekly"            |
			| "Selora Faye"   | "Dublin, Ireland"         | 6000.00 | "tile"       | "solar"      | "monthly"             |
			| "Zorin Kael"    | "Mumbai, India"           | 1000.00 | "fiberglass" | "eletric"    | "weekly"              |
			| "Talyra Voss"   | "Reykjavik, Iceland"      | 2000.00 | "fiberglass" | "eletric"    | "biweekly"            |
			| "Brontis Creed" | "Melbourne, Australia"    | 3000.00 | "fiberglass" | "eletric"    | "monthly"             |
			| "Elara Quinn"   | "Barcelona, Spain"        | 1000.00 | "fiberglass" | "gas"        | "weekly"              |
			| "Rynix Slate"   | "Nairobi, Kenya"          | 2000.00 | "fiberglass" | "gas"        | "biweekly"            |
			| "Viora Lenx"    | "Seattle, Washington"     | 3000.00 | "fiberglass" | "gas"        | "monthly"             |
			| "Kaelum Drift"  | "Budapest, Hungary"       | 4000.00 | "fiberglass" | "solar"      | "weekly"              |
			| "Sypher Zane"   | "Auckland, New Zealand"   | 5000.00 | "fiberglass" | "solar"      | "biweekly"            |
			| "Nerida Vex"    | "Lima, Peru"              | 6000.00 | "fiberglass" | "solar"      | "monthly"             |
			| "Thalion Rex"   | "Stockholm, Sweden"       | 1000.00 | "vinyl"      | "eletric"    | "weekly"              |
			| "Oryna Sage"    | "Hanoi, Vietnam"          | 2000.00 | "vinyl"      | "eletric"    | "biweekly"            |
			| "Fenquar Blaze" | "Edinburgh, Scotland"     | 3000.00 | "vinyl"      | "eletric"    | "monthly"             |
			| "Lirien Moss"   | "San Diego, California"   | 1000.00 | "vinyl"      | "gas"        | "weekly"              |
			| "Xyler Thorn"   | "Athens, Greece"          | 2000.00 | "vinyl"      | "gas"        | "biweekly"            |
			| "Calista Rain"  | "Bogotá, Colombia"        | 3000.00 | "vinyl"      | "gas"        | "monthly"             |
			| "Vorin Pax"     | "Warsaw, Poland"          | 4000.00 | "vinyl"      | "solar"      | "weekly"              |
			| "Aureth Kline"  | "Tulsa, Oklahoma"         | 5000.00 | "vinyl"      | "solar"      | "biweekly"            |
			| "Zynara Cole"   | "Singapore, Singapore"    | 6000.00 | "vinyl"      | "solar"      | "monthly"             |

	Scenario: Making a HTTP request for Pool API with invalid body doesn't creates a new Pool
		Given a request with <name>, <location>, <volume>, <material>, <heating_type> and <maintenance_frequency>
		When making a POST HTTP request for Pool API
		Then shouldn't create a new Pool
		Then should return <field>, <message> and status <code>

		Examples:
			| name           | location             | volume  | material     | heating_type | maintenance_frequency | field                   | message                                                   | code |
			| ""             | "Lisbon, Portugal"   | 1000.00 | "tile"       | "eletric"    | "weekly"              | "name"                  | "Value error, Field shouldn't be empty or blank"          | 400  |
			| "Lysara Wren"  | ""                   | 3000.00 | "tile"       | "eletric"    | "monthly"             | "location"              | "Value error, Field shouldn't be empty or blank"          | 400  |
			| "Cenora Bliss" | "Montreal, Canada"   | -10.00  | "tile"       | "gas"        | "biweekly"            | "volume"                | "Value error, Field should be equal or greater than zero" | 400  |
			| "Drayce Holt"  | "Santiago, Chile"    | 0.00    | "tile"       | "gas"        | "monthly"             | "volume"                | "Value error, Field should be equal or greater than zero" | 400  |
			| "Gavix Rune"   | "Phoenix, Arizona"   | 5000.00 | ""           | "solar"      | "biweekly"            | "material"              | "Value error, Field shouldn't be empty or blank"          | 400  |
			| "Zorin Kael"   | "Mumbai, India"      | 1000.00 | "metal"      | "eletric"    | "weekly"              | "material"              | "Input should be 'tile', 'fiberglass' or 'vinyl'"         | 400  |
			| "Talyra Voss"  | "Reykjavik, Iceland" | 2000.00 | "fiberglass" | ""           | "biweekly"            | "heating_type"          | "Value error, Field shouldn't be empty or blank"          | 400  |
			| "Elara Quinn"  | "Barcelona, Spain"   | 1000.00 | "fiberglass" | "coal"       | "weekly"              | "heating_type"          | "Input should be 'eletric', 'gas' or 'solar'"             | 400  |
			| "Rynix Slate"  | "Nairobi, Kenya"     | 2000.00 | "fiberglass" | "gas"        | ""                    | "maintenance_frequency" | "Value error, Field shouldn't be empty or blank"          | 400  |
			| "Kaelum Drift" | "Budapest, Hungary"  | 4000.00 | "fiberglass" | "solar"      | "annually"            | "maintenance_frequency" | "Input should be 'weekly', 'biweekly' or 'monthly'"       | 400  |
			