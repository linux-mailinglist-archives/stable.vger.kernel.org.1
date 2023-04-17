Return-Path: <stable+bounces-56040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F791B641
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 07:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF91284F6E
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 05:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7E4D8C3;
	Fri, 28 Jun 2024 05:40:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.priv.miraclelinux.com (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E128DBC;
	Fri, 28 Jun 2024 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.210.215.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553222; cv=none; b=R0QZJN23l8iReoCPngH354pxW/7lfR9DW0F8e9jaVNVnL/6WOUIWpnlKTE5MTA/vY2P2IGwKejcVFvqtJ0kdeP++lm/hVcdPjOoZvqgx7hL01loXLX7opOhu4rK6VjRGKs8hSuJ4fd/i1qhNmzWn9K5eK+k+i9vGcwUifJI7r6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553222; c=relaxed/simple;
	bh=0sNYBCFxwwSn4mreE3io6zw++WBvVZZ9Q8zHdUApboQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=g9TWvq6RIT+vCU0wAZ3I3M80HzEO45ij3fZecDfJzFvxBybxbdGISKZ1cPulryDcXYKHUVD6T9z1hksQvbzOmG+p3veSEY2JX1Yt4aLXTgC3feUYmMh+cVfD5RrY/V+Q8XLPhdMQVcyzq7AZApoCln6PNEfWUggL6erkBor1a78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; arc=none smtp.client-ip=202.210.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: from cip-lava-a.miraclelinux.com (cip-lava-a.miraclelinux.com [10.2.1.116])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 05C91140103;
	Fri, 28 Jun 2024 14:40:19 +0900 (JST)
From: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hiraku.toyooka@miraclelinux.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
Subject: [PATCH 5.15 2/3] ipv6: Fix data races around sk->sk_prot.
Date: Mon, 17 Apr 2023 16:53:47 +0000
Message-Id: <20230417165348.26189-3-kazunori.kobayashi@miraclelinux.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230417165348.26189-1-kazunori.kobayashi@miraclelinux.com>
References: <20230417165348.26189-1-kazunori.kobayashi@miraclelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit 364f997b5cfe1db0d63a390fe7c801fa2b3115f6 upstream.

Commit 086d49058cd8 ("ipv6: annotate some data-races around sk->sk_prot")
fixed some data-races around sk->sk_prot but it was not enough.

Some functions in inet6_(stream|dgram)_ops still access sk->sk_prot
without lock_sock() or rtnl_lock(), so they need READ_ONCE() to avoid
load tearing.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
---
 net/core/sock.c          |  6 ++++--
 net/ipv4/af_inet.c       | 23 ++++++++++++++++-------
 net/ipv6/ipv6_sockglue.c |  4 ++--
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 62e376f09f957..399d0b801b097 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3413,7 +3413,8 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	return sk->sk_prot->getsockopt(sk, level, optname, optval, optlen);
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
 
@@ -3440,7 +3441,8 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	return sk->sk_prot->setsockopt(sk, level, optname, optval, optlen);
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 487f75993bf4f..110ac22d3ce20 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -565,22 +565,27 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 		       int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
+	const struct proto *prot;
 	int err;
 
 	if (addr_len < sizeof(uaddr->sa_family))
 		return -EINVAL;
+
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	prot = READ_ONCE(sk->sk_prot);
+
 	if (uaddr->sa_family == AF_UNSPEC)
-		return sk->sk_prot->disconnect(sk, flags);
+		return prot->disconnect(sk, flags);
 
 	if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
-		err = sk->sk_prot->pre_connect(sk, uaddr, addr_len);
+		err = prot->pre_connect(sk, uaddr, addr_len);
 		if (err)
 			return err;
 	}
 
 	if (data_race(!inet_sk(sk)->inet_num) && inet_autobind(sk))
 		return -EAGAIN;
-	return sk->sk_prot->connect(sk, uaddr, addr_len);
+	return prot->connect(sk, uaddr, addr_len);
 }
 EXPORT_SYMBOL(inet_dgram_connect);
 
@@ -743,10 +748,11 @@ EXPORT_SYMBOL(inet_stream_connect);
 int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 		bool kern)
 {
-	struct sock *sk1 = sock->sk;
+	struct sock *sk1 = sock->sk, *sk2;
 	int err = -EINVAL;
-	struct sock *sk2 = sk1->sk_prot->accept(sk1, flags, &err, kern);
 
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, flags, &err, kern);
 	if (!sk2)
 		goto do_err;
 
@@ -834,12 +840,15 @@ ssize_t inet_sendpage(struct socket *sock, struct page *page, int offset,
 		      size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
+	const struct proto *prot;
 
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	if (sk->sk_prot->sendpage)
-		return sk->sk_prot->sendpage(sk, page, offset, size, flags);
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	prot = READ_ONCE(sk->sk_prot);
+	if (prot->sendpage)
+		return prot->sendpage(sk, page, offset, size, flags);
 	return sock_no_sendpage(sock, page, offset, size, flags);
 }
 EXPORT_SYMBOL(inet_sendpage);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 485d381aa4475..b8970fdeb0dda 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -475,7 +475,7 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 				sock_prot_inuse_add(net, sk->sk_prot, -1);
 				sock_prot_inuse_add(net, &tcp_prot, 1);
 				local_bh_enable();
-				/* Paired with READ_ONCE(sk->sk_prot) in net/ipv6/af_inet6.c */
+				/* Paired with READ_ONCE(sk->sk_prot) in inet6_stream_ops */
 				WRITE_ONCE(sk->sk_prot, &tcp_prot);
 				icsk->icsk_af_ops = &ipv4_specific;
 				sk->sk_socket->ops = &inet_stream_ops;
@@ -490,7 +490,7 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 				sock_prot_inuse_add(net, sk->sk_prot, -1);
 				sock_prot_inuse_add(net, prot, 1);
 				local_bh_enable();
-				/* Paired with READ_ONCE(sk->sk_prot) in net/ipv6/af_inet6.c */
+				/* Paired with READ_ONCE(sk->sk_prot) in inet6_dgram_ops */
 				WRITE_ONCE(sk->sk_prot, prot);
 				sk->sk_socket->ops = &inet_dgram_ops;
 				sk->sk_family = PF_INET;
-- 
2.39.2


