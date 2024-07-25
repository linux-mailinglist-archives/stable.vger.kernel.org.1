Return-Path: <stable+bounces-61352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8306A93BCF6
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 09:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1DA282968
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 07:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8516E892;
	Thu, 25 Jul 2024 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EoTZd8wG"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7916CD3A;
	Thu, 25 Jul 2024 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891722; cv=none; b=hAKJe2rs2Uoe/pDY2Hm0m7XHIRJWZrwJ6tepA1NqhbphNgqQ+ZP6ztUF0u7jWSV4w2w6faA72DhKnx6dZszrHzL593J9N4NPdpF9dF/8K4xN1IwvXrGB1q/joqxc1IhjaErIOSE76txq6qp3yJ5sGgz1xs3sxurg/Co/8t4RMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891722; c=relaxed/simple;
	bh=C6WRwDUONbCwjMOYbPgm8PvoHT72vL1m8MFet/DFhv4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ew8lDchEjkFkiocmpR/uHRTpe9rg14z4wKB0yaBpLP2IyTLDBgoHTKUu21M8Ah6KbCpeRvEkv9R2CC2FkH9czE24c96KXf3AqALJ3YM7A5pKQ5InDj7lSG+UyFpDpaTTyxS/NPcyT8qZbspgKzQck0q8qwpFnNN17WkclhYJmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EoTZd8wG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721891721; x=1753427721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C6WRwDUONbCwjMOYbPgm8PvoHT72vL1m8MFet/DFhv4=;
  b=EoTZd8wGWKdqN54orOLP7N6V8ATfFpM0SyHC6M1p/k2/T6YiBeyj+gKO
   0CRW59pMPLjt+rR/Kgk4WMg1h+7cs7Mgjvn7WmqH6BKHgHQInVCD/dOWU
   ESv8+PPCSgleXua2yDjlFVG98TmWr8cnwcONa4/CVxt/NMINauZp+UrsC
   dkSUUffM45tNvDFk+GtEJl1zy9P1pBAPnvTRpeOMngUIs/iNwtTpGJ/gd
   j7TvWqjgPjKYAeoNtgEI+ZU/y/+0/fTDVlGLvdE4MbG0pVLDroFv6Py2t
   uItUDMb6FuEKurusTioEppOSMEU7Mme8OQ5TU7UfkLZsDC03TNKt0nS8w
   w==;
X-CSE-ConnectionGUID: 6oFYj1z4SPSlQiymYK1oBA==
X-CSE-MsgGUID: R3+59Xb1TRe+XjSfi5TUmw==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="30323881"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 00:15:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 00:14:57 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 00:14:53 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horatiu.vultur@microchip.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net V1] net: phy: micrel: Fix the KSZ9131 MDI-X status issue
Date: Thu, 25 Jul 2024 12:41:25 +0530
Message-ID: <20240725071125.13960-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The MDIX status is not accurately reflecting the current state after the link
partner has manually altered its MDIX configuration while operating in forced
mode.

Access information about Auto mdix completion and pair selection from the
KSZ9131's Auto/MDI/MDI-X status register

Fixes: b64e6a8794d9 ("net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/phy/micrel.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index dd519805deee..65b0a3115e14 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1389,6 +1389,8 @@ static int ksz9131_config_init(struct phy_device *phydev)
 	const struct device *dev_walker;
 	int ret;
 
+	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+
 	dev_walker = &phydev->mdio.dev;
 	do {
 		of_node = dev_walker->of_node;
@@ -1438,28 +1440,30 @@ static int ksz9131_config_init(struct phy_device *phydev)
 #define MII_KSZ9131_AUTO_MDIX		0x1C
 #define MII_KSZ9131_AUTO_MDI_SET	BIT(7)
 #define MII_KSZ9131_AUTO_MDIX_SWAP_OFF	BIT(6)
+#define MII_KSZ9131_DIG_AXAN_STS	0x14
+#define MII_KSZ9131_DIG_AXAN_STS_LINK_DET	BIT(14)
+#define MII_KSZ9131_DIG_AXAN_STS_A_SELECT	BIT(12)
 
 static int ksz9131_mdix_update(struct phy_device *phydev)
 {
 	int ret;
 
-	ret = phy_read(phydev, MII_KSZ9131_AUTO_MDIX);
-	if (ret < 0)
-		return ret;
-
-	if (ret & MII_KSZ9131_AUTO_MDIX_SWAP_OFF) {
-		if (ret & MII_KSZ9131_AUTO_MDI_SET)
-			phydev->mdix_ctrl = ETH_TP_MDI;
-		else
-			phydev->mdix_ctrl = ETH_TP_MDI_X;
+	if (phydev->mdix_ctrl != ETH_TP_MDI_AUTO) {
+		phydev->mdix = phydev->mdix_ctrl;
 	} else {
-		phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
-	}
+		ret = phy_read(phydev, MII_KSZ9131_DIG_AXAN_STS);
+		if (ret < 0)
+			return ret;
 
-	if (ret & MII_KSZ9131_AUTO_MDI_SET)
-		phydev->mdix = ETH_TP_MDI;
-	else
-		phydev->mdix = ETH_TP_MDI_X;
+		if (ret & MII_KSZ9131_DIG_AXAN_STS_LINK_DET) {
+			if (ret & MII_KSZ9131_DIG_AXAN_STS_A_SELECT)
+				phydev->mdix = ETH_TP_MDI;
+			else
+				phydev->mdix = ETH_TP_MDI_X;
+		} else {
+			phydev->mdix = ETH_TP_MDI_INVALID;
+		}
+	}
 
 	return 0;
 }
-- 
2.34.1


