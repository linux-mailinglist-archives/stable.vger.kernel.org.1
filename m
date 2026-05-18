Return-Path: <stable+bounces-249275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDi3J8gPC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:10:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4583856D586
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48B4330337EE
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3A13F9F46;
	Mon, 18 May 2026 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyOjN+1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9143CEF8
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109512; cv=none; b=Jq89olLXG292sr6GukNjGXvVWlGgcugmqmWDkZSWA2cEJuzRmr4fOI7bvLpF/Tv14yru8G0BWXFI64htDi8WkS/cVc0Lfd8WTaT29qbVHs2nI3QHYMYYPLDg6NFCPYYzvPGO1OVMpRMavlgnENkeTBadUpxyIiRAFo9eWoAPiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109512; c=relaxed/simple;
	bh=ptxVWpFFbSHlxZUuT6jm9VCknJyLNRH/qK38kXsluYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGQDtAkmt1b2nLx4JcalOrcRZw/k6gc7BzipE0zIAU5c6t6OUOHwV2jAzRk7UgS+Lzzt0V35MjMfy9+6ymVspVIhvkSo7MTlt8MSRmx5lRziOfqWis7i20kWK7AasYtF/LKi4YTlMamw509VesDweGA2CsGzpPVxXvDOB2iu0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyOjN+1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5C6C2BCB7;
	Mon, 18 May 2026 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109512;
	bh=ptxVWpFFbSHlxZUuT6jm9VCknJyLNRH/qK38kXsluYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LyOjN+1puYnACDH9pCKty0hclu86V+wmabtpOmuIZ+c6CL/SryYKpd0gS86dfD1Dt
	 EKw2BWZGNS9IlQE0jyoCV5cCM6CchCDmgI0pSKQlmKI5S15b5Y5MTu98idlloPRkz2
	 ga07znlTy8LLZG4qKgqDNnPIlcadEMrQfRHSeF3J8QBnCVBxlVQozI8vulg2scb1kT
	 EjsZ7TZXy5yoz3Oucu5/qNJALijMFYMn7DZTxfn1mDO1duVK1B8lm33U9SAAr4xI1U
	 fJJ7pRuVhdnJj4IQcdAKykdS5FkwO3TQnv1g6RbA8stiiL8biYw+2nI1UqP9mGJLzA
	 JBxhx/r/3PJig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
Date: Mon, 18 May 2026 09:05:08 -0400
Message-ID: <20260518130509.978083-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051256-grime-usual-23e7@gregkh>
References: <2026051256-grime-usual-23e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4583856D586
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249275-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
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
index 71995d00696ea..aed6c04c7de67 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -139,7 +139,8 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	bool fragstolen;
 	int delta;
 
-	if (MPTCP_SKB_CB(from)->offset ||
+	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
+	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
@@ -370,6 +371,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->offset = offset;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
+	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fbb3897c9c2c2..2a33452715597 100644
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
@@ -988,8 +989,6 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
-void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 49be98ffd1de7..f2fc735d8b618 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -778,9 +778,6 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 	subflow_set_remote_key(msk, subflow, mp_opt);
 	subflow->fully_established = 1;
 	WRITE_ONCE(msk->fully_established, true);
-
-	if (subflow->is_mptfo)
-		__mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
 }
 
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
-- 
2.53.0


