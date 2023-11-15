Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30E17ECD33
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjKOTfC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjKOTfA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D29919E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9291DC433CB;
        Wed, 15 Nov 2023 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076896;
        bh=ArMOTo3XroasB7Xp+icAu2/gySThlA3z/eP3cwSOQuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ydHU9tsm3oZeClT3bAd2PMevVQL6aUdhXO99ABZVml/ustSG/giNgkAMIs2fEaKYq
         vDY4/1no0iq1YaN5x+k/t08hOuPkBcENMoG6vG9CORRegztYId9eo45HB41MprjnUk
         f3rCiiXcnlLx5cuD6rEmbmJOFdtrWJxEpxJUXxVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 060/603] udp: annotate data-races around udp->encap_type
Date:   Wed, 15 Nov 2023 14:10:05 -0500
Message-ID: <20231115191617.277433799@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 70a36f571362a8de8b8c02d21ae524fc776287f2 ]

syzbot/KCSAN complained about UDP_ENCAP_L2TPINUDP setsockopt() racing.

Add READ_ONCE()/WRITE_ONCE() to document races on this lockless field.

syzbot report was:
BUG: KCSAN: data-race in udp_lib_setsockopt / udp_lib_setsockopt

read-write to 0xffff8881083603fa of 1 bytes by task 16557 on cpu 0:
udp_lib_setsockopt+0x682/0x6c0
udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2779
sock_common_setsockopt+0x61/0x70 net/core/sock.c:3697
__sys_setsockopt+0x1c9/0x230 net/socket.c:2263
__do_sys_setsockopt net/socket.c:2274 [inline]
__se_sys_setsockopt net/socket.c:2271 [inline]
__x64_sys_setsockopt+0x66/0x80 net/socket.c:2271
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read-write to 0xffff8881083603fa of 1 bytes by task 16554 on cpu 1:
udp_lib_setsockopt+0x682/0x6c0
udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2779
sock_common_setsockopt+0x61/0x70 net/core/sock.c:3697
__sys_setsockopt+0x1c9/0x230 net/socket.c:2263
__do_sys_setsockopt net/socket.c:2274 [inline]
__se_sys_setsockopt net/socket.c:2271 [inline]
__x64_sys_setsockopt+0x66/0x80 net/socket.c:2271
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x01 -> 0x05

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 16554 Comm: syz-executor.5 Not tainted 6.5.0-rc7-syzkaller-00004-gf7757129e3de #0

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c      | 4 ++--
 net/ipv4/udp.c         | 9 +++++----
 net/ipv4/xfrm4_input.c | 4 ++--
 net/ipv6/udp.c         | 5 +++--
 net/ipv6/xfrm6_input.c | 4 ++--
 net/l2tp/l2tp_core.c   | 6 +++---
 6 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index b22596b18ee8c..b1919278e931f 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -630,7 +630,7 @@ static void __gtp_encap_destroy(struct sock *sk)
 			gtp->sk0 = NULL;
 		else
 			gtp->sk1u = NULL;
-		udp_sk(sk)->encap_type = 0;
+		WRITE_ONCE(udp_sk(sk)->encap_type, 0);
 		rcu_assign_sk_user_data(sk, NULL);
 		release_sock(sk);
 		sock_put(sk);
@@ -682,7 +682,7 @@ static int gtp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	netdev_dbg(gtp->dev, "encap_recv sk=%p\n", sk);
 
-	switch (udp_sk(sk)->encap_type) {
+	switch (READ_ONCE(udp_sk(sk)->encap_type)) {
 	case UDP_ENCAP_GTP0:
 		netdev_dbg(gtp->dev, "received GTP0 packet\n");
 		ret = gtp0_udp_encap_recv(gtp, skb);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 637a4faf9aff6..2eeab4af17a13 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -714,7 +714,7 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 			       iph->saddr, uh->source, skb->dev->ifindex,
 			       inet_sdif(skb), udptable, NULL);
 
-	if (!sk || udp_sk(sk)->encap_type) {
+	if (!sk || READ_ONCE(udp_sk(sk)->encap_type)) {
 		/* No socket for error: try tunnels before discarding */
 		if (static_branch_unlikely(&udp_encap_needed_key)) {
 			sk = __udp4_lib_err_encap(net, iph, uh, udptable, sk, skb,
@@ -2081,7 +2081,8 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	}
 	nf_reset_ct(skb);
 
-	if (static_branch_unlikely(&udp_encap_needed_key) && up->encap_type) {
+	if (static_branch_unlikely(&udp_encap_needed_key) &&
+	    READ_ONCE(up->encap_type)) {
 		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
 
 		/*
@@ -2684,7 +2685,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 #endif
 			fallthrough;
 		case UDP_ENCAP_L2TPINUDP:
-			up->encap_type = val;
+			WRITE_ONCE(up->encap_type, val);
 			udp_tunnel_encap_enable(sk);
 			break;
 		default:
@@ -2785,7 +2786,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_ENCAP:
-		val = up->encap_type;
+		val = READ_ONCE(up->encap_type);
 		break;
 
 	case UDP_NO_CHECK6_TX:
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index eac206a290d05..183f6dc372429 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -85,11 +85,11 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	struct udphdr *uh;
 	struct iphdr *iph;
 	int iphlen, len;
-
 	__u8 *udpdata;
 	__be32 *udpdata32;
-	__u16 encap_type = up->encap_type;
+	u16 encap_type;
 
+	encap_type = READ_ONCE(up->encap_type);
 	/* if this is not encapsulated socket, then just return now */
 	if (!encap_type)
 		return 1;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 90688877e9004..0e79d189613be 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -571,7 +571,7 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	sk = __udp6_lib_lookup(net, daddr, uh->dest, saddr, uh->source,
 			       inet6_iif(skb), inet6_sdif(skb), udptable, NULL);
 
-	if (!sk || udp_sk(sk)->encap_type) {
+	if (!sk || READ_ONCE(udp_sk(sk)->encap_type)) {
 		/* No socket for error: try tunnels before discarding */
 		if (static_branch_unlikely(&udpv6_encap_needed_key)) {
 			sk = __udp6_lib_err_encap(net, hdr, offset, uh,
@@ -688,7 +688,8 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	}
 	nf_reset_ct(skb);
 
-	if (static_branch_unlikely(&udpv6_encap_needed_key) && up->encap_type) {
+	if (static_branch_unlikely(&udpv6_encap_needed_key) &&
+	    READ_ONCE(up->encap_type)) {
 		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
 
 		/*
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 4907ab241d6be..4156387248e40 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -81,14 +81,14 @@ int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	struct ipv6hdr *ip6h;
 	int len;
 	int ip6hlen = sizeof(struct ipv6hdr);
-
 	__u8 *udpdata;
 	__be32 *udpdata32;
-	__u16 encap_type = up->encap_type;
+	u16 encap_type;
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return xfrm4_udp_encap_rcv(sk, skb);
 
+	encap_type = READ_ONCE(up->encap_type);
 	/* if this is not encapsulated socket, then just return now */
 	if (!encap_type)
 		return 1;
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 03608d3ded4b8..8d21ff25f1602 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1139,9 +1139,9 @@ static void l2tp_tunnel_destruct(struct sock *sk)
 	switch (tunnel->encap) {
 	case L2TP_ENCAPTYPE_UDP:
 		/* No longer an encapsulation socket. See net/ipv4/udp.c */
-		(udp_sk(sk))->encap_type = 0;
-		(udp_sk(sk))->encap_rcv = NULL;
-		(udp_sk(sk))->encap_destroy = NULL;
+		WRITE_ONCE(udp_sk(sk)->encap_type, 0);
+		udp_sk(sk)->encap_rcv = NULL;
+		udp_sk(sk)->encap_destroy = NULL;
 		break;
 	case L2TP_ENCAPTYPE_IP:
 		break;
-- 
2.42.0



