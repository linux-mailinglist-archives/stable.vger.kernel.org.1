Return-Path: <stable+bounces-36450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 893BD89BFEE
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28EE1F24D1B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3C52E62C;
	Mon,  8 Apr 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jUhyKh4U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79D481A6;
	Mon,  8 Apr 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581361; cv=none; b=ffLvYVDD6rUOE3i4szUx3EahskyOFjmBLFFNFUAQsW085oF6fau6UOIG1GT59oOFkxh2deRlbx2El3yFIsPfYTcar3SZZ3KOGXnfuxDhWqh60k66zG46NViCXlC8EaKWHyln/TgOeFLiyT8irlKg4Bw9QjhKVnY9th3Bc8poOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581361; c=relaxed/simple;
	bh=NFTplQ+cylo5kb8IKFTRiphqsqorHi2/sQOEqv8JHtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcU2mNmdZrt7MH5SFkYWVFJMuYhJEIDlZL7Y3O2gmrta59v46PV5qIq4kZzOG5LeC/s6LV2X67zSTwcvu6GaH+PoaoAZypKS3gpOSUNk3B4NYJWSvPszSWT2j3/jq06QgidKaT1gH7eZMNIYtGCC08AAdqX75VPzVJnHEly/MOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jUhyKh4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA613C433C7;
	Mon,  8 Apr 2024 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581361;
	bh=NFTplQ+cylo5kb8IKFTRiphqsqorHi2/sQOEqv8JHtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUhyKh4UKUyjoHJHrkrZZPPa8RHEB6mJiii5nukS9ercrsUvpAKgzzJLFTEAwnA3S
	 BE9W+teMft1Nr3tpTx59WKKas3wb6KvsJVOaHUZeM/0OBttMxrtSngDYYf5aEHrPXU
	 edeUvtJ/4xGhnPr/ZSNhUhpSpI6Ic0Kjx8ElkqEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Dumazet <edumazet@google.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/138] tcp: properly terminate timers for kernel sockets
Date: Mon,  8 Apr 2024 14:57:02 +0200
Message-ID: <20240408125256.487848106@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

[ Upstream commit 151c9c724d05d5b0dd8acd3e11cb69ef1f2dbada ]

We had various syzbot reports about tcp timers firing after
the corresponding netns has been dismantled.

Fortunately Josef Bacik could trigger the issue more often,
and could test a patch I wrote two years ago.

When TCP sockets are closed, we call inet_csk_clear_xmit_timers()
to 'stop' the timers.

inet_csk_clear_xmit_timers() can be called from any context,
including when socket lock is held.
This is the reason it uses sk_stop_timer(), aka del_timer().
This means that ongoing timers might finish much later.

For user sockets, this is fine because each running timer
holds a reference on the socket, and the user socket holds
a reference on the netns.

For kernel sockets, we risk that the netns is freed before
timer can complete, because kernel sockets do not hold
reference on the netns.

This patch adds inet_csk_clear_xmit_timers_sync() function
that using sk_stop_timer_sync() to make sure all timers
are terminated before the kernel socket is released.
Modules using kernel sockets close them in their netns exit()
handler.

Also add sock_not_owned_by_me() helper to get LOCKDEP
support : inet_csk_clear_xmit_timers_sync() must not be called
while socket lock is held.

It is very possible we can revert in the future commit
3a58f13a881e ("net: rds: acquire refcount on TCP sockets")
which attempted to solve the issue in rds only.
(net/smc/af_smc.c and net/mptcp/subflow.c have similar code)

We probably can remove the check_net() tests from
tcp_out_of_resources() and __tcp_close() in the future.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/netdev/20240314210740.GA2823176@perftesting/
Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
Fixes: 8a68173691f0 ("net: sk_clone_lock() should only do get_net() if the parent is not a kernel socket")
Link: https://lore.kernel.org/bpf/CANn89i+484ffqb93aQm1N-tjxxvb3WDKX0EbD7318RwRgsatjw@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Tested-by: Josef Bacik <josef@toxicpanda.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Link: https://lore.kernel.org/r/20240322135732.1535772-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_connection_sock.h |  1 +
 include/net/sock.h                 |  7 +++++++
 net/ipv4/inet_connection_sock.c    | 14 ++++++++++++++
 net/ipv4/tcp.c                     |  2 ++
 4 files changed, 24 insertions(+)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 080968d6e6c53..8132f330306db 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -172,6 +172,7 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 			       void (*delack_handler)(struct timer_list *),
 			       void (*keepalive_handler)(struct timer_list *));
 void inet_csk_clear_xmit_timers(struct sock *sk);
+void inet_csk_clear_xmit_timers_sync(struct sock *sk);
 
 static inline void inet_csk_schedule_ack(struct sock *sk)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index 579732d47dfc4..60577751ea9e8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1833,6 +1833,13 @@ static inline void sock_owned_by_me(const struct sock *sk)
 #endif
 }
 
+static inline void sock_not_owned_by_me(const struct sock *sk)
+{
+#ifdef CONFIG_LOCKDEP
+	WARN_ON_ONCE(lockdep_sock_is_held(sk) && debug_locks);
+#endif
+}
+
 static inline bool sock_owned_by_user(const struct sock *sk)
 {
 	sock_owned_by_me(sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 79fa19a36bbd1..f7832d4253820 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -771,6 +771,20 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 }
 EXPORT_SYMBOL(inet_csk_clear_xmit_timers);
 
+void inet_csk_clear_xmit_timers_sync(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	/* ongoing timer handlers need to acquire socket lock. */
+	sock_not_owned_by_me(sk);
+
+	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
+
+	sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
+	sk_stop_timer_sync(sk, &sk->sk_timer);
+}
+
 void inet_csk_delete_keepalive_timer(struct sock *sk)
 {
 	sk_stop_timer(sk, &sk->sk_timer);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5a165e29f7be4..f01c0a5d2c37b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3052,6 +3052,8 @@ void tcp_close(struct sock *sk, long timeout)
 	lock_sock(sk);
 	__tcp_close(sk, timeout);
 	release_sock(sk);
+	if (!sk->sk_net_refcnt)
+		inet_csk_clear_xmit_timers_sync(sk);
 	sock_put(sk);
 }
 EXPORT_SYMBOL(tcp_close);
-- 
2.43.0




