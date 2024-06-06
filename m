Return-Path: <stable+bounces-49593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8AF8FEDF2
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC471F22837
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB181BE85E;
	Thu,  6 Jun 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZqQFTGcp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9319E7FF;
	Thu,  6 Jun 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683543; cv=none; b=Z8zIKYKoZXhGmt9BlUSwNqGrcF4LFZehfqEUGHQNpsKySLZuUoKZeKqqbn1HayTbqt48HT1iWKcJM/FL+uK8XOHd0nbooWQnZuqkJQ/P4AE82rRGw/yYc0wGJWhYSgD330wLyCO0wgT5sFsVth3AqDj1IlycP+XHsN5KwAi4CI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683543; c=relaxed/simple;
	bh=gQhuXz5l+t7B1I/6P7sKnBdDvHTOPSIyScrsDFCOdA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HayDdG04B0lT0vswupCburSWmLrgj5rAK99DCH0KyKxQSxtnOlXErE2ynKtv3FqvbrxmjoBY61yf/vXLJepEu1w5R0UkTmu9Z3mF27+ydkX4E3hncz+qVx1B9eZt2WGM+ngG9045yERNgu8HVJlCjy4WNi8CjKqcDAfKmpXcdYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZqQFTGcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D00C2BD10;
	Thu,  6 Jun 2024 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683543;
	bh=gQhuXz5l+t7B1I/6P7sKnBdDvHTOPSIyScrsDFCOdA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqQFTGcp/0psHOkDPIJZFeZzbRceeOPbHFMjcc0ZCrG/TmsVeBiusnI7961iiAC+x
	 +5zmN6z+4rj7UlXqoHVH/fgg3uOX+inwGRZHTGAZpn+BxR6ywHbUY0cRxByo+QBF9w
	 +w6uxKPALywG065Rtu2zGCgwm00BAPkkpumLoUFY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 482/744] watchdog: bd9576: Drop "always-running" property
Date: Thu,  6 Jun 2024 16:02:34 +0200
Message-ID: <20240606131747.922075320@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Matti Vaittinen <mazziesaccount@gmail.com>

[ Upstream commit e3b3afd34d84efcbe4543deb966b1990f43584b8 ]

The always-running (from linux,wdt-gpio.yaml) is abused by the BD9576
watchdog driver. It's defined meaning is "the watchdog is always running
and can not be stopped". The BD9576 watchdog driver has implemented it
as "start watchdog when loading the module and prevent it from being
stopped".

Furthermore, the implementation does not set the WDOG_HW_RUNNING when
enabling the watchdog due to the "always-running" at module loading.
This will end up resulting a watchdog timeout if the device is not
opened.

The culprit was pointed out by Guenter, discussion can be found from
https://lore.kernel.org/lkml/4fa3a64b-60fb-4e5e-8785-0f14da37eea2@roeck-us.net/

Drop the invalid "always-running" handling.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: b237bcac557a ("wdt: Support wdt on ROHM BD9576MUF and BD9573MUF")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/ZhPAt76yaJMersXf@fedora
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/bd9576_wdt.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/watchdog/bd9576_wdt.c b/drivers/watchdog/bd9576_wdt.c
index 4a20e07fbb699..f00ea1b4e40b6 100644
--- a/drivers/watchdog/bd9576_wdt.c
+++ b/drivers/watchdog/bd9576_wdt.c
@@ -29,7 +29,6 @@ struct bd9576_wdt_priv {
 	struct gpio_desc	*gpiod_en;
 	struct device		*dev;
 	struct regmap		*regmap;
-	bool			always_running;
 	struct watchdog_device	wdd;
 };
 
@@ -62,10 +61,7 @@ static int bd9576_wdt_stop(struct watchdog_device *wdd)
 {
 	struct bd9576_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	if (!priv->always_running)
-		bd9576_wdt_disable(priv);
-	else
-		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	bd9576_wdt_disable(priv);
 
 	return 0;
 }
@@ -264,9 +260,6 @@ static int bd9576_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->always_running = device_property_read_bool(dev->parent,
-							 "always-running");
-
 	watchdog_set_drvdata(&priv->wdd, priv);
 
 	priv->wdd.info			= &bd957x_wdt_ident;
@@ -281,9 +274,6 @@ static int bd9576_wdt_probe(struct platform_device *pdev)
 
 	watchdog_stop_on_reboot(&priv->wdd);
 
-	if (priv->always_running)
-		bd9576_wdt_start(&priv->wdd);
-
 	return devm_watchdog_register_device(dev, &priv->wdd);
 }
 
-- 
2.43.0




