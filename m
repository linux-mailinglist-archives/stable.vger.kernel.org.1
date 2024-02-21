Return-Path: <stable+bounces-22511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C685DC5C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656F9285028
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1387278B50;
	Wed, 21 Feb 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZNGu6/PL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730079DAE;
	Wed, 21 Feb 2024 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523543; cv=none; b=O9NXajC2T1t4/kG3+ZWK+bO8Atx4TDU89GCwJL4mZoLQKNhderSDCg+OGFzsnRWyB7yQN2F0M4PAu/uftIimnlOoZE1yvB4uMHvI8wlby4IcdEFFSKuY+9HXESz6Z1FECTOSTw4S6WI3RgHkYYsy5ifXE9V/ea5IxYbwCu8T7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523543; c=relaxed/simple;
	bh=prai7UZ4AAmkh3KCDdSjcbARwajcgezrdkwPd1TO9/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMFbtw5kv6DLMMPhsnNgAHgQojwqUwRKsuC0STFStbgSFWmssfvkEw/afbXsJ888C7biFs3xewB6Vi9iN6fnaFab2u7v9sWt1gUbwjzhDOUxO+oaMbh9SJOa89VDMhfWK8UlT0/C5u5yi55f7sXOvZaKrhNQ6qElbqbJwlIPuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZNGu6/PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEFAC433F1;
	Wed, 21 Feb 2024 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523543;
	bh=prai7UZ4AAmkh3KCDdSjcbARwajcgezrdkwPd1TO9/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNGu6/PLWPv9WSLpny0vMam0XkNGskXvpYlczWma9Qp7+po2aRC3dJKLUlM5Cm5PK
	 F4g4z+FW5l/yRv3JKyEECUnyDfhTczaBEE439thgXncfUMAqPPozK/y8SG9k1F9G/0
	 GBD/TSMNAXxoD2GeNO6fgndcFRro2eXp684sX//0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 450/476] fbdev: Rename pagelist to pagereflist for deferred I/O
Date: Wed, 21 Feb 2024 14:08:21 +0100
Message-ID: <20240221130024.668869469@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit e80eec1b871a2acb8f5c92db4c237e9ae6dd322b ]

Rename various instances of pagelist to pagereflist. The list now
stores pageref structures, so the new name is more appropriate.

In their write-back helpers, several fbdev drivers refer to the
pageref list in struct fb_deferred_io instead of using the one
supplied as argument to the function. Convert them over to the
supplied one. It's the same instance, so no change of behavior
occurs.

v4:
	* fix commit message (Javier)

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220429100834.18898-5-tzimmermann@suse.de
Stable-dep-of: 33cd6ea9c067 ("fbdev: flush deferred IO before closing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fb_helper.c        |  7 +++----
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c     |  5 ++---
 drivers/hid/hid-picolcd_fb.c           |  2 +-
 drivers/staging/fbtft/fbtft-core.c     | 10 +++++-----
 drivers/video/fbdev/broadsheetfb.c     | 12 +++++-------
 drivers/video/fbdev/core/fb_defio.c    | 18 +++++++++---------
 drivers/video/fbdev/hecubafb.c         |  3 +--
 drivers/video/fbdev/hyperv_fb.c        |  5 ++---
 drivers/video/fbdev/metronomefb.c      | 12 +++++-------
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 16 +++++++---------
 drivers/video/fbdev/smscufx.c          |  8 +++-----
 drivers/video/fbdev/ssd1307fb.c        |  3 +--
 drivers/video/fbdev/udlfb.c            |  8 +++-----
 drivers/video/fbdev/xen-fbfront.c      |  5 ++---
 include/drm/drm_fb_helper.h            |  3 +--
 include/linux/fb.h                     |  6 +++---
 16 files changed, 53 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 888ec6135544..82960d5d4e73 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -683,13 +683,12 @@ static void drm_fb_helper_damage(struct fb_info *info, u32 x, u32 y,
 /**
  * drm_fb_helper_deferred_io() - fbdev deferred_io callback function
  * @info: fb_info struct pointer
- * @pagelist: list of mmap framebuffer pages that have to be flushed
+ * @pagereflist: list of mmap framebuffer pages that have to be flushed
  *
  * This function is used as the &fb_deferred_io.deferred_io
  * callback function for flushing the fbdev mmap writes.
  */
-void drm_fb_helper_deferred_io(struct fb_info *info,
-			       struct list_head *pagelist)
+void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	unsigned long start, end, min, max;
 	struct fb_deferred_io_pageref *pageref;
@@ -697,7 +696,7 @@ void drm_fb_helper_deferred_io(struct fb_info *info,
 
 	min = ULONG_MAX;
 	max = 0;
-	list_for_each_entry(pageref, pagelist, list) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		start = pageref->offset;
 		end = start + PAGE_SIZE - 1;
 		min = min(min, start);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
index 1f20e3c958ef..79b08e927f76 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -316,8 +316,7 @@ static int vmw_fb_pan_display(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-static void vmw_deferred_io(struct fb_info *info,
-			    struct list_head *pagelist)
+static void vmw_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	struct vmw_fb_par *par = info->par;
 	unsigned long start, end, min, max;
@@ -327,7 +326,7 @@ static void vmw_deferred_io(struct fb_info *info,
 
 	min = ULONG_MAX;
 	max = 0;
-	list_for_each_entry(pageref, pagelist, list) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		struct page *page = pageref->page;
 		start = page->index << PAGE_SHIFT;
 		end = start + PAGE_SIZE - 1;
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index 33c102a60992..8a0d1365cd72 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -432,7 +432,7 @@ static const struct fb_ops picolcdfb_ops = {
 
 
 /* Callback from deferred IO workqueue */
-static void picolcd_fb_deferred_io(struct fb_info *info, struct list_head *pagelist)
+static void picolcd_fb_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	picolcd_fb_update(info);
 }
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 5c52b5ff9f51..7aec35ae5cd5 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -322,7 +322,7 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
 }
 
-static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagelist)
+static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	struct fbtft_par *par = info->par;
 	unsigned int dirty_lines_start, dirty_lines_end;
@@ -340,7 +340,7 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagelist)
 	spin_unlock(&par->dirty_lock);
 
 	/* Mark display lines as dirty */
-	list_for_each_entry(pageref, pagelist, list) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		struct page *page = pageref->page;
 		count++;
 		index = page->index << PAGE_SHIFT;
@@ -654,9 +654,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	fbops->fb_setcolreg =      fbtft_fb_setcolreg;
 	fbops->fb_blank     =      fbtft_fb_blank;
 
-	fbdefio->delay =           HZ / fps;
-	fbdefio->sort_pagelist =   true;
-	fbdefio->deferred_io =     fbtft_deferred_io;
+	fbdefio->delay =            HZ / fps;
+	fbdefio->sort_pagereflist = true;
+	fbdefio->deferred_io =      fbtft_deferred_io;
 	fb_deferred_io_init(info);
 
 	snprintf(info->fix.id, sizeof(info->fix.id), "%s", dev->driver->name);
diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index 2ca753d27f76..8b953d20ccdc 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -929,13 +929,11 @@ static void broadsheetfb_dpy_update(struct broadsheetfb_par *par)
 }
 
 /* this is called back from the deferred io workqueue */
-static void broadsheetfb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void broadsheetfb_dpy_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	u16 y1 = 0, h = 0;
 	int prev_index = -1;
 	struct fb_deferred_io_pageref *pageref;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
 	int h_inc;
 	u16 yres = info->var.yres;
 	u16 xres = info->var.xres;
@@ -944,7 +942,7 @@ static void broadsheetfb_dpy_deferred_io(struct fb_info *info,
 	h_inc = DIV_ROUND_UP(PAGE_SIZE , xres);
 
 	/* walk the written page list and swizzle the data */
-	list_for_each_entry(pageref, &fbdefio->pagelist, list) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		struct page *cur = pageref->page;
 		if (prev_index < 0) {
 			/* just starting so assign first page */
@@ -1059,9 +1057,9 @@ static const struct fb_ops broadsheetfb_ops = {
 };
 
 static struct fb_deferred_io broadsheetfb_defio = {
-	.delay		= HZ/4,
-	.sort_pagelist	= true,
-	.deferred_io	= broadsheetfb_dpy_deferred_io,
+	.delay			= HZ/4,
+	.sort_pagereflist	= true,
+	.deferred_io		= broadsheetfb_dpy_deferred_io,
 };
 
 static int broadsheetfb_probe(struct platform_device *dev)
diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index a79af3b5faf3..5faeca61d3dd 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -41,7 +41,7 @@ static struct fb_deferred_io_pageref *fb_deferred_io_pageref_get(struct fb_info
 								 struct page *page)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
-	struct list_head *pos = &fbdefio->pagelist;
+	struct list_head *pos = &fbdefio->pagereflist;
 	unsigned long pgoff = offset >> PAGE_SHIFT;
 	struct fb_deferred_io_pageref *pageref, *cur;
 
@@ -63,7 +63,7 @@ static struct fb_deferred_io_pageref *fb_deferred_io_pageref_get(struct fb_info
 	pageref->page = page;
 	pageref->offset = pgoff << PAGE_SHIFT;
 
-	if (unlikely(fbdefio->sort_pagelist)) {
+	if (unlikely(fbdefio->sort_pagereflist)) {
 		/*
 		 * We loop through the list of pagerefs before adding in
 		 * order to keep the pagerefs sorted. This has significant
@@ -71,7 +71,7 @@ static struct fb_deferred_io_pageref *fb_deferred_io_pageref_get(struct fb_info
 		 * pages. If possible, drivers should try to work with
 		 * unsorted page lists instead.
 		 */
-		list_for_each_entry(cur, &info->fbdefio->pagelist, list) {
+		list_for_each_entry(cur, &fbdefio->pagereflist, list) {
 			if (cur->offset > pageref->offset)
 				break;
 		}
@@ -163,7 +163,7 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	mutex_lock(&fbdefio->lock);
 
 	/* first write in this cycle, notify the driver */
-	if (fbdefio->first_io && list_empty(&fbdefio->pagelist))
+	if (fbdefio->first_io && list_empty(&fbdefio->pagereflist))
 		fbdefio->first_io(info);
 
 	pageref = fb_deferred_io_pageref_get(info, offset, page);
@@ -228,18 +228,18 @@ static void fb_deferred_io_work(struct work_struct *work)
 
 	/* here we mkclean the pages, then do all deferred IO */
 	mutex_lock(&fbdefio->lock);
-	list_for_each_entry(pageref, &fbdefio->pagelist, list) {
+	list_for_each_entry(pageref, &fbdefio->pagereflist, list) {
 		struct page *cur = pageref->page;
 		lock_page(cur);
 		page_mkclean(cur);
 		unlock_page(cur);
 	}
 
-	/* driver's callback with pagelist */
-	fbdefio->deferred_io(info, &fbdefio->pagelist);
+	/* driver's callback with pagereflist */
+	fbdefio->deferred_io(info, &fbdefio->pagereflist);
 
 	/* clear the list */
-	list_for_each_entry_safe(pageref, next, &fbdefio->pagelist, list)
+	list_for_each_entry_safe(pageref, next, &fbdefio->pagereflist, list)
 		fb_deferred_io_pageref_put(pageref, info);
 
 	mutex_unlock(&fbdefio->lock);
@@ -259,7 +259,7 @@ int fb_deferred_io_init(struct fb_info *info)
 
 	mutex_init(&fbdefio->lock);
 	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
-	INIT_LIST_HEAD(&fbdefio->pagelist);
+	INIT_LIST_HEAD(&fbdefio->pagereflist);
 	if (fbdefio->delay == 0) /* set a default of 1 s */
 		fbdefio->delay = HZ;
 
diff --git a/drivers/video/fbdev/hecubafb.c b/drivers/video/fbdev/hecubafb.c
index 00d77105161a..bd6b0dec414b 100644
--- a/drivers/video/fbdev/hecubafb.c
+++ b/drivers/video/fbdev/hecubafb.c
@@ -115,8 +115,7 @@ static void hecubafb_dpy_update(struct hecubafb_par *par)
 }
 
 /* this is called back from the deferred io workqueue */
-static void hecubafb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void hecubafb_dpy_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	hecubafb_dpy_update(info->par);
 }
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 704ba7ee13c6..6a881cfd7f5c 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -420,8 +420,7 @@ static void hvfb_docopy(struct hvfb_par *par,
 }
 
 /* Deferred IO callback */
-static void synthvid_deferred_io(struct fb_info *p,
-				 struct list_head *pagelist)
+static void synthvid_deferred_io(struct fb_info *p, struct list_head *pagereflist)
 {
 	struct hvfb_par *par = p->par;
 	struct fb_deferred_io_pageref *pageref;
@@ -437,7 +436,7 @@ static void synthvid_deferred_io(struct fb_info *p,
 	 * in synthvid_update function by clamping the y2
 	 * value to yres.
 	 */
-	list_for_each_entry(pageref, pagelist, list) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		struct page *page = pageref->page;
 		start = page->index << PAGE_SHIFT;
 		end = start + PAGE_SIZE - 1;
diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index 74672539ee7b..b8df0bb7cabc 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -465,16 +465,14 @@ static u16 metronomefb_dpy_update_page(struct metronomefb_par *par, int index)
 }
 
 /* this is called back from the deferred io workqueue */
-static void metronomefb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void metronomefb_dpy_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	u16 cksum;
 	struct fb_deferred_io_pageref *pageref;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct metronomefb_par *par = info->par;
 
 	/* walk the written page list and swizzle the data */
-	list_for_each_entry(pageref, &fbdefio->pagelist, list) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		struct page *cur = pageref->page;
 		cksum = metronomefb_dpy_update_page(par,
 					(cur->index << PAGE_SHIFT));
@@ -568,9 +566,9 @@ static const struct fb_ops metronomefb_ops = {
 };
 
 static struct fb_deferred_io metronomefb_defio = {
-	.delay		= HZ,
-	.sort_pagelist	= true,
-	.deferred_io	= metronomefb_dpy_deferred_io,
+	.delay			= HZ,
+	.sort_pagereflist	= true,
+	.deferred_io		= metronomefb_dpy_deferred_io,
 };
 
 static int metronomefb_probe(struct platform_device *dev)
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index b6b5ce3505c0..e33c016c5428 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -435,8 +435,7 @@ static struct sh_mobile_lcdc_sys_bus_ops sh_mobile_lcdc_sys_bus_ops = {
 	.read_data	= lcdc_sys_read_data,
 };
 
-static int sh_mobile_lcdc_sginit(struct fb_info *info,
-				  struct list_head *pagelist)
+static int sh_mobile_lcdc_sginit(struct fb_info *info, struct list_head *pagereflist)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	unsigned int nr_pages_max = ch->fb_size >> PAGE_SHIFT;
@@ -445,7 +444,7 @@ static int sh_mobile_lcdc_sginit(struct fb_info *info,
 
 	sg_init_table(ch->sglist, nr_pages_max);
 
-	list_for_each_entry(pageref, pagelist, list) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		struct page *page = pageref->page;
 		sg_set_page(&ch->sglist[nr_pages++], page, PAGE_SIZE, 0);
 	}
@@ -453,8 +452,7 @@ static int sh_mobile_lcdc_sginit(struct fb_info *info,
 	return nr_pages;
 }
 
-static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
-				       struct list_head *pagelist)
+static void sh_mobile_lcdc_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	const struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg->panel_cfg;
@@ -463,7 +461,7 @@ static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
 	sh_mobile_lcdc_clk_on(ch->lcdc);
 
 	/*
-	 * It's possible to get here without anything on the pagelist via
+	 * It's possible to get here without anything on the pagereflist via
 	 * sh_mobile_lcdc_deferred_io_touch() or via a userspace fsync()
 	 * invocation. In the former case, the acceleration routines are
 	 * stepped in to when using the framebuffer console causing the
@@ -473,12 +471,12 @@ static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
 	 * acceleration routines have their own methods for writing in
 	 * that still need to be updated.
 	 *
-	 * The fsync() and empty pagelist case could be optimized for,
+	 * The fsync() and empty pagereflist case could be optimized for,
 	 * but we don't bother, as any application exhibiting such
 	 * behaviour is fundamentally broken anyways.
 	 */
-	if (!list_empty(pagelist)) {
-		unsigned int nr_pages = sh_mobile_lcdc_sginit(info, pagelist);
+	if (!list_empty(pagereflist)) {
+		unsigned int nr_pages = sh_mobile_lcdc_sginit(info, pagereflist);
 
 		/* trigger panel update */
 		dma_map_sg(ch->lcdc->dev, ch->sglist, nr_pages, DMA_TO_DEVICE);
diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index bf3d151abd6f..14e4e106d26b 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -953,12 +953,10 @@ static void ufx_ops_fillrect(struct fb_info *info,
  *   Touching ANY framebuffer memory that triggers a page fault
  *   in fb_defio will cause a deadlock, when it also tries to
  *   grab the same mutex. */
-static void ufx_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void ufx_dpy_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
-	struct fb_deferred_io_pageref *pageref;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct ufx_data *dev = info->par;
+	struct fb_deferred_io_pageref *pageref;
 
 	if (!fb_defio)
 		return;
@@ -967,7 +965,7 @@ static void ufx_dpy_deferred_io(struct fb_info *info,
 		return;
 
 	/* walk the written page list and render each to device */
-	list_for_each_entry(pageref, &fbdefio->pagelist, list) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		/* create a rectangle of full screen width that encloses the
 		 * entire dirty framebuffer page */
 		struct page *cur = pageref->page;
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 1e2f71c2f8a8..7acf7c0b263e 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -370,8 +370,7 @@ static const struct fb_ops ssd1307fb_ops = {
 	.fb_imageblit	= ssd1307fb_imageblit,
 };
 
-static void ssd1307fb_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void ssd1307fb_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	ssd1307fb_update_display(info->par);
 }
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index c187163fe580..12bd5a7318e1 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -780,11 +780,9 @@ static void dlfb_ops_fillrect(struct fb_info *info,
  *   in fb_defio will cause a deadlock, when it also tries to
  *   grab the same mutex.
  */
-static void dlfb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void dlfb_dpy_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	struct fb_deferred_io_pageref *pageref;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct dlfb_data *dlfb = info->par;
 	struct urb *urb;
 	char *cmd;
@@ -810,7 +808,7 @@ static void dlfb_dpy_deferred_io(struct fb_info *info,
 	cmd = urb->transfer_buffer;
 
 	/* walk the written page list and render each to device */
-	list_for_each_entry(pageref, &fbdefio->pagelist, list) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		struct page *cur = pageref->page;
 
 		if (dlfb_render_hline(dlfb, &urb, (char *) info->fix.smem_start,
@@ -983,7 +981,7 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 
 		if (fbdefio) {
 			fbdefio->delay = DL_DEFIO_WRITE_DELAY;
-			fbdefio->sort_pagelist = true;
+			fbdefio->sort_pagereflist = true;
 			fbdefio->deferred_io = dlfb_dpy_deferred_io;
 		}
 
diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 00d9502ee25a..37e3f226f78c 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -181,8 +181,7 @@ static void xenfb_refresh(struct xenfb_info *info,
 		xenfb_do_update(info, x1, y1, x2 - x1 + 1, y2 - y1 + 1);
 }
 
-static void xenfb_deferred_io(struct fb_info *fb_info,
-			      struct list_head *pagelist)
+static void xenfb_deferred_io(struct fb_info *fb_info, struct list_head *pagereflist)
 {
 	struct xenfb_info *info = fb_info->par;
 	struct fb_deferred_io_pageref *pageref;
@@ -191,7 +190,7 @@ static void xenfb_deferred_io(struct fb_info *fb_info,
 
 	miny = INT_MAX;
 	maxy = 0;
-	list_for_each_entry(pageref, pagelist, list) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		struct page *page = pageref->page;
 		beg = page->index << PAGE_SHIFT;
 		end = beg + PAGE_SIZE - 1;
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 3af4624368d8..329607ca65c0 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -229,8 +229,7 @@ void drm_fb_helper_fill_info(struct fb_info *info,
 			     struct drm_fb_helper *fb_helper,
 			     struct drm_fb_helper_surface_size *sizes);
 
-void drm_fb_helper_deferred_io(struct fb_info *info,
-			       struct list_head *pagelist);
+void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagereflist);
 
 ssize_t drm_fb_helper_sys_read(struct fb_info *info, char __user *buf,
 			       size_t count, loff_t *ppos);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 768de6534a82..b322d30f6225 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -211,9 +211,9 @@ struct fb_deferred_io_pageref {
 struct fb_deferred_io {
 	/* delay between mkwrite and deferred handler */
 	unsigned long delay;
-	bool sort_pagelist; /* sort pagelist by offset */
-	struct mutex lock; /* mutex that protects the page list */
-	struct list_head pagelist; /* list of touched pages */
+	bool sort_pagereflist; /* sort pagelist by offset */
+	struct mutex lock; /* mutex that protects the pageref list */
+	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
 	void (*first_io)(struct fb_info *info);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
-- 
2.43.0




