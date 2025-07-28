Return-Path: <stable+bounces-164936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB05B13B81
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECC71884126
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6882676DF;
	Mon, 28 Jul 2025 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc2GYVTH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF1264625;
	Mon, 28 Jul 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709378; cv=none; b=dv89ir37bSRBT/J1YQnJD3XepCaax8/Y0kxHlYazjixqTyBglPskUSI7JBxclVZVCJcy5cx5MKhA0/ZG+F9XTO++bfyt+d2fTc2fPAbAOBS0DbcyAhAsSI/HxoUDw1326d8jN2D4BSmgoRW6iQ25hNn3SILXCz/eaOXPAHSeevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709378; c=relaxed/simple;
	bh=ajIsIPGdqkDtuGr8nwg2OjjGRVFb6CUhknoCIztH9rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYb7jiOe/WVRTlhCjNcVPF7iadMqy3N1MU9uSrQfnS2kCnObkcfIU/xQVuxSSNwsJrut+aitwfbi7CsN2T76A8ucdCBNf0hRRj1hTm7cChTvgM/RcVB4Ck+xY0j8Qs6P4fZvDyeuO8Ih/dPwHT3aiz3es+YrEAGHVlvBQPZiqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc2GYVTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A39FC4CEF8;
	Mon, 28 Jul 2025 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753709377;
	bh=ajIsIPGdqkDtuGr8nwg2OjjGRVFb6CUhknoCIztH9rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lc2GYVTHk69+rh2DMmd3Pax5bQ9bsE3iJKxquSwgEe4lyV06PAou89O63wObSRViC
	 H4QiAu8hbJoUQjFfnqxWOo2EcFW6SroUzNug+ET65e8iDHazrvRm/rO7opTOUbQiLc
	 qQBH5YHoxC5vXU7RvxZ0W9czS6HYC4XWK80KjVbWKnfa1BIgK8+tTPDyjpO68Raz7q
	 NLuSikFgtzEveO7RakWV1gZdqLhAhXge+Er8aiwT+JMCwPaxt8gJCg0C5cQSo/yxXD
	 FML8XEROBi6IOE4JXr5Cs1hBWwbTYgrS/IHcp1Z/8DRyVR+qbzqx5doUhvU0WJzEFG
	 e/WBwBQ9EOfbQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 2/3] mptcp: plug races between subflow fail and subflow creation
Date: Mon, 28 Jul 2025 15:29:22 +0200
Message-ID: <20250728132919.3904847-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250728132919.3904847-5-matttbe@kernel.org>
References: <20250728132919.3904847-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7484; i=matttbe@kernel.org; h=from:subject; bh=6ZgUWt+C+BU2mwxkJxeLetLROoJ7tZVUltObvgt8/5c=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLaq405Mguv3J/aYbe551TEwamxh771Fu9qnf2oxVzVe 7L8lW2TOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZS5snwP3TPqcCtbJ/+xzl6 t+4Ofv7EgGnS9z1zLzul3D/1LT/p7ESG/26h/KwSupnfHKQURD7PqFEXvjD1n92qxR9KyqZeiD/ KyAUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit def5b7b2643ebba696fc60ddf675dca13f073486 upstream.

We have races similar to the one addressed by the previous patch between
subflow failing and additional subflow creation. They are just harder to
trigger.

The solution is similar. Use a separate flag to track the condition
'socket state prevent any additional subflow creation' protected by the
fallback lock.

The socket fallback makes such flag true, and also receiving or sending
an MP_FAIL option.

The field 'allow_infinite_fallback' is now always touched under the
relevant lock, we can drop the ONCE annotation on write.

Fixes: 478d770008b0 ("mptcp: send out MP_FAIL when data checksum fails")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250714-net-mptcp-fallback-races-v1-2-391aff963322@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in subflow.c, because commit f1f26512a9bf ("mptcp: use plain
  bool instead of custom binary enum") and commit 46a5d3abedbe
  ("mptcp: fix typos in comments") are not in this version. Both are
  causing conflicts in the context, and the same modifications can still
  be applied. Same in protocol.h with commit b8dc6d6ce931 ("mptcp: fix
  rcv buffer auto-tuning"). Conflicts in protocol.c because commit
  ee2708aedad0 ("mptcp: use get_retrans wrapper") is not in this version
  and refactor the code in __mptcp_retrans(), but the modification can
  still be applied, just not at the same indentation level. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       |  8 +++++++-
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  7 +++++--
 net/mptcp/subflow.c  | 19 ++++++++++++++-----
 4 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 34120694ad49..6392973b1fa7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -309,8 +309,14 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 	pr_debug("fail_seq=%llu\n", fail_seq);
 
-	if (!READ_ONCE(msk->allow_infinite_fallback))
+	/* After accepting the fail, we can't create any other subflows */
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
 		return;
+	}
+	msk->allow_subflows = false;
+	spin_unlock_bh(&msk->fallback_lock);
 
 	if (!subflow->fail_tout) {
 		pr_debug("send MP_FAIL response and infinite map\n");
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 904a348daa51..73e298f276a8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -885,7 +885,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
 	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	msk->allow_infinite_fallback = false;
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
@@ -897,7 +897,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 		return false;
 
 	spin_lock_bh(&msk->fallback_lock);
-	if (__mptcp_check_fallback(msk)) {
+	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
 		return false;
 	}
@@ -2707,7 +2707,7 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
+		msk->allow_infinite_fallback = false;
 	}
 	spin_unlock_bh(&msk->fallback_lock);
 
@@ -2835,7 +2835,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
-	WRITE_ONCE(msk->allow_infinite_fallback, true);
+	msk->allow_infinite_fallback = true;
+	msk->allow_subflows = true;
 	msk->recovery = false;
 
 	mptcp_pm_data_init(msk);
@@ -3673,7 +3674,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
 		spin_lock_bh(&msk->fallback_lock);
-		if (__mptcp_check_fallback(msk)) {
+		if (!msk->allow_subflows) {
 			spin_unlock_bh(&msk->fallback_lock);
 			return false;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a3acc7042ee9..e1637443203e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -314,12 +314,14 @@ struct mptcp_sock {
 		u64	time;	/* start time of measurement window */
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
+	bool		allow_subflows;
 
 	u32 setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
 
-	spinlock_t	fallback_lock;	/* protects fallback and
-					 * allow_infinite_fallback
+	spinlock_t	fallback_lock;	/* protects fallback,
+					 * allow_infinite_fallback and
+					 * allow_join
 					 */
 };
 
@@ -991,6 +993,7 @@ static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
 		return false;
 	}
 
+	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d21109a130ec..cff232810692 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1168,20 +1168,29 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		mptcp_schedule_work(sk);
 }
 
-static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
+static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	unsigned long fail_tout;
 
+	/* we are really failing, prevent any later subflow join */
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+	msk->allow_subflows = false;
+	spin_unlock_bh(&msk->fallback_lock);
+
 	/* greceful failure can happen only on the MPC subflow */
 	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
-		return;
+		return false;
 
 	/* since the close timeout take precedence on the fail one,
 	 * no need to start the latter when the first is already set
 	 */
 	if (sock_flag((struct sock *)msk, SOCK_DEAD))
-		return;
+		return true;
 
 	/* we don't need extreme accuracy here, use a zero fail_tout as special
 	 * value meaning no fail timeout at all;
@@ -1193,6 +1202,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_send_ack(ssk);
 
 	mptcp_reset_tout_timer(msk, subflow->fail_tout);
+	return true;
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
@@ -1261,12 +1271,11 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		    (subflow->mp_join || subflow->valid_csum_seen)) {
 			subflow->send_mp_fail = 1;
 
-			if (!READ_ONCE(msk->allow_infinite_fallback)) {
+			if (!mptcp_subflow_fail(msk, ssk)) {
 				subflow->reset_transient = 0;
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
 				goto reset;
 			}
-			mptcp_subflow_fail(msk, ssk);
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
 			return true;
 		}
-- 
2.50.0


