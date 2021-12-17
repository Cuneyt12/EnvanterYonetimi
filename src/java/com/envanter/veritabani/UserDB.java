package com.envanter.veritabani;

import com.envanter.javabean.Cart;
import com.envanter.javabean.Products;
import com.envanter.javabean.SoldProducts;
import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class UserDB {
    public static final String  KULLANICI_EKLE = "INSERT INTO kullanicilar(kullanici_adi, sifre, eposta, hesap_turu) VALUES(?, ?, ?, ?)";
    public static final String  KULLANICI_BILGILERI = "SELECT * FROM kullanicilar";
    public static final String  URUN_EKLE = "INSERT INTO urunler(urunKodu, kategori, urunAdi, adet, alisFiyat, satisFiyat) VALUES(?, ?, ?, ?, ?, ?)";
    public static final String  URUN_BILGILERI = "SELECT * FROM ";
    public static final String  SEPETE_URUN_EKLE = "INSERT INTO sepet(urunKodu, urunAdi, adet, fiyat) VALUES(?, ?, ?, ?)";
    public static final String  SATILANLAR = "INSERT INTO satilan(urunKodu, urunAdi, adet, fiyat) VALUES(?, ?, ?, ?)";
    public static final String DRIVER = "com.mysql.jdbc.Driver";
    public static final String URL = "jdbc:mysql://localhost:3306/envanter";
    public static boolean isFirstLogin = false;
    public static  boolean isForSell = false;
    public static boolean isAddedToCart = false;
    public static boolean isRemovedFromCart = false;
    public static boolean isRemovedAll = false;
    Products products = new Products();
    Cart cart;
    SoldProducts sold;
    public static HashMap<Integer, Cart> sepetHashMap = new HashMap<>();
    public static List<Products> urunlerList = new ArrayList<>();
    public static List<Cart> sepetList = new ArrayList<>();
    public static List<SoldProducts> satilanlarList = new ArrayList<>();
    public static  int eksilt = 0;
    public int adet = 0;
    public int sepetAdedi = 0;
    public int urunAdet = 0;
    public int adetArttir = 0;
    public static String sepetAdediGlobal;
    HashMap<Integer, Integer> sepetHash = new HashMap();
    HashMap<Integer, Integer> urunHash = new HashMap();
    ArrayList<Cart> silinen = new ArrayList<>();
    int kod = 0;
    
    
    public UserDB(){
        
        urunBilgileriniGetir();
    }
        
    public String hesapKontrol(String kullaniciAdi, String parola){
        Connection con = null;
             
         try {
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, "root", "root");
            Statement sorgu = con.createStatement();
            ResultSet veri = sorgu.executeQuery(KULLANICI_BILGILERI);
            
            while(veri.next()){
                if (kullaniciAdi.equals(veri.getString("kullanici_adi")) && parola.equals(veri.getString("sifre")) && veri.getString("hesap_turu").equals("admin")  ) {
                     if(veri.getString("sifre").equals("admin")){
                         isFirstLogin = true;
                     }
                     return "admin";
                }
                else if (kullaniciAdi.equals(veri.getString("kullanici_adi")) && parola.equals(veri.getString("sifre")) && veri.getString("hesap_turu").equals("staff")) {
                         return "staff";
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("HESAP KONTROL HATA");
        }
        return "Kayıt bulunamadı";
    }
    
    public void urunEkle(String urunKodu, String kategori, String urunAdi, String adet, String alisFiyat, String satisFiyat){
        Connection con = null;
             int result = 0;
             PreparedStatement p = null;
             ResultSet rs = null;
              
              
          try {
              Class.forName(DRIVER);
              con = DriverManager.getConnection(URL, "root", "root");
              Statement sorgu = con.createStatement();
             
              if(!urunVarMi(Integer.valueOf(urunKodu), Integer.valueOf(adet))){
                  p = con.prepareStatement(URUN_EKLE);
              
              p.setString(1, urunKodu);
              p.setString(2, kategori);
              p.setString(3, urunAdi);
              p.setString(4, adet);
              p.setString(5, alisFiyat);
              p.setString(6, satisFiyat);
              
              result = p.executeUpdate();
              
              }
              else{
                  System.out.println("ürün vardı 1 arttırıldı");
              }
            }
         catch (Exception ex) {
             ex.printStackTrace();
            System.out.println("HATA URUN EKLENMEDİ");
        }
          
    }
    
    public ResultSet urunListele(String tablo){
        ResultSet urun = null;
        Connection conn = null;
        int a = 0;
        String sql = URUN_BILGILERI + tablo ;
          
        
         try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, "root", "root");
            Statement sorgu = conn.createStatement();
            urun = sorgu.executeQuery(sql);
            } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("LİSTELEMEDE HATA");
        }
         return urun;
    }
    
    public void sepeteEkle(int urunKodu){
        ResultSet urun = null;
        Connection conn = null; 
        PreparedStatement p = null;
        
         try {
             Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, "root", "root");
            Statement sorgu = conn.createStatement();
            urun = sorgu.executeQuery("SELECT * FROM urunler WHERE urunKodu='" + urunKodu + "'");
            p = conn.prepareStatement(SEPETE_URUN_EKLE);
            
            while(urun.next()){
                this.sepetAdedi++;
                sepetHashMap.put(Integer.valueOf(urun.getString("urunKodu")), new Cart(Integer.valueOf(urun.getString("urunKodu")), urun.getString("urunAdi"), 
                                        Integer.valueOf(urun.getString("adet")), Integer.valueOf(urun.getString("satisFiyat"))));
                sepetList.add(new Cart(Integer.valueOf(urun.getString("urunKodu")), urun.getString("urunAdi"), 
                                        Integer.valueOf(urun.getString("adet")), Integer.valueOf(urun.getString("satisFiyat"))));
                this.adet = Integer.valueOf(urun.getString("adet"));
                  p.setInt(1, Integer.valueOf(urun.getString("urunKodu")));
                   p.setString(2, urun.getString("urunAdi"));
                  p.setInt(3, this.sepetAdedi);
                 p.setInt(4, Integer.valueOf(urun.getString("satisFiyat")));
                 sepetHash.put(Integer.valueOf(urun.getString("urunKodu")),  this.sepetAdedi);
            }   
            this.sepetAdedi = 0;
            int a = p.executeUpdate();
            
             adetGuncelle(urunKodu);
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("SEPETTE HATA");
        }
    }
    
    public void adetGuncelle(int urunKodu){
  
        Connection conn = null;  
        PreparedStatement sorgu;
        this.adet = this.adet - eksilt;
       
         try {
             Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, "root", "root");
            if(isAddedToCart){
                sorgu = conn.prepareStatement("UPDATE urunler SET adet='" + this.adet + "' WHERE urunKodu='" + urunKodu + "'");
                sorgu.executeUpdate(); 
                System.out.println("Ürün eksiltildi");
            }   
            if(isRemovedFromCart){
                sorgu = conn.prepareStatement("UPDATE urunler SET adet='" + (urunHash.get(urunKodu) ) + "' WHERE urunKodu='" + urunKodu + "'");
                sorgu.executeUpdate();
                this.adetArttir = 0;
            }
            if(isRemovedAll){
                System.out.println( urunKodu + " için güncelleme ÖNCESİİİ işlemiiiiiiiiiiiiiiiiiiiii REMOVED ALL  this.adetArttir= " + sepettenGeriGidecekUrunSayisi(urunKodu));
                sorgu = conn.prepareStatement("UPDATE urunler SET adet='" + (urunHash.get(urunKodu)) + "' WHERE urunKodu='" + urunKodu + "'");
                sorgu.executeUpdate(); 
            }
             
             
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("ADET GÜNCELLEMEDE HATA");
        } 
         this.isAddedToCart = false; 
         this.isRemovedFromCart = false;
         this.isRemovedAll = false;
         this.eksilt = 0;
       }
    
    public void kullaniciEkle(String kAdi, String sifre, String mail, String hesapTipi){
        Connection con = null;
             int result = 0;
             PreparedStatement p = null;
              ResultSet rs = null;
          try {
              Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, "root", "root");
           
              p = con.prepareStatement(KULLANICI_EKLE);
              
              p.setString(1, kAdi);
              p.setString(2, sifre);
              p.setString(3, mail);
              p.setString(4, hesapTipi);
              
              result = p.executeUpdate();
              
           
            }
         catch (Exception ex) {
             ex.printStackTrace();
            System.out.println("HATA EKLENMEDİ");
        }
    }
    
    public void sifreGuncelle(String sifre, String kAdi){
        Connection conn = null;     
       
         try {
             Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, "root", "root");
            PreparedStatement sorgu = conn.prepareStatement("UPDATE kullanicilar SET sifre='" + sifre + "' WHERE kullanici_adi='" + kAdi + "'");
            sorgu.executeUpdate();       
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("SİFRE GÜNCELLEMEDE HATA");
        }
    }
    
    public void urunSil(String tabloAdi, int urunKodu){
        String deleteOne = "DELETE  FROM " + tabloAdi +  " where urunKodu='" + urunKodu + "'";
         Connection conn = null;  
         PreparedStatement sorgu = null;
         this.adetArttir = 0;
        
         try {
             Class.forName(DRIVER);
             conn = DriverManager.getConnection(URL, "root", "root");
                
                this.adetArttir = ayniUrunVarMi(urunKodu);
                urunHash.put(urunKodu, (urunHash.get(urunKodu) + this.adetArttir));
                sepetHashMap.remove(urunKodu);
                sorgu = conn.prepareStatement(deleteOne);
                sorgu.executeUpdate();
                this.isRemovedFromCart = true;
                adetGuncelle(urunKodu); 
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("ÜRÜN SİLMEDE HATA");
           
        }   
     }
    
    public void satilaniSil(){
        Connection conn = null;  
         PreparedStatement sorgu = null;
         ResultSet result = null;
         Statement s = null;
         satilanlarList.clear();
         
          try {
             Class.forName(DRIVER);
             conn = DriverManager.getConnection(URL, "root", "root");
              
             s = conn.createStatement();
             
             result = s.executeQuery("Select * from sepet");
             
             while(result.next()) {
                 satilanlarList.add(new SoldProducts(Integer.valueOf(result.getString("urunKodu")), result.getString("urunAdi"), Integer.valueOf(result.getString("adet")), 
                         Integer.valueOf(result.getString("fiyat"))));
                 
                 sorgu = conn.prepareStatement("DELETE   FROM sepet WHERE urunKodu='" + result.getString("urunKodu") + "'");
                sorgu.executeUpdate();
             }
                
             
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("ÜRÜN SİLMEDE HATA");        
        } 
    }
    
    public void satilaniBosalt(){
        Connection conn = null;  
         PreparedStatement sorgu = null;
         ResultSet result = null;
         Statement s = null;
         
         
          try {
             Class.forName(DRIVER);
             conn = DriverManager.getConnection(URL, "root", "root");
              
             s = conn.createStatement();
             
             result = s.executeQuery("Select * from satilan");
             
             while(result.next()) {
                 
                 sorgu = conn.prepareStatement("DELETE   FROM satilan WHERE urunKodu='" + result.getString("urunKodu") + "'");
                sorgu.executeUpdate();
             }
                
             
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("ÜRÜN SİLMEDE HATA");        
        } 
    }
    
    public void satisListesineEkle(int urunKodu, String ad, int adet, int fiyat){
         Connection con = null;
             int result = 0;
             PreparedStatement p = null;
              ResultSet rs = null;
          try {
              Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, "root", "root");
           
              p = con.prepareStatement(SATILANLAR);
              
              p.setInt(1, urunKodu);
              p.setString(2, ad);
              p.setInt(3, adet);
              p.setInt(4, fiyat);
              
              
              result = p.executeUpdate();
              
            }
         catch (Exception ex) {
             ex.printStackTrace();
            System.out.println("HATA URUN EKLENMEDİ");
        }
    }
    
    public boolean urunVarMi(int urunKodu, int adet){
         Connection con = null;
             
         try {
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, "root", "root");
            Statement sorgu = con.createStatement();
            ResultSet veri = sorgu.executeQuery(URUN_BILGILERI + "urunler");
            
            while(veri.next()){
                if(urunKodu == veri.getInt("urunKodu")){
                    PreparedStatement sorgu1 = con.prepareStatement("UPDATE urunler SET adet='" + (veri.getInt("adet") + adet) + "' WHERE urunKodu='" + urunKodu + "'");
                      sorgu1.executeUpdate(); 
                    return true;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("HESAP KONTROL HATA");
        }
        return false;
    }
    
    public void urunBilgileriniGetir(){
        //urunlerList.clear();
        urunHash.clear();
        ResultSet urun = null;
        Connection conn = null;
        
        int a = 0;
        String sql = URUN_BILGILERI + "urunler" ;
       
         try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, "root", "root");
            Statement sorgu = conn.createStatement();
            urun = sorgu.executeQuery(sql);
            
            while(urun.next()){
              
               urunHash.put(Integer.valueOf(urun.getString("urunKodu")), Integer.valueOf(urun.getString("adet")));
            }
            } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("BAŞLANGIÇ BİLGİLERİ ALINAMADI");
        }
         
         for(Map.Entry m: urunHash.entrySet()){
             System.out.println("KEY: " + m.getKey() + " Value: " + m.getValue());
         }
    }
    
    public int ayniUrunVarMi(int urunKodu){
         
          int a = 0;
        Connection conn = null;  
        PreparedStatement sorgu = null;
        Statement st = null;
      
        try {//2
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, "root", "root");
            st = conn.createStatement();
            ResultSet rs = st.executeQuery(URUN_BILGILERI + "sepet");
            
            while(rs.next()){
                   if(urunKodu == Integer.valueOf(rs.getString("urunKodu"))){
                       a++;
                   }
                     
            }
        
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("ÜRÜN SİLMEDE HATA");
           
        } 
     
   return a;
}
    
    public void sepetiTemizle(String tabloAdi){
        Connection conn = null;  
        PreparedStatement sorgu = null;
        Statement st = null;
        
      
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, "root", "root");
            st = conn.createStatement();
            ResultSet rs = st.executeQuery(URUN_BILGILERI + tabloAdi);
            
            while(rs.next()){
                     
                     this.isRemovedAll = true;
                     this.adetArttir = sepettenGeriGidecekUrunSayisi(Integer.valueOf(rs.getString("urunKodu")));
                     sorgu = conn.prepareStatement("DELETE  FROM " + tabloAdi +  " where urunKodu='" + Integer.valueOf(rs.getString("urunKodu")) + "'");
                     sorgu.executeUpdate();
                     urunHash.put(Integer.valueOf(rs.getString("urunKodu")), (urunHash.get(Integer.valueOf(rs.getString("urunKodu"))) + this.adetArttir) );
                     adetGuncelle(Integer.valueOf(rs.getString("urunKodu")));
                     
            }
            sepetList.clear();
        
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("ÜRÜN SİLMEDE HATA");
           
        } 
    }
    
    public int sepettenGeriGidecekUrunSayisi(int urunKodu){
        int a = 0;
        
        
        Collection<Cart> values = sepetHashMap.values();
        
        for(Cart ca: values){
            System.out.println("KOLEKSİYON: " + ca.getUrunKodu() + " URUN KODU: " + urunKodu);
            if(urunKodu == ca.getUrunKodu()){
                a++;
            }
        }
       
      return a;
    }
    
    public void urunGuncelle(int urunKodu, String kategori, String urunAdi, int adet, int alisFiyat, int satisFiyat){
         Connection con = null;
             
         try {
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, "root", "root");
            Statement sorgu = con.createStatement();
            ResultSet veri = sorgu.executeQuery(URUN_BILGILERI + "urunler");
            
                  PreparedStatement sorgu1 = con.prepareStatement("UPDATE urunler SET kategori='" + kategori + "', urunAdi='" + urunAdi + "', adet='" + adet + "', alisFiyat='" +
                          alisFiyat + "', satisFiyat='" + satisFiyat+ "' WHERE urunKodu='" + urunKodu + "'");
                  sorgu1.executeUpdate(); 
           
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("HESAP KONTROL HATA");
        }
    }
}