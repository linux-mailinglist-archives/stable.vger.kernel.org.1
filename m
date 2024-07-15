Return-Path: <stable+bounces-59262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101C3930C91
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 04:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98111B20DE8
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 02:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680835258;
	Mon, 15 Jul 2024 02:17:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F0C79C4;
	Mon, 15 Jul 2024 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721009873; cv=none; b=LM4iS1snfPoG6fCibn6UOae75305kfMwEWqfc+XcJmbB1E81HKoHjyVv5N7j70GJKAk4Nn75Hi7WC3xb8s7Jqc8GfK7p3KPNx/c0rt8Nsed9s/o4FvNlR9zepGl0FxYEwSZtS3LCuzLgsWi8LkTc+BjpsLWhjzTokRK3Cd83hbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721009873; c=relaxed/simple;
	bh=iXaBQfqBFXm/MkNHoRokVMnXa+C5Nl9SJ7yc68AYvqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oSJRMQVCRk51HygBM9OukrQ/vzCkc8COPkBK7eZ2+ztqaNfAhAPdN0ieJBG2+XQgYUQu2CCzIvazAeCjrVJilJrWSr2wwk5h3NHmC2z/bOlVuoY5gcAFvxtf3lpZMlzi0mZpMsII5FkvpiCeDdlkByklHRWzJ32KD2GYwGIswUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F77A1A038B;
	Mon, 15 Jul 2024 04:12:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 071FB1A04A4;
	Mon, 15 Jul 2024 04:12:24 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0F535180222B;
	Mon, 15 Jul 2024 10:12:21 +0800 (+08)
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
Subject: [PATCH v2 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
Date: Mon, 15 Jul 2024 09:53:55 +0800
Message-Id: <1721008436-24288-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721008436-24288-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721008436-24288-1-git-send-email-hongxing.zhu@nxp.com>
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
index e94c0fdea2260..12d69a6429b6a 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -45,6 +45,10 @@ enum {
 	/* Clock Reset Register */
 	IMX_CLOCK_RESET				= 0x7f3f,
 	IMX_CLOCK_RESET_RESET			= 1 << 0,
+	/* IMX8QM SATA specific control registers */
+	IMX8QM_SATA_AHCI_VEND_PTC		= 0xc8,
+	IMX8QM_SATA_AHCI_VEND_PTC_RXWM_MASK	= 0x7f,
+	IMX8QM_SATA_AHCI_VEND_PTC_NEWRXWM	= 0x29,
 };
 
 enum ahci_imx_type {
@@ -466,6 +470,12 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 	phy_power_off(imxpriv->cali_phy0);
 	phy_exit(imxpriv->cali_phy0);
 
+	/* RxWaterMark setting */
+	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_VEND_PTC);
+	val &= ~IMX8QM_SATA_AHCI_VEND_PTC_RXWM_MASK;
+	val |= IMX8QM_SATA_AHCI_VEND_PTC_NEWRXWM;
+	writel(val, hpriv->mmio + IMX8QM_SATA_AHCI_VEND_PTC);
+
 	return 0;
 
 err_sata_phy_exit:
-- 
2.37.1


