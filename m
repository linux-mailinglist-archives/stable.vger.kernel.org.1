Return-Path: <stable+bounces-59388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A2931F5B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 05:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC2C1C20F05
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 03:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBB822309;
	Tue, 16 Jul 2024 03:36:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804A1CD20;
	Tue, 16 Jul 2024 03:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101015; cv=none; b=A8CH473MJA5TDRDZd8/SNFq2NSE4IDH4kjgoOp31VPD7WW2cLSfWnyJ8aDoI/yZNiNpZtGluwl3afab10Rrg0N06/pHWAtBjDowx2oECButljtm/uslqHD+AnSOF3uBiC5UCvjwHqYjMv4NeWAp4U2tN6e/YUWL+jw/gAbaAvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101015; c=relaxed/simple;
	bh=bYwq/hwbR1HNMotgXIXk+TkyIZMEspylxapDOYGDZ0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hrdNWB0Y3v8FoF6I/91rACGtjF0Ct5h/E/KS+HZr8xt34uyyHIC4zLYXiAUPvbx/XYLRBs4pCZV7ihXxpcYysbUj0TjRFj8VVqWrguAFolSwuJTQ1vtJu/gx9W5uEMRvqBndubNq79JOIiPeZSI68jqN1/u2SMvpctCh65rt7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EAE222009AE;
	Tue, 16 Jul 2024 05:36:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B14F02001D5;
	Tue, 16 Jul 2024 05:36:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B93D6183487B;
	Tue, 16 Jul 2024 11:36:44 +0800 (+08)
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
Subject: [PATCH v3 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
Date: Tue, 16 Jul 2024 11:18:14 +0800
Message-Id: <1721099895-26098-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721099895-26098-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721099895-26098-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The RXWM(RxWaterMark) sets the minimum number of free location within
the RX FIFO before the watermark is exceeded which in turn will cause
the Transport Layer to instruct the Link Layer to transmit HOLDS to
the transmitting end.

Based on the default RXWM value 0x20, RX FIFO overflow might be
observed on i.MX8QM MEK board, when some Gen3 SATA disks are used.

The FIFO overflow will result in CRC error, internal error and protocol
error, then the SATA link is not stable anymore.

To fix this issue, enlarge RX water mark setting from 0x20 to 0x29.

Fixes: 027fa4dee935 ("ahci: imx: add the imx8qm ahci sata support")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/ata/ahci_imx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index e94c0fdea2260..b6ad0fe5fbbcc 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -45,6 +45,10 @@ enum {
 	/* Clock Reset Register */
 	IMX_CLOCK_RESET				= 0x7f3f,
 	IMX_CLOCK_RESET_RESET			= 1 << 0,
+	/* IMX8QM SATA specific control registers */
+	IMX8QM_SATA_AHCI_PTC			= 0xc8,
+	IMX8QM_SATA_AHCI_PTC_RXWM_MASK		= GENMASK(6, 0),
+	IMX8QM_SATA_AHCI_PTC_RXWM		= 0x29,
 };
 
 enum ahci_imx_type {
@@ -466,6 +470,12 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 	phy_power_off(imxpriv->cali_phy0);
 	phy_exit(imxpriv->cali_phy0);
 
+	/* RxWaterMark setting */
+	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
+	val &= ~IMX8QM_SATA_AHCI_PTC_RXWM_MASK;
+	val |= IMX8QM_SATA_AHCI_PTC_RXWM;
+	writel(val, hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
+
 	return 0;
 
 err_sata_phy_exit:
-- 
2.37.1


