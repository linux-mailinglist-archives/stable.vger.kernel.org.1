Return-Path: <stable+bounces-68063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334EE953071
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D5D1C24046
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB42A19DF58;
	Thu, 15 Aug 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Va2wsSsQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4011714A8;
	Thu, 15 Aug 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729380; cv=none; b=EZ/4lJOUwEiPYsrXWAmltHcnNKc4oDEdp6EfbAQZ0IfXFc6BXGLGVmul9PA5BmOda93pDm2CCaUVkF+1PXg0k+pXjfcX0y7phlyZsgthAx5G/AHZRKe8Oin0tWY60q6M+Q0mzez/0BFNmBmBkEq5kZnD2V/01pSzYjifvnPV/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729380; c=relaxed/simple;
	bh=h47hcM3zCAHAYkKglPZX9ej+6ElzSg3SIu4t4U8GU18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlPVGMEemeOTJCBHIzSMrZFj4t/TNnFUXPhE68Rg5l/NOCwKt8+mCotB/S8aywEg+82UAMBYnSugzImo/daUT9Q68/4Uy654ijXXGT4yL4GGK/ZhVReu8akr9ul9GESSm+u0qP+3II54cBZu4LWcexFcgil/Zz7FBWO8OWgMPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Va2wsSsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDF3C32786;
	Thu, 15 Aug 2024 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729380;
	bh=h47hcM3zCAHAYkKglPZX9ej+6ElzSg3SIu4t4U8GU18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Va2wsSsQlE/R9EfxfozmKuRrWqmibtV76ULM4BC0gcRmaq3i9rW6FbIzLgO6FpoCt
	 zvbpTuQxVUgQrICWg841HEDrCixgQ0DJsrwSC017m6gjjJepDAcgdcIRCDLI+84iP9
	 fMFYzkKEsMHv69HZ/fKzKv18WHAufNJ7Gfe4RWQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 062/484] net: fec: Refactor: #define magic constants
Date: Thu, 15 Aug 2024 15:18:40 +0200
Message-ID: <20240815131943.679358682@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Csókás Bence <csokas.bence@prolan.hu>

[ Upstream commit ff049886671ccd4e624a30ec464cb20e4c39a313 ]

Add defines for bits of ECR, RCR control registers, TX watermark etc.

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20240212153717.10023-1-csokas.bence@prolan.hu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c32fe1986f27 ("net: fec: Fix FEC_ECR_EN1588 being cleared on link-down")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 46 +++++++++++++++--------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f02376555ed45..722810ce4068f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -252,8 +252,8 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define PKT_MINBUF_SIZE		64
 
 /* FEC receive acceleration */
-#define FEC_RACC_IPDIS		(1 << 1)
-#define FEC_RACC_PRODIS		(1 << 2)
+#define FEC_RACC_IPDIS		BIT(1)
+#define FEC_RACC_PRODIS		BIT(2)
 #define FEC_RACC_SHIFT16	BIT(7)
 #define FEC_RACC_OPTIONS	(FEC_RACC_IPDIS | FEC_RACC_PRODIS)
 
@@ -285,8 +285,23 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_MMFR_TA		(2 << 16)
 #define FEC_MMFR_DATA(v)	(v & 0xffff)
 /* FEC ECR bits definition */
-#define FEC_ECR_MAGICEN		(1 << 2)
-#define FEC_ECR_SLEEP		(1 << 3)
+#define FEC_ECR_RESET           BIT(0)
+#define FEC_ECR_ETHEREN         BIT(1)
+#define FEC_ECR_MAGICEN         BIT(2)
+#define FEC_ECR_SLEEP           BIT(3)
+#define FEC_ECR_EN1588          BIT(4)
+#define FEC_ECR_BYTESWP         BIT(8)
+/* FEC RCR bits definition */
+#define FEC_RCR_LOOP            BIT(0)
+#define FEC_RCR_HALFDPX         BIT(1)
+#define FEC_RCR_MII             BIT(2)
+#define FEC_RCR_PROMISC         BIT(3)
+#define FEC_RCR_BC_REJ          BIT(4)
+#define FEC_RCR_FLOWCTL         BIT(5)
+#define FEC_RCR_RMII            BIT(8)
+#define FEC_RCR_10BASET         BIT(9)
+/* TX WMARK bits */
+#define FEC_TXWMRK_STRFWD       BIT(8)
 
 #define FEC_MII_TIMEOUT		30000 /* us */
 
@@ -981,7 +996,7 @@ fec_restart(struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	u32 temp_mac[2];
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
-	u32 ecntl = 0x2; /* ETHEREN */
+	u32 ecntl = FEC_ECR_ETHEREN;
 
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
@@ -1059,18 +1074,18 @@ fec_restart(struct net_device *ndev)
 		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID)
 			rcntl |= (1 << 6);
 		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
-			rcntl |= (1 << 8);
+			rcntl |= FEC_RCR_RMII;
 		else
-			rcntl &= ~(1 << 8);
+			rcntl &= ~FEC_RCR_RMII;
 
 		/* 1G, 100M or 10M */
 		if (ndev->phydev) {
 			if (ndev->phydev->speed == SPEED_1000)
 				ecntl |= (1 << 5);
 			else if (ndev->phydev->speed == SPEED_100)
-				rcntl &= ~(1 << 9);
+				rcntl &= ~FEC_RCR_10BASET;
 			else
-				rcntl |= (1 << 9);
+				rcntl |= FEC_RCR_10BASET;
 		}
 	} else {
 #ifdef FEC_MIIGSK_ENR
@@ -1129,13 +1144,13 @@ fec_restart(struct net_device *ndev)
 
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* enable ENET endian swap */
-		ecntl |= (1 << 8);
+		ecntl |= FEC_ECR_BYTESWP;
 		/* enable ENET store and forward mode */
-		writel(1 << 8, fep->hwp + FEC_X_WMRK);
+		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}
 
 	if (fep->bufdesc_ex)
-		ecntl |= (1 << 4);
+		ecntl |= FEC_ECR_EN1588;
 
 	if (fep->quirks & FEC_QUIRK_DELAYED_CLKS_SUPPORT &&
 	    fep->rgmii_txc_dly)
@@ -1189,7 +1204,7 @@ static void
 fec_stop(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
+	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
 	u32 val;
 
 	/* We cannot expect a graceful transmit stop without link !!! */
@@ -1208,7 +1223,7 @@ fec_stop(struct net_device *ndev)
 		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
 			writel(0, fep->hwp + FEC_ECNTRL);
 		} else {
-			writel(1, fep->hwp + FEC_ECNTRL);
+			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
 			udelay(10);
 		}
 		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
@@ -1224,12 +1239,11 @@ fec_stop(struct net_device *ndev)
 	/* We have to keep ENET enabled to have MII interrupt stay working */
 	if (fep->quirks & FEC_QUIRK_ENET_MAC &&
 		!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
-		writel(2, fep->hwp + FEC_ECNTRL);
+		writel(FEC_ECR_ETHEREN, fep->hwp + FEC_ECNTRL);
 		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
 	}
 }
 
-
 static void
 fec_timeout(struct net_device *ndev, unsigned int txqueue)
 {
-- 
2.43.0




