Return-Path: <stable+bounces-10239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEC58273EC
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3EBE1C22C82
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853C54669;
	Mon,  8 Jan 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K6NbgiZY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE914C602;
	Mon,  8 Jan 2024 15:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8E9C433CA;
	Mon,  8 Jan 2024 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728426;
	bh=jBW3R6fszMKwvuXB1JzoY7QLHx9hHfMpker85uCIyW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6NbgiZY5kGrwswsjYp88IwUdy3T2r/HC5491NguA12Fse6YZGBez0sR23SLG3fsY
	 NPQPis+MBZ2X0Xi0NUgOjMD8bY5jT5goI7JjXAOmQdHLQ0Tj8GOUBIxly5WAh+FgH0
	 BJDnhwt8Yx33ifOHoCnmBdN2XSEkIa81B1xSz26I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 073/150] udp: annotate data-races around udp->encap_type
Date: Mon,  8 Jan 2024 16:35:24 +0100
Message-ID: <20240108153514.572507690@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 477b4d4f860bd..bace989591f75 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -629,7 +629,7 @@ static void __gtp_encap_destroy(struct sock *sk)
 			gtp->sk0 = NULL;
 		else
 			gtp->sk1u = NULL;
-		udp_sk(sk)->encap_type = 0;
+		WRITE_ONCE(udp_sk(sk)->encap_type, 0);
 		rcu_assign_sk_user_data(sk, NULL);
 		release_sock(sk);
 		sock_put(sk);
@@ -681,7 +681,7 @@ static int gtp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	netdev_dbg(gtp->dev, "encap_recv sk=%p\n", sk);
 
-	switch (udp_sk(sk)->encap_type) {
+	switch (READ_ONCE(udp_sk(sk)->encap_type)) {
 	case UDP_ENCAP_GTP0:
 		netdev_dbg(gtp->dev, "received GTP0 packet\n");
 		ret = gtp0_udp_encap_recv(gtp, skb);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 267f77633a8f3..5672d9a86c5d2 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -733,7 +733,7 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 			       iph->saddr, uh->source, skb->dev->ifindex,
 			       inet_sdif(skb), udptable, NULL);
 
-	if (!sk || udp_sk(sk)->encap_type) {
+	if (!sk || READ_ONCE(udp_sk(sk)->encap_type)) {
 		/* No socket for error: try tunnels before discarding */
 		if (static_branch_unlikely(&udp_encap_needed_key)) {
 			sk = __udp4_lib_err_encap(net, iph, uh, udptable, sk, skb,
@@ -2114,7 +2114,8 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	}
 	nf_reset_ct(skb);
 
-	if (static_branch_unlikely(&udp_encap_needed_key) && up->encap_type) {
+	if (static_branch_unlikely(&udp_encap_needed_key) &&
+	    READ_ONCE(up->encap_type)) {
 		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
 
 		/*
@@ -2699,7 +2700,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 #endif
 			fallthrough;
 		case UDP_ENCAP_L2TPINUDP:
-			up->encap_type = val;
+			WRITE_ONCE(up->encap_type, val);
 			udp_tunnel_encap_enable(sk);
 			break;
 		default:
@@ -2800,7 +2801,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
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
index 5b7c4f8e2ed03..961106eda69d0 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -598,7 +598,7 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	sk = __udp6_lib_lookup(net, daddr, uh->dest, saddr, uh->source,
 			       inet6_iif(skb), inet6_sdif(skb), udptable, NULL);
 
-	if (!sk || udp_sk(sk)->encap_type) {
+	if (!sk || READ_ONCE(udp_sk(sk)->encap_type)) {
 		/* No socket for error: try tunnels before discarding */
 		if (static_branch_unlikely(&udpv6_encap_needed_key)) {
 			sk = __udp6_lib_err_encap(net, hdr, offset, uh,
@@ -712,7 +712,8 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
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
2.43.0




