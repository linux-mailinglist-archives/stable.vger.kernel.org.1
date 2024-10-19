Return-Path: <stable+bounces-86901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C39A4C95
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 11:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB01C20A56
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 09:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DEA1DE8A9;
	Sat, 19 Oct 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ+X6vSg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DBA20E30B;
	Sat, 19 Oct 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729330257; cv=none; b=n1Etc63+GvV3h0cCe2J/GTgN7+FR/1Z6QfaWl5gXm9Gi2gALsoJijkT93hABGYI+l5ksTgAr08QVpV4DX4uBo8oh3Kba7UkyyoGmsyab6t96WZPKW87O+PDur1uym3+x5h58sEHUrGwpI7eUABy11beYhBXIwHAW9yimMwNQ1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729330257; c=relaxed/simple;
	bh=dEhaXs008IelrVlpIGrKqx72zRXIFdSAvep1dnwSKUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ue8I7yluCsc7Or0zV6Cc8HAZWrttBBi9IY+B4MMO3yVuu/7bjRi7LHIFoKDoo7V0sj9nRJWTDLvx+gmFP28svUBo1EE/l+XRMA2N6nb6wu/+ZNzCLmf9T5e+SeLxAaD2DiDvFi2p8wmF0EfXF512lF7+hwXWGr9vi9i2DmhJ0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ+X6vSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F01EC4CED0;
	Sat, 19 Oct 2024 09:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729330257;
	bh=dEhaXs008IelrVlpIGrKqx72zRXIFdSAvep1dnwSKUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJ+X6vSgzjUdHZoZuMwuVchIDwh9PN+lG5DNH4m5gMFQNTSGzHjFOpEhGfdkbWuD/
	 siyo1TnF9dUwgKNaZWC2hLwvFpMrpynGKhiqjPLLltf0I/3YOEp4v4j80mc08DEebv
	 jbm/3TivWkkxXP1MyFIbkXKADcHu8PtGvKBNvUwtyAtjnlGk3gdu5jTeikm+/Jdc5i
	 IuWbLNp38JEHS851Fngw9YMXRc+1MR+OpbJOfph6yWowMDCLw8s7ZS9Hf7BDCDij3z
	 +kCgI9Cneprt0rif05KfpYKdEFVO7ga6wm8w18xirnR9jpPxLJxaztHUfm/krJLJLb
	 GI4i01dwiDzAg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	sashal@kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.15.y 1/6] mptcp: track and update contiguous data status
Date: Sat, 19 Oct 2024 11:30:47 +0200
Message-ID: <20241019093045.3181989-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241019093045.3181989-8-matttbe@kernel.org>
References: <20241019093045.3181989-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=matttbe@kernel.org; h=from:subject; bh=MKSVi7yEwyagbUCOqgzGFgk8trdkA4n0xEqTsM+rmaY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnE3xFJr21UYipsChfeTnVU9WqObdx49dAtn+u5 6Sd6aYoZOSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxN8RQAKCRD2t4JPQmmg czakEADb2LcUpiuz7Dhp9gU+HSuK0uVmRqc2R/BKcBb3vu1GSJnLrX3B46t6qWgz4fw4Bv11BRQ 3n7alE3HoOawKzNxhM7XI1CpERklzBd7upmZbYCD5lnSlgQVTmOQOupqoAAkfMUVzDS4iDWRt2P 4qNPXI1i7GFA/WeI93fMZyx/5Z9m81fOtoAxyf6S78X1XGxmmtxkD0FMzcUO6DzcbGQf2wQ/+PQ mIZYtvlF1QN0tzqv2oEMKpt6waSIQn/ph3xnGnsf0QKfy7OOC3YP9JSE+uDzjhoVbyCR/UQiK4g IHP2hauY9fi+CwHmkQTnweUWjXU/5r4kGiI6X0jO42onbbCTBR2iY6//V6yccazniH7nfZAmmpm tV4XzuFA4jjNdthlG5on4+DwkfZwofI5kgOVg2p1o14oANXwxfs6PaNKqGeX2R7S9KDyVU+2L8G WWdAOmt8dONVIQ6iyvCOjDppPid3ATRKCm2v1Khv2SwkJpkguiCkER68oJrBsO3+rr+K0jslaGu wHkd26643KzBaQOu4E6x26SmnE7cxPMEU/pRsuHI/Qd10B/cEcUY+eFxUldO1gHe9qVNQy3/+3K GkLrakwKwrZH5gCrNTsXwZLQzYdUdwEgdLTeTJSPz0D2pScsr2i1ksIR1xMx4DDePzwHWeRL0Ct gDYJmImKEUKcprg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

commit 0530020a7c8f2204e784f0dbdc882bbd961fdbde upstream.

This patch adds a new member allow_infinite_fallback in mptcp_sock,
which is initialized to 'true' when the connection begins and is set
to 'false' on any retransmit or successful MP_JOIN. Only do infinite
mapping fallback if there is a single subflow AND there have been no
retransmissions AND there have never been any MP_JOINs.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
[ Conflicts in protocol.c, because commit 3e5014909b56 ("mptcp: cleanup
  MPJ subflow list handling") is not in this version. This commit is
  linked to a new feature, changing the context around. The new line
  can still be added at the same place.
  Conflicts in protocol.h, because commit 4f6e14bd19d6 ("mptcp: support
  TCP_CORK and TCP_NODELAY") is not in this version. This commit is
  linked to a new feature, changing the context around. The new line can
  still be added at the same place.
  Conflicts in subflow.c, because commit 0348c690ed37 ("mptcp: add the
  fallback check") is not in this version. This commit is linked to a
  new feature, changing the context around. The new line can still be
  added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 +++
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index da2a1a150bc6..73a0b0d15382 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2472,6 +2472,7 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		WRITE_ONCE(msk->allow_infinite_fallback, false);
 	}
 
 	release_sock(ssk);
@@ -2549,6 +2550,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
+	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
 
 	mptcp_pm_data_init(msk);
@@ -3299,6 +3301,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	if (parent_sock && !ssk->sk_socket)
 		mptcp_sock_graft(ssk, parent_sock);
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 out:
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9e0a5591d4e1..5d458c3161cd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -249,6 +249,7 @@ struct mptcp_sock {
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
+	bool		allow_infinite_fallback;
 	spinlock_t	join_list_lock;
 	int		keepalive_cnt;
 	int		keepalive_idle;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e71082dd6484..412823af2c1d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1219,7 +1219,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 fallback:
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+		if (mptcp_has_another_subflow(ssk) ||
+		    !READ_ONCE(msk->allow_infinite_fallback)) {
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 		}
@@ -1481,6 +1482,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	return err;
 
 failed_unlink:
-- 
2.45.2


