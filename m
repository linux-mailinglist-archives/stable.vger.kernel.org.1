Return-Path: <stable+bounces-180870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD5B8EB84
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 03:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601FC1898181
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 01:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034392E2840;
	Mon, 22 Sep 2025 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEgVM9Xa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E542E22BF
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505593; cv=none; b=J4fLVRJTr7OCVdVw21TX+WtKI/+XxKjwM6yHL2nhbpdIc93JLFq0CoxWvo2Plp5QP4nzN7C6OBA+qifJRsOcYrfCK1KhSfZAnxsLYkQekqC67ctKYdLYo2oOe/SQ7cp8tJZ7ts0V8OBKWYRopKI4FA+TB8ShKD6x75F6J+1BNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505593; c=relaxed/simple;
	bh=p+/YsUGkK+Bmrk7bgCXAwBAZIG2wJKgCR9A3x07cO5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4uWxFdCl8g3wtaW8AeiNoFsOui0jnwFVY3YPVK88MIlwYlepvEfRt+FEu8Q+4w4zFDAmd3+j4H3/t18SDpxF5Xb8L23OhVicm4Ddh/edu9I73WBWQtjezIh2HVcF2XtJsRfxC40E7BdQkpzIebXaohEiLsPL6MHT6/w6loL87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEgVM9Xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E78C4CEE7;
	Mon, 22 Sep 2025 01:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758505593;
	bh=p+/YsUGkK+Bmrk7bgCXAwBAZIG2wJKgCR9A3x07cO5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEgVM9Xaxz9sxsKGWFde5Kdcuc2D4YUmLaLDcFY+iVP8aBL68loMO4YEt6zOsCF5T
	 /3XFLQdIppBZhGa10zck8OjsYLLg2/G/gJvO1jEBAlHM1fARaFI25aqQVvJZKxe4kh
	 yjEAhZzldCBQzxu0W6rUXDustejK4THGoGFd2raEcQpcvQPnHwZMehddtY1T8rwb4M
	 cKnVfoZZ9+0+3vo5IgoWZaQGib6AoL5RGuKfE2nfMwvsFs1QAifc+Zi9FDZgbrXRoh
	 N0yzggQ6FJyHIg8CzoNNLWgyjJuGdInENcCmr3NgQy9dVVN1xTR9teKodYWiM7nKMk
	 ZxYfdWRa/IfYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mptcp: propagate shutdown to subflows when possible
Date: Sun, 21 Sep 2025 21:46:30 -0400
Message-ID: <20250922014630.3127747-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092143-trench-expiring-9a2f@gregkh>
References: <2025092143-trench-expiring-9a2f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit f755be0b1ff429a2ecf709beeb1bcd7abc111c2b ]

When the MPTCP DATA FIN have been ACKed, there is no more MPTCP related
metadata to exchange, and all subflows can be safely shutdown.

Before this patch, the subflows were actually terminated at 'close()'
time. That's certainly fine most of the time, but not when the userspace
'shutdown()' a connection, without close()ing it. When doing so, the
subflows were staying in LAST_ACK state on one side -- and consequently
in FIN_WAIT2 on the other side -- until the 'close()' of the MPTCP
socket.

Now, when the DATA FIN have been ACKed, all subflows are shutdown. A
consequence of this is that the TCP 'FIN' flag can be set earlier now,
but the end result is the same. This affects the packetdrill tests
looking at the end of the MPTCP connections, but for a good reason.

Note that tcp_shutdown() will check the subflow state, so no need to do
that again before calling it.

Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Cc: stable@vger.kernel.org
Fixes: 16a9a9da1723 ("mptcp: Add helper to process acks of DATA_FIN")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250912-net-mptcp-fix-sft-connect-v1-1-d40e77cbbf02@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f33c3150e6909..1342c31df0c40 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -326,6 +326,20 @@ static void mptcp_stop_timer(struct sock *sk)
 	mptcp_sk(sk)->timer_ival = 0;
 }
 
+static void mptcp_shutdown_subflows(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		tcp_shutdown(ssk, SEND_SHUTDOWN);
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 static void mptcp_check_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -348,6 +362,7 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
+			mptcp_shutdown_subflows(msk);
 			inet_sk_state_store(sk, TCP_CLOSE);
 			sk->sk_state_change(sk);
 			break;
@@ -430,6 +445,7 @@ static void mptcp_check_data_fin(struct sock *sk)
 			inet_sk_state_store(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
+			mptcp_shutdown_subflows(msk);
 			inet_sk_state_store(sk, TCP_CLOSE);
 			// @@ Close subflows now?
 			break;
-- 
2.51.0


