// =================== DATA ===================
const CATEGORIES = ['Electronics','Clothing','Books','Home & Kitchen','Sports','Beauty'];
 
const EMOJIS = {
  'Electronics':'📱','Clothing':'👕','Books':'📚',
  'Home & Kitchen':'🍳','Sports':'⚽','Beauty':'💄'
};
 
let products = [];

let currentUser = null;
let currentProduct = null;
let selectedCat = 'All';
let orders = [];
 
// =================== AUTH ===================
function switchAuth(tab) {
  document.querySelectorAll('.auth-tab').forEach((t,i) => t.classList.toggle('active', (i===0&&tab==='login')||(i===1&&tab==='register')));
  document.getElementById('loginForm').style.display = tab==='login'?'flex':'none';
  document.getElementById('registerForm').style.display = tab==='register'?'flex':'none';
}
 
async function login() {
  const email = document.getElementById('loginEmail').value;
  const pass = document.getElementById('loginPass').value;

  const res = await fetch('http://localhost:3000/login', {
    method:'POST',
    headers:{'Content-Type':'application/json'},
    body: JSON.stringify({ email, password: pass })
  });

  if (res.ok) {
    currentUser = await res.json();
    updateUserUI();
    showPage('home');
    showToast("Welcome!", "success");
  } else {
    showToast("Invalid credentials", "error");
  }
}
 
async function register() {
  const name = document.getElementById('regName').value;
  const email = document.getElementById('regEmail').value;
  const pass = document.getElementById('regPass').value;

  const res = await fetch('http://localhost:3000/register', {
    method:'POST',
    headers:{'Content-Type':'application/json'},
    body: JSON.stringify({ name, email, password: pass })
  });

  if (res.ok) {
    showToast("Registered!", "success");
  } else {
    showToast("User exists", "error");
  }
}
 
function updateUserUI() {
  const pill = document.getElementById('userPill');
  if (currentUser) {
    pill.innerHTML = `<span>${currentUser.name}</span> ${currentUser.role==='admin'?'👑':''} · <span style="color:var(--danger);cursor:pointer" onclick="logout()">Out</span>`;
    document.getElementById('adminNavBtn').style.display = currentUser.role==='admin'?'block':'none';
  } else {
    pill.innerHTML = 'Sign In';
    document.getElementById('adminNavBtn').style.display='none';
  }
}
 
function logout() {
  currentUser = null;
  cart = [];

  updateUserUI();
  updateCartCount();
  renderCart();   
}
 
// =================== PRODUCTS ===================
function getEmoji(cat) { return EMOJIS[cat]||'🛍️'; }
 
function productCard(p, showNew=false) {
  const discPrice = Math.round(p.price * (1 - p.discount/100));
  const outOfStock = p.stock === 0;
  return `
    <div class="product-card" onclick="openModal(${p.id})">
      <div class="product-img">
        ${p.image 
          ? `<img src="${p.image}" style="width:100%;height:100%;object-fit:cover;">`
          : getEmoji(p.cat)}
        ${outOfStock ? '<span class="product-badge out">Out of Stock</span>' : (p.discount>0?`<span class="product-badge">${p.discount}% OFF</span>`:'')}
      </div>
      <div class="product-info">
        <div class="product-cat">${p.cat}</div>
        <div class="product-name">${p.name}${showNew?'<span class="tag-new">NEW</span>':''}</div>
        <div class="product-price">
          ₹${discPrice.toLocaleString('en-IN')}
          ${p.discount>0?`<span class="original">₹${p.price.toLocaleString('en-IN')}</span>`:''}
        </div>
        <div class="product-footer">
          <span class="product-rating">★ ${p.rating}</span>
          <button class="add-btn" ${outOfStock?'disabled':''} onclick="event.stopPropagation();addToCart(${p.id})">
            ${outOfStock?'Sold Out':'Add +'}
          </button>
        </div>
      </div>
    </div>`;
}
 
function renderTrending() {
  const trending = products.filter(p=>p.rating>=4.6).slice(0,8);
  document.getElementById('trendingGrid').innerHTML = trending.map(p=>productCard(p)).join('');
}
 
function renderCatalog() {
  let filtered = [...products];
  const q = document.getElementById('searchInput').value.toLowerCase();
  const sort = document.getElementById('sortSelect').value;
  if (selectedCat !== 'All') filtered = filtered.filter(p=>p.cat===selectedCat);
  if (q) filtered = filtered.filter(p=>p.name.toLowerCase().includes(q)||p.cat.toLowerCase().includes(q));
  if (sort==='price-asc') filtered.sort((a,b)=>a.price-b.price);
  else if (sort==='price-desc') filtered.sort((a,b)=>b.price-a.price);
  else if (sort==='name') filtered.sort((a,b)=>a.name.localeCompare(b.name));
  document.getElementById('productCount').textContent = `${filtered.length} products`;
  document.getElementById('catalogGrid').innerHTML = filtered.length ? filtered.map(p=>productCard(p)).join('') : '<div class="empty-state"><span class="emoji">🔍</span><p>No products found</p></div>';
}
 
function renderCatFilter() {
  const cats = ['All', ...CATEGORIES];
  document.getElementById('catFilter').innerHTML = cats.map(c=>`
    <div class="cat-chip ${selectedCat===c?'active':''}" onclick="selectCat('${c}')">${getEmoji(c)||'🛍️'} ${c}</div>
  `).join('');
}
 
function selectCat(cat) {
  selectedCat = cat;
  renderCatFilter();
  renderCatalog();
}
 
function filterProducts() { renderCatalog(); }
 
// =================== MODAL ===================
function openModal(id) {
  currentProduct = products.find(p=>p.id===id);
  if (!currentProduct) return;
  const p = currentProduct;
  const discPrice = Math.round(p.price*(1-p.discount/100));
  document.getElementById('modalImg').innerHTML = p.image
    ? `<img src="${p.image}" style="width:100%;height:100%;object-fit:cover;">`
    : getEmoji(p.cat);
  document.getElementById('modalCat').textContent = p.cat;
  document.getElementById('modalName').textContent = p.name;
  document.getElementById('modalPrice').innerHTML = `₹${discPrice.toLocaleString('en-IN')} ${p.discount>0?`<span style="font-size:1rem;color:var(--muted);text-decoration:line-through;font-weight:400">₹${p.price.toLocaleString('en-IN')}</span>`:''}`;
  document.getElementById('modalDesc').textContent = p.desc;
  document.getElementById('modalMeta').innerHTML = `
    <div class="meta-tag">Rating: <span>★ ${p.rating}</span></div>
    <div class="meta-tag">Stock: <span>${p.stock}</span></div>
    <div class="meta-tag">Category: <span>${p.cat}</span></div>
  `;
  document.getElementById('modalQty').textContent = '1';
  document.getElementById('modalAddBtn').disabled = p.stock===0;
  document.getElementById('modalAddBtn').textContent = p.stock===0?'Out of Stock':'Add to Cart';
  document.getElementById('productModal').classList.add('open');
}
 
function closeModal(e) { if(e.target===document.getElementById('productModal')) closeModalDirect(); }
function closeModalDirect() { document.getElementById('productModal').classList.remove('open'); }
 
function changeQty(d) {
  const el = document.getElementById('modalQty');
  const val = Math.max(1, Math.min(currentProduct.stock, parseInt(el.textContent)+d));
  el.textContent = val;
}
 
function addModalToCart() {
  const qty = parseInt(document.getElementById('modalQty').textContent);
  for(let i=0;i<qty;i++) addToCart(currentProduct.id);
  closeModalDirect();
}
 
// =================== CART ===================
async function addToCart(id) {
  if (!currentUser) {
    showToast("Login first", "error");
    return;
  }

  await fetch('http://localhost:3000/cart', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      user_id: currentUser.id,
      product_id: id
    })
  });

  await updateCartCount();
  await renderCart();

  showToast("Added to cart");
}

 
async function updateCartCount() {
  if (!currentUser) {
    document.getElementById('cartCount').textContent = 0;
    return;
  }

  const res = await fetch(`http://localhost:3000/cart/${currentUser.id}`);
  const data = await res.json();

  const total = data.reduce((sum, item) => sum + item.quantity, 0);
  document.getElementById('cartCount').textContent = total;

}


async function renderCart() {
  if (!currentUser) {
    document.getElementById('cartItems').innerHTML = "Login first";
    return;
  }

  const res = await fetch(`http://localhost:3000/cart/${currentUser.id}`);
  const cart = await res.json();

  const el = document.getElementById('cartItems');

  if (!cart.length) {
    el.innerHTML = '<div class="empty-state"><span class="emoji">🛒</span><p>Your cart is empty</p></div>';
    
    document.getElementById('subtotal').textContent = '₹0';
    document.getElementById('tax').textContent = '₹0';
    document.getElementById('total').textContent = '₹0';
    return;
  }

  let subtotal = 0;

  el.innerHTML = cart.map(p => {
    const price = p.price * p.quantity;
    subtotal += price;

    return `
      <div class="cart-item">
        <div class="cart-item-img">🛍️</div>
        <div class="cart-item-info">
          <div class="cart-item-name">${p.name}</div>
          <div>Qty: ${p.quantity}</div>
          <div class="cart-item-price">₹${price}</div>
        </div>
        <button class="cart-item-remove" onclick="removeFromCart(${p.id})">🗑</button>
      </div>
    `;
  }).join('');

  const tax = Math.round(subtotal * 0.18);

  document.getElementById('subtotal').textContent = '₹' + subtotal;
  document.getElementById('tax').textContent = '₹' + tax;
  document.getElementById('total').textContent = '₹' + (subtotal + tax);
}

async function checkout() {
  if (!currentUser) {
    showToast("Login first", "error");
    return;
  }

  const total = cart.reduce((s,p)=>s+p.price*p.qty,0);

  await fetch('http://localhost:3000/order', {
    method:'POST',
    headers:{'Content-Type':'application/json'},
    body: JSON.stringify({ user_id: currentUser.id, total })
  });

  cart = [];
  updateCartCount();
  renderCart();
  showToast("Order placed!", "success");
}
 
async function removeFromCart(productId) {
  await fetch(`http://localhost:3000/cart/${currentUser.id}/${productId}`, {
    method: 'DELETE'
  });

  await renderCart();
  await updateCartCount();
}

// =================== ADMIN ===================
function renderAdminTable() {
  document.getElementById('adminTableBody').innerHTML = products.map(p=>`
    <tr>
      <td style="color:var(--muted)">#${p.id}</td>
      <td><strong>${p.name}</strong></td>
      <td>${p.cat}</td>
      <td>₹${Math.round(p.price*(1-p.discount/100)).toLocaleString('en-IN')}</td>
      <td>${p.stock}</td>
      <td><span class="status-pill ${p.stock>0?'available':'out'}">${p.stock>0?'In Stock':'Out of Stock'}</span></td>
      <td>
        <button onclick="updateProduct(${p.id})" 
          style="background:rgba(248,113,113,0.15);color:var(--danger);border:none;border-radius:6px;padding:0.5rem 1.4rem;cursor:pointer;font-size:0.8rem">
          Edit
        </button>

        <button onclick="deleteProduct(${p.id})" 
          style="background:#f87171;border:none;padding:5px 10px;border-radius:6px;cursor:pointer;margin-left:5px;">
          Delete
        </button>
      </td>
    </tr>
  `).join('');
}
 
async function updateAdminStats() {
  document.getElementById('statProducts').textContent = products.length;

  const usersRes = await fetch('http://localhost:3000/users');
  const usersData = await usersRes.json();

  const ordersRes = await fetch('http://localhost:3000/orders');
  const ordersData = await ordersRes.json();

  document.getElementById('statUsers').textContent = usersData.count;
  document.getElementById('statOrders').textContent = ordersData.count;
  document.getElementById('statRevenue').textContent =
    '₹' + (ordersData.revenue || 0).toLocaleString('en-IN');
}
 
async function addProduct() {
  const product = {
    name: document.getElementById('newName').value,
    category: document.getElementById('newCat').value,
    price: parseInt(document.getElementById('newPrice').value),
    stock: parseInt(document.getElementById('newStock').value),
    description: document.getElementById('newDesc').value,
    image: document.getElementById('newImage').value,
    rating: 4.0,
    discount: 0
  };

  const res = await fetch('http://localhost:3000/products', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(product)
  });

  const text = await res.text();
  console.log("SERVER RESPONSE:", text);

  if (res.ok) {
    showToast('✅ Product added');
    loadProducts();
  } else {
    showToast('❌ Failed to add product', 'error');
  }
}

async function deleteProduct(id) {
  await fetch(`http://localhost:3000/products/${id}`, {
    method: 'DELETE'
  });

  await loadProducts();   
  renderAdminTable();

  showToast('🗑 Deleted');
}

async function updateProduct(id) {
  const p = products.find(x => x.id === id);

  const newName = prompt("Name:", p.name);
  const newPrice = prompt("Price:", p.price);
  const newStock = prompt("Stock:", p.stock);
  const newCategory = prompt("Category:", p.cat);
  const newDesc = prompt("Description:", p.desc);

  if (!newName || !newPrice || !newStock) return;

  const res = await fetch(`http://localhost:3000/products/${id}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      name: newName,
      category: newCategory,
      price: parseInt(newPrice),
      stock: parseInt(newStock),
      description: newDesc,
      rating: p.rating || 4.0,
      discount: p.discount || 0
    })
  });

  const msg = await res.text();
  console.log(msg);

  await loadProducts();
  showToast('✏ Updated');
}
 
// =================== NAVIGATION ===================
function showPage(name) {
  document.querySelectorAll('.page').forEach(p=>p.classList.remove('active'));
  document.querySelectorAll('.nav-btn').forEach(b=>b.classList.remove('active'));
  document.getElementById('page-'+name).classList.add('active');
  if (name==='catalog') { renderCatalog(); renderCatFilter(); }
  if (name==='cart') renderCart();
  if (name==='admin') {
    if (!currentUser||currentUser.role!=='admin') { showToast('❌ Admin access only','error'); showPage('auth'); return; }
    renderAdminTable(); updateAdminStats();
  }
  window.scrollTo(0,0);
  if (name === 'cart') {
    renderCart(); 
  }
}
 
// =================== TOAST ===================
function showToast(msg, type='success') {
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.className = `toast show ${type}`;
  setTimeout(()=>t.classList.remove('show'),3000);
}
 
// =================== INIT ===================

async function loadProducts() {
  try {
    const res = await fetch('http://localhost:3000/products');
    const data = await res.json();

    // 🔥 IMPORTANT FIX
    products = data.map(p => ({
      ...p,
      cat: p.category,
      desc: p.description
    }));

    console.log(products); // check in console

    renderTrending();
    renderCatalog();
  } catch (err) {
    console.error("Error loading products:", err);
  }
}

loadProducts();
renderCatFilter();
