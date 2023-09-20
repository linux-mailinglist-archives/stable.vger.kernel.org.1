Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325F67A7E72
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjITMSC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjITMSB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:18:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EBE185
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:17:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E6AC43395;
        Wed, 20 Sep 2023 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212263;
        bh=v+DspCEOn3/xtlJIMq48jJAhh0klkx4wQB1BLdp+USA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAxOpvD4iYK3E9ZRK7wTRwBzSijpz6aIylmf6pnrzAmauBj5ABihiPSm7KjJDlWwX
         DjBW3EKO8Olv8ulDrbtavIn3OU8il0HUxy8IER+gbhXSI+o0ld/cjoFrvRCKNyfFDs
         RlZv59Nhp4KNayh8tVcYhow4bMQvoB6N8ZfZqOIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liang Chen <liangchen.linux@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 212/273] veth: Fixing transmit return status for dropped packets
Date:   Wed, 20 Sep 2023 13:30:52 +0200
Message-ID: <20230920112853.016576849@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liang Chen <liangchen.linux@gmail.com>

[ Upstream commit 151e887d8ff97e2e42110ffa1fb1e6a2128fb364 ]

The veth_xmit function returns NETDEV_TX_OK even when packets are dropped.
This behavior leads to incorrect calculations of statistics counts, as
well as things like txq->trans_start updates.

Fixes: e314dbdc1c0d ("[NET]: Virtual ethernet device driver.")
Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/veth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index ea999a6639330..8006a7716168f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -181,6 +181,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
 	struct veth_rq *rq = NULL;
+	int ret = NETDEV_TX_OK;
 	struct net_device *rcv;
 	int length = skb->len;
 	bool rcv_xdp = false;
@@ -210,6 +211,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 drop:
 		atomic64_inc(&priv->dropped);
+		ret = NET_XMIT_DROP;
 	}
 
 	if (rcv_xdp)
@@ -217,7 +219,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	rcu_read_unlock();
 
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static u64 veth_stats_one(struct pcpu_vstats *result, struct net_device *dev)
-- 
2.40.1



