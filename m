Return-Path: <stable+bounces-161202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B7AFD3EA
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3344A1C40FCF
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA762E5B0D;
	Tue,  8 Jul 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nn2lIl0w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81762E091E;
	Tue,  8 Jul 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993890; cv=none; b=GWCZ1GPFCEihQbzDWJIr+CaEu1Tc2OgIT/nvtQ84eCoMY9mNujUVyRpbDWqH1SDQcgjpcynyMqX4vi64M3yzOhiA/aTKT9vhDdqoTLbZ8bFaJ8wUjVUTkY19beJmFxaAKdBBAou1st8+0GAxa2lXKts92JaHfQ30cypqs99E5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993890; c=relaxed/simple;
	bh=faHnp1A2N7r39jDwCGj9XTBz0WxWRUwffs1HVFksXyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkMhIqX6XCwVUd1Nove9pK3f5+Ziu7bsqaD6htRU0ukDJSDglTVPO7qD4w5KP2LGAIY1K3TsS8aiDX+56HXEUWOdF04SVZ+k/dFL6iouHMkAhYGo1BRDVh+T/ycsR18SCKUM8iHMIX5Kr9P1v0njcZ6kgtvXnzJakfK9jylyiMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nn2lIl0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61347C4CEED;
	Tue,  8 Jul 2025 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993889;
	bh=faHnp1A2N7r39jDwCGj9XTBz0WxWRUwffs1HVFksXyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nn2lIl0wQqm3tO7erukgKEZJ1yvQrYNntZeIrpu+rVduXu9PBnEiKL37RdEJQeSvw
	 zB1j4RnkZsL7cNQ56i9MutaPC5B910p8jgXGDI9xOKyYsBzBjnO2Ztm37CYnR+SJ94
	 cs7BDpnhxUNwNPgjCI3lsgin3xAS+5KpTh6zLct4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-parisc@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 054/160] tty: vt: sanitize arguments of consw::con_clear()
Date: Tue,  8 Jul 2025 18:21:31 +0200
Message-ID: <20250708162233.042957881@linuxfoundation.org>
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

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

[ Upstream commit 559f01a0ee6d924c6fec3eaf6a5b078b15e71070 ]

In consw::con_clear():
* Height is always 1, so drop it.
* Offsets and width are always unsigned values, so re-type them as such.

This needs a new __fbcon_clear() in the fbcon code to still handle
height which might not be 1 when called internally.

Note that tests for negative count/width are left in place -- they are
taken care of in the next patches.

And document the hook.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
Tested-by: Helge Deller <deller@gmx.de> # parisc STI console
Link: https://lore.kernel.org/r/20240122110401.7289-22-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 03bcbbb3995b ("dummycon: Trigger redraw when switching consoles with deferred takeover")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vt.c                 |  2 +-
 drivers/video/console/dummycon.c    |  4 ++--
 drivers/video/console/mdacon.c      | 15 +++++---------
 drivers/video/console/newport_con.c |  6 +++---
 drivers/video/console/sticon.c      |  8 ++++----
 drivers/video/console/vgacon.c      |  4 ++--
 drivers/video/fbdev/core/fbcon.c    | 32 +++++++++++++++++------------
 include/linux/console.h             |  5 +++--
 8 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 0e3d7d8f5e75a..765db5a7d5f52 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1628,7 +1628,7 @@ static void csi_X(struct vc_data *vc, unsigned int vpar)
 	vc_uniscr_clear_line(vc, vc->state.x, count);
 	scr_memsetw((unsigned short *)vc->vc_pos, vc->vc_video_erase_char, 2 * count);
 	if (con_should_update(vc))
-		vc->vc_sw->con_clear(vc, vc->state.y, vc->state.x, 1, count);
+		vc->vc_sw->con_clear(vc, vc->state.y, vc->state.x, count);
 	vc->vc_need_wrap = 0;
 }
 
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 9a19eb72a18b9..6918014b02408 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -108,8 +108,8 @@ static void dummycon_init(struct vc_data *vc, bool init)
 }
 
 static void dummycon_deinit(struct vc_data *vc) { }
-static void dummycon_clear(struct vc_data *vc, int sy, int sx, int height,
-			   int width) { }
+static void dummycon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
+			   unsigned int width) { }
 static void dummycon_cursor(struct vc_data *vc, int mode) { }
 
 static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index c5b255c968794..1ddbb6cd5b0ca 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -442,23 +442,18 @@ static void mdacon_putcs(struct vc_data *c, const unsigned short *s,
 	}
 }
 
-static void mdacon_clear(struct vc_data *c, int y, int x, 
-			  int height, int width)
+static void mdacon_clear(struct vc_data *c, unsigned int y, unsigned int x,
+			 unsigned int width)
 {
 	u16 *dest = mda_addr(x, y);
 	u16 eattr = mda_convert_attr(c->vc_video_erase_char);
 
-	if (width <= 0 || height <= 0)
+	if (width <= 0)
 		return;
 
-	if (x==0 && width==mda_num_columns) {
-		scr_memsetw(dest, eattr, height*width*2);
-	} else {
-		for (; height > 0; height--, dest+=mda_num_columns)
-			scr_memsetw(dest, eattr, width*2);
-	}
+	scr_memsetw(dest, eattr, width * 2);
 }
-                        
+
 static int mdacon_switch(struct vc_data *c)
 {
 	return 1;	/* redrawing needed */
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 4b7161a81b2f6..5dac00c825946 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -346,12 +346,12 @@ static void newport_deinit(struct vc_data *c)
 	}
 }
 
-static void newport_clear(struct vc_data *vc, int sy, int sx, int height,
-			  int width)
+static void newport_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
+			  unsigned int width)
 {
 	int xend = ((sx + width) << 3) - 1;
 	int ystart = ((sy << 4) + topscan) & 0x3ff;
-	int yend = (((sy + height) << 4) + topscan - 1) & 0x3ff;
+	int yend = (((sy + 1) << 4) + topscan - 1) & 0x3ff;
 
 	if (logo_active)
 		return;
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 10302df885147..58e983b18f1f4 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -299,13 +299,13 @@ static void sticon_deinit(struct vc_data *c)
 	sticon_set_def_font(i, NULL);
 }
 
-static void sticon_clear(struct vc_data *conp, int sy, int sx, int height,
-			 int width)
+static void sticon_clear(struct vc_data *conp, unsigned int sy, unsigned int sx,
+			 unsigned int width)
 {
-    if (!height || !width)
+    if (!width)
 	return;
 
-    sti_clear(sticon_sti, sy, sx, height, width,
+    sti_clear(sticon_sti, sy, sx, 1, width,
 	      conp->vc_video_erase_char, font_data[conp->vc_num]);
 }
 
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index a9777fd38ad92..54d79edbe85e1 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1187,8 +1187,8 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
  *  The console `switch' structure for the VGA based console
  */
 
-static void vgacon_clear(struct vc_data *vc, int sy, int sx, int height,
-			 int width) { }
+static void vgacon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
+			 unsigned int width) { }
 static void vgacon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
 static void vgacon_putcs(struct vc_data *vc, const unsigned short *s,
 			 int count, int ypos, int xpos) { }
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index f47dbba972fbb..7467b7a27ce2f 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1210,8 +1210,8 @@ static void fbcon_deinit(struct vc_data *vc)
  *  restriction is simplicity & efficiency at the moment.
  */
 
-static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
-			int width)
+static void __fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
+			  unsigned int height, unsigned int width)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -1250,6 +1250,12 @@ static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 		ops->clear(vc, info, real_y(p, sy), sx, height, width, fg, bg);
 }
 
+static void fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
+			unsigned int width)
+{
+	__fbcon_clear(vc, sy, sx, 1, width);
+}
+
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos)
 {
@@ -1673,7 +1679,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 		case SCROLL_MOVE:
 			fbcon_redraw_blit(vc, info, p, t, b - t - count,
 				     count);
-			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							(b - count)),
@@ -1696,7 +1702,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					    b - t - count, vc->vc_cols);
 			else
 				goto redraw_up;
-			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_PAN_REDRAW:
@@ -1714,7 +1720,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 							  vc->vc_rows - b, b);
 			} else
 				fbcon_redraw_move(vc, p, t + count, b - t - count, t);
-			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_PAN_MOVE:
@@ -1737,14 +1743,14 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					    b - t - count, vc->vc_cols);
 			else
 				goto redraw_up;
-			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_REDRAW:
 		      redraw_up:
 			fbcon_redraw(vc, p, t, b - t - count,
 				     count * vc->vc_cols);
-			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							(b - count)),
@@ -1761,7 +1767,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 		case SCROLL_MOVE:
 			fbcon_redraw_blit(vc, info, p, b - 1, b - t - count,
 				     -count);
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							t),
@@ -1784,7 +1790,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					    b - t - count, vc->vc_cols);
 			else
 				goto redraw_down;
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_PAN_MOVE:
@@ -1806,7 +1812,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					    b - t - count, vc->vc_cols);
 			else
 				goto redraw_down;
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_PAN_REDRAW:
@@ -1823,14 +1829,14 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					fbcon_redraw_move(vc, p, count, t, 0);
 			} else
 				fbcon_redraw_move(vc, p, t, b - t - count, t + count);
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_REDRAW:
 		      redraw_down:
 			fbcon_redraw(vc, p, b - 1, b - t - count,
 				     -count * vc->vc_cols);
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							t),
@@ -2175,7 +2181,7 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 
 		oldc = vc->vc_video_erase_char;
 		vc->vc_video_erase_char &= charmask;
-		fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
+		__fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
 		vc->vc_video_erase_char = oldc;
 	}
 }
diff --git a/include/linux/console.h b/include/linux/console.h
index 9258cb8e0841e..bd7f3a6a64cd0 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -36,6 +36,7 @@ enum vc_intensity;
  *
  * @con_init:   initialize the console on @vc. @init is true for the very first
  *		call on this @vc.
+ * @con_clear:  erase @count characters at [@x, @y] on @vc. @count >= 1.
  * @con_scroll: move lines from @top to @bottom in direction @dir by @lines.
  *		Return true if no generic handling should be done.
  *		Invoked by csi_M and printing to the console.
@@ -48,8 +49,8 @@ struct consw {
 	const char *(*con_startup)(void);
 	void	(*con_init)(struct vc_data *vc, bool init);
 	void	(*con_deinit)(struct vc_data *vc);
-	void	(*con_clear)(struct vc_data *vc, int sy, int sx, int height,
-			int width);
+	void	(*con_clear)(struct vc_data *vc, unsigned int y,
+			     unsigned int x, unsigned int count);
 	void	(*con_putc)(struct vc_data *vc, int c, int ypos, int xpos);
 	void	(*con_putcs)(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos);
-- 
2.39.5




