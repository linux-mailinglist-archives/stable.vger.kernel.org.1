Return-Path: <stable+bounces-160038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F11FAF7C07
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85166E498E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591202EE99E;
	Thu,  3 Jul 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RkedZON1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B122B8AB;
	Thu,  3 Jul 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556171; cv=none; b=e2CYRPRzycSpikIUMlrKzYMiY1KUthCSxFjWxuWBkx8uVy2wrrIa1T9gXbMusu81ToFYSmpqbldBbeRV80eBwk2laW63mGtPtpEJJ18uYYl13XEI4KRp+jI2pBl1aHGv5wvuMCImtqUc1oixv5+EL/x03nwuY26BewzsA/ExRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556171; c=relaxed/simple;
	bh=G+d5zU5IK4v4xzlKuv/P65nXp+C3iKIWtkM/kXuegU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIldz6kk4bOwZrf9zb9f4wFbEtpNO7IWtRFJvwrEHxyXPoepUEGi3QXLxVc3kpUDyprZCIIbMqPq5QFKgCa+szeP0ucLvezKYy2V4abksHMSokI/1FBA3eBWb59I7oALkX5EJEQMGetzgAqWI9meOsZMOh5+rveeFYUajm7vjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RkedZON1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AA3C4CEE3;
	Thu,  3 Jul 2025 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556170;
	bh=G+d5zU5IK4v4xzlKuv/P65nXp+C3iKIWtkM/kXuegU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkedZON16BHnf4mv+z6YsYVuW/y74ySPtSazqF/VFJoAFW+kxnn+IZ3C/bw1hhDVo
	 EF9HCIZf6w5rnQuyhbzb4vHPCBwqjPrfd0X65NMK0JM0N0h129s1B2yKzV4te3uzCT
	 CjELiXLoUCvEpuUJtxZz9xbeXYPhPVW4lS9Pi3eM=
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
Subject: [PATCH 6.1 067/132] tty: vt: make consw::con_switch() return a bool
Date: Thu,  3 Jul 2025 16:42:36 +0200
Message-ID: <20250703143942.044485578@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 609d2bac58d0b..ccfd9d93c10c5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1014,7 +1014,7 @@ void redraw_screen(struct vc_data *vc, int is_switch)
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
index 5dac00c825946..1ebb18bf10983 100644
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
index 58e983b18f1f4..6b82194a8ef36 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -309,9 +309,9 @@ static void sticon_clear(struct vc_data *conp, unsigned int sy, unsigned int sx,
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
index 6998e28441c97..81f27cd610271 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -595,7 +595,7 @@ static int vgacon_doresize(struct vc_data *c,
 	return 0;
 }
 
-static int vgacon_switch(struct vc_data *c)
+static bool vgacon_switch(struct vc_data *c)
 {
 	int x = c->vc_cols * VGA_FONTWIDTH;
 	int y = c->vc_rows * c->vc_cell_height;
@@ -624,7 +624,7 @@ static int vgacon_switch(struct vc_data *c)
 			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
 
-	return 0;		/* Redrawing not needed */
+	return false;		/* Redrawing not needed */
 }
 
 static void vga_set_palette(struct vc_data *vc, const unsigned char *table)
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3fd76dc6010b4..1a17274187112 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2073,7 +2073,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	return 0;
 }
 
-static int fbcon_switch(struct vc_data *vc)
+static bool fbcon_switch(struct vc_data *vc)
 {
 	struct fb_info *info, *old_info = NULL;
 	struct fbcon_ops *ops;
@@ -2195,9 +2195,9 @@ static int fbcon_switch(struct vc_data *vc)
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
index d7b45c60cf02f..ab8b19f6affab 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -40,6 +40,8 @@ enum vc_intensity;
  * @con_scroll: move lines from @top to @bottom in direction @dir by @lines.
  *		Return true if no generic handling should be done.
  *		Invoked by csi_M and printing to the console.
+ * @con_switch: notifier about the console switch; it is supposed to return
+ *		true if a redraw is needed.
  * @con_set_palette: sets the palette of the console to @table (optional)
  * @con_scrolldelta: the contents of the console should be scrolled by @lines.
  *		     Invoked by user. (optional)
@@ -58,7 +60,7 @@ struct consw {
 	bool	(*con_scroll)(struct vc_data *vc, unsigned int top,
 			unsigned int bottom, enum con_scroll dir,
 			unsigned int lines);
-	int	(*con_switch)(struct vc_data *vc);
+	bool	(*con_switch)(struct vc_data *vc);
 	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
 	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
 			unsigned int flags);
-- 
2.39.5




