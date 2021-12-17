package com.envanter.javabean;

import java.io.Serializable;

public class User implements Serializable{
    private long id;
    private String isim;
    private String sifre;
    private String eposta;
    private String hesapTipi;
    
    public User(){
        
    }

    public User(String isim, String sifre, String eposta, String hesapTipi) {
        this.isim = isim;
        this.sifre = sifre;
        this.eposta = eposta;
        this.hesapTipi = hesapTipi;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getIsim() {
        return isim;
    }

    public void setIsim(String isim) {
        this.isim = isim;
    }

    public String getSifre() {
        return sifre;
    }

    public void setSifre(String sifre) {
        this.sifre = sifre;
    }

    public String getEposta() {
        return eposta;
    }

    public void setEposta(String eposta) {
        this.eposta = eposta;
    }

    public String getHesapTipi() {
        return hesapTipi;
    }

    public void setHesapTipi(String hesapTipi) {
        this.hesapTipi = hesapTipi;
    }
}
