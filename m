Return-Path: <stable+bounces-249910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHqVN8awDWpy1gUAu9opvQ
	(envelope-from <stable+bounces-249910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:01:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DAC58E676
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27C5D301466E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBEA3C1413;
	Wed, 20 May 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbhD5j1y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EEF3A9D83
	for <stable@vger.kernel.org>; Wed, 20 May 2026 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281753; cv=none; b=BGfW3wyn/YUSZToiXelUj2i5Wv7KWgAbUuj7SpSJkacc/XY/boqp98SbV9G4z5bVLRDHaeWCK0IHGBt4dPpy1saN502AXkg9Kl10VNdob1cb87xG3OxfYXCOrZD8BxnVPxRYnriRkwr9Qjc+79mPn/1CWVxLOUz8dSK4gmsIRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281753; c=relaxed/simple;
	bh=ErmgRQOi7rJ9hPS3pcO52D9/SybkiqANFmHZhx2Gjp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5cN0BEBEvF3zYGDI2R1VWL1wtDpSQxa55aWnfCuov3ECF9eHiUF+V5RuT4qrl+aryGIbqJHJ9QGNdJd6TJ7X/MlIFtfwPC+Uwqj7al9Mj49m5dysliEJgfirNJP1Q6xpVCSKdwjIComsj8d3mhv5RIxJvcBRoRJ1uxrCw5/Wog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbhD5j1y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AD71F000E9;
	Wed, 20 May 2026 12:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281751;
	bh=5WcBcKzQTH+/WlAsEBWy57fN+FfCg3XTF6JIIMtjRWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fbhD5j1y3hSjrpfyLobj3SiSMXbf7kRBKQQxjW96DFBK7kFegdsIoZrpqj+jDRpBC
	 4EkBP+AzXurEexuUX5rWYKC2KrUvPwt7gOo3rpHIg5uJUF1NSV5YWR59Ek/qjDd4RY
	 e0vhNkl0FdhLETQIDnMd83Z9mlSwJZ5RXOdDrnDaTWfaOjvX9wWKJRYtXiwEgXEmZ2
	 IquH8eG64zpZf35uiTsMYrYWmapN4Fu1ksHfLM3jMxjHz63bBqC/8BeT0oG4z2nBCh
	 V1gWuW1ctT5vGHkD8N7mZvC3iSWZ77IcX9zj4V5D2rsns8YB9+ewb+XzZQh+mXNaaz
	 qTpZH2/Y0Yd9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] spi: st-ssc4: switch to use modern name
Date: Wed, 20 May 2026 08:55:47 -0400
Message-ID: <20260520125548.3536474-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051546-fable-equator-195c@gregkh>
References: <2026051546-fable-equator-195c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249910-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[st.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email,huawei.com:email,msgid.link:url]
X-Rspamd-Queue-Id: B0DAC58E676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit e6b7e64cb11966b26646a362677ca5a08481157e ]

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://msgid.link/r/20231128093031.3707034-4-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 19857374010d ("spi: st-ssc4: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-st-ssc4.c | 70 +++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 7fcff9c539e23..e064025e2fd6d 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -6,7 +6,7 @@
  *          Patrice Chotard <patrice.chotard@st.com>
  *          Lee Jones <lee.jones@linaro.org>
  *
- *  SPI master mode controller driver, used in STMicroelectronics devices.
+ *  SPI host mode controller driver, used in STMicroelectronics devices.
  */
 
 #include <linux/clk.h>
@@ -115,10 +115,10 @@ static void ssc_read_rx_fifo(struct spi_st *spi_st)
 	spi_st->words_remaining -= count;
 }
 
-static int spi_st_transfer_one(struct spi_master *master,
+static int spi_st_transfer_one(struct spi_controller *host,
 			       struct spi_device *spi, struct spi_transfer *t)
 {
-	struct spi_st *spi_st = spi_master_get_devdata(master);
+	struct spi_st *spi_st = spi_controller_get_devdata(host);
 	uint32_t ctl = 0;
 
 	/* Setup transfer */
@@ -165,7 +165,7 @@ static int spi_st_transfer_one(struct spi_master *master,
 	if (ctl)
 		writel_relaxed(ctl, spi_st->base + SSC_CTL);
 
-	spi_finalize_current_transfer(spi->master);
+	spi_finalize_current_transfer(spi->controller);
 
 	return t->len;
 }
@@ -174,7 +174,7 @@ static int spi_st_transfer_one(struct spi_master *master,
 #define MODEBITS  (SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_LOOP | SPI_CS_HIGH)
 static int spi_st_setup(struct spi_device *spi)
 {
-	struct spi_st *spi_st = spi_master_get_devdata(spi->master);
+	struct spi_st *spi_st = spi_controller_get_devdata(spi->controller);
 	u32 spi_st_clk, sscbrg, var;
 	u32 hz = spi->max_speed_hz;
 
@@ -274,35 +274,35 @@ static irqreturn_t spi_st_irq(int irq, void *dev_id)
 static int spi_st_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct spi_st *spi_st;
 	int irq, ret = 0;
 	u32 var;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spi_st));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*spi_st));
+	if (!host)
 		return -ENOMEM;
 
-	master->dev.of_node		= np;
-	master->mode_bits		= MODEBITS;
-	master->setup			= spi_st_setup;
-	master->transfer_one		= spi_st_transfer_one;
-	master->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
-	master->auto_runtime_pm		= true;
-	master->bus_num			= pdev->id;
-	master->use_gpio_descriptors	= true;
-	spi_st				= spi_master_get_devdata(master);
+	host->dev.of_node		= np;
+	host->mode_bits			= MODEBITS;
+	host->setup			= spi_st_setup;
+	host->transfer_one		= spi_st_transfer_one;
+	host->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	host->auto_runtime_pm		= true;
+	host->bus_num			= pdev->id;
+	host->use_gpio_descriptors	= true;
+	spi_st				= spi_controller_get_devdata(host);
 
 	spi_st->clk = devm_clk_get(&pdev->dev, "ssc");
 	if (IS_ERR(spi_st->clk)) {
 		dev_err(&pdev->dev, "Unable to request clock\n");
 		ret = PTR_ERR(spi_st->clk);
-		goto put_master;
+		goto put_host;
 	}
 
 	ret = clk_prepare_enable(spi_st->clk);
 	if (ret)
-		goto put_master;
+		goto put_host;
 
 	init_completion(&spi_st->done);
 
@@ -324,7 +324,7 @@ static int spi_st_probe(struct platform_device *pdev)
 	var &= ~SSC_CTL_SR;
 	writel_relaxed(var, spi_st->base + SSC_CTL);
 
-	/* Set SSC into slave mode before reconfiguring PIO pins */
+	/* Set SSC into target mode before reconfiguring PIO pins */
 	var = readl_relaxed(spi_st->base + SSC_CTL);
 	var &= ~SSC_CTL_MS;
 	writel_relaxed(var, spi_st->base + SSC_CTL);
@@ -347,11 +347,11 @@ static int spi_st_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register master\n");
+		dev_err(&pdev->dev, "Failed to register host\n");
 		goto rpm_disable;
 	}
 
@@ -361,15 +361,15 @@ static int spi_st_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 clk_disable:
 	clk_disable_unprepare(spi_st->clk);
-put_master:
-	spi_master_put(master);
+put_host:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void spi_st_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct spi_st *spi_st = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct spi_st *spi_st = spi_controller_get_devdata(host);
 
 	pm_runtime_disable(&pdev->dev);
 
@@ -381,8 +381,8 @@ static void spi_st_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int spi_st_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct spi_st *spi_st = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct spi_st *spi_st = spi_controller_get_devdata(host);
 
 	writel_relaxed(0, spi_st->base + SSC_IEN);
 	pinctrl_pm_select_sleep_state(dev);
@@ -394,8 +394,8 @@ static int spi_st_runtime_suspend(struct device *dev)
 
 static int spi_st_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct spi_st *spi_st = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct spi_st *spi_st = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(spi_st->clk);
@@ -408,10 +408,10 @@ static int spi_st_runtime_resume(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int spi_st_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -420,10 +420,10 @@ static int spi_st_suspend(struct device *dev)
 
 static int spi_st_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret)
 		return ret;
 
-- 
2.53.0


