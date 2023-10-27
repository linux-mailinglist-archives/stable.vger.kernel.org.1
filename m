Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C807D9764
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345815AbjJ0MMB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345763AbjJ0MMA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:12:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8321BB
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:11:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D479DC433C7;
        Fri, 27 Oct 2023 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698408717;
        bh=lT4VW6a/19q5ShKRx1KhwB/IK/7DGT6a3G6Tcb+aEkc=;
        h=Subject:To:Cc:From:Date:From;
        b=bTE4gnCQOyqgucWyexzFRAaxjJNsH0u8qKoGs7WgehUMdigIFu/+wn72yO1HShdrX
         TzwChCCmoqLINWhcRE15xJEUySsLe5kLwoXUXCoDlgyhL1BdW94l81OaSW5v1HoJ5x
         t9PgeVEB184OqiKND2rvP+9vG2o6jXT1eIsIf+qY=
Subject: FAILED: patch "[PATCH] net: stmmac: update MAC capabilities when tx queues are" failed to apply to 6.1-stable tree
To:     michael.wei.hong.sit@intel.com, davem@davemloft.net,
        stable@vger.kernel.org, yi.fang.gan@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:11:52 +0200
Message-ID: <2023102752-maturely-stardom-066f@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 95201f36f395df34321fcddbce12103e8bbe4970
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102752-maturely-stardom-066f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 95201f36f395df34321fcddbce12103e8bbe4970 Mon Sep 17 00:00:00 2001
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Date: Fri, 20 Oct 2023 11:25:35 +0800
Subject: [PATCH] net: stmmac: update MAC capabilities when tx queues are
 updated

Upon boot up, the driver will configure the MAC capabilities based on
the maximum number of tx and rx queues. When the user changes the
tx queues to single queue, the MAC should be capable of supporting Half
Duplex, but the driver does not update the MAC capabilities when it is
configured so.

Using the stmmac_reinit_queues() to check the number of tx queues
and set the MAC capabilities accordingly.

Fixes: 0366f7e06a6b ("net: stmmac: add ethtool support for get/set channels")
Cc: <stable@vger.kernel.org> # 5.17+
Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ed1a5a31a491..5801f4d50f95 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1197,6 +1197,17 @@ static int stmmac_init_phy(struct net_device *dev)
 	return ret;
 }
 
+static void stmmac_set_half_duplex(struct stmmac_priv *priv)
+{
+	/* Half-Duplex can only work with single tx queue */
+	if (priv->plat->tx_queues_to_use > 1)
+		priv->phylink_config.mac_capabilities &=
+			~(MAC_10HD | MAC_100HD | MAC_1000HD);
+	else
+		priv->phylink_config.mac_capabilities |=
+			(MAC_10HD | MAC_100HD | MAC_1000HD);
+}
+
 static int stmmac_phy_setup(struct stmmac_priv *priv)
 {
 	struct stmmac_mdio_bus_data *mdio_bus_data;
@@ -1228,10 +1239,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 						MAC_10FD | MAC_100FD |
 						MAC_1000FD;
 
-	/* Half-Duplex can only work with single queue */
-	if (priv->plat->tx_queues_to_use <= 1)
-		priv->phylink_config.mac_capabilities |= MAC_10HD | MAC_100HD |
-							 MAC_1000HD;
+	stmmac_set_half_duplex(priv);
 
 	/* Get the MAC specific capabilities */
 	stmmac_mac_phylink_get_caps(priv);
@@ -7172,6 +7180,7 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
 									rx_cnt);
 
+	stmmac_set_half_duplex(priv);
 	stmmac_napi_add(dev);
 
 	if (netif_running(dev))

