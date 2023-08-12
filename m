Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481F277A1C6
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHLSc3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHLSc0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:32:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E6AE75
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3C561DBD
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3504EC433C8;
        Sat, 12 Aug 2023 18:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865148;
        bh=A47V4jueRXKPb7JR2/hUQCOOJQNyML9/40vnAViZtJ0=;
        h=Subject:To:Cc:From:Date:From;
        b=s/YOGAyCw4me8He3h2jex6knHhvnmBgN28nKhhEMFuT5chSgUPdlQUq9ErSecU8e0
         YL9s8yhT5XP1Zc1GzM9iIr0g/XZO9N6KzIz1rLpdFbt93I5+uttCmd7uUr9H4LKWah
         8+j9uFizQdcdAdhlSARPivd3q62VFUYLVvNZTH34=
Subject: FAILED: patch "[PATCH] net: phy: at803x: fix the wol setting functions" failed to apply to 5.15-stable tree
To:     leoyang.li@nxp.com, davem@davemloft.net,
        rmk+kernel@armlinux.org.uk, viorel.suman@nxp.com, wei.fang@nxp.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:32:21 +0200
Message-ID: <2023081221-myth-coyness-ed74@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e58f30246c35c126c7571065b33bee4b3b1d2ef8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081221-myth-coyness-ed74@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

e58f30246c35 ("net: phy: at803x: fix the wol setting functions")
988e8d90b3dc ("net: phy: at803x: Use devm_regulator_get_enable_optional()")
1f0dd412e34e ("net: phy: at803x: fix error return code in at803x_probe()")
9926de7315be ("net: phy: at803x: fix NULL pointer dereference on AR9331 PHY")
d7cd5e06c9dd ("net: phy: at803x: disable WOL at probe")
3265f4218878 ("net: phy: at803x: add fiber support")
4f3a00c7f5b2 ("net: phy: at803x: move page selection fix to config_init")
edcb501e543c ("net: phy: at803x: make array offsets static")
8c84d7528d8d ("net: phy: add qca8081 cdt feature")
9d4dae29624f ("net: phy: add qca8081 soft_reset and enable master/slave seed")
2acdd43fe009 ("net: phy: add qca8081 config_init")
f884d449bf28 ("net: phy: add qca8081 config_aneg")
765c22aad157 ("net: phy: add qca8081 get_features")
79c7bc052154 ("net: phy: add qca8081 read_status")
daf61732a49a ("net: phy: add qca8081 ethernet phy driver")
9540cdda9113 ("net: phy: at803x: use GENMASK() for speed status")
7beecaf7d507 ("net: phy: at803x: improve the WOL feature")
2d4284e88a59 ("net: phy: at803x: use phy_modify()")
c0f0b563f8c0 ("net: phy: at803x: replace AT803X_DEVICE_ADDR with MDIO_MMD_PCS")
ba3c01ee02ed ("net: phy: at803x: fix resume for QCA8327 phy")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e58f30246c35c126c7571065b33bee4b3b1d2ef8 Mon Sep 17 00:00:00 2001
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 2 Aug 2023 14:13:46 -0500
Subject: [PATCH] net: phy: at803x: fix the wol setting functions

In commit 7beecaf7d507 ("net: phy: at803x: improve the WOL feature"), it
seems not correct to use a wol_en bit in a 1588 Control Register which is
only available on AR8031/AR8033(share the same phy_id) to determine if WoL
is enabled.  Change it back to use AT803X_INTR_ENABLE_WOL for determining
the WoL status which is applicable on all chips supporting wol. Also update
the at803x_set_wol() function to only update the 1588 register on chips
having it.  After this change, disabling wol at probe from commit
d7cd5e06c9dd ("net: phy: at803x: disable WOL at probe") is no longer
needed.  Change it to just disable the WoL bit in 1588 register for
AR8031/AR8033 to be aligned with AT803X_INTR_ENABLE_WOL in probe.

Fixes: 7beecaf7d507 ("net: phy: at803x: improve the WOL feature")
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Reviewed-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index c1f307d90518..9c2c2e2ee94b 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -459,21 +459,27 @@ static int at803x_set_wol(struct phy_device *phydev,
 			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
 				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
 
-		/* Enable WOL function */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, AT803X_PHY_MMD3_WOL_CTRL,
-				0, AT803X_WOL_EN);
-		if (ret)
-			return ret;
+		/* Enable WOL function for 1588 */
+		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
+			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+					     AT803X_PHY_MMD3_WOL_CTRL,
+					     0, AT803X_WOL_EN);
+			if (ret)
+				return ret;
+		}
 		/* Enable WOL interrupt */
 		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
 		if (ret)
 			return ret;
 	} else {
-		/* Disable WoL function */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, AT803X_PHY_MMD3_WOL_CTRL,
-				AT803X_WOL_EN, 0);
-		if (ret)
-			return ret;
+		/* Disable WoL function for 1588 */
+		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
+			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+					     AT803X_PHY_MMD3_WOL_CTRL,
+					     AT803X_WOL_EN, 0);
+			if (ret)
+				return ret;
+		}
 		/* Disable WOL interrupt */
 		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
 		if (ret)
@@ -508,11 +514,11 @@ static void at803x_get_wol(struct phy_device *phydev,
 	wol->supported = WAKE_MAGIC;
 	wol->wolopts = 0;
 
-	value = phy_read_mmd(phydev, MDIO_MMD_PCS, AT803X_PHY_MMD3_WOL_CTRL);
+	value = phy_read(phydev, AT803X_INTR_ENABLE);
 	if (value < 0)
 		return;
 
-	if (value & AT803X_WOL_EN)
+	if (value & AT803X_INTR_ENABLE_WOL)
 		wol->wolopts |= WAKE_MAGIC;
 }
 
@@ -858,9 +864,6 @@ static int at803x_probe(struct phy_device *phydev)
 	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
 		int ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
 		int mode_cfg;
-		struct ethtool_wolinfo wol = {
-			.wolopts = 0,
-		};
 
 		if (ccr < 0)
 			return ccr;
@@ -877,12 +880,14 @@ static int at803x_probe(struct phy_device *phydev)
 			break;
 		}
 
-		/* Disable WOL by default */
-		ret = at803x_set_wol(phydev, &wol);
-		if (ret < 0) {
-			phydev_err(phydev, "failed to disable WOL on probe: %d\n", ret);
+		/* Disable WoL in 1588 register which is enabled
+		 * by default
+		 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     AT803X_PHY_MMD3_WOL_CTRL,
+				     AT803X_WOL_EN, 0);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;

