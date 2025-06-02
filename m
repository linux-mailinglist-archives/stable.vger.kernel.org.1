Return-Path: <stable+bounces-149257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C33ACB1E4
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF1A404E8B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168FE238177;
	Mon,  2 Jun 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U1XFOJGm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A023816E;
	Mon,  2 Jun 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873404; cv=none; b=HXOPyTi61hbMbXVkZ1L6b081jIEW3/NVBlt7roRS0pcOJSw//oYFuCGI0HNOt0+QZn+BL5guOXcCAwkPnQhBtHkabEODZvaGxkjgY7MB4HwyChTCQYZ5yBCnYxmgtl1WOHFrwKkBx6awkk1Od7KcUOxC3zrsLjPwi3GCk3yxc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873404; c=relaxed/simple;
	bh=9+rEpatgy70j1JMj0CtekdZ7dSIH35sy2c47YS6YUSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUbZdSMrsLwXJ9I5fFJhuBfc+3lK2ZqX5H6hK/7cjHM7oZ6JIwpzAbg9MUQKalMv4ag/OFbR7OezWxZ6sTW7NU18n4zZla3OqsqBH6Wxp4nbfpEpHEQWVsnsTDPz1G2OyOEfcWeW/Nvq6hfWj2lttSlWklFh4DxycTTBj+XGK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U1XFOJGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474C9C4CEEE;
	Mon,  2 Jun 2025 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873404;
	bh=9+rEpatgy70j1JMj0CtekdZ7dSIH35sy2c47YS6YUSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1XFOJGm8FewQLPB3p9C+Q1q6itaMas3X/bMxZ6JgWaB35NhA2Vp0Rr+8V4Cm6MMS
	 YgAUdv3IfBNgnzmUKo/zjo2zBLfdzbLN+f8JFTNBS3pLDf80FaATW9IZhaKZdlTeVI
	 Ky9g4DTHbjyOGAMpwHDLU0S95vgkDBoJJEMz0SJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 130/444] watchdog: aspeed: Update bootstatus handling
Date: Mon,  2 Jun 2025 15:43:14 +0200
Message-ID: <20250602134346.162724705@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

[ Upstream commit 5c03f9f4d36292150c14ebd90788c4d3273ed9dc ]

The boot status in the watchdog device struct is updated during
controller probe stage. Application layer can get the boot status
through the command, cat /sys/class/watchdog/watchdogX/bootstatus.
The bootstatus can be,
WDIOF_CARDRESET => System is reset due to WDT timeout occurs.
Others          => Other reset events, e.g., power on reset.

On ASPEED platforms, boot status is recorded in the SCU registers.
- AST2400: Only a bit is used to represent system reset triggered by
           any WDT controller.
- AST2500/AST2600: System reset triggered by different WDT controllers
                   can be distinguished by different SCU bits.

Besides, on AST2400 and AST2500, since alternating boot event is
also triggered by using WDT timeout mechanism, it is classified
as WDIOF_CARDRESET.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20250113093737.845097-2-chin-ting_kuo@aspeedtech.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/aspeed_wdt.c | 81 ++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b72a858bbac70..7bc0fb1df1e00 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -11,21 +11,30 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+struct aspeed_wdt_scu {
+	const char *compatible;
+	u32 reset_status_reg;
+	u32 wdt_reset_mask;
+	u32 wdt_reset_mask_shift;
+};
 
 struct aspeed_wdt_config {
 	u32 ext_pulse_width_mask;
 	u32 irq_shift;
 	u32 irq_mask;
+	struct aspeed_wdt_scu scu;
 };
 
 struct aspeed_wdt {
@@ -39,18 +48,36 @@ static const struct aspeed_wdt_config ast2400_config = {
 	.ext_pulse_width_mask = 0xff,
 	.irq_shift = 0,
 	.irq_mask = 0,
+	.scu = {
+		.compatible = "aspeed,ast2400-scu",
+		.reset_status_reg = 0x3c,
+		.wdt_reset_mask = 0x1,
+		.wdt_reset_mask_shift = 1,
+	},
 };
 
 static const struct aspeed_wdt_config ast2500_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 12,
 	.irq_mask = GENMASK(31, 12),
+	.scu = {
+		.compatible = "aspeed,ast2500-scu",
+		.reset_status_reg = 0x3c,
+		.wdt_reset_mask = 0x1,
+		.wdt_reset_mask_shift = 2,
+	},
 };
 
 static const struct aspeed_wdt_config ast2600_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 0,
 	.irq_mask = GENMASK(31, 10),
+	.scu = {
+		.compatible = "aspeed,ast2600-scu",
+		.reset_status_reg = 0x74,
+		.wdt_reset_mask = 0xf,
+		.wdt_reset_mask_shift = 16,
+	},
 };
 
 static const struct of_device_id aspeed_wdt_of_table[] = {
@@ -211,6 +238,56 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 	return 0;
 }
 
+static void aspeed_wdt_update_bootstatus(struct platform_device *pdev,
+					 struct aspeed_wdt *wdt)
+{
+	const struct resource *res;
+	struct aspeed_wdt_scu scu = wdt->cfg->scu;
+	struct regmap *scu_base;
+	u32 reset_mask_width;
+	u32 reset_mask_shift;
+	u32 idx = 0;
+	u32 status;
+	int ret;
+
+	if (!of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt")) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		idx = ((intptr_t)wdt->base & 0x00000fff) / resource_size(res);
+	}
+
+	scu_base = syscon_regmap_lookup_by_compatible(scu.compatible);
+	if (IS_ERR(scu_base)) {
+		wdt->wdd.bootstatus = WDIOS_UNKNOWN;
+		return;
+	}
+
+	ret = regmap_read(scu_base, scu.reset_status_reg, &status);
+	if (ret) {
+		wdt->wdd.bootstatus = WDIOS_UNKNOWN;
+		return;
+	}
+
+	reset_mask_width = hweight32(scu.wdt_reset_mask);
+	reset_mask_shift = scu.wdt_reset_mask_shift +
+			   reset_mask_width * idx;
+
+	if (status & (scu.wdt_reset_mask << reset_mask_shift))
+		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
+	/* clear wdt reset event flag */
+	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt") ||
+	    of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2500-wdt")) {
+		ret = regmap_read(scu_base, scu.reset_status_reg, &status);
+		if (!ret) {
+			status &= ~(scu.wdt_reset_mask << reset_mask_shift);
+			regmap_write(scu_base, scu.reset_status_reg, status);
+		}
+	} else {
+		regmap_write(scu_base, scu.reset_status_reg,
+			     scu.wdt_reset_mask << reset_mask_shift);
+	}
+}
+
 /* access_cs0 shows if cs0 is accessible, hence the reverted bit */
 static ssize_t access_cs0_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -447,10 +524,10 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
+	aspeed_wdt_update_bootstatus(pdev, wdt);
+
 	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
 	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
-
 		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
 		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
 			wdt->wdd.groups = bswitch_groups;
-- 
2.39.5




