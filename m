Return-Path: <stable+bounces-181903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E075BA9466
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437E83C7475
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D9F2FF677;
	Mon, 29 Sep 2025 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H5xzEOm7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1C2FBDF2
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151062; cv=none; b=tABN2KWk5m8cUzUiYsI2r8YUzR73ivmpf1pMjphsBN0VlM9KztofHCBxI+IURSsH7Jb9kb14pFuUXrIPyNoo1Ha2JlRIRFwxyx9WTr5zSjHR50J1YV9sNMoHUjnxnKemuB3NuLTFe5hjpeB2yFcQVOmCOZJRTCy5hzrR/zqp1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151062; c=relaxed/simple;
	bh=BoJgKJHULOP/d+qDWe7hA0xuzpkg7Gb8OdViOVIT8qY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cOdryMQa4832HfrLjZPJOfm2r+sxrFPYVxmx+ATFPT0wimJgKjCW9CjJ8Ewp5j6Zo2P6BZ5G6WRIiMMyx3OJmJd2R7hRjLNiDDTc/886krnyyqA1o9MWDHj4uG8h+lRd3+9LP7M13LR2Kj9Q+EbTUT6U7CIUL35HKdIAPFb9f1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H5xzEOm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04E1C4CEF4;
	Mon, 29 Sep 2025 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759151062;
	bh=BoJgKJHULOP/d+qDWe7hA0xuzpkg7Gb8OdViOVIT8qY=;
	h=Subject:To:Cc:From:Date:From;
	b=H5xzEOm71trbYk4W0zUkTpcidqMJW4jTvDvyY9bAr2ZX5qIGKUldOTyxD57kGZNdC
	 97/q/Ym4sFMve/7g2UGGAVkSIAzkkIcAPP5IFEgFTf7UuVZAZwkQD6RrTnMmI18Khr
	 5OERrCpfpOSU19UsBj/ivLVo610Hc1cS9gxEeqRo=
Subject: FAILED: patch "[PATCH] spi: cadence-qspi: defer runtime support on socfpga if reset" failed to apply to 6.1-stable tree
To: khairul.anuar.romli@altera.com,adrianhoyin.ng@altera.com,broonie@kernel.org,matthew.gerlach@altera.com,nirav.rabara@altera.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 15:04:14 +0200
Message-ID: <2025092914-monologue-unloving-05b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 30dbc1c8d50f13c1581b49abe46fe89f393eacbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092914-monologue-unloving-05b0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30dbc1c8d50f13c1581b49abe46fe89f393eacbf Mon Sep 17 00:00:00 2001
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Date: Wed, 10 Sep 2025 16:06:32 +0800
Subject: [PATCH] spi: cadence-qspi: defer runtime support on socfpga if reset
 bit is enabled

Enabling runtime PM allows the kernel to gate clocks and power to idle
devices. On SoCFPGA, a warm reset does not fully reinitialize these
domains.This leaves devices suspended and powered down, preventing U-Boot
or the kernel from reusing them after a warm reset, which breaks the boot
process.

Fixes: 4892b374c9b7 ("mtd: spi-nor: cadence-quadspi: Add runtime PM support")
CC: stable@vger.kernel.org # 6.12+
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Niravkumar L Rabara <nirav.rabara@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Link: https://patch.msgid.link/910aad68ba5d948919a7b90fa85a2fadb687229b.1757491372.git.khairul.anuar.romli@altera.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 9bf823348cd3..d288e9d9c187 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -46,6 +46,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_DMA_SET_MASK		BIT(7)
 #define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
 #define CQSPI_DISABLE_STIG_MODE		BIT(9)
+#define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -1468,14 +1469,17 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	int ret;
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
+	const struct cqspi_driver_platdata *ddata = of_device_get_match_data(dev);
 
 	if (refcount_read(&cqspi->inflight_ops) == 0)
 		return -ENODEV;
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret) {
-		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
-		return ret;
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
+			return ret;
+		}
 	}
 
 	if (!refcount_read(&cqspi->refcount))
@@ -1491,7 +1495,8 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	ret = cqspi_mem_process(mem, op);
 
-	pm_runtime_put_autosuspend(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_put_autosuspend(dev);
 
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
@@ -1985,11 +1990,12 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	pm_runtime_enable(dev);
-
-	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_get_noresume(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_enable(dev);
+		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_get_noresume(dev);
+	}
 
 	ret = spi_register_controller(host);
 	if (ret) {
@@ -1997,12 +2003,17 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_setup_failed;
 	}
 
-	pm_runtime_put_autosuspend(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_put_autosuspend(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
 
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
-	pm_runtime_disable(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -2013,7 +2024,11 @@ static int cqspi_probe(struct platform_device *pdev)
 
 static void cqspi_remove(struct platform_device *pdev)
 {
+	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	ddata = of_device_get_match_data(dev);
 
 	refcount_set(&cqspi->refcount, 0);
 
@@ -2026,14 +2041,17 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
-		clk_disable(cqspi->clk);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		if (pm_runtime_get_sync(&pdev->dev) >= 0)
+			clk_disable(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
 
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
 }
 
 static int cqspi_runtime_suspend(struct device *dev)
@@ -2112,7 +2130,8 @@ static const struct cqspi_driver_platdata socfpga_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE
 			| CQSPI_NO_SUPPORT_WR_COMPLETION
 			| CQSPI_SLOW_SRAM
-			| CQSPI_DISABLE_STIG_MODE,
+			| CQSPI_DISABLE_STIG_MODE
+			| CQSPI_DISABLE_RUNTIME_PM,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {


