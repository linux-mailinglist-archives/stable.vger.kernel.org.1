Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430BD7612F2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjGYLGr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjGYLG3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61046A4
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59E5C6164D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6827AC433C7;
        Tue, 25 Jul 2023 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283088;
        bh=L0wQ3DSFqrOYj94fjWj6PKzHw8pA5Xg63x+YvbaHYU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nueRnw26YmfKaI2d/+pSMWdTdH8OIiW04XoBqfs6i1uNyZZQZ3CVfPBGtZyfmIJu3
         1OWpqXDbI3iHWgJe51HUjKXJm721K2IKOh13pToaMtLDZ6SJbKVNiKUH258oe+t9rB
         JLwM2P7Rs2zEv5E/lOzutuJfJM++Z2mFNYkLWFiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 135/183] tcp: annotate data-races around tcp_rsk(req)->txhash
Date:   Tue, 25 Jul 2023 12:46:03 +0200
Message-ID: <20230725104512.791155706@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5e5265522a9a7f91d1b0bd411d634bdaf16c80cd ]

TCP request sockets are lockless, some of their fields
can change while being read by another cpu as syzbot noticed.

This is usually harmless, but we should annotate the known
races.

This patch takes care of tcp_rsk(req)->txhash,
a separate one is needed for tcp_rsk(req)->ts_recent.

BUG: KCSAN: data-race in tcp_make_synack / tcp_rtx_synack

write to 0xffff8881362304bc of 4 bytes by task 32083 on cpu 1:
tcp_rtx_synack+0x9d/0x2a0 net/ipv4/tcp_output.c:4213
inet_rtx_syn_ack+0x38/0x80 net/ipv4/inet_connection_sock.c:880
tcp_check_req+0x379/0xc70 net/ipv4/tcp_minisocks.c:665
tcp_v6_rcv+0x125b/0x1b20 net/ipv6/tcp_ipv6.c:1673
ip6_protocol_deliver_rcu+0x92f/0xf30 net/ipv6/ip6_input.c:437
ip6_input_finish net/ipv6/ip6_input.c:482 [inline]
NF_HOOK include/linux/netfilter.h:303 [inline]
ip6_input+0xbd/0x1b0 net/ipv6/ip6_input.c:491
dst_input include/net/dst.h:468 [inline]
ip6_rcv_finish+0x1e2/0x2e0 net/ipv6/ip6_input.c:79
NF_HOOK include/linux/netfilter.h:303 [inline]
ipv6_rcv+0x74/0x150 net/ipv6/ip6_input.c:309
__netif_receive_skb_one_core net/core/dev.c:5452 [inline]
__netif_receive_skb+0x90/0x1b0 net/core/dev.c:5566
netif_receive_skb_internal net/core/dev.c:5652 [inline]
netif_receive_skb+0x4a/0x310 net/core/dev.c:5711
tun_rx_batched+0x3bf/0x400
tun_get_user+0x1d24/0x22b0 drivers/net/tun.c:1997
tun_chr_write_iter+0x18e/0x240 drivers/net/tun.c:2043
call_write_iter include/linux/fs.h:1871 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x4ab/0x7d0 fs/read_write.c:584
ksys_write+0xeb/0x1a0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x42/0x50 fs/read_write.c:646
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff8881362304bc of 4 bytes by task 32078 on cpu 0:
tcp_make_synack+0x367/0xb40 net/ipv4/tcp_output.c:3663
tcp_v6_send_synack+0x72/0x420 net/ipv6/tcp_ipv6.c:544
tcp_conn_request+0x11a8/0x1560 net/ipv4/tcp_input.c:7059
tcp_v6_conn_request+0x13f/0x180 net/ipv6/tcp_ipv6.c:1175
tcp_rcv_state_process+0x156/0x1de0 net/ipv4/tcp_input.c:6494
tcp_v6_do_rcv+0x98a/0xb70 net/ipv6/tcp_ipv6.c:1509
tcp_v6_rcv+0x17b8/0x1b20 net/ipv6/tcp_ipv6.c:1735
ip6_protocol_deliver_rcu+0x92f/0xf30 net/ipv6/ip6_input.c:437
ip6_input_finish net/ipv6/ip6_input.c:482 [inline]
NF_HOOK include/linux/netfilter.h:303 [inline]
ip6_input+0xbd/0x1b0 net/ipv6/ip6_input.c:491
dst_input include/net/dst.h:468 [inline]
ip6_rcv_finish+0x1e2/0x2e0 net/ipv6/ip6_input.c:79
NF_HOOK include/linux/netfilter.h:303 [inline]
ipv6_rcv+0x74/0x150 net/ipv6/ip6_input.c:309
__netif_receive_skb_one_core net/core/dev.c:5452 [inline]
__netif_receive_skb+0x90/0x1b0 net/core/dev.c:5566
netif_receive_skb_internal net/core/dev.c:5652 [inline]
netif_receive_skb+0x4a/0x310 net/core/dev.c:5711
tun_rx_batched+0x3bf/0x400
tun_get_user+0x1d24/0x22b0 drivers/net/tun.c:1997
tun_chr_write_iter+0x18e/0x240 drivers/net/tun.c:2043
call_write_iter include/linux/fs.h:1871 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x4ab/0x7d0 fs/read_write.c:584
ksys_write+0xeb/0x1a0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x42/0x50 fs/read_write.c:646
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x91d25731 -> 0xe79325cd

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 32078 Comm: syz-executor.4 Not tainted 6.5.0-rc1-syzkaller-00033-geb26cbb1a754 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023

Fixes: 58d607d3e52f ("tcp: provide skb->hash to synack packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230717144445.653164-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c      | 3 ++-
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 4 ++--
 net/ipv6/tcp_ipv6.c      | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ef740983a1222..e5df50b3e23a0 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -992,7 +992,8 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			0,
 			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			ip_hdr(skb)->tos, tcp_rsk(req)->txhash);
+			ip_hdr(skb)->tos,
+			READ_ONCE(tcp_rsk(req)->txhash));
 }
 
 /*
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7f37e7da64671..f281eab7fd125 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -510,7 +510,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newicsk->icsk_ack.lrcvtime = tcp_jiffies32;
 
 	newtp->lsndtime = tcp_jiffies32;
-	newsk->sk_txhash = treq->txhash;
+	newsk->sk_txhash = READ_ONCE(treq->txhash);
 	newtp->total_retrans = req->num_retrans;
 
 	tcp_init_xmit_timers(newsk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 925594dbeb929..693a29d3f43bd 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3581,7 +3581,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	rcu_read_lock();
 	md5 = tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
 #endif
-	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
+	skb_set_hash(skb, READ_ONCE(tcp_rsk(req)->txhash), PKT_HASH_TYPE_L4);
 	/* bpf program will be interested in the tcp_flags */
 	TCP_SKB_CB(skb)->tcp_flags = TCPHDR_SYN | TCPHDR_ACK;
 	tcp_header_size = tcp_synack_options(sk, req, mss, skb, &opts, md5,
@@ -4124,7 +4124,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
-		tcp_rsk(req)->txhash = net_tx_rndhash();
+		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
 	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
 				  NULL);
 	if (!res) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8d61efeab9c99..0dcb06a1fe044 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1133,7 +1133,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			req->ts_recent, sk->sk_bound_dev_if,
 			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
 			ipv6_get_dsfield(ipv6_hdr(skb)), 0, sk->sk_priority,
-			tcp_rsk(req)->txhash);
+			READ_ONCE(tcp_rsk(req)->txhash));
 }
 
 
-- 
2.39.2



