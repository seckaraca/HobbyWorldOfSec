package com.hobbyworld.controller;

import com.hobbyworld.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/test-db")
    public String testConnection() {
        try {
            long count = userRepository.count();
            return "Bağlantı Başarılı! Veritabanındaki toplam kullanıcı sayısı: " + count;
        } catch (Exception e) {
            return "Bağlantı Hatası: " + e.getMessage();
        }
    }
}
