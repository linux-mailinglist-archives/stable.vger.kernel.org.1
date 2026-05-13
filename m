Return-Path: <stable+bounces-247047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOSjL64DBWpRRgIAu9opvQ
	(envelope-from <stable+bounces-247047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:05:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAEA53BBF2
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC74E3019568
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372153C9896;
	Wed, 13 May 2026 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cix2FM3k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E733C4B84
	for <stable@vger.kernel.org>; Wed, 13 May 2026 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713517; cv=none; b=RGLvrt4JauOC0VHiDJYtjBW5kmWLUZFHA5cZkBZxczliRQ+Jv8T5lhnp2316XDwr9V4KQZS/ONVXIfK9vnpvLYKIEzl8AfxjvXKo8+BBOGjJpWjxtaZz2BIgqA5Y9m9srZfftZ+0sX/BQn2pInRKb3KuHWwRWczcABJvC0UL1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713517; c=relaxed/simple;
	bh=pMlBfZXBaw4Y0ZFQvj4LcKhfI+i3i/TV1Ga1YxxGoOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEEeMVlQOqcVSmo20s7MibzCsPYMi2TZY8/UwjmsbgBR84WXrDZSev64BRI66c6YXgoAvcLEYVfCNLnY2NPPHRKgfJpQtwT+YU74ZBBTY0sBhZovI319vrjhX/hQxDwew1rPK9UJc1AcN3daHWo6KEpS7hYO/7Twx18/DPXuDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cix2FM3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF21EC19425;
	Wed, 13 May 2026 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778713516;
	bh=pMlBfZXBaw4Y0ZFQvj4LcKhfI+i3i/TV1Ga1YxxGoOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cix2FM3kwTxDg3IpqQHiYguyfE8m4D2MTDqv91itzuxQflQC28q0vfYycukSUM7uF
	 Sb18OktXj4wz2Z62vDOF1U8Zr65kBtNj0NZrL4Xysnjeh2AaAo+iULloMDjhpoCDux
	 DVWhq8vzX4zDcgnJLRkQ2NPg6bt13YOHv3ztsXhPp2r424lHI5wmxf9jpWR874GKgE
	 OlCgUImlAln1RGrIvcYfzOaD47ZHWcdEZtvcHvFSmOBWn8izprJHTZ3CV41EDmq+Rn
	 ZUb8+zl3GGk0lP8eVCZr965FOi6wz6O14IUsbnV5CCs/PfyNGzNWpTLf9WdAQRNg6C
	 +DfqV4USWHd+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] spi: sun6i: switch to use modern name
Date: Wed, 13 May 2026 19:05:12 -0400
Message-ID: <20260513230513.4027915-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051227-endorphin-facedown-91d1@gregkh>
References: <2026051227-endorphin-facedown-91d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6EAEA53BBF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247047-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 9f55bb79893a9dc75982372bee1307bdce48976b ]

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://msgid.link/r/20231128093031.3707034-8-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: d874a1c33aee ("spi: sun6i: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun6i.c | 148 ++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index fddc633097736..cd018ea1abf14 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -97,7 +97,7 @@ struct sun6i_spi_cfg {
 };
 
 struct sun6i_spi {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	void __iomem		*base_addr;
 	dma_addr_t		dma_addr_rx;
 	dma_addr_t		dma_addr_tx;
@@ -181,7 +181,7 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi)
 
 static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
+	struct sun6i_spi *sspi = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
@@ -212,7 +212,7 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 				 struct spi_transfer *tfr)
 {
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
-	struct spi_master *master = sspi->master;
+	struct spi_controller *host = sspi->host;
 
 	rxdesc = NULL;
 	if (tfr->rx_buf) {
@@ -223,9 +223,9 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 			.src_maxburst = 8,
 		};
 
-		dmaengine_slave_config(master->dma_rx, &rxconf);
+		dmaengine_slave_config(host->dma_rx, &rxconf);
 
-		rxdesc = dmaengine_prep_slave_sg(master->dma_rx,
+		rxdesc = dmaengine_prep_slave_sg(host->dma_rx,
 						 tfr->rx_sg.sgl,
 						 tfr->rx_sg.nents,
 						 DMA_DEV_TO_MEM,
@@ -245,38 +245,38 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 			.dst_maxburst = 8,
 		};
 
-		dmaengine_slave_config(master->dma_tx, &txconf);
+		dmaengine_slave_config(host->dma_tx, &txconf);
 
-		txdesc = dmaengine_prep_slave_sg(master->dma_tx,
+		txdesc = dmaengine_prep_slave_sg(host->dma_tx,
 						 tfr->tx_sg.sgl,
 						 tfr->tx_sg.nents,
 						 DMA_MEM_TO_DEV,
 						 DMA_PREP_INTERRUPT);
 		if (!txdesc) {
 			if (rxdesc)
-				dmaengine_terminate_sync(master->dma_rx);
+				dmaengine_terminate_sync(host->dma_rx);
 			return -EINVAL;
 		}
 	}
 
 	if (tfr->rx_buf) {
 		dmaengine_submit(rxdesc);
-		dma_async_issue_pending(master->dma_rx);
+		dma_async_issue_pending(host->dma_rx);
 	}
 
 	if (tfr->tx_buf) {
 		dmaengine_submit(txdesc);
-		dma_async_issue_pending(master->dma_tx);
+		dma_async_issue_pending(host->dma_tx);
 	}
 
 	return 0;
 }
 
-static int sun6i_spi_transfer_one(struct spi_master *master,
+static int sun6i_spi_transfer_one(struct spi_controller *host,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
 	unsigned int div, div_cdr1, div_cdr2, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int trig_level;
@@ -293,7 +293,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
-	use_dma = master->can_dma ? master->can_dma(master, spi, tfr) : false;
+	use_dma = host->can_dma ? host->can_dma(host, spi, tfr) : false;
 
 	/* Clear pending interrupts */
 	sun6i_spi_write(sspi, SUN6I_INT_STA_REG, ~0);
@@ -463,7 +463,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	} else {
 		ret = sun6i_spi_prepare_dma(sspi, tfr);
 		if (ret) {
-			dev_warn(&master->dev,
+			dev_warn(&host->dev,
 				 "%s: prepare DMA failed, ret=%d",
 				 dev_name(&spi->dev), ret);
 			return ret;
@@ -486,7 +486,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
 
-	tx_time = spi_controller_xfer_timeout(master, tfr);
+	tx_time = spi_controller_xfer_timeout(host, tfr);
 	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
 					      msecs_to_jiffies(tx_time));
@@ -502,13 +502,13 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 			timeout = wait_for_completion_timeout(&sspi->dma_rx_done,
 							      timeout);
 			if (!timeout)
-				dev_warn(&master->dev, "RX DMA timeout\n");
+				dev_warn(&host->dev, "RX DMA timeout\n");
 		}
 	}
 
 	end = jiffies;
 	if (!timeout) {
-		dev_warn(&master->dev,
+		dev_warn(&host->dev,
 			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
 			 jiffies_to_msecs(end - start), tx_time);
@@ -518,8 +518,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
 
 	if (ret && use_dma) {
-		dmaengine_terminate_sync(master->dma_rx);
-		dmaengine_terminate_sync(master->dma_tx);
+		dmaengine_terminate_sync(host->dma_rx);
+		dmaengine_terminate_sync(host->dma_tx);
 	}
 
 	return ret;
@@ -564,8 +564,8 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 
 static int sun6i_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(sspi->hclk);
@@ -601,8 +601,8 @@ static int sun6i_spi_runtime_resume(struct device *dev)
 
 static int sun6i_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
 
 	reset_control_assert(sspi->rstc);
 	clk_disable_unprepare(sspi->mclk);
@@ -611,11 +611,11 @@ static int sun6i_spi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static bool sun6i_spi_can_dma(struct spi_master *master,
+static bool sun6i_spi_can_dma(struct spi_controller *host,
 			      struct spi_device *spi,
 			      struct spi_transfer *xfer)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
 
 	/*
 	 * If the number of spi words to transfer is less or equal than
@@ -627,67 +627,67 @@ static bool sun6i_spi_can_dma(struct spi_master *master,
 
 static int sun6i_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct sun6i_spi *sspi;
 	struct resource *mem;
 	int ret = 0, irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sun6i_spi));
-	if (!master) {
-		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(struct sun6i_spi));
+	if (!host) {
+		dev_err(&pdev->dev, "Unable to allocate SPI Host\n");
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(pdev, master);
-	sspi = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, host);
+	sspi = spi_controller_get_devdata(host);
 
 	sspi->base_addr = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(sspi->base_addr)) {
 		ret = PTR_ERR(sspi->base_addr);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENXIO;
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun6i_spi_handler,
 			       0, "sun6i-spi", sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
-		goto err_free_master;
+		goto err_free_host;
 	}
 
-	sspi->master = master;
+	sspi->host = host;
 	sspi->cfg = of_device_get_match_data(&pdev->dev);
 
-	master->max_speed_hz = 100 * 1000 * 1000;
-	master->min_speed_hz = 3 * 1000;
-	master->use_gpio_descriptors = true;
-	master->set_cs = sun6i_spi_set_cs;
-	master->transfer_one = sun6i_spi_transfer_one;
-	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    sspi->cfg->mode_bits;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->dev.of_node = pdev->dev.of_node;
-	master->auto_runtime_pm = true;
-	master->max_transfer_size = sun6i_spi_max_transfer_size;
+	host->max_speed_hz = 100 * 1000 * 1000;
+	host->min_speed_hz = 3 * 1000;
+	host->use_gpio_descriptors = true;
+	host->set_cs = sun6i_spi_set_cs;
+	host->transfer_one = sun6i_spi_transfer_one;
+	host->num_chipselect = 4;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			  sspi->cfg->mode_bits;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->dev.of_node = pdev->dev.of_node;
+	host->auto_runtime_pm = true;
+	host->max_transfer_size = sun6i_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
 		dev_err(&pdev->dev, "Unable to acquire AHB clock\n");
 		ret = PTR_ERR(sspi->hclk);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	sspi->mclk = devm_clk_get(&pdev->dev, "mod");
 	if (IS_ERR(sspi->mclk)) {
 		dev_err(&pdev->dev, "Unable to acquire module clock\n");
 		ret = PTR_ERR(sspi->mclk);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	init_completion(&sspi->done);
@@ -697,34 +697,34 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(sspi->rstc)) {
 		dev_err(&pdev->dev, "Couldn't get reset controller\n");
 		ret = PTR_ERR(sspi->rstc);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
-	master->dma_tx = dma_request_chan(&pdev->dev, "tx");
-	if (IS_ERR(master->dma_tx)) {
+	host->dma_tx = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR(host->dma_tx)) {
 		/* Check tx to see if we need defer probing driver */
-		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER) {
+		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto err_free_master;
+			goto err_free_host;
 		}
 		dev_warn(&pdev->dev, "Failed to request TX DMA channel\n");
-		master->dma_tx = NULL;
+		host->dma_tx = NULL;
 	}
 
-	master->dma_rx = dma_request_chan(&pdev->dev, "rx");
-	if (IS_ERR(master->dma_rx)) {
-		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER) {
+	host->dma_rx = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(host->dma_rx)) {
+		if (PTR_ERR(host->dma_rx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto err_free_dma_tx;
 		}
 		dev_warn(&pdev->dev, "Failed to request RX DMA channel\n");
-		master->dma_rx = NULL;
+		host->dma_rx = NULL;
 	}
 
-	if (master->dma_tx && master->dma_rx) {
+	if (host->dma_tx && host->dma_rx) {
 		sspi->dma_addr_tx = mem->start + SUN6I_TXDATA_REG;
 		sspi->dma_addr_rx = mem->start + SUN6I_RXDATA_REG;
-		master->can_dma = sun6i_spi_can_dma;
+		host->can_dma = sun6i_spi_can_dma;
 	}
 
 	/*
@@ -742,9 +742,9 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot register SPI master\n");
+		dev_err(&pdev->dev, "cannot register SPI host\n");
 		goto err_pm_disable;
 	}
 
@@ -754,26 +754,26 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	sun6i_spi_runtime_suspend(&pdev->dev);
 err_free_dma_rx:
-	if (master->dma_rx)
-		dma_release_channel(master->dma_rx);
+	if (host->dma_rx)
+		dma_release_channel(host->dma_rx);
 err_free_dma_tx:
-	if (master->dma_tx)
-		dma_release_channel(master->dma_tx);
-err_free_master:
-	spi_master_put(master);
+	if (host->dma_tx)
+		dma_release_channel(host->dma_tx);
+err_free_host:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void sun6i_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_controller *host = platform_get_drvdata(pdev);
 
 	pm_runtime_force_suspend(&pdev->dev);
 
-	if (master->dma_tx)
-		dma_release_channel(master->dma_tx);
-	if (master->dma_rx)
-		dma_release_channel(master->dma_rx);
+	if (host->dma_tx)
+		dma_release_channel(host->dma_tx);
+	if (host->dma_rx)
+		dma_release_channel(host->dma_rx);
 }
 
 static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
-- 
2.53.0


