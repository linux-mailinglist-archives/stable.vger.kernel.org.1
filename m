Return-Path: <stable+bounces-15221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6CC83849C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6075B2C283
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8D6D1B5;
	Tue, 23 Jan 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0U0gPJlS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F36D1B4;
	Tue, 23 Jan 2024 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975376; cv=none; b=XzfvSwPZIprTuvrCGVR2IVphNxFxWm/x16KW85iUPohM+1dvd2C3x358a9n51ssqp9jrA8+TtU1z9YfuDq7qdd+VhYudTFHh3wTb6L6YoeJJGF2gjeGyd4T8Iqfr1+CZ5uU/Po69M1XkWt11WncbQD8k5uTC/WxJKZ3+gLxgKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975376; c=relaxed/simple;
	bh=AdoZwTU+4UEavwGIWTd7TCHOVEanabU7p3oeyGuZ+DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdLFlzRDovSTsB3K11+jOwrB8XG5z90YNe635OT5aSH02xDJzg0K9sjGzoQX3awELM/fLoGb6nGZT575x0oWfjOvHWlaH/ds2dMtbUCbZGiDS6Q5dtw2czkox5baGoY77NUENJuK8pTzHBTMYleZ9cFx6yeaG+K+ocpU4QJogmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0U0gPJlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D91FC433C7;
	Tue, 23 Jan 2024 02:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975376;
	bh=AdoZwTU+4UEavwGIWTd7TCHOVEanabU7p3oeyGuZ+DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0U0gPJlSOfFqTyL3hSQxKMcj91ImgQ4J1AS2A/1W6XUih0YY5lx1hMV/7QS7JXadX
	 NYTIQ5frLjtFT/7k5+fFzpPjP88z5Z88k07IbGJf+W5CmeVhQ12BTG5EyjSw11lJ55
	 2BiEjraCmOlA0NCfMbp86AU2PtLG3QLZcucEHzxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 339/583] fbdev: imxfb: fix left margin setting
Date: Mon, 22 Jan 2024 15:56:30 -0800
Message-ID: <20240122235822.398850919@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

[ Upstream commit 5758844105f7dd9a0a04990cd92499a1a593dd36 ]

The previous setting did not take into account the CSTN mode.
For the H_WAIT_2 bitfield (bits 0-7) of the LCDC Horizontal Configuration
Register (LCDCR), the IMX25RM manual states that:

In TFT mode, it specifies the number of SCLK periods between the end of
HSYNC and the beginning of OE signal, and the total delay time equals
(H_WAIT_2 + 3) of SCLK periods.
In CSTN mode, it specifies the number of SCLK periods between the end of
HSYNC and the first display data in each line, and the total delay time
equals (H_WAIT_2 + 2) of SCLK periods.

The patch handles both cases.

Fixes: 4e47382fbca9 ("fbdev: imxfb: warn about invalid left/right margin")
Fixes: 7e8549bcee00 ("imxfb: Fix margin settings")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/imxfb.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 84201c9608d3..7042a43b81d8 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -42,6 +42,7 @@
 #include <video/videomode.h>
 
 #define PCR_TFT		(1 << 31)
+#define PCR_COLOR	(1 << 30)
 #define PCR_BPIX_8	(3 << 25)
 #define PCR_BPIX_12	(4 << 25)
 #define PCR_BPIX_16	(5 << 25)
@@ -150,6 +151,12 @@ enum imxfb_type {
 	IMX21_FB,
 };
 
+enum imxfb_panel_type {
+	PANEL_TYPE_MONOCHROME,
+	PANEL_TYPE_CSTN,
+	PANEL_TYPE_TFT,
+};
+
 struct imxfb_info {
 	struct platform_device  *pdev;
 	void __iomem		*regs;
@@ -157,6 +164,7 @@ struct imxfb_info {
 	struct clk		*clk_ahb;
 	struct clk		*clk_per;
 	enum imxfb_type		devtype;
+	enum imxfb_panel_type	panel_type;
 	bool			enabled;
 
 	/*
@@ -444,6 +452,13 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	if (!is_imx1_fb(fbi) && imxfb_mode->aus_mode)
 		fbi->lauscr = LAUSCR_AUS_MODE;
 
+	if (imxfb_mode->pcr & PCR_TFT)
+		fbi->panel_type = PANEL_TYPE_TFT;
+	else if (imxfb_mode->pcr & PCR_COLOR)
+		fbi->panel_type = PANEL_TYPE_CSTN;
+	else
+		fbi->panel_type = PANEL_TYPE_MONOCHROME;
+
 	/*
 	 * Copy the RGB parameters for this display
 	 * from the machine specific parameters.
@@ -596,6 +611,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 {
 	struct imxfb_info *fbi = info->par;
 	u32 ymax_mask = is_imx1_fb(fbi) ? YMAX_MASK_IMX1 : YMAX_MASK_IMX21;
+	u8 left_margin_low;
 
 	pr_debug("var: xres=%d hslen=%d lm=%d rm=%d\n",
 		var->xres, var->hsync_len,
@@ -604,6 +620,13 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 		var->yres, var->vsync_len,
 		var->upper_margin, var->lower_margin);
 
+	if (fbi->panel_type == PANEL_TYPE_TFT)
+		left_margin_low = 3;
+	else if (fbi->panel_type == PANEL_TYPE_CSTN)
+		left_margin_low = 2;
+	else
+		left_margin_low = 0;
+
 #if DEBUG_VAR
 	if (var->xres < 16        || var->xres > 1024)
 		printk(KERN_ERR "%s: invalid xres %d\n",
@@ -611,7 +634,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (var->hsync_len < 1    || var->hsync_len > 64)
 		printk(KERN_ERR "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
-	if (var->left_margin < 3  || var->left_margin > 255)
+	if (var->left_margin < left_margin_low  || var->left_margin > 255)
 		printk(KERN_ERR "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
 	if (var->right_margin < 1 || var->right_margin > 255)
@@ -637,7 +660,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 
 	writel(HCR_H_WIDTH(var->hsync_len - 1) |
 		HCR_H_WAIT_1(var->right_margin - 1) |
-		HCR_H_WAIT_2(var->left_margin - 3),
+		HCR_H_WAIT_2(var->left_margin - left_margin_low),
 		fbi->regs + LCDC_HCR);
 
 	writel(VCR_V_WIDTH(var->vsync_len) |
-- 
2.43.0




