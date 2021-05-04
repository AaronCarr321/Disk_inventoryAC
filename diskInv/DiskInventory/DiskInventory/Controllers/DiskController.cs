using DiskInventory.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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
            //var disks = context.Disks.ToList();
            var disks = context.Disks.OrderBy(d => d.DiskName).ThenBy(s => s.StatusId).ToList();
            return View(disks);
        }
        [HttpGet]
        public IActionResult Add()      //
        {
            ViewBag.Action = "Add";
            ViewBag.Genres = context.Genres.OrderBy(g => g.Description).ToList();
            ViewBag.Statuses = context.Statuses.OrderBy(s => s.Description).ToList();
            ViewBag.DiskTypes = context.DiskTypes.OrderBy(dt => dt.Description).ToList();
            Disk newdisk = new Disk();
            newdisk.ReleaseDate = DateTime.Today;
            return View("Edit", newdisk);
        }
        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.Genres = context.Genres.OrderBy(g => g.Description).ToList();
            ViewBag.Statuses = context.Statuses.OrderBy(s => s.Description).ToList();
            ViewBag.DiskTypes = context.DiskTypes.OrderBy(dt => dt.Description).ToList();
            var disk = context.Disks.Find(id);
            return View(disk);
        }
        [HttpPost]
        public IActionResult Edit(Disk disk)
        {
            if (ModelState.IsValid)
            {
                if (disk.DiskId == 0)
                {
                    context.Disks.Add(disk);
                }
                else
                {
                    context.Disks.Update(disk);
                }
                context.SaveChanges();
                return RedirectToAction("Index", "Disk");
            }
            else
            {
                ViewBag.Action = (disk.DiskId == 0) ? "Add" : "Edit";
                //ViewBag.DiskTypes = context.DiskTypes.OrderBy(t => t.Description).ToList();
                ViewBag.Genres = context.Genres.OrderBy(g => g.Description).ToList();
                ViewBag.Statuses = context.Statuses.OrderBy(s => s.Description).ToList();
                ViewBag.DiskTypes = context.DiskTypes.OrderBy(dt => dt.Description).ToList();
                return View(disk);
            }
        }
        [HttpGet]
        public IActionResult Delete(int id)
        {
            var disk = context.Disks.Find(id);
            return View(disk);
        }

        [HttpPost]
        public IActionResult Delete(Disk disk)
        {
            context.Disks.Remove(disk);
            context.SaveChanges();
            return RedirectToAction("Index", "Disk");
        }
    }
}
