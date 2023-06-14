Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C39713F2E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjE1Tmr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjE1Tmr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:42:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE12A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8283961F05
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85053C433D2;
        Sun, 28 May 2023 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302965;
        bh=NscXEtqL0b9w3JRbzrY+YSYrDngtbHeWfgOMOH41iPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ol9L8PcNRmm6ruouMnGJ9gLkN6679nzppIpEZMqNV/nTFEYvWr9QZhyjfLk23aIxt
         A0hMM3sMBHI+SQN3Z40GbC5G/TvgXlLamamI/XCQuhfBsANprbT42nmLcqa49WHzLp
         mTfeBSGm8b/6Rg8dzPzYB8G7g2blzTp5f9G8q9HE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sehee Lee <seheele@google.com>,
        Sewook Seo <sewookseo@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 099/211] net: Find dst with sks xfrm policy not ctl_sk
Date:   Sun, 28 May 2023 20:10:20 +0100
Message-Id: <20230528190846.052685871@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: sewookseo <sewookseo@google.com>

[ Upstream commit e22aa14866684f77b4f6b6cae98539e520ddb731 ]

If we set XFRM security policy by calling setsockopt with option
IPV6_XFRM_POLICY, the policy will be stored in 'sock_policy' in 'sock'
struct. However tcp_v6_send_response doesn't look up dst_entry with the
actual socket but looks up with tcp control socket. This may cause a
problem that a RST packet is sent without ESP encryption & peer's TCP
socket can't receive it.
This patch will make the function look up dest_entry with actual socket,
if the socket has XFRM policy(sock_policy), so that the TCP response
packet via this function can be encrypted, & aligned on the encrypted
TCP socket.

Tested: We encountered this problem when a TCP socket which is encrypted
in ESP transport mode encryption, receives challenge ACK at SYN_SENT
state. After receiving challenge ACK, TCP needs to send RST to
establish the socket at next SYN try. But the RST was not encrypted &
peer TCP socket still remains on ESTABLISHED state.
So we verified this with test step as below.
[Test step]
1. Making a TCP state mismatch between client(IDLE) & server(ESTABLISHED).
2. Client tries a new connection on the same TCP ports(src & dst).
3. Server will return challenge ACK instead of SYN,ACK.
4. Client will send RST to server to clear the SOCKET.
5. Client will retransmit SYN to server on the same TCP ports.
[Expected result]
The TCP connection should be established.

Cc: Maciej Żenczykowski <maze@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Sehee Lee <seheele@google.com>
Signed-off-by: Sewook Seo <sewookseo@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1e306ec49a1f ("tcp: fix possible sk_priority leak in tcp_v4_send_reset()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h   | 2 ++
 net/ipv4/ip_output.c | 2 +-
 net/ipv4/tcp_ipv4.c  | 2 ++
 net/ipv6/tcp_ipv6.c  | 5 ++++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 8a9943d935f14..726a2dbb407f1 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1198,6 +1198,8 @@ int __xfrm_sk_clone_policy(struct sock *sk, const struct sock *osk);
 
 static inline int xfrm_sk_clone_policy(struct sock *sk, const struct sock *osk)
 {
+	if (!sk_fullsock(osk))
+		return 0;
 	sk->sk_policy[0] = NULL;
 	sk->sk_policy[1] = NULL;
 	if (unlikely(osk->sk_policy[0] || osk->sk_policy[1]))
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1e07df2821773..6fd04f2f8b40c 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1723,7 +1723,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			   tcp_hdr(skb)->source, tcp_hdr(skb)->dest,
 			   arg->uid);
 	security_skb_classify_flow(skb, flowi4_to_flowi_common(&fl4));
-	rt = ip_route_output_key(net, &fl4);
+	rt = ip_route_output_flow(net, &fl4, sk);
 	if (IS_ERR(rt))
 		return;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 275ae42be99e0..1995d46afb214 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -804,6 +804,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 		ctl_sk->sk_priority = (sk->sk_state == TCP_TIME_WAIT) ?
 				   inet_twsk(sk)->tw_priority : sk->sk_priority;
 		transmit_time = tcp_transmit_time(sk);
+		xfrm_sk_clone_policy(ctl_sk, sk);
 	}
 	ip_send_unicast_reply(ctl_sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
@@ -812,6 +813,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 			      transmit_time);
 
 	ctl_sk->sk_mark = 0;
+	xfrm_sk_free_policy(ctl_sk);
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2347740d3cc7c..fe29bc66aeac7 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -984,7 +984,10 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	 * Underlying function will use this to retrieve the network
 	 * namespace
 	 */
-	dst = ip6_dst_lookup_flow(sock_net(ctl_sk), ctl_sk, &fl6, NULL);
+	if (sk && sk->sk_state != TCP_TIME_WAIT)
+		dst = ip6_dst_lookup_flow(net, sk, &fl6, NULL); /*sk's xfrm_policy can be referred*/
+	else
+		dst = ip6_dst_lookup_flow(net, ctl_sk, &fl6, NULL);
 	if (!IS_ERR(dst)) {
 		skb_dst_set(buff, dst);
 		ip6_xmit(ctl_sk, buff, &fl6, fl6.flowi6_mark, NULL,
-- 
2.39.2



