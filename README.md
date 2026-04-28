## ⚙️ Setup Instructions

### 1. Clone Repository

```
git clone https://github.com/YOUR_USERNAME/bazaarx.git
cd bazaarx
```

---

### 2. Install Dependencies

```
npm install
```

---

### 3. Setup MySQL Database

Make sure MySQL is installed and running.

#### Step 1: Create Database

```
CREATE DATABASE bazaarx;
USE bazaarx;
```

#### Step 2: Import SQL File

A pre-built SQL file is provided in the project:

```
/database/bazaarx.sql
```

Import it using:

**Option A (MySQL Workbench):**

* Go to *Server → Data Import*
* Select `bazaarx.sql`
* Execute

**Option B (Command Line):**

```
mysql -u root -p bazaarx < database/bazaarx.sql
```

---

### 4. Configure Database Connection

Open `server.js` and update:

```
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'YOUR_PASSWORD',
  database: 'bazaarx'
});
```

---

### 5. Run Server

```
node server.js
```

Server will start at:

```
http://localhost:3000
```

---

### 6. Open Frontend

Open `index.html` in your browser.

---

## 🔑 Admin Login

```
Email: admin@bazaarx.com
Password: admin123
```
# 🛒 BazaarX – Full Stack E-Commerce Web App

BazaarX is a modern full-stack e-commerce platform built with a focus on clean UI, real-time data handling, and admin control. It supports product browsing, cart management, authentication, and an admin dashboard.

---

## 🚀 Features

### 🛍️ User Side

* Browse products by category
* Search and sort functionality
* Add to cart (with quantity management)
* Real-time cart updates
* Order placement
* User authentication (Login/Register)

### 👨‍💼 Admin Panel

* Add new products
* Update product details
* Delete products
* View total users, orders, and revenue

---

## 🧱 Tech Stack

### Frontend

* HTML5
* CSS3 (Modern UI with animations)
* JavaScript (Vanilla)

### Backend

* Node.js
* Express.js

### Database

* MySQL

---

## 📂 Project Structure

```
bazaarx/
│
├── server.js          # Backend server (Express + MySQL)
├── index.html         # Frontend UI
├── style.css         
├── script.js          
└── README.md
```

---

## ⚙️ Setup Instructions

### 1. Clone Repository

```
git clone https://github.com/YOUR_USERNAME/bazaarx.git
cd bazaarx
```

### 2. Install Dependencies

```
npm install
```

### 3. Setup MySQL Database

Create database:

```
CREATE DATABASE bazaarx;
```

Create tables:

* users
* products
* cart
* orders

(Use your SQL schema here)

---

### 4. Run Server

```
node server.js
```

Server runs on:

```
http://localhost:3000
```

---

## 🔑 Admin Credentials

```
Email: admin@bazaarx.com
Password: admin123
```

---

## 🖼️ Image Handling

* Product images are stored as URLs in the database
* Admin can upload image links while adding products

---

## 🧠 Key Concepts Used

* REST APIs
* CRUD operations
* MySQL joins (cart + products)
* State handling (frontend)
* Authentication logic
* Dynamic rendering

---

## 🚧 Future Improvements

* Image upload (Cloudinary / Firebase)
* Payment gateway integration
* JWT Authentication
* Order history page
* Responsive mobile optimization

---

## 📸 Screenshots
<img width="1919" height="990" alt="image" src="https://github.com/user-attachments/assets/208518b4-ba87-45a0-9375-cd79b0bfd858" />
---
<img width="1919" height="986" alt="image" src="https://github.com/user-attachments/assets/b427e7a6-c9de-4e63-9739-707f268ab773" />



---

## 👩‍💻 Author

**Meenakshi Kothawade**
Computer Engineering Student
Bharati Vidyapeeth, Pune

---

## ⭐ If you like this project

Give it a star on GitHub ⭐

