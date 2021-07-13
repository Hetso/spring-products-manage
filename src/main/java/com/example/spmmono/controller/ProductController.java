package com.example.spmmono.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.spmmono.model.ProductModel;
import com.example.spmmono.service.ProductService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@Validated
@RestController
@Tag(name = "Products")
@RequestMapping(value = "/products", produces = MediaType.APPLICATION_JSON_VALUE)
public class ProductController {

	@Autowired
	ProductService productService;

	@Operation(summary = "Get all products")
	@GetMapping
	public ResponseEntity<List<ProductModel>> getAllProducts() {
		return new ResponseEntity<>(productService.getProducts(),
				HttpStatus.OK);
	}

	@Operation(summary = "Get a product by id")
	@GetMapping("/{id:[0-9]+}")
	public ResponseEntity<ProductModel> getProduct(
			@PathVariable("id") final long id) {

		Optional<ProductModel> product = productService.getProduct(id);

		if (product.isPresent()) {
			return new ResponseEntity<>(product.get(),
					HttpStatus.OK);
		}

		return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	}

	@Operation(summary = "Create a new product")
	@PostMapping
	public ResponseEntity<ProductModel> createProduct(
			@RequestBody ProductModel productToCreate) {
		productService.saveProduct(productToCreate);

		return new ResponseEntity<>(productToCreate,
				HttpStatus.CREATED);
	}

}
