Return-Path: <stable+bounces-47629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D43D8D33DC
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EF62853B5
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C0178CCD;
	Wed, 29 May 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRd/i9/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A94115B14A;
	Wed, 29 May 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976836; cv=none; b=aPNB5VoWpfxKJqJlArU4ex59vNUZhkPX6vJ1bZqu9zoIGzHX76FJ8Bvbr/K8BKTa2+a1Jw+ddWr59/6pkdhY8QrVSFAGqUp+FzIyyXUNQzw54ifcyXi8dpzMcH/x15nNTZGSabvMJ/ofOhumKDwK7gJwiDd7dliT7FLSRA3IImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976836; c=relaxed/simple;
	bh=Bp2lrsd5Pt0fAdnTuT1CMGHP7lrKu32mKn8vsxswefI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsEbyU7M7ftHo6wJAUGrCH88kvHGgx3urOv2ok5lnYrKIVFSEcQzAxIrP/ocgnm3fv5QQjjh+AP3zuXpwPbQyYs5tGlXzbhSYK8zlNEVIICeTt6kpEeBx2BB5wFJs9FeucSpxP66TFnsoMjkn0iN7tHmTk3WLP2OnczNyt9oSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRd/i9/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D892C2BD10;
	Wed, 29 May 2024 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976836;
	bh=Bp2lrsd5Pt0fAdnTuT1CMGHP7lrKu32mKn8vsxswefI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mRd/i9/vHfrxv6Byj4GZFcXqmnmJxgKFXctE7lvizNtm+/rpliSQp0M8wXwtRboBf
	 g0anuDSMIa31+UauKwDUBLcQaKief4b9wFEdCaVPvvb90I/Q18Xwi9nz3vGMCTsXTz
	 uiXHNgbose1rJ3Swa9S+ZsClo3qOcj+cGLK9hY47bm9y7rd7jHbFSCy2B3XPkk1L14
	 XaFSWogNEPRCx5l7Teun6gzQ6s8220Lfg6tq3t9+pNWPxAyTZ+OLi1W1m45P9594xu
	 15sftRi6ZXZxdqDphDJ5ZYVMS5O1Vlh6s19M9O5qPFXzKxN4pz/eSHhuoXr5TH7rtA
	 PDvdIDwBfkmMQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 3/3] mptcp: fix full TCP keep-alive support
Date: Wed, 29 May 2024 12:00:26 +0200
Message-ID: <20240529100022.3373664-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529100022.3373664-5-matttbe@kernel.org>
References: <20240529100022.3373664-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6715; i=matttbe@kernel.org; h=from:subject; bh=Bp2lrsd5Pt0fAdnTuT1CMGHP7lrKu32mKn8vsxswefI=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVvy3NZAtLp9eF2ZxMu3hKHvWiji+HEB2uZSgE 76Sdm+RZXeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlb8twAKCRD2t4JPQmmg cyGUD/402c2izreF0/J4NFzws5HrYHmtqEqrtCjbO1bhXeW3lHbk8YtWCvBaiJmSAM01QhOXXoq 0hgvHC2l3iB6JcZc27k5ax3uoTn+Vr057IwOqrqiTxvbKdan/ox4nQx9R08+L6LKgOwPVE2akRr Y1mz9ZCXRgwW5Z2pOPQ7yWdBWebeOcyHwLQ9rpayAv/vGSRbSz0/TNje1cOUP+Zuy5M3YDlI1An /EoanZhQ5l2EWKmQXzPLf6tG/sEvgJ3psuSv2OA4VmhqH+MqUGoXeCetDGWkTy5VQbryXNzoqzr 5mIqcyUYRj3xi9hbrPOs9sRCiTlWLFN7Ufms+dv0DAOZGjt3m0uEAEbQtj0ytS6GMFrO7x2AFSv rwefbXMd/OqystGmqP3IliyNv+3kbgGeuDF/zxHbkXSyzN8eK9EZzOPxdsB6P+xohX5h8bjcohX hE7dO8PScgrETxSxndqBK3ZHBmT223XiPEN17VGMFldeW0Dt5FFu7dctx5MjbscP/B4VwWNvgeX wtaHCu22mYtELt//xjB6SKqHLKb+BF2w174ba9/gsiGLBC8yn1umgSZXdGZZTRfi7V8MfcBSczB pfP1DHEztxpbylLPnhghIWkWvdgrSc2uiMWWkI+TEwRsA/JZhQQQxv+TMBMaiglNAe1+rVjJy/M 5oVQb1MqO12Vvpw==
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
[ Conflicts in the same context, because commit 29b5e5ef8739 ("mptcp:
  implement TCP_NOTSENT_LOWAT support") (new feature) and commit
  013e3179dbd2 ("mptcp: fix rcv space initialization") (not backported
  because of the various conflicts, and because the race fixed by this
  commit "does not produce ill effects in practice") are not in this
  version. Also, TCP_KEEPINTVL and TCP_KEEPCNT value had to be set
  without lock, the same way it was done on TCP side prior commit
  6fd70a6b4e6f ("tcp: set TCP_KEEPINTVL locklessly") and commit
  84485080cbc1 ("tcp: set TCP_KEEPCNT locklessly"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h |  3 ++
 net/mptcp/sockopt.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2bc37773e780..eaed858c0ff9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -288,6 +288,9 @@ struct mptcp_sock {
 			fastopening:1,
 			in_accept_queue:1,
 			free_first:1;
+	int		keepalive_cnt;
+	int		keepalive_idle;
+	int		keepalive_intvl;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 7573bbd15f84..ff82fc062ae7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -616,6 +616,52 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int __tcp_sock_set_keepintvl(struct sock *sk, int val)
+{
+	if (val < 1 || val > MAX_TCP_KEEPINTVL)
+		return -EINVAL;
+
+	WRITE_ONCE(tcp_sk(sk)->keepalive_intvl, val * HZ);
+
+	return 0;
+}
+
+static int __tcp_sock_set_keepcnt(struct sock *sk, int val)
+{
+	if (val < 1 || val > MAX_TCP_KEEPCNT)
+		return -EINVAL;
+
+	/* Paired with READ_ONCE() in keepalive_probes() */
+	WRITE_ONCE(tcp_sk(sk)->keepalive_probes, val);
+
+	return 0;
+}
+
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
@@ -805,6 +851,22 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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
+						 &__tcp_sock_set_keepintvl,
+						 &msk->keepalive_intvl, val);
+		break;
+	case TCP_KEEPCNT:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPCNT,
+						 &__tcp_sock_set_keepcnt,
+						 &msk->keepalive_cnt,
+						 val);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1163,6 +1225,8 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
+	struct sock *sk = (void *)msk;
+
 	switch (optname) {
 	case TCP_ULP:
 	case TCP_CONGESTION:
@@ -1178,6 +1242,18 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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
@@ -1282,6 +1358,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
 	__tcp_sock_set_cork(ssk, !!msk->cork);
 	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
+	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
+	__tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
+	__tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 
 	inet_sk(ssk)->transparent = inet_sk(sk)->transparent;
 	inet_sk(ssk)->freebind = inet_sk(sk)->freebind;
-- 
2.43.0


