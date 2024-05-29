Return-Path: <stable+bounces-47625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0108D33D5
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B901C21DF9
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061416A360;
	Wed, 29 May 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvwvpBil"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B716E89A;
	Wed, 29 May 2024 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976718; cv=none; b=FklNxWLiyoFARe7vVstDQ1lesr/jSmrnmGWroQEgEYh2s/m5CYKA/hzh3IhX6hvXtNWzKFTlLIg+kzfJ/SxNzGjIJhlPclK8562Os3WXZK2NuAE0CA9hPQ00pFk1o3S5sd1Ny/ODWIvcrq+7E88ewgFqtXF8FqGf1vIIfqnpMqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976718; c=relaxed/simple;
	bh=mvKwxshAnxrKx8XmOlEBl3EAOqIMUm8g46OR8yj4BOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiZX2nVXe7KvrlQheEUXK33dehQhq2QCOL1UaxL+O0wcAHc0/WtvvUynasBczMIfFNu4DkTljQ/0LknFFDQk0fLXUfQStCLiD6BU924MbK0PAOPbGag6MWfTW5qZYvcUCNW0XsA5Qq1crUbDkZc1mNYWMXjGyyhWBx6F6yGmUwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvwvpBil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5727FC4AF08;
	Wed, 29 May 2024 09:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976717;
	bh=mvKwxshAnxrKx8XmOlEBl3EAOqIMUm8g46OR8yj4BOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvwvpBileoL82Dab6xNsMIzoPM9Br8tghKj2YMJebLc9DX/taqs1ws8QMpIXiDvwl
	 +IBSmWQg63gUmP9jBcfC+hYWn/7tB4syY7Fmq3y5M0kurU09c6fwNwDtyk5WsKjCEJ
	 IaWJBUOwtmgL0habo9uNsBs7aTVTig+6YoYW0rfWP0aNfpsVWJcmFrxQK9xo+8B7yX
	 7gWCONP80GhuPTkT2/psw9idEE+oIhHUwFHpFcbQufQRYkCQRQdQmqCzxkCcWGtSe2
	 yk2WeOKN+pRjBHKVifHTprOT+WopVBH7FznruQe7KTStqQpSRBsaynBqI7Qty+esVC
	 PQV1oBOxc4lDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 3/3] mptcp: fix full TCP keep-alive support
Date: Wed, 29 May 2024 11:58:21 +0200
Message-ID: <20240529095817.3370953-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529095817.3370953-5-matttbe@kernel.org>
References: <20240529095817.3370953-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5798; i=matttbe@kernel.org; h=from:subject; bh=mvKwxshAnxrKx8XmOlEBl3EAOqIMUm8g46OR8yj4BOA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVvw5KXps3GAi1GgdsnQ6tLbwXzUAUUXoCJxzz Lr4xc4/FSSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlb8OQAKCRD2t4JPQmmg czaXEACHgK+Fq22D9lEw+L3/OUnKkcL/FWRjCatKKUIzUAjuMnF7Ebq8lbt9AqVdTufRx3fH5kO LgRdOlBQpllKr9XYMZeeYIigFV1Y4vhNeTOiyk89+88OG8r4ogpQuMePAxcyceBuCh4Ey6aRWkZ zCF7OesQXH4vwbSpd0ARVu5Ld+EjpWq8ngJ+5hYgZX6PXcNXLOTrZi3gtf4TbjZtdVG0riIW5Ni UUBRGx46GocQ56NWqdHzcST4Ochf3dCDbLDqT3mhbM+fiF0jf6rSlnUdore8G5qF4E5h/4XQlsS FgF1u7waNKCluJ8bRP9lIjdcgu42+A43Cl1i6XiYQnCnUuZ7y6SlrB9Lo5JI5HL3pcCj/pbATZO d3aOUHcSKeLBmnPePs2UMwIkBbzcws0EazRkOPWyDUR98fry7ge59+MuYBi/Y1klyZtYA0OApGi XwVy3+AMUt7v6NAZlI2oVYV0gcjmz4TTFJ5i998zfGO1r6QXLF6bqvIM/H3HfMKWqYkXyVdYfMf BkKzE5oWi+Ff42WnDT1PET0YNhBwqnOjmL89SBWyyLyfIj73VW/egK6dqOZa4YRgtNQmihVyPLT ibL7we9yPWVWUYfahXQQW2VmWYboSq4gwKd7Z6QjTA9C9IqmAy9JNWZ6LlbuTxL3m34/OXGrocX d0fH+h5bpfaMwjw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit bd11dc4fb969ec148e50cd87f88a78246dbc4d0b upstream.

SO_KEEPALIVE support has been added a while ago, as part of a series
"adding SOL_SOCKET" support. To have a full control of this keep-alive
feature, it is important to also support TCP_KEEP* socket options at the
SOL_TCP level.

Supporting them on the setsockopt() part is easy, it is just a matter of
remembering each value in the MPTCP sock structure, and calling
tcp_sock_set_keep*() helpers on each subflow. If the value is not
modified (0), calling these helpers will not do anything. For the
getsockopt() part, the corresponding value from the MPTCP sock structure
or the default one is simply returned. All of this is very similar to
other TCP_* socket options supported by MPTCP.

It looks important for kernels supporting SO_KEEPALIVE, to also support
TCP_KEEP* options as well: some apps seem to (wrongly) consider that if
the former is supported, the latter ones will be supported as well. But
also, not having this simple and isolated change is preventing MPTCP
support in some apps, and libraries like GoLang [1]. This is why this
patch is seen as a fix.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/383
Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
Link: https://github.com/golang/go/issues/56539 [1]
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20240514011335.176158-3-martineau@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ conflicts in the same context, because commit 29b5e5ef8739 ("mptcp:
  implement TCP_NOTSENT_LOWAT support") is not in this version ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sockopt.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cf30b0b1dc7c..93ba48f4ae38 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -303,6 +303,9 @@ struct mptcp_sock {
 			in_accept_queue:1,
 			free_first:1,
 			rcvspace_init:1;
+	int		keepalive_cnt;
+	int		keepalive_idle;
+	int		keepalive_intvl;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index e33d721ed37e..cc04b5e29dd3 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -621,6 +621,31 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
+				      int (*set_val)(struct sock *, int),
+				      int *msk_val, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	int err = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ret;
+
+		lock_sock(ssk);
+		ret = set_val(ssk, val);
+		err = err ? : ret;
+		release_sock(ssk);
+	}
+
+	if (!err) {
+		*msk_val = val;
+		sockopt_seq_inc(msk);
+	}
+
+	return err;
+}
+
 static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
@@ -803,6 +828,22 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_NODELAY:
 		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
 		break;
+	case TCP_KEEPIDLE:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPIDLE,
+						 &tcp_sock_set_keepidle_locked,
+						 &msk->keepalive_idle, val);
+		break;
+	case TCP_KEEPINTVL:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPINTVL,
+						 &tcp_sock_set_keepintvl,
+						 &msk->keepalive_intvl, val);
+		break;
+	case TCP_KEEPCNT:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPCNT,
+						 &tcp_sock_set_keepcnt,
+						 &msk->keepalive_cnt,
+						 val);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1303,6 +1344,8 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
+	struct sock *sk = (void *)msk;
+
 	switch (optname) {
 	case TCP_ULP:
 	case TCP_CONGESTION:
@@ -1321,6 +1364,18 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->cork);
 	case TCP_NODELAY:
 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
+	case TCP_KEEPIDLE:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_idle ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_time) / HZ);
+	case TCP_KEEPINTVL:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_intvl ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_intvl) / HZ);
+	case TCP_KEEPCNT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_cnt ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_probes));
 	}
 	return -EOPNOTSUPP;
 }
@@ -1430,6 +1485,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
 	__tcp_sock_set_cork(ssk, !!msk->cork);
 	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
+	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
+	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
+	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
-- 
2.43.0


