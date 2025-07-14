Return-Path: <stable+bounces-161875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D223B045AD
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9607C1A6604D
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8264426562A;
	Mon, 14 Jul 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhsdwPfo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B47264FA9;
	Mon, 14 Jul 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511326; cv=none; b=Ytj7wy5FFO+Lpo3RHYxLB8ml/tSMx1WBQGzbjqZSO1ZhLBV0JCDnX63fCW0C8RXNQYLbN4AiWfoX8bkQg147Khq4ZZiLmBagBwC0Ep8wQA5KLuzOgtiMTkSHiADGdUKcqKm5RqBdttKFODOJL8rIX9cZC1XYOwdJJT9P9miBTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511326; c=relaxed/simple;
	bh=dNlWYPSJeTjJtmUFv01ki4ZicEoiuj4E98YF9dyGQEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ypc9tPK+8w1oX27SDYgNsW8xKGMKSHM4w1xEHklaLvbZWroBcKZ0aRomWelGrfyrobIM5EwOjAaJgxGNKvutYWFDk6ZgjpCdHwNIdjtwsYikn/X0NHR+pYKRe/1AOTGPNJpJXoAENCRZYsrpj1I9clss+3VLrB7ciRKtpuhTwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhsdwPfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9739CC4CEF5;
	Mon, 14 Jul 2025 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752511325;
	bh=dNlWYPSJeTjJtmUFv01ki4ZicEoiuj4E98YF9dyGQEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OhsdwPfok6T0h+Cq6v8Z+VzrGWF1lIIVkXkIZGv6/Xcy20fqkSOOS9Si4ZcHiwd0V
	 SD81kaphi8Gy+h+K+Y5x/UJW8edvTQY+v55wI/cJ8qN9dqhDahQW8BHNo3XW/T2H8P
	 dTU8HWYwufBYcPsdAH3ueila8MX319e8947Kn99o+VnIwjkUQcZym4lmdAv36WAreC
	 MtlBQlCJgwzT9JyVTwLnV+QCqwI57ysbE8BMnGCSX35mj/7UfNy0EH5x8KiIRa5q0N
	 cHiH4yTav3T6SLMURvBbHeU2mJkVcE+m7/qcwsvuNWAUz3THR+bFUcyW5bi+LTq/or
	 JyY25ikLussaQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 14 Jul 2025 18:41:45 +0200
Subject: [PATCH net 2/3] mptcp: plug races between subflow fail and subflow
 creation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-net-mptcp-fallback-races-v1-2-391aff963322@kernel.org>
References: <20250714-net-mptcp-fallback-races-v1-0-391aff963322@kernel.org>
In-Reply-To: <20250714-net-mptcp-fallback-races-v1-0-391aff963322@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6799; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uAulBNxb5rxyQp2Ki9ga6ldQQTaagPQUZiJ5M9ACOQU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJKjYNTEnvXb7zYtsT7yq69p6IOry7zEI56Y7LDWcLiY
 9en+bPXdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkeAAjw6KE9OR4tYyqNguf
 +8bzoo+ovqoLOv3sc8Lxb+vjVp4UZWP4X2ER0j7v87GX9su3Ll7gxm7lJSqppzVF2e+YqvoSwYW
 dbAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

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
---
 net/mptcp/pm.c       |  8 +++++++-
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  7 +++++--
 net/mptcp/subflow.c  | 19 ++++++++++++++-----
 4 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index feb01747d7d86b648fd928816af3b171258e31a7..420d416e2603de2e54f017216c56daa80f356e87 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -765,8 +765,14 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
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
index b08a42fcbb650b8851f9b44090e61503f3dcad67..bf92cee9b5cee39e2b0831b6f7e06ce013fb6913 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -791,7 +791,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
 	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	msk->allow_infinite_fallback = false;
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
@@ -803,7 +803,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 		return false;
 
 	spin_lock_bh(&msk->fallback_lock);
-	if (__mptcp_check_fallback(msk)) {
+	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
 		return false;
 	}
@@ -2625,7 +2625,7 @@ static void __mptcp_retrans(struct sock *sk)
 				len = max(copied, len);
 				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 					 info.size_goal);
-				WRITE_ONCE(msk->allow_infinite_fallback, false);
+				msk->allow_infinite_fallback = false;
 			}
 			spin_unlock_bh(&msk->fallback_lock);
 
@@ -2753,7 +2753,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
-	WRITE_ONCE(msk->allow_infinite_fallback, true);
+	msk->allow_infinite_fallback = true;
+	msk->allow_subflows = true;
 	msk->recovery = false;
 	msk->subflow_id = 1;
 	msk->last_data_sent = tcp_jiffies32;
@@ -3549,7 +3550,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
 		spin_lock_bh(&msk->fallback_lock);
-		if (__mptcp_check_fallback(msk)) {
+		if (!msk->allow_subflows) {
 			spin_unlock_bh(&msk->fallback_lock);
 			return false;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2a60c3c71651b917c8b9b33d16f8e831c76cfc82..6ec245fd2778ef30e0dc84d309d27ecd1f62e0d1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -346,13 +346,15 @@ struct mptcp_sock {
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
 
@@ -1232,6 +1234,7 @@ static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
 		return false;
 	}
 
+	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a6a35985e551e0967f998c3ae928b76376fa97fd..1802bc5435a1aaabc81e28152b0bac5656e3b828 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1302,20 +1302,29 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
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
 	/* graceful failure can happen only on the MPC subflow */
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
@@ -1327,6 +1336,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_send_ack(ssk);
 
 	mptcp_reset_tout_timer(msk, subflow->fail_tout);
+	return true;
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
@@ -1387,12 +1397,11 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		    (subflow->mp_join || subflow->valid_csum_seen)) {
 			subflow->send_mp_fail = 1;
 
-			if (!READ_ONCE(msk->allow_infinite_fallback)) {
+			if (!mptcp_subflow_fail(msk, ssk)) {
 				subflow->reset_transient = 0;
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
 				goto reset;
 			}
-			mptcp_subflow_fail(msk, ssk);
 			WRITE_ONCE(subflow->data_avail, true);
 			return true;
 		}

-- 
2.48.1


