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
		"schedule": "weekly",
		"contact": "Chuck Kinbote",
		"facility": "biker shack",
		"func": "_2cb_op",
		"proposal_img": "res://textures/ui/biker.png",
		"icon_img": "res://textures/ui/biker_shack.png",
		"operating_cost": 3000
	},
	"rare_animals": {
		"name": "RARE ANIMAL SMUGGLING",
		"button_text": "Exotic animal smuggling ring",
		"location": "St. Petersburg, FL",
		"asset": "rare_animals",
		"rating": 4,
		"upfront": 40000,
		"income": 10000,
		"schedule": "weekly",
		"contact": "Ashley Venture",
		"facility": "mcmansion",
		"func": "_rare_animals_op",
		"proposal_img": "res://textures/ui/biker.png",
		"icon_img": "res://textures/ui/exotic_animal_ring.png",
		"operating_cost": 15000
		}
}

var canonical_banks = {
	"Franklin Credit Union": {
		"name": "Franklin Credit Union",
		"location": "Omaha, Nebraska",
		"interest": 3.14,
		"min_amount": 20000,
		"shadiness": 56.43,
		"security": 15.00,
		"offshore": false,
		"proposal_img": "res://textures/ui/bank_menu.png",
		"icon_img": "res://textures/ui/us_bank.png",
		"account_total": 0.0
	},
	"Cayman Islands Community Banking Solutions": {
		"name": "Cayman Islands Community Banking Solutions",
		"location": "George Town, Grand Cayman",
		"interest": 0.14,
		"min_amount": 200000,
		"shadiness": 10.00,
		"security": 50.00,
		"offshore": true,
		"proposal_img": "res://textures/ui/bank_menu.png",
		"icon_img": "res://textures/ui/us_bank.png",
		"account_total": 0.0
	}
}

var state = {
	"corp_name": "Z Group",
	"total_cash": 42000.00,
	"total_accounts": 00.00,
	"available_ops": {"2cb": canonical_ops["2cb"], "rare_animals": canonical_ops["rare_animals"]},
	"current_ops": [],
	"available_banks": {"Franklin Credit Union": canonical_banks["Franklin Credit Union"]},
	"current_banks": [],
	"biz": {},
	"underworld_influence": 12,
	"mode": "look",
	"place_cache": []
}
