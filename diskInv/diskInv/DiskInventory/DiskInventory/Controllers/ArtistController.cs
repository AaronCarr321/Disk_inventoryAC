using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DiskInventory.Models;

namespace DiskInventory.Controllers
{
    public class ArtistController : Controller
    {
        private Disk_inventoryACContext context { get; set; }
        public ArtistController(Disk_inventoryACContext ctx)
        {
            context = ctx;
        }
        public IActionResult Index()
        {
            List<Artist> artists = context.Artists.OrderBy(a => a.Lname).ThenBy(a => a.Fname).ToList();
            return View(artists);
        }
    }
}
