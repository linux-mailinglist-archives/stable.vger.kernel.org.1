Return-Path: <stable+bounces-181904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A253BA9469
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5517A50F2
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6CD2FBDF2;
	Mon, 29 Sep 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="luAHLTHh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CFC2EA
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151065; cv=none; b=nFQOJYsyUht4BDqBonXl6jALpA47Z3aCBNK0yU9Pt5PngQAyt8HnLOJFE9f3NCmSDFw8YKVkmWxSe0M8R1HGzZPUDtZ99w76T7syKL+5jwilB7iCV8l1RRIqkCKOeYOdM44sM82fBW6uO/k20d8ZmlnB4jZ3A7u+5LSrc3fCmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151065; c=relaxed/simple;
	bh=/NBFonhknSqS2Qr+pSqCI7wJnMPPKFetipN3weRuP70=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m2hMJwj56rLNlBohucmSDJyS5jKQdAAgYCqVjlxMck7f/OdEQP/5lEcQ/YzpQ/eFrkewN6EA4dgz/l1cQzH72KIOxoHfSwPz8wJgES4pqsY0ESvVsz5cQjURrx0M5w/4UFNbzOVyLq6evYpTxtfRvhRci9cJt4RoRlKSvj7OYSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=luAHLTHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3105C4CEF4;
	Mon, 29 Sep 2025 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759151065;
	bh=/NBFonhknSqS2Qr+pSqCI7wJnMPPKFetipN3weRuP70=;
	h=Subject:To:Cc:From:Date:From;
	b=luAHLTHhMbvP9BQKqQvD/vYGm5WvikS11RMw0OJ1jXpcEyrNMvijLIvaFQYClAq/i
	 1pEklChnfb4FxxZiWvtRbfN9BC05LsjfJqT9IHa305vR1nF7vbyTUqKhYESp6jdgoq
	 hwFHB/ExlSK8hq+lUTAwoGueoOGPsNlzU5A8GnBI=
Subject: FAILED: patch "[PATCH] spi: cadence-qspi: defer runtime support on socfpga if reset" failed to apply to 6.6-stable tree
To: khairul.anuar.romli@altera.com,adrianhoyin.ng@altera.com,broonie@kernel.org,matthew.gerlach@altera.com,nirav.rabara@altera.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 15:04:14 +0200
Message-ID: <2025092914-occupy-barge-2555@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 30dbc1c8d50f13c1581b49abe46fe89f393eacbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092914-occupy-barge-2555@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


