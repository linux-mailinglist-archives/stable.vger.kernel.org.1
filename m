Return-Path: <stable+bounces-60596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB4D9373DF
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 08:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C79D1C23837
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B30C14901A;
	Fri, 19 Jul 2024 06:01:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33028148850;
	Fri, 19 Jul 2024 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368891; cv=none; b=IGx2A24fvK8iCbl+XCWN4Tk3Tw7VdTQath7164zzetMdS/5sdCKltPgsOE2KUJNDKudwCl3h9zchPRF1UtsqXWcZUxn6CdVZUGS6ZaFzOB+08EVi+r9Vxz5tsYDbrHQcFQtykV+WEwv5mgjiiJm8c0+U5dbJB4kxHEAOlS49l3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368891; c=relaxed/simple;
	bh=pA6k4V9dwaoeIp5xyfNNE1f4Xu/kAiokzrri2F4N/yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oI5Bqjz9Mj0gnfnkxs0em52zX3oAUDvEeRc7qGRyGSSWgvt2RNZwhUG++IZYPDCiBJy1lAQK08z8wbEqe7SCbnXeEfp77rH3aBwu36DIz4rc+bsbV2JeVHNmcLUwXqODKkJDw/lxAn771rA5iZ5a+NJVkrSVSIabM1SyE3p49nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E664C1A0264;
	Fri, 19 Jul 2024 08:01:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B41D41A01B8;
	Fri, 19 Jul 2024 08:01:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BF6571820F77;
	Fri, 19 Jul 2024 14:01:19 +0800 (+08)
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
Subject: [PATCH v4 5/6] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
Date: Fri, 19 Jul 2024 13:42:15 +0800
Message-Id: <1721367736-30156-6-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
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


