Return-Path: <stable+bounces-101469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A219EECA3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC7E1884A94
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1720D215777;
	Thu, 12 Dec 2024 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SseH0ulp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86DE217670;
	Thu, 12 Dec 2024 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017661; cv=none; b=FIjs2ZMMRRgSFQzgi0fXPmuk5mS7ksZFim9Egkrui2EzUEF8WXoTn8W1RhPPq1tgIHDpu0VaSLjtuvk92fii2fmdQKtOxHgZ50r3YKGIpOWwKoSIbVRHwUzRwjH92rUC8sHNcJmsCYdDPL9XXh0972txrJFx7MKUvvW6VZTICOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017661; c=relaxed/simple;
	bh=NIRMlwkb6yruWEuK9p/P2Wg1+dFIjz6cYpQretMHEzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYjpN0KlttCy5LHjqWsH0W8nI39Govt5jwkRzKpXzTJx51IuKsd4CAUjkdSbgAELuXXsvFsrup166wi9agspadS+4Jn0ZVgCpCiZdBqUuahJ3LbeUaDEdxr45nOUNJlScs+JKRBdKLpDua5lUJCaixat4E97hnVhdO8jzePEO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SseH0ulp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CBEC4CECE;
	Thu, 12 Dec 2024 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017661;
	bh=NIRMlwkb6yruWEuK9p/P2Wg1+dFIjz6cYpQretMHEzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SseH0ulpTLaxAiFP5pCAZi2Gt+8aTWhgzUreVTxvEw2Hlee5Nl5NBSCo1r2HLu5IB
	 xIUZYZSjNbKFOex4jpIT+XF92+ArT+54rZHrJIaD9MsXyyesUIagZ+ZA+9yxarNoG/
	 2SO9D0vSX3VWKXRnIUipljoY50aXwMpcxe3TBMi0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 076/356] soc: fsl: cpm1: qmc: Re-order probe() operations
Date: Thu, 12 Dec 2024 15:56:35 +0100
Message-ID: <20241212144247.628640653@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

From: Herve Codina <herve.codina@bootlin.com>

[ Upstream commit a13bf605342ea9df492b8159cadaa41862b53e15 ]

Current code handles CPM1 version of QMC. In the QUICC Engine (QE)
version, some operations done at probe() need to be done in a different
order.

In order to prepare the support for the QE version, changed the sequence
of operation done at probe():
- Retrieve the tsa_serial earlier, before initializing resources.
- Group SCC initialisation and do this initialization when it is really
  needed in the probe() sequence.

Having the QE compatible sequence in the CPM1 version does not lead to
any issue and works correctly without any regressions.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/r/20240808071132.149251-26-herve.codina@bootlin.com
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Stable-dep-of: cb3daa51db81 ("soc: fsl: cpm1: qmc: Set the ret error code on platform_get_irq() failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qe/qmc.c | 54 +++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index f22d1d85d1021..a5c9cbb99600e 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1281,6 +1281,12 @@ static int qmc_probe(struct platform_device *pdev)
 	qmc->dev = &pdev->dev;
 	INIT_LIST_HEAD(&qmc->chan_head);
 
+	qmc->tsa_serial = devm_tsa_serial_get_byphandle(qmc->dev, np, "fsl,tsa-serial");
+	if (IS_ERR(qmc->tsa_serial)) {
+		return dev_err_probe(qmc->dev, PTR_ERR(qmc->tsa_serial),
+				     "Failed to get TSA serial\n");
+	}
+
 	qmc->scc_regs = devm_platform_ioremap_resource_byname(pdev, "scc_regs");
 	if (IS_ERR(qmc->scc_regs))
 		return PTR_ERR(qmc->scc_regs);
@@ -1297,33 +1303,13 @@ static int qmc_probe(struct platform_device *pdev)
 	if (IS_ERR(qmc->dpram))
 		return PTR_ERR(qmc->dpram);
 
-	qmc->tsa_serial = devm_tsa_serial_get_byphandle(qmc->dev, np, "fsl,tsa-serial");
-	if (IS_ERR(qmc->tsa_serial)) {
-		return dev_err_probe(qmc->dev, PTR_ERR(qmc->tsa_serial),
-				     "Failed to get TSA serial\n");
-	}
-
-	/* Connect the serial (SCC) to TSA */
-	ret = tsa_serial_connect(qmc->tsa_serial);
-	if (ret) {
-		dev_err(qmc->dev, "Failed to connect TSA serial\n");
-		return ret;
-	}
-
 	/* Parse channels informationss */
 	ret = qmc_of_parse_chans(qmc, np);
 	if (ret)
-		goto err_tsa_serial_disconnect;
+		return ret;
 
 	nb_chans = qmc_nb_chans(qmc);
 
-	/* Init GMSR_H and GMSR_L registers */
-	qmc_write32(qmc->scc_regs + SCC_GSMRH,
-		    SCC_GSMRH_CDS | SCC_GSMRH_CTSS | SCC_GSMRH_CDP | SCC_GSMRH_CTSP);
-
-	/* enable QMC mode */
-	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
-
 	/*
 	 * Allocate the buffer descriptor table
 	 * 8 rx and 8 tx descriptors per channel
@@ -1333,8 +1319,7 @@ static int qmc_probe(struct platform_device *pdev)
 					    &qmc->bd_dma_addr, GFP_KERNEL);
 	if (!qmc->bd_table) {
 		dev_err(qmc->dev, "Failed to allocate bd table\n");
-		ret = -ENOMEM;
-		goto err_tsa_serial_disconnect;
+		return -ENOMEM;
 	}
 	memset(qmc->bd_table, 0, qmc->bd_size);
 
@@ -1346,8 +1331,7 @@ static int qmc_probe(struct platform_device *pdev)
 					     &qmc->int_dma_addr, GFP_KERNEL);
 	if (!qmc->int_table) {
 		dev_err(qmc->dev, "Failed to allocate interrupt table\n");
-		ret = -ENOMEM;
-		goto err_tsa_serial_disconnect;
+		return -ENOMEM;
 	}
 	memset(qmc->int_table, 0, qmc->int_size);
 
@@ -1366,18 +1350,32 @@ static int qmc_probe(struct platform_device *pdev)
 
 	ret = qmc_setup_tsa(qmc);
 	if (ret)
-		goto err_tsa_serial_disconnect;
+		return ret;
 
 	qmc_write16(qmc->scc_pram + QMC_GBL_QMCSTATE, 0x8000);
 
 	ret = qmc_setup_chans(qmc);
 	if (ret)
-		goto err_tsa_serial_disconnect;
+		return ret;
 
 	/* Init interrupts table */
 	ret = qmc_setup_ints(qmc);
 	if (ret)
-		goto err_tsa_serial_disconnect;
+		return ret;
+
+	/* Connect the serial (SCC) to TSA */
+	ret = tsa_serial_connect(qmc->tsa_serial);
+	if (ret) {
+		dev_err(qmc->dev, "Failed to connect TSA serial\n");
+		return ret;
+	}
+
+	/* Init GMSR_H and GMSR_L registers */
+	qmc_write32(qmc->scc_regs + SCC_GSMRH,
+		    SCC_GSMRH_CDS | SCC_GSMRH_CTSS | SCC_GSMRH_CDP | SCC_GSMRH_CTSP);
+
+	/* enable QMC mode */
+	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
 
 	/* Disable and clear interrupts,  set the irq handler */
 	qmc_write16(qmc->scc_regs + SCC_SCCM, 0x0000);
-- 
2.43.0




