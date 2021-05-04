using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DiskInventory.Models;

namespace DiskInventory.Controllers
{
    public class BorrowerController : Controller
    {
        private Disk_inventoryACContext context { get; set; }           // Student context name will differ
        public BorrowerController(Disk_inventoryACContext ctx)            // Student context name will differ
        {
            context = ctx;
        }
        public IActionResult Index()
        {
            List<Borrower> borrowers = context.Borrowers.OrderBy(a => a.Lname).ToList();
            return View(borrowers);
        }
    }
}
