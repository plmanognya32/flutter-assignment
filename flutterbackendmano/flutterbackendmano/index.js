// index.js
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const itemRoutes = require('./itemRoutes');

const app = express();
app.use(cors());
app.use(express.json());

mongoose.connect('mongodb://127.0.0.1:27017/items')
  .then(() => console.log('✅ MongoDB connected'))
  .catch(err => console.log('❌ MongoDB Error:', err));

// Use all item routes under /products
app.use('/products', itemRoutes);

app.listen(5000, () => {
  console.log('🚀 Server running on http://localhost:5000/items');
});
