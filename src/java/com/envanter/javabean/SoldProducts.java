/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.envanter.javabean;

import java.io.Serializable;

public class SoldProducts extends Cart{
        public SoldProducts(int urunKodu, String urunAdi, int adet, int fiyat){
            super(urunKodu, urunAdi, adet, fiyat);
        }
}
