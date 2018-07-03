using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Excel = Microsoft.Office.Interop.Excel;
using System.IO;
using ExcelImportv2.Models;
using ExcelImportv2.ViewModels;

namespace ExcelImportv2.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Importation(HttpPostedFileBase excelfile)
        {

            if (excelfile == null || excelfile.ContentLength == 0) //is a file selected?
            {
                ViewBag.Error = "Please select an excel file<br>";
                return View("Index");
            }
            else
            {
                if (excelfile.FileName.EndsWith("xls") || excelfile.FileName.EndsWith("xlsx")) //is the file an Excel file?
                {
                    string path = Server.MapPath("~/Content/" + excelfile.FileName);
                    if (System.IO.File.Exists(path))
                        System.IO.File.Delete(path); //excel does not stop, end task in task manager
                    excelfile.SaveAs(path);

                    //Read Columns, Rows, data from document
                    Excel.Application application = new Excel.Application();
                    Excel.Workbook workbook = application.Workbooks.Open(path);
                    Excel.Worksheet worksheet = workbook.ActiveSheet;
                    Excel.Range range = worksheet.UsedRange;
                    List<ShipsModel> listShips = new List<ShipsModel>();
                    for(int row = 2; row <= range.Rows.Count; row++)
                    {
                        //map values to variables
                        ShipsModel newShip = new ShipsModel();
                        newShip.Manufactuer = ((Excel.Range)range.Cells[row, 1]).Text;
                        newShip.ModelName = ((Excel.Range)range.Cells[row, 2]).Text;
                        newShip.Hardpoints = ((Excel.Range)range.Cells[row, 3]).Text;
                        newShip.TopVelocity = ((Excel.Range)range.Cells[row, 4]).Text;
                        listShips.Add(newShip);

                        using (ShipsEntities db = new ShipsEntities())
                        {
                            //map variables to db values and save
                            var dbShip = new Table();
                            dbShip.Manufactuer = newShip.Manufactuer;
                            dbShip.ModelName = newShip.ModelName;
                            dbShip.Hardpoints = newShip.Hardpoints;
                            dbShip.TopVelocity = newShip.TopVelocity;
                            db.Tables.Add(dbShip);
                            db.SaveChanges();
                        }
                    }
                    ViewBag.ListShips = listShips;
                    return View("Success");

                }
                else
                {
                    ViewBag.Error = "File type is incorrect<br>";
                    return View("Index");
                }
            }
        }
    }
}