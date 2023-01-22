use optics

db.createCollection("suppliers")
db.createCollection("clients")
db.createCollection("employee")
db.createCollection("glasses")

db.suppliers.insertOne({
    id: 1,
    name: "Supplier X",
    nif: "11111111S",
    address: [{
        street: "Velazquez, 9", 
        floor: 5, 
        city: "Barcelona", 
        zipcode: 08302, 
        country: "Spain"
    }],
    contact: [{
        phone: 111111118, 
        fax: 111223345
    }],
    glasses: [{
        glassesID: 1
    }],
  })

  db.clients.insertOne({
    id: 1,
    name: "Client X",
    address: [{
        street: "Angels, 3", 
        floor: 1, 
        city: "Barcelona", 
        zipcode: 08187, 
        country: "Spain"
    }],
    mail: "xsads@gmail.com",
    registrationDate: Date(),
    referringClient: 1
  })

  db.employee.insertOne({
    id: 1,
    name: "Employee X",
    sales: [{
        glassID: 1,
        clientID: 1,
        saleDate: Date()
    }]
  })

  db.glasses.insertOne({
    id: 1,
    brand: [{
        id: 1,
        name: "Brand X"
    }],
    glassGraduation: [{
        left: 1.05,
        right: 0.5
    }],
    color: [{
        left: "pink",
        right: "white"
    }],
    glassFrame: [{
        type: "Metallic"
    }],
    price: 105.99
  })

