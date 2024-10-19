Return-Path: <stable+bounces-86909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C89A4CDD
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 12:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769E71C20F51
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227231DE8B0;
	Sat, 19 Oct 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovh6Lazu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710356B81;
	Sat, 19 Oct 2024 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729333754; cv=none; b=TDgN9ehDWJfOug/UQjA8U0JPmA4Hfcy4GKwJfR/5Y/1G8lqBLSMPWRHERW79VduoS4I/Vbu4RODNog0awAgS8jKJUrRKLbiekQop5emaOy8DfobpcmVlWwtKdwSL9fG05qfjVi/kui8TXxreQ4mGM9U9hCeKwmL7fHWCIPD6R5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729333754; c=relaxed/simple;
	bh=VpqFXISswc8exQVEP8luyYLRhtlSzgWomoKX4ar6WoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgNyWUbGr/Pc4klIKZ6Mgn8GnIHH4o8hPmjQ5ACATm+kVLWNaHLUmM2YQbrZ0Nx5OQ5B82amr6wEfC0xDqQ6o9I4IKhqenveL8uIXSW2lxk+v3WXtwt+lDSTR+Fd8HdI1doV/RXWkwa8m52fgTFsBb5psiGev1GdgHfy8IkWh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovh6Lazu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DF0C4CED0;
	Sat, 19 Oct 2024 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729333753;
	bh=VpqFXISswc8exQVEP8luyYLRhtlSzgWomoKX4ar6WoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovh6Lazu60JYAgmyPwfFmF5eCJn7IwcTLnvmNsRKSbJ3M2lMi3jdLwT8+/IP5CKKV
	 rfh8UN4e5PmrRTvC2BMEAPu0g1lSnJ1DOHVKYA9Dfx7jxGnDjOvsdR278x9Ybj6h5+
	 ttWMciNvOrOXC/3j8TmDDiQuAgWVhHcHTeuGsnB5TwK0zOe66kxaiZyUnFRNZIiU/D
	 EaEKZoJfbeT11pjK7iqjIh+5odk49SehQak30yV8y9w74KX1t3DTBPWf+Uagg5nqOR
	 opq8jTFbxAmxF+NjwrHmOi8zMx4TB436oxsBOkaMXICewiPxikweKcO4uyD2BPjn78
	 dqh3oNQAOl8/Q==
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
Subject: [PATCH 5.10.y 1/3] mptcp: track and update contiguous data status
Date: Sat, 19 Oct 2024 12:29:07 +0200
Message-ID: <20241019102905.3383483-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241019102905.3383483-5-matttbe@kernel.org>
References: <20241019102905.3383483-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3622; i=matttbe@kernel.org; h=from:subject; bh=cJMz9CWTxnjL18zdD09XUIClsjXXzQuv24tkpzLXHU0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnE4nxMaHon3IvNEswAXCDyNUjkXFlqX3rGmULZ kXc6kgDtYqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxOJ8QAKCRD2t4JPQmmg cw/mEACjdEVjTtBkB5FcGWduudkB6G6xJSMvCRnGE88QVPajUhWDzKJc5vaCjrVUDrXcFtozFz8 zJVE7NfnwPD+6m+3T6KG1PEIcjylW9BKLWBJLshDRjr5TZLRBjRj7tW6H1sapEEzf3tB0sWxKMn +rR1l4ZBjxVGIDGvD4rY9kpwaac187JXtLtmqwEMF7eGxKmV1Eq2nm2xY35scT1PVE/PbC5NXzl 0bKr4uaIJ8tCyxkHYcAR+edvCl3IpNIILg7mK5lkLSECDls2qAgzZF5B20KfUvquwBFukgfHft8 UDUPbHixMEJboNMy4bYJCSPJFXbbG0LJu5mmel/An3kMPO2JIuu7H7AfnMAx39YfizkbtU3Xg1Z xTi3a8SFFnI+re3IDUSzFNNh83hbD5s4jv1ER1grLE98gHDsVgyh5S62BqN03Lu6xYZXaU45Vuj tfGxofdaIW+eFANIP/vw0z+UFw+XoxSIDPlz3/xBUUmzlqvj74AHNl+vHTIN2af1dCfnjM8QlPN qzAvp4lD4DJ8FxXM+P5fyH/jfuGcqNhiXZiYdZ52eJRsJCScXlyV1IJsGCxDiLhlmH28pFN+Cuq SlpQN/rxGAduMmfSOtUK0AVCP4lDKVVyeKwZqzP7I5eUtUUZ3/ZsEyQjfAyOZK6xWK6e+ZpCE7z vqHBzEGuFTgRmaQ==
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
  added at the same place.
  Extra conflicts in v5.10, because the context has been changed. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 +++++-
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 590e2c9bb67e..24a21ff0cb8a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1810,9 +1810,11 @@ static void mptcp_worker(struct work_struct *work)
 		if (!mptcp_ext_cache_refill(msk))
 			break;
 	}
-	if (copied)
+	if (copied) {
 		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
+		WRITE_ONCE(msk->allow_infinite_fallback, false);
+	}
 
 	dfrag->data_seq = orig_write_seq;
 	dfrag->offset = orig_offset;
@@ -1845,6 +1847,7 @@ static int __mptcp_init_sock(struct sock *sk)
 
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
+	WRITE_ONCE(msk->allow_infinite_fallback, true);
 
 	mptcp_pm_data_init(msk);
 
@@ -2543,6 +2546,7 @@ bool mptcp_finish_join(struct sock *sk)
 	if (parent_sock && !sk->sk_socket)
 		mptcp_sock_graft(sk, parent_sock);
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	return true;
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 44944e8f73c5..2330140d6b1c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -213,6 +213,7 @@ struct mptcp_sock {
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
+	bool		allow_infinite_fallback;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 843c61ebd421..0c020ca463f4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1179,6 +1179,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	list_add_tail(&subflow->node, &msk->join_list);
 	spin_unlock_bh(&msk->join_list_lock);
 
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	return err;
 
 failed:
-- 
2.45.2


