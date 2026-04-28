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
