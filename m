Return-Path: <stable+bounces-132966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364C1A918CB
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AA65A01FB
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E06722A1D5;
	Thu, 17 Apr 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EotGOh3o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA061D63D6
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884447; cv=none; b=C9IEfOwiEqljQT0+Yy/fXF3mBZYniDNbxh/IxWAR4h3dioKc1JUQi1Ciuv1+pM/QsVS+3c1DC1qECk0XfyrN/hO0uld/roJtr9fyoQbbX+YdANe5iW2j1RfepwdkGrsCK5oZPV1D2Db9ESe5NYfP7+PGSvfhpnAYEddaGnEPlTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884447; c=relaxed/simple;
	bh=SoVpTJzV5/CXiXlriGvZwiP5IYbfactClKhBo7cPplQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jvFVohoZZKT71t6YfPzF0PCRwtZ4ouB0lgtm6VNeCqlhyiy+/rYKP8hceLY897+b4IkvKOKzu1g7GFPbfTN/gPJo9ZLPuqvOG6IFeHzExdinnkJq2pQoFJd8SOf/pvvQYkhcLChFgKG0BhO+dLYF8fz7Eo+Me27Rz49mnpLJI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EotGOh3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B4AC4CEE4;
	Thu, 17 Apr 2025 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884446;
	bh=SoVpTJzV5/CXiXlriGvZwiP5IYbfactClKhBo7cPplQ=;
	h=Subject:To:Cc:From:Date:From;
	b=EotGOh3oB18g0OT05GGALUgpinn2rNb2m8A2ecOHUwwN7QtAXYWcN7aw6fE84Rpg8
	 tVjnAZZBF91WzqpBCbdlDIg8AdJEtxzL6MkKGcSbnuJmLbVbvZPd1XAeKbj/pA0Hqh
	 dHS5PJJ3bGu4lBvpwhfone5YXb5TX+sfsfZvQkyo=
Subject: FAILED: patch "[PATCH] media: imx219: Adjust PLL settings based on the number of" failed to apply to 6.6-stable tree
To: dave.stevenson@raspberrypi.com,hverkuil@xs4all.nl,peyton.howe@bellsouth.net,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:07:23 +0200
Message-ID: <2025041723-crib-sank-56c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 591a07588c03437dbcc3addfff07675de95a461e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041723-crib-sank-56c0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 591a07588c03437dbcc3addfff07675de95a461e Mon Sep 17 00:00:00 2001
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 23 Jan 2025 15:37:49 +0000
Subject: [PATCH] media: imx219: Adjust PLL settings based on the number of
 MIPI lanes

Commit ceddfd4493b3 ("media: i2c: imx219: Support four-lane operation")
added support for device tree to allow configuration of the sensor to
use 4 lanes with a link frequency of 363MHz, and amended the advertised
pixel rate to 280.8MPix/s.

However it didn't change any of the PLL settings, so actually it would
have been running overclocked in the MIPI block, and with the frame
rate and exposure calculations being wrong as the pixel rate was
unchanged.

The pixel rate and link frequency advertised were taken from the "Clock
Setting Example" section of the datasheet. However those are based on an
external clock of 12MHz, and are unachievable with a clock of 24MHz - it
seems PREPLLCLK_VT_DIV and PREPLLCK_OP_DIV can ONLY be set via the
automatic configuration documented in "9-1-2 EXCK_FREQ setting depend on
INCK frequency", not by writing the registers.
The closest we can get with a 24MHz clock is 281.6MPix/s and 364MHz.

Dropping all support for the 363MHz link frequency would cause problems
for existing users, so allow it, but log a warning that the requested
value is being changed to the supported one.

Fixes: ceddfd4493b3 ("media: i2c: imx219: Support four-lane operation")
Cc: stable@vger.kernel.org
Co-developed-by: Peyton Howe <peyton.howe@bellsouth.net>
Signed-off-by: Peyton Howe <peyton.howe@bellsouth.net>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index c6c30109225c..64227eb423d4 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -133,10 +133,11 @@
 
 /* Pixel rate is fixed for all the modes */
 #define IMX219_PIXEL_RATE		182400000
-#define IMX219_PIXEL_RATE_4LANE		280800000
+#define IMX219_PIXEL_RATE_4LANE		281600000
 
 #define IMX219_DEFAULT_LINK_FREQ	456000000
-#define IMX219_DEFAULT_LINK_FREQ_4LANE	363000000
+#define IMX219_DEFAULT_LINK_FREQ_4LANE_UNSUPPORTED	363000000
+#define IMX219_DEFAULT_LINK_FREQ_4LANE	364000000
 
 /* IMX219 native and active pixel array size. */
 #define IMX219_NATIVE_WIDTH		3296U
@@ -168,15 +169,6 @@ static const struct cci_reg_sequence imx219_common_regs[] = {
 	{ CCI_REG8(0x30eb), 0x05 },
 	{ CCI_REG8(0x30eb), 0x09 },
 
-	/* PLL Clock Table */
-	{ IMX219_REG_VTPXCK_DIV, 5 },
-	{ IMX219_REG_VTSYCK_DIV, 1 },
-	{ IMX219_REG_PREPLLCK_VT_DIV, 3 },	/* 0x03 = AUTO set */
-	{ IMX219_REG_PREPLLCK_OP_DIV, 3 },	/* 0x03 = AUTO set */
-	{ IMX219_REG_PLL_VT_MPY, 57 },
-	{ IMX219_REG_OPSYCK_DIV, 1 },
-	{ IMX219_REG_PLL_OP_MPY, 114 },
-
 	/* Undocumented registers */
 	{ CCI_REG8(0x455e), 0x00 },
 	{ CCI_REG8(0x471e), 0x4b },
@@ -201,12 +193,45 @@ static const struct cci_reg_sequence imx219_common_regs[] = {
 	{ IMX219_REG_EXCK_FREQ, IMX219_EXCK_FREQ(IMX219_XCLK_FREQ / 1000000) },
 };
 
+static const struct cci_reg_sequence imx219_2lane_regs[] = {
+	/* PLL Clock Table */
+	{ IMX219_REG_VTPXCK_DIV, 5 },
+	{ IMX219_REG_VTSYCK_DIV, 1 },
+	{ IMX219_REG_PREPLLCK_VT_DIV, 3 },	/* 0x03 = AUTO set */
+	{ IMX219_REG_PREPLLCK_OP_DIV, 3 },	/* 0x03 = AUTO set */
+	{ IMX219_REG_PLL_VT_MPY, 57 },
+	{ IMX219_REG_OPSYCK_DIV, 1 },
+	{ IMX219_REG_PLL_OP_MPY, 114 },
+
+	/* 2-Lane CSI Mode */
+	{ IMX219_REG_CSI_LANE_MODE, IMX219_CSI_2_LANE_MODE },
+};
+
+static const struct cci_reg_sequence imx219_4lane_regs[] = {
+	/* PLL Clock Table */
+	{ IMX219_REG_VTPXCK_DIV, 5 },
+	{ IMX219_REG_VTSYCK_DIV, 1 },
+	{ IMX219_REG_PREPLLCK_VT_DIV, 3 },	/* 0x03 = AUTO set */
+	{ IMX219_REG_PREPLLCK_OP_DIV, 3 },	/* 0x03 = AUTO set */
+	{ IMX219_REG_PLL_VT_MPY, 88 },
+	{ IMX219_REG_OPSYCK_DIV, 1 },
+	{ IMX219_REG_PLL_OP_MPY, 91 },
+
+	/* 4-Lane CSI Mode */
+	{ IMX219_REG_CSI_LANE_MODE, IMX219_CSI_4_LANE_MODE },
+};
+
 static const s64 imx219_link_freq_menu[] = {
 	IMX219_DEFAULT_LINK_FREQ,
 };
 
 static const s64 imx219_link_freq_4lane_menu[] = {
 	IMX219_DEFAULT_LINK_FREQ_4LANE,
+	/*
+	 * This will never be advertised to userspace, but will be used for
+	 * v4l2_link_freq_to_bitmap
+	 */
+	IMX219_DEFAULT_LINK_FREQ_4LANE_UNSUPPORTED,
 };
 
 static const char * const imx219_test_pattern_menu[] = {
@@ -662,9 +687,11 @@ static int imx219_set_framefmt(struct imx219 *imx219,
 
 static int imx219_configure_lanes(struct imx219 *imx219)
 {
-	return cci_write(imx219->regmap, IMX219_REG_CSI_LANE_MODE,
-			 imx219->lanes == 2 ? IMX219_CSI_2_LANE_MODE :
-			 IMX219_CSI_4_LANE_MODE, NULL);
+	/* Write the appropriate PLL settings for the number of MIPI lanes */
+	return cci_multi_reg_write(imx219->regmap,
+				  imx219->lanes == 2 ? imx219_2lane_regs : imx219_4lane_regs,
+				  imx219->lanes == 2 ? ARRAY_SIZE(imx219_2lane_regs) :
+				  ARRAY_SIZE(imx219_4lane_regs), NULL);
 };
 
 static int imx219_start_streaming(struct imx219 *imx219,
@@ -1035,6 +1062,7 @@ static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
 	struct v4l2_fwnode_endpoint ep_cfg = {
 		.bus_type = V4L2_MBUS_CSI2_DPHY
 	};
+	unsigned long link_freq_bitmap;
 	int ret = -EINVAL;
 
 	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
@@ -1056,23 +1084,40 @@ static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
 	imx219->lanes = ep_cfg.bus.mipi_csi2.num_data_lanes;
 
 	/* Check the link frequency set in device tree */
-	if (!ep_cfg.nr_of_link_frequencies) {
-		dev_err_probe(dev, -EINVAL,
-			      "link-frequency property not found in DT\n");
-		goto error_out;
+	switch (imx219->lanes) {
+	case 2:
+		ret = v4l2_link_freq_to_bitmap(dev,
+					       ep_cfg.link_frequencies,
+					       ep_cfg.nr_of_link_frequencies,
+					       imx219_link_freq_menu,
+					       ARRAY_SIZE(imx219_link_freq_menu),
+					       &link_freq_bitmap);
+		break;
+	case 4:
+		ret = v4l2_link_freq_to_bitmap(dev,
+					       ep_cfg.link_frequencies,
+					       ep_cfg.nr_of_link_frequencies,
+					       imx219_link_freq_4lane_menu,
+					       ARRAY_SIZE(imx219_link_freq_4lane_menu),
+					       &link_freq_bitmap);
+
+		if (!ret && (link_freq_bitmap & BIT(1))) {
+			dev_warn(dev, "Link frequency of %d not supported, but has been incorrectly advertised previously\n",
+				 IMX219_DEFAULT_LINK_FREQ_4LANE_UNSUPPORTED);
+			dev_warn(dev, "Using link frequency of %d\n",
+				 IMX219_DEFAULT_LINK_FREQ_4LANE);
+			link_freq_bitmap |= BIT(0);
+		}
+		break;
 	}
 
-	if (ep_cfg.nr_of_link_frequencies != 1 ||
-	   (ep_cfg.link_frequencies[0] != ((imx219->lanes == 2) ?
-	    IMX219_DEFAULT_LINK_FREQ : IMX219_DEFAULT_LINK_FREQ_4LANE))) {
+	if (ret || !(link_freq_bitmap & BIT(0))) {
+		ret = -EINVAL;
 		dev_err_probe(dev, -EINVAL,
 			      "Link frequency not supported: %lld\n",
 			      ep_cfg.link_frequencies[0]);
-		goto error_out;
 	}
 
-	ret = 0;
-
 error_out:
 	v4l2_fwnode_endpoint_free(&ep_cfg);
 	fwnode_handle_put(endpoint);


