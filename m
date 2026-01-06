Return-Path: <stable+bounces-206024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E1CFAE21
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 21:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D674D30124E6
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 20:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198282D595D;
	Tue,  6 Jan 2026 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTmWHA7y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7427586C
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724020; cv=none; b=SKDr9E0G5/XzjvvA7iS+yCxTfEfR69y71zLIl5yjU4dE1oLGAKYNSlFcNTNAKy23W03R8rX9OI4n82slwrVV6cUee6y5YLQNaslplf1FFnCkE84+bVBM0s2G70gVR91g+bwtemJ4TvyGK80FmMXygtBZJ3VE35Z1verusbXHR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724020; c=relaxed/simple;
	bh=zZw2TJCpqVevwO/97oJi3uZSkdRPcbhtpQIqLqqijeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXb8aQU+1EvDAOxgBFfJsS8Dfo+aKOQMsqXSmX8Ta6zX8UZcKjjCgP374bhp9oAtYt/Q9fqj8hO0CDWlTTARxltjoQRUwICYBtpVcWQQF/MXs0IY9EYrhTckdCD0BLqCGGX739D4zGccNbiIYxmwdeIXAiepedYh5tkoNi5gMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTmWHA7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E770CC19425;
	Tue,  6 Jan 2026 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767724019;
	bh=zZw2TJCpqVevwO/97oJi3uZSkdRPcbhtpQIqLqqijeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTmWHA7ywilh/JbHzQfkQP2BaYOh52dFVCyWCdm0jw6NdFpuFsp7G6ZCbNPmtTfQo
	 YapZAb5AZhzP4fNrgqIvNL6f/12nf5dSfVpJbqByfFCFJCHycrMnRaIBywiHa1I7jk
	 gDDUtbpkx1lAdcaLws1xJDM/xMKCytW0undRdEJdYvsNW9iLHt+/NsncXmuRKe1eWA
	 4BhP5rbn9psYQyDPSDT4U/5+CW9uDEdiiGWoMNZFtur4P3L+wPCe6auKoqhfQZrC2w
	 KitsdgYd+KFsePHUR4TeggaHTidUf6jxDKXRthaZZXZCHHkQWYPiOFgDg7lKRq2evb
	 RanRQo9Ay5Njg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] pmdomain: Use device_get_match_data()
Date: Tue,  6 Jan 2026 13:26:53 -0500
Message-ID: <20260106182656.3115094-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182656.3115094-1-sashal@kernel.org>
References: <2026010515-quaking-outlook-7f2c@gregkh>
 <20260106182656.3115094-1-sashal@kernel.org>
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
 drivers/soc/actions/owl-sps.c     | 16 +++++-----------
 drivers/soc/imx/gpc.c             |  7 +++----
 drivers/soc/rockchip/pm_domains.c | 13 ++++---------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/actions/owl-sps.c b/drivers/soc/actions/owl-sps.c
index 73a9e0bb7e8e..3a586d1f3256 100644
--- a/drivers/soc/actions/owl-sps.c
+++ b/drivers/soc/actions/owl-sps.c
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
diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 8d0d05041be3..18f58e321ea8 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
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
diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index ce89e5d2a040..a872301a9c68 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
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
@@ -728,7 +730,6 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	struct device_node *node;
 	struct device *parent;
 	struct rockchip_pmu *pmu;
-	const struct of_device_id *match;
 	const struct rockchip_pmu_info *pmu_info;
 	int error;
 
@@ -737,13 +738,7 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
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


