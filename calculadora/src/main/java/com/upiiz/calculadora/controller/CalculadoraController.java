package com.upiiz.calculadora.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CalculadoraController {

    @GetMapping("/calculadora")
    public String mostrarCalculadora() {
        // Esto buscará el archivo calculadora.html en la carpeta templates
        return "calculadora";
    }
}