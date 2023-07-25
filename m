Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282976136F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjGYLKt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGYLKV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC651BF0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1358A61656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E20AC433C9;
        Tue, 25 Jul 2023 11:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283358;
        bh=rkFAPEoG2NQsx3d65VRXSfyXQcGkdYLNr+2c7wiTYVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5yJjhyiEhE1cKpZ/9snSxkiNKFSwVabsCCYxAOssjtM2wRgVMU0vkn60ZTzTQrcu
         8CyK2dgi15dWSWfa4DQxpFbhW4IyyuAM21O9MLPuj1wppmZNqfITif/1twIQ84vLzS
         6JrtIbBhSLYyy6wcfCadlpiaXJHnMmbZ/1ADQex8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Golle <daniel@makrotopia.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 47/78] net: ethernet: mtk_eth_soc: handle probe deferral
Date:   Tue, 25 Jul 2023 12:46:38 +0200
Message-ID: <20230725104453.100358749@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 1d6d537dc55d1f42d16290f00157ac387985b95b ]

Move the call to of_get_ethdev_address to mtk_add_mac which is part of
the probe function and can hence itself return -EPROBE_DEFER should
of_get_ethdev_address return -EPROBE_DEFER. This allows us to entirely
get rid of the mtk_init function.

The problem of of_get_ethdev_address returning -EPROBE_DEFER surfaced
in situations in which the NVMEM provider holding the MAC address has
not yet be loaded at the time mtk_eth_soc is initially probed. In this
case probing of mtk_eth_soc should be deferred instead of falling back
to use a random MAC address, so once the NVMEM provider becomes
available probing can be repeated.

Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 29 ++++++++-------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index c55ba1d085e5b..50ee9d3d4c841 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2612,23 +2612,6 @@ static int mtk_hw_deinit(struct mtk_eth *eth)
 	return 0;
 }
 
-static int __init mtk_init(struct net_device *dev)
-{
-	struct mtk_mac *mac = netdev_priv(dev);
-	struct mtk_eth *eth = mac->hw;
-	int ret;
-
-	ret = of_get_ethdev_address(mac->of_node, dev);
-	if (ret) {
-		/* If the mac address is invalid, use random mac address */
-		eth_hw_addr_random(dev);
-		dev_err(eth->dev, "generated random MAC address %pM\n",
-			dev->dev_addr);
-	}
-
-	return 0;
-}
-
 static void mtk_uninit(struct net_device *dev)
 {
 	struct mtk_mac *mac = netdev_priv(dev);
@@ -2956,7 +2939,6 @@ static const struct ethtool_ops mtk_ethtool_ops = {
 };
 
 static const struct net_device_ops mtk_netdev_ops = {
-	.ndo_init		= mtk_init,
 	.ndo_uninit		= mtk_uninit,
 	.ndo_open		= mtk_open,
 	.ndo_stop		= mtk_stop,
@@ -3010,6 +2992,17 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	mac->hw = eth;
 	mac->of_node = np;
 
+	err = of_get_ethdev_address(mac->of_node, eth->netdev[id]);
+	if (err == -EPROBE_DEFER)
+		return err;
+
+	if (err) {
+		/* If the mac address is invalid, use random mac address */
+		eth_hw_addr_random(eth->netdev[id]);
+		dev_err(eth->dev, "generated random MAC address %pM\n",
+			eth->netdev[id]->dev_addr);
+	}
+
 	memset(mac->hwlro_ip, 0, sizeof(mac->hwlro_ip));
 	mac->hwlro_ip_cnt = 0;
 
-- 
2.39.2



