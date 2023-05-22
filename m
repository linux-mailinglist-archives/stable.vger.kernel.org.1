Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE170C67F
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjEVTSs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbjEVTSm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD24B0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A5E1627E3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36244C433EF;
        Mon, 22 May 2023 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783120;
        bh=pMMrNnYs3zUgBbEfFXHioYtSSevmoQXu7U0OElNbjM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AStp1Ix5A+dnoKtyuzLUIGVuGmduX+VGWXsWyo0OsKmpUN+LqPnn0JCRvo8ed9TOt
         mzcNRfmzC0GrmEaU52tNfZ2L3sZ7O/iYHVBhdjHi/iFbXOvmCjpcF6Xd33JmICtwhC
         hN7Pq156ZqxZW9OqzMXxJkF2gdgGHXjJYhU35Jdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shuang Li <shuali@redhat.com>,
        Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 145/203] tipc: do not update mtu if msg_max is too small in mtu negotiation
Date:   Mon, 22 May 2023 20:09:29 +0100
Message-Id: <20230522190358.981009437@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 56077b56cd3fb78e1c8619e29581ba25a5c55e86 ]

When doing link mtu negotiation, a malicious peer may send Activate msg
with a very small mtu, e.g. 4 in Shuang's testing, without checking for
the minimum mtu, l->mtu will be set to 4 in tipc_link_proto_rcv(), then
n->links[bearer_id].mtu is set to 4294967228, which is a overflow of
'4 - INT_H_SIZE - EMSG_OVERHEAD' in tipc_link_mss().

With tipc_link.mtu = 4, tipc_link_xmit() kept printing the warning:

 tipc: Too large msg, purging xmit list 1 5 0 40 4!
 tipc: Too large msg, purging xmit list 1 15 0 60 4!

And with tipc_link_entry.mtu 4294967228, a huge skb was allocated in
named_distribute(), and when purging it in tipc_link_xmit(), a crash
was even caused:

  general protection fault, probably for non-canonical address 0x2100001011000dd: 0000 [#1] PREEMPT SMP PTI
  CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 6.3.0.neta #19
  RIP: 0010:kfree_skb_list_reason+0x7e/0x1f0
  Call Trace:
   <IRQ>
   skb_release_data+0xf9/0x1d0
   kfree_skb_reason+0x40/0x100
   tipc_link_xmit+0x57a/0x740 [tipc]
   tipc_node_xmit+0x16c/0x5c0 [tipc]
   tipc_named_node_up+0x27f/0x2c0 [tipc]
   tipc_node_write_unlock+0x149/0x170 [tipc]
   tipc_rcv+0x608/0x740 [tipc]
   tipc_udp_recv+0xdc/0x1f0 [tipc]
   udp_queue_rcv_one_skb+0x33e/0x620
   udp_unicast_rcv_skb.isra.72+0x75/0x90
   __udp4_lib_rcv+0x56d/0xc20
   ip_protocol_deliver_rcu+0x100/0x2d0

This patch fixes it by checking the new mtu against tipc_bearer_min_mtu(),
and not updating mtu if it is too small.

Fixes: ed193ece2649 ("tipc: simplify link mtu negotiation")
Reported-by: Shuang Li <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Jon Maloy <jmaloy@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/link.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 8fdd3b23bd123..655a2e1b6dfe4 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -2199,7 +2199,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 	struct tipc_msg *hdr = buf_msg(skb);
 	struct tipc_gap_ack_blks *ga = NULL;
 	bool reply = msg_probe(hdr), retransmitted = false;
-	u32 dlen = msg_data_sz(hdr), glen = 0;
+	u32 dlen = msg_data_sz(hdr), glen = 0, msg_max;
 	u16 peers_snd_nxt =  msg_next_sent(hdr);
 	u16 peers_tol = msg_link_tolerance(hdr);
 	u16 peers_prio = msg_linkprio(hdr);
@@ -2238,6 +2238,9 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 	switch (mtyp) {
 	case RESET_MSG:
 	case ACTIVATE_MSG:
+		msg_max = msg_max_pkt(hdr);
+		if (msg_max < tipc_bearer_min_mtu(l->net, l->bearer_id))
+			break;
 		/* Complete own link name with peer's interface name */
 		if_name =  strrchr(l->name, ':') + 1;
 		if (sizeof(l->name) - (if_name - l->name) <= TIPC_MAX_IF_NAME)
@@ -2282,8 +2285,8 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 		l->peer_session = msg_session(hdr);
 		l->in_session = true;
 		l->peer_bearer_id = msg_bearer_id(hdr);
-		if (l->mtu > msg_max_pkt(hdr))
-			l->mtu = msg_max_pkt(hdr);
+		if (l->mtu > msg_max)
+			l->mtu = msg_max;
 		break;
 
 	case STATE_MSG:
-- 
2.39.2



