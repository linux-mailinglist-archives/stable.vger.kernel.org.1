Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFFC75D466
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjGUTUu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjGUTUq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA462737
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7B1E61B24
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1194C433C8;
        Fri, 21 Jul 2023 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967244;
        bh=z5LZoxRrgbBp+zB7s0+ICMhj21qAjW9NCNmbW0BGw+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/Blpi7fu70ZH6VqYElocV5GHkxoUn/dl8WPfp7P6Na2zUzxMXYS+QGu88f1MQJa4
         Yh1CcmRB3/NMaGZT8wgaOsgbSMeFIFAuukkgfT+3fBvc1LKX6PIfv8LNLOmvUwJDy/
         7EVCy1OAjeAZe6GTvNuIBdF+jv8JnhkyrL0W4XQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 095/223] net: phy: dp83td510: fix kernel stall during netboot in DP83TD510E PHY driver
Date:   Fri, 21 Jul 2023 18:05:48 +0200
Message-ID: <20230721160524.913479323@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit fc0649395dca81f2b3b02d9b248acb38cbcee55c upstream.

Fix an issue where the kernel would stall during netboot, showing the
"sched: RT throttling activated" message. This stall was triggered by
the behavior of the mii_interrupt bit (Bit 7 - DP83TD510E_STS_MII_INT)
in the DP83TD510E's PHY_STS Register (Address = 0x10). The DP83TD510E
datasheet (2020) states that the bit clears on write, however, in
practice, the bit clears on read.

This discrepancy had significant implications on the driver's interrupt
handling. The PHY_STS Register was used by handle_interrupt() to check
for pending interrupts and by read_status() to get the current link
status. The call to read_status() was unintentionally clearing the
mii_interrupt status bit without deasserting the IRQ pin, causing
handle_interrupt() to miss other pending interrupts. This issue was most
apparent during netboot.

The fix refrains from using the PHY_STS Register for interrupt handling.
Instead, we now solely rely on the INTERRUPT_REG_1 Register (Address =
0x12) and INTERRUPT_REG_2 Register (Address = 0x13) for this purpose.
These registers directly influence the IRQ pin state and are latched
high until read.

Note: The INTERRUPT_REG_2 Register (Address = 0x13) exists and can also
be used for interrupt handling, specifically for "Aneg page received
interrupt" and "Polarity change interrupt". However, these features are
currently not supported by this driver.

Fixes: 165cd04fe253 ("net: phy: dp83td510: Add support for the DP83TD510 Ethernet PHY")
Cc: <stable@vger.kernel.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20230621043848.3806124-1-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/dp83td510.c |   23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -12,6 +12,11 @@
 
 /* MDIO_MMD_VEND2 registers */
 #define DP83TD510E_PHY_STS			0x10
+/* Bit 7 - mii_interrupt, active high. Clears on read.
+ * Note: Clearing does not necessarily deactivate IRQ pin if interrupts pending.
+ * This differs from the DP83TD510E datasheet (2020) which states this bit
+ * clears on write 0.
+ */
 #define DP83TD510E_STS_MII_INT			BIT(7)
 #define DP83TD510E_LINK_STATUS			BIT(0)
 
@@ -53,12 +58,6 @@ static int dp83td510_config_intr(struct
 	int ret;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
-		/* Clear any pending interrupts */
-		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PHY_STS,
-				    0x0);
-		if (ret)
-			return ret;
-
 		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
 				    DP83TD510E_INTERRUPT_REG_1,
 				    DP83TD510E_INT1_LINK_EN);
@@ -81,10 +80,6 @@ static int dp83td510_config_intr(struct
 					 DP83TD510E_GENCFG_INT_EN);
 		if (ret)
 			return ret;
-
-		/* Clear any pending interrupts */
-		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PHY_STS,
-				    0x0);
 	}
 
 	return ret;
@@ -94,14 +89,6 @@ static irqreturn_t dp83td510_handle_inte
 {
 	int  ret;
 
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PHY_STS);
-	if (ret < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	} else if (!(ret & DP83TD510E_STS_MII_INT)) {
-		return IRQ_NONE;
-	}
-
 	/* Read the current enabled interrupts */
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_INTERRUPT_REG_1);
 	if (ret < 0) {


