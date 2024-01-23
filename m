Return-Path: <stable+bounces-15420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7A838528
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56887289969
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276DF810;
	Tue, 23 Jan 2024 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oR5OY7t5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26810F1;
	Tue, 23 Jan 2024 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975756; cv=none; b=CJHc06RLiP6clOWPDY+Q4VE5tarNv5USKuCJGy4iLoH3ZMXnzt4E4HCrjfMBg6MhUqea/XRhICDGxzlbiktvPO/7I/CTdr9hJOK+4TDdT3rWXBOKKgOTgmvA95oq6qoZJ0spT24vXqG4dmGEkVV0ss+nElQCrEll5azdJEkssuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975756; c=relaxed/simple;
	bh=Ei4L1UFuZPq3ECkFBLcMX564J2F76Me8tNORyTT3aRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0NCKx2+0Ky1OOplumDlxrFrHyIB3rMJGlgOmnG6CQnRkyYj/INubEztcbs0qXnfy+jS66D9Q5twLUYrH2pAxYhMRdi7V+aeSOoyIf4Cx/0aO1N9So5w7UdktOfzIpvTzjj4ZpATrO/v+g70iBy4x2e01+j16gSvgvJv91ynLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oR5OY7t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D319C433C7;
	Tue, 23 Jan 2024 02:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975756;
	bh=Ei4L1UFuZPq3ECkFBLcMX564J2F76Me8tNORyTT3aRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oR5OY7t5eM9PH7lBCZgd2xAcN3Xch6Gx0fgJQX2vtycvlafcHSw7p5f6Z7ODK6KvR
	 0CqFTwLNfr0019WX+FQ4juor6KBB1Xh/mRrBqQaqug48X2fW2u4jlWnPAtux5eyaZR
	 QKL4BH18Sg/PsMHrYitg9YRZ/o6BIavWBZ33F3ik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 539/583] udp: annotate data-races around up->pending
Date: Mon, 22 Jan 2024 15:59:50 -0800
Message-ID: <20240122235828.613727698@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 482521d8e0c6520429478aa6866cd44128b33d5d ]

up->pending can be read without holding the socket lock,
as pointed out by syzbot [1]

Add READ_ONCE() in lockless contexts, and WRITE_ONCE()
on write side.

[1]
BUG: KCSAN: data-race in udpv6_sendmsg / udpv6_sendmsg

write to 0xffff88814e5eadf0 of 4 bytes by task 15547 on cpu 1:
 udpv6_sendmsg+0x1405/0x1530 net/ipv6/udp.c:1596
 inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:657
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x257/0x310 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0x78/0x90 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

read to 0xffff88814e5eadf0 of 4 bytes by task 15551 on cpu 0:
 udpv6_sendmsg+0x22c/0x1530 net/ipv6/udp.c:1373
 inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:657
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2586
 ___sys_sendmsg net/socket.c:2640 [inline]
 __sys_sendmmsg+0x269/0x500 net/socket.c:2726
 __do_sys_sendmmsg net/socket.c:2755 [inline]
 __se_sys_sendmmsg net/socket.c:2752 [inline]
 __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2752
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

value changed: 0x00000000 -> 0x0000000a

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 15551 Comm: syz-executor.1 Tainted: G        W          6.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com
Link: https://lore.kernel.org/netdev/0000000000009e46c3060ebcdffd@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 12 ++++++------
 net/ipv6/udp.c | 16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c3ff984b6354..bd12a7658213 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -805,7 +805,7 @@ void udp_flush_pending_frames(struct sock *sk)
 
 	if (up->pending) {
 		up->len = 0;
-		up->pending = 0;
+		WRITE_ONCE(up->pending, 0);
 		ip_flush_pending_frames(sk);
 	}
 }
@@ -993,7 +993,7 @@ int udp_push_pending_frames(struct sock *sk)
 
 out:
 	up->len = 0;
-	up->pending = 0;
+	WRITE_ONCE(up->pending, 0);
 	return err;
 }
 EXPORT_SYMBOL(udp_push_pending_frames);
@@ -1069,7 +1069,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	getfrag = is_udplite ? udplite_getfrag : ip_generic_getfrag;
 
 	fl4 = &inet->cork.fl.u.ip4;
-	if (up->pending) {
+	if (READ_ONCE(up->pending)) {
 		/*
 		 * There are pending frames.
 		 * The socket lock must be held while it's corked.
@@ -1265,7 +1265,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl4->saddr = saddr;
 	fl4->fl4_dport = dport;
 	fl4->fl4_sport = inet->inet_sport;
-	up->pending = AF_INET;
+	WRITE_ONCE(up->pending, AF_INET);
 
 do_append_data:
 	up->len += ulen;
@@ -1277,7 +1277,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	else if (!corkreq)
 		err = udp_push_pending_frames(sk);
 	else if (unlikely(skb_queue_empty(&sk->sk_write_queue)))
-		up->pending = 0;
+		WRITE_ONCE(up->pending, 0);
 	release_sock(sk);
 
 out:
@@ -1315,7 +1315,7 @@ void udp_splice_eof(struct socket *sock)
 	struct sock *sk = sock->sk;
 	struct udp_sock *up = udp_sk(sk);
 
-	if (!up->pending || udp_test_bit(CORK, sk))
+	if (!READ_ONCE(up->pending) || udp_test_bit(CORK, sk))
 		return;
 
 	lock_sock(sk);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index f60ba4295435..f1170dcc21d9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1134,7 +1134,7 @@ static void udp_v6_flush_pending_frames(struct sock *sk)
 		udp_flush_pending_frames(sk);
 	else if (up->pending) {
 		up->len = 0;
-		up->pending = 0;
+		WRITE_ONCE(up->pending, 0);
 		ip6_flush_pending_frames(sk);
 	}
 }
@@ -1312,7 +1312,7 @@ static int udp_v6_push_pending_frames(struct sock *sk)
 			      &inet_sk(sk)->cork.base);
 out:
 	up->len = 0;
-	up->pending = 0;
+	WRITE_ONCE(up->pending, 0);
 	return err;
 }
 
@@ -1369,7 +1369,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		default:
 			return -EINVAL;
 		}
-	} else if (!up->pending) {
+	} else if (!READ_ONCE(up->pending)) {
 		if (sk->sk_state != TCP_ESTABLISHED)
 			return -EDESTADDRREQ;
 		daddr = &sk->sk_v6_daddr;
@@ -1400,8 +1400,8 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		return -EMSGSIZE;
 
 	getfrag  =  is_udplite ?  udplite_getfrag : ip_generic_getfrag;
-	if (up->pending) {
-		if (up->pending == AF_INET)
+	if (READ_ONCE(up->pending)) {
+		if (READ_ONCE(up->pending) == AF_INET)
 			return udp_sendmsg(sk, msg, len);
 		/*
 		 * There are pending frames.
@@ -1591,7 +1591,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		goto out;
 	}
 
-	up->pending = AF_INET6;
+	WRITE_ONCE(up->pending, AF_INET6);
 
 do_append_data:
 	if (ipc6.dontfrag < 0)
@@ -1605,7 +1605,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	else if (!corkreq)
 		err = udp_v6_push_pending_frames(sk);
 	else if (unlikely(skb_queue_empty(&sk->sk_write_queue)))
-		up->pending = 0;
+		WRITE_ONCE(up->pending, 0);
 
 	if (err > 0)
 		err = np->recverr ? net_xmit_errno(err) : 0;
@@ -1646,7 +1646,7 @@ static void udpv6_splice_eof(struct socket *sock)
 	struct sock *sk = sock->sk;
 	struct udp_sock *up = udp_sk(sk);
 
-	if (!up->pending || udp_test_bit(CORK, sk))
+	if (!READ_ONCE(up->pending) || udp_test_bit(CORK, sk))
 		return;
 
 	lock_sock(sk);
-- 
2.43.0




