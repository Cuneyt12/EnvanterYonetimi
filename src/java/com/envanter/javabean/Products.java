/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.envanter.javabean;

import java.io.Serializable;

/**
 *
 * @author Cüneyt
 */
public class Products implements Serializable{
    private int urunKodu;
    private String kategori;
    private String urunAdi;
    private int adet;
    private int alisFiyat;
    private int satisFiyat;
    
    public Products(){}
    
    public Products(int urunKodu, String kategori, String urunAdi, int adet, int alisFiyat, int satisFiyat){
        this.urunKodu = urunKodu;
        this.kategori = kategori;
        this.urunAdi = urunAdi;
        this.adet = adet;
        this.alisFiyat = alisFiyat;
        this.satisFiyat = satisFiyat;
    }

    public int getUrunKodu() {
        return urunKodu;
    }

    public void setUrunKodu(int urunKodu) {
        this.urunKodu = urunKodu;
    }

    public String getKategori() {
        return kategori;
    }

    public void setKategori(String kategori) {
        this.kategori = kategori;
    }

    public String getUrunAdi() {
        return urunAdi;
    }

    public void setUrunAdi(String urunAdi) {
        this.urunAdi = urunAdi;
    }

    public int getAdet() {
        return adet;
    }

    public void setAdet(int adet) {
        this.adet = adet;
    }

    public int getAlisFiyat() {
        return alisFiyat;
    }

    public void setAlisFiyat(int alisFiyat) {
        this.alisFiyat = alisFiyat;
    }

    public int getSatisFiyat() {
        return satisFiyat;
    }

    public void setSatisFiyat(int satisFiyat) {
        this.satisFiyat = satisFiyat;
    }
    
    
    
}
