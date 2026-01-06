Return-Path: <stable+bounces-205120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 788C2CF92FE
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA7A6300FD62
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BA22541B;
	Tue,  6 Jan 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJu2sRhj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650B222585
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714972; cv=none; b=kHKHCGS31QCITABZR2Zh9Pa7/2hSsoAmP5WAmfyExU14KiQKQgrxYjoIVWHvSIvcryD9UwZrGNL5wrz8A0TmZDpGB68w6MfnDW0OC52uOXMN+iFf6+TxPupqk4UwRHex5tlSdNFBFY1/lE/RfIlFxskDVAHgnJdmZnOLAmpjnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714972; c=relaxed/simple;
	bh=ioMSrG+DJFNTOnXSAEKFr6u5PPpXBuirb46JWJPBJn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovZhyDjXJGVDgayEZIpcpzpy/glH7jeSKgw9MVYfH8W1OPR87WNfKomlauunqDPuTZ1C6zHzs3pfC4q3jKfhSMvqAKJaXVwhMiGkWj2VomdHGmNxKzY2VgI+M0/J+8smEJrH7nD8dVf4HCTA+WEsKaCUPFTuxWgK1ChsvE/bUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJu2sRhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFD5C116C6;
	Tue,  6 Jan 2026 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767714972;
	bh=ioMSrG+DJFNTOnXSAEKFr6u5PPpXBuirb46JWJPBJn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJu2sRhjlY1FC+WrJw9t0xzsRbE7JKjuuhnLxTbz1gnavjyLHjvjQ1ftVrQknezj+
	 lcvS2a2iJalYZM6KFoHbZw+0fbVrdEhgOWmwITZ6gJT3gSbNEKUFPBFW1K7NucGxHU
	 n5PaydY24ji9O/4DUJuu+AmxydGpXZ3ySvulNiTLsNirLShbNSqdl5AAe0jeToeAGq
	 deCK5kueGYtOLiu8853jm65xuJBgrmnEamU2s+UAazsoT6aZXV6PcGJjIlBe7QFKwv
	 v3zJLlp5Weeu+pSe+4gkt6pSTYSX4qM4Ypcc10gsbPU+W93IitlHzw6Yu9xNQuQepN
	 VAevmFgINozeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] pmdomain: Use device_get_match_data()
Date: Tue,  6 Jan 2026 10:56:02 -0500
Message-ID: <20260106155609.3056915-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010514-aerospace-cathouse-bd44@gregkh>
References: <2026010514-aerospace-cathouse-bd44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

[ Upstream commit 3ba9fdfaa550936837b50b73d6c27ac401fde875 ]

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20231006224614.444488-1-robh@kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 73cb5f6eafb0 ("pmdomain: imx: Fix reference count leak in imx_gpc_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/actions/owl-sps.c     | 16 +++++-----------
 drivers/pmdomain/imx/gpc.c             |  7 +++----
 drivers/pmdomain/rockchip/pm-domains.c | 13 ++++---------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/pmdomain/actions/owl-sps.c b/drivers/pmdomain/actions/owl-sps.c
index 73a9e0bb7e8e..3a586d1f3256 100644
--- a/drivers/pmdomain/actions/owl-sps.c
+++ b/drivers/pmdomain/actions/owl-sps.c
@@ -8,8 +8,10 @@
  * Copyright (c) 2017 Andreas Färber
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pm_domain.h>
 #include <linux/soc/actions/owl-sps.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
@@ -96,24 +98,16 @@ static int owl_sps_init_domain(struct owl_sps *sps, int index)
 
 static int owl_sps_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	const struct owl_sps_info *sps_info;
 	struct owl_sps *sps;
 	int i, ret;
 
-	if (!pdev->dev.of_node) {
-		dev_err(&pdev->dev, "no device node\n");
-		return -ENODEV;
-	}
-
-	match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
-	if (!match || !match->data) {
+	sps_info = device_get_match_data(&pdev->dev);
+	if (!sps_info) {
 		dev_err(&pdev->dev, "unknown compatible or missing data\n");
 		return -EINVAL;
 	}
 
-	sps_info = match->data;
-
 	sps = devm_kzalloc(&pdev->dev,
 			   struct_size(sps, domains, sps_info->num_domains),
 			   GFP_KERNEL);
diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index d7c0301a7121..9ccab78c8986 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -7,9 +7,10 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -403,9 +404,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 
 static int imx_gpc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(imx_gpc_dt_ids, &pdev->dev);
-	const struct imx_gpc_dt_data *of_id_data = of_id->data;
+	const struct imx_gpc_dt_data *of_id_data = device_get_match_data(&pdev->dev);
 	struct device_node *pgc_node;
 	struct regmap *regmap;
 	void __iomem *base;
diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index d5d3ecb38283..9b76b62869d0 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -9,11 +9,13 @@
 #include <linux/iopoll.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
+#include <linux/property.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
-#include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
@@ -857,7 +859,6 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	struct device_node *node;
 	struct device *parent;
 	struct rockchip_pmu *pmu;
-	const struct of_device_id *match;
 	const struct rockchip_pmu_info *pmu_info;
 	int error;
 
@@ -866,13 +867,7 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
-		dev_err(dev, "missing pmu data\n");
-		return -EINVAL;
-	}
-
-	pmu_info = match->data;
+	pmu_info = device_get_match_data(dev);
 
 	pmu = devm_kzalloc(dev,
 			   struct_size(pmu, domains, pmu_info->num_domains),
-- 
2.51.0


