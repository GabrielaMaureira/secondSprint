use pizzeriaShop

db.createCollection("pizzeria")
db.createCollection("order")
db.createCollection("client")
db.createCollection("product")

db.pizzeria.insertOne({
    id: 1,
    name: "Pizzeria X",
    address: [{
        street: "Rafael Casanova, 6", 
        floor: 1, 
        city: "Barcelona", 
        zipcode: 08186, 
        country: "Spain"
    }],
    employee: [{
        id: 1,
        name: "Paolo",
        nif: "111111S",
        phone: 222222227,
        type: [{
            job: "deliveryMan"
         }]
    }]
})
db.order.insertOne({
    id: 1,
    dateTime: Date(),
    delivery: [{
        type: "delivery"
    }],
    detailOrder: [{
        id: 1,
        productID: 1,
        quantity: 4,
    }],
    totalProducts: 4,
    totalPrice: 143.96,
    clientID: 1,
    pizzeriaID: 1,
    employeeID: 1
})

db.client.insertOne({
    id: 1,
    name: "Client X",
    lastName: "kjhb",
    phone: 123457689,
    address: [{
        street: "La Font de Sant Cristofol, 3", 
        floor: 1, 
        city: "Barcelona", 
        zipcode: 08187, 
        country: "Spain"
     }]
})
db.product.insertOne({
    id: 1,
    category: "Spicy",
    name: "Diavolo",
    description: "Pizza with spicy ingredients",
    image: File(),
    price: 35,99
})
