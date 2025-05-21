Return-Path: <stable+bounces-145860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512EABF84E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086987A25E3
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225D721579F;
	Wed, 21 May 2025 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8Uncq5h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4C1E503D;
	Wed, 21 May 2025 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839064; cv=none; b=rxylDw/ksyqeICvE8OXOWLfBSvZmJ4/KinfB+xj7wxnStoTiuQOXE1NqGSP//T22aoSmcyqcPJkO76q5m5uDehFI/pBgf4rLyB/GFR9fRxWzbIJXOuS/jpreHIkfuLcEVu45+Z5H6yng78K+aA76vth41AKg2Mt81iNqfm4eym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839064; c=relaxed/simple;
	bh=PKUNOwIpuUE5YO5nXlI0AOnbmxAlCcv9+44QlYtduwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qmo27YW6uQMNklZP8fQVF6rSHvL9jQPLbz9qfWA9oi+AVevPFyBGFdkZBKcC0eDlcX+npqx71qAg6jLIfv+eTbUgdMfRw9p1OrFwCPXh3FLUsp/rcMYiyH7ctFweH1J0O1eCDoeKP59/JIDNABvYpDNvPxybXo17HKMgVZMvoUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8Uncq5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C61C4CEE4;
	Wed, 21 May 2025 14:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839064;
	bh=PKUNOwIpuUE5YO5nXlI0AOnbmxAlCcv9+44QlYtduwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8Uncq5heV8YgpaxK/ezZHH+Yuw74bNgNs6OnHGKTeX/HF2qh1AY+xtwRD5l/WSHg
	 47b7DjeZKLPRch+sw5LjP4DRInpPkH79onCjXrcXxZYnLxNi0dFGQutCnmQw6Iz2dQ
	 3vXueZbFxG+Bt7UuWwxUvBpPsM0MIZae5HqQXDvdRRuvo3J+sP3gu3MrHbLKwttSJW
	 McrmjDA21W/WGPul607OjXPSatq/T77+AlmAxkbEIzhvpvamYnJhyI1XeW0/GtkT2Q
	 1jh9X4lraHX+AMj7iditTyp1ReVU3VXjFVpUqwX7L4q/ynxi5H2Rn7lE3tinM4h/XP
	 yeAcuHtaLo4AA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6 13/26] af_unix: Save listener for embryo socket.
Date: Wed, 21 May 2025 14:45:21 +0000
Message-ID: <20250521144803.2050504-14-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
In-Reply-To: <20250521144803.2050504-1-lee@kernel.org>
References: <20250521144803.2050504-1-lee@kernel.org>
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
index 37171943fb542..d6b755b254a17 100644
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
index e54f54f9d9948..4d4c035ba626d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -978,6 +978,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_max_ack_backlog	= READ_ONCE(net->unx.sysctl_max_dgram_qlen);
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
+	u->listener = NULL;
 	u->inflight = 0;
 	u->vertex = NULL;
 	u->path.dentry = NULL;
@@ -1582,6 +1583,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	newsk->sk_type		= sk->sk_type;
 	init_peercred(newsk);
 	newu = unix_sk(newsk);
+	newu->listener = other;
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
 	otheru = unix_sk(other);
 
@@ -1677,8 +1679,8 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 		       bool kern)
 {
 	struct sock *sk = sock->sk;
-	struct sock *tsk;
 	struct sk_buff *skb;
+	struct sock *tsk;
 	int err;
 
 	err = -EOPNOTSUPP;
@@ -1703,6 +1705,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
+	unix_sk(tsk)->listener = NULL;
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
-- 
2.49.0.1112.g889b7c5bd8-goog


