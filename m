Return-Path: <stable+bounces-20568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C97C85A827
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C71C2396D
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036373B7A9;
	Mon, 19 Feb 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MPR1/ZNE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7B3B7A1
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358730; cv=none; b=tovwdwbN+IA41F28NowhIP3Qp5A/4SkYkcctfY1s/P+Eg67MeVxvxeRUp19lK3aZiXMt7QFKFt4imlj0aPauB++xFV7rGrJHBNdJNRE3QsYpmJ+W34flofb5JQEtsoJd+PJREomzSRv8mzVSL276z1+t8yodRfI5bBAt/2gLNLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358730; c=relaxed/simple;
	bh=k4knVFfrs9CBdsrbKYXcCM8f0cQRVgfqMQuTbE2If7Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=skYwZMBumUhb7lKE/vIhhOYsosOkA/gRrln9G8tH7vOh/0zF3qf2Krk9XNRV7fRuaGZSB+c8xiAqF/Vb+90ajmsoRgIC4ZSE8toq/XtESUXIU0Lc575WsaMPM2BlM4MQS0kSXBWTHwgGLp3Rse57E7osLkGnRPrpjebCXrmL7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MPR1/ZNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278E8C433F1;
	Mon, 19 Feb 2024 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358730;
	bh=k4knVFfrs9CBdsrbKYXcCM8f0cQRVgfqMQuTbE2If7Q=;
	h=Subject:To:Cc:From:Date:From;
	b=MPR1/ZNEBU8RaUOeA9YJ61EAOB4qbfhYR7aq/ikOjdOJyFxLI5nYIr94cbM+FN0L9
	 0MA4d0n3qxOSFbUjUQfsHW9sCPnQNqPlHkPokQeSN6D4oVByfos8CLCy2/IMKMpsbx
	 ksYEjpXsNB1qrwmOgjAmzZq1RLUHxuxToMDX2l/I=
Subject: FAILED: patch "[PATCH] mptcp: fix more tx path fields initialization" failed to apply to 6.1-stable tree
To: pabeni@redhat.com,davem@davemloft.net,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:05:11 +0100
Message-ID: <2024021911-fragment-yearly-5b45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3f83d8a77eeeb47011b990fd766a421ee64f1d73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021911-fragment-yearly-5b45@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3f83d8a77eee ("mptcp: fix more tx path fields initialization")
013e3179dbd2 ("mptcp: fix rcv space initialization")
c693a8516429 ("mptcp: use mptcp_set_state")
4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
d109a7767273 ("mptcp: fix possible NULL pointer dereference on close")
8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
a5efdbcece83 ("mptcp: fix delegated action races")
27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
f6909dc1c1f4 ("mptcp: rename timer related helper to less confusing names")
9f1a98813b4b ("mptcp: process pending subflow error on close")
d5fbeff1ab81 ("mptcp: move __mptcp_error_report in protocol.c")
ebc1e08f01eb ("mptcp: drop last_snd and MPTCP_RESET_SCHEDULER")
e263691773cd ("mptcp: Remove unnecessary test for __mptcp_init_sock()")
39880bd808ad ("mptcp: get rid of msk->subflow")
3f326a821b99 ("mptcp: change the mpc check helper to return a sk")
3aa362494170 ("mptcp: avoid ssock usage in mptcp_pm_nl_create_listen_socket()")
f0bc514bd5c1 ("mptcp: avoid additional indirection in sockopt")
40f56d0c7043 ("mptcp: avoid additional indirection in mptcp_listen()")
8cf2ebdc0078 ("mptcp: mptcp: avoid additional indirection in mptcp_bind()")
ccae357c1c6a ("mptcp: avoid additional __inet_stream_connect() call")

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


