/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.controller;

import com.vertec.daoimpl.DashboardDAOImpl;
import com.vertec.daoimpl.ReportDAOImpl;
import com.vertec.hibe.model.Account;
import com.vertec.hibe.model.BalanceSheetData;
import com.vertec.hibe.model.Company;
import com.vertec.hibe.model.DepreciationData;
import com.vertec.hibe.model.SysUser;
import com.vertec.hibe.model.Transaction;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Java-Dev-Ruchira
 */
@WebServlet(name = "ReportController", urlPatterns = {"/ReportController"})
public class ReportController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final ReportDAOImpl reportdao = new ReportDAOImpl();
    private final DashboardDAOImpl dashboarddao = new DashboardDAOImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String action = request.getParameter("action");
            HttpSession httpSession = request.getSession();
            SysUser user1 = (SysUser) httpSession.getAttribute("user");
            Company company = (Company) httpSession.getAttribute("company");
            RequestDispatcher requestDispatcher;

            switch (action) {

                case "ViewAssets": { // load asset page
                    requestDispatcher = request.getRequestDispatcher("/app/reports/toAssets.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "loadJournalEntries": { // load  Journal Entries
                    requestDispatcher = request.getRequestDispatcher("/app/reports/JournalEntries.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "loadJournalEntriesPage": { // load Journal Entries Page
                    String frdate = request.getParameter("fromDay").trim();
                    String todate = request.getParameter("toDate").trim();
                    try {
                        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
                        Date fdate = sd.parse(frdate);
                        Date toodate = sd.parse(todate);
                        List<Transaction> tList = reportdao.loadAllOfAccountByPayType(fdate, toodate, company);
                        request.setAttribute("transaction", tList);
                        request.setAttribute("date", new Date().toString());
                        request.setAttribute("from", frdate);
                        request.setAttribute("to", todate);
                        requestDispatcher = request.getRequestDispatcher("/app/reports/ReportJounal.jsp");
                        requestDispatcher.forward(request, response);
                    } catch (Exception e) {
                    }
                    break;
                }
                case "PrintAssetReport": { // print assest report
                    String acc = request.getParameter("acc");
                    String from = request.getParameter("from");
                    String to = request.getParameter("to");

                    System.out.println(acc);
                    System.out.println(from);
                    System.out.println(to);
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date fromDate = null;
                    Date toDate = null;
                    try {
                        fromDate = sdf.parse(from);
                        toDate = sdf.parse(to);
                    } catch (ParseException ex) {
                        Logger.getLogger(ReportController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    List<Transaction> credit = reportdao.loadAssetCreditSide(new Account(Integer.parseInt(acc)), fromDate, toDate, company);
                    List<Transaction> debit = reportdao.loadAssetDebitSide(new Account(Integer.parseInt(acc)), fromDate, toDate, company);
                    request.setAttribute("accname", reportdao.getAccountById(Integer.parseInt(acc)).getName());
                    request.setAttribute("from", from);
                    request.setAttribute("to", to);
                    request.setAttribute("credit", credit);
                    request.setAttribute("debit", debit);
                    request.setAttribute("balanceback", reportdao.loadBalanceBackward(new Account(Integer.parseInt(acc)), fromDate, company));
                    request.setAttribute("openbal", reportdao.getAccountOpenBalance(Integer.parseInt(acc)));
                    request.setAttribute("debit", debit);
                    request.setAttribute("date", new Date().toString());
                    requestDispatcher = request.getRequestDispatcher("/app/reports/PrintAsset.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "loadProfitLossPage": { // load profit loss page 
                    requestDispatcher = request.getRequestDispatcher("/app/reports/ProfitLoss.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "listOfAcctByCash": { // get the details of cash account
                    String fdate = request.getParameter("fromDay").trim();
                    String todate = request.getParameter("toDay").trim();
                    try {
                        List<Account> aList = reportdao.loadAllOfAccountByCash1(company);
                        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
                        Date fromDate = sd.parse(fdate);
                        Date toDate = sd.parse(todate);
                        reportdao.CalculateDepreciation(fromDate, toDate, company);
                        List<String[]> arr = reportdao.loadAccountsForProfit(aList, fromDate, toDate);
                        List<DepreciationData> dep = reportdao.getDepreciationData(fromDate, toDate, company);
                        request.setAttribute("arr", arr);
                        request.setAttribute("dep", dep);
                        request.setAttribute("date", new Date());
                        request.setAttribute("from", fdate);
                        request.setAttribute("to", todate);
                        requestDispatcher = request.getRequestDispatcher("/app/reports/ReportProfitLoss.jsp");
                        requestDispatcher.forward(request, response);
                    } catch (ParseException ex) {
                        Logger.getLogger(ReportController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                case "ViewCreateTrialBalance": { // load trail balance page
                    requestDispatcher = request.getRequestDispatcher("/app/reports/toTrialBalance.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "ViewCreateBalanceSheet": { // load to create the balance sheet
                    requestDispatcher = request.getRequestDispatcher("/app/reports/toBalanceSheet.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "PrintBalanceSheetReport": { // print the balnce sheet
                    String from = request.getParameter("from");
                    String to = request.getParameter("to");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date fromDate = null;
                    Date toDate = null;
                    try {
                        fromDate = sdf.parse(from);
                        toDate = sdf.parse(to);
                    } catch (ParseException ex) {
                        Logger.getLogger(ReportController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    reportdao.CalculateDepreciation(fromDate, toDate, company);
                    List<BalanceSheetData> starr = reportdao.getBalanceSheetData(fromDate, toDate, company);
                    List<DepreciationData> dep = reportdao.getDepreciationData(fromDate, toDate, company);

                    List<Account> aList = reportdao.loadAllOfAccountByCash1(company);
                    List<String[]> arr = reportdao.loadAccountsForProfit(aList, fromDate, toDate);

                    Double debit = 0.0;
                    Double credit = 0.0;
                    for (String[] a : arr) {

                        if (Double.parseDouble(a[1]) < 0) {
                            credit += ((-1) * Double.parseDouble(a[1]));
                        } else {
                            debit += Double.parseDouble(a[1]);
                        }
                    }
                    for (DepreciationData d : dep) {
                        
                        double depreamount=0;
                        double damount=0;
                        double Beforedep=0;
                        
                        
                        if(d.getDepreciation().getAmount() !=null){
                            depreamount=d.getDepreciation().getAmount();
                        }
                        if(d.getAmount() !=null){
                            damount=d.getAmount();
                        }
                        if(d.getBeforedep() !=null){
                            Beforedep=d.getBeforedep();
                        }
                            
                            
                            
                        debit+=depreamount-damount-Beforedep;
//                        debit += d.getDepreciation().getAmount() - d.getAmount() - d.getBeforedep();
                    }

                    request.setAttribute("data", starr);
                    request.setAttribute("dep", dep);
                    request.setAttribute("from", from);
                    request.setAttribute("to", to);
                    request.setAttribute("date", new Date().toString());
                    request.setAttribute("profit", (debit - credit));
                    requestDispatcher = request.getRequestDispatcher("/app/reports/PrintBalanceSheet.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "PrintTrialBalanceReport": { // print trail balnce sheet

                    String from = request.getParameter("from");
                    String to = request.getParameter("to");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date fromDate = null;
                    Date toDate = null;
                    try {
                        fromDate = sdf.parse(from);
                        toDate = sdf.parse(to);
                    } catch (ParseException ex) {
                        Logger.getLogger(ReportController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    List<String[]> starr = reportdao.loadTrialbalance(fromDate, toDate, company);

                    request.setAttribute("data", starr);
                    request.setAttribute("from", from);
                    request.setAttribute("to", to);
                    request.setAttribute("date", new Date().toString());
                    requestDispatcher = request.getRequestDispatcher("/app/reports/PrintTrialBalance.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "toLedgerAccounts": { // load to create  leger account 
                    List<Account> acc = reportdao.getAccountsByCompany(company);
                    request.setAttribute("account", acc);
                    requestDispatcher = request.getRequestDispatcher("/app/reports/toLedgerAccounts.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "PrintLedgerAccounts": { //print the leger acconts
                    String acc = request.getParameter("acc");
                    String from = request.getParameter("from");
                    String to = request.getParameter("to");

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date fromDate = null;
                    Date toDate = null;
                    try {
                        fromDate = sdf.parse(from);
                        toDate = sdf.parse(to);
                    } catch (ParseException ex) {
                        Logger.getLogger(ReportController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    List<Account> account = reportdao.getAccountsByCompany(company, acc);
                    request.setAttribute("account", account);
                    request.setAttribute("from", fromDate);
                    request.setAttribute("to", toDate);
                    requestDispatcher = request.getRequestDispatcher("/app/reports/PrintLedgerAccounts.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "dashboard": { // to print the dash board elements
                    
                    JSONObject jOB = new JSONObject();
                    JSONArray jar1 = new JSONArray();
                    JSONObject job1 = new JSONObject();
                    job1.put("liblitity", dashboarddao.getLiabilities(company));
                    job1.put("debtors", dashboarddao.getDebtorsAmount(company));
                    job1.put("income", dashboarddao.getIncomeAmount(company));
                    job1.put("expense", dashboarddao.getExpences(company));
                    job1.put("account", dashboarddao.getAccount(company));
//                    job1.put("incompleted", dashboarddao.getincompletedProject());
//                    job1.put("hold", dashboarddao.getHoldProject());
//                    job1.put("ongoing", dashboarddao.getOngoingProject());
                    
                    jar1.add(job1);
                    jOB.put("des", jar1);
                    response.getWriter().write(jOB.toString());
                    break;
                }
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
