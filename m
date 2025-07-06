Return-Path: <stable+bounces-159861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6980EAF7B1A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9111CA23A2
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854B2F0C6C;
	Thu,  3 Jul 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M8jSFJlc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A12EF9B8;
	Thu,  3 Jul 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555588; cv=none; b=YUYHOl0EI1aTFWOqyHq3batyQXv0nFBCVhn6icduQRp5SR0GCLi2oVf/qpqcqndkReuLxCpcKI0oCdTSa+9pMctlyJ86O++50qzwD4EXmQPRl5JfQyPyP3Z5oDxftbnaUEeggmhUkx9ZY0rNVHoHxjHO30qLRAH37bg0KfgmVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555588; c=relaxed/simple;
	bh=rnCioXGSZVjMdxrHe/wdUDWpvWLb244uboipYegY21o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/Jee1yltS2NMIxmJnJk5G1uz9oeaJ2ymZoAYE9RhYGs7Lr+gYNDDjXQoAZQylP9x6O4M6jhSjimEz9b7886lVxoWyzE9ps3KA+XRxf0864ewC01bjKYayH44mYlQ9gBUV1h2+3sW6E1RY/2Dwmp9Z9GwygS0OlxumH7f9WciDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M8jSFJlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EE0C4CEED;
	Thu,  3 Jul 2025 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555588;
	bh=rnCioXGSZVjMdxrHe/wdUDWpvWLb244uboipYegY21o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8jSFJlcKbuoJoLVEm07CKZea8YNIN+BGDng+b0RNHsxifpMUcDlBiBKO9KI8vlrp
	 Qiyi1JPORFwfV36zOaDpL3CM5lO+8kLcGDQVWM4rU8hrGEz3IeV6wcO/xn/S6YfzZa
	 UjXOcuf8eN3bH673icdDGFcfCysu1TJQfdk8HVMI=
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
Subject: [PATCH 6.6 060/139] tty: vt: make consw::con_switch() return a bool
Date: Thu,  3 Jul 2025 16:42:03 +0200
Message-ID: <20250703143943.515430439@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

[ Upstream commit 8d5cc8eed738e3202379722295c626cba0849785 ]

The non-zero (true) return value from consw::con_switch() means a redraw
is needed. So make this return type a bool explicitly instead of int.
The latter might imply that -Eerrors are expected. They are not.

And document the hook.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
Tested-by: Helge Deller <deller@gmx.de> # parisc STI console
Link: https://lore.kernel.org/r/20240122110401.7289-31-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 03bcbbb3995b ("dummycon: Trigger redraw when switching consoles with deferred takeover")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vt.c                 | 2 +-
 drivers/video/console/dummycon.c    | 4 ++--
 drivers/video/console/mdacon.c      | 4 ++--
 drivers/video/console/newport_con.c | 4 ++--
 drivers/video/console/sticon.c      | 4 ++--
 drivers/video/console/vgacon.c      | 4 ++--
 drivers/video/fbdev/core/fbcon.c    | 6 +++---
 include/linux/console.h             | 4 +++-
 8 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a368c98c92be3..c5ec7306aa713 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -962,7 +962,7 @@ void redraw_screen(struct vc_data *vc, int is_switch)
 	}
 
 	if (redraw) {
-		int update;
+		bool update;
 		int old_was_color = vc->vc_can_do_color;
 
 		set_origin(vc);
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 6918014b02408..d701f2b51f5b1 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -119,9 +119,9 @@ static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
 	return false;
 }
 
-static int dummycon_switch(struct vc_data *vc)
+static bool dummycon_switch(struct vc_data *vc)
 {
-	return 0;
+	return false;
 }
 
 /*
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 1ddbb6cd5b0ca..26b41a8f36c87 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -454,9 +454,9 @@ static void mdacon_clear(struct vc_data *c, unsigned int y, unsigned int x,
 	scr_memsetw(dest, eattr, width * 2);
 }
 
-static int mdacon_switch(struct vc_data *c)
+static bool mdacon_switch(struct vc_data *c)
 {
-	return 1;	/* redrawing needed */
+	return true;	/* redrawing needed */
 }
 
 static int mdacon_blank(struct vc_data *c, int blank, int mode_switch)
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 55c6106b3507b..63d96c4bbdccd 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -462,7 +462,7 @@ static void newport_cursor(struct vc_data *vc, int mode)
 	}
 }
 
-static int newport_switch(struct vc_data *vc)
+static bool newport_switch(struct vc_data *vc)
 {
 	static int logo_drawn = 0;
 
@@ -476,7 +476,7 @@ static int newport_switch(struct vc_data *vc)
 		}
 	}
 
-	return 1;
+	return true;
 }
 
 static int newport_blank(struct vc_data *c, int blank, int mode_switch)
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index d99c2a659bfd4..87900600eff11 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -310,9 +310,9 @@ static void sticon_clear(struct vc_data *conp, unsigned int sy, unsigned int sx,
 	      conp->vc_video_erase_char, font_data[conp->vc_num]);
 }
 
-static int sticon_switch(struct vc_data *conp)
+static bool sticon_switch(struct vc_data *conp)
 {
-    return 1;	/* needs refreshing */
+    return true;	/* needs refreshing */
 }
 
 static int sticon_blank(struct vc_data *c, int blank, int mode_switch)
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 5b5d1c9ef488c..bbc362db40c58 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -585,7 +585,7 @@ static void vgacon_doresize(struct vc_data *c,
 	raw_spin_unlock_irqrestore(&vga_lock, flags);
 }
 
-static int vgacon_switch(struct vc_data *c)
+static bool vgacon_switch(struct vc_data *c)
 {
 	int x = c->vc_cols * VGA_FONTWIDTH;
 	int y = c->vc_rows * c->vc_cell_height;
@@ -614,7 +614,7 @@ static int vgacon_switch(struct vc_data *c)
 			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
 
-	return 0;		/* Redrawing not needed */
+	return false;		/* Redrawing not needed */
 }
 
 static void vga_set_palette(struct vc_data *vc, const unsigned char *table)
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c14dbb09341fc..9d095fe03e18b 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2072,7 +2072,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	return 0;
 }
 
-static int fbcon_switch(struct vc_data *vc)
+static bool fbcon_switch(struct vc_data *vc)
 {
 	struct fb_info *info, *old_info = NULL;
 	struct fbcon_ops *ops;
@@ -2194,9 +2194,9 @@ static int fbcon_switch(struct vc_data *vc)
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
 			      vc->vc_size_row * (vc->vc_bottom -
 						 vc->vc_top) / 2);
-		return 0;
+		return false;
 	}
-	return 1;
+	return true;
 }
 
 static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
diff --git a/include/linux/console.h b/include/linux/console.h
index e06cee4923fef..38571607065d7 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -42,6 +42,8 @@ enum vc_intensity;
  * @con_scroll: move lines from @top to @bottom in direction @dir by @lines.
  *		Return true if no generic handling should be done.
  *		Invoked by csi_M and printing to the console.
+ * @con_switch: notifier about the console switch; it is supposed to return
+ *		true if a redraw is needed.
  * @con_set_palette: sets the palette of the console to @table (optional)
  * @con_scrolldelta: the contents of the console should be scrolled by @lines.
  *		     Invoked by user. (optional)
@@ -60,7 +62,7 @@ struct consw {
 	bool	(*con_scroll)(struct vc_data *vc, unsigned int top,
 			unsigned int bottom, enum con_scroll dir,
 			unsigned int lines);
-	int	(*con_switch)(struct vc_data *vc);
+	bool	(*con_switch)(struct vc_data *vc);
 	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
 	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
 			unsigned int vpitch, unsigned int flags);
-- 
2.39.5




