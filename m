Return-Path: <stable+bounces-163644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C012B0D0F9
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21FC54385B
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717E228C000;
	Tue, 22 Jul 2025 04:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fykaYCa4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C654642D
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160094; cv=none; b=tPqIKD7RZB8TQHaDeMOyfSxOg5AXp69+ykjoHmURMViIE3ndzcrCUAGKCk8SpiphXrQeaBNco0eBu143ejfq29pdRMaFVawEaVdyRqVqzF4ItVcHIgpfAkDDshf7eG1SPAdBl1d+YkxhD+HdnL+xhwakS3hg4y0+7Cg90epmaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160094; c=relaxed/simple;
	bh=gKAvsIqOBPq0p3+aDPKKmpZqv98fNMEUNQAC/DiwBOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+UV/jTZrH4zFqbxMeAAckG+UlmVOH9dz4UBtVaSTT6TNaYHPk52+fw3dHj8EZXHRGGCzQvlNIZWFZ1TjgKyp1J9iNC4wMnc7IJxIaG8iGs8OMixFqX9E2RdeHtwL3ugewid83hiOMJoqWfZJtnrkjZFtREG6rlI7L3ZFRfDccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fykaYCa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E83C4CEEB;
	Tue, 22 Jul 2025 04:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753160093;
	bh=gKAvsIqOBPq0p3+aDPKKmpZqv98fNMEUNQAC/DiwBOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fykaYCa4SWTzNz58QrMjCgIuOsLmv6ynpt98oOd8J4eOdnOKC8azmzAkGEYONpnIA
	 iKdTPukgHVOn5qEQ8skJ7gYvKvrFNfRmZF3U38ImNFtsh3FmnYsjO7DxwpPixsH/Q2
	 DVB5htUieI7MHToTc/MIRdhFZpranQGYVlu+aE3AawU/TWykEN8hPK70rGg3MfFjX8
	 rJ3/8NJHem9Dd4r9RCJ6CNPwuKDlQHeVLRlFuo+oZNigbJh37S5gSZNBTrnC+W7rcR
	 ZSFmsA6VIzFpm9zCixyuBEBx1XYIY/vFExsWMPicwI84d+QxoUCEymkpFz7ck6/wRL
	 yD6PYmz5gm8Iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jayesh Choudhary <j-choudhary@ti.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] i2c: omap: Add support for setting mux
Date: Tue, 22 Jul 2025 00:54:45 -0400
Message-Id: <20250722045447.893946-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072119-tragedy-multitude-6649@gregkh>
References: <2025072119-tragedy-multitude-6649@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jayesh Choudhary <j-choudhary@ti.com>

[ Upstream commit b6ef830c60b6f4adfb72d0780b4363df3a1feb9c ]

Some SoCs require muxes in the routing for SDA and SCL lines.
Therefore, add support for setting the mux by reading the mux-states
property from the dt-node.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Link: https://lore.kernel.org/r/20250318103622.29979-3-j-choudhary@ti.com
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: a9503a2ecd95 ("i2c: omap: Handle omap_i2c_init() errors in omap_i2c_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/Kconfig    |  1 +
 drivers/i2c/busses/i2c-omap.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2254abda5c46c..0e679cc501488 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -937,6 +937,7 @@ config I2C_OMAP
 	tristate "OMAP I2C adapter"
 	depends on ARCH_OMAP || ARCH_K3 || COMPILE_TEST
 	default MACH_OMAP_OSK
+	select MULTIPLEXER
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C interface on the Texas Instruments OMAP1/2 family of processors.
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8c9cf08ad45e2..488ee9de64108 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/mux/consumer.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/platform_data/i2c-omap.h>
@@ -211,6 +212,7 @@ struct omap_i2c_dev {
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
+	struct mux_state	*mux_state;
 };
 
 static const u8 reg_map_ip_v1[] = {
@@ -1452,6 +1454,23 @@ omap_i2c_probe(struct platform_device *pdev)
 				       (1000 * omap->speed / 8);
 	}
 
+	if (of_property_read_bool(node, "mux-states")) {
+		struct mux_state *mux_state;
+
+		mux_state = devm_mux_state_get(&pdev->dev, NULL);
+		if (IS_ERR(mux_state)) {
+			r = PTR_ERR(mux_state);
+			dev_dbg(&pdev->dev, "failed to get I2C mux: %d\n", r);
+			goto err_disable_pm;
+		}
+		omap->mux_state = mux_state;
+		r = mux_state_select(omap->mux_state);
+		if (r) {
+			dev_err(&pdev->dev, "failed to select I2C mux: %d\n", r);
+			goto err_disable_pm;
+		}
+	}
+
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(omap);
 
@@ -1511,6 +1530,9 @@ static void omap_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&omap->adapter);
 
+	if (omap->mux_state)
+		mux_state_deselect(omap->mux_state);
+
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		dev_err(omap->dev, "Failed to resume hardware, skip disable\n");
-- 
2.39.5


