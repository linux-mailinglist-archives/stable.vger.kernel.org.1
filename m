Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0528070C98E
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjEVTtY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjEVTtY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929195
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2BD62ADA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2334C433D2;
        Mon, 22 May 2023 19:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784962;
        bh=qcTLJdlnhfgIBA0C43Sbk31XTRmyFAaa++oUAUaTBn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbeEMJwI3OBOtrTzJBhVLiilM8M3f4cz7QPzEXgCudZqd+N1v7uINYz3iM9TP35X3
         UtCUymhW+VGtwL5BFQMZ9V4PWZszf3Yi/onHJMvd2L5QEckLtaxjQdKCQCkUfsxnT2
         hnc1LBqOqQ6ST3tdYJ+NM5g3Nwe08gcgfCJk8N3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Fainelli <f.fainelli@gmail.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 262/364] net: bcmgenet: Restore phy_stop() depending upon suspend/close
Date:   Mon, 22 May 2023 20:09:27 +0100
Message-Id: <20230522190419.258283968@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 225c657945c4a6307741cb3cc89467eadcc26e9b ]

Removing the phy_stop() from bcmgenet_netif_stop() ended up causing
warnings from the PHY library that phy_start() is called from the
RUNNING state since we are no longer stopping the PHY state machine
during bcmgenet_suspend().

Restore the call to phy_stop() but make it conditional on being called
from the close or suspend path.

Fixes: c96e731c93ff ("net: bcmgenet: connect and disconnect from the PHY state machine")
Fixes: 93e0401e0fc0 ("net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://lore.kernel.org/r/20230515025608.2587012-1-f.fainelli@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index f28ffc31df220..eca0c92c0c84d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3450,7 +3450,7 @@ static int bcmgenet_open(struct net_device *dev)
 	return ret;
 }
 
-static void bcmgenet_netif_stop(struct net_device *dev)
+static void bcmgenet_netif_stop(struct net_device *dev, bool stop_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
@@ -3465,6 +3465,8 @@ static void bcmgenet_netif_stop(struct net_device *dev)
 	/* Disable MAC transmit. TX DMA disabled must be done before this */
 	umac_enable_set(priv, CMD_TX_EN, false);
 
+	if (stop_phy)
+		phy_stop(dev->phydev);
 	bcmgenet_disable_rx_napi(priv);
 	bcmgenet_intr_disable(priv);
 
@@ -3485,7 +3487,7 @@ static int bcmgenet_close(struct net_device *dev)
 
 	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
 
-	bcmgenet_netif_stop(dev);
+	bcmgenet_netif_stop(dev, false);
 
 	/* Really kill the PHY state machine and disconnect from it */
 	phy_disconnect(dev->phydev);
@@ -4303,7 +4305,7 @@ static int bcmgenet_suspend(struct device *d)
 
 	netif_device_detach(dev);
 
-	bcmgenet_netif_stop(dev);
+	bcmgenet_netif_stop(dev, true);
 
 	if (!device_may_wakeup(d))
 		phy_suspend(dev->phydev);
-- 
2.39.2



