Return-Path: <stable+bounces-20560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D5A85A81B
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635D82828CB
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F5B3B190;
	Mon, 19 Feb 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vV8qKAzr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A43B18D
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358658; cv=none; b=VMuy2jziePaJtOCJSU/ZmAY84mEcRQjw7glZ+o5BnAN+HUgHSYfCHVhL9a8fJ5H/IsJy7aY86CXW/canYgA4AWigXdRoFSHjHKSC+LmGHKBwTeQF1O2L6vOqc7rnUheIlhTZfCK8U/YHpmnKfPoqvOG0nuSp+zg2oyT7q7tr9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358658; c=relaxed/simple;
	bh=qKwHNgizoYlZuTm3svtllV/BXdvnJktI/0bUen6w9YE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lb+1WzPbiRT/ojmKDZKSKOGwtx9iScVcKZbApht4G/LTaRmm/hc97Bge4YIKtoWKJwllS98M0x79F/7OseazZUPt35xKwi0RKA+PKnikOmeU7Ilg2KOHTM29gQn/4Ik4u3IrrCsQtB+Rz0Q/omGd39KgXlFhntUX5+dX7/A+6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vV8qKAzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0882C433C7;
	Mon, 19 Feb 2024 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358658;
	bh=qKwHNgizoYlZuTm3svtllV/BXdvnJktI/0bUen6w9YE=;
	h=Subject:To:Cc:From:Date:From;
	b=vV8qKAzr16Rgm4/gNVcj56FxZ5HvKcNJH9IHTbTSSmQjrh4hJowk/yEOEIerHVetm
	 +9hh7E52HrPyizGNoiNYKYMJNFbkfhjMaDnLohtsYiT2S2yPJ2N2j5usL2schWr8ae
	 3mP8FIg5g1OIqHM3qQWMZuORpUbSNLrMjanQlEdo=
Subject: FAILED: patch "[PATCH] mptcp: fix rcv space initialization" failed to apply to 5.10-stable tree
To: pabeni@redhat.com,davem@davemloft.net,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:04:05 +0100
Message-ID: <2024021904-undertook-crushing-1de6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 013e3179dbd2bc756ce1dd90354abac62f65b739
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021904-undertook-crushing-1de6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

013e3179dbd2 ("mptcp: fix rcv space initialization")
4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
d109a7767273 ("mptcp: fix possible NULL pointer dereference on close")
8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
a5efdbcece83 ("mptcp: fix delegated action races")
27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
f6909dc1c1f4 ("mptcp: rename timer related helper to less confusing names")
ebc1e08f01eb ("mptcp: drop last_snd and MPTCP_RESET_SCHEDULER")
e263691773cd ("mptcp: Remove unnecessary test for __mptcp_init_sock()")
39880bd808ad ("mptcp: get rid of msk->subflow")
17ebf8a4c38b ("mptcp: fix the incorrect judgment for msk->cb_flags")
a7384f391875 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 013e3179dbd2bc756ce1dd90354abac62f65b739 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 8 Feb 2024 19:03:50 +0100
Subject: [PATCH] mptcp: fix rcv space initialization

mptcp_rcv_space_init() is supposed to happen under the msk socket
lock, but active msk socket does that without such protection.

Leverage the existing mptcp_propagate_state() helper to that extent.
We need to ensure mptcp_rcv_space_init will happen before
mptcp_rcv_space_adjust(), and the release_cb does not assure that:
explicitly check for such condition.

While at it, move the wnd_end initialization out of mptcp_rcv_space_init(),
it never belonged there.

Note that the race does not produce ill effect in practice, but
change allows cleaning-up and defying better the locking model.

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2111819016af..7632eafb683b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1963,6 +1963,9 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (copied <= 0)
 		return;
 
+	if (!msk->rcvspace_init)
+		mptcp_rcv_space_init(msk, msk->first);
+
 	msk->rcvq_space.copied += copied;
 
 	mstamp = div_u64(tcp_clock_ns(), NSEC_PER_USEC);
@@ -3160,6 +3163,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
+	msk->rcvspace_init = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
@@ -3247,6 +3251,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 {
 	const struct tcp_sock *tp = tcp_sk(ssk);
 
+	msk->rcvspace_init = 1;
 	msk->rcvq_space.copied = 0;
 	msk->rcvq_space.rtt_us = 0;
 
@@ -3257,8 +3262,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 				      TCP_INIT_CWND * tp->advmss);
 	if (msk->rcvq_space.space == 0)
 		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
-
-	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 }
 
 void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
@@ -3478,10 +3481,9 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
-
-	mptcp_rcv_space_init(msk, ssk);
 }
 
 void mptcp_sock_graft(struct sock *sk, struct socket *parent)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b905f1868298..9f5ee82e3473 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -304,7 +304,8 @@ struct mptcp_sock {
 			nodelay:1,
 			fastopening:1,
 			in_accept_queue:1,
-			free_first:1;
+			free_first:1,
+			rcvspace_init:1;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0dcb721c89d1..56b2ac2f2f22 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -424,6 +424,8 @@ void __mptcp_sync_state(struct sock *sk, int state)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	__mptcp_propagate_sndbuf(sk, msk->first);
+	if (!msk->rcvspace_init)
+		mptcp_rcv_space_init(msk, msk->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
 		mptcp_set_state(sk, state);
 		sk->sk_state_change(sk);
@@ -545,7 +547,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
-		mptcp_rcv_space_init(msk, sk);
 		mptcp_propagate_state(parent, sk);
 	}
 	return;
@@ -1744,7 +1745,6 @@ static void subflow_state_change(struct sock *sk)
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_do_fallback(sk);
-		mptcp_rcv_space_init(msk, sk);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk);


