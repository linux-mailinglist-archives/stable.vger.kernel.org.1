Return-Path: <stable+bounces-161198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B93AFD3D2
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0136016DF1A
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F172E612D;
	Tue,  8 Jul 2025 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zIoJNjLu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F35C2E091E;
	Tue,  8 Jul 2025 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993878; cv=none; b=eiIEVIjFAM4jBQgh319lZIroR4r54KGVBF2wShpDgZxE4coOxvembDca7JKyd6dvmMej42WOuU/rNhThsW+zikzmbzN9ckOfrKdLWcX5QrRyhKQjKYpLNrK36ENPvZ3dr3JR78Tb1ls1opZXSkcAgjHw9l621KOVzAmCVtmfA2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993878; c=relaxed/simple;
	bh=nhvbr2WvRLbuzWlUQENTWqIXJuhT3qAOZvYJxbk1jVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZeOr8nsqbxD+dqEu3UOOvYGmRxn/yjJSBWvC/NdMDE97K7migoCBQxsPPkPc4UBpoFyJzeWi67S0BzWC4RJhsx2IzHxQnYDk2J+a9o9u9QWlTVB7L8XykwrAqeKwn3GhX6HywrBJKh7cLON2R6PQYLCrPBSTlRi/w4gmWYtCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zIoJNjLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E86EC4CEED;
	Tue,  8 Jul 2025 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993878;
	bh=nhvbr2WvRLbuzWlUQENTWqIXJuhT3qAOZvYJxbk1jVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zIoJNjLuPybAgDYn1CYhkTjF/MXXJ8XoTxFSUxKHR7O+radRUHoikR2Fs9LnHfIM/
	 ri74rUyUYKHWuK9DLXVr25v5vEn4p8L/n9b4oV9fqW+d2gi+9lO4aPQRxKm2nhlnYy
	 8rImQZvNi9gH2apB8xTwDOHf94tbypSpgz89/w8o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Slaby <jslaby@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 050/160] tty/vt: consolemap: rename and document struct uni_pagedir
Date: Tue,  8 Jul 2025 18:21:27 +0200
Message-ID: <20250708162232.928467277@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit 4173f018aae16b6496d292c234b858241f85254f ]

struct uni_pagedir contains 32 unicode page directories, so the name of
the structure is a bit misleading. Rename the structure to uni_pagedict,
so it looks like this:
struct uni_pagedict
  -> 32 page dirs
     -> 32 rows
       -> 64 glyphs

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20220607104946.18710-2-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 03bcbbb3995b ("dummycon: Trigger redraw when switching consoles with deferred takeover")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/consolemap.c    | 47 ++++++++++++++++++++--------------
 drivers/video/console/vgacon.c |  4 +--
 include/linux/console_struct.h |  6 ++---
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index d815ac98b39e3..32fa4df121dab 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -186,17 +186,26 @@ static unsigned short translations[][256] = {
 
 static int inv_translate[MAX_NR_CONSOLES];
 
-struct uni_pagedir {
-	u16 		**uni_pgdir[32];
+/**
+ * struct uni_pagedict -- unicode directory
+ *
+ * @uni_pgdir: 32*32*64 table with glyphs
+ * @refcount: reference count of this structure
+ * @sum: checksum
+ * @inverse_translations: best-effort inverse mapping
+ * @inverse_trans_unicode: best-effort inverse mapping to unicode
+ */
+struct uni_pagedict {
+	u16		**uni_pgdir[32];
 	unsigned long	refcount;
 	unsigned long	sum;
 	unsigned char	*inverse_translations[4];
 	u16		*inverse_trans_unicode;
 };
 
-static struct uni_pagedir *dflt;
+static struct uni_pagedict *dflt;
 
-static void set_inverse_transl(struct vc_data *conp, struct uni_pagedir *p, int i)
+static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p, int i)
 {
 	int j, glyph;
 	unsigned short *t = translations[i];
@@ -221,7 +230,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedir *p, int
 }
 
 static void set_inverse_trans_unicode(struct vc_data *conp,
-				      struct uni_pagedir *p)
+				      struct uni_pagedict *p)
 {
 	int i, j, k, glyph;
 	u16 **p1, *p2;
@@ -270,7 +279,7 @@ unsigned short *set_translate(int m, struct vc_data *vc)
  */
 u16 inverse_translate(const struct vc_data *conp, int glyph, int use_unicode)
 {
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
 	int m;
 	if (glyph < 0 || glyph >= MAX_GLYPH)
 		return 0;
@@ -297,7 +306,7 @@ EXPORT_SYMBOL_GPL(inverse_translate);
 static void update_user_maps(void)
 {
 	int i;
-	struct uni_pagedir *p, *q = NULL;
+	struct uni_pagedict *p, *q = NULL;
 	
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (!vc_cons_allocated(i))
@@ -393,7 +402,7 @@ int con_get_trans_new(ushort __user * arg)
 extern u8 dfont_unicount[];	/* Defined in console_defmap.c */
 extern u16 dfont_unitable[];
 
-static void con_release_unimap(struct uni_pagedir *p)
+static void con_release_unimap(struct uni_pagedict *p)
 {
 	u16 **p1;
 	int i, j;
@@ -419,7 +428,7 @@ static void con_release_unimap(struct uni_pagedir *p)
 /* Caller must hold the console lock */
 void con_free_unimap(struct vc_data *vc)
 {
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
 
 	p = *vc->vc_uni_pagedir_loc;
 	if (!p)
@@ -431,10 +440,10 @@ void con_free_unimap(struct vc_data *vc)
 	kfree(p);
 }
   
-static int con_unify_unimap(struct vc_data *conp, struct uni_pagedir *p)
+static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *p)
 {
 	int i, j, k;
-	struct uni_pagedir *q;
+	struct uni_pagedict *q;
 	
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (!vc_cons_allocated(i))
@@ -472,7 +481,7 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedir *p)
 }
 
 static int
-con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
+con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 {
 	int i, n;
 	u16 **p1, *p2;
@@ -503,7 +512,7 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 /* Caller must hold the lock */
 static int con_do_clear_unimap(struct vc_data *vc)
 {
-	struct uni_pagedir *p, *q;
+	struct uni_pagedict *p, *q;
 
 	p = *vc->vc_uni_pagedir_loc;
 	if (!p || --p->refcount) {
@@ -536,7 +545,7 @@ int con_clear_unimap(struct vc_data *vc)
 int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 {
 	int err = 0, err1, i;
-	struct uni_pagedir *p, *q;
+	struct uni_pagedict *p, *q;
 	struct unipair *unilist, *plist;
 
 	if (!ct)
@@ -569,7 +578,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 		
 		/*
 		 * Since refcount was > 1, con_clear_unimap() allocated a
-		 * a new uni_pagedir for this vc.  Re: p != q
+		 * a new uni_pagedict for this vc.  Re: p != q
 		 */
 		q = *vc->vc_uni_pagedir_loc;
 
@@ -660,7 +669,7 @@ int con_set_default_unimap(struct vc_data *vc)
 {
 	int i, j, err = 0, err1;
 	u16 *q;
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
 
 	if (dflt) {
 		p = *vc->vc_uni_pagedir_loc;
@@ -714,7 +723,7 @@ EXPORT_SYMBOL(con_set_default_unimap);
  */
 int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc)
 {
-	struct uni_pagedir *q;
+	struct uni_pagedict *q;
 
 	if (!*src_vc->vc_uni_pagedir_loc)
 		return -EINVAL;
@@ -739,7 +748,7 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
 	int i, j, k, ret = 0;
 	ushort ect;
 	u16 **p1, *p2;
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
 	struct unipair *unilist;
 
 	unilist = kvmalloc_array(ct, sizeof(struct unipair), GFP_KERNEL);
@@ -810,7 +819,7 @@ conv_uni_to_pc(struct vc_data *conp, long ucs)
 {
 	int h;
 	u16 **p1, *p2;
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
   
 	/* Only 16-bit codes supported at this time */
 	if (ucs > 0xffff)
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 63a6944ebb190..7bce5a174f388 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -75,7 +75,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines);
 static int vgacon_set_origin(struct vc_data *c);
 static void vgacon_save_screen(struct vc_data *c);
 static void vgacon_invert_region(struct vc_data *c, u16 * p, int count);
-static struct uni_pagedir *vgacon_uni_pagedir;
+static struct uni_pagedict *vgacon_uni_pagedir;
 static int vgacon_refcount;
 
 /* Description of the hardware situation */
@@ -363,7 +363,7 @@ static const char *vgacon_startup(void)
 
 static void vgacon_init(struct vc_data *c, int init)
 {
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
 
 	/*
 	 * We cannot be loaded as a module, therefore init will be 1
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index d5b9c8d40c18e..f75033f0277fc 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -17,7 +17,7 @@
 #include <linux/vt.h>
 #include <linux/workqueue.h>
 
-struct uni_pagedir;
+struct uni_pagedict;
 struct uni_screen;
 
 #define NPAR 16
@@ -157,8 +157,8 @@ struct vc_data {
 	unsigned int	vc_bell_duration;	/* Console bell duration */
 	unsigned short	vc_cur_blink_ms;	/* Cursor blink duration */
 	struct vc_data **vc_display_fg;		/* [!] Ptr to var holding fg console for this display */
-	struct uni_pagedir *vc_uni_pagedir;
-	struct uni_pagedir **vc_uni_pagedir_loc; /* [!] Location of uni_pagedir variable for this console */
+	struct uni_pagedict *vc_uni_pagedir;
+	struct uni_pagedict **vc_uni_pagedir_loc; /* [!] Location of uni_pagedict variable for this console */
 	struct uni_screen *vc_uni_screen;	/* unicode screen content */
 	/* additional information is in vt_kern.h */
 };
-- 
2.39.5




