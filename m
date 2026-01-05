Return-Path: <stable+bounces-204633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2BFCF30A4
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC0443015127
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CBB3161B8;
	Mon,  5 Jan 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l/QkPu6R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1B3161A8
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609563; cv=none; b=IhSlpD31eDKB70ee7ZPfbHUrXVWdK1bncR99bsVt0wGXdK9WdUHYsQ3KszjaFp7T8+W5mqudB0U7+SS0kg4iDTMoNVS7il3LWd3UBtOlx8AoF4+9DiorF2QRZSwAUSTUyDoZA1wI/p7RbCGvHvVa4h78OMmuVUzaDf3075DbJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609563; c=relaxed/simple;
	bh=EY/8lI7RGL8R7aliV+hq3GetxYDxAgmXxLaQOWybN0g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KJKQEm94fC/emsztCsee2foLhnBBdvtFRBkamYmEW8o1lq5m2alGWrfq/bDJyZ9ion98Xic3bDlPg3RNIHxkBlMGChSOIKbVxi5s47c/G0uPELv1YewLYB0Dd6Vdx5EzVu/bzjIEce3762DC2xnDxnjUf+OScG2zpIc6Vt1kMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/QkPu6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621C6C19421;
	Mon,  5 Jan 2026 10:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767609563;
	bh=EY/8lI7RGL8R7aliV+hq3GetxYDxAgmXxLaQOWybN0g=;
	h=Subject:To:Cc:From:Date:From;
	b=l/QkPu6R0Y1Dr81YkVNwilHzjzChAG4hjm5+p9B96f4Vf2WdkWEhCuXDm4GBbTiwc
	 agWNhnLYy4DvRVVms8criN+08/AeVkGd0/00T6chfLwKUuNG9smod2aRe4BUPn6MNt
	 7Ad96aZwgcpYMIQ2hVTdn+LOMSlR2bVHwyhhcTWk=
Subject: FAILED: patch "[PATCH] leds: leds-lp50xx: Enable chip before any communication" failed to apply to 5.10-stable tree
To: christian.hitz@bbv.ch,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:39:19 +0100
Message-ID: <2026010519-botanical-suds-31fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 434959618c47efe9e5f2e20f4a850caac4f6b823
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010519-botanical-suds-31fa@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 434959618c47efe9e5f2e20f4a850caac4f6b823 Mon Sep 17 00:00:00 2001
From: Christian Hitz <christian.hitz@bbv.ch>
Date: Tue, 28 Oct 2025 16:51:40 +0100
Subject: [PATCH] leds: leds-lp50xx: Enable chip before any communication
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If a GPIO is used to control the chip's enable pin, it needs to be pulled
high before any i2c communication is attempted.

Currently, the enable GPIO handling is not correct.

Assume the enable GPIO is low when the probe function is entered. In this
case the device is in SHUTDOWN mode and does not react to i2c commands.

During probe the following sequence happens:
 1. The call to lp50xx_reset() on line 548 has no effect as i2c is not
    possible yet.
 2. Then - on line 552 - lp50xx_enable_disable() is called. As
    "priv->enable_gpio“ has not yet been initialized, setting the GPIO has
    no effect. Also the i2c enable command is not executed as the device
    is still in SHUTDOWN.
 3. On line 556 the call to lp50xx_probe_dt() finally parses the rest of
    the DT and the configured priv->enable_gpio is set up.

As a result the device is still in SHUTDOWN mode and not ready for
operation.

Split lp50xx_enable_disable() into distinct enable and disable functions
to enforce correct ordering between enable_gpio manipulations and i2c
commands.
Read enable_gpio configuration from DT before attempting to manipulate
enable_gpio.
Add delays to observe correct wait timing after manipulating enable_gpio
and before any i2c communication.

Cc: stable@vger.kernel.org
Fixes: 242b81170fb8 ("leds: lp50xx: Add the LP50XX family of the RGB LED driver")
Signed-off-by: Christian Hitz <christian.hitz@bbv.ch>
Link: https://patch.msgid.link/20251028155141.1603193-1-christian@klarinett.li
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 3a0316be96ed..e2a9c8592953 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -50,6 +50,12 @@
 
 #define LP50XX_SW_RESET		0xff
 #define LP50XX_CHIP_EN		BIT(6)
+#define LP50XX_CHIP_DISABLE	0x00
+#define LP50XX_START_TIME_US	500
+#define LP50XX_RESET_TIME_US	3
+
+#define LP50XX_EN_GPIO_LOW	0
+#define LP50XX_EN_GPIO_HIGH	1
 
 /* There are 3 LED outputs per bank */
 #define LP50XX_LEDS_PER_MODULE	3
@@ -369,19 +375,42 @@ static int lp50xx_reset(struct lp50xx *priv)
 	return regmap_write(priv->regmap, priv->chip_info->reset_reg, LP50XX_SW_RESET);
 }
 
-static int lp50xx_enable_disable(struct lp50xx *priv, int enable_disable)
+static int lp50xx_enable(struct lp50xx *priv)
 {
 	int ret;
 
-	ret = gpiod_direction_output(priv->enable_gpio, enable_disable);
+	if (priv->enable_gpio) {
+		ret = gpiod_direction_output(priv->enable_gpio, LP50XX_EN_GPIO_HIGH);
+		if (ret)
+			return ret;
+
+		udelay(LP50XX_START_TIME_US);
+	}
+
+	ret = lp50xx_reset(priv);
 	if (ret)
 		return ret;
 
-	if (enable_disable)
-		return regmap_write(priv->regmap, LP50XX_DEV_CFG0, LP50XX_CHIP_EN);
-	else
-		return regmap_write(priv->regmap, LP50XX_DEV_CFG0, 0);
+	return regmap_write(priv->regmap, LP50XX_DEV_CFG0, LP50XX_CHIP_EN);
+}
 
+static int lp50xx_disable(struct lp50xx *priv)
+{
+	int ret;
+
+	ret = regmap_write(priv->regmap, LP50XX_DEV_CFG0, LP50XX_CHIP_DISABLE);
+	if (ret)
+		return ret;
+
+	if (priv->enable_gpio) {
+		ret = gpiod_direction_output(priv->enable_gpio, LP50XX_EN_GPIO_LOW);
+		if (ret)
+			return ret;
+
+		udelay(LP50XX_RESET_TIME_US);
+	}
+
+	return 0;
 }
 
 static int lp50xx_probe_leds(struct fwnode_handle *child, struct lp50xx *priv,
@@ -445,6 +474,10 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 		return dev_err_probe(priv->dev, PTR_ERR(priv->enable_gpio),
 				     "Failed to get enable GPIO\n");
 
+	ret = lp50xx_enable(priv);
+	if (ret)
+		return ret;
+
 	priv->regulator = devm_regulator_get(priv->dev, "vled");
 	if (IS_ERR(priv->regulator))
 		priv->regulator = NULL;
@@ -545,14 +578,6 @@ static int lp50xx_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = lp50xx_reset(led);
-	if (ret)
-		return ret;
-
-	ret = lp50xx_enable_disable(led, 1);
-	if (ret)
-		return ret;
-
 	return lp50xx_probe_dt(led);
 }
 
@@ -561,7 +586,7 @@ static void lp50xx_remove(struct i2c_client *client)
 	struct lp50xx *led = i2c_get_clientdata(client);
 	int ret;
 
-	ret = lp50xx_enable_disable(led, 0);
+	ret = lp50xx_disable(led);
 	if (ret)
 		dev_err(led->dev, "Failed to disable chip\n");
 


