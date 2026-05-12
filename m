Return-Path: <stable+bounces-245493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMorD9MjA2oF1AEAu9opvQ
	(envelope-from <stable+bounces-245493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:57:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE28F52087D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051EA3079552
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4383E4DA54C;
	Tue, 12 May 2026 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cAoJg3Fc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32B39E9CC
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589930; cv=none; b=kIm5EMfAIHvzhxM/fLa4LIwdPEBMrsEPhg+tdwD9Kx7dh1gajFnuClJFxfSvuN8YW57s/uOSrbE2jU8M2CCJDjAzxNN5V32QoQRAgO0mtYop2txuGbxPSKcnYxEhvi3WGE5vdbvl+XNv2e4moMXGrrtEWiRXLbUUEgmjona94js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589930; c=relaxed/simple;
	bh=GGFCbVyphswuX4bIrb/4+nPWdL3xRlaa822Ij15P028=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O6hpgaP3jmuo9O5YK6imVtyJIe04JYIJ4Kz22LKl7/ItACjI7OqdpRBU6ZSa2OPiKQ18KD05b2dNnH1uqBtj/nSZCLqefblH+Pr9PRVIIjRppiavDF51QNLk2THzLin7VLNTBnQiXFSLgjq0Cc78ROqLq5VEHBV1+949dXoep7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cAoJg3Fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EFAC2BCF5;
	Tue, 12 May 2026 12:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778589930;
	bh=GGFCbVyphswuX4bIrb/4+nPWdL3xRlaa822Ij15P028=;
	h=Subject:To:Cc:From:Date:From;
	b=cAoJg3Fc8TfiCtS2DP/gbuVGAkcHg1odrtYVb9Rf14s+iNGQvPwpjcXRW4qbOT1yU
	 Earjpt6HZ/GaI32XiGDmtpeZLaYfwhmWk8mKdQgUdqeMH2v7+hG5HYUhx55pPV+PvA
	 PUYlOYuGy/re8gZCwIpjQSg6gebEykMPwLuiaODg=
Subject: FAILED: patch "[PATCH] io_uring/tw: serialize ctx->retry_llist with ->uring_lock" failed to apply to 6.18-stable tree
To: axboe@kernel.dk,invd@inhq.net,michael.rodler@x41-dsec.de,robert.femmer@x41-dsec.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:41:42 +0200
Message-ID: <2026051242-reproach-duplicity-8d39@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE28F52087D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245493-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,inhq.net:email,kernel.dk:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 17666e2d7592c3e85260cafd3950121524acc2c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051242-reproach-duplicity-8d39@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 17666e2d7592c3e85260cafd3950121524acc2c5 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 27 Apr 2026 14:29:02 -0600
Subject: [PATCH] io_uring/tw: serialize ctx->retry_llist with ->uring_lock

The DEFER_TASKRUN local task work paths all run under ctx->uring_lock,
which serializes them with each other and with the rest of the ring's
hot paths. io_move_task_work_from_local() is the exception - it's called
from io_ring_exit_work() on a kworker without holding the lock and from
the iopoll cancelation side right after dropping it.

->work_llist is fine with this, as it's only ever updated via the
expected paths. But the ->retry_llist is updated while runing, and hence
it could potentially race between normal task_work running and the
task-has-exited shutdown path.

Simply grab ->uring_lock while moving the local work to the fallback
list for exit purposes, which nicely serializes it across both the
normal additions and the exit prune path.

Cc: stable@vger.kernel.org
Fixes: f46b9cdb22f7 ("io_uring: limit local tw done")
Reported-by: Robert Femmer <robert.femmer@x41-dsec.de>
Reported-by: Christian Reitter <invd@inhq.net>
Reported-by: Michael Rodler <michael.rodler@x41-dsec.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/tw.c b/io_uring/tw.c
index fdff81eebc95..023d5e6bc491 100644
--- a/io_uring/tw.c
+++ b/io_uring/tw.c
@@ -273,8 +273,18 @@ void io_req_task_work_add_remote(struct io_kiocb *req, unsigned flags)
 
 void __cold io_move_task_work_from_local(struct io_ring_ctx *ctx)
 {
-	struct llist_node *node = llist_del_all(&ctx->work_llist);
+	struct llist_node *node;
 
+	/*
+	 * Running the work items may utilize ->retry_llist as a means
+	 * for capping the number of task_work entries run at the same
+	 * time. But that list can potentially race with moving the work
+	 * from here, if the task is exiting. As any normal task_work
+	 * running holds ->uring_lock already, just guard this slow path
+	 * with ->uring_lock to avoid racing on ->retry_llist.
+	 */
+	guard(mutex)(&ctx->uring_lock);
+	node = llist_del_all(&ctx->work_llist);
 	__io_fallback_tw(node, false);
 	node = llist_del_all(&ctx->retry_llist);
 	__io_fallback_tw(node, false);


