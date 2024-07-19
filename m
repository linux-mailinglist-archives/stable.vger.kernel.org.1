Return-Path: <stable+bounces-60595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB42B9373DA
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A484228643E
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 06:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B047148838;
	Fri, 19 Jul 2024 06:01:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417F37BAE3;
	Fri, 19 Jul 2024 06:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368888; cv=none; b=icEW8XaGkBrxzCK/MzgzBEhP/jdLM/Anq3BSGl7DrVZHj2mRMpDuVHueHrBhh89PtCjkysWUpR0UhE93jsMFDSh8Mxp5a4OhYPcET9SU904LmVz1SCZT4bOp4N+SHMC6sXX28VVX/9X4oYOv7XzM6uayU2SMZhrDQORMNSTFLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368888; c=relaxed/simple;
	bh=B8R0+soTkRLKX7M1hwzeNsFHB8sKJ5BpKxBTvbjHMGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=trKbY2ykIZK8eJ7RVfDLKCVTAPABshffAYa53yyEMmw/SdtktFaGEtu42vgvd9n7tyDTVDXeHu1/8KxEizsPHPd8Miu7SjJ++eL7AV9M31f959k/Oa8JDjlHr5naO2b0Ke2g5NCwlqEJpGLrrGdif1xxM/i7ES+uuPVWcf6iX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E73D5202753;
	Fri, 19 Jul 2024 08:01:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B57662015F8;
	Fri, 19 Jul 2024 08:01:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BD1DA181D0FE;
	Fri, 19 Jul 2024 14:01:16 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: tj@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: linux-ide@vger.kernel.org,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 3/6] ata: ahci_imx: AHB clock rate setting is not required on i.MX8QM AHCI SATA
Date: Fri, 19 Jul 2024 13:42:13 +0800
Message-Id: <1721367736-30156-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

i.MX8QM AHCI SATA doesn't need AHB clock rate to set the vendor
specified TIMER1MS register.
Do the AHB clock rate setting for i.MX53 and i.MX6Q AHCI SATA only.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/ata/ahci_imx.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 75258ed42d2ee..4dd98368f8562 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -872,12 +872,6 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		return PTR_ERR(imxpriv->sata_ref_clk);
 	}
 
-	imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
-	if (IS_ERR(imxpriv->ahb_clk)) {
-		dev_err(dev, "can't get ahb clock.\n");
-		return PTR_ERR(imxpriv->ahb_clk);
-	}
-
 	if (imxpriv->type == AHCI_IMX6Q || imxpriv->type == AHCI_IMX6QP) {
 		u32 reg_value;
 
@@ -937,11 +931,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		goto disable_clk;
 
 	/*
-	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
-	 * and IP vendor specific register IMX_TIMER1MS.
-	 * Configure CAP_SSS (support stagered spin up).
-	 * Implement the port0.
-	 * Get the ahb clock rate, and configure the TIMER1MS register.
+	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL.
+	 * Set CAP_SSS (support stagered spin up) and Implement the port0.
 	 */
 	reg_val = readl(hpriv->mmio + HOST_CAP);
 	if (!(reg_val & HOST_CAP_SSS)) {
@@ -954,8 +945,19 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		writel(reg_val, hpriv->mmio + HOST_PORTS_IMPL);
 	}
 
-	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
-	writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
+	if (imxpriv->type != AHCI_IMX8QM) {
+		/*
+		 * Get AHB clock rate and configure the vendor specified
+		 * TIMER1MS register on i.MX53, i.MX6Q and i.MX6QP only.
+		 */
+		imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
+		if (IS_ERR(imxpriv->ahb_clk)) {
+			dev_err(dev, "Failed to get ahb clock\n");
+			goto disable_sata;
+		}
+		reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
+		writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
+	}
 
 	ret = ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info,
 				      &ahci_platform_sht);
-- 
2.37.1


