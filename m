Return-Path: <stable+bounces-247026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIWPIUrSBGr0PQIAu9opvQ
	(envelope-from <stable+bounces-247026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:34:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B09453A04F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C55D23040C91
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513513B777B;
	Wed, 13 May 2026 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhdElovf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD823B6C03
	for <stable@vger.kernel.org>; Wed, 13 May 2026 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700865; cv=none; b=Y2wTE2APPeu+dnKK5njZF4qeCk1PvdFpXiPQYX3Lpbu2ZZsjREvkms80v1w3jPozs9i9bsZ9sgkOyPnmpmH028HYQHmASVg1ZW2TGBf2RgwRfnJMempvhxSo57RLYeCjYxKZpYmODAqEhSrfL7jMpTMh2ssk41FGFBhtsMCZNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700865; c=relaxed/simple;
	bh=xRAEaNWnBUdOD7kpqIDp5YbWJNJnFnJQTp5Lbh0sTeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGbWYRhbIHdyiefgrUgT4wdCEm02FXGBGVAu+hHkzo9q4KgKAJUxvCG0zQujIoMSWtKSFh92uTWZjq8SXkSRKrBgwhyESjLpNBOJkNc0Vi1aVVVnMJz/T1Ek4AmuQDYtoPWf6oBVV9Wt1Fprw1EmFDKelT314L6UncXOserWbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhdElovf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDCFC19425;
	Wed, 13 May 2026 19:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778700864;
	bh=xRAEaNWnBUdOD7kpqIDp5YbWJNJnFnJQTp5Lbh0sTeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhdElovfUwReKtWR1aPGrsA8NRBy5OvpAv11v72v+X22gb33ddCdqKaf4fccup2om
	 HYfVeQH/6btTwvowpzyld/F2EHHZW6YKcxYd6ECZDmv8L0jRtr0IFY4zPPimDVv3zH
	 60KKkY2vrqHkz1rny4E54KW1FS5b9IvgczNPe+8b+aQRiGseeJWTYRzyQ68L+lWp9j
	 VkpVFC6eyA6zzI3IDoOpsXV3X/WhFmqHhaa4ps0gjEatpEDC5GL2Rak0+aJMPMN4Lz
	 Iy8qJgBsUgYpXuqFQ3OuyP6ymsD58UpL3OVAfTxYuybaIctTs3KzDvQmZbJ2rwAnVZ
	 GosVeTTSXZ0PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] spi: zynq-qspi: switch to use modern name
Date: Wed, 13 May 2026 15:34:18 -0400
Message-ID: <20260513193420.3938432-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513193420.3938432-1-sashal@kernel.org>
References: <2026051203-regain-crablike-8461@gregkh>
 <20260513193420.3938432-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B09453A04F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247026-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Action: no action

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 178ebb0c505b0a35edb4fb2a0e23a1f29e1db14d ]

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://msgid.link/r/20231128093031.3707034-24-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: c9c012706c9f ("spi: zynq-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 3cc2b0cb14f61..c933254e6d319 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -54,10 +54,10 @@
 #define ZYNQ_QSPI_CONFIG_MSTREN_MASK	BIT(0) /* Master Mode */
 
 /*
- * QSPI Configuration Register - Baud rate and slave select
+ * QSPI Configuration Register - Baud rate and target select
  *
  * These are the values used in the calculation of baud rate divisor and
- * setting the slave select.
+ * setting the target select.
  */
 #define ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX	GENMASK(2, 0) /* Baud rate maximum */
 #define ZYNQ_QSPI_CONFIG_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift */
@@ -164,14 +164,14 @@ static inline void zynq_qspi_write(struct zynq_qspi *xqspi, u32 offset,
  *
  * The default settings of the QSPI controller's configurable parameters on
  * reset are
- *	- Master mode
+ *	- Host mode
  *	- Baud rate divisor is set to 2
  *	- Tx threshold set to 1l Rx threshold set to 32
  *	- Flash memory interface mode enabled
  *	- Size of the word to be transferred as 8 bit
  * This function performs the following actions
  *	- Disable and clear all the interrupts
- *	- Enable manual slave select
+ *	- Enable manual target select
  *	- Enable manual start
  *	- Deselect all the chip select lines
  *	- Set the size of the word to be transferred as 32 bit
@@ -289,7 +289,7 @@ static void zynq_qspi_txfifo_op(struct zynq_qspi *xqspi, unsigned int size)
  */
 static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 {
-	struct spi_controller *ctlr = spi->master;
+	struct spi_controller *ctlr = spi->controller;
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
 	u32 config_reg;
 
@@ -377,7 +377,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
  */
 static int zynq_qspi_setup_op(struct spi_device *spi)
 {
-	struct spi_controller *ctlr = spi->master;
+	struct spi_controller *ctlr = spi->controller;
 	struct zynq_qspi *qspi = spi_controller_get_devdata(ctlr);
 	int ret;
 
@@ -534,7 +534,7 @@ static irqreturn_t zynq_qspi_irq(int irq, void *dev_id)
 static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->master);
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->controller);
 	int err = 0, i;
 	u8 *tmpbuf;
 
@@ -646,7 +646,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	struct zynq_qspi *xqspi;
 	u32 num_cs;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
+	ctlr = spi_alloc_host(&pdev->dev, sizeof(*xqspi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -656,14 +656,14 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
 		ret = PTR_ERR(xqspi->pclk);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	init_completion(&xqspi->data_completion);
@@ -672,13 +672,13 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	if (IS_ERR(xqspi->refclk)) {
 		dev_err(&pdev->dev, "ref_clk clock not found.\n");
 		ret = PTR_ERR(xqspi->refclk);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	ret = clk_prepare_enable(xqspi->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	ret = clk_prepare_enable(xqspi->refclk);
@@ -724,7 +724,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
-		dev_err(&pdev->dev, "spi_register_master failed\n");
+		dev_err(&pdev->dev, "devm_spi_register_controller failed\n");
 		goto clk_dis_all;
 	}
 
@@ -734,7 +734,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
-remove_master:
+remove_ctlr:
 	spi_controller_put(ctlr);
 
 	return ret;
-- 
2.53.0


