Return-Path: <stable+bounces-62098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1922B93E305
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F46281783
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381019FA64;
	Sun, 28 Jul 2024 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AK1wYMGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65314388B;
	Sun, 28 Jul 2024 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128136; cv=none; b=pHDp+CkAX03J6exEkzupMLPE2qLyV8L7+grbC59+godGsy/fWP7erGvs00YtJXhwTeWTZs6FASHZCxfOTz3bWwI6WNOtUD8yepw3PG5DMnoF3ailyCMD7fwaeLCNGZby1MXZPU0e2GvllTE2juCSMeXLZoKJHER968u2nR2HckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128136; c=relaxed/simple;
	bh=v2b0Gui+0FK7PIbCU3JpPoQR+c0iZICBwcDTuEq2IBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlDduA67q1njyLb6QDVoJzUyD4qVTqOQN8z5ONUf3mltAbzEvi+m0YXvvhsOBA1UJrOFV02tvI+0opRovHevct2dJCRXtq684f9hHyMsEsmeLMatOMQqKr465gE4K+KTHIPUX+QchIczlhZfPJOZ0SaZywOy8ak1bN/cand7oM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AK1wYMGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB58C32781;
	Sun, 28 Jul 2024 00:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128135;
	bh=v2b0Gui+0FK7PIbCU3JpPoQR+c0iZICBwcDTuEq2IBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AK1wYMGOc/8VXvIUkC5C5OjUkT7SxAxqi+lu+aFjGcBMui+d4M5zhEgAF4fnC2nqO
	 69eOOElRrRCVJ9RKZBMtCejWs+NobtZRxDx5GWwRQ3VnpRfVjqL36kBOKSRCBuxHDg
	 kCSk5YibjR8KMxTQBiKByPFI2kHVgtSMVh7u6XGsURDnbeESXJd/k+CnyqKwZZOM4m
	 oLdtN+o3pE3OM/b48jelM9bDDPb2VDxPO4CUEF20wAs0kdiiNsCSSAR9jMANUJ1gl4
	 KtgtrWuWrhB6mwcScrBwbIP09iISG15TY9dcLyKG0USRIquZyvqfmu068FawEDQIpL
	 csqn2UhX2ApVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	mhal@rbox.co,
	daan.j.demeyer@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/11] af_unix: Don't retry after unix_state_lock_nested() in unix_stream_connect().
Date: Sat, 27 Jul 2024 20:55:10 -0400
Message-ID: <20240728005522.1731999-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005522.1731999-1-sashal@kernel.org>
References: <20240728005522.1731999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 1ca27e0c8c13ac50a4acf9cdf77069e2d94a547d ]

When a SOCK_(STREAM|SEQPACKET) socket connect()s to another one, we need
to lock the two sockets to check their states in unix_stream_connect().

We use unix_state_lock() for the server and unix_state_lock_nested() for
client with tricky sk->sk_state check to avoid deadlock.

The possible deadlock scenario are the following:

  1) Self connect()
  2) Simultaneous connect()

The former is simple, attempt to grab the same lock, and the latter is
AB-BA deadlock.

After the server's unix_state_lock(), we check the server socket's state,
and if it's not TCP_LISTEN, connect() fails with -EINVAL.

Then, we avoid the former deadlock by checking the client's state before
unix_state_lock_nested().  If its state is not TCP_LISTEN, we can make
sure that the client and the server are not identical based on the state.

Also, the latter deadlock can be avoided in the same way.  Due to the
server sk->sk_state requirement, AB-BA deadlock could happen only with
TCP_LISTEN sockets.  So, if the client's state is TCP_LISTEN, we can
give up the second lock to avoid the deadlock.

  CPU 1                 CPU 2                  CPU 3
  connect(A -> B)       connect(B -> A)        listen(A)
  ---                   ---                    ---
  unix_state_lock(B)
  B->sk_state == TCP_LISTEN
  READ_ONCE(A->sk_state) == TCP_CLOSE
                            ^^^^^^^^^
                            ok, will lock A    unix_state_lock(A)
             .--------------'                  WRITE_ONCE(A->sk_state, TCP_LISTEN)
             |                                 unix_state_unlock(A)
             |
             |          unix_state_lock(A)
             |          A->sk_sk_state == TCP_LISTEN
             |          READ_ONCE(B->sk_state) == TCP_LISTEN
             v                                    ^^^^^^^^^^
  unix_state_lock_nested(A)                       Don't lock B !!

Currently, while checking the client's state, we also check if it's
TCP_ESTABLISHED, but this is unlikely and can be checked after we know
the state is not TCP_CLOSE.

Moreover, if it happens after the second lock, we now jump to the restart
label, but it's unlikely that the server is not found during the retry,
so the jump is mostly to revist the client state check.

Let's remove the retry logic and check the state against TCP_CLOSE first.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3905cdcaa5184..b019d7b65c62e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1461,6 +1461,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	struct unix_sock *u = unix_sk(sk), *newu, *otheru;
 	struct net *net = sock_net(sk);
 	struct sk_buff *skb = NULL;
+	unsigned char state;
 	long timeo;
 	int err;
 
@@ -1505,7 +1506,6 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 	}
 
-	/* Latch state of peer */
 	unix_state_lock(other);
 
 	/* Apparently VFS overslept socket death. Retry. */
@@ -1535,37 +1535,21 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto restart;
 	}
 
-	/* Latch our state.
-
-	   It is tricky place. We need to grab our state lock and cannot
-	   drop lock on peer. It is dangerous because deadlock is
-	   possible. Connect to self case and simultaneous
-	   attempt to connect are eliminated by checking socket
-	   state. other is TCP_LISTEN, if sk is TCP_LISTEN we
-	   check this before attempt to grab lock.
-
-	   Well, and we have to recheck the state after socket locked.
+	/* self connect and simultaneous connect are eliminated
+	 * by rejecting TCP_LISTEN socket to avoid deadlock.
 	 */
-	switch (READ_ONCE(sk->sk_state)) {
-	case TCP_CLOSE:
-		/* This is ok... continue with connect */
-		break;
-	case TCP_ESTABLISHED:
-		/* Socket is already connected */
-		err = -EISCONN;
-		goto out_unlock;
-	default:
-		err = -EINVAL;
+	state = READ_ONCE(sk->sk_state);
+	if (unlikely(state != TCP_CLOSE)) {
+		err = state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
 		goto out_unlock;
 	}
 
 	unix_state_lock_nested(sk, U_LOCK_SECOND);
 
-	if (sk->sk_state != TCP_CLOSE) {
+	if (unlikely(sk->sk_state != TCP_CLOSE)) {
+		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
 		unix_state_unlock(sk);
-		unix_state_unlock(other);
-		sock_put(other);
-		goto restart;
+		goto out_unlock;
 	}
 
 	err = security_unix_stream_connect(sk, other, newsk);
-- 
2.43.0


