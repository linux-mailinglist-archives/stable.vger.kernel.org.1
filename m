Return-Path: <stable+bounces-246981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN5lBKS4BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:45:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DDA5383EB
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 182BC300B448
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC04DC540;
	Wed, 13 May 2026 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn5Q8tc1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0C37DAD4
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694304; cv=none; b=OfjCq6aF8jatQn105PH9hCSSzFKrHngvibBawQHvvrnmcSSuXmr9WfbYh2ywJANu1k7uuwwOWXZnF6D2NP3QKa8QL1+nbUmiYP+mJPoIZEvy9mJc/DuQLn1NkFIv2U+r5p+PNGDICA8Gv3CReQWo14VaWal1u4A0NAXOdWGKavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694304; c=relaxed/simple;
	bh=DHF/nLNSYxpaccWNCMH1XQrIFJMNqNe9PxxTqGgWvqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq9gUV/g5l35+WxK6t05zW8b0N/UwuFQAIc6xTiXiYPBIL9r9TriN5/wOgmEkhGoVDzgIYQtDwiIaFBtsFIYzQP6l5gej/UzyYoAFOZULYgmpKdhKopCeUTQ3cWFfBdtPy8wMlZ1tsjDiBtzc/rueXXEzYnnWB4Bam+oB4TiSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn5Q8tc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08E8C2BCB7;
	Wed, 13 May 2026 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778694304;
	bh=DHF/nLNSYxpaccWNCMH1XQrIFJMNqNe9PxxTqGgWvqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tn5Q8tc1Y4MV0algc418cXS7SnA39Mbr322J279VnuIf3fjmkIq9qDKwrqc20/2tZ
	 x1Ay6KtTURA2GQqGFc77/WMRsrZVkpV4bw0jQY0hsphpmPGLurGbE4bIVbfsT6aNlW
	 tnpssUeVvpSSlCdBi2UsNtYY3D3TROz8jZ2uzQG9jA/5mrzuEGYbEe4zG7szoiV1CB
	 6TFDmHdf1mbZ2OAMvcUcXlvFNjaZg4OXf0llxHBRUG+AguYJ3s8whmfK9tlonvQDdU
	 348c6K1Ej+UQUfl+JI/0eLkHeK/O2IhA9hFlEAyKuvdmWR/ymxEOnDtlPYazPUBP99
	 zvMRwTaOty9Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] spi: sun4i: switch to use modern name
Date: Wed, 13 May 2026 13:45:00 -0400
Message-ID: <20260513174501.3896424-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513174501.3896424-1-sashal@kernel.org>
References: <2026051252-unproven-faculty-80e7@gregkh>
 <20260513174501.3896424-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A3DDA5383EB
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
	TAGGED_FROM(0.00)[bounces-246981-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Action: no action

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 6d232cc8a7e59af0c083319827541966a68817a0 ]

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://msgid.link/r/20231128093031.3707034-7-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 42108a2f03e0 ("spi: sun4i: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun4i.c | 72 ++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index b7ce4ff91193d..b1afd5e100451 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -75,7 +75,7 @@
 #define SUN4I_FIFO_STA_TF_CNT_BITS		16
 
 struct sun4i_spi {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	void __iomem		*base_addr;
 	struct clk		*hclk;
 	struct clk		*mclk;
@@ -161,7 +161,7 @@ static inline void sun4i_spi_fill_fifo(struct sun4i_spi *sspi, int len)
 
 static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct sun4i_spi *sspi = spi_master_get_devdata(spi->master);
+	struct sun4i_spi *sspi = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
@@ -201,11 +201,11 @@ static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
 	return SUN4I_MAX_XFER_SIZE - 1;
 }
 
-static int sun4i_spi_transfer_one(struct spi_master *master,
+static int sun4i_spi_transfer_one(struct spi_controller *host,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
 {
-	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	struct sun4i_spi *sspi = spi_controller_get_devdata(host);
 	unsigned int mclk_rate, div, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
@@ -334,7 +334,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 					      msecs_to_jiffies(tx_time));
 	end = jiffies;
 	if (!timeout) {
-		dev_warn(&master->dev,
+		dev_warn(&host->dev,
 			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
 			 jiffies_to_msecs(end - start), tx_time);
@@ -389,8 +389,8 @@ static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 
 static int sun4i_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct sun4i_spi *sspi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(sspi->hclk);
@@ -418,8 +418,8 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 
 static int sun4i_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct sun4i_spi *sspi = spi_controller_get_devdata(host);
 
 	clk_disable_unprepare(sspi->mclk);
 	clk_disable_unprepare(sspi->hclk);
@@ -429,62 +429,62 @@ static int sun4i_spi_runtime_suspend(struct device *dev)
 
 static int sun4i_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct sun4i_spi *sspi;
 	int ret = 0, irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sun4i_spi));
-	if (!master) {
-		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(struct sun4i_spi));
+	if (!host) {
+		dev_err(&pdev->dev, "Unable to allocate SPI Host\n");
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(pdev, master);
-	sspi = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, host);
+	sspi = spi_controller_get_devdata(host);
 
 	sspi->base_addr = devm_platform_ioremap_resource(pdev, 0);
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
 
 	ret = devm_request_irq(&pdev->dev, irq, sun4i_spi_handler,
 			       0, "sun4i-spi", sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
-		goto err_free_master;
+		goto err_free_host;
 	}
 
-	sspi->master = master;
-	master->max_speed_hz = 100 * 1000 * 1000;
-	master->min_speed_hz = 3 * 1000;
-	master->set_cs = sun4i_spi_set_cs;
-	master->transfer_one = sun4i_spi_transfer_one;
-	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->dev.of_node = pdev->dev.of_node;
-	master->auto_runtime_pm = true;
-	master->max_transfer_size = sun4i_spi_max_transfer_size;
+	sspi->host = host;
+	host->max_speed_hz = 100 * 1000 * 1000;
+	host->min_speed_hz = 3 * 1000;
+	host->set_cs = sun4i_spi_set_cs;
+	host->transfer_one = sun4i_spi_transfer_one;
+	host->num_chipselect = 4;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->dev.of_node = pdev->dev.of_node;
+	host->auto_runtime_pm = true;
+	host->max_transfer_size = sun4i_spi_max_transfer_size;
 
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
@@ -496,16 +496,16 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	ret = sun4i_spi_runtime_resume(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't resume the device\n");
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot register SPI master\n");
+		dev_err(&pdev->dev, "cannot register SPI host\n");
 		goto err_pm_disable;
 	}
 
@@ -514,8 +514,8 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	sun4i_spi_runtime_suspend(&pdev->dev);
-err_free_master:
-	spi_master_put(master);
+err_free_host:
+	spi_controller_put(host);
 	return ret;
 }
 
-- 
2.53.0


