Return-Path: <stable+bounces-62084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 888B793E2D4
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1323CB2430E
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1746195F04;
	Sun, 28 Jul 2024 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaT8jj7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84588195980;
	Sun, 28 Jul 2024 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128098; cv=none; b=AQrBA2CY2Udox/1X5/4t1ZAODST8LRsD11YWOV2R8AxAkXmVvGuoy78fULQqU6kRt0ap6+reYGxPXxBuSpCODe8I/hn2DjzsFz172t2YNsqbBmvGAzESVVSIEZAwZOZntXvqzSbx/8/0HwKrXo+OqXpjz80RWwsfkNvvqGywhuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128098; c=relaxed/simple;
	bh=ABd+EkdPMw1KDkPLVq6bmwQAzqntT3H8FdtgFX0JQuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGM0xxATudfvab1Obpe5dSRVkbtb0vI2KiGhLHtz8+QqX4AfB6evwQ1L2lqQk09V3sXgPFyk7MXgIfuA5K9ZmT2WANEJBPcAeQ8SjnLeR4fWn8qYNmQA6gIRX2KVF87NQLBxGkpVIg/+QVQO0QxHwQ9ht9JKJE6BLGML89XeUFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaT8jj7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C108C4AF09;
	Sun, 28 Jul 2024 00:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128098;
	bh=ABd+EkdPMw1KDkPLVq6bmwQAzqntT3H8FdtgFX0JQuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaT8jj7wVSX6ueOgZiq9y6LLz0YlQix9Uul9++VA69RTtmcuHuyZaAZbScybX3sSZ
	 yKcO1Sq2pPGE06sHhVuMMykYcDMzs8gbi06gehgHnhSH88BUw0Iig/4zPJRedGcFQj
	 IeMPPQqU1rLmv7pFOLbB8wpk7dJeNsPiFP/eQ71WqoOHLd0rCf3bHWGsCJfsyTq7Ni
	 k2+1GKAz6/p9xZlpACzVAxdxwuNyobYYJH3DQqdDw1twelppb1OiVXPo9SSz/0ViKm
	 /PqxmUKPEPfXAr0uPslOVYMuKJs+TjZq08fBqXYVfWltFpZgtGx4W3JuHS+6zTaZMz
	 p4eCwhWrkVatQ==
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
Subject: [PATCH AUTOSEL 6.6 06/15] af_unix: Don't retry after unix_state_lock_nested() in unix_stream_connect().
Date: Sat, 27 Jul 2024 20:54:27 -0400
Message-ID: <20240728005442.1729384-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005442.1729384-1-sashal@kernel.org>
References: <20240728005442.1729384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 5a26e785ce70d..bb66bcd4a50ea 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1483,6 +1483,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	struct unix_sock *u = unix_sk(sk), *newu, *otheru;
 	struct net *net = sock_net(sk);
 	struct sk_buff *skb = NULL;
+	unsigned char state;
 	long timeo;
 	int err;
 
@@ -1529,7 +1530,6 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 	}
 
-	/* Latch state of peer */
 	unix_state_lock(other);
 
 	/* Apparently VFS overslept socket death. Retry. */
@@ -1559,37 +1559,21 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
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


