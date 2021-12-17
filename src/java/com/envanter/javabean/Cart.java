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
public class Cart implements Serializable{
    private int urunKodu;
    private String urunAdi;
    private int adet;
    private int fiyat;
    
    public Cart(int urunKodu, String urunAdi, int adet, int fiyat){
        this.urunKodu = urunKodu;
        this.urunAdi = urunAdi;
        this.adet = adet;
        this.fiyat = fiyat;
    }

    public int getUrunKodu() {
        return urunKodu;
    }

    public void setUrunKodu(int urunKodu) {
        this.urunKodu = urunKodu;
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

    public int getFiyat() {
        return fiyat;
    }

    public void setFiyat(int fiyat) {
        this.fiyat = fiyat;
    }
    
}
