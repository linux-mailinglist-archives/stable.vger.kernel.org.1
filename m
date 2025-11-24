Return-Path: <stable+bounces-196731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4596C80D77
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4EFA4E2106
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431130B511;
	Mon, 24 Nov 2025 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XCGn49wq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2326FDB2
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992167; cv=none; b=eRrEpA7yvnLbXvNW5/y/RdytUGm3MTxbIo5D4TkCIBK7tfYlbi7TUD9/g1gE0jMuUbWuEWR1gIBberRcu8mMj7OwL/Va6LAQ605uTXk15Kl0ixgSpnWQPg+ao1PPC2k+VH+f47KRKmzeRka936MDCoiPqZauddat35y8RTYjbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992167; c=relaxed/simple;
	bh=PJVZ1wrymc14ptitkvfQxQZj04h9Mltatg1bwz78wX4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fo7xoUeCL35+hb/+1gBqQqKt2kZCRlqP3b//s31a2riDkvxpIj95p48OJQ1RSn8OMYeza0PDPpchsIPvuZ8Ho7scKVln4eHtWJwyi+abmZhqptcJZxrE1iFovobU4bzO8l8Kd8BS1QfHMIP3IumEwxoe5CMWJLywok9dWwarulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XCGn49wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377FCC4CEF1;
	Mon, 24 Nov 2025 13:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992167;
	bh=PJVZ1wrymc14ptitkvfQxQZj04h9Mltatg1bwz78wX4=;
	h=Subject:To:Cc:From:Date:From;
	b=XCGn49wqInZCSRm7YZiU5uQbyHBFLfqIfsa53M8bWyKyH/EkAmpQrdJQloCoVOxBN
	 8XQe7fQ3pamcBLxSZ7G6EV81E7Ji+eWE2MbZntqY8sknEfPBIuTjTejH/xjHU5s4Ip
	 6+vDC2JXAIIVetYmElR0qVh7kqZEaeQvb636+BgY=
Subject: FAILED: patch "[PATCH] mptcp: fix premature close in case of fallback" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:49:24 +0100
Message-ID: <2025112424-drift-duffel-a7f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 17393fa7b7086664be519e7230cb6ed7ec7d9462
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112424-drift-duffel-a7f9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 17393fa7b7086664be519e7230cb6ed7ec7d9462 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 18 Nov 2025 08:20:21 +0100
Subject: [PATCH] mptcp: fix premature close in case of fallback

I'm observing very frequent self-tests failures in case of fallback when
running on a CONFIG_PREEMPT kernel.

The root cause is that subflow_sched_work_if_closed() closes any subflow
as soon as it is half-closed and has no incoming data pending.

That works well for regular subflows - MPTCP needs bi-directional
connectivity to operate on a given subflow - but for fallback socket is
race prone.

When TCP peer closes the connection before the MPTCP one,
subflow_sched_work_if_closed() will schedule the MPTCP worker to
gracefully close the subflow, and shortly after will do another schedule
to inject and process a dummy incoming DATA_FIN.

On CONFIG_PREEMPT kernel, the MPTCP worker can kick-in and close the
fallback subflow before subflow_sched_work_if_closed() is able to create
the dummy DATA_FIN, unexpectedly interrupting the transfer.

Address the issue explicitly avoiding closing fallback subflows on when
the peer is only half-closed.

Note that, when the subflow is able to create the DATA_FIN before the
worker invocation, the worker will change the msk state before trying to
close the subflow and will skip the latter operation as the msk will not
match anymore the precondition in __mptcp_close_subflow().

Fixes: f09b0ad55a11 ("mptcp: close subflow when receiving TCP+FIN")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-3-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e27e0fe2460f..e30e9043a694 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2563,7 +2563,8 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 		if (ssk_state != TCP_CLOSE &&
 		    (ssk_state != TCP_CLOSE_WAIT ||
-		     inet_sk_state_load(sk) != TCP_ESTABLISHED))
+		     inet_sk_state_load(sk) != TCP_ESTABLISHED ||
+		     __mptcp_check_fallback(msk)))
 			continue;
 
 		/* 'subflow_data_ready' will re-sched once rx queue is empty */


