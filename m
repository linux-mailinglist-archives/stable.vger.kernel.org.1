Return-Path: <stable+bounces-204852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93CCF4E0F
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A245F331E438
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1472F5A01;
	Mon,  5 Jan 2026 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbZa9HS2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD32221F13
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631691; cv=none; b=gL4kfMDSFuubomKrN+1nJhaJwiHeJO6EQDNlQ6MuVkAnZ6316izjMdAEWOLWOdjvwm5zZ5yrfOv5qo6GErR3kMP7+kvJ8teQlHoQPjxmOq4CqKyM87AVxA16nxrKStE1UtDiQfnJyikYnGZYeIxMW8cHvvWLpmsx2NH3PhaLJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631691; c=relaxed/simple;
	bh=2KVNlRsBI2hOXt/v73nZlIraIiM6n4HAzzfO9I2BP28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2q4dIznyvkpauXXr1ujUrgqjxVD2Fgc9mv09hBKF3/IO3YXtm8ZoG8JZOu7n8sq/Z0NBFBC9rp0qpoW2Itq6jguLQCW+njFGXFWikh8LnZJxtzyzQ/pvBQ18NDnk20CGER9xYsFnSJXzQVB/yhkikOz1mIm54X4KbBvwoPKZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbZa9HS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D98C19424;
	Mon,  5 Jan 2026 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767631691;
	bh=2KVNlRsBI2hOXt/v73nZlIraIiM6n4HAzzfO9I2BP28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbZa9HS2rlHV9YPSrJ0l8ERkZgqg7bUFSevaKdrqAH9ErtRaXzjl57ZCEyCXj2WEt
	 0h7NCzTrK36oFyyVRrO3AtNSGUaTLeO1V97Y/JTbaEZdXeFWI2jRz2tApOceexBkzk
	 eYAwInXFFCbc0y5l90V3qqvpA6DJIReTGRi0Nfxr1peN3KfPaIPNU0QROl77qhQY7r
	 haBhEXyAWj5dktMbohhicOwvg/iz1NesH+7eHs4ni5gJyNAxRh2yzbNgug7GjB9qTw
	 65SjfloKb5W0aHtvGdeGRjQrmayWHc502XnTIi21xlSpMliXxxDnLI3CWdf5IdJlNW
	 sBIhwr6TvQ6Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] leds: lp50xx: Reduce level of dereferences
Date: Mon,  5 Jan 2026 11:48:05 -0500
Message-ID: <20260105164808.2675734-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010519-botanical-suds-31fa@gregkh>
References: <2026010519-botanical-suds-31fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 556f15fe023ec1d9f9cd2781ba6cd14bda650d22 ]

The priv->dev is effectively the same as &priv->client->dev.
So, drop the latter for the former.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Stable-dep-of: 434959618c47 ("leds: leds-lp50xx: Enable chip before any communication")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lp50xx.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 279f3958e0ab..66299605d133 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -322,7 +322,7 @@ static int lp50xx_brightness_set(struct led_classdev *cdev,
 
 	ret = regmap_write(led->priv->regmap, reg_val, brightness);
 	if (ret) {
-		dev_err(&led->priv->client->dev,
+		dev_err(led->priv->dev,
 			"Cannot write brightness value %d\n", ret);
 		goto out;
 	}
@@ -338,7 +338,7 @@ static int lp50xx_brightness_set(struct led_classdev *cdev,
 		ret = regmap_write(led->priv->regmap, reg_val,
 				   mc_dev->subled_info[i].intensity);
 		if (ret) {
-			dev_err(&led->priv->client->dev,
+			dev_err(led->priv->dev,
 				"Cannot write intensity value %d\n", ret);
 			goto out;
 		}
@@ -404,7 +404,7 @@ static int lp50xx_probe_leds(struct fwnode_handle *child, struct lp50xx *priv,
 
 	if (num_leds > 1) {
 		if (num_leds > priv->chip_info->max_modules) {
-			dev_err(&priv->client->dev, "reg property is invalid\n");
+			dev_err(priv->dev, "reg property is invalid\n");
 			return -EINVAL;
 		}
 
@@ -412,13 +412,13 @@ static int lp50xx_probe_leds(struct fwnode_handle *child, struct lp50xx *priv,
 
 		ret = fwnode_property_read_u32_array(child, "reg", led_banks, num_leds);
 		if (ret) {
-			dev_err(&priv->client->dev, "reg property is missing\n");
+			dev_err(priv->dev, "reg property is missing\n");
 			return ret;
 		}
 
 		ret = lp50xx_set_banks(priv, led_banks);
 		if (ret) {
-			dev_err(&priv->client->dev, "Cannot setup banked LEDs\n");
+			dev_err(priv->dev, "Cannot setup banked LEDs\n");
 			return ret;
 		}
 
@@ -426,12 +426,12 @@ static int lp50xx_probe_leds(struct fwnode_handle *child, struct lp50xx *priv,
 	} else {
 		ret = fwnode_property_read_u32(child, "reg", &led_number);
 		if (ret) {
-			dev_err(&priv->client->dev, "led reg property missing\n");
+			dev_err(priv->dev, "led reg property missing\n");
 			return ret;
 		}
 
 		if (led_number > priv->chip_info->num_leds) {
-			dev_err(&priv->client->dev, "led-sources property is invalid\n");
+			dev_err(priv->dev, "led-sources property is invalid\n");
 			return -EINVAL;
 		}
 
@@ -470,7 +470,7 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 		led = &priv->leds[i];
 		ret = fwnode_property_count_u32(child, "reg");
 		if (ret < 0) {
-			dev_err(&priv->client->dev, "reg property is invalid\n");
+			dev_err(priv->dev, "reg property is invalid\n");
 			goto child_out;
 		}
 
@@ -520,12 +520,11 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 		led_cdev = &led->mc_cdev.led_cdev;
 		led_cdev->brightness_set_blocking = lp50xx_brightness_set;
 
-		ret = devm_led_classdev_multicolor_register_ext(&priv->client->dev,
+		ret = devm_led_classdev_multicolor_register_ext(priv->dev,
 						       &led->mc_cdev,
 						       &init_data);
 		if (ret) {
-			dev_err(&priv->client->dev, "led register err: %d\n",
-				ret);
+			dev_err(priv->dev, "led register err: %d\n", ret);
 			goto child_out;
 		}
 		i++;
@@ -588,15 +587,14 @@ static int lp50xx_remove(struct i2c_client *client)
 
 	ret = lp50xx_enable_disable(led, 0);
 	if (ret) {
-		dev_err(&led->client->dev, "Failed to disable chip\n");
+		dev_err(led->dev, "Failed to disable chip\n");
 		return ret;
 	}
 
 	if (led->regulator) {
 		ret = regulator_disable(led->regulator);
 		if (ret)
-			dev_err(&led->client->dev,
-				"Failed to disable regulator\n");
+			dev_err(led->dev, "Failed to disable regulator\n");
 	}
 
 	mutex_destroy(&led->lock);
-- 
2.51.0


