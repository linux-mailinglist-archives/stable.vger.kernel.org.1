Return-Path: <stable+bounces-47630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD688D33EF
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69392855E8
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D574179970;
	Wed, 29 May 2024 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGybFY2Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF16176FD8;
	Wed, 29 May 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976906; cv=none; b=VHv3U6ZTu3ji3UiM4qCE5gmc6QdVq+hpbby3lx1ZNjcKOtM4T9NBSpT6QIXJxadkSaXadKC+1uWGsYEGEHDAd1NiQl5zR107PrSKgvE+LarEOlxYpeVOXh8FVtw04ZXGPYzgfyZJYBMdOuIxxoEQPB+E5mJWxlhIrURtLLH9yF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976906; c=relaxed/simple;
	bh=nh/XSjBObbOx6HpafG1Uepxj05v+qaURr87XVgDROdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rng94hsOHvg13jKweuFay5qcXAY+cGjNIZuBieTWVOB58REE4wQ5ZJigGTVFIvJXjP1T1BvBPrW4giSyWubQWyJXh3b5H7QZ6CaxdsYU17QMyN8M/wazOSMWdUJLuSBgULDFUpgqf+MKnMJTcyNbSUM6lkzFrKITgSmKoW0dx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGybFY2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8155FC2BD10;
	Wed, 29 May 2024 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976905;
	bh=nh/XSjBObbOx6HpafG1Uepxj05v+qaURr87XVgDROdk=;
	h=From:To:Cc:Subject:Date:From;
	b=KGybFY2Y+h2A1D77RMvPZjvLZ5MuV0FlF5nlaEidG/x+/48yKj7561q2u1vP8GwVM
	 vTyhM+TYI9WThfDe5nrD75SpzlUaVFlf7MI/s92FsA22W0OoZaa6fGy+rhOCMkCSfG
	 nlyy1VXdLRijLbjUuStI1UY7ZRB+KcF9q7uNEYi43dzR44kXqShnRmqFTmN3avJiGJ
	 +GrsRFdW3M5vX8iVVI3fLUDHFzhzAJy7c5Uv8GdK40rF82PZybL4NinNdI+8kre51A
	 UXh97uKubUSxEkn2CUsJKeuCN87lbDNWpZMvyctFllBgT2fIfp8uZx0wp8ag61D3Qy
	 5bCzYSJQk5zXQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: fix full TCP keep-alive support
Date: Wed, 29 May 2024 12:01:31 +0200
Message-ID: <20240529100130.3375226-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7789; i=matttbe@kernel.org; h=from:subject; bh=nh/XSjBObbOx6HpafG1Uepxj05v+qaURr87XVgDROdk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVvz6D8pCwCklPsUDJfYdjvJSHIJR1Q1y10u8H OJnDODXbMmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlb8+gAKCRD2t4JPQmmg c/XeEACGgyaCdA1rlu9ATWXRvKCJPNBavEQshlG4tvzyUAsKQIJ/qmo3hn+Rl84ni9g3kspRpuN wISYc5B9zFMteznrCLL0yhoS7fR4INHtsVRVb973Nz2Lx01ikuZ4r0+Di4oSpPnkPlm5SgibVYq F40cbwsfiywsoRPbwrt8bxHSKwyBqtNi2KEJau1loxzMKd9ak9QbaWUNV8JefCaE1k2a6wuU8JX xtgggXvx9Y0gaMV3gW4kLsTIzUPxHLLmlGljT92ytEAjr1TljmEJW3puiWtSCw2L6G6pH2Je5sr rIcULbrVd1EdUE9/KWJZAod0BUDdGfEYzWBN9wFE0Qm/qukPhRCz0c3dBGrzmCvK0n9F+JHBeA9 x8TRdxZf734LkZZZv2CLvArCCiqHyUFNy+gUcJrl1QhPosMXe/6ry3BmvoG4C3VgmmDsv1Dawk/ XmCeKmi0j0HQKWCSpDAtSwVRsZ/60pmXGhEqDYsGD2UtCVQgD5nu6IHr0skuVWrB9IGDN5amH0e Sryt6UhYZ8q3ZUyBUyuT45dYyQd6cQe7JAcsoNjGNMiCIJnAl85jKJx7VG/b6ycioiDXOBJ9Rmu LSB036JiBLEzw4bPcK577NN1zYdRV1kGeLQBXuCmwyMXdhAHpeUePSkzpLuGsjR2NAhGh0wDvqf UUHUFPqWXMeNJcg==
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
  implement TCP_NOTSENT_LOWAT support") (new feature), commit
  013e3179dbd2 ("mptcp: fix rcv space initialization") (not backported
  because of the various conflicts, and because the race fixed by this
  commit "does not produce ill effects in practice"), and commit
  4f6e14bd19d6 ("mptcp: support TCP_CORK and TCP_NODELAY") are not in
  this version. The adaptations done by 7f71a337b515 ("mptcp: cleanup
  SOL_TCP handling") have been adapted to this case here. Also,
  TCP_KEEPINTVL and TCP_KEEPCNT value had to be set without lock, the
  same way it was done on TCP side prior commit 6fd70a6b4e6f ("tcp: set
  TCP_KEEPINTVL locklessly") and commit 84485080cbc1 ("tcp: set
  TCP_KEEPCNT locklessly"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h |   3 ++
 net/mptcp/sockopt.c  | 115 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 78aa6125eafb..b4ccae4f6849 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -250,6 +250,9 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	spinlock_t	join_list_lock;
+	int		keepalive_cnt;
+	int		keepalive_idle;
+	int		keepalive_intvl;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index bd797d8f72ab..36d85af12e76 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -593,6 +593,60 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
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
+static int mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
+				    int (*set_val)(struct sock *, int),
+				    int *msk_val, sockptr_t optval,
+				    unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int val, err;
+
+	err = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (err)
+		return err;
+
+	lock_sock(sk);
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
+	release_sock(sk);
+
+	return err;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -601,6 +655,21 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return -EOPNOTSUPP;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
+	case TCP_KEEPIDLE:
+		return mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPIDLE,
+						&tcp_sock_set_keepidle_locked,
+						&msk->keepalive_idle,
+						optval, optlen);
+	case TCP_KEEPINTVL:
+		return mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPINTVL,
+						&__tcp_sock_set_keepintvl,
+						&msk->keepalive_intvl,
+						optval, optlen);
+	case TCP_KEEPCNT:
+		return mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPCNT,
+						&__tcp_sock_set_keepcnt,
+						&msk->keepalive_cnt,
+						optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -667,9 +736,40 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	return ret;
 }
 
+static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
+				int __user *optlen, int val)
+{
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+	if (len < 0)
+		return -EINVAL;
+
+	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
+		unsigned char ucval = (unsigned char)val;
+
+		len = 1;
+		if (put_user(len, optlen))
+			return -EFAULT;
+		if (copy_to_user(optval, &ucval, 1))
+			return -EFAULT;
+	} else {
+		len = min_t(unsigned int, len, sizeof(int));
+		if (put_user(len, optlen))
+			return -EFAULT;
+		if (copy_to_user(optval, &val, len))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
+	struct sock *sk = (void *)msk;
+
 	switch (optname) {
 	case TCP_ULP:
 	case TCP_CONGESTION:
@@ -677,6 +777,18 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_CC_INFO:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
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
@@ -746,6 +858,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
+	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
+	__tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
+	__tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 }
 
 static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.43.0


