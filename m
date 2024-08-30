Return-Path: <stable+bounces-71596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DF965F09
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE86CB25BF7
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B4317D344;
	Fri, 30 Aug 2024 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2wZBGLKR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD417C7BE
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013419; cv=none; b=gRYIaW8anrEjrdim7UO6BIwwyvP2zOXPoCdjHA8Ek/QgEzHKuin6nE1dSqtN/Hc2aDDzWQuFoF98bFm1DQVkxkwaiSAQ42pOSyjKYHKwIrBjHI9BG6QenPW6CPn5wXg8Pml1Zx7na+FgIMB1qO7/t/ueqdnQdTHileTLa6mnW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013419; c=relaxed/simple;
	bh=ZyC/uAZszreM6R2+pWryHDZmxshkh+J1GcOTirjaoWA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OpfeGaw1ZlOk1b4/6iAk/cEsgjzjVar4QCqOp0eB9vJGBTrVF5LZTPEaCABxVxISZSqV3k2bCAckscA50TBRzAt5fbu/L5m+aOxdF6T3h3v8OffACgBmSRed+W9ZNfBRtk33DpunzkpilZ84xLCzmZKP1G49JLJpdVPlKbJT620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2wZBGLKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00A8C4CEC2;
	Fri, 30 Aug 2024 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013419;
	bh=ZyC/uAZszreM6R2+pWryHDZmxshkh+J1GcOTirjaoWA=;
	h=Subject:To:Cc:From:Date:From;
	b=2wZBGLKRQFE2QEZ8d0Pwkp70/iIRsIhWEI0AcuH8qgR9QIJdZ4cUkEWyFZXAMvpm0
	 79A/Ha84s97B8qKpEOQ9pOlxmq1MrUpFuKLXdCa5Od09HOwhVcau8nwiO4fgFVrZAo
	 tNRNxW2MQwKFPBXWX/Jxz3Rk983wuY8gpJKcP1F0=
Subject: FAILED: patch "[PATCH] mptcp: avoid duplicated SUB_CLOSED events" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,arinc.unal@arinc9.com,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:23:28 +0200
Message-ID: <2024083028-coauthor-moving-1474@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d82809b6c5f2676b382f77a5cbeb1a5d91ed2235
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083028-coauthor-moving-1474@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
a7cfe7766370 ("mptcp: fix data races on local_id")
84c531f54ad9 ("mptcp: userspace pm send RM_ADDR for ID 0")
f1f26512a9bf ("mptcp: use plain bool instead of custom binary enum")
1e07938e29c5 ("net: mptcp: rename netlink handlers to mptcp_pm_nl_<blah>_{doit,dumpit}")
1d0507f46843 ("net: mptcp: convert netlink from small_ops to ops")
fce68b03086f ("mptcp: add scheduled in mptcp_subflow_context")
1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
740ebe35bd3f ("mptcp: add struct mptcp_sched_ops")
a7384f391875 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d82809b6c5f2676b382f77a5cbeb1a5d91ed2235 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:35 +0200
Subject: [PATCH] mptcp: avoid duplicated SUB_CLOSED events
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The initial subflow might have already been closed, but still in the
connection list. When the worker is instructed to close the subflows
that have been marked as closed, it might then try to close the initial
subflow again.

 A consequence of that is that the SUB_CLOSED event can be seen twice:

  # ip mptcp endpoint
  1.1.1.1 id 1 subflow dev eth0
  2.2.2.2 id 2 subflow dev eth1

  # ip mptcp monitor &
  [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9

  # ip mptcp endpoint delete id 1
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9

The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
second one from __mptcp_close_subflow().

To avoid doing the post-closed processing twice, the subflow is now
marked as closed the first time.

Note that it is not enough to check if we are dealing with the first
subflow and check its sk_state: the subflow might have been reset or
closed before calling mptcp_close_ssk().

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b571fba88a2f..37ebcb7640eb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2508,6 +2508,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->close_event_done)
+		return;
+
+	subflow->close_event_done = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 240d7c2ea551..26eb898a202b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -524,7 +524,8 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 10;
+		close_event_done : 1,       /* has done the post-closed part */
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;


