Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BAE70375E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbjEORUX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244052AbjEORTu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:19:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79970120A3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59EDA62C17
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C67CC433EF;
        Mon, 15 May 2023 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171071;
        bh=3O8jAW2NdzBayoBjmJvoq9Fbi2XluQu9Ry6OYO+UMbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojKIJjeekELia3IgZtQj+fTEogerpZVFVHaE+hBBa9n85ZILFgwzuWFWgFeKIyJXu
         LdybKXObEoHoWi5pFARy14QZVcO5BZl6s+sHsfH9F4X8DsiT9HDgELmvh0zZ0WvMGa
         I35A3y69KeYgDGzwlUSXqwnqfPL2CQGLKu0aCf24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gagandeep Singh <g.singh@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 091/242] net: fec: correct the counting of XDP sent frames
Date:   Mon, 15 May 2023 18:26:57 +0200
Message-Id: <20230515161724.642152752@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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
index 2341597408d12..5fd3b41319827 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3737,7 +3737,8 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	entries_free = fec_enet_get_free_txdesc_num(txq);
 	if (entries_free < MAX_SKB_FRAGS + 1) {
 		netdev_err(fep->netdev, "NOT enough BD for SG!\n");
-		return NETDEV_TX_OK;
+		xdp_return_frame(frame);
+		return NETDEV_TX_BUSY;
 	}
 
 	/* Fill in a Tx ring entry */
@@ -3795,6 +3796,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	struct fec_enet_private *fep = netdev_priv(dev);
 	struct fec_enet_priv_tx_q *txq;
 	int cpu = smp_processor_id();
+	unsigned int sent_frames = 0;
 	struct netdev_queue *nq;
 	unsigned int queue;
 	int i;
@@ -3805,8 +3807,11 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 
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
@@ -3816,7 +3821,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 
 	__netif_tx_unlock(nq);
 
-	return num_frames;
+	return sent_frames;
 }
 
 static const struct net_device_ops fec_netdev_ops = {
-- 
2.39.2



