Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3564F7CE647
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjJRSYH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 14:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjJRSYF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 14:24:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE84113
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 11:24:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7FDC433CB;
        Wed, 18 Oct 2023 18:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697653443;
        bh=sVVaA7qK6A1MF9I/eIxto2nwaRUVaUAUafSQEMrzHWU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RI3ZnzzhtoFKusIBwr/VslDUMaUBkWg/Avgof7QIE7W9NZvb8BT8tpbVOlvajYYgL
         hb4kafXQvUcXDh/AjYX/ax2UyuiRrCb/e+u8KB8kfDgFYMmGMqKU+ESsu7b8zvoDon
         /qgUBS+m08/d/O870whqig0ZgmhHOAL+WtzFIrkpU6D4EILB9pUyJMZbvTBgQL04I6
         YJxHI/rUB7EY32VVE96NX/xGIqPcS5xbkqYju1oogY0MIAL7sqh0xOU5xTgEy+XSSj
         IEoDrLaLrp2aRGbwRK87QplwU3OVDTmOhTMh9X8hG/7moBdk5tzS9WYBuyNxNHGvYT
         VhbKEUaylQzrQ==
From:   Mat Martineau <martineau@kernel.org>
Date:   Wed, 18 Oct 2023 11:23:54 -0700
Subject: [PATCH net 3/5] mptcp: more conservative check for zero probes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-send-net-20231018-v1-3-17ecb002e41d@kernel.org>
References: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
In-Reply-To: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
To:     Matthieu Baerts <matttbe@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

Christoph reported that the MPTCP protocol can find the subflow-level
write queue unexpectedly not empty while crafting a zero-window probe,
hitting a warning:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 188 at net/mptcp/protocol.c:1312 mptcp_sendmsg_frag+0xc06/0xe70
Modules linked in:
CPU: 0 PID: 188 Comm: kworker/0:2 Not tainted 6.6.0-rc2-g1176aa719d7a #47
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
Workqueue: events mptcp_worker
RIP: 0010:mptcp_sendmsg_frag+0xc06/0xe70 net/mptcp/protocol.c:1312
RAX: 47d0530de347ff6a RBX: 47d0530de347ff6b RCX: ffff8881015d3c00
RDX: ffff8881015d3c00 RSI: 47d0530de347ff6b RDI: 47d0530de347ff6b
RBP: 47d0530de347ff6b R08: ffffffff8243c6a8 R09: ffffffff82042d9c
R10: 0000000000000002 R11: ffffffff82056850 R12: ffff88812a13d580
R13: 0000000000000001 R14: ffff88812b375e50 R15: ffff88812bbf3200
FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000695118 CR3: 0000000115dfc001 CR4: 0000000000170ef0
Call Trace:
 <TASK>
 __subflow_push_pending+0xa4/0x420 net/mptcp/protocol.c:1545
 __mptcp_push_pending+0x128/0x3b0 net/mptcp/protocol.c:1614
 mptcp_release_cb+0x218/0x5b0 net/mptcp/protocol.c:3391
 release_sock+0xf6/0x100 net/core/sock.c:3521
 mptcp_worker+0x6e8/0x8f0 net/mptcp/protocol.c:2746
 process_scheduled_works+0x341/0x690 kernel/workqueue.c:2630
 worker_thread+0x3a7/0x610 kernel/workqueue.c:2784
 kthread+0x143/0x180 kernel/kthread.c:388
 ret_from_fork+0x4d/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304
 </TASK>

The root cause of the issue is that expectations are wrong: e.g. due
to MPTCP-level re-injection we can hit the critical condition.

Explicitly avoid the zero-window probe when the subflow write queue
is not empty and drop the related warnings.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/444
Fixes: f70cad1085d1 ("mptcp: stop relying on tcp_tx_skb_cache")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d1902373c974..4e30e5ba3795 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1298,7 +1298,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (copy == 0) {
 		u64 snd_una = READ_ONCE(msk->snd_una);
 
-		if (snd_una != msk->snd_nxt) {
+		if (snd_una != msk->snd_nxt || tcp_write_queue_tail(ssk)) {
 			tcp_remove_empty_skb(ssk);
 			return 0;
 		}
@@ -1306,11 +1306,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		zero_window_probe = true;
 		data_seq = snd_una - 1;
 		copy = 1;
-
-		/* all mptcp-level data is acked, no skbs should be present into the
-		 * ssk write queue
-		 */
-		WARN_ON_ONCE(reuse_skb);
 	}
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
@@ -1339,7 +1334,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (reuse_skb) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
 		mpext->data_len += copy;
-		WARN_ON_ONCE(zero_window_probe);
 		goto out;
 	}
 

-- 
2.41.0

