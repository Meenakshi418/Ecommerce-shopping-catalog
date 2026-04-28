const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'cn29^bs4!$&sdjk',
  database: 'bazaarx'
});

db.connect(err => {
  if (err) throw err;
  console.log("✅ DB Connected");
});

let users = [
  {
    id: 1,
    name: "Admin",
    email: "admin@bazaarx.com",
    password: "admin123",
    role: "admin"
  }
];

/* ========= PRODUCTS ========= */

// GET
app.get('/products', (req, res) => {
  db.query('SELECT * FROM products', (err, result) => {
    if (err) throw err;
    res.json(result);
  });
});

// ADD
// app.post('/products', (req, res) => {
//   const { name, category, price, stock, description } = req.body;

//   db.query(
//     'INSERT INTO products (name, category, price, stock, description) VALUES (?, ?, ?, ?, ?)',
//     [name, category, price, stock, description],
//     (err) => {
//       if (err) throw err;
//       res.send("Added");
//     }
//   );
// });

// DELETE
app.delete('/products/:id', (req, res) => {
  db.query('DELETE FROM products WHERE id=?', [req.params.id], (err) => {
    if (err) throw err;
    res.send("Deleted");
  });
});

/* ========= AUTH ========= */

app.post('/register', (req, res) => {
  const { name, email, password } = req.body;

  db.query(
    'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
    [name, email, password],
    (err) => {
      if (err) return res.status(400).send("User exists");
      res.send("Registered");
    }
  );
});

app.post('/login', (req, res) => {
  const { email, password } = req.body;

  db.query(
    'SELECT * FROM users WHERE email=? AND password=?',
    [email, password],
    (err, result) => {
      if (err) throw err;

      if (result.length > 0) res.json(result[0]);
      else res.status(401).send("Invalid");
    }
  );
});

/* ========= ORDER ========= */

app.post('/order', (req, res) => {
  const { user_id, total } = req.body;

  db.query(
    'INSERT INTO orders (user_id, total) VALUES (?, ?)',
    [user_id, total],
    (err) => {
      if (err) throw err;
      res.send("Order placed");
    }
  );
});

app.listen(3000, () => console.log("🚀 Running on 3000"));

/* ========= ADMIN ========= */
// ADD PRODUCT FROM ADMIN
app.post('/products', (req, res) => {
  const { name, category, price, stock, description, image } = req.body;

  const sql = `
    INSERT INTO products (name, category, price, stock, description, image)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  db.query(
    sql,
    [name, category, price, stock, description, image],
    (err) => {
      if (err) {
        console.log("❌ DB ERROR:", err);
        return res.status(500).send("Error adding product");
      }
      res.send("Product added");
    }
  );
});

// DELETE PRODUCT FROM ADMIN
app.delete('/products/:id', (req, res) => {
  db.query('DELETE FROM products WHERE id=?', [req.params.id], (err) => {
    if (err) return res.status(500).send(err);
    res.send("Deleted");
  });
});

// UPDATE PRODUCT FROM ADMIN
app.put('/products/:id', (req, res) => {
  const id = req.params.id;

  const { name, category, price, stock, description, rating, discount } = req.body;

  const sql = `
    UPDATE products 
    SET name=?, category=?, price=?, stock=?, description=?, rating=?, discount=?
    WHERE id=?
  `;

  db.query(
    sql,
    [name, category, price, stock, description, rating, discount, id],
    (err, result) => {
      if (err) return res.status(500).send(err);
      res.send('Updated successfully');
    }
  );
});

// GET USERS COUNT
app.get('/users', (req, res) => {
  db.query('SELECT COUNT(*) as count FROM users', (err, result) => {
    if (err) throw err;
    res.json(result[0]);
  });
});

// GET ORDERS + REVENUE
app.get('/orders', (req, res) => {
  db.query('SELECT COUNT(*) as count, SUM(total) as revenue FROM orders', (err, result) => {
    if (err) throw err;
    res.json(result[0]);
  });
});

/* ========= CART ========= */
// ADD TO CART
app.post('/cart', (req, res) => {
  const { user_id, product_id } = req.body;

  const sql = `
    INSERT INTO cart (user_id, product_id, quantity)
    VALUES (?, ?, 1)
    ON DUPLICATE KEY UPDATE quantity = quantity + 1
  `;

  db.query(sql, [user_id, product_id], (err) => {
    if (err) return res.status(500).send(err);
    res.send("Added to cart");
  });
});

// GET CART 
app.get('/cart/:user_id', (req, res) => {
  const sql = `
    SELECT c.quantity, p.*
    FROM cart c
    JOIN products p ON c.product_id = p.id
    WHERE c.user_id = ?
  `;

  db.query(sql, [req.params.user_id], (err, result) => {
    if (err) return res.status(500).send(err);
    res.json(result);
  });
});

// DELETE FROM CART
app.delete('/cart/:user_id/:product_id', (req, res) => {
  db.query(
    'DELETE FROM cart WHERE user_id=? AND product_id=?',
    [req.params.user_id, req.params.product_id],
    (err) => {
      if (err) return res.status(500).send(err);
      res.send("Removed");
    }
  );
});
