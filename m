Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E2719DE7
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjFAN12 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjFAN1M (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709A41AD
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48B32644BF
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DC8C433D2;
        Thu,  1 Jun 2023 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626014;
        bh=BuBrf69UuEMbsoa6uCg/fgUGps9gMXYrqcFhuQHg11Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCvuagdZyqJTbtqDeYEjuu7qyxfcH5wrW8rTbP06sRQ2oOPltAOkMy23Tst2/jRmm
         /CwhRDVjt/AQT88ORG1vkJaZTJy+GgLNeOigKmLCis5BR0mJpAEmLMIcVZDvfPsOSd
         Jn29Vi8Is9yAJfSx5X6dbjyJCwNvSEU5RnYRljno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        David Epping <david.epping@missinglinkelectronics.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Vladimir Oltean <olteanv@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 41/45] net: phy: mscc: enable VSC8501/2 RGMII RX clock
Date:   Thu,  1 Jun 2023 14:21:37 +0100
Message-Id: <20230601131940.581271682@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: David Epping <david.epping@missinglinkelectronics.com>

[ Upstream commit 71460c9ec5c743e9ffffca3c874d66267c36345e ]

By default the VSC8501 and VSC8502 RGMII/GMII/MII RX_CLK output is
disabled. To allow packet forwarding towards the MAC it needs to be
enabled.

For other PHYs supported by this driver the clock output is enabled
by default.

Fixes: d3169863310d ("net: phy: mscc: add support for VSC8502")
Signed-off-by: David Epping <david.epping@missinglinkelectronics.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc/mscc.h      |  1 +
 drivers/net/phy/mscc/mscc_main.c | 54 +++++++++++++++++---------------
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index a50235fdf7d99..055e4ca5b3b5c 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -179,6 +179,7 @@ enum rgmii_clock_delay {
 #define VSC8502_RGMII_CNTL		  20
 #define VSC8502_RGMII_RX_DELAY_MASK	  0x0070
 #define VSC8502_RGMII_TX_DELAY_MASK	  0x0007
+#define VSC8502_RGMII_RX_CLK_DISABLE	  0x0800
 
 #define MSCC_PHY_WOL_LOWER_MAC_ADDR	  21
 #define MSCC_PHY_WOL_MID_MAC_ADDR	  22
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index bd81a4b041e52..adc8cd6f2d95a 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -519,14 +519,27 @@ static int vsc85xx_mac_if_set(struct phy_device *phydev,
  *  * 2.0 ns (which causes the data to be sampled at exactly half way between
  *    clock transitions at 1000 Mbps) if delays should be enabled
  */
-static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
-				   u16 rgmii_rx_delay_mask,
-				   u16 rgmii_tx_delay_mask)
+static int vsc85xx_update_rgmii_cntl(struct phy_device *phydev, u32 rgmii_cntl,
+				     u16 rgmii_rx_delay_mask,
+				     u16 rgmii_tx_delay_mask)
 {
 	u16 rgmii_rx_delay_pos = ffs(rgmii_rx_delay_mask) - 1;
 	u16 rgmii_tx_delay_pos = ffs(rgmii_tx_delay_mask) - 1;
 	u16 reg_val = 0;
-	int rc;
+	u16 mask = 0;
+	int rc = 0;
+
+	/* For traffic to pass, the VSC8502 family needs the RX_CLK disable bit
+	 * to be unset for all PHY modes, so do that as part of the paged
+	 * register modification.
+	 * For some family members (like VSC8530/31/40/41) this bit is reserved
+	 * and read-only, and the RX clock is enabled by default.
+	 */
+	if (rgmii_cntl == VSC8502_RGMII_CNTL)
+		mask |= VSC8502_RGMII_RX_CLK_DISABLE;
+
+	if (phy_interface_is_rgmii(phydev))
+		mask |= rgmii_rx_delay_mask | rgmii_tx_delay_mask;
 
 	mutex_lock(&phydev->lock);
 
@@ -537,10 +550,9 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
 		reg_val |= RGMII_CLK_DELAY_2_0_NS << rgmii_tx_delay_pos;
 
-	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
-			      rgmii_cntl,
-			      rgmii_rx_delay_mask | rgmii_tx_delay_mask,
-			      reg_val);
+	if (mask)
+		rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
+				      rgmii_cntl, mask, reg_val);
 
 	mutex_unlock(&phydev->lock);
 
@@ -549,19 +561,11 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
 
 static int vsc85xx_default_config(struct phy_device *phydev)
 {
-	int rc;
-
 	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
 
-	if (phy_interface_mode_is_rgmii(phydev->interface)) {
-		rc = vsc85xx_rgmii_set_skews(phydev, VSC8502_RGMII_CNTL,
-					     VSC8502_RGMII_RX_DELAY_MASK,
-					     VSC8502_RGMII_TX_DELAY_MASK);
-		if (rc)
-			return rc;
-	}
-
-	return 0;
+	return vsc85xx_update_rgmii_cntl(phydev, VSC8502_RGMII_CNTL,
+					 VSC8502_RGMII_RX_DELAY_MASK,
+					 VSC8502_RGMII_TX_DELAY_MASK);
 }
 
 static int vsc85xx_get_tunable(struct phy_device *phydev,
@@ -1758,13 +1762,11 @@ static int vsc8584_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (phy_interface_is_rgmii(phydev)) {
-		ret = vsc85xx_rgmii_set_skews(phydev, VSC8572_RGMII_CNTL,
-					      VSC8572_RGMII_RX_DELAY_MASK,
-					      VSC8572_RGMII_TX_DELAY_MASK);
-		if (ret)
-			return ret;
-	}
+	ret = vsc85xx_update_rgmii_cntl(phydev, VSC8572_RGMII_CNTL,
+					VSC8572_RGMII_RX_DELAY_MASK,
+					VSC8572_RGMII_TX_DELAY_MASK);
+	if (ret)
+		return ret;
 
 	ret = genphy_soft_reset(phydev);
 	if (ret)
-- 
2.39.2



