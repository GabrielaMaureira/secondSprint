use pizzeriaShop

db.CreateCollection("client")
db.CreateCollection("pizzeria")
db.CreateCollection("employee")
db.CreateCollection("category")
db.CreateCollection("product")
db.CreateCollection("order")

db.client.insertOne
({
        name: "Client X",
        lastName: "kjh",
        address: [{
          street: "La font de sant cristofol, 3",
          zipCode: 08187,
          city: "Barcelona",
          country: "Spain"
        }],
        phone: 123456789
})

db.pizzeria.insertOne
({
        address: [{
          street: "Rafael Casanova, 6",
          zipcode: 08186,
          city: "Barcelona",
          country: "Spain"
        }]
      
})

db.employee.insertOne
({
        name: "Paolo",
        lastName: "Esposito",
        nif: "11111111S",
        phone: 222222227,
        type: "deliveryMan",
        pizzeriaId: ObjectId("6153d5ab7e6932a0d3c73b77")
      
})

db.category.insertOne
({
        name: "Classics"
      
})

db.product.insertOne
({
        name: "Diavolo Pizza",
        description: "Spicy ingredients",
        image: File(),
        price: 12.50,
        categoryId: ObjectId("615a6e5768d524c6a07ee2e7")
})

db.order.insertOne
({
        DateTime: Date(),
        deliveryType: "Delivery",
        clientId: ObjectId("615a6ca768d524c6a07ee2e4"),
        employeeId: ObjectId("615a6f4168d524c6a07ee2e9"),
        pizzeriaId: ObjectId("615a6d0768d524c6a07ee2e5"),
        products: [{
            productId: ObjectId("615a709d68d524c6a07ee2ea"),
            quantity: 2
        }],
        totalPrice: 25
})
  