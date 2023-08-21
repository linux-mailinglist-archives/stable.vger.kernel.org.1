Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B94783316
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjHUUAG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjHUUAF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:00:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3C211C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE94B64757
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8A8C433C8;
        Mon, 21 Aug 2023 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648001;
        bh=CRVOkD2vWg3fx+B3SSLhATxmH6MKvwFwo4PNBdTmeGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9GXapKKN9RWvI3EE7+6qAGXObrLLZbh62JMh/WpcXDy62yacacRDDCUcNthg56v7
         N/WZN2eiDdtFqrrDG/CVXtZH1tXr9IvMcZG1Qda1pIYhBKJiFCE7q+Jf1d7nOnjgDK
         bhwebpmOD79WYnUARfdePgBa0UlxRD2JAh7V5LiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 002/234] net: phy: at803x: Use devm_regulator_get_enable_optional()
Date:   Mon, 21 Aug 2023 21:39:25 +0200
Message-ID: <20230821194128.861347331@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 988e8d90b3dc482637532e61bc2d58bfc4af5167 ]

Use devm_regulator_get_enable_optional() instead of hand writing it. It
saves some line of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e58f30246c35 ("net: phy: at803x: fix the wol setting functions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/at803x.c | 44 +++++++---------------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index ef6dc008e4c50..b2e1c0655f628 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -304,7 +304,6 @@ struct at803x_priv {
 	bool is_1000basex;
 	struct regulator_dev *vddio_rdev;
 	struct regulator_dev *vddh_rdev;
-	struct regulator *vddio;
 	u64 stats[ARRAY_SIZE(at803x_hw_stats)];
 };
 
@@ -824,11 +823,11 @@ static int at803x_parse_dt(struct phy_device *phydev)
 		if (ret < 0)
 			return ret;
 
-		priv->vddio = devm_regulator_get_optional(&phydev->mdio.dev,
-							  "vddio");
-		if (IS_ERR(priv->vddio)) {
+		ret = devm_regulator_get_enable_optional(&phydev->mdio.dev,
+							 "vddio");
+		if (ret) {
 			phydev_err(phydev, "failed to get VDDIO regulator\n");
-			return PTR_ERR(priv->vddio);
+			return ret;
 		}
 
 		/* Only AR8031/8033 support 1000Base-X for SFP modules */
@@ -856,12 +855,6 @@ static int at803x_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (priv->vddio) {
-		ret = regulator_enable(priv->vddio);
-		if (ret < 0)
-			return ret;
-	}
-
 	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
 		int ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
 		int mode_cfg;
@@ -869,10 +862,8 @@ static int at803x_probe(struct phy_device *phydev)
 			.wolopts = 0,
 		};
 
-		if (ccr < 0) {
-			ret = ccr;
-			goto err;
-		}
+		if (ccr < 0)
+			return ccr;
 		mode_cfg = ccr & AT803X_MODE_CFG_MASK;
 
 		switch (mode_cfg) {
@@ -890,25 +881,11 @@ static int at803x_probe(struct phy_device *phydev)
 		ret = at803x_set_wol(phydev, &wol);
 		if (ret < 0) {
 			phydev_err(phydev, "failed to disable WOL on probe: %d\n", ret);
-			goto err;
+			return ret;
 		}
 	}
 
 	return 0;
-
-err:
-	if (priv->vddio)
-		regulator_disable(priv->vddio);
-
-	return ret;
-}
-
-static void at803x_remove(struct phy_device *phydev)
-{
-	struct at803x_priv *priv = phydev->priv;
-
-	if (priv->vddio)
-		regulator_disable(priv->vddio);
 }
 
 static int at803x_get_features(struct phy_device *phydev)
@@ -2021,7 +1998,6 @@ static struct phy_driver at803x_driver[] = {
 	.name			= "Qualcomm Atheros AR8035",
 	.flags			= PHY_POLL_CABLE_TEST,
 	.probe			= at803x_probe,
-	.remove			= at803x_remove,
 	.config_aneg		= at803x_config_aneg,
 	.config_init		= at803x_config_init,
 	.soft_reset		= genphy_soft_reset,
@@ -2043,7 +2019,6 @@ static struct phy_driver at803x_driver[] = {
 	.name			= "Qualcomm Atheros AR8030",
 	.phy_id_mask		= AT8030_PHY_ID_MASK,
 	.probe			= at803x_probe,
-	.remove			= at803x_remove,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
 	.set_wol		= at803x_set_wol,
@@ -2059,7 +2034,6 @@ static struct phy_driver at803x_driver[] = {
 	.name			= "Qualcomm Atheros AR8031/AR8033",
 	.flags			= PHY_POLL_CABLE_TEST,
 	.probe			= at803x_probe,
-	.remove			= at803x_remove,
 	.config_init		= at803x_config_init,
 	.config_aneg		= at803x_config_aneg,
 	.soft_reset		= genphy_soft_reset,
@@ -2082,7 +2056,6 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_EXACT(ATH8032_PHY_ID),
 	.name			= "Qualcomm Atheros AR8032",
 	.probe			= at803x_probe,
-	.remove			= at803x_remove,
 	.flags			= PHY_POLL_CABLE_TEST,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
@@ -2098,7 +2071,6 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_EXACT(ATH9331_PHY_ID),
 	.name			= "Qualcomm Atheros AR9331 built-in PHY",
 	.probe			= at803x_probe,
-	.remove			= at803x_remove,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
@@ -2115,7 +2087,6 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_EXACT(QCA9561_PHY_ID),
 	.name			= "Qualcomm Atheros QCA9561 built-in PHY",
 	.probe			= at803x_probe,
-	.remove			= at803x_remove,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
@@ -2181,7 +2152,6 @@ static struct phy_driver at803x_driver[] = {
 	.name			= "Qualcomm QCA8081",
 	.flags			= PHY_POLL_CABLE_TEST,
 	.probe			= at803x_probe,
-	.remove			= at803x_remove,
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
-- 
2.40.1



