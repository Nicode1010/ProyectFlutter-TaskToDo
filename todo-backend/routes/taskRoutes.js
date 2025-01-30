const express = require("express");
const Task = require("../models/Task");

const router = express.Router();

// 📌 Agregar una nueva tarea
router.post("/tasks", async (req, res) => {
    try {
        const { title } = req.body;
        const newTask = new Task({ title });
        await newTask.save();
        res.status(201).json(newTask);
    } catch (error) {
        res.status(500).json({ error: "Error al crear la tarea" });
    }
});

// 📌 Obtener todas las tareas
router.get("/tasks", async (req, res) => {
    try {
        const tasks = await Task.find();
        res.json(tasks);
    } catch (error) {
        res.status(500).json({ error: "Error al obtener las tareas" });
    }
});

module.exports = router;
