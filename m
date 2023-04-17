Return-Path: <stable+bounces-56041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F4B91B644
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 07:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E34FB22E6A
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 05:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC73524C4;
	Fri, 28 Jun 2024 05:40:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.priv.miraclelinux.com (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547E44C89;
	Fri, 28 Jun 2024 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.210.215.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553222; cv=none; b=VS2hnov+8trGp9Xc9qzcdAC5Gmdf5/AvnRR+PVpFf6YNGMTXon1NJoU5WhUqN0q1ZLtca5tGVNAkoQe5n0ZuQXEQH2dxgdQMKOmpAb1aT9jkNixzsHkG9VUU/QNv6cpEcL4Nk1bbeo7ZluqSjmaGtJMseuG0v/cXZD8iOlLnZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553222; c=relaxed/simple;
	bh=ZNngTCojwR7ShZZiul1KbJwOgp7f99mA0PArR10ypF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MQKRUCDmlnRoP5Ha8syY0+2PbMfM/dawQE6KgGpIgkyGo6sVZfWSPM/gTvruQtWYcnr4XTe0xFjMK8AHoMKru8qpMuF2Xf22tAXPoRkx7NYsxhjvsYq5iNy6vZkXz+XWHNvjC4+2Tt+xya/aW4Ce/KPf/0LleoADeoPzoHTIPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; arc=none smtp.client-ip=202.210.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: from cip-lava-a.miraclelinux.com (cip-lava-a.miraclelinux.com [10.2.1.116])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 8103D140105;
	Fri, 28 Jun 2024 14:40:19 +0900 (JST)
From: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hiraku.toyooka@miraclelinux.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
Subject: [PATCH 5.15 3/3] tcp: Fix data races around icsk->icsk_af_ops.
Date: Mon, 17 Apr 2023 16:53:48 +0000
Message-Id: <20230417165348.26189-4-kazunori.kobayashi@miraclelinux.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230417165348.26189-1-kazunori.kobayashi@miraclelinux.com>
References: <20230417165348.26189-1-kazunori.kobayashi@miraclelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit f49cd2f4d6170d27a2c61f1fecb03d8a70c91f57 upstream.

setsockopt(IPV6_ADDRFORM) and tcp_v6_connect() change icsk->icsk_af_ops
under lock_sock(), but tcp_(get|set)sockopt() read it locklessly.  To
avoid load/store tearing, we need to add READ_ONCE() and WRITE_ONCE()
for the reads and writes.

Thanks to Eric Dumazet for providing the syzbot report:

BUG: KCSAN: data-race in tcp_setsockopt / tcp_v6_connect

write to 0xffff88813c624518 of 8 bytes by task 23936 on cpu 0:
tcp_v6_connect+0x5b3/0xce0 net/ipv6/tcp_ipv6.c:240
__inet_stream_connect+0x159/0x6d0 net/ipv4/af_inet.c:660
inet_stream_connect+0x44/0x70 net/ipv4/af_inet.c:724
__sys_connect_file net/socket.c:1976 [inline]
__sys_connect+0x197/0x1b0 net/socket.c:1993
__do_sys_connect net/socket.c:2003 [inline]
__se_sys_connect net/socket.c:2000 [inline]
__x64_sys_connect+0x3d/0x50 net/socket.c:2000
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88813c624518 of 8 bytes by task 23937 on cpu 1:
tcp_setsockopt+0x147/0x1c80 net/ipv4/tcp.c:3789
sock_common_setsockopt+0x5d/0x70 net/core/sock.c:3585
__sys_setsockopt+0x212/0x2b0 net/socket.c:2252
__do_sys_setsockopt net/socket.c:2263 [inline]
__se_sys_setsockopt net/socket.c:2260 [inline]
__x64_sys_setsockopt+0x62/0x70 net/socket.c:2260
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0xffffffff8539af68 -> 0xffffffff8539aff8

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 23937 Comm: syz-executor.5 Not tainted
6.0.0-rc4-syzkaller-00331-g4ed9c1e971b1-dirty #0

Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 08/26/2022

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
---
 net/ipv4/tcp.c           | 10 ++++++----
 net/ipv6/ipv6_sockglue.c |  3 ++-
 net/ipv6/tcp_ipv6.c      |  6 ++++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9c7998377d6bd..e348b69ef0f5e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3704,8 +3704,9 @@ int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (level != SOL_TCP)
-		return icsk->icsk_af_ops->setsockopt(sk, level, optname,
-						     optval, optlen);
+		/* Paired with WRITE_ONCE() in do_ipv6_setsockopt() and tcp_v6_connect() */
+		return READ_ONCE(icsk->icsk_af_ops)->setsockopt(sk, level, optname,
+								optval, optlen);
 	return do_tcp_setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(tcp_setsockopt);
@@ -4303,8 +4304,9 @@ int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (level != SOL_TCP)
-		return icsk->icsk_af_ops->getsockopt(sk, level, optname,
-						     optval, optlen);
+		/* Paired with WRITE_ONCE() in do_ipv6_setsockopt() and tcp_v6_connect() */
+		return READ_ONCE(icsk->icsk_af_ops)->getsockopt(sk, level, optname,
+								optval, optlen);
 	return do_tcp_getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(tcp_getsockopt);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b8970fdeb0dda..a1a92480e935f 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -477,7 +477,8 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 				local_bh_enable();
 				/* Paired with READ_ONCE(sk->sk_prot) in inet6_stream_ops */
 				WRITE_ONCE(sk->sk_prot, &tcp_prot);
-				icsk->icsk_af_ops = &ipv4_specific;
+				/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+				WRITE_ONCE(icsk->icsk_af_ops, &ipv4_specific);
 				sk->sk_socket->ops = &inet_stream_ops;
 				sk->sk_family = PF_INET;
 				tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index c18fdddbfa09d..29c8d386274bf 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -237,7 +237,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 		sin.sin_port = usin->sin6_port;
 		sin.sin_addr.s_addr = usin->sin6_addr.s6_addr32[3];
 
-		icsk->icsk_af_ops = &ipv6_mapped;
+		/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+		WRITE_ONCE(icsk->icsk_af_ops, &ipv6_mapped);
 		if (sk_is_mptcp(sk))
 			mptcpv6_handle_mapped(sk, true);
 		sk->sk_backlog_rcv = tcp_v4_do_rcv;
@@ -249,7 +250,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 
 		if (err) {
 			icsk->icsk_ext_hdr_len = exthdrlen;
-			icsk->icsk_af_ops = &ipv6_specific;
+			/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+			WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
 			if (sk_is_mptcp(sk))
 				mptcpv6_handle_mapped(sk, false);
 			sk->sk_backlog_rcv = tcp_v6_do_rcv;
-- 
2.39.2


