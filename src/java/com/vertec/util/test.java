/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author vertec-r
 */
public class test {
    public static void main(String[] args) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date1 = sdf.parse("2009-12-31");
            Date date2 = sdf.parse("2010-01-31");
            
            
            if(date1.after(date2)){
                System.out.println("Date1 is after Date2");
            }

            if(date1.before(date2)){
                System.out.println("Date1 is before Date2");
            }

            if(date1.equals(date2)){
                System.out.println("Date1 is equal Date2");
            }
        } catch (ParseException ex) {
            Logger.getLogger(test.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
