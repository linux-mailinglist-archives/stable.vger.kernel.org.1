Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FF775CDBC
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjGUQOC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGUQNr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8219E3ABB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:13:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC2C61D33
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72423C433C7;
        Fri, 21 Jul 2023 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955998;
        bh=neAPo5fNJGPPDfPd10rkT8VOueG2X9zldENTHLY2l4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQjt5bCbd02u+6iWw5zatJhRTQhrDBMu6Ycz8l92dIfYKU5ZDH4tZTcmwe6coUvub
         TuyLAtvSBUQzh0F9VNfx399Z5Fw83f2Usy7FREistComqHweY4MQz8j6/AzGYh+G/N
         mh9VrFw/jmuXBBJeb8htD2TbGKPlif4seEoQaDdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Fang <wei.fang@nxp.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 081/292] net: fec: remove useless fec_enet_reset_skb()
Date:   Fri, 21 Jul 2023 18:03:10 +0200
Message-ID: <20230721160532.287049347@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit 2ae9c66b04554bf5b3eeaab8c12a0bfb9f28ebde ]

This patch is a cleanup for fec driver. The fec_enet_reset_skb()
is used to free skb buffers for tx queues and is only invoked in
fec_restart(). However, fec_enet_bd_init() also resets skb buffers
and is invoked in fec_restart() too. So fec_enet_reset_skb() is
redundant and useless.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 20f797399035 ("net: fec: recycle pages for transmitted XDP frames")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 38e5b5abe067c..c08331f7da7b3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1011,24 +1011,6 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	}
 }
 
-static void fec_enet_reset_skb(struct net_device *ndev)
-{
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_tx_q *txq;
-	int i, j;
-
-	for (i = 0; i < fep->num_tx_queues; i++) {
-		txq = fep->tx_queue[i];
-
-		for (j = 0; j < txq->bd.ring_size; j++) {
-			if (txq->tx_skbuff[j]) {
-				dev_kfree_skb_any(txq->tx_skbuff[j]);
-				txq->tx_skbuff[j] = NULL;
-			}
-		}
-	}
-}
-
 /*
  * This function is called to start or restart the FEC during a link
  * change, transmit timeout, or to reconfigure the FEC.  The network
@@ -1071,9 +1053,6 @@ fec_restart(struct net_device *ndev)
 
 	fec_enet_enable_ring(ndev);
 
-	/* Reset tx SKB buffers. */
-	fec_enet_reset_skb(ndev);
-
 	/* Enable MII mode */
 	if (fep->full_duplex == DUPLEX_FULL) {
 		/* FD enable */
-- 
2.39.2



