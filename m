Return-Path: <stable+bounces-65540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FAE94A95F
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B141C216EC
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC4954F87;
	Wed,  7 Aug 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CODPKAXw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18B2AF16
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039511; cv=none; b=c/B8nD/MGjZNooZyou2DKXS+uN+F/QAuGHkW6ZCVGoUInCPj7AX20CUCeejvZyoX8Ap0ZJAEi2VTZuUjfbPJBESgNwLb6e8wijHGjT75cRUfvQFcnHt4aixUVHvOXec/2yIPY+IrOuU23n6crWIBOod89/u8YmXgpvR19DqVlz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039511; c=relaxed/simple;
	bh=ZQdY2GXkMvaT6hQTwXDbPJWtse9Esyu0Sv9ojKFF340=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JPVf2fWUgmTmVWD5DTY1CZL8198wG7GQopAoK44Yd7HGJIfxaqwgKr8rSvTroynFDZAZvfjC1HhVCC1AtxRDESN+PNNEv+PQgOwv+5iER/tqWnzNB9jIff5cK+yY6t8ELElCEDqpn9/j5xWrjXvfRmy0SMP0qHlSkbxWR2H10B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CODPKAXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98C7C4AF0B;
	Wed,  7 Aug 2024 14:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039511;
	bh=ZQdY2GXkMvaT6hQTwXDbPJWtse9Esyu0Sv9ojKFF340=;
	h=Subject:To:Cc:From:Date:From;
	b=CODPKAXwfhoAUdymH6so/hga3JzYSfVoxlqN5Dv4+C7SfNVMUg0/b5c3LFhEgLm3e
	 z/Dv5k9NzkXNmXVgFY1pn+WjvO9xgZ4aYyJSKCL6h5Phc50r8BGpMCgSOmk4QbuENI
	 dCEX1YgP5Ua/nUJ3vCKNopYXXtLh0Vn9QzOv59Lo=
Subject: FAILED: patch "[PATCH] mptcp: sched: check both directions for backup" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:04:59 +0200
Message-ID: <2024080759-deploy-send-dfa5@gregkh>
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
git cherry-pick -x b6a66e521a2032f7fcba2af5a9bcbaeaa19b7ca3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080759-deploy-send-dfa5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

b6a66e521a20 ("mptcp: sched: check both directions for backup")
3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation")
ff5a0b421cb2 ("mptcp: faster active backup recovery")
6da14d74e2bd ("mptcp: cleanup sysctl data and helpers")
1e1d9d6f119c ("mptcp: handle pending data on closed subflow")
71b7dec27f34 ("mptcp: less aggressive retransmission strategy")
33d41c9cd74c ("mptcp: more accurate timeout")
d2f77960e5b0 ("mptcp: add sysctl allow_join_initial_addr_port")
8ce568ed06ce ("mptcp: drop tx skb cache")
fc3c82eebf8e ("mptcp: add a new sysctl checksum_enabled")
752e906732c6 ("mptcp: add csum_enabled in mptcp_sock")
744ee14054c8 ("mptcp: restrict values of 'enabled' sysctl")
804c72eeecd2 ("mptcp: support SYSCTL only if enabled")
ae514983f2e4 ("mptcp: remove redundant initialization in pm_nl_init_net()")
6876a18d3361 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b6a66e521a2032f7fcba2af5a9bcbaeaa19b7ca3 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:23 +0200
Subject: [PATCH] mptcp: sched: check both directions for backup

The 'mptcp_subflow_context' structure has two items related to the
backup flags:

 - 'backup': the subflow has been marked as backup by the other peer

 - 'request_bkup': the backup flag has been set by the host

Before this patch, the scheduler was only looking at the 'backup' flag.
That can make sense in some cases, but it looks like that's not what we
wanted for the general use, because either the path-manager was setting
both of them when sending an MP_PRIO, or the receiver was duplicating
the 'backup' flag in the subflow request.

Note that the use of these two flags in the path-manager are going to be
fixed in the next commits, but this change here is needed not to modify
the behaviour.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 09e72215b9f9..085b749cdd97 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -34,7 +34,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		struct sock *ssk;
 
 		__entry->active = mptcp_subflow_active(subflow);
-		__entry->backup = subflow->backup;
+		__entry->backup = subflow->backup || subflow->request_bkup;
 
 		if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
 			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a26c2c840fd9..a2fc54ed68c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1422,13 +1422,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		pace = subflow->avg_pacing_rate;
 		if (unlikely(!pace)) {
 			/* init pacing rate from socket */
@@ -1439,9 +1441,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		}
 
 		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
-		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].linger_time = linger_time;
+		if (linger_time < send_info[backup].linger_time) {
+			send_info[backup].ssk = ssk;
+			send_info[backup].linger_time = linger_time;
 		}
 	}
 	__mptcp_set_timeout(sk, tout);


