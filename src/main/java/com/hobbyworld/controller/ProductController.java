package com.hobbyworld.controller;

import com.hobbyworld.model.Product;
import com.hobbyworld.repository.ProductRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.math.BigDecimal;

@RestController
public class ProductController {
    private final ProductRepository productRepository;

    public ProductController(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @GetMapping("/urun-ekle")
    public String urunEkle() {
        Product urun = new Product();
        urun.setProductName("Premium Akrilik Yün - Kırmızı");
        urun.setCategory("Örgü Malzemeleri");
        urun.setPrice(new BigDecimal("125.50"));
        urun.setStockQuantity(50);
        
        productRepository.save(urun);
        return "Başardık Seçkin! İlk ürün (Kırmızı Yün) veritabanına kaydedildi.";
    }
}
