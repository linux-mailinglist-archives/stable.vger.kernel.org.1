Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34207034DA
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbjEOQxN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243194AbjEOQwz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9546580
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB08862993
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE020C433EF;
        Mon, 15 May 2023 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169553;
        bh=O+CynplPKCNbmRTMIr3ypQ3K0K06Rfi5LXHJnDF04k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIFtg0RRTMcn4V4Epcaka5q54ucefLxBTPyLTP9yfZyewSs5Na2jH4xJx2Kiis8w6
         vA645bMfjOcQ+luVJ9Z7j3ydVbBOMt79J7RopJaZJ7WQ89m/aaKR/aSZ1ZIfZRrAw1
         WpcdKfsrl0L2dkoc2RbgL98DNWrL5/OVc03UaeTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gagandeep Singh <g.singh@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 095/246] net: fec: correct the counting of XDP sent frames
Date:   Mon, 15 May 2023 18:25:07 +0200
Message-Id: <20230515161725.431338640@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shenwei Wang <shenwei.wang@nxp.com>

[ Upstream commit 26312c685ae0bca61e06ac75ee158b1e69546415 ]

In the current xdp_xmit implementation, if any single frame fails to
transmit due to insufficient buffer descriptors, the function nevertheless
reports success in sending all frames. This results in erroneously
indicating that frames were transmitted when in fact they were dropped.

This patch fixes the issue by ensureing the return value properly
indicates the actual number of frames successfully transmitted, rather than
potentially reporting success for all frames when some could not transmit.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 160c1b3525f5b..42ec6ca3bf035 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3798,7 +3798,8 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	entries_free = fec_enet_get_free_txdesc_num(txq);
 	if (entries_free < MAX_SKB_FRAGS + 1) {
 		netdev_err(fep->netdev, "NOT enough BD for SG!\n");
-		return NETDEV_TX_OK;
+		xdp_return_frame(frame);
+		return NETDEV_TX_BUSY;
 	}
 
 	/* Fill in a Tx ring entry */
@@ -3856,6 +3857,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	struct fec_enet_private *fep = netdev_priv(dev);
 	struct fec_enet_priv_tx_q *txq;
 	int cpu = smp_processor_id();
+	unsigned int sent_frames = 0;
 	struct netdev_queue *nq;
 	unsigned int queue;
 	int i;
@@ -3866,8 +3868,11 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 
 	__netif_tx_lock(nq, cpu);
 
-	for (i = 0; i < num_frames; i++)
-		fec_enet_txq_xmit_frame(fep, txq, frames[i]);
+	for (i = 0; i < num_frames; i++) {
+		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) != 0)
+			break;
+		sent_frames++;
+	}
 
 	/* Make sure the update to bdp and tx_skbuff are performed. */
 	wmb();
@@ -3877,7 +3882,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 
 	__netif_tx_unlock(nq);
 
-	return num_frames;
+	return sent_frames;
 }
 
 static const struct net_device_ops fec_netdev_ops = {
-- 
2.39.2



