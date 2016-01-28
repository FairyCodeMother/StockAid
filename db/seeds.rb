# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: "Chicago" }, { name: "Copenhagen" }])
#   Mayor.create(name: "Emanuel", city: cities.first)

org_stanford = Organization.create(name: "Stanford Hospital", address: "300 Pasteur Drive, Stanford, CA 94305",
                                   phone_number: "(650) 723–4000", email: "info@stanfordhospital.com")
org_kaiser   = Organization.create(name: "Kaiser Permanente Mountain View",
                                   address: "555 Castro St, Mountain View, CA 94041",
                                   phone_number: "(650) 903-3000", email: "info@kaisermountview.com")
org_alameda  = Organization.create(name: "Alameda Hospital", address: "2070 Clinton Ave, Alameda, CA 94501",
                                   phone_number: "(510) 522-3700", email: "info@alamedaahs.org")

user1 = User.create(email: "dinsdalep@fake.com", password: "password")

category_adult_underwear = Category.create(description: "Adult's Underwear")
category_kids_underwear = Category.create(description: "Kids' Underwear")
category_socks = Category.create(description: "Socks")
category_adult_shirts = Category.create(description: "Adults' Shirts")
category_kids_shirts = Category.create(description: "Kids' Shirts")
category_sweaters = Category.create(description: "Sweatshirts/Sweaters")
category_sweatsuits = Category.create(description: "Sweat Suits")
category_pants = Category.create(description: "Pants")
category_shoes = Category.create(description: "Flip-Flops/Slippers")
category_misc = Category.create(description: "Miscellaneous")

Item.create([
              { description: "Women - Underwear - XS (5)", category_id: category_adult_underwear.id },
              { description: "Women - Underwear - S (6)", category_id: category_adult_underwear.id },
              { description: "Women - Underwear - M (7)", category_id: category_adult_underwear.id },
              { description: "Women - Underwear - L (8)", category_id: category_adult_underwear.id },
              { description: "Women - Underwear - 1X (9)", category_id: category_adult_underwear.id },
              { description: "Women - Underwear - 2X (10)", category_id: category_adult_underwear.id },
              { description: "Women - Underwear - 3X (11)", category_id: category_adult_underwear.id },
              { description: "Women - Underwear - 4X (12)", category_id: category_adult_underwear.id },
              { description: "Women - Bra - S (32)", category_id: category_adult_underwear.id },
              { description: "Women - Bra - M (34)", category_id: category_adult_underwear.id },
              { description: "Women - Bra - L (36)", category_id: category_adult_underwear.id },
              { description: "Women - Bra - 1X (38)", category_id: category_adult_underwear.id },
              { description: "Women - Bra - 2L (40-42)", category_id: category_adult_underwear.id },
              { description: "Women - Bra - 3X (44)", category_id: category_adult_underwear.id },
              { description: "Women - Bra - 4X", category_id: category_adult_underwear.id },
              { description: "Men - Underwear – XS (28-30)", category_id: category_adult_underwear.id },
              { description: "Men - Underwear- S (32-33)", category_id: category_adult_underwear.id },
              { description: "Men - Underwear – M (34-36)", category_id: category_adult_underwear.id },
              { description: "Men - Underwear - L (38-40)", category_id: category_adult_underwear.id },
              { description: "Men - Underwear – 1X (40-42)", category_id: category_adult_underwear.id },

              { description: "Girls - Underwear – (2-3)", category_id: category_kids_underwear.id },
              { description: "Girls - Underwear – (4-5)", category_id: category_kids_underwear.id },
              { description: "Girls - Underwear – (6)", category_id: category_kids_underwear.id },
              { description: "Girls - Underwear – (7-8)", category_id: category_kids_underwear.id },
              { description: "Girls - Underwear – (10-12)", category_id: category_kids_underwear.id },
              { description: "Girls - Underwear – (14)", category_id: category_kids_underwear.id },
              { description: "Girls - Underwear – (16)", category_id: category_kids_underwear.id },
              { description: "Boys - Underwear - XXS (2-3T)", category_id: category_kids_underwear.id },
              { description: "Boys - Underwear - XS (4-5)", category_id: category_kids_underwear.id },
              { description: "Boys - Underwear - S", category_id: category_kids_underwear.id },
              { description: "Boys - Underwear - M", category_id: category_kids_underwear.id },
              { description: "Boys - Underwear - L", category_id: category_kids_underwear.id },
              { description: "Boys - Underwear - XL", category_id: category_kids_underwear.id },

              { description: "Women - Socks", category_id: category_socks.id },
              { description: "Men - Socks", category_id: category_socks.id },
              { description: "\"Cozy\" (winter) Socks", category_id: category_socks.id },
              { description: "Girls - Socks", category_id: category_socks.id },
              { description: "Boys - Socks", category_id: category_socks.id },

              { description: "Women - Shirt - XS", category_id: category_adult_shirts.id },
              { description: "Women - Shirt - S", category_id: category_adult_shirts.id },
              { description: "Women - Shirt - M", category_id: category_adult_shirts.id },
              { description: "Women - Shirt - L", category_id: category_adult_shirts.id },
              { description: "Women - Shirt - 1X", category_id: category_adult_shirts.id },
              { description: "Women - Shirt - 2X", category_id: category_adult_shirts.id },
              { description: "Women - Shirt - 3X", category_id: category_adult_shirts.id },
              { description: "Women - Shirt - 4X", category_id: category_adult_shirts.id },
              { description: "Adult - Shirt - S", category_id: category_adult_shirts.id },
              { description: "Adult - Shirt - M", category_id: category_adult_shirts.id },
              { description: "Adult - Shirt - L", category_id: category_adult_shirts.id },
              { description: "Adult - Shirt - 1X", category_id: category_adult_shirts.id },
              { description: "Adult - Shirt - 2X", category_id: category_adult_shirts.id },
              { description: "Adult - Shirt - 3X", category_id: category_adult_shirts.id },
              { description: "Adult - Shirt - 4X", category_id: category_adult_shirts.id },

              { description: "Youth - Shirt - XS", category_id: category_kids_shirts.id },
              { description: "Youth - Shirt - S", category_id: category_kids_shirts.id },
              { description: "Youth - Shirt - M", category_id: category_kids_shirts.id },
              { description: "Youth - Shirt - L", category_id: category_kids_shirts.id },
              { description: "Youth - Shirt - 1X", category_id: category_kids_shirts.id },
              { description: "Kids - Shirt - 4T", category_id: category_kids_shirts.id },
              { description: "Kids - Shirt - 5T", category_id: category_kids_shirts.id },
              { description: "Kids - Shirt - XS", category_id: category_kids_shirts.id },
              { description: "Kids - Shirt - S", category_id: category_kids_shirts.id },
              { description: "Kids - Shirt - M", category_id: category_kids_shirts.id },
              { description: "Kids - Shirt – L", category_id: category_kids_shirts.id },
              { description: "Kids - Shirt – 1X", category_id: category_kids_shirts.id },

              { description: "Adult - Sweatshirt/Sweater - XS", category_id: category_sweaters.id },
              { description: "Adult - Sweatshirt/Sweater - S", category_id: category_sweaters.id },
              { description: "Adult - Sweatshirt/Sweater - M", category_id: category_sweaters.id },
              { description: "Adult - Sweatshirt/Sweater - L", category_id: category_sweaters.id },
              { description: "Adult - Sweatshirt/Sweater - 1X", category_id: category_sweaters.id },
              { description: "Adult - Sweatshirt/Sweater - 2X", category_id: category_sweaters.id },
              { description: "Kids - Sweatshirt/Sweater - 4T", category_id: category_sweaters.id },
              { description: "Kids - Sweatshirt/Sweater - XS", category_id: category_sweaters.id },
              { description: "Kids - Sweatshirt/Sweater - S", category_id: category_sweaters.id },
              { description: "Kids - Sweatshirt/Sweater - M", category_id: category_sweaters.id },
              { description: "Kids - Sweatshirt/Sweater - L", category_id: category_sweaters.id },
              { description: "Kids - Sweatshirt/Sweater - 1X", category_id: category_sweaters.id },

              { description: "Adult - Sweat Suit - S", category_id: category_sweatsuits.id },
              { description: "Adult - Sweat Suit - M", category_id: category_sweatsuits.id },
              { description: "Adult - Sweat Suit - L", category_id: category_sweatsuits.id },
              { description: "Adult - Sweat Suit - 1X", category_id: category_sweatsuits.id },
              { description: "Adult - Sweat Suit - 2X", category_id: category_sweatsuits.id },
              { description: "Adult - Sweat Suit - 3X", category_id: category_sweatsuits.id },
              { description: "Adult - Sweat Suit - 4X", category_id: category_sweatsuits.id },
              { description: "Kids - Sweat Suit - XXS (2-3)", category_id: category_sweatsuits.id },
              { description: "Kids - Sweat Suit - XS (4-5)", category_id: category_sweatsuits.id },
              { description: "Kids - Sweat Suit - S (6-7)", category_id: category_sweatsuits.id },
              { description: "Kids - Sweat Suit - M (8-11)", category_id: category_sweatsuits.id },
              { description: "Kids - Sweat Suit - L (12-13)", category_id: category_sweatsuits.id },
              { description: "Kids - Sweat Suit - 1X (14-16)", category_id: category_sweatsuits.id },

              { description: "Adult - Pants - XS", category_id: category_pants.id },
              { description: "Adult - Pants - S", category_id: category_pants.id },
              { description: "Adult - Pants - M", category_id: category_pants.id },
              { description: "Adult - Pants - L", category_id: category_pants.id },
              { description: "Adult - Pants - 1X", category_id: category_pants.id },
              { description: "Adult - Pants - 2X", category_id: category_pants.id },
              { description: "Adult - Pants - 3X", category_id: category_pants.id },
              { description: "Adult - Pants - 4X", category_id: category_pants.id },
              { description: "Kids - Pants - XS", category_id: category_pants.id },
              { description: "Kids - Pants - S", category_id: category_pants.id },
              { description: "Kids - Pants - M", category_id: category_pants.id },
              { description: "Kids - Pants - L", category_id: category_pants.id },
              { description: "Kids - Pants - 1X", category_id: category_pants.id },
              { description: "Adult - Leggings (One Size Fits All)", category_id: category_pants.id },

              { description: "Adult - Flip-flops - XXS", category_id: category_shoes.id },
              { description: "Adult - Flip-flops - XS", category_id: category_shoes.id },
              { description: "Adult - Flip-flops - S (6-7)", category_id: category_shoes.id },
              { description: "Adult - Flip-flops - M (7-8)", category_id: category_shoes.id },
              { description: "Adult - Flip-flops - L (9-10)", category_id: category_shoes.id },
              { description: "Adult - Flip-flops - 1X (11-12)", category_id: category_shoes.id },
              { description: "Kids - Flip-flops - XS (4-5)", category_id: category_shoes.id },
              { description: "Kids - Flip-flops - S (6-7)", category_id: category_shoes.id },
              { description: "Kids - Flip-flops - M (7-8)", category_id: category_shoes.id },
              { description: "Kids - Flip-flops - L (9-10)", category_id: category_shoes.id },
              { description: "Kids - Flip-flops - 1X (11-12)", category_id: category_shoes.id },
              { description: "Adult - Slippers - S (5-6)", category_id: category_shoes.id },
              { description: "Adult - Slippers - M (7-8)", category_id: category_shoes.id },
              { description: "Adult - Slippers - L (9-10)", category_id: category_shoes.id },
              { description: "Adult - Slippers - 1X", category_id: category_shoes.id },

              { description: "Blanket", category_id: category_misc.id },
              { description: "Hat", category_id: category_misc.id },
              { description: "Gloves", category_id: category_misc.id },
              { description: "Scarf", category_id: category_misc.id },
              { description: "Tote", category_id: category_misc.id },
              { description: "Journal", category_id: category_misc.id },
              { description: "Book", category_id: category_misc.id },
              { description: "Dollar Tree Card", category_id: category_misc.id },
              { description: "Tooth Brush", category_id: category_misc.id },
              { description: "Toothpaste", category_id: category_misc.id },
              { description: "Dental Floss", category_id: category_misc.id },
              { description: "Stuffed Animal", category_id: category_misc.id },
              { description: "DVD", category_id: category_misc.id },
              { description: "Comb", category_id: category_misc.id },
              { description: "$5.00 Gift Card", category_id: category_misc.id },
              { description: "Other", category_id: category_misc.id }
            ])

Order.create([
               { organization_id: org_kaiser.id, user_id: user1.id, order_date: "2016-01-27", status: "pending" },
               { organization_id: org_alameda.id, user_id: user1.id, order_date: "2016-01-26", status: "approved" },
               { organization_id: org_stanford.id, user_id: user1.id, order_date: "2016-01-25", status: "shipped" },
               { organization_id: org_alameda.id, user_id: user1.id, order_date: "2016-01-22", status: "filled" }
             ])
