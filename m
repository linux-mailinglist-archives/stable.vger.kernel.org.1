Return-Path: <stable+bounces-180864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D9B8EA0C
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7AE3BD5BA
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75D79CD;
	Mon, 22 Sep 2025 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYN+nNTI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C378F20
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758501850; cv=none; b=Pz/bQ0Sv3kPRpg73HZT7JOdOvt3tzVkfNISkxXYPHzNk6sloDZaF+5h2hRC4fJE0eD/+WxZhcOzGEPc0GKyg/Y59vbbtPQE8viq9aGr+VGfTp70Tij3+SlMwGyIX0vODmwBHyDj6a0wZMoc+XTJUS5XnXx9JO9IYwmoEMcBAXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758501850; c=relaxed/simple;
	bh=vd0kUDpIz1SA/MxYOcZ0L1mmd01IFxbmgC6Ni92diAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xvtqcr8nHVhVEZzXJnc+6dMfLcBBcfwHzEy43XBkOBTIlSbWbOLn6q669gTxhdufVkT+zcB83GRQDFjd7Vwoee4t0UPXVG1yvA+i5uN2RrBEC2x6ZUzIW/5ZbCxq8vX/Zz49VTPmj8ezhwO8RTsABuA5wdPp+81V/MfTFBC4ALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYN+nNTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1DCC4CEE7;
	Mon, 22 Sep 2025 00:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758501848;
	bh=vd0kUDpIz1SA/MxYOcZ0L1mmd01IFxbmgC6Ni92diAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYN+nNTIRsdh10Hg3H14y4K9lZ0T6Xawg4mpbgDNwJdgkg7+5BZDQRkOE327HZOA1
	 6ECuM/epVpYI5JANGC3o0DaabClQonHUVDCM9XxUUc3lT0IYNyOfGqVV26xaju4/Wc
	 GkbyScqxN/CvKcAx/R5tpiqnKGMqaZ8seubSNLHZ+QsPbeukd2kFwydiIfknY7QJCy
	 xAa3sxpJeVIGzqEY1qGu+0Lr2GUNLZtue7jD/q5mMbaaF8THqkztMQ4bBmgFqf/CVC
	 UZl/m30C5VIo+PZrK4EJ67FdgtYjoKO214dLV/G9QFT492QkfQXjaGFQkUPVXK9Jzm
	 NMlDCDrpDax7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: propagate shutdown to subflows when possible
Date: Sun, 21 Sep 2025 20:44:04 -0400
Message-ID: <20250922004404.3108078-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092142-stingily-broadside-f761@gregkh>
References: <2025092142-stingily-broadside-f761@gregkh>
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
index 883efcbb8dfc3..ea715a1282425 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -425,6 +425,19 @@ static void mptcp_close_wake_up(struct sock *sk)
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
@@ -448,6 +461,7 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
+			mptcp_shutdown_subflows(msk);
 			inet_sk_state_store(sk, TCP_CLOSE);
 			break;
 		}
@@ -615,6 +629,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 			inet_sk_state_store(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
+			mptcp_shutdown_subflows(msk);
 			inet_sk_state_store(sk, TCP_CLOSE);
 			break;
 		default:
-- 
2.51.0


