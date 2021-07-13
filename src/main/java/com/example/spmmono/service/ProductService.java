package com.example.spmmono.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.spmmono.model.ProductModel;
import com.example.spmmono.repository.ProductRepository;

@Service
@Transactional(readOnly = true)
public class ProductService {

	@Autowired
	ProductRepository productRepository;

	public List<ProductModel> getProducts() {
		return productRepository.findAll();
	}

	public Optional<ProductModel> getProduct(final long id) {
		return productRepository.findById(id);
	}

	@Transactional(readOnly = false)
	public void saveProduct(ProductModel productToCreate) {
		productRepository.save(productToCreate);
	}

}
