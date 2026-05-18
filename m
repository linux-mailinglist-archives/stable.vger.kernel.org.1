Return-Path: <stable+bounces-249259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC3bMx/+Cmop/AQAu9opvQ
	(envelope-from <stable+bounces-249259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:55:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 664E156C093
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E8C9304ADE7
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394C133A9CB;
	Mon, 18 May 2026 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3BbCxZR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F085C3E6DE4
	for <stable@vger.kernel.org>; Mon, 18 May 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104905; cv=none; b=ONsk/yQ2sB9eP+2AGWDuWFgtfJCXpO4qhJWJg3ClU/tczl3TY3foBbmCZfQC/gpehWB9BLqu+dRto36ZLwP4zXOu3DhiyFOAQDkm8K8IbO/aHSW2uocBSiACuy7jNIVGPUQAKl+dwRw70YYzPQ3u8sR5BFDrfMZ2cVe7r/cRTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104905; c=relaxed/simple;
	bh=2nRextZmHDf0GblPnFOfvRhZtmps2PF1Jw5vRb79eec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObJg4xIHO8UG8n/kaTlmsQafatsaPfd3dB++pnQFIfqpGbcvrZbEsyOKSQzbajvfe2Zj4U4JA4RZtGp6XmxFnIJ90rk7F4DPmkZR6V3iSahMK6H3GrJTMzY3BYKbzqtK7Cy1XOBRDFiaEmiUmmCxsUHPoTrD5G3G/RB7p5w4tjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3BbCxZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF29C2BCB7;
	Mon, 18 May 2026 11:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104904;
	bh=2nRextZmHDf0GblPnFOfvRhZtmps2PF1Jw5vRb79eec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3BbCxZR8WOmXHuruSehNXW/n524VzX+RVrWybJNn5mJNFU8sQCCBKgf+5khpOc5c
	 WK0Ys2vIrIh7V7v1XErf+aj5Uvi0Vu6H+GCDBg+Ny/ZTDImZYqtan6X+MRiV8EqXfZ
	 c2B52Q1d5jzQq53gzKwuDXBa1A2pHpwLqnuBir5v8JD5zpNBtcXBgkg1T2O/FwdyUW
	 rH7MUz+HuONUa7r35UNcdzdsMmvAJtkLCOVtO+M1MKoJSKSHy3aWV4v1xXrODdvrwp
	 EKj253N2j8JRURjbaajFH3tGnpemRcgmQg5NV8VELjJxbmOknAsB2kBhvNJnLfZwjY
	 YH5d86pEo/ZOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
Date: Mon, 18 May 2026 07:48:21 -0400
Message-ID: <20260518114822.789572-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051256-flinch-galley-b789@gregkh>
References: <2026051256-flinch-galley-b789@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 664E156C093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249259-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit f03afb3aeb9d81f6c5ab728a61a040012923e3b3 ]

When we will move the whole RX path under the msk socket lock, updating
the already queued skb for passive fastopen socket at 3rd ack time will
be extremely painful and race prone

The map_seq for already enqueued skbs is used only to allow correct
coalescing with later data; preventing collapsing to the first skb of
a fastopen connect we can completely remove the
__mptcp_fastopen_gen_msk_ackseq() helper.

Before dropping this helper, a new item had to be added to the
mptcp_skb_cb structure. Because this item will be frequently tested in
the fast path -- almost on every packet -- and because there is free
space there, a single byte is used instead of a bitfield. This micro
optimisation slightly reduces the number of CPU operations to do the
associated check.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250218-net-next-mptcp-rx-path-refactor-v1-2-4a47d90d7998@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 6254a16d6f0c ("mptcp: fix rx timestamp corruption on fastopen")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/fastopen.c | 24 ++----------------------
 net/mptcp/protocol.c |  4 +++-
 net/mptcp/protocol.h |  5 ++---
 net/mptcp/subflow.c  |  3 ---
 4 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index a29ff901df758..7777f5a2d1437 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -40,13 +40,12 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	tp->copied_seq += skb->len;
 	subflow->ssn_offset += skb->len;
 
-	/* initialize a dummy sequence number, we will update it at MPC
-	 * completion, if needed
-	 */
+	/* Only the sequence delta is relevant */
 	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
 
@@ -58,22 +57,3 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	mptcp_data_unlock(sk);
 }
-
-void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt)
-{
-	struct sock *sk = (struct sock *)msk;
-	struct sk_buff *skb;
-
-	skb = skb_peek_tail(&sk->sk_receive_queue);
-	if (skb) {
-		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
-		pr_debug("msk %p moving seq %llx -> %llx end_seq %llx -> %llx\n", sk,
-			 MPTCP_SKB_CB(skb)->map_seq, MPTCP_SKB_CB(skb)->map_seq + msk->ack_seq,
-			 MPTCP_SKB_CB(skb)->end_seq, MPTCP_SKB_CB(skb)->end_seq + msk->ack_seq);
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq;
-		MPTCP_SKB_CB(skb)->end_seq += msk->ack_seq;
-	}
-
-	pr_debug("msk=%p ack_seq=%llx\n", msk, msk->ack_seq);
-}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f9dd5c3d2d50e..7dbb666c72c30 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -137,7 +137,8 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	bool fragstolen;
 	int delta;
 
-	if (MPTCP_SKB_CB(from)->offset ||
+	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
+	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
@@ -368,6 +369,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->offset = offset;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
+	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 391a8026cb487..9ed9cb36e9bbe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -129,7 +129,8 @@ struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
 	u32 offset;
-	u8  has_rxtstamp:1;
+	u8  has_rxtstamp;
+	u8  cant_coalesce;
 };
 
 #define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
@@ -1069,8 +1070,6 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
-void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 int mptcp_nl_fill_addr(struct sk_buff *skb,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3843d3a80f4f1..10e945f5fa0f1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -802,9 +802,6 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 	subflow_set_remote_key(msk, subflow, mp_opt);
 	WRITE_ONCE(subflow->fully_established, true);
 	WRITE_ONCE(msk->fully_established, true);
-
-	if (subflow->is_mptfo)
-		__mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
 }
 
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
-- 
2.53.0


