Return-Path: <stable+bounces-164897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F00B13759
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD9C1894F73
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9431B4153;
	Mon, 28 Jul 2025 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPCuo7pZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B991B425C;
	Mon, 28 Jul 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694130; cv=none; b=DjWNUjkC8oCHtgOvD5kZVztMmtshsaCHNMWReIvM2qVrqupWueleOjOPdVgq38hvKwSfi2TXNq3FosPZdSmIpzVEQuUWfh673FjwKWQaA/9l1wZZzcTf6c9YY2qGwqOcSl3fqudwTsvtP6MDBNbHznVGTGLgMSuxGuPhuobhSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694130; c=relaxed/simple;
	bh=V1AXepVSnN3TRuxqtG1zw15qm/jfL12Rx78/VUrBG0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQNif4bgy2YQRoHVulvXThJU+zNo2UwpzMVcFPsaF0U0GCoedjjGncLouErBJwrNxguKzJBBq3VMHt17WXbn74eciWd+zf4/zDWv4ADZdvlyMmKA2rkY69kAsEJv9UBJ6orADy2ceRBed/qbOh/YtUwwwkfJtvibSMi6vLc0qXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPCuo7pZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2158BC4CEF8;
	Mon, 28 Jul 2025 09:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753694129;
	bh=V1AXepVSnN3TRuxqtG1zw15qm/jfL12Rx78/VUrBG0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPCuo7pZhzIT0h6JXflZ4D/q9NKG4R+nk6qh/4a1z9ndAwShtlm+xKr7bslHffrH9
	 JyWnxz5Un7KKFMjZ4Kj6pmEeMQsAkJnP8PGW3uv5FQ1UM+1JDkfBgiDfyq+P0keefW
	 1r/Fmc/aXuPFi3rGUY+VNPpWzoGRgOFJCRc/4FAfaYr+FOUjJNIEYe4bbCXQIxrdPF
	 fzMvVBmuv0BtzHgahDVXJpVaEhsi+S7cDlGD4Gd9ddLw0m5Q2CFTlC0U3hK8fX1Y5N
	 n5Nzo/umVcvPndDrB/JB9o1Ehz0pEShWWUbwBthHrKkmdmSYc38/fSjUgGLXgW3/es
	 TseZsLRszmbZQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 2/3] mptcp: plug races between subflow fail and subflow creation
Date: Mon, 28 Jul 2025 11:14:50 +0200
Message-ID: <20250728091448.3494479-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250728091448.3494479-5-matttbe@kernel.org>
References: <20250728091448.3494479-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7120; i=matttbe@kernel.org; h=from:subject; bh=y84ZVMoIQO1bfnOgAwoZr6kt3NRZLz+9Pn9xe+BNOw4=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLa7ae2yL3JXB654FKO312mW1KrdoXsm3PHRNP4mfjs7 NDVjep6HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZE8fIMOfiTs7dxxbu9t0l W3jkJZvzke+iLFPUGGbtst5y+Jno3kUM/0sfm3mduD6vuaxqzlHr29mb97yR0Nka9UE/8MHLVtV jPtwA
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
  be applied. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       |  8 +++++++-
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  7 +++++--
 net/mptcp/subflow.c  | 19 ++++++++++++++-----
 4 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 157a574fab0c..29c167e5fc02 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -304,8 +304,14 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
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
index 2595ace615fe..d95fc113d317 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -875,7 +875,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
 	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	msk->allow_infinite_fallback = false;
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
@@ -887,7 +887,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 		return false;
 
 	spin_lock_bh(&msk->fallback_lock);
-	if (__mptcp_check_fallback(msk)) {
+	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
 		return false;
 	}
@@ -2688,7 +2688,7 @@ static void __mptcp_retrans(struct sock *sk)
 				len = max(copied, len);
 				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 					 info.size_goal);
-				WRITE_ONCE(msk->allow_infinite_fallback, false);
+				msk->allow_infinite_fallback = false;
 			}
 			spin_unlock_bh(&msk->fallback_lock);
 
@@ -2819,7 +2819,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
-	WRITE_ONCE(msk->allow_infinite_fallback, true);
+	msk->allow_infinite_fallback = true;
+	msk->allow_subflows = true;
 	msk->recovery = false;
 	msk->subflow_id = 1;
 
@@ -3624,7 +3625,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
 		spin_lock_bh(&msk->fallback_lock);
-		if (__mptcp_check_fallback(msk)) {
+		if (!msk->allow_subflows) {
 			spin_unlock_bh(&msk->fallback_lock);
 			return false;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e637f468065..c5f41cdb36c4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -330,13 +330,15 @@ struct mptcp_sock {
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 	u8		scaling_ratio;
+	bool		allow_subflows;
 
 	u32		subflow_id;
 	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
 
-	spinlock_t	fallback_lock;	/* protects fallback and
-					 * allow_infinite_fallback
+	spinlock_t	fallback_lock;	/* protects fallback,
+					 * allow_infinite_fallback and
+					 * allow_join
 					 */
 };
 
@@ -1113,6 +1115,7 @@ static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
 		return false;
 	}
 
+	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5a8990536f8e..a01ea18283c7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1257,20 +1257,29 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
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
@@ -1282,6 +1291,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_send_ack(ssk);
 
 	mptcp_reset_tout_timer(msk, subflow->fail_tout);
+	return true;
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
@@ -1342,12 +1352,11 @@ static bool subflow_check_data_avail(struct sock *ssk)
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


