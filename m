Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E587612F0
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjGYLGo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjGYLG1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:06:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F73846A1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D8B46165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6493C433C8;
        Tue, 25 Jul 2023 11:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283086;
        bh=+tuscWJfTiWJGqth5FHAtdGo30zsu3WZcqflxKiltr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F113S+av3svDQWVZD2e8uC6Wl1VaOSWUXn/xIOomRwAl724cCDn7gXfX+/0B2KPqR
         2J8i8itceXDj37ZBWIPngQN2ufFZoOMtSFvSgPV6GuKASWcnB6JVpYqR3GB0ipSCto
         6tJ4f4wnNFetBm48qYvu2ZiGHPQLCxE5H6ZEHZr8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Antoine Tenart <atenart@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 134/183] net: ipv4: use consistent txhash in TIME_WAIT and SYN_RECV
Date:   Tue, 25 Jul 2023 12:46:02 +0200
Message-ID: <20230725104512.760684857@linuxfoundation.org>
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

From: Antoine Tenart <atenart@kernel.org>

[ Upstream commit c0a8966e2bc7d31f77a7246947ebc09c1ff06066 ]

When using IPv4/TCP, skb->hash comes from sk->sk_txhash except in
TIME_WAIT and SYN_RECV where it's not set in the reply skb from
ip_send_unicast_reply. Those packets will have a mismatched hash with
others from the same flow as their hashes will be 0. IPv6 does not have
the same issue as the hash is set from the socket txhash in those cases.

This commits sets the hash in the reply skb from ip_send_unicast_reply,
which makes the IPv4 code behaving like IPv6.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 5e5265522a9a ("tcp: annotate data-races around tcp_rsk(req)->txhash")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip.h     |  2 +-
 net/ipv4/ip_output.c |  4 +++-
 net/ipv4/tcp_ipv4.c  | 14 +++++++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index acec504c469a0..83a1a9bc3ceb1 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -282,7 +282,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			   const struct ip_options *sopt,
 			   __be32 daddr, __be32 saddr,
 			   const struct ip_reply_arg *arg,
-			   unsigned int len, u64 transmit_time);
+			   unsigned int len, u64 transmit_time, u32 txhash);
 
 #define IP_INC_STATS(net, field)	SNMP_INC_STATS64((net)->mib.ip_statistics, field)
 #define __IP_INC_STATS(net, field)	__SNMP_INC_STATS64((net)->mib.ip_statistics, field)
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 2a07588265c70..7b4ab545c06e0 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1691,7 +1691,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			   const struct ip_options *sopt,
 			   __be32 daddr, __be32 saddr,
 			   const struct ip_reply_arg *arg,
-			   unsigned int len, u64 transmit_time)
+			   unsigned int len, u64 transmit_time, u32 txhash)
 {
 	struct ip_options_data replyopts;
 	struct ipcm_cookie ipc;
@@ -1754,6 +1754,8 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 								arg->csum));
 		nskb->ip_summed = CHECKSUM_NONE;
 		nskb->mono_delivery_time = !!transmit_time;
+		if (txhash)
+			skb_set_hash(nskb, txhash, PKT_HASH_TYPE_L4);
 		ip_push_pending_frames(sk, &fl4);
 	}
 out:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a7de5ba74e7f7..ef740983a1222 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -692,6 +692,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	u64 transmit_time = 0;
 	struct sock *ctl_sk;
 	struct net *net;
+	u32 txhash = 0;
 
 	/* Never send a reset in response to a reset. */
 	if (th->rst)
@@ -829,6 +830,8 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 				   inet_twsk(sk)->tw_priority : sk->sk_priority;
 		transmit_time = tcp_transmit_time(sk);
 		xfrm_sk_clone_policy(ctl_sk, sk);
+		txhash = (sk->sk_state == TCP_TIME_WAIT) ?
+			 inet_twsk(sk)->tw_txhash : sk->sk_txhash;
 	} else {
 		ctl_sk->sk_mark = 0;
 		ctl_sk->sk_priority = 0;
@@ -837,7 +840,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len,
-			      transmit_time);
+			      transmit_time, txhash);
 
 	xfrm_sk_free_policy(ctl_sk);
 	sock_net_set(ctl_sk, &init_net);
@@ -859,7 +862,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 			    struct sk_buff *skb, u32 seq, u32 ack,
 			    u32 win, u32 tsval, u32 tsecr, int oif,
 			    struct tcp_md5sig_key *key,
-			    int reply_flags, u8 tos)
+			    int reply_flags, u8 tos, u32 txhash)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct {
@@ -935,7 +938,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len,
-			      transmit_time);
+			      transmit_time, txhash);
 
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
@@ -955,7 +958,8 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			tw->tw_bound_dev_if,
 			tcp_twsk_md5_key(tcptw),
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			tw->tw_tos
+			tw->tw_tos,
+			tw->tw_txhash
 			);
 
 	inet_twsk_put(tw);
@@ -988,7 +992,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			0,
 			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			ip_hdr(skb)->tos);
+			ip_hdr(skb)->tos, tcp_rsk(req)->txhash);
 }
 
 /*
-- 
2.39.2



