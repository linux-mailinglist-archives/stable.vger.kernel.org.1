Return-Path: <stable+bounces-20566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74AB85A822
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9091F21353
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97613B7A1;
	Mon, 19 Feb 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h/q8PzTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2453399C
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358724; cv=none; b=p8m1KXn0RfMh+ywPrGqOlLqj1hXfYYKl79nwq1mA82l4lLbSQ+XvmX3DOj0gnPlMJfwW5m+hZ43mGZRtA2i3q3H4js3e+LO86lRlbEoMb5jVvjtKxOLj/VfdtXYs1DztuKrPmBQi+3jHsYuagjWYbhpFM/aiTp5P+otkT3lbgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358724; c=relaxed/simple;
	bh=zXvokp9QZ+vZk3YAxM9jOle+TeWuEy0w4b8y5id1lL0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xs2xtyjsRVPce8JcBUBf+nO01DyOLpcENwriDdWzvkUqazeZcbda1u3WykrKair1sRuS54m2GDZ3tmVTqPZGWpCV7L6/avX/Q/5MBOX8G32of9kQ8aSpfum/NY4Pdv4cRwMKsFXV5LyRV9/7DI82Av+0LQ+sv8DSUm78Hj3IbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h/q8PzTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEAEC43390;
	Mon, 19 Feb 2024 16:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358724;
	bh=zXvokp9QZ+vZk3YAxM9jOle+TeWuEy0w4b8y5id1lL0=;
	h=Subject:To:Cc:From:Date:From;
	b=h/q8PzTvUF2CGIGYp5WO7FFl1OmJr8xucuI0ekLnspt7U7x9jqJj0IlZsePyy0sqZ
	 hiYmKZQlekDXSLNoTOqmCJALEgZKClOTcSQcTzZcYHqaszz4v7vScZnwvOPfYKq1yG
	 rwiz0Jkc7n2GBaI0lS+1gHY1ruJUASlNFgc+VzjQ=
Subject: FAILED: patch "[PATCH] mptcp: fix more tx path fields initialization" failed to apply to 6.7-stable tree
To: pabeni@redhat.com,davem@davemloft.net,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:05:09 +0100
Message-ID: <2024021909-wobbling-taste-4260@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 3f83d8a77eeeb47011b990fd766a421ee64f1d73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021909-wobbling-taste-4260@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

3f83d8a77eee ("mptcp: fix more tx path fields initialization")
013e3179dbd2 ("mptcp: fix rcv space initialization")
c693a8516429 ("mptcp: use mptcp_set_state")

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


