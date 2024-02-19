Return-Path: <stable+bounces-20567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E57385A826
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D331F216FF
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E509A3B181;
	Mon, 19 Feb 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SX6B7nWq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE13D0A6
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358727; cv=none; b=ofVNQ8Vyl6JaKqhwtmXNb9nGqLh76ZZGsP/mGcGwGpCN0DQ98ykeNHCLVZ5gPHVSrBUUfga6qYeSpvPfai4OjVTb2GfZZxEu2nQFvvCOj8YQvW2AEnTEbtShBmSpzBNMoM1+q/5VJj9cpm3XEawTLi0Xf9+bg25IotZXqWW9GLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358727; c=relaxed/simple;
	bh=TWB4Q+ImiNDB5OYJUZr3CkGKyTRh0wPLytXU+sTDBE8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xieoy8JVKLoV7DO6nxsZrG3kg4NjlasA/goMGfvrQZiQwVWSVqXFwLr2mRjcQBoQ+lDVWm/Hw0c7oZB2Z8KVhzA19R3SL8b99LTEUVT2aalkG0Pq6yFhZq2IqI8PiN16CkO3RzmNwUv/cp5t5JiNy3BSfT4VzHvPUzakRSrsbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SX6B7nWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14454C433C7;
	Mon, 19 Feb 2024 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358727;
	bh=TWB4Q+ImiNDB5OYJUZr3CkGKyTRh0wPLytXU+sTDBE8=;
	h=Subject:To:Cc:From:Date:From;
	b=SX6B7nWqgT6XcAPQugkhQT4PbsJ2qEUMj8FjU3pI1xTPfdUgpMsqs/6npYIr+Sr6L
	 5GezhGrL5mGCfJYBok8CPUbWYDmarCmM7pIRNNfzXIFhhYcgeTnIKqdmwfXGgdz1AO
	 4VGwGQS6VPcDeF93z88/wawfsbpIncM9dJqDgf34=
Subject: FAILED: patch "[PATCH] mptcp: fix more tx path fields initialization" failed to apply to 6.6-stable tree
To: pabeni@redhat.com,davem@davemloft.net,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:05:10 +0100
Message-ID: <2024021910-cold-outmost-b825@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3f83d8a77eeeb47011b990fd766a421ee64f1d73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021910-cold-outmost-b825@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

3f83d8a77eee ("mptcp: fix more tx path fields initialization")
013e3179dbd2 ("mptcp: fix rcv space initialization")
c693a8516429 ("mptcp: use mptcp_set_state")
4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
d109a7767273 ("mptcp: fix possible NULL pointer dereference on close")
8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3f83d8a77eeeb47011b990fd766a421ee64f1d73 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 8 Feb 2024 19:03:51 +0100
Subject: [PATCH] mptcp: fix more tx path fields initialization

The 'msk->write_seq' and 'msk->snd_nxt' are always updated under
the msk socket lock, except at MPC handshake completiont time.

Builds-up on the previous commit to move such init under the relevant
lock.

There are no known problems caused by the potential race, the
primary goal is consistency.

Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7632eafb683b..8cb6a873dae9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3478,10 +3478,8 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
-	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
-	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
-	WRITE_ONCE(msk->snd_una, msk->write_seq);
-	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
+	WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
+	WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 56b2ac2f2f22..c2df34ebcf28 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -421,12 +421,21 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
 
 void __mptcp_sync_state(struct sock *sk, int state)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk = msk->first;
 
-	__mptcp_propagate_sndbuf(sk, msk->first);
+	subflow = mptcp_subflow_ctx(ssk);
+	__mptcp_propagate_sndbuf(sk, ssk);
 	if (!msk->rcvspace_init)
-		mptcp_rcv_space_init(msk, msk->first);
+		mptcp_rcv_space_init(msk, ssk);
+
 	if (sk->sk_state == TCP_SYN_SENT) {
+		/* subflow->idsn is always available is TCP_SYN_SENT state,
+		 * even for the FASTOPEN scenarios
+		 */
+		WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
+		WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 		mptcp_set_state(sk, state);
 		sk->sk_state_change(sk);
 	}


