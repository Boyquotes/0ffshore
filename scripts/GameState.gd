extends Control

#
# CANONICAL DATA SHAPES FOR GAME CONCEPTS
# These are the defaults for operations,
# banks, businesses, contacts, and facilities 
#
var canonical_ops = {
	"2cb": {
		"name": "2CB SYNTH LAB",
		"button_text": "2CB synth lab",
		"location": "Shasta, CA",
		"asset": "2cb",
		"rating": 2,
		"upfront": 25000,
		"income": 2000,
		"schedule": "daily",
		"contact": "Chuck Kinbote",
		"facility": "biker shack"
	},
	"rare_animals": {
		"name": "RARE ANIMAL SMUGGLING",
		"button_text": "Exotic animal smuggling ring",
		"location": "St. Petersburg, FL",
		"asset": "animals",
		"rating": 4,
		"upfront": 40000,
		"income": 10000,
		"schedule": "weekly",
		"contact": "Ashley Venture",
		"facility": "mcmansion"
	},
}

var canonical_banks = {
	"Franklin Credit Union": {
		"interest": 3.14,
		"min_amount": 20000,
		"shadiness": 56.43,
		"security": 15.00,
		"offshore": false,
		"amount": 0.0
	},
	"Cayman Islands Community Banking Solutions": {
		"interest": 0.14,
		"min_amount": 200000,
		"shadiness": 10.00,
		"security": 50.00,
		"offshore": true,
		"amount": 0.0
	}
}

var state = {
	"corp_name": "Z Group",
	"total_cash": 42000.00,
	"total_accounts": 00.00,
	"ops": {"2cb": canonical_ops["2cb"], "rare_animals": canonical_ops["rare_animals"]},
	"banks": {},
	"biz": {}
}
