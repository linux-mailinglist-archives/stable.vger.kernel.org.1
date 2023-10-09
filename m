Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9197BDEB2
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376381AbjJINWH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376383AbjJINWH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:22:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B748F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:22:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5999CC433C8;
        Mon,  9 Oct 2023 13:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857725;
        bh=sGH/67FV1O1bHQfIyIlCve0vpbnjAls8V4P0zKasMJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLw2g9cb07TY5KOsRJI8I6pDAvXSu66nNfNzY1Zi+H8a9xF0ezveGfVmvXhaqeu0F
         3WSFC5az8sUTdb1cvp2AWCu/4tRF9llQNlx9rqrOIrWT1RotLrQ7ENykt63dyg9lEC
         wnqV+jSXwl5+EhTUxAum7muPNocQ6GMi8WZxfw2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 110/162] neighbour: fix data-races around n->output
Date:   Mon,  9 Oct 2023 15:01:31 +0200
Message-ID: <20231009130125.963150186@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5baa0433a15eadd729625004c37463acb982eca7 ]

n->output field can be read locklessly, while a writer
might change the pointer concurrently.

Add missing annotations to prevent load-store tearing.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/neighbour.h         |  2 +-
 net/bridge/br_netfilter_hooks.c |  2 +-
 net/core/neighbour.c            | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index f6a8ecc6b1fa7..ccc4a0f8b4ad8 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -541,7 +541,7 @@ static inline int neigh_output(struct neighbour *n, struct sk_buff *skb,
 	    READ_ONCE(hh->hh_len))
 		return neigh_hh_output(hh, skb);
 
-	return n->output(n, skb);
+	return READ_ONCE(n->output)(n, skb);
 }
 
 static inline struct neighbour *
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 442198cb83909..01d690d9fe5f8 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -294,7 +294,7 @@ int br_nf_pre_routing_finish_bridge(struct net *net, struct sock *sk, struct sk_
 			/* tell br_dev_xmit to continue with forwarding */
 			nf_bridge->bridged_dnat = 1;
 			/* FIXME Need to refragment */
-			ret = neigh->output(neigh, skb);
+			ret = READ_ONCE(neigh->output)(neigh, skb);
 		}
 		neigh_release(neigh);
 		return ret;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index bafd72e5f5886..b20c9768d9f3f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -410,7 +410,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 				 */
 				__skb_queue_purge(&n->arp_queue);
 				n->arp_queue_len_bytes = 0;
-				n->output = neigh_blackhole;
+				WRITE_ONCE(n->output, neigh_blackhole);
 				if (n->nud_state & NUD_VALID)
 					n->nud_state = NUD_NOARP;
 				else
@@ -920,7 +920,7 @@ static void neigh_suspect(struct neighbour *neigh)
 {
 	neigh_dbg(2, "neigh %p is suspected\n", neigh);
 
-	neigh->output = neigh->ops->output;
+	WRITE_ONCE(neigh->output, neigh->ops->output);
 }
 
 /* Neighbour state is OK;
@@ -932,7 +932,7 @@ static void neigh_connect(struct neighbour *neigh)
 {
 	neigh_dbg(2, "neigh %p is connected\n", neigh);
 
-	neigh->output = neigh->ops->connected_output;
+	WRITE_ONCE(neigh->output, neigh->ops->connected_output);
 }
 
 static void neigh_periodic_work(struct work_struct *work)
@@ -1449,7 +1449,7 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 				if (n2)
 					n1 = n2;
 			}
-			n1->output(n1, skb);
+			READ_ONCE(n1->output)(n1, skb);
 			if (n2)
 				neigh_release(n2);
 			rcu_read_unlock();
@@ -3145,7 +3145,7 @@ int neigh_xmit(int index, struct net_device *dev,
 			rcu_read_unlock();
 			goto out_kfree_skb;
 		}
-		err = neigh->output(neigh, skb);
+		err = READ_ONCE(neigh->output)(neigh, skb);
 		rcu_read_unlock();
 	}
 	else if (index == NEIGH_LINK_TABLE) {
-- 
2.40.1



