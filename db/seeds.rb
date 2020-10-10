# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: "a@a",
    password: "aaaaaa"
	)

Genre.create!(
		[
			{id: "1", name: "ケーキ", is_valid: "true"},
			{id: "2", name: "焼き菓子", is_valid: "true"},
			{id: "3", name: "プリン", is_valid: "true"},
			{id: "4", name: "キャンディ", is_valid: "true"}
		]
		)

Item.create!(
	[
	  {name: "ケーキ", genre_id: "1", description: "イチゴのショートケーキです。", tax_excluded_price: "300", image: open("app/assets/images/itigo.jpg"), is_on_sale: "true"},
	  {name: "焼き菓子", genre_id: "2", description: "ビスケットです。", tax_excluded_price: "100", image: open("app/assets/images/yakigashi.jpg"), is_on_sale: "true"},
	  {name: "プリン", genre_id: "3", description: "プリンです", tax_excluded_price: "300", image: open("app/assets/images/purinn.jpg"), is_on_sale: "true"},
	  {name: "キャンディ", genre_id: "4", description: "キャンディです。", tax_excluded_price: "100", image:  open("app/assets/images/ame.jpg"), is_on_sale: "true"}
	]
	)

#image_id: open("app/assets/images/itigo.jpg")にするとinvalidIDでimage_idが存在しなくなるが
# image: open("app/assets/images/itigo.jpg")にするとエラーが無くなる
#これはattachmentで保存されているカラムがimageのため
#refileの使用上image_idではなく、imageで保存するため