Return-Path: <stable+bounces-246978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOm2CEq6BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:52:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02622538597
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7B75301B4DB
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867BE4DC52C;
	Wed, 13 May 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8m5hcZA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D94DBD86
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694299; cv=none; b=p2HvpDVRzUYCY1TWoPtMq1Xk/KW+gNUrNYup/qDRlUdeeJ/X4QsOPQr2Hxvb1LCQug4dd6WRghwpbkFxuvcH9ZQHZqWC/+WGNGNd8rxSvSPPOdNYjx0xXS4I52pnzJns/19orEwMTCQj2FW2pIlSRMUtZQVAfkf6WAnCGqTJoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694299; c=relaxed/simple;
	bh=9QWs+bOlPGPjzPcJfHhqZG27SXQjsYLAttz9e5Vo+v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxuHRVWO4R749PILN6eKTWA7hnyN8q1yH0+p8rI0HuWqqiQxPfF59ol0lSxil7aFtAo7HIS12EAor+lGnk2p+pQYmPomy9hdoMga7wSHhgmu4Kd7vFRBFuy27e3zBTey2hN2HfA7I5bhyuADbEMDYLmQGcaRgqG4Ul0D1NEGR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8m5hcZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C73C2BCB7;
	Wed, 13 May 2026 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778694299;
	bh=9QWs+bOlPGPjzPcJfHhqZG27SXQjsYLAttz9e5Vo+v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8m5hcZAoyU5GJC+hojp2vaDPSzJVJ+0bajxdxyJHNAFSNRBi5aabd0KWhHXtEpns
	 /8cmaAE2aacpxGFnUxFFoV9bom0m2rF7Agd64/G575XgdO18FhFxOHhFoYtWJVZi2B
	 SrllGKdLHLu8k1wBisKYfM24HT6Xpwouo9XL45kk6Z2+0NKub5fWsy/x+LCTVR11B7
	 jNVGEPO2xT/rWwNRztydDXNJvE3u2RJfMXurD89cgnwQ4i98F5/MiSHDsqMp0lQvN0
	 cfRXfnb670kWioCX20s54NOjTUR8iOxWQf3E9mbDl6b3wjEann9hgLGlUQGH5FVNFU
	 gXcm1etlZI8KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] spi: synquacer: switch to use modern name
Date: Wed, 13 May 2026 13:44:54 -0400
Message-ID: <20260513174455.3896307-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513174455.3896307-1-sashal@kernel.org>
References: <2026051241-embezzle-retrial-5eb7@gregkh>
 <20260513174455.3896307-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02622538597
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246978-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 3524d1b727a66712f02f92807219a3650e5cf910 ]

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://msgid.link/r/20231128093031.3707034-10-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 75d849c3452e ("spi: syncuacer: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-synquacer.c | 82 ++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index 3a92f722a6c50..6e366810b34d8 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -225,11 +225,11 @@ static int write_fifo(struct synquacer_spi *sspi)
 	return 0;
 }
 
-static int synquacer_spi_config(struct spi_master *master,
+static int synquacer_spi_config(struct spi_controller *host,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 	unsigned int speed, mode, bpw, cs, bus_width, transfer_mode;
 	u32 rate, val, div;
 
@@ -263,7 +263,7 @@ static int synquacer_spi_config(struct spi_master *master,
 	}
 
 	sspi->transfer_mode = transfer_mode;
-	rate = master->max_speed_hz;
+	rate = host->max_speed_hz;
 
 	div = DIV_ROUND_UP(rate, speed);
 	if (div > 254) {
@@ -350,11 +350,11 @@ static int synquacer_spi_config(struct spi_master *master,
 	return 0;
 }
 
-static int synquacer_spi_transfer_one(struct spi_master *master,
+static int synquacer_spi_transfer_one(struct spi_controller *host,
 				      struct spi_device *spi,
 				      struct spi_transfer *xfer)
 {
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 	int ret;
 	int status = 0;
 	u32 words;
@@ -378,7 +378,7 @@ static int synquacer_spi_transfer_one(struct spi_master *master,
 	if (bpw == 8 && !(xfer->len % 4) && !(spi->mode & SPI_LSB_FIRST))
 		xfer->bits_per_word = 32;
 
-	ret = synquacer_spi_config(master, spi, xfer);
+	ret = synquacer_spi_config(host, spi, xfer);
 
 	/* restore */
 	xfer->bits_per_word = bpw;
@@ -482,7 +482,7 @@ static int synquacer_spi_transfer_one(struct spi_master *master,
 
 static void synquacer_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct synquacer_spi *sspi = spi_master_get_devdata(spi->master);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(spi->controller);
 	u32 val;
 
 	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
@@ -517,11 +517,11 @@ static int synquacer_spi_wait_status_update(struct synquacer_spi *sspi,
 	return -EBUSY;
 }
 
-static int synquacer_spi_enable(struct spi_master *master)
+static int synquacer_spi_enable(struct spi_controller *host)
 {
 	u32 val;
 	int status;
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 
 	/* Disable module */
 	writel(0, sspi->regs + SYNQUACER_HSSPI_REG_MCTRL);
@@ -601,18 +601,18 @@ static irqreturn_t sq_spi_tx_handler(int irq, void *priv)
 static int synquacer_spi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct synquacer_spi *sspi;
 	int ret;
 	int rx_irq, tx_irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*sspi));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	sspi = spi_master_get_devdata(master);
+	sspi = spi_controller_get_devdata(host);
 	sspi->dev = &pdev->dev;
 
 	init_completion(&sspi->transfer_done);
@@ -625,7 +625,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 
 	sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IHCLK; /* Default */
 	device_property_read_u32(&pdev->dev, "socionext,ihclk-rate",
-				 &master->max_speed_hz); /* for ACPI */
+				 &host->max_speed_hz); /* for ACPI */
 
 	if (dev_of_node(&pdev->dev)) {
 		if (device_property_match_string(&pdev->dev,
@@ -655,21 +655,21 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 			goto put_spi;
 		}
 
-		master->max_speed_hz = clk_get_rate(sspi->clk);
+		host->max_speed_hz = clk_get_rate(sspi->clk);
 	}
 
-	if (!master->max_speed_hz) {
+	if (!host->max_speed_hz) {
 		dev_err(&pdev->dev, "missing clock source\n");
 		ret = -EINVAL;
 		goto disable_clk;
 	}
-	master->min_speed_hz = master->max_speed_hz / 254;
+	host->min_speed_hz = host->max_speed_hz / 254;
 
 	sspi->aces = device_property_read_bool(&pdev->dev,
 					       "socionext,set-aces");
 	sspi->rtm = device_property_read_bool(&pdev->dev, "socionext,use-rtm");
 
-	master->num_chipselect = SYNQUACER_HSSPI_NUM_CHIP_SELECT;
+	host->num_chipselect = SYNQUACER_HSSPI_NUM_CHIP_SELECT;
 
 	rx_irq = platform_get_irq(pdev, 0);
 	if (rx_irq <= 0) {
@@ -699,27 +699,27 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	master->dev.of_node = np;
-	master->dev.fwnode = pdev->dev.fwnode;
-	master->auto_runtime_pm = true;
-	master->bus_num = pdev->id;
+	host->dev.of_node = np;
+	host->dev.fwnode = pdev->dev.fwnode;
+	host->auto_runtime_pm = true;
+	host->bus_num = pdev->id;
 
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
-			    SPI_TX_QUAD | SPI_RX_QUAD;
-	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24) |
-				     SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
+			  SPI_TX_QUAD | SPI_RX_QUAD;
+	host->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24) |
+				   SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
 
-	master->set_cs = synquacer_spi_set_cs;
-	master->transfer_one = synquacer_spi_transfer_one;
+	host->set_cs = synquacer_spi_set_cs;
+	host->transfer_one = synquacer_spi_transfer_one;
 
-	ret = synquacer_spi_enable(master);
+	ret = synquacer_spi_enable(host);
 	if (ret)
 		goto disable_clk;
 
 	pm_runtime_set_active(sspi->dev);
 	pm_runtime_enable(sspi->dev);
 
-	ret = devm_spi_register_master(sspi->dev, master);
+	ret = devm_spi_register_controller(sspi->dev, host);
 	if (ret)
 		goto disable_pm;
 
@@ -730,15 +730,15 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 disable_clk:
 	clk_disable_unprepare(sspi->clk);
 put_spi:
-	spi_master_put(master);
+	spi_controller_put(host);
 
 	return ret;
 }
 
 static void synquacer_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 
 	pm_runtime_disable(sspi->dev);
 
@@ -747,11 +747,11 @@ static void synquacer_spi_remove(struct platform_device *pdev)
 
 static int __maybe_unused synquacer_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -763,8 +763,8 @@ static int __maybe_unused synquacer_spi_suspend(struct device *dev)
 
 static int __maybe_unused synquacer_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 	int ret;
 
 	if (!pm_runtime_suspended(dev)) {
@@ -778,7 +778,7 @@ static int __maybe_unused synquacer_spi_resume(struct device *dev)
 			return ret;
 		}
 
-		ret = synquacer_spi_enable(master);
+		ret = synquacer_spi_enable(host);
 		if (ret) {
 			clk_disable_unprepare(sspi->clk);
 			dev_err(dev, "failed to enable spi (%d)\n", ret);
@@ -786,7 +786,7 @@ static int __maybe_unused synquacer_spi_resume(struct device *dev)
 		}
 	}
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret < 0)
 		clk_disable_unprepare(sspi->clk);
 
-- 
2.53.0


