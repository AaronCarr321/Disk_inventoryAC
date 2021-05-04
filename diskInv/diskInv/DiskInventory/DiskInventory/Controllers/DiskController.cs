using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DiskInventory.Models;

namespace DiskInventory.Controllers
{
    public class DiskController : Controller
    {
        private Disk_inventoryACContext context { get; set; }         
        public DiskController(Disk_inventoryACContext ctx)           
        {
            context = ctx;
        }
        public IActionResult Index()
        {
            List<Disk> disks = context.Disks.OrderBy(a => a.DiskName).ToList();
            return View(disks);
        }
    }
}
