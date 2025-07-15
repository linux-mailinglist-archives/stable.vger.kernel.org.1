Return-Path: <stable+bounces-162469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F491B05E24
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9441C4064E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA1C2E8DE0;
	Tue, 15 Jul 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k8ibpXUG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240922E267F;
	Tue, 15 Jul 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586637; cv=none; b=mkPnGlKhOq9SgLlJ+ihSHD1P42eSOmdGcB3/NslaBGeTNvC436VHUXA01eI/5QZWgLj2/JFQuZS/l+BgUjBbhGScvCeGVrBrOA2NTc8Vji/+IAD3T3qTqUET+NmE9tgoEs230bksx0F5MBkPI6DhRLkQN6E2twxXMOx9T3J1eHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586637; c=relaxed/simple;
	bh=1Rl7JJ23uDlju74Sn4RqiR2sFOipDXgKrZ91q5zOrpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUc2d6XGPgclXxs5/dsZ6VyxHgP0J5G/baxTT2Jf31XdzjtJqg6WCpDwjT6fCTMK1mdB5VsU1srDLxAJXhaTr2uo90EUGzKfGfFQEAZSz52KLJhIcBNuclEQOmDo5GENB8qui1rGohf9mLZFT8MHWjGJJiwj2bRtiSet3ToITH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k8ibpXUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4FBC4CEE3;
	Tue, 15 Jul 2025 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586637;
	bh=1Rl7JJ23uDlju74Sn4RqiR2sFOipDXgKrZ91q5zOrpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8ibpXUGb6j3U3ENdN64q/rvS56HevznR2vKMYMho4lX0yOZlm4z/XU1MeqlqJyiL
	 +hcOFZ5px1HsIWAf5hQN+O1qXRAAcYCuB4lF4u/ZFuR+zbY3IwWCkebD6CHl1j5QZn
	 r8IKpYVl4k8On2apNWDkTwauFuSDAz69n4et4gw0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Baron <jbaron@akamai.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 109/148] netlink: Fix wraparounds of sk->sk_rmem_alloc.
Date: Tue, 15 Jul 2025 15:13:51 +0200
Message-ID: <20250715130804.677824974@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit ae8f160e7eb24240a2a79fc4c815c6a0d4ee16cc ]

Netlink has this pattern in some places

  if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
  	atomic_add(skb->truesize, &sk->sk_rmem_alloc);

, which has the same problem fixed by commit 5a465a0da13e ("udp:
Fix multiple wraparounds of sk->sk_rmem_alloc.").

For example, if we set INT_MAX to SO_RCVBUFFORCE, the condition
is always false as the two operands are of int.

Then, a single socket can eat as many skb as possible until OOM
happens, and we can see multiple wraparounds of sk->sk_rmem_alloc.

Let's fix it by using atomic_add_return() and comparing the two
variables as unsigned int.

Before:
  [root@fedora ~]# ss -f netlink
  Recv-Q      Send-Q Local Address:Port                Peer Address:Port
  -1668710080 0               rtnl:nl_wraparound/293               *

After:
  [root@fedora ~]# ss -f netlink
  Recv-Q     Send-Q Local Address:Port                Peer Address:Port
  2147483072 0               rtnl:nl_wraparound/290               *
  ^
  `--- INT_MAX - 576

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Jason Baron <jbaron@akamai.com>
Closes: https://lore.kernel.org/netdev/cover.1750285100.git.jbaron@akamai.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250704054824.1580222-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 81 ++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 17d86eee8bd8b..4c7af7f5117ae 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -378,7 +378,6 @@ static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 	WARN_ON(skb->sk != NULL);
 	skb->sk = sk;
 	skb->destructor = netlink_skb_destructor;
-	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 	sk_mem_charge(sk, skb->truesize);
 }
 
@@ -1206,41 +1205,48 @@ static struct sk_buff *netlink_alloc_large_skb(unsigned int size,
 int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 		      long *timeo, struct sock *ssk)
 {
+	DECLARE_WAITQUEUE(wait, current);
 	struct netlink_sock *nlk;
+	unsigned int rmem;
 
 	nlk = nlk_sk(sk);
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 
-	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
-		DECLARE_WAITQUEUE(wait, current);
-		if (!*timeo) {
-			if (!ssk || netlink_is_kernel(ssk))
-				netlink_overrun(sk);
-			sock_put(sk);
-			kfree_skb(skb);
-			return -EAGAIN;
-		}
-
-		__set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&nlk->wait, &wait);
+	if ((rmem == skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)) &&
+	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
+		netlink_skb_set_owner_r(skb, sk);
+		return 0;
+	}
 
-		if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-		     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
-		    !sock_flag(sk, SOCK_DEAD))
-			*timeo = schedule_timeout(*timeo);
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 
-		__set_current_state(TASK_RUNNING);
-		remove_wait_queue(&nlk->wait, &wait);
+	if (!*timeo) {
+		if (!ssk || netlink_is_kernel(ssk))
+			netlink_overrun(sk);
 		sock_put(sk);
+		kfree_skb(skb);
+		return -EAGAIN;
+	}
 
-		if (signal_pending(current)) {
-			kfree_skb(skb);
-			return sock_intr_errno(*timeo);
-		}
-		return 1;
+	__set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue(&nlk->wait, &wait);
+	rmem = atomic_read(&sk->sk_rmem_alloc);
+
+	if (((rmem && rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf)) ||
+	     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
+	    !sock_flag(sk, SOCK_DEAD))
+		*timeo = schedule_timeout(*timeo);
+
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&nlk->wait, &wait);
+	sock_put(sk);
+
+	if (signal_pending(current)) {
+		kfree_skb(skb);
+		return sock_intr_errno(*timeo);
 	}
-	netlink_skb_set_owner_r(skb, sk);
-	return 0;
+
+	return 1;
 }
 
 static int __netlink_sendskb(struct sock *sk, struct sk_buff *skb)
@@ -1300,6 +1306,7 @@ static int netlink_unicast_kernel(struct sock *sk, struct sk_buff *skb,
 	ret = -ECONNREFUSED;
 	if (nlk->netlink_rcv != NULL) {
 		ret = skb->len;
+		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 		netlink_skb_set_owner_r(skb, sk);
 		NETLINK_CB(skb).sk = ssk;
 		netlink_deliver_tap_kernel(sk, ssk, skb);
@@ -1378,13 +1385,19 @@ EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 static int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
+	unsigned int rmem, rcvbuf;
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+
+	if ((rmem != skb->truesize || rmem <= rcvbuf) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		__netlink_sendskb(sk, skb);
-		return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
+		return rmem > (rcvbuf >> 1);
 	}
+
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 	return -1;
 }
 
@@ -2177,6 +2190,7 @@ static int netlink_dump(struct sock *sk)
 	struct module *module;
 	int err = -ENOBUFS;
 	int alloc_min_size;
+	unsigned int rmem;
 	int alloc_size;
 
 	mutex_lock(nlk->cb_mutex);
@@ -2185,9 +2199,6 @@ static int netlink_dump(struct sock *sk)
 		goto errout_skb;
 	}
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
-		goto errout_skb;
-
 	/* NLMSG_GOODSIZE is small to avoid high order allocations being
 	 * required, but it makes sense to _attempt_ a 16K bytes allocation
 	 * to reduce number of system calls on dump operations, if user
@@ -2209,6 +2220,12 @@ static int netlink_dump(struct sock *sk)
 	if (!skb)
 		goto errout_skb;
 
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	if (rmem >= READ_ONCE(sk->sk_rcvbuf)) {
+		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+		goto errout_skb;
+	}
+
 	/* Trim skb to allocated size. User is expected to provide buffer as
 	 * large as max(min_dump_alloc, 16KiB (mac_recvmsg_len capped at
 	 * netlink_recvmsg())). dump will pack as many smaller messages as
-- 
2.39.5




