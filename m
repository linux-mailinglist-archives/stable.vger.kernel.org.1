Return-Path: <stable+bounces-94964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB769D7556
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C590B307ED
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422651B140D;
	Sun, 24 Nov 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqHTEqLN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99181E1C08;
	Sun, 24 Nov 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455435; cv=none; b=sUpC6K75FGWzpGpne/QlxfTxilpDlIkWP0SwxBN73lo+53pX8Oaz2ym4T+l2skLHC5/pTWMf6MnCnTTtR5EovgcYSBXfWNx78ACnXURoJXRA2edpJO8ASHfZXt9KQFvnYQstw8WQ53hyOUAzWExjOOKKAkYrFFSt4wxnDUKSD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455435; c=relaxed/simple;
	bh=KZhz5tYPeK/jVYnXQsImtD0gPYrjJ/5xKHiRBK3RG1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etI5JJb5PibGkXCgkwpMa0Ug0M4E+H9GDuw72oyRFlTfXUoQ19V9MeLmB+HHZhRXAPSdWTmDnOays2rj2r9rgHVGk8pzHEibw2b1nMebKtRNdOANy+ddUxl5eR3xhzVUl/oVoPlpE4ipj5djbz9Nvs+gWS3taYIqaWeQkjA5YlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqHTEqLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CF3C4CECC;
	Sun, 24 Nov 2024 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455434;
	bh=KZhz5tYPeK/jVYnXQsImtD0gPYrjJ/5xKHiRBK3RG1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqHTEqLN+xGCIpmp5ojvPR0oxe2TGyheF/9QuvtgaFbGf3KN2DxgIfZfiRzNcAyAw
	 uTv4f3CfCRSUwKkE9ETkdglieJX2iu6FRNKOUvGfdrmoCfrHcuooeISfblp1XmSutG
	 IKfdfiEWUVYNV38foFXUk9OIWoPjx60XaIy3MgEe5F9asPrEXXVH3FHhD1Dl6fW4i2
	 3CWD1duiOkJA7PlCHRxBJ7s7bbM9ZmjoQadna9VpBYmUNORYPT0CA23QUew8Fyu+Xe
	 VkSrDPOHvGtlNe1e0pw8ZGrb9nw7Qp5gSd3iQVXGOrKt8qSHvRqwHmn8OpMlhOAqP8
	 3BF36u+8h6LuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gang Yan <yangang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 068/107] mptcp: annotate data-races around subflow->fully_established
Date: Sun, 24 Nov 2024 08:29:28 -0500
Message-ID: <20241124133301.3341829-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

[ Upstream commit 581c8cbfa934aaa555daa4e843242fcecc160f05 ]

We introduce the same handling for potential data races with the
'fully_established' flag in subflow as previously done for
msk->fully_established.

Additionally, we make a crucial change: convert the subflow's
'fully_established' from 'bit_field' to 'bool' type. This is
necessary because methods for avoiding data races don't work well
with 'bit_field'. Specifically, the 'READ_ONCE' needs to know
the size of the variable being accessed, which is not supported in
'bit_field'. Also, 'test_bit' expect the address of 'bit_field'.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/516
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241021-net-next-mptcp-misc-6-13-v1-2-1ef02746504a@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/diag.c     | 2 +-
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 6 +++---
 net/mptcp/subflow.c  | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 2d3efb405437d..02205f7994d75 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -47,7 +47,7 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 		flags |= MPTCP_SUBFLOW_FLAG_BKUP_REM;
 	if (sf->request_bkup)
 		flags |= MPTCP_SUBFLOW_FLAG_BKUP_LOC;
-	if (sf->fully_established)
+	if (READ_ONCE(sf->fully_established))
 		flags |= MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED;
 	if (sf->conn_finished)
 		flags |= MPTCP_SUBFLOW_FLAG_CONNECTED;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 370c3836b7712..1603b3702e220 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -461,7 +461,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take precedence */
-	if (subflow->fully_established || snd_data_fin_enable ||
+	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||
 	    subflow->snd_isn != TCP_SKB_CB(skb)->seq ||
 	    sk->sk_state != TCP_ESTABLISHED)
 		return false;
@@ -930,7 +930,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
-	if (likely(subflow->fully_established)) {
+	if (likely(READ_ONCE(subflow->fully_established))) {
 		/* on passive sockets, check for 3rd ack retransmission
 		 * note that msk is always set by subflow_syn_recv_sock()
 		 * for mp_join subflows
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48d480982b787..47ee616f69c2d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3519,7 +3519,7 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	struct tcp_sock *tp = tcp_sk(ssk);
 	unsigned long timeout;
 
-	if (mptcp_subflow_ctx(ssk)->fully_established)
+	if (READ_ONCE(mptcp_subflow_ctx(ssk)->fully_established))
 		return;
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 568a72702b080..a93e661ef5c43 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -513,7 +513,6 @@ struct mptcp_subflow_context {
 		request_bkup : 1,
 		mp_capable : 1,	    /* remote is MPTCP capable */
 		mp_join : 1,	    /* remote is JOINing */
-		fully_established : 1,	    /* path validated */
 		pm_notified : 1,    /* PM hook called for established status */
 		conn_finished : 1,
 		map_valid : 1,
@@ -532,10 +531,11 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
+	bool	fully_established;  /* path validated */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
@@ -780,7 +780,7 @@ static inline bool __tcp_can_send(const struct sock *ssk)
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
 	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
-	if (subflow->request_join && !subflow->fully_established)
+	if (subflow->request_join && !READ_ONCE(subflow->fully_established))
 		return false;
 
 	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6170f2fff71e4..860903e064225 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -800,7 +800,7 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 				       const struct mptcp_options_received *mp_opt)
 {
 	subflow_set_remote_key(msk, subflow, mp_opt);
-	subflow->fully_established = 1;
+	WRITE_ONCE(subflow->fully_established, true);
 	WRITE_ONCE(msk->fully_established, true);
 
 	if (subflow->is_mptfo)
@@ -2062,7 +2062,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 	} else if (subflow_req->mp_join) {
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;
-		new_ctx->fully_established = 1;
+		WRITE_ONCE(new_ctx->fully_established, true);
 		new_ctx->remote_key_valid = 1;
 		new_ctx->backup = subflow_req->backup;
 		new_ctx->request_bkup = subflow_req->request_bkup;
-- 
2.43.0


