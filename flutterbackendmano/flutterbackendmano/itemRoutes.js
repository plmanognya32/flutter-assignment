// itemRoutes.js
const express = require('express');
const router = express.Router();
const Item = require('./item');

// GET all items — /products/items
router.get('/items', async (req, res) => {
  try {
    const items = await Item.find();
    res.json(items);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching items' });
  }
});

// POST — /products/items
router.post('/items', async (req, res) => {
  try {
    const newItem = new Item(req.body);
    await newItem.save();
    res.status(201).json(newItem);
  } catch (err) {
    res.status(400).json({ message: 'Error adding item' });
  }
});

// PUT — /products/items/:id
router.put('/items/:id', async (req, res) => {
  try {
    const { name, description, imageUrl, price } = req.body;

    const updatedItem = await Item.findByIdAndUpdate(
      req.params.id,
      { name, description, imageUrl, price },
      { new: true, runValidators: true }
    );

    if (!updatedItem) {
      return res.status(404).json({ message: 'Item not found' });
    }

    res.json(updatedItem);
  } catch (err) {
    res.status(400).json({ message: 'Error updating item' });
  }
});

// DELETE — /products/items/:id
router.delete('/items/:id', async (req, res) => {
  try {
    const deleted = await Item.findByIdAndDelete(req.params.id);
    if (!deleted) {
      return res.status(404).json({ message: 'Item not found' });
    }
    res.json({ message: 'Deleted successfully' });
  } catch (err) {
    res.status(400).json({ message: 'Error deleting item' });
  }
});

module.exports = router;
