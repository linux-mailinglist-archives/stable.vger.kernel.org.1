Return-Path: <stable+bounces-73742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF996EE3E
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D474C2838C7
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E98C14B945;
	Fri,  6 Sep 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8S7Xq3/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097745BE3;
	Fri,  6 Sep 2024 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611728; cv=none; b=t/OjnX+U3JRuqcBN1Q0DULK3/3XYHVYdvkB53Hv3BWMBxxuFfcDCHUR3R7Q9atipOzU/6lVcrP6y+jDw2NmRpHRLeeb0b51i0YzWReE1uUV3BUBKpO8pNemcZJ6t2NcC7DXAaJfxcVZ01UvR48nz5FCFPxES7D3N+NcOMsFiLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611728; c=relaxed/simple;
	bh=hqr6tVMKvQxKRSgnMypbCzTdhSYMmHFovaXU4oB8Iy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucHwDI/yNRidy3hmrq4ScHMPxaF3gCn4bXYR/6vPgjvpD3K6ZkF+7M/TxpZwJyVAxcVOdhtY0lSTVa1F1cycRxl5X1djFT9IBWZ+6ZmZs/NUTvCYojS6MrZUie9TsHtz3Gkhzcjx1nSJoYezVBFBhNL1fCHE0cZpIQv08fzLfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8S7Xq3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26583C4CEC4;
	Fri,  6 Sep 2024 08:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611728;
	bh=hqr6tVMKvQxKRSgnMypbCzTdhSYMmHFovaXU4oB8Iy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D8S7Xq3/zbkEGXxekcYfqEocTY0sxoupapqWyhTDQIX7fasODJkuT7MeX+ja3b9pZ
	 XiSqATK+JO3fAIzOc8KKOmuglcqql6iZyGG8qH5sdOybogM4x8jFtWgVen1TuNSq5u
	 XLHheASRNWizrdNJw0OHY7wm9IEGgfHHN9yGj70+XVJwF7xNNK7L7ltIPOtRcovR30
	 NtlKVM93ZdSKGvZzziK0YpYGXbP92Ukv5bOzVBRTRTWNqTHknhdJdH+8c/RGv3YYLv
	 WDuQn4KftPVB8FXkcIhltIGibrm4Lw18e6q7Z8SZ9gxEbwbi1YwB/bhtKWYq0fLHtS
	 +kb4Zji54F2Dg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: close subflow when receiving TCP+FIN
Date: Fri,  6 Sep 2024 10:35:21 +0200
Message-ID: <20240906083520.1773331-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083037-germproof-omnivore-ecf0@gregkh>
References: <2024083037-germproof-omnivore-ecf0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3841; i=matttbe@kernel.org; h=from:subject; bh=hqr6tVMKvQxKRSgnMypbCzTdhSYMmHFovaXU4oB8Iy8=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r7Ibf9/Vu0rVWYt+oHL90pFGXJdtVUqs9VGm SUbOerAe4aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq+yAAKCRD2t4JPQmmg cxbcD/9yqTxADf51jCQ3tylf/8E8Fa0ya47AypTAxGNAwsTvkzdUjr4TtqxrvwjU9qHlW3KUerA 7X0w7NfhpGs71ANHBFdpB2YYywju9L6N83U24CgF0EKwam8vs2HdrwR3gkmH090ER+QBgV0YpKL 0gIpgZLa57rryIF0b7V7zlj01JM3veN5zh91XSctUj+jOEf2Yz1vNQydJ63tzaJ1phXb4Zpq5E1 KaXGpuO+5zt26SRTAOq1nBNAN3visJ/YpcaUYqkvp1kSQW+moKcrw3jXzXT2Tr+xl2V7bmvfNMP 4av4uEwQPiSps8sNJhHcg8qnRWfYS+tii5Ugo+M+IPAa4bvM32DO4zxqfEa9wjZnFEsqwnUJcnR Q6TBW3uSohzyi3GtC/ucgOc9rg5fzIo6GVV+6IqrbX35TVxDfNAFpBmeCNuYOyuprPokGdIZlYN RzpyBloluWCIooPu14kutedasWgZmMtxgjjMv0JLjsaai62cuZa0HYAsZPjk3tHPY7SzngzmGLL wVCcfny+qBYgGa8WAoCsUbxB9FdfGXiTkWdp9bHvdQMgwezA9UlxlPl8EdXqZJ9+1IBUy5dXIWB JsHHVfujroAO58lVGNQ8h9vbTKiiHj4/62y7niViojQ+lrJ/1Q6zoIIFQBv6slzCm92h7xCv2P6 +C+5bLZZh7EpyAw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit f09b0ad55a1196f5891663f8888463c0541059cb upstream.

When a peer decides to close one subflow in the middle of a connection
having multiple subflows, the receiver of the first FIN should accept
that, and close the subflow on its side as well. If not, the subflow
will stay half closed, and would even continue to be used until the end
of the MPTCP connection or a reset from the network.

The issue has not been seen before, probably because the in-kernel
path-manager always sends a RM_ADDR before closing the subflow. Upon the
reception of this RM_ADDR, the other peer will initiate the closure on
its side as well. On the other hand, if the RM_ADDR is lost, or if the
path-manager of the other peer only closes the subflow without sending a
RM_ADDR, the subflow would switch to TCP_CLOSE_WAIT, but that's it,
leaving the subflow half-closed.

So now, when the subflow switches to the TCP_CLOSE_WAIT state, and if
the MPTCP connection has not been closed before with a DATA_FIN, the
kernel owning the subflow schedules its worker to initiate the closure
on its side as well.

This issue can be easily reproduced with packetdrill, as visible in [1],
by creating an additional subflow, injecting a FIN+ACK before sending
the DATA_FIN, and expecting a FIN+ACK in return.

Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")
Cc: stable@vger.kernel.org
Link: https://github.com/multipath-tcp/packetdrill/pull/154 [1]
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240826-net-mptcp-close-extra-sf-fin-v1-1-905199fe1172@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ No conflicts but 'sk' is not available in __mptcp_close_subflow in
  this version. It would require b6985b9b8295 ("mptcp: use the workqueue
  to destroy unaccepted sockets") which has not been backported to this
  version. It is easier to get 'sk' by casting 'msk' into a 'struct
  sock'. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 5 ++++-
 net/mptcp/subflow.c  | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5afd49bf4750..da2a1a150bc6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2361,8 +2361,11 @@ static void __mptcp_close_subflow(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ssk_state = inet_sk_state_load(ssk);
 
-		if (inet_sk_state_load(ssk) != TCP_CLOSE)
+		if (ssk_state != TCP_CLOSE &&
+		    (ssk_state != TCP_CLOSE_WAIT ||
+		     inet_sk_state_load((struct sock *)ssk) != TCP_ESTABLISHED))
 			continue;
 
 		/* 'subflow_data_ready' will re-sched once rx queue is empty */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5f514943721f..e71082dd6484 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1131,12 +1131,16 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 /* sched mptcp worker to remove the subflow if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (likely(ssk->sk_state != TCP_CLOSE))
+	struct sock *sk = (struct sock *)msk;
+
+	if (likely(ssk->sk_state != TCP_CLOSE &&
+		   (ssk->sk_state != TCP_CLOSE_WAIT ||
+		    inet_sk_state_load(sk) != TCP_ESTABLISHED)))
 		return;
 
 	if (skb_queue_empty(&ssk->sk_receive_queue) &&
 	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
-		mptcp_schedule_work((struct sock *)msk);
+		mptcp_schedule_work(sk);
 }
 
 static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
-- 
2.45.2


