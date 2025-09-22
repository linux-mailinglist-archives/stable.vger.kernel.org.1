Return-Path: <stable+bounces-180860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1687DB8E9E1
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F1D3BE9B2
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96D3C01;
	Mon, 22 Sep 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4WxqCmR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF86800
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758499790; cv=none; b=SOu5g0h2z1OZOFlgTtPgVABgRxEGH1TXbGvmOqDa2AnuzsMlhUvjZRUWAJfEkNwr+U3FfEOeFDB1D1FIxNQti8I1Lj8P0dd7jxLHcywotxWZDOvNA8DgR9pwhe7cEoHF8Ey3jjRY5wdf3YKgOBXravxG9XU1nEaC3S8jjLbIuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758499790; c=relaxed/simple;
	bh=Xz79sUnYgL90H7Rim1muvIJauBru609oGSGxt/PK46E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7HRXDhEZbFsICo5ARDfnl+gMUQJ4yMtWu3BjLeVLhPG1H3CxJntZ+VO+SqjRP3DNrSLBumEB3gmW8vRT4XwZV1hCmQqmTirdMrhZY5KYx04aq7GWaKCqvD9+euLXex6o3B3Jga4fgK71zyYW9fltdrldGJ3bdTVZdgKZGVKi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4WxqCmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B57C4CEE7;
	Mon, 22 Sep 2025 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758499790;
	bh=Xz79sUnYgL90H7Rim1muvIJauBru609oGSGxt/PK46E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4WxqCmRFu2jqUGPvBocvQ0Iy0Kc9Xngb9EIw2aVqQB9di4iGEehgGJ8PDRDqcVQh
	 EWxGfD3Q5trsMKObFpTMs17+JFofe6K4s8a9IMHWVJjy3W6ifBummlfgdH//wXNAY4
	 iiOkAWz6NYMb6vSPIBJg/pvOnLG5pJct4ZhQav3N8WqjJPk2Pu1YWoYx2Sy3rzgCys
	 4A7nGsLnE0PzOKh3We15MvQsuAkbRu6o4jaAWOQIZ8PgNq7DkCqcx4UpyLkEN7UidG
	 eXOM5GdVkvBzTxktFgO2uqNuQzqnMBRUSnW66egswP7YWrMDYgXhcErU+L3IqswX/K
	 YtBwgiQGhx7Jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: propagate shutdown to subflows when possible
Date: Sun, 21 Sep 2025 20:09:47 -0400
Message-ID: <20250922000947.3097293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092141-slashing-postal-be15@gregkh>
References: <2025092141-slashing-postal-be15@gregkh>
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
index e3f09467b36b2..643d64bdef2ea 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -415,6 +415,20 @@ static void mptcp_close_wake_up(struct sock *sk)
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
+
 static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -438,6 +452,7 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
+			mptcp_shutdown_subflows(msk);
 			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		}
@@ -605,6 +620,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 			mptcp_set_state(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
+			mptcp_shutdown_subflows(msk);
 			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		default:
-- 
2.51.0


