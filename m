Return-Path: <stable+bounces-181994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902BBAA7D0
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 21:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098061C5B2F
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 19:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459924111D;
	Mon, 29 Sep 2025 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX9DeyQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E561E3DE8
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174980; cv=none; b=YfSAXVpx1ses9x4xGEctYTE9tzH3hHmx1uU4BZYMa2cDNYZm8LGsTAiUPGyujP0uen3lQveLLPXvhfkHS7Sx4//06zlNd4sWgVQMC/mRSq3BNT4hK1LgJi2kfEyMhiU2m0uLYZeXDKWihjmaZvVku1PXVu5W16CObhR7isvMUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174980; c=relaxed/simple;
	bh=PzKztbX/a0nQ9OxRDUp5igE879QHQbv4eygIl6em954=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDTC6ZGO1LzvT8AX9R1bRotosdzJgZ2nR1JOofDpVBhOYxZlCNCtC0PDSMt6YPq+/F5NuNha4W8u4TeYDEtqYPFWcs06oUvRnGZaZuWIJWO88Aypj1cJOts4BwMC/hoKPnJReJ7p4e3qyIcixDynPQkUFANIsdgTiVwiKO0gNSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DX9DeyQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F93C113D0;
	Mon, 29 Sep 2025 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174979;
	bh=PzKztbX/a0nQ9OxRDUp5igE879QHQbv4eygIl6em954=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DX9DeyQQoygUjPJnCPXC7TLpyop7FQUvhgjwM49Q+ebSIWDXfeJXvifAAIC9AbL1k
	 3/15DoD+7wSS6agoCaf+vrWsBuavlM6C63DPkj8sm6E8/AOFvscmR1TKho8P8Q7uH4
	 GrHoRVpCTb0fFO5J8SBbAa9EOnL/yruvUoUlCpLME9XPIiBk6ZYKnmPmBsB96n3n9p
	 pApxYHOunIuOzrKIq2r+jSvYPvIxcVeI0wjTunuCLa92ExAld89Ybz5vSQXO6t4t3l
	 eaB1xD5aEyaKy1GwIydOAZtLz8QsaTV7fac9SNc3svu2JiigI4X7dRzwc7CmCo5soX
	 SlWgCrOEsoM5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled
Date: Mon, 29 Sep 2025 15:42:55 -0400
Message-ID: <20250929194255.332788-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929194255.332788-1-sashal@kernel.org>
References: <2025092913-wriggly-condition-4b00@gregkh>
 <20250929194255.332788-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

[ Upstream commit 30dbc1c8d50f13c1581b49abe46fe89f393eacbf ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 57 ++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d656f36002887..c9eb8004fcc27 100644
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
@@ -1491,8 +1495,10 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	ret = cqspi_mem_process(mem, op);
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
 
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
@@ -1986,11 +1992,12 @@ static int cqspi_probe(struct platform_device *pdev)
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
@@ -1998,13 +2005,17 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_setup_failed;
 	}
 
-	pm_runtime_mark_last_busy(dev);
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
@@ -2015,7 +2026,11 @@ static int cqspi_probe(struct platform_device *pdev)
 
 static void cqspi_remove(struct platform_device *pdev)
 {
+	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	ddata = of_device_get_match_data(dev);
 
 	refcount_set(&cqspi->refcount, 0);
 
@@ -2028,14 +2043,17 @@ static void cqspi_remove(struct platform_device *pdev)
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
@@ -2114,7 +2132,8 @@ static const struct cqspi_driver_platdata socfpga_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE
 			| CQSPI_NO_SUPPORT_WR_COMPLETION
 			| CQSPI_SLOW_SRAM
-			| CQSPI_DISABLE_STIG_MODE,
+			| CQSPI_DISABLE_STIG_MODE
+			| CQSPI_DISABLE_RUNTIME_PM,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
-- 
2.51.0


