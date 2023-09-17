Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074367A39CE
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbjIQTyl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbjIQTyW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:54:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90FAEE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:54:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1B0C433C8;
        Sun, 17 Sep 2023 19:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980457;
        bh=S0zqokmRPlr3UoQkRLDvQt+xA6D03M85IfXHQl7w7ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v5uhT6DkeN8Cd1MfQZLL3NWDoJ/1/WTyciio8OQ05jeskgOLS0i/xDcIgfrgZkT5e
         xMgdLLJcMTcU6j1X7mo47i4CnEufyMIQl3F1xes6kdnKLbsgd0Ij1BryoBnxlEyLjA
         2FC17H+nQ7ZYpUJz4MiEEqmeRukxkEJScIC9F5DU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jian Shen <shenjian15@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 167/285] net: hns3: fix tx timeout issue
Date:   Sun, 17 Sep 2023 21:12:47 +0200
Message-ID: <20230917191057.431684481@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit 61a1deacc3d4fd3d57d7fda4d935f7f7503e8440 ]

Currently, the driver knocks the ring doorbell before updating
the ring->last_to_use in tx flow. if the hardware transmiting
packet and napi poll scheduling are fast enough, it may get
the old ring->last_to_use in drivers' napi poll.
In this case, the driver will think the tx is not completed, and
return directly without clear the flag __QUEUE_STATE_STACK_XOFF,
which may cause tx timeout.

Fixes: 20d06ca2679c ("net: hns3: optimize the tx clean process")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b7b51e56b0308..71772213b4448 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2102,8 +2102,12 @@ static void hns3_tx_doorbell(struct hns3_enet_ring *ring, int num,
 	 */
 	if (test_bit(HNS3_NIC_STATE_TX_PUSH_ENABLE, &priv->state) && num &&
 	    !ring->pending_buf && num <= HNS3_MAX_PUSH_BD_NUM && doorbell) {
+		/* This smp_store_release() pairs with smp_load_aquire() in
+		 * hns3_nic_reclaim_desc(). Ensure that the BD valid bit
+		 * is updated.
+		 */
+		smp_store_release(&ring->last_to_use, ring->next_to_use);
 		hns3_tx_push_bd(ring, num);
-		WRITE_ONCE(ring->last_to_use, ring->next_to_use);
 		return;
 	}
 
@@ -2114,6 +2118,11 @@ static void hns3_tx_doorbell(struct hns3_enet_ring *ring, int num,
 		return;
 	}
 
+	/* This smp_store_release() pairs with smp_load_aquire() in
+	 * hns3_nic_reclaim_desc(). Ensure that the BD valid bit is updated.
+	 */
+	smp_store_release(&ring->last_to_use, ring->next_to_use);
+
 	if (ring->tqp->mem_base)
 		hns3_tx_mem_doorbell(ring);
 	else
@@ -2121,7 +2130,6 @@ static void hns3_tx_doorbell(struct hns3_enet_ring *ring, int num,
 		       ring->tqp->io_base + HNS3_RING_TX_RING_TAIL_REG);
 
 	ring->pending_buf = 0;
-	WRITE_ONCE(ring->last_to_use, ring->next_to_use);
 }
 
 static void hns3_tsyn(struct net_device *netdev, struct sk_buff *skb,
@@ -3562,9 +3570,8 @@ static void hns3_reuse_buffer(struct hns3_enet_ring *ring, int i)
 static bool hns3_nic_reclaim_desc(struct hns3_enet_ring *ring,
 				  int *bytes, int *pkts, int budget)
 {
-	/* pair with ring->last_to_use update in hns3_tx_doorbell(),
-	 * smp_store_release() is not used in hns3_tx_doorbell() because
-	 * the doorbell operation already have the needed barrier operation.
+	/* This smp_load_acquire() pairs with smp_store_release() in
+	 * hns3_tx_doorbell().
 	 */
 	int ltu = smp_load_acquire(&ring->last_to_use);
 	int ntc = ring->next_to_clean;
-- 
2.40.1



