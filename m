Return-Path: <stable+bounces-145891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE097ABF9A3
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8843B39AB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FABD224885;
	Wed, 21 May 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/hVibg9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3EA1E2606;
	Wed, 21 May 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841637; cv=none; b=EQ5KlwC/pi5XbjL1C0A0zX6jLKqX6SsGLoIeFJHfYuomzeON04b5OHssDSAmXHh5qY8L898Jib4ikoTJHk5SEj0gbDdXCdXVmAUE4izE5KaBqVGGE9LF6yRxzbujBwwmIOu89226sEgiTpjShpsoBeK8WRJPGqxAnJ4tuBWaXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841637; c=relaxed/simple;
	bh=BSy8Koe2LlIfi02MrdJ+5aDU4ObqpdpP/dGX8EvvOjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+GqnHaJc7lbIHkfAJ0WebiMjyfI/Q9kri9X3f69VFv1oAOvuyUCtSybAa5cOWaeu89m+upAn4YjPr0sSEzqRYY76A9+nMYPflwJMNjCUBnT/kUwTa8i597ucdJnyG1hkVF6RPj4EcfPzJjdwnBbetN5MBVdwOYXTbGIjL79i58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/hVibg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC52C4CEEB;
	Wed, 21 May 2025 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841636;
	bh=BSy8Koe2LlIfi02MrdJ+5aDU4ObqpdpP/dGX8EvvOjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/hVibg9nuYnpKkpKuVlS/OFAvUOkLwN7QfLYvclxccteHzJxQtyZH4tBcDAcuqXF
	 OXCm4arsAwcDfkfDBhzbVOZIIX9O3jzXuep9hXzC21mWUTxxV90/LenPw2Mtc+M4JE
	 ZN5b+/b/98L6oNLQR+Twr+XjGYCf4FbB68LRDERhTPPq/gE6ItlaYvYbiblbrmCkPB
	 ZgirHOFm4mmIc48rl1PGPo8arm7+tco+a7z5lIb9mDl8imOdjAFGbWh4TgG98HDimy
	 WO5cxNG+rE3OXCASbD/rLL3uvv5BFem3QzWDOZ/dEEbUwsaYdoHsF0MP3muD2uoOxU
	 Lb+rgPXaupRqg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 14/27] af_unix: Save listener for embryo socket.
Date: Wed, 21 May 2025 16:27:13 +0100
Message-ID: <20250521152920.1116756-15-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
In-Reply-To: <20250521152920.1116756-1-lee@kernel.org>
References: <20250521152920.1116756-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit aed6ecef55d70de3762ce41c561b7f547dbaf107 ]

This is a prep patch for the following change, where we need to
fetch the listening socket from the successor embryo socket
during GC.

We add a new field to struct unix_sock to save a pointer to a
listening socket.

We set it when connect() creates a new socket, and clear it when
accept() is called.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-8-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit aed6ecef55d70de3762ce41c561b7f547dbaf107)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h | 1 +
 net/unix/af_unix.c    | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index e6f7bba19152..624fea657518 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -83,6 +83,7 @@ struct unix_sock {
 	struct path		path;
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
+	struct sock		*listener;
 	struct unix_vertex	*vertex;
 	struct list_head	link;
 	unsigned long		inflight;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 658a1680a92e..6075ecbe40b2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -954,6 +954,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_max_ack_backlog	= READ_ONCE(net->unx.sysctl_max_dgram_qlen);
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
+	u->listener = NULL;
 	u->inflight = 0;
 	u->vertex = NULL;
 	u->path.dentry = NULL;
@@ -1558,6 +1559,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	newsk->sk_type		= sk->sk_type;
 	init_peercred(newsk);
 	newu = unix_sk(newsk);
+	newu->listener = other;
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
 	otheru = unix_sk(other);
 
@@ -1651,8 +1653,8 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 		       bool kern)
 {
 	struct sock *sk = sock->sk;
-	struct sock *tsk;
 	struct sk_buff *skb;
+	struct sock *tsk;
 	int err;
 
 	err = -EOPNOTSUPP;
@@ -1677,6 +1679,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
+	unix_sk(tsk)->listener = NULL;
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
-- 
2.49.0.1143.g0be31eac6b-goog


