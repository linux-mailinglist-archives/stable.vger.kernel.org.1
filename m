Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987C1735388
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjFSKq0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjFSKpz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:45:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E626E70
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C220560B86
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CA8C433C8;
        Mon, 19 Jun 2023 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171534;
        bh=xIhpgfWCylMW1Cmv87dSXbgtERI9Ge5C8OTZjOElVwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c8t3MGeASbRfQ2rdrZi/ZMRPEirVu6bYqQGq5mL8mjcZ/G4RRIM/VeM74yb4O3M8b
         5+D0vbH9lFp75zjdleg45V/uIkldMYJTTxbcpN2ie9Mtqrh9XqdmllLNgFBbQzlSDp
         QqfRAhn33YZDgXnAOoCD6T8ZE/trKMuR7+JCk20o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jose Abreu <Jose.Abreu@synopsys.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 066/166] net: ethernet: stmicro: stmmac: fix possible memory leak in __stmmac_open
Date:   Mon, 19 Jun 2023 12:29:03 +0200
Message-ID: <20230619102157.989868740@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Christian Marangi <ansuelsmth@gmail.com>

commit 30134b7c47bd28fdb4db4d12aef824e0579cfee4 upstream.

Fix a possible memory leak in __stmmac_open when stmmac_init_phy fails.
It's also needed to free everything allocated by stmmac_setup_dma_desc
and not just the dma_conf struct.

Drop free_dma_desc_resources from __stmmac_open and correctly call
free_dma_desc_resources on each user of __stmmac_open on error.

Reported-by: Jose Abreu <Jose.Abreu@synopsys.com>
Fixes: ba39b344e924 ("net: ethernet: stmicro: stmmac: generate stmmac dma conf before open")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Jose Abreu <Jose.Abreu@synopsys.com>
Link: https://lore.kernel.org/r/20230614091714.15912-1-ansuelsmth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3865,7 +3865,6 @@ irq_error:
 
 	stmmac_hw_teardown(dev);
 init_error:
-	free_dma_desc_resources(priv, &priv->dma_conf);
 	phylink_disconnect_phy(priv->phylink);
 init_phy_error:
 	pm_runtime_put(priv->device);
@@ -3883,6 +3882,9 @@ static int stmmac_open(struct net_device
 		return PTR_ERR(dma_conf);
 
 	ret = __stmmac_open(dev, dma_conf);
+	if (ret)
+		free_dma_desc_resources(priv, dma_conf);
+
 	kfree(dma_conf);
 	return ret;
 }
@@ -5607,12 +5609,15 @@ static int stmmac_change_mtu(struct net_
 		stmmac_release(dev);
 
 		ret = __stmmac_open(dev, dma_conf);
-		kfree(dma_conf);
 		if (ret) {
+			free_dma_desc_resources(priv, dma_conf);
+			kfree(dma_conf);
 			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
 			return ret;
 		}
 
+		kfree(dma_conf);
+
 		stmmac_set_rx_mode(dev);
 	}
 


