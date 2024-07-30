Return-Path: <stable+bounces-64372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D23941D8A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE13B28C39B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997031A76DC;
	Tue, 30 Jul 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rAP122P9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AC1A76A4;
	Tue, 30 Jul 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359903; cv=none; b=ep2TGB6kbiPzFIOj5UWkBuKGk6yFhQplVmVGe+KBq9eN5OmIEyQJ6ysufQjFzw5zKxnyJTThzuz0KL4PVilAXmn+ie6iQEFE8AH/pFyFzz3mljO51B8+2p7OMloc9DUU2+aPMWgySLKNLPTjfl6UrZ4dcLeZvQUvfPtfkrynYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359903; c=relaxed/simple;
	bh=Ts10PYBYTtxabww7mvcbG66LrrOeny+dL/k0KZc6Eqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwGWuq4Jg52wW5eG2Hno1k+5qwT9rBZJBhMv40kKa1gQq2ONkmOkPnFX24WLfEq4f33RcqzdHWFWzkmlNT3jkAS3qSq9IFOu7AB8XJv7Tf7ixrhqZGSrlyNvx8fIk3Wfr4KS6YTOoIiu3vnSAR6qCKLhFLfSUnA8wm6V48zt5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rAP122P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA5AC4AF11;
	Tue, 30 Jul 2024 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359903;
	bh=Ts10PYBYTtxabww7mvcbG66LrrOeny+dL/k0KZc6Eqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rAP122P910euFeL/bDvgI17mQp1wq9pqY8znyHdopUmXYiHag8v0QxclyucUWFCdJ
	 ti/AJuesNwgcT3Sd2eqOoHRGIzL4dUQ4ddJNHL0yBxtGUX3BPPIm3GMkxqp1Jpf9cu
	 01WWXT1K9/PKWF+W9bkoHkwu3ClKjPrDUdRMmGF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 553/568] spi: microchip-core: switch to use modern name
Date: Tue, 30 Jul 2024 17:51:00 +0200
Message-ID: <20240730151701.774783516@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 8f8bf52ed5b76fc7958b0fbe3131540aecdff8ac ]

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20230823033003.3407403-7-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 3a5e76283672 ("spi: microchip-core: fix init function not setting the master and motorola modes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-microchip-core.c | 74 ++++++++++++++++----------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index cd624872dafb8..096008d006009 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -249,7 +249,7 @@ static inline void mchp_corespi_set_framesize(struct mchp_corespi *spi, int bt)
 static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
 {
 	u32 reg;
-	struct mchp_corespi *corespi = spi_master_get_devdata(spi->master);
+	struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
 
 	reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
 	reg &= ~BIT(spi_get_chipselect(spi, 0));
@@ -270,11 +270,11 @@ static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
 
 static int mchp_corespi_setup(struct spi_device *spi)
 {
-	struct mchp_corespi *corespi = spi_master_get_devdata(spi->master);
+	struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
 	/*
-	 * Active high slaves need to be specifically set to their inactive
+	 * Active high targets need to be specifically set to their inactive
 	 * states during probe by adding them to the "control group" & thus
 	 * driving their select line low.
 	 */
@@ -287,7 +287,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void mchp_corespi_init(struct spi_master *master, struct mchp_corespi *spi)
+static void mchp_corespi_init(struct spi_controller *host, struct mchp_corespi *spi)
 {
 	unsigned long clk_hz;
 	u32 control = mchp_corespi_read(spi, REG_CONTROL);
@@ -301,7 +301,7 @@ static void mchp_corespi_init(struct spi_master *master, struct mchp_corespi *sp
 
 	/* max. possible spi clock rate is the apb clock rate */
 	clk_hz = clk_get_rate(spi->clk);
-	master->max_speed_hz = clk_hz;
+	host->max_speed_hz = clk_hz;
 
 	/*
 	 * The controller must be configured so that it doesn't remove Chip
@@ -321,7 +321,7 @@ static void mchp_corespi_init(struct spi_master *master, struct mchp_corespi *sp
 	/*
 	 * It is required to enable direct mode, otherwise control over the chip
 	 * select is relinquished to the hardware. SSELOUT is enabled too so we
-	 * can deal with active high slaves.
+	 * can deal with active high targets.
 	 */
 	spi->pending_slave_select = SSELOUT | SSEL_DIRECT;
 	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
@@ -387,8 +387,8 @@ static inline void mchp_corespi_set_mode(struct mchp_corespi *spi, unsigned int
 
 static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct mchp_corespi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_id;
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 	u32 intfield = mchp_corespi_read(spi, REG_MIS) & 0xf;
 	bool finalise = false;
 
@@ -412,7 +412,7 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 	if (intfield & INT_RX_CHANNEL_OVERFLOW) {
 		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RX_CHANNEL_OVERFLOW);
 		finalise = true;
-		dev_err(&master->dev,
+		dev_err(&host->dev,
 			"%s: RX OVERFLOW: rxlen: %d, txlen: %d\n", __func__,
 			spi->rx_len, spi->tx_len);
 	}
@@ -420,13 +420,13 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 	if (intfield & INT_TX_CHANNEL_UNDERRUN) {
 		mchp_corespi_write(spi, REG_INT_CLEAR, INT_TX_CHANNEL_UNDERRUN);
 		finalise = true;
-		dev_err(&master->dev,
+		dev_err(&host->dev,
 			"%s: TX UNDERFLOW: rxlen: %d, txlen: %d\n", __func__,
 			spi->rx_len, spi->tx_len);
 	}
 
 	if (finalise)
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(host);
 
 	return IRQ_HANDLED;
 }
@@ -468,16 +468,16 @@ static int mchp_corespi_calculate_clkgen(struct mchp_corespi *spi,
 	return 0;
 }
 
-static int mchp_corespi_transfer_one(struct spi_master *master,
+static int mchp_corespi_transfer_one(struct spi_controller *host,
 				     struct spi_device *spi_dev,
 				     struct spi_transfer *xfer)
 {
-	struct mchp_corespi *spi = spi_master_get_devdata(master);
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = mchp_corespi_calculate_clkgen(spi, (unsigned long)xfer->speed_hz);
 	if (ret) {
-		dev_err(&master->dev, "failed to set clk_gen for target %u Hz\n", xfer->speed_hz);
+		dev_err(&host->dev, "failed to set clk_gen for target %u Hz\n", xfer->speed_hz);
 		return ret;
 	}
 
@@ -500,11 +500,11 @@ static int mchp_corespi_transfer_one(struct spi_master *master,
 	return 1;
 }
 
-static int mchp_corespi_prepare_message(struct spi_master *master,
+static int mchp_corespi_prepare_message(struct spi_controller *host,
 					struct spi_message *msg)
 {
 	struct spi_device *spi_dev = msg->spi;
-	struct mchp_corespi *spi = spi_master_get_devdata(master);
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 
 	mchp_corespi_set_framesize(spi, DEFAULT_FRAMESIZE);
 	mchp_corespi_set_mode(spi, spi_dev->mode);
@@ -514,32 +514,32 @@ static int mchp_corespi_prepare_message(struct spi_master *master,
 
 static int mchp_corespi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct mchp_corespi *spi;
 	struct resource *res;
 	u32 num_cs;
 	int ret = 0;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(*spi));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
+	if (!host)
 		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "unable to allocate master for SPI controller\n");
+				     "unable to allocate host for SPI controller\n");
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
 	if (of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs))
 		num_cs = MAX_CS;
 
-	master->num_chipselect = num_cs;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->setup = mchp_corespi_setup;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->transfer_one = mchp_corespi_transfer_one;
-	master->prepare_message = mchp_corespi_prepare_message;
-	master->set_cs = mchp_corespi_set_cs;
-	master->dev.of_node = pdev->dev.of_node;
+	host->num_chipselect = num_cs;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->setup = mchp_corespi_setup;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->transfer_one = mchp_corespi_transfer_one;
+	host->prepare_message = mchp_corespi_prepare_message;
+	host->set_cs = mchp_corespi_set_cs;
+	host->dev.of_node = pdev->dev.of_node;
 
-	spi = spi_master_get_devdata(master);
+	spi = spi_controller_get_devdata(host);
 
 	spi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(spi->regs))
@@ -550,7 +550,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 		return spi->irq;
 
 	ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
-			       IRQF_SHARED, dev_name(&pdev->dev), master);
+			       IRQF_SHARED, dev_name(&pdev->dev), host);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "could not request irq\n");
@@ -565,25 +565,25 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to enable clock\n");
 
-	mchp_corespi_init(master, spi);
+	mchp_corespi_init(host, spi);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
 		mchp_corespi_disable(spi);
 		clk_disable_unprepare(spi->clk);
 		return dev_err_probe(&pdev->dev, ret,
-				     "unable to register master for SPI controller\n");
+				     "unable to register host for SPI controller\n");
 	}
 
-	dev_info(&pdev->dev, "Registered SPI controller %d\n", master->bus_num);
+	dev_info(&pdev->dev, "Registered SPI controller %d\n", host->bus_num);
 
 	return 0;
 }
 
 static void mchp_corespi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master  = platform_get_drvdata(pdev);
-	struct mchp_corespi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host  = platform_get_drvdata(pdev);
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 
 	mchp_corespi_disable_ints(spi);
 	clk_disable_unprepare(spi->clk);
-- 
2.43.0




