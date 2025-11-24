Return-Path: <stable+bounces-196733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F6C80D86
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C72D94E1FD3
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA5730B517;
	Mon, 24 Nov 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="emhfAkqw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D830B514
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992215; cv=none; b=LJgeDK6DPM3OTDTTR3mN/51R8LagDIPNAYMwAtk/+V5ta66n3wWtvhlMlIpcZ2rqlh6y37+v3xeNDu/Qplf4WhmrRrjkd5Vg00ZfbFPSFXvl0zltX444y1O3ZnxFdcSlqXiUB/7FhkrOBd6yzJU/RDPkrozezvKBA/r95vWJErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992215; c=relaxed/simple;
	bh=I7kSVIaPC3emC/hp8tOq0z9CrMTx93Szrv+vOoH1JkU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VHNGUJ7z7CDqQytvqyHXYjuy0sS4diwPALEsBYgbZRdug0SdKVQSxuj0qZnIBwuYc269Gd3sWRik+LDE7PYPT0z5Ue/u5yM1FvSsWkq6z8m8CZ+bh2UOQm33O6ifIny5TetiJS/iBUeFsVDCVLHghZlsJJL/XzyZFuRPXNchGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=emhfAkqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018C5C116C6;
	Mon, 24 Nov 2025 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992215;
	bh=I7kSVIaPC3emC/hp8tOq0z9CrMTx93Szrv+vOoH1JkU=;
	h=Subject:To:Cc:From:Date:From;
	b=emhfAkqwg7X100I/Lq9/o36/vmXQMe2ZHZ/b9Pd4sx0miuG6SgUjae6H9jKNrtE/t
	 gUIRKccgtKOgEA84jVPt5GYSbZwghpl24YumLG8KII+/hoXcXPSYAWayaq2sNHbwGL
	 Z7N3PohanxcCSgKJTlgXw9tEfQeCK2zCXpVeWqDo=
Subject: FAILED: patch "[PATCH] mptcp: decouple mptcp fastclose from tcp close" failed to apply to 6.1-stable tree
To: pabeni@redhat.com,geliang@kernel.org,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:50:12 +0100
Message-ID: <2025112412-trough-caloric-1503@gregkh>
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
git cherry-pick -x fff0c87996672816a84c3386797a5e69751c5888
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112412-trough-caloric-1503@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fff0c87996672816a84c3386797a5e69751c5888 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 18 Nov 2025 08:20:23 +0100
Subject: [PATCH] mptcp: decouple mptcp fastclose from tcp close

With the current fastclose implementation, the mptcp_do_fastclose()
helper is in charge of two distinct actions: send the fastclose reset
and cleanup the subflows.

Formally decouple the two steps, ensuring that mptcp explicitly closes
all the subflows after the mentioned helper.

This will make the upcoming fix simpler, and allows dropping the 2nd
argument from mptcp_destroy_common(). The Fixes tag is then the same as
in the next commit to help with the backports.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-5-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6f0e8f670d83..c59246c1fde6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2808,7 +2808,11 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_close_subflow(sk);
 
 	if (mptcp_close_tout_expired(sk)) {
+		struct mptcp_subflow_context *subflow, *tmp;
+
 		mptcp_do_fastclose(sk);
+		mptcp_for_each_subflow_safe(msk, subflow, tmp)
+			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
 		mptcp_close_wake_up(sk);
 	}
 
@@ -3233,7 +3237,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
 	 */
-	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+	mptcp_do_fastclose(sk);
+	mptcp_destroy_common(msk);
 
 	/* The first subflow is already in TCP_CLOSE status, the following
 	 * can't overlap with a fallback anymore
@@ -3412,7 +3417,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
+void mptcp_destroy_common(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -3421,7 +3426,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 
 	/* join list will be eventually flushed (with rst) at sock lock release time */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, 0);
 
 	__skb_queue_purge(&sk->sk_receive_queue);
 	skb_rbtree_purge(&msk->out_of_order_queue);
@@ -3439,7 +3444,7 @@ static void mptcp_destroy(struct sock *sk)
 
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
-	mptcp_destroy_common(msk, 0);
+	mptcp_destroy_common(msk);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5575ef64ea31..6ca97096607c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -977,7 +977,7 @@ static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
 	local_bh_enable();
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
+void mptcp_destroy_common(struct mptcp_sock *msk);
 
 #define MPTCP_TOKEN_MAX_RETRIES	4
 


