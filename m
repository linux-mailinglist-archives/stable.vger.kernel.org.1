Return-Path: <stable+bounces-67928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A247A952FCB
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C807A1C2492E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD001A00DF;
	Thu, 15 Aug 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EeD33gfI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C4E1A00D1;
	Thu, 15 Aug 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728959; cv=none; b=PS5eIUhAoFKdiVVlh4PcChN6XiS5Q3zjInOPnljY4nQT2ngD2MzstqRTTNMwYzksB6bYDp7kkKIfAg/QCBR4E3X5oJBG1zUwoFBjPujEsBWAyiMPZR7oaP+7e/n2Uadrg/WM0/r0BwaQJSGlkPpOflicKDQiAKFiu8j5k1nltDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728959; c=relaxed/simple;
	bh=FKMeuB+rMszW6TbWS3wT/nQxCyPCzSL+MyXQ+yg53j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTP+exxThKLcBRBDvK6vgZ3eEsEWawmSagD2xkhj/RQXIPnAnfU0AFBITf7BYSX47j7LT6Kd5GB+jP+Jsjqx5rkwoSkvAq46r9xYAOnB2Scblhh2ohtw064VmTm0or2JDWmJu/nmAyLZFWGrfcyhqbqJqpFbQPUZvnm3thtxS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EeD33gfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EACC32786;
	Thu, 15 Aug 2024 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728959;
	bh=FKMeuB+rMszW6TbWS3wT/nQxCyPCzSL+MyXQ+yg53j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeD33gfIffA7kEFcTwoG+9Xx5ZJOH0XCDyBPtiIrWebkJT39BseHDa5jSzwHiG+FW
	 xxMXQbWkSQ9sfJEZh1jlEslvORnCsrEBtkf3E4R1GVGhLdFo3CiELfKYqNOgvEtQVA
	 uLlRYywZW5Bt/ljVzVulxJ/siQ9w8uDdG8jB/cEo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Clark Wang <xiaoning.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 165/196] spi: lpspi: Replace all "master" with "controller"
Date: Thu, 15 Aug 2024 15:24:42 +0200
Message-ID: <20240815131858.386254466@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clark Wang <xiaoning.wang@nxp.com>

[ Upstream commit 07d71557494c05b0651def1651bf6d7e7f47bbbb ]

In order to enable the slave mode and make the code more readable,
replace all related structure names and object names which is
named "master" with "controller".

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 730bbfaf7d48 ("spi: spi-fsl-lpspi: Fix scldiv calculation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 84 ++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 51670976faa35..725d6ac5f814d 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,6 +3,7 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2018 NXP Semiconductors
 
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -137,16 +138,18 @@ static void fsl_lpspi_intctrl(struct fsl_lpspi_data *fsl_lpspi,
 	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
 }
 
-static int lpspi_prepare_xfer_hardware(struct spi_master *master)
+static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
 {
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
 
 	return clk_prepare_enable(fsl_lpspi->clk);
 }
 
-static int lpspi_unprepare_xfer_hardware(struct spi_master *master)
+static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller)
 {
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
 
 	clk_disable_unprepare(fsl_lpspi->clk);
 
@@ -291,7 +294,8 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 static void fsl_lpspi_setup_transfer(struct spi_device *spi,
 				     struct spi_transfer *t)
 {
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(spi->master);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(spi->controller);
 
 	fsl_lpspi->config.mode = spi->mode;
 	fsl_lpspi->config.bpw = t ? t->bits_per_word : spi->bits_per_word;
@@ -318,11 +322,12 @@ static void fsl_lpspi_setup_transfer(struct spi_device *spi,
 	fsl_lpspi_config(fsl_lpspi);
 }
 
-static int fsl_lpspi_transfer_one(struct spi_master *master,
+static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
 {
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
 	int ret;
 
 	fsl_lpspi->tx_buf = t->tx_buf;
@@ -347,10 +352,11 @@ static int fsl_lpspi_transfer_one(struct spi_master *master,
 	return 0;
 }
 
-static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
+static int fsl_lpspi_transfer_one_msg(struct spi_controller *controller,
 				      struct spi_message *msg)
 {
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
 	struct spi_device *spi = msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_xfer = true;
@@ -366,7 +372,7 @@ static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
 
 		is_first_xfer = false;
 
-		ret = fsl_lpspi_transfer_one(master, spi, xfer);
+		ret = fsl_lpspi_transfer_one(controller, spi, xfer);
 		if (ret < 0)
 			goto complete;
 
@@ -380,7 +386,7 @@ static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
 
 	msg->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(controller);
 
 	return ret;
 }
@@ -410,30 +416,31 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
 	struct fsl_lpspi_data *fsl_lpspi;
-	struct spi_master *master;
+	struct spi_controller *controller;
 	struct resource *res;
 	int ret, irq;
 	u32 temp;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_lpspi_data));
-	if (!master)
+	controller = spi_alloc_master(&pdev->dev,
+					sizeof(struct fsl_lpspi_data));
+	if (!controller)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, controller);
 
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
-	master->bus_num = pdev->id;
+	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
+	controller->bus_num = pdev->id;
 
-	fsl_lpspi = spi_master_get_devdata(master);
+	fsl_lpspi = spi_controller_get_devdata(controller);
 	fsl_lpspi->dev = &pdev->dev;
 
-	master->transfer_one_message = fsl_lpspi_transfer_one_msg;
-	master->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
-	master->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
-	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = pdev->id;
+	controller->transfer_one_message = fsl_lpspi_transfer_one_msg;
+	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
+	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
+	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->dev.of_node = pdev->dev.of_node;
+	controller->bus_num = pdev->id;
 
 	init_completion(&fsl_lpspi->xfer_done);
 
@@ -441,32 +448,32 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(fsl_lpspi->base)) {
 		ret = PTR_ERR(fsl_lpspi->base);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, 0,
 			       dev_name(&pdev->dev), fsl_lpspi);
 	if (ret) {
 		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	fsl_lpspi->clk = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(fsl_lpspi->clk)) {
 		ret = PTR_ERR(fsl_lpspi->clk);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	ret = clk_prepare_enable(fsl_lpspi->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "can't enable lpspi clock, ret=%d\n", ret);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
@@ -475,24 +482,25 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(fsl_lpspi->clk);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_master error.\n");
-		goto out_master_put;
+		dev_err(&pdev->dev, "spi_register_controller error.\n");
+		goto out_controller_put;
 	}
 
 	return 0;
 
-out_master_put:
-	spi_master_put(master);
+out_controller_put:
+	spi_controller_put(controller);
 
 	return ret;
 }
 
 static int fsl_lpspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct spi_controller *controller = platform_get_drvdata(pdev);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
 
 	clk_disable_unprepare(fsl_lpspi->clk);
 
@@ -509,6 +517,6 @@ static struct platform_driver fsl_lpspi_driver = {
 };
 module_platform_driver(fsl_lpspi_driver);
 
-MODULE_DESCRIPTION("LPSPI Master Controller driver");
+MODULE_DESCRIPTION("LPSPI Controller driver");
 MODULE_AUTHOR("Gao Pan <pandy.gao@nxp.com>");
 MODULE_LICENSE("GPL");
-- 
2.43.0




