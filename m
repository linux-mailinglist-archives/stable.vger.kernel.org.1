Return-Path: <stable+bounces-247007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB0wG3jCBGp7NgIAu9opvQ
	(envelope-from <stable+bounces-247007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:27:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D651B538EB1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 454DC30E29DF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAFE3A75B6;
	Wed, 13 May 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGTm3xz5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8703A75B0
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696424; cv=none; b=FI9Hlrm/zuZq8o2AKqiO+aHBj9NpGJu0DAnXDVtk9h4JpAPiLj/AfFOiAoc8CtdFAvf3tWCkEy6WjzdxFutbS/NKrdiUVXMrcepLoI974YNdIFILP3JogTn54wiDPaXSj0gU3nN+RIQMqufbzYhwcUm5ugtgKogK9+g+Rrwjwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696424; c=relaxed/simple;
	bh=FacQjR8blqaYsMNQcJ7NJD8DaZzPQm4PR/qs/+0IIhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZNW+LJuST9CAbPH8XFr5dYtf501XlzoFnOcHV0iq1Ga15yghUrvmKeU5zDZesy5InfWFcWrkpBFVgmrHJSfmMEEqF+Zh74FArAXzfB/R2HEDARl/hRevH/EdloMdzspK1g0WIYWsl7GA6ZE7dYlbN7QdaFrLJz7gHl1Jacr9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGTm3xz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EE6C2BCC7;
	Wed, 13 May 2026 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778696423;
	bh=FacQjR8blqaYsMNQcJ7NJD8DaZzPQm4PR/qs/+0IIhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGTm3xz5VihB3lbE8alCEu/LgJTl+4ve+J4OlTkOGhc0XTPQiAgKUP6shuXwTNJpI
	 emnURdn8EqnZmbRF/8zqCm/DSo2jxMbFXnbAZ1b1r6ENtKfO9eQ3Cu5c93gRICXB7x
	 SNb1EIX9JZljIRNzbOYYgzgHqs8oQ/D3wqQvtpWd2/8fq7BlYIfBtWAH6bakxf2ncN
	 8v40M1yDNkGKBmaDYHo8/IVvFTYEkAuCRknW3L/NkeBID39pDnCM22lqQPExvmsHC/
	 ot2n9oPBxChSpE4ZWp3w7EkBuEVsvAXq2VZ0G+0sCPBZKPkpufQLN6WBscTT2vcmC1
	 PsItqGjqxliIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	Michal Simek <michal.simek@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
Date: Wed, 13 May 2026 14:20:20 -0400
Message-ID: <20260513182021.3918405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051203-stonework-judgingly-0a7d@gregkh>
References: <2026051203-stonework-judgingly-0a7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D651B538EB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247007-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,amd.com:email]
X-Rspamd-Action: no action

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit 1f8fd9490e3184e9a2394df2e682901a1d57ce71 ]

Replace devm_clk_get() followed by clk_prepare_enable() with
devm_clk_get_enabled() for both "pclk" and "ref_clk". This removes
the need for explicit clock enable and disable calls, as the managed
API automatically disables the clocks on device removal or probe
failure.

Remove the now-unnecessary clk_disable_unprepare() calls from the
probe error paths and the remove callback. Simplify error handling
by jumping directly to the remove_ctlr label.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Acked-by: Michal Simek <michal.simek@amd.com>
Link: https://patch.msgid.link/24043625f89376da36feca2408f990a85be7ab36.1775555500.git.xiaopei01@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: c9c012706c9f ("spi: zynq-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 42 ++++++-------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index de4c182474329..63acb11c3262b 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -379,21 +379,10 @@ static int zynq_qspi_setup_op(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct zynq_qspi *qspi = spi_controller_get_devdata(ctlr);
-	int ret;
 
 	if (ctlr->busy)
 		return -EBUSY;
 
-	ret = clk_enable(qspi->refclk);
-	if (ret)
-		return ret;
-
-	ret = clk_enable(qspi->pclk);
-	if (ret) {
-		clk_disable(qspi->refclk);
-		return ret;
-	}
-
 	zynq_qspi_write(qspi, ZYNQ_QSPI_ENABLE_OFFSET,
 			ZYNQ_QSPI_ENABLE_ENABLE_MASK);
 
@@ -659,7 +648,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 		goto remove_ctlr;
 	}
 
-	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
+	xqspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
 		ret = PTR_ERR(xqspi->pclk);
@@ -668,36 +657,24 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	init_completion(&xqspi->data_completion);
 
-	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
+	xqspi->refclk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
 	if (IS_ERR(xqspi->refclk)) {
 		dev_err(&pdev->dev, "ref_clk clock not found.\n");
 		ret = PTR_ERR(xqspi->refclk);
 		goto remove_ctlr;
 	}
 
-	ret = clk_prepare_enable(xqspi->pclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
-		goto remove_ctlr;
-	}
-
-	ret = clk_prepare_enable(xqspi->refclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable device clock.\n");
-		goto clk_dis_pclk;
-	}
-
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq < 0) {
 		ret = xqspi->irq;
-		goto clk_dis_all;
+		goto remove_ctlr;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
 			       0, pdev->name, xqspi);
 	if (ret != 0) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "request_irq failed\n");
-		goto clk_dis_all;
+		goto remove_ctlr;
 	}
 
 	ret = of_property_read_u32(np, "num-cs",
@@ -707,7 +684,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	} else if (num_cs > ZYNQ_QSPI_MAX_NUM_CS) {
 		ret = -EINVAL;
 		dev_err(&pdev->dev, "only 2 chip selects are available\n");
-		goto clk_dis_all;
+		goto remove_ctlr;
 	} else {
 		ctlr->num_chipselect = num_cs;
 	}
@@ -725,15 +702,11 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "devm_spi_register_controller failed\n");
-		goto clk_dis_all;
+		goto remove_ctlr;
 	}
 
 	return ret;
 
-clk_dis_all:
-	clk_disable_unprepare(xqspi->refclk);
-clk_dis_pclk:
-	clk_disable_unprepare(xqspi->pclk);
 remove_ctlr:
 	spi_controller_put(ctlr);
 
@@ -755,9 +728,6 @@ static void zynq_qspi_remove(struct platform_device *pdev)
 	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
 
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
-
-	clk_disable_unprepare(xqspi->refclk);
-	clk_disable_unprepare(xqspi->pclk);
 }
 
 static const struct of_device_id zynq_qspi_of_match[] = {
-- 
2.53.0


