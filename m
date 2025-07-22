Return-Path: <stable+bounces-163647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A2AB0D0FC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FB06C27A5
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813651581F8;
	Tue, 22 Jul 2025 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as0ojUkZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425032E3716
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160151; cv=none; b=k881jrCZGtHVrnrcPqy4L9nXlVYGT0o2mcdQMCrJB9vGSuZ5XJ6hyH0TAzdHF/qFDbgr6Fkk3S6N+xklvBQDZhYrMP2lBbDmmArH5FPBOXfxgqG8xqf+thXZVZYs9NYjL5NvZXjx6GCAchnLq3vSbLAsKrmEoIdKHpH92ep38JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160151; c=relaxed/simple;
	bh=OFrL0O8tgLYqBkMQzW0vHXWq42pz1R87MWqH4WsQI18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGbvNY4jQv3jH3AKkRqqe7N6q97dgZdt/ABAiTdWNQzBT0kRTHGkHkc3rxnD2YR6SnpXiGa6gLya+1Osi+0zp7CxBxR3Mqr2fEo7wE2j1PzHoKlDJlmpsQxI/PWlGJyz1hSDeqt1G3Rwi+LJ4KaT0DHRMIkO37/G0WWw/Tmjxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as0ojUkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5522C4CEEB;
	Tue, 22 Jul 2025 04:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753160150;
	bh=OFrL0O8tgLYqBkMQzW0vHXWq42pz1R87MWqH4WsQI18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=as0ojUkZOti3dTJZwSWklT6ASHVmXdiZjmJxpeHPdjmtAVoE4bS0nD09k8ND4ewri
	 S5AV/iKIhy/Dm5Too6BF7Yw6ybnxo0DMUD3xAdPqh2V8wq34oTbkIQr5+Sx4TFsYB8
	 bVcyBlp9InkopDkKu8bG9nbifgWiX0IY2i8t9VVlnZEQEojK68BLq/+C4pCc4ntHo/
	 qCHQ+bfmot+TFqttsARGvXSsQxOHb0x1JUto9xGt5FUOo0eV2FuoP8gucvn09IuUDd
	 Zu1WSpvXKPIajZNGaFru18/2NmT2fS8amXlJIwMtRl9Xd3jHzJZYco6CYVzpzwei1T
	 NDRktBJXEpVDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jayesh Choudhary <j-choudhary@ti.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] i2c: omap: Add support for setting mux
Date: Tue, 22 Jul 2025 00:55:32 -0400
Message-Id: <20250722045534.894081-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072119-stifling-dismount-033b@gregkh>
References: <2025072119-stifling-dismount-033b@gregkh>
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
index 982007a112c2a..8d4270664ebd1 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -899,6 +899,7 @@ config I2C_OMAP
 	tristate "OMAP I2C adapter"
 	depends on ARCH_OMAP || ARCH_K3 || COMPILE_TEST
 	default MACH_OMAP_OSK
+	select MULTIPLEXER
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C interface on the Texas Instruments OMAP1/2 family of processors.
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 22975bfd6b252..ffc116e76ba18 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/mux/consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
@@ -211,6 +212,7 @@ struct omap_i2c_dev {
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
+	struct mux_state	*mux_state;
 };
 
 static const u8 reg_map_ip_v1[] = {
@@ -1455,6 +1457,23 @@ omap_i2c_probe(struct platform_device *pdev)
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
 
@@ -1514,6 +1533,9 @@ static void omap_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&omap->adapter);
 
+	if (omap->mux_state)
+		mux_state_deselect(omap->mux_state);
+
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		dev_err(omap->dev, "Failed to resume hardware, skip disable\n");
-- 
2.39.5


