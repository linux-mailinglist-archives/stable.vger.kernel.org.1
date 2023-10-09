Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC517BDDD1
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376797AbjJINNi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376870AbjJINNW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7542EA6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:12:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9EEC433CA;
        Mon,  9 Oct 2023 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857155;
        bh=ilxlO9T1hPCXSAi7/OfiB1ez/s7hdsq9WLDXDzEdB6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPtUDx2mmFmL+Ka+M96WiMUkxUsmyUVAssaSBXEMsc5cRnwAn8zZp83uEK1MvnJLf
         8mlVjU82iIRtTktmZ/Ix//Nm6C8cUq9vrX1OCPYGiQwOLkeBSURXmidzN08iCvqqMc
         4Ru4TlcVtyXg+zh2fr4k3OoLrJcB4EgoEAERC3JU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tam Nguyen <tam.nguyen.xa@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 114/163] rswitch: Fix PHY station management clock setting
Date:   Mon,  9 Oct 2023 15:01:18 +0200
Message-ID: <20231009130127.174538105@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit a0c55bba0d0d0b5591083f65f830940d8ae63f31 ]

Fix the MPIC.PSMCS value following the programming example in the
section 6.4.2 Management Data Clock (MDC) Setting, Ethernet MAC IP,
S4 Hardware User Manual Rev.1.00.

The value is calculated by
    MPIC.PSMCS = clk[MHz] / (MDC frequency[MHz] * 2) - 1
with the input clock frequency from clk_get_rate() and MDC frequency
of 2.5MHz. Otherwise, this driver cannot communicate PHYs on the R-Car
S4 Starter Kit board.

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Reported-by: Tam Nguyen <tam.nguyen.xa@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20230926123054.3976752-1-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/rswitch.c | 13 ++++++++++++-
 drivers/net/ethernet/renesas/rswitch.h |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 215854812f80a..660cbfe344d2c 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022 Renesas Electronics Corporation
  */
 
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/etherdevice.h>
@@ -1049,7 +1050,7 @@ static void rswitch_rmac_setting(struct rswitch_etha *etha, const u8 *mac)
 static void rswitch_etha_enable_mii(struct rswitch_etha *etha)
 {
 	rswitch_modify(etha->addr, MPIC, MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
-		       MPIC_PSMCS(0x05) | MPIC_PSMHT(0x06));
+		       MPIC_PSMCS(etha->psmcs) | MPIC_PSMHT(0x06));
 	rswitch_modify(etha->addr, MPSM, 0, MPSM_MFF_C45);
 }
 
@@ -1681,6 +1682,12 @@ static void rswitch_etha_init(struct rswitch_private *priv, int index)
 	etha->index = index;
 	etha->addr = priv->addr + RSWITCH_ETHA_OFFSET + index * RSWITCH_ETHA_SIZE;
 	etha->coma_addr = priv->addr;
+
+	/* MPIC.PSMCS = (clk [MHz] / (MDC frequency [MHz] * 2) - 1.
+	 * Calculating PSMCS value as MDC frequency = 2.5MHz. So, multiply
+	 * both the numerator and the denominator by 10.
+	 */
+	etha->psmcs = clk_get_rate(priv->clk) / 100000 / (25 * 2) - 1;
 }
 
 static int rswitch_device_alloc(struct rswitch_private *priv, int index)
@@ -1882,6 +1889,10 @@ static int renesas_eth_sw_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	spin_lock_init(&priv->lock);
 
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
 	priv->ptp_priv = rcar_gen4_ptp_alloc(pdev);
 	if (!priv->ptp_priv)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 9740398067140..13a401cebd8b7 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -915,6 +915,7 @@ struct rswitch_etha {
 	bool external_phy;
 	struct mii_bus *mii;
 	phy_interface_t phy_interface;
+	u32 psmcs;
 	u8 mac_addr[MAX_ADDR_LEN];
 	int link;
 	int speed;
@@ -1012,6 +1013,7 @@ struct rswitch_private {
 	struct rswitch_mfwd mfwd;
 
 	spinlock_t lock;	/* lock interrupt registers' control */
+	struct clk *clk;
 
 	bool gwca_halt;
 };
-- 
2.40.1



