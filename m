Return-Path: <stable+bounces-180983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC99B91FFB
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320892A40D1
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D67C2EA72A;
	Mon, 22 Sep 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b="RgxdkXik"
X-Original-To: stable@vger.kernel.org
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD113C0C
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555648; cv=none; b=qHl7+HRG74EAsWmyPbBFjT+mA+Ob2/l+arAwVmI1MMJeGs0NqW35QuukbMbLltfzB4wsCRJUU+N6SPvzO1wkKhhe8Z15hZ6PVKHpAvGpchKDPnlJkvtwn1CX+fYvs9KwAZhMWN9vrJcsESUSsm7xc9nhkj5AqeOrqcmuiqAJVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555648; c=relaxed/simple;
	bh=lTqVCEjcxikwMjepirSLpSNK6L3IHAlxdl5A38gWUoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnyvbQbdV+SLWQMQwAA+1ezvSp9VlV3xSErkS3MVvvkdOT3uxKPnVI0begkBt7QGxCWLDD1WuLtWLiSG3QeUBf/6ReFGL6yd0KFtmbOI52hzTxYEF3mSwqrdSPBPP/e1lD+cb+KUCMpITr50igxnZ05uUXRQz0Lj6GNLOeyElQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be; spf=pass smtp.mailfrom=zanders.be; dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b=RgxdkXik; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zanders.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zanders.be; s=202002;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=4m4XxfeOnQfD8SjFcUdl5itKBGk9YX/dPDna0jtQUXw=;
	b=RgxdkXikJ4C1IUraDotl7A2lAWMKaHYSAdsmuRZvm8BojeT9lKz3aDSFV1hDbNaweRDCh65I7biJD
	 QEURI2TTb330OHUuQRBgLjMiQYEsiY89rmaIZc+Zg7vZkcH3LOBVNDNHABrjRM4BsfWVCBqHGImtje
	 KIuRjKZLZQOHMX/CGGZEXlXcOBO6n5SZOdErPH88gOy0+aJ1meSxnI2ZdQJroQyPfJccylXC5/mFX5
	 E0odx9cc8O4C/CrXGk+VMvpqDBnOsLLJwCy4dWjPUB7fO6l/tCtfVGxCW1cOPzsn/26JdD5BMOIbYg
	 Njis3hRXa303t/tc+Vdoq4kKIaUpNaw==
X-MSG-ID: 78c8b809-97ca-11f0-867b-0050568164d1
From: Maarten Zanders <maarten@zanders.be>
To: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maarten Zanders <maarten@zanders.be>,
	stable@vger.kernel.org,
	imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: nand: raw: gpmi: fix clocks when CONFIG_PM=N
Date: Mon, 22 Sep 2025 17:39:38 +0200
Message-ID: <20250922153938.743640-2-maarten@zanders.be>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f04ced6d545e ("mtd: nand: raw: gpmi: improve power management
handling") moved all clock handling into PM callbacks. With CONFIG_PM
disabled, those callbacks are missing, leaving the driver unusable.

Add clock init/teardown for !CONFIG_PM builds to restore basic operation.
Keeping the driver working without requiring CONFIG_PM is preferred over
adding a Kconfig dependency.

Fixes: f04ced6d545e ("mtd: nand: raw: gpmi: improve power management handling")
Signed-off-by: Maarten Zanders <maarten@zanders.be>
Cc: stable@vger.kernel.org
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index f4e68008ea03..a750f5839e34 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -145,6 +145,9 @@ static int __gpmi_enable_clk(struct gpmi_nand_data *this, bool v)
 	return ret;
 }
 
+#define gpmi_enable_clk(x)	__gpmi_enable_clk(x, true)
+#define gpmi_disable_clk(x)	__gpmi_enable_clk(x, false)
+
 static int gpmi_init(struct gpmi_nand_data *this)
 {
 	struct resources *r = &this->resources;
@@ -2765,6 +2768,11 @@ static int gpmi_nand_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
 	pm_runtime_use_autosuspend(&pdev->dev);
+#ifndef CONFIG_PM
+	ret = gpmi_enable_clk(this);
+	if (ret)
+		goto exit_acquire_resources;
+#endif
 
 	ret = gpmi_init(this);
 	if (ret)
@@ -2800,6 +2808,9 @@ static void gpmi_nand_remove(struct platform_device *pdev)
 	release_resources(this);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+#ifndef CONFIG_PM
+	gpmi_disable_clk(this);
+#endif
 }
 
 static int gpmi_pm_suspend(struct device *dev)
@@ -2846,9 +2857,6 @@ static int gpmi_pm_resume(struct device *dev)
 	return 0;
 }
 
-#define gpmi_enable_clk(x)	__gpmi_enable_clk(x, true)
-#define gpmi_disable_clk(x)	__gpmi_enable_clk(x, false)
-
 static int gpmi_runtime_suspend(struct device *dev)
 {
 	struct gpmi_nand_data *this = dev_get_drvdata(dev);
-- 
2.51.0


