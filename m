Return-Path: <stable+bounces-204855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B9CF4CEB
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 882D7300A938
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB1309DDB;
	Mon,  5 Jan 2026 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apzO8VzW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7A3090E6
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631693; cv=none; b=hLNDwp3FUUd+SNi1zTiMzyxMugN/y5L71sx1C9Yyqt57tN1jnujTpIoLxzZTjXObTBG8Xm5whkJhsvcoxOQBlOk/Eop4dn96Ccgb3ZVbm3mBeVPBhsQQVl9SjJsaXN5uXveML1e29rjFcs4/gcs8riK05dzbrjmqEmSgzh5a660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631693; c=relaxed/simple;
	bh=en9gfnSRFDfwkXVcyh2ZvVSXgaxa19+bfurXrIGNKo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0gDMujNLTg4w5XJ9rbhzfD9JFvixiBfDPuuwQqmCFP568+3EoSArjW/WthoCZT5Lqry6Y4hIhJhR18mEDJXRMgoG2b/r9leQA7NPFLHa2BaD5Q/u+B2jWeEteJaZEaIVHxMLMLeApokAQFv8DAo5WQrvcKwDU8zZY5Rc0HZM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apzO8VzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D102EC2BC86;
	Mon,  5 Jan 2026 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767631693;
	bh=en9gfnSRFDfwkXVcyh2ZvVSXgaxa19+bfurXrIGNKo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apzO8VzW/mZapEdNU4q6O1LfUT7KUg4Nlwzc6sAu8BgsB7ZzPdDLZLNEUYvOQFXBF
	 x/lSwoYJ6byQPXECDhIvZZiyTjTIDDjfh8Obfp8A2tjNCyhDqppKBv9DqCXHKsXkvN
	 JGEAgkVK1ZXn3A0flKrGLY/w7fBX/n+PyMx/NoB9Q5cvLpxgmnuJAhjbGx7M1Mcy+8
	 mpzSXMdHc4mvzEswK+/NpG213zCNJTK9Rec+16vLmHDG7ii6rK7aPuRCBAHyKTzsf5
	 CuGur2+sCBh5Kgq8Uw28tJ4sZ+ncbAqek7BtAJFWpRYDa23pXaWvkxz2OgyqgZXrJ4
	 UlXiJnlsnvVWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Hitz <christian.hitz@bbv.ch>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] leds: leds-lp50xx: Enable chip before any communication
Date: Mon,  5 Jan 2026 11:48:08 -0500
Message-ID: <20260105164808.2675734-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105164808.2675734-1-sashal@kernel.org>
References: <2026010519-botanical-suds-31fa@gregkh>
 <20260105164808.2675734-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Hitz <christian.hitz@bbv.ch>

[ Upstream commit 434959618c47efe9e5f2e20f4a850caac4f6b823 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lp50xx.c | 55 +++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 479f24d3bb9d..e2f72bb46e9a 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -53,6 +53,12 @@
 
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
@@ -378,19 +384,42 @@ static int lp50xx_reset(struct lp50xx *priv)
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
@@ -460,6 +489,10 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 		return ret;
 	}
 
+	ret = lp50xx_enable(priv);
+	if (ret)
+		return ret;
+
 	priv->regulator = devm_regulator_get(priv->dev, "vled");
 	if (IS_ERR(priv->regulator))
 		priv->regulator = NULL;
@@ -567,14 +600,6 @@ static int lp50xx_probe(struct i2c_client *client,
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
 
@@ -583,7 +608,7 @@ static int lp50xx_remove(struct i2c_client *client)
 	struct lp50xx *led = i2c_get_clientdata(client);
 	int ret;
 
-	ret = lp50xx_enable_disable(led, 0);
+	ret = lp50xx_disable(led);
 	if (ret)
 		dev_err(led->dev, "Failed to disable chip\n");
 
-- 
2.51.0


