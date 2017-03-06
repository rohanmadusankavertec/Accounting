/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.daoimpl;

import com.vertec.hibe.model.Account;
import com.vertec.hibe.model.BalanceSheetData;
import com.vertec.hibe.model.Company;
import com.vertec.hibe.model.Depreciation;
import com.vertec.hibe.model.DepreciationData;
import com.vertec.hibe.model.Transaction;
import com.vertec.util.NewHibernateUtil;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author vertec-r
 */
public class ReportDAOImpl {

    public List<Transaction> loadAssetCreditSide(Account a, Date from, Date to, Company company) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT t FROM Transaction t WHERE t.credit = :account AND t.companyId=:com AND t.date BETWEEN :from AND :to");
                query.setParameter("account", a);
                query.setParameter("from", from);
                query.setParameter("to", to);
                query.setParameter("com", company);
                List<Transaction> pcList = query.list();
                return pcList;

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<Transaction> loadAllOfAccountByPayType(Date fdate, Date todate, Company com) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT t FROM Transaction t WHERE t.companyId=:com  AND t.date  BETWEEN :fdate AND :todate");
//                query.setParameter("cid",cid);

                query.setParameter("fdate", fdate);
                query.setParameter("todate", todate);
//                query.setParameter("did",did);
                query.setParameter("com", com);

                List<Transaction> aList = query.list();
                return aList;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }

    public List<Account> loadAllOfAccountByCash1(Company com) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {

//                Query query = session.createQuery("SELECT t FROM Transaction t WHERE t.companyId=:com  AND t.date  BETWEEN :fdate AND :todate");
                Query query = session.createQuery("SELECT a FROM Account a WHERE a.companyId=:com AND a.isValid=:valid AND (a.subtypeId.name='Cash' OR a.subtypeId.name='Bank')");
//                query.setParameter("cid",cid);

                query.setParameter("valid", true);
//                query.setParameter("did",did);
                query.setParameter("com", com);

                List<Account> aList = query.list();
                return aList;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }

    public List<String[]> loadAccountsForProfit(List<Account> account, Date from, Date to) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                List<String[]> starr = new ArrayList<>();
                for (Account a : account) {
                    Query query1 = session.createQuery("SELECT t FROM Transaction t WHERE t.date BETWEEN :from AND :to");
                    query1.setParameter("from", from);
                    query1.setParameter("to", to);
                    List<Transaction> tList = query1.list();

                    for (Transaction transaction : tList) {
                        
                        if (!transaction.getDebit().getSubtypeId().getTypeId().getName().equals("Capital") && !transaction.getCredit().getSubtypeId().getTypeId().getName().equals("Capital")) {
                            boolean bool = true;
                            for (String[] st : starr) {
                                if (st[0].equals(transaction.getId() + "")) {
                                    bool = false;
                                }
                            }
                            if (bool) {
                                String[] arr = {transaction.getId() + "", transaction.getCredit().getName(), transaction.getDebit().getName(), transaction.getPrice() + ""};
                                starr.add(arr);
                            }
                        }
                    }
                }
                List<String[]> arr = new ArrayList<>();

                for (String[] st : starr) {
                    boolean cbool = false;
                    boolean dbool = false;
                    boolean is_change = false;

                    Query query1 = session.createQuery("SELECT t FROM Transaction t WHERE t.id=:id");
                    query1.setParameter("id", Integer.parseInt(st[0]));
                    Transaction t1 = (Transaction) query1.uniqueResult();

                    
                    if ((t1.getDebit().getSubtypeId().getName().equals("Cash") | t1.getDebit().getSubtypeId().getName().equals("Bank")) & (t1.getCredit().getSubtypeId().getName().equals("Cash") | t1.getCredit().getSubtypeId().getName().equals("Bank"))) {
                        dbool = true;
                        cbool = true;
                    } else if ((!t1.getDebit().getSubtypeId().getName().equals("Cash") | !t1.getDebit().getSubtypeId().getName().equals("Bank")) & (t1.getCredit().getSubtypeId().getName().equals("Cash") | t1.getCredit().getSubtypeId().getName().equals("Bank"))) {
                        dbool = false;
                        cbool = true;
                        if (t1.getDebit().getSubtypeId().getName().equals("Creditors") | t1.getDebit().getSubtypeId().getName().equals("Debtors")) {
                            cbool = false;
                        }

                    } else if ((t1.getDebit().getSubtypeId().getName().equals("Cash") | t1.getDebit().getSubtypeId().getName().equals("Bank")) & (!t1.getCredit().getSubtypeId().getName().equals("Cash") | !t1.getCredit().getSubtypeId().getName().equals("Bank"))) {
                        dbool = true;
                        cbool = false;

                        if (t1.getCredit().getSubtypeId().getName().equals("Creditors") | t1.getCredit().getSubtypeId().getName().equals("Debtors")) {
                            dbool = false;
                        }
                    } else if ((!t1.getDebit().getSubtypeId().getName().equals("Cash") | !t1.getDebit().getSubtypeId().getName().equals("Bank")) & (!t1.getCredit().getSubtypeId().getName().equals("Cash") | !t1.getCredit().getSubtypeId().getName().equals("Bank"))) {
                        dbool = false;
                        cbool = false;
                    }

                    if (cbool & dbool) {
                    } else if (!cbool & !dbool) {
                    } else {
                        double amount = 0.0;
                        String accountname = "";

                        if (dbool & dbool) {
                            amount = t1.getPrice();
                            accountname = t1.getCredit().getName() + "  (" + t1.getCredit().getSubtypeId().getName() + ")";
                        } else {
                            amount = (-1) * t1.getPrice();
                            accountname = t1.getDebit().getName() + "  (" + t1.getDebit().getSubtypeId().getName() + ")";
                        }
                        String[] sarr = {st[0], accountname, amount + ""};
                        arr.add(sarr);
                    }
                }
                List<String[]> finalarr = new ArrayList<>();
                for (String[] starray : arr) {
                    boolean finalbool = true;
                    for (String[] arr2 : finalarr) {
                        if (starray[1].equals(arr2[0])) {
                            finalbool = false;
                            arr2[1] = (Double.parseDouble(starray[2]) + Double.parseDouble(arr2[1])) + "";
                        }
                    }
                    if (finalbool) {
                        String[] newarr = {starray[1], starray[2]};
                        finalarr.add(newarr);
                    }
                }
                for (String[] starray : finalarr) {
                    System.out.println(starray[0] + "_____________________" + starray[1]);
                }
                return finalarr;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<Transaction> loadAssetDebitSide(Account a, Date from, Date to, Company company) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT t FROM Transaction t WHERE t.debit = :account AND t.companyId=:com AND t.date BETWEEN :from AND :to");
                query.setParameter("account", a);
                query.setParameter("from", from);
                query.setParameter("to", to);
                query.setParameter("com", company);
                List<Transaction> pcList = query.list();
                return pcList;

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public Account getAccountById(int id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT a FROM Account a WHERE a.id=:id");
                query.setParameter("id", id);
                Account pcList = (Account) query.uniqueResult();
                return pcList;

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public Double getAccountOpenBalance(int id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT a.balance FROM Account a WHERE a.id=:id");
                query.setParameter("id", id);
                Double pcList = (Double) query.uniqueResult();
                return pcList;

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public Double loadBalanceBackward(Account a, Date date, Company com) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Double debit = 0.0;
                Double credit = 0.0;
                Query query = session.createQuery("SELECT SUM(t.price) FROM Transaction t WHERE t.debit = :account AND t.companyId=:com AND t.date < :date");
                query.setParameter("account", a);
                query.setParameter("date", date);
                query.setParameter("com", com);
                Object ob = query.uniqueResult();
                if (ob == null) {
                } else {
                    debit = (Double) ob;
                }
                Query query1 = session.createQuery("SELECT SUM(t.price) FROM Transaction t WHERE t.credit = :account AND t.companyId=:com AND t.date < :date");
                query1.setParameter("account", a);
                query1.setParameter("date", date);
                query1.setParameter("com", com);
//                credit =(Double) query1.uniqueResult();
                Object ob2 = query1.uniqueResult();
                if (ob2 == null) {
                } else {
                    credit = (Double) ob2;
                }
                System.out.println("<><><><><><><><><><><><><><><><><><><><><><><><><><>");
                System.out.println("DEBIT :" + debit);
                System.out.println("CREDIT :" + credit);
                System.out.println("<><><><><><><><><><><><><><><><><><><><><><><><><><>");
                return debit - credit;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<String[]> loadTrialbalance(Date from, Date to, Company com) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT a FROM Account a ");
                List<Account> account = (List<Account>) query.list();
                List<String[]> starr = new ArrayList<>();
                for (Account a : account) {

                    Double debit = 0.0;
                    Double credit = 0.0;

                    Query query1 = session.createQuery("SELECT SUM(t.price) FROM Transaction t WHERE t.debit=:acc AND t.companyId=:com AND t.date BETWEEN :from AND :to");
                    query1.setParameter("from", from);
                    query1.setParameter("to", to);
                    query1.setParameter("acc", a);
                    query1.setParameter("com", com);
                    Object ob1 = query1.uniqueResult();
                    if (ob1 == null) {
                    } else {
                        debit = (Double) ob1;
                    }

                    Query query2 = session.createQuery("SELECT SUM(t.price) FROM Transaction t WHERE t.credit=:acc AND t.companyId=:com AND t.date BETWEEN :from AND :to");
                    query2.setParameter("from", from);
                    query2.setParameter("to", to);
                    query2.setParameter("acc", a);
                    query2.setParameter("com", com);
                    Object ob2 = query2.uniqueResult();
                    if (ob2 == null) {
                    } else {
                        credit = (Double) ob2;
                    }

                    String[] arr = {a.getName(), (debit - credit) + ""};
                    starr.add(arr);

                }
                return starr;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<Account> getAccountsByCompany(Company com) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT a FROM Account a WHERE a.companyId=:com");
                query.setParameter("com", com);
                List<Account> pcList = (List<Account>) query.list();
                return pcList;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<Account> getAccountsByCompany(Company com, String acc) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = null;
                if (acc.equals("")) {
                    query = session.createQuery("SELECT a FROM Account a WHERE a.companyId=:com");
                } else {
                    query = session.createQuery("SELECT a FROM Account a WHERE a.companyId=:com AND a.id=:id");
                    query.setParameter("id", Integer.parseInt(acc));
                }

//                
//                Query query = session.createQuery("SELECT a FROM Account a WHERE a.companyId=:com");
                query.setParameter("com", com);
                List<Account> pcList = (List<Account>) query.list();
                return pcList;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<BalanceSheetData> getBalanceSheetData(Date from, Date to, Company com) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT a FROM Account a");
                List<Account> account = (List<Account>) query.list();
                List<BalanceSheetData> starr = new ArrayList<>();
                for (Account a : account) {

                    Double debit = 0.0;
                    Double credit = 0.0;

                    Query query1 = session.createQuery("SELECT SUM(t.price) FROM Transaction t WHERE t.debit=:acc AND t.companyId=:com AND t.date BETWEEN :from AND :to");
                    query1.setParameter("from", from);
                    query1.setParameter("to", to);
                    query1.setParameter("acc", a);
                    query1.setParameter("com", com);
                    Object ob1 = query1.uniqueResult();
                    if (ob1 == null) {
                    } else {
                        debit = (Double) ob1;
                    }

                    Query query2 = session.createQuery("SELECT SUM(t.price) FROM Transaction t WHERE t.credit=:acc AND t.companyId=:com AND t.date BETWEEN :from AND :to");
                    query2.setParameter("from", from);
                    query2.setParameter("to", to);
                    query2.setParameter("acc", a);
                    query2.setParameter("com", com);
                    Object ob2 = query2.uniqueResult();
                    if (ob2 == null) {
                    } else {
                        credit = (Double) ob2;
                    }
                    BalanceSheetData bsd = new BalanceSheetData();
                    bsd.setA(a);
                    bsd.setSt(null);
                    bsd.setAmount((debit - credit));
                    starr.add(bsd);
                }
                return starr;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<DepreciationData> getDepreciationData(Date from, Date to, Company com) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT d FROM Depreciation d");
                List<Depreciation> depreciation = (List<Depreciation>) query.list();
                List<DepreciationData> starr = new ArrayList<>();
                for (Depreciation dep : depreciation) {
                    Query query1 = session.createQuery("SELECT SUM(t.price) FROM Transaction t WHERE t.depreciationId=:dep AND t.debit.subtypeId.name='Depreciation' AND t.companyId=:com AND t.date BETWEEN :from AND :to");
                    query1.setParameter("from", from);
                    query1.setParameter("to", to);
                    query1.setParameter("dep", dep);
                    query1.setParameter("com", com);
                    Double ob1 = (Double) query1.uniqueResult();

                    
                    
                    
                    
                    Query query2 = session.createQuery("SELECT SUM(t.price) FROM Transaction t WHERE t.depreciationId=:dep AND t.debit.subtypeId.name='Depreciation' AND t.companyId=:com AND t.date < :from ");
                    query2.setParameter("from", from);
                    query2.setParameter("dep", dep);
                    query2.setParameter("com", com);
                    Double ob2 = (Double) query2.uniqueResult();

                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    DepreciationData depre = new DepreciationData();
                    if (ob1 == null) {
                    } else {
                        depre.setAmount(ob1);
                    }
                    if (ob2 == null) {
                    } else {
                        depre.setBeforedep(ob2);
                    }
                    depre.setAccount(dep.getDebit());
                    depre.setDepreciation(dep);
                    starr.add(depre);
                }
                return starr;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public void CalculateDepreciation(Date from, Date to, Company com) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        org.hibernate.Transaction tr = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT d FROM Depreciation d WHERE d.isClosed=:ic AND d.credit.companyId=:com");
                query.setParameter("com", com);
                query.setParameter("ic", false);
                List<Depreciation> pcList = (List<Depreciation>) query.list();

                for (Depreciation dep : pcList) {
                    Query dq = session.createQuery("DELETE FROM Transaction t WHERE t.credit=:credit AND t.debit=:debit AND t.depreciationId=:did");
                    dq.setParameter("credit", dep.getCredit());
                    dq.setParameter("debit", dep.getDebit());
                    dq.setParameter("did", dep);
                    dq.executeUpdate();
                    session.flush();
                    tr.commit();

                    int terms = dep.getTerm();
                    double amount = dep.getAmount();
                    double rate = dep.getRate();
                    Date ldate = dep.getDate();
                    Date CurrentDate = to;

                    int i = 0;
                    while (ldate.before(CurrentDate)) {
                        i++;
                        Calendar c = Calendar.getInstance();
                        c.setTime(ldate);
                        c.add(Calendar.YEAR, 1);
                        Date dd = c.getTime();
                        long diff = CurrentDate.getTime() - dd.getTime();

                        if (diff > 365) {
                            double depamount = amount * (rate / 100);
                            Transaction trans = new Transaction();
                            trans.setCompanyId(com);
                            trans.setCredit(dep.getCredit());
                            trans.setDebit(dep.getDebit());
                            trans.setDate(dd);
                            trans.setDepreciationId(dep);
                            trans.setDescription("Calculated Depreciation Automatically...");
                            trans.setDiscount(0.0);
                            trans.setPaidAmount(depamount);
                            trans.setPrice(depamount);
                            new SaveDAOImpl().saveObject(trans);
                            amount -= depamount;
                        }
                        long diff2 = CurrentDate.getTime() - ldate.getTime();

                        if (diff < 0 && diff2 > 0) {
                            int diffInDays = getDifferenceDays(ldate, CurrentDate);
                            double depamount = amount * (rate / 100) * (Double.parseDouble(diffInDays + "") / 365);
                            DecimalFormat df = new DecimalFormat("#.##");
                            depamount = Double.valueOf(df.format(depamount));
                            Transaction trans = new Transaction();
                            trans.setCompanyId(com);
                            trans.setCredit(dep.getCredit());
                            trans.setDebit(dep.getDebit());
                            trans.setDate(CurrentDate);
                            trans.setDepreciationId(dep);
                            trans.setDescription("Calculated Depreciation Automatically...");
                            trans.setDiscount(0.0);
                            trans.setPaidAmount(depamount);
                            trans.setPrice(depamount);
                            new SaveDAOImpl().saveObject(trans);
                            amount -= depamount;
                        }
                        if (i == terms) {
                            Query uq = session.createQuery("UPDATE Depreciation d SET d.isClosed=:ic WHERE d=:did");
                            uq.setParameter("did", dep);
                            uq.setParameter("ic", true);
                            uq.executeUpdate();
                            session.flush();
                            tr.commit();
                            break;
                        }
                        ldate = dd;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
    }

    public int getDifferenceDays(Date d1, Date d2) {
        int daysdiff = 0;
        long diff = d2.getTime() - d1.getTime();
        long diffDays = diff / (24 * 60 * 60 * 1000) + 1;
        daysdiff = (int) diffDays;
        return daysdiff;
    }

}
