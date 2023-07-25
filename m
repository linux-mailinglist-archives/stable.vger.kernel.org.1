Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9577A7612F1
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjGYLGq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjGYLG3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A146AF
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 148FF61656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29450C433C7;
        Tue, 25 Jul 2023 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283091;
        bh=yKDZSjGttAMGNcMkQMseXjFpn+bgnbDsLyx3kfhe30A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vMsp1066pDJlKIdo/uO8ExDyB/+3fR1Q9Q4FvBCh2kATj8lpaf+h6nDvMJHRN0GyR
         btjzYO+/o3kMDMYF/3c8aRw4LRhnB8e8X8dzq8Kc/aXc1NWAInLcuf0s8nv4UOAsdD
         14m3ZRwsGDiZj+ClW3S6zQ01vAtT/jiR7KgW0gJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 136/183] tcp: annotate data-races around tcp_rsk(req)->ts_recent
Date:   Tue, 25 Jul 2023 12:46:04 +0200
Message-ID: <20230725104512.821115628@linuxfoundation.org>
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

[ Upstream commit eba20811f32652bc1a52d5e7cc403859b86390d9 ]

TCP request sockets are lockless, tcp_rsk(req)->ts_recent
can change while being read by another cpu as syzbot noticed.

This is harmless, but we should annotate the known races.

Note that tcp_check_req() changes req->ts_recent a bit early,
we might change this in the future.

BUG: KCSAN: data-race in tcp_check_req / tcp_check_req

write to 0xffff88813c8afb84 of 4 bytes by interrupt on cpu 1:
tcp_check_req+0x694/0xc70 net/ipv4/tcp_minisocks.c:762
tcp_v4_rcv+0x12db/0x1b70 net/ipv4/tcp_ipv4.c:2071
ip_protocol_deliver_rcu+0x356/0x6d0 net/ipv4/ip_input.c:205
ip_local_deliver_finish+0x13c/0x1a0 net/ipv4/ip_input.c:233
NF_HOOK include/linux/netfilter.h:303 [inline]
ip_local_deliver+0xec/0x1c0 net/ipv4/ip_input.c:254
dst_input include/net/dst.h:468 [inline]
ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
NF_HOOK include/linux/netfilter.h:303 [inline]
ip_rcv+0x197/0x270 net/ipv4/ip_input.c:569
__netif_receive_skb_one_core net/core/dev.c:5493 [inline]
__netif_receive_skb+0x90/0x1b0 net/core/dev.c:5607
process_backlog+0x21f/0x380 net/core/dev.c:5935
__napi_poll+0x60/0x3b0 net/core/dev.c:6498
napi_poll net/core/dev.c:6565 [inline]
net_rx_action+0x32b/0x750 net/core/dev.c:6698
__do_softirq+0xc1/0x265 kernel/softirq.c:571
do_softirq+0x7e/0xb0 kernel/softirq.c:472
__local_bh_enable_ip+0x64/0x70 kernel/softirq.c:396
local_bh_enable+0x1f/0x20 include/linux/bottom_half.h:33
rcu_read_unlock_bh include/linux/rcupdate.h:843 [inline]
__dev_queue_xmit+0xabb/0x1d10 net/core/dev.c:4271
dev_queue_xmit include/linux/netdevice.h:3088 [inline]
neigh_hh_output include/net/neighbour.h:528 [inline]
neigh_output include/net/neighbour.h:542 [inline]
ip_finish_output2+0x700/0x840 net/ipv4/ip_output.c:229
ip_finish_output+0xf4/0x240 net/ipv4/ip_output.c:317
NF_HOOK_COND include/linux/netfilter.h:292 [inline]
ip_output+0xe5/0x1b0 net/ipv4/ip_output.c:431
dst_output include/net/dst.h:458 [inline]
ip_local_out net/ipv4/ip_output.c:126 [inline]
__ip_queue_xmit+0xa4d/0xa70 net/ipv4/ip_output.c:533
ip_queue_xmit+0x38/0x40 net/ipv4/ip_output.c:547
__tcp_transmit_skb+0x1194/0x16e0 net/ipv4/tcp_output.c:1399
tcp_transmit_skb net/ipv4/tcp_output.c:1417 [inline]
tcp_write_xmit+0x13ff/0x2fd0 net/ipv4/tcp_output.c:2693
__tcp_push_pending_frames+0x6a/0x1a0 net/ipv4/tcp_output.c:2877
tcp_push_pending_frames include/net/tcp.h:1952 [inline]
__tcp_sock_set_cork net/ipv4/tcp.c:3336 [inline]
tcp_sock_set_cork+0xe8/0x100 net/ipv4/tcp.c:3343
rds_tcp_xmit_path_complete+0x3b/0x40 net/rds/tcp_send.c:52
rds_send_xmit+0xf8d/0x1420 net/rds/send.c:422
rds_send_worker+0x42/0x1d0 net/rds/threads.c:200
process_one_work+0x3e6/0x750 kernel/workqueue.c:2408
worker_thread+0x5f2/0xa10 kernel/workqueue.c:2555
kthread+0x1d7/0x210 kernel/kthread.c:379
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

read to 0xffff88813c8afb84 of 4 bytes by interrupt on cpu 0:
tcp_check_req+0x32a/0xc70 net/ipv4/tcp_minisocks.c:622
tcp_v4_rcv+0x12db/0x1b70 net/ipv4/tcp_ipv4.c:2071
ip_protocol_deliver_rcu+0x356/0x6d0 net/ipv4/ip_input.c:205
ip_local_deliver_finish+0x13c/0x1a0 net/ipv4/ip_input.c:233
NF_HOOK include/linux/netfilter.h:303 [inline]
ip_local_deliver+0xec/0x1c0 net/ipv4/ip_input.c:254
dst_input include/net/dst.h:468 [inline]
ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
NF_HOOK include/linux/netfilter.h:303 [inline]
ip_rcv+0x197/0x270 net/ipv4/ip_input.c:569
__netif_receive_skb_one_core net/core/dev.c:5493 [inline]
__netif_receive_skb+0x90/0x1b0 net/core/dev.c:5607
process_backlog+0x21f/0x380 net/core/dev.c:5935
__napi_poll+0x60/0x3b0 net/core/dev.c:6498
napi_poll net/core/dev.c:6565 [inline]
net_rx_action+0x32b/0x750 net/core/dev.c:6698
__do_softirq+0xc1/0x265 kernel/softirq.c:571
run_ksoftirqd+0x17/0x20 kernel/softirq.c:939
smpboot_thread_fn+0x30a/0x4a0 kernel/smpboot.c:164
kthread+0x1d7/0x210 kernel/kthread.c:379
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

value changed: 0x1cd237f1 -> 0x1cd237f2

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230717144445.653164-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c      | 2 +-
 net/ipv4/tcp_minisocks.c | 9 ++++++---
 net/ipv4/tcp_output.c    | 2 +-
 net/ipv6/tcp_ipv6.c      | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index e5df50b3e23a0..d49a66b271d52 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -988,7 +988,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
-			req->ts_recent,
+			READ_ONCE(req->ts_recent),
 			0,
 			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f281eab7fd125..42844d20da020 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -537,7 +537,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->max_window = newtp->snd_wnd;
 
 	if (newtp->rx_opt.tstamp_ok) {
-		newtp->rx_opt.ts_recent = req->ts_recent;
+		newtp->rx_opt.ts_recent = READ_ONCE(req->ts_recent);
 		newtp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 		newtp->tcp_header_len = sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
 	} else {
@@ -601,7 +601,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
 		if (tmp_opt.saw_tstamp) {
-			tmp_opt.ts_recent = req->ts_recent;
+			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
 			if (tmp_opt.rcv_tsecr)
 				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
 			/* We do not store true stamp, but it is not required,
@@ -740,8 +740,11 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 	/* In sequence, PAWS is OK. */
 
+	/* TODO: We probably should defer ts_recent change once
+	 * we take ownership of @req.
+	 */
 	if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
-		req->ts_recent = tmp_opt.rcv_tsval;
+		WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
 
 	if (TCP_SKB_CB(skb)->seq == tcp_rsk(req)->rcv_isn) {
 		/* Truncate SYN, it is out of window starting
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 693a29d3f43bd..26bd039f9296f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -876,7 +876,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	if (likely(ireq->tstamp_ok)) {
 		opts->options |= OPTION_TS;
 		opts->tsval = tcp_skb_timestamp(skb) + tcp_rsk(req)->ts_off;
-		opts->tsecr = req->ts_recent;
+		opts->tsecr = READ_ONCE(req->ts_recent);
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
 	if (likely(ireq->sack_ok)) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 0dcb06a1fe044..d9253aa764fae 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1130,7 +1130,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
-			req->ts_recent, sk->sk_bound_dev_if,
+			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
 			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
 			ipv6_get_dsfield(ipv6_hdr(skb)), 0, sk->sk_priority,
 			READ_ONCE(tcp_rsk(req)->txhash));
-- 
2.39.2



