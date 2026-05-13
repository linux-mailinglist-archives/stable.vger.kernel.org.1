Return-Path: <stable+bounces-247013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM+BLcHFBGrdNwIAu9opvQ
	(envelope-from <stable+bounces-247013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:41:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A02A539235
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA023016EE1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2F3A2E07;
	Wed, 13 May 2026 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyna+DZ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CAA3F4138
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697231; cv=none; b=Yz9d6ogrYzlYpOcoJyCUTLizEZXzuqJp5C88rv0BwD+JM8bXGRCV8/cH04f+LkWBuA8+XXED/Sc9alBWadGs30R8Qxdld7oHjNDhQcgFEvb5ZsuXJLisjRS/KM9Yfys2jWfTQPHkipxAOzK+wRbo4Vl/ryHSllY7j4u4xjCCllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697231; c=relaxed/simple;
	bh=YYk/XDkEOANKLAbKu7UE/bMjrya0ysxxLqrh62+R0qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbQIlk5klxGV4rDgtTPerj5dTsFgrsWFG1SKW2YXAMpbkA+BeOiHMoiH784Vx/9ZR2wmKDpWKjnyVTTy5TK532H2i67eyB9Q/XiAC+dhj8MgYCMXkKKHMcVzxq9lCkF0nFjsvDn2divneHLYC3EHd9cejrpVsCU7RRPwI/rxn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyna+DZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926EFC19425;
	Wed, 13 May 2026 18:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778697231;
	bh=YYk/XDkEOANKLAbKu7UE/bMjrya0ysxxLqrh62+R0qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kyna+DZ30TwqEH4b4DEZCtqW7vflrmp3HXQqJWuMbE1YOuiUVT/E+iVuPvWhrtZA0
	 96G/sta0MmrSl2s+N6w47rjviTw8VC89NVIERvs2ezlmjw44pRMc3gacRV3KgzLt2D
	 owZ06soB6paR38Bmahw99bdFI+spX0LiHtWOJMhUvKheUKSoF/vA4YSpfkT48teMhH
	 fHM8YYnDAuMXLO4d3VmxKiLpPnSSDSjaioHm31Y4YCAi9Dtvtq//fcjICVisdIhDbA
	 ws8z0hYfKkNqVZrkk9+ts5Umhm08JRWkGZP+Ss56Ej3WGNytTs8ac8d3pGSQWbmoQY
	 2+2ySUZ9xO91A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] spi: zynq-qspi: switch to use modern name
Date: Wed, 13 May 2026 14:33:46 -0400
Message-ID: <20260513183348.3927281-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051203-dealmaker-flounder-0204@gregkh>
References: <2026051203-dealmaker-flounder-0204@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A02A539235
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247013-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,msgid.link:url]
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
index 9358c75a30f44..8959eb9f2032e 100644
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


