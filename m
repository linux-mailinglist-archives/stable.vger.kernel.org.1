Return-Path: <stable+bounces-180866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3328B8EA42
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF52218966BF
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0E6BB5B;
	Mon, 22 Sep 2025 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duYszCyB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC33596D
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502577; cv=none; b=nayT9k8i8FCblGf6oCWl4JIJ+opVCN8bEu4zT/lA7DhU7R7l85M5lHXEnKQgNDk1fPbXmUg42vdP4ZSYjRHk5G75r6KhL8bvBYy2Qc0d/pKyraLV4LNghho77AyQvxMdenLwjynVXkr1ICpVqJ4WJKFvLRwZgfW5Cz9esdYAc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502577; c=relaxed/simple;
	bh=ZD3JsEDuY71fOB+G4C9aBWFjIfPVuxWP34jNgUzbXQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nc8Q+YTxvpiWEPlu4sZ3Rauvzy1AlTDkGUKBU1tLhvHAoPpwWB0gtDEsrkYvX+kRASZxH0JoAjM4E/QucNAyHDrBVQ3+XLlyDjdtEwHL8jN7DLJCUXrywJjxZSVrGVEcJJD6sS5EB6U885dOesIkWAl4Fb6AKePZvETQQs+t97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duYszCyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ACEC4CEE7;
	Mon, 22 Sep 2025 00:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758502575;
	bh=ZD3JsEDuY71fOB+G4C9aBWFjIfPVuxWP34jNgUzbXQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duYszCyBmtJ1HH+9QS8RAgjHkYE8IniGx06DyTLp5REfwVHB/GaU07SfTe6QzD3a3
	 8gUBuXA3l37z/y/xg7tSEhaHYxHL71IglNECRkXO13SexAj9k/K9tkNL3lYPi5QdTG
	 hvuQId1zYAOeFRTxpVJ2mq3u9bhDTfHWS8hf43p3RlPurgL0cY5HbjCZy2x+sSuGX4
	 71aNOPLNPWtyIRr2cra5EvDSOXlG+7FW5i6L7rGtnhHlJN/gtBXgzCGCtzX8/uZpDl
	 WpSiRM87j2skjX4SQzgOj4+zB2Glsgg0BV2cf7Hz0Ca4oUWCpHggJyZL2VD7LTQ1hD
	 6DApTD4IoJt1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: propagate shutdown to subflows when possible
Date: Sun, 21 Sep 2025 20:56:12 -0400
Message-ID: <20250922005613.3111681-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092143-detonator-snowcap-57d7@gregkh>
References: <2025092143-detonator-snowcap-57d7@gregkh>
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
 net/mptcp/protocol.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bf2b9ba1c734a..490fd8b188894 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -354,6 +354,19 @@ static void mptcp_close_wake_up(struct sock *sk)
 		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
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
 static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -377,6 +390,7 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
+			mptcp_shutdown_subflows(msk);
 			inet_sk_state_store(sk, TCP_CLOSE);
 			break;
 		}
@@ -539,6 +553,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 			inet_sk_state_store(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
+			mptcp_shutdown_subflows(msk);
 			inet_sk_state_store(sk, TCP_CLOSE);
 			break;
 		default:
-- 
2.51.0


