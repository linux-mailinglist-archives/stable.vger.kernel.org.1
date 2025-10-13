Return-Path: <stable+bounces-185319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29FDBD5323
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF84426C1A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE9830DD0D;
	Mon, 13 Oct 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0O1Rh2PL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE630DD03;
	Mon, 13 Oct 2025 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369956; cv=none; b=Pznvfj5BRcTbMfQUjmS6KzSWvs4wrC8rBCZ9ii4LWvLFoET+A0rBY8p/DfVkZIGiJpaE6aVzf8/9KeXfb/44wb1SC1x7Ltq3GzUGJxL9aP+EpctanoysItQUyCW4B89CDlcuuBd11hfg9/s1LklgimWsfGrPQEWHhaTt7gdj06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369956; c=relaxed/simple;
	bh=N7v3MWlJGLI4hEMS/lWPid2R3tpQJfjBHFrQhY4o+i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DztCCe5HBk6TK5y1Td2TXJ/gRsa2+ixmsLDg4WgDC8nnaibdkWxrpYBsicayJmi/54agnTjRY5Qt+DwePiIElSW4KyB91L9HwzXbxEPnCTiYn0pgy6pWitUxumVLEIDiSZQ2Yx0LHLs0F4+1uCj+Py18jd1DbXCi/qPtPgFBAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0O1Rh2PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DE5C4CEE7;
	Mon, 13 Oct 2025 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369955;
	bh=N7v3MWlJGLI4hEMS/lWPid2R3tpQJfjBHFrQhY4o+i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0O1Rh2PLTVdy/mkLT+hzk6E6sIDOuRdgEQbuVbui/mcfd63I7i5wV61nn8D3neYo7
	 2itdr31uyhj/peBL7E4hfQEyPJD/MsdxNInOW07hVTx9gP/L+m65uTJlpEpK2xbEn1
	 MoxNXIlZsqbjsAyIo24hpOvj/qwj39J+7ZECIYVE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 428/563] coresight: Appropriately disable programming clocks
Date: Mon, 13 Oct 2025 16:44:49 +0200
Message-ID: <20251013144426.792039520@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo Yan <leo.yan@arm.com>

[ Upstream commit 1abc1b212effe920f4729353880c8e03f1d76b4b ]

Some CoreSight components have programming clocks (pclk) and are enabled
using clk_get() and clk_prepare_enable().  However, in many cases, these
clocks are not disabled when modules exit and only released by clk_put().

To fix the issue, this commit refactors programming clock by replacing
clk_get() and clk_prepare_enable() with devm_clk_get_optional_enabled()
for enabling APB clock. If the "apb_pclk" clock is not found, a NULL
pointer is returned, and the function proceeds to attempt enabling the
"apb" clock.

Since ACPI platforms rely on firmware to manage clocks, returning a NULL
pointer in this case leaves clock management to the firmware rather than
the driver. This effectively avoids a clock imbalance issue during
module removal - where the clock could be disabled twice: once during
the ACPI runtime suspend and again during the devm resource release.

Callers are updated to reuse the returned error value.

With the change, programming clocks are managed as resources in driver
model layer, allowing clock cleanup to be handled automatically.  As a
result, manual cleanup operations are no longer needed and are removed
from the Coresight drivers.

Fixes: 73d779a03a76 ("coresight: etm4x: Change etm4_platform_driver driver for MMIO devices")
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20250731-arm_cs_fix_clock_v4-v6-4-1dfe10bb3f6f@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-catu.c  |  9 ++------
 .../hwtracing/coresight/coresight-cpu-debug.c |  6 +----
 .../hwtracing/coresight/coresight-ctcu-core.c | 10 ++-------
 .../coresight/coresight-etm4x-core.c          |  9 ++------
 .../hwtracing/coresight/coresight-funnel.c    |  6 +----
 .../coresight/coresight-replicator.c          |  6 +----
 drivers/hwtracing/coresight/coresight-stm.c   |  4 +---
 .../hwtracing/coresight/coresight-tmc-core.c  |  4 +---
 drivers/hwtracing/coresight/coresight-tpiu.c  |  4 +---
 include/linux/coresight.h                     | 22 ++++++++-----------
 10 files changed, 21 insertions(+), 59 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index af2a55f0c907c..4c345ff2cff14 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -636,7 +636,7 @@ static int catu_platform_probe(struct platform_device *pdev)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
@@ -645,11 +645,8 @@ static int catu_platform_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, drvdata);
 	ret = __catu_probe(&pdev->dev, res);
 	pm_runtime_put(&pdev->dev);
-	if (ret) {
+	if (ret)
 		pm_runtime_disable(&pdev->dev);
-		if (!IS_ERR_OR_NULL(drvdata->pclk))
-			clk_put(drvdata->pclk);
-	}
 
 	return ret;
 }
@@ -663,8 +660,6 @@ static void catu_platform_remove(struct platform_device *pdev)
 
 	__catu_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index a871d997330b0..e39dfb886688e 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -699,7 +699,7 @@ static int debug_platform_probe(struct platform_device *pdev)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
@@ -710,8 +710,6 @@ static int debug_platform_probe(struct platform_device *pdev)
 	if (ret) {
 		pm_runtime_put_noidle(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
-		if (!IS_ERR_OR_NULL(drvdata->pclk))
-			clk_put(drvdata->pclk);
 	}
 	return ret;
 }
@@ -725,8 +723,6 @@ static void debug_platform_remove(struct platform_device *pdev)
 
 	__debug_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index c6bafc96db963..de279efe34058 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -209,7 +209,7 @@ static int ctcu_probe(struct platform_device *pdev)
 
 	drvdata->apb_clk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->apb_clk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->apb_clk);
 
 	cfgs = of_device_get_match_data(dev);
 	if (cfgs) {
@@ -233,12 +233,8 @@ static int ctcu_probe(struct platform_device *pdev)
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 
 	drvdata->csdev = coresight_register(&desc);
-	if (IS_ERR(drvdata->csdev)) {
-		if (!IS_ERR_OR_NULL(drvdata->apb_clk))
-			clk_put(drvdata->apb_clk);
-
+	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
-	}
 
 	return 0;
 }
@@ -275,8 +271,6 @@ static void ctcu_platform_remove(struct platform_device *pdev)
 
 	ctcu_remove(pdev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->apb_clk))
-		clk_put(drvdata->apb_clk);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 81f20a167e001..4b98a7bf4cb73 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2309,14 +2309,12 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	if (res) {
 		drvdata->base = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(drvdata->base)) {
-			clk_put(drvdata->pclk);
+		if (IS_ERR(drvdata->base))
 			return PTR_ERR(drvdata->base);
-		}
 	}
 
 	dev_set_drvdata(&pdev->dev, drvdata);
@@ -2423,9 +2421,6 @@ static void etm4_remove_platform_dev(struct platform_device *pdev)
 	if (drvdata)
 		etm4_remove_dev(drvdata);
 	pm_runtime_disable(&pdev->dev);
-
-	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 static const struct amba_id etm4_ids[] = {
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index b1922dbe9292b..36fc4e991458c 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -240,7 +240,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	/*
 	 * Map the device base for dynamic-funnel, which has been
@@ -284,8 +284,6 @@ static int funnel_probe(struct device *dev, struct resource *res)
 out_disable_clk:
 	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
-	if (ret && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_disable_unprepare(drvdata->pclk);
 	return ret;
 }
 
@@ -355,8 +353,6 @@ static void funnel_platform_remove(struct platform_device *pdev)
 
 	funnel_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 static const struct of_device_id funnel_match[] = {
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 06efd2b01a0f7..6dd24eb10a94b 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -247,7 +247,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	/*
 	 * Map the device base for dynamic-replicator, which has been
@@ -296,8 +296,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
 out_disable_clk:
 	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
-	if (ret && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_disable_unprepare(drvdata->pclk);
 	return ret;
 }
 
@@ -335,8 +333,6 @@ static void replicator_platform_remove(struct platform_device *pdev)
 
 	replicator_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index e45c6c7204b44..88ee453b28154 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -851,7 +851,7 @@ static int __stm_probe(struct device *dev, struct resource *res)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 	dev_set_drvdata(dev, drvdata);
 
 	base = devm_ioremap_resource(dev, res);
@@ -1033,8 +1033,6 @@ static void stm_platform_remove(struct platform_device *pdev)
 
 	__stm_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 0b5e7635a084d..e867198b03e82 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -991,7 +991,7 @@ static int tmc_platform_probe(struct platform_device *pdev)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
@@ -1015,8 +1015,6 @@ static void tmc_platform_remove(struct platform_device *pdev)
 
 	__tmc_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 3e01592884280..b2559c6fac6d2 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -153,7 +153,7 @@ static int __tpiu_probe(struct device *dev, struct resource *res)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -293,8 +293,6 @@ static void tpiu_platform_remove(struct platform_device *pdev)
 
 	__tpiu_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_ACPI
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4ac65c68bbf44..1e652e1578419 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -6,6 +6,7 @@
 #ifndef _LINUX_CORESIGHT_H
 #define _LINUX_CORESIGHT_H
 
+#include <linux/acpi.h>
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -480,26 +481,21 @@ static inline bool is_coresight_device(void __iomem *base)
  * Returns:
  *
  * clk   - Clock is found and enabled
- * NULL  - clock is not found
+ * NULL  - Clock is controlled by firmware (ACPI device only)
  * ERROR - Clock is found but failed to enable
  */
 static inline struct clk *coresight_get_enable_apb_pclk(struct device *dev)
 {
 	struct clk *pclk;
-	int ret;
 
-	pclk = clk_get(dev, "apb_pclk");
-	if (IS_ERR(pclk)) {
-		pclk = clk_get(dev, "apb");
-		if (IS_ERR(pclk))
-			return NULL;
-	}
+	/* Firmware controls clocks for an ACPI device. */
+	if (has_acpi_companion(dev))
+		return NULL;
+
+	pclk = devm_clk_get_optional_enabled(dev, "apb_pclk");
+	if (!pclk)
+		pclk = devm_clk_get_optional_enabled(dev, "apb");
 
-	ret = clk_prepare_enable(pclk);
-	if (ret) {
-		clk_put(pclk);
-		return ERR_PTR(ret);
-	}
 	return pclk;
 }
 
-- 
2.51.0




