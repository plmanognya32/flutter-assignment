// models/item.js
const mongoose = require('mongoose');

const itemSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Product name is required'],
    trim: true,
  },
  description: {
    type: String,
    required: [true, 'Description is required'],
    trim: true,
  },
  price: {
    type: Number,
    required: [true, 'Price is required'],
    min: [0, 'Price must be a positive number'],
  },
  imageUrl: {
    type: String,
    required: [true, 'Image URL is required'],
  },
});

module.exports = mongoose.model('Item', itemSchema);
