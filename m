Return-Path: <stable+bounces-246301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLHXFPlvA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:22:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5ED527733
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B59F3089273
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F0330BB80;
	Tue, 12 May 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X5JoXQ9h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180EB3EDE63;
	Tue, 12 May 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608874; cv=none; b=MfQcx7sJ1BFoS4DGJNehckA+hHPqTi6C4POnvKO3PzXCjbqUEpLeKCqXM+28GHWUDoahjdWkgYVFjt4v4t4wNEZhbBoARpIJhHiTZ0s7eT4Tsyb8r4Eyiju06RE4x+OiFzZtlmloEWShDlgZitQnu4LvuZZSF5wuLRoJ6l06K/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608874; c=relaxed/simple;
	bh=3+9BVRrQ0BZ5HrG/xgqQ7+LjrsjQbgcxNg7kCNaylSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thoGN9/qcjIdeOJ/ESFyyNWDkxRyBfbw4yQAzxhtuXUOwpZ+iukBrboYo59wOli45c2lYC3R0rNvD8HicdRBvN/6aixQCbIMD6sxmhYddQKVyt9uEhNKnDzDQi2CpGBK1NrJj47Js9lXoRV1x6081X3sv7BPO3Vb3Vkl1PMmwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X5JoXQ9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A557C2BCB0;
	Tue, 12 May 2026 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608873;
	bh=3+9BVRrQ0BZ5HrG/xgqQ7+LjrsjQbgcxNg7kCNaylSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5JoXQ9hEZ9TEZGH15lErFXJCiqBiVllKjqv8wZ37xbJZXcfsjBCfeP7SRngMuhfk
	 XTyUpqf8/BS3Kd9jLvAAgrz9zGGS42/ZqWoZdiDUzmkxgZtyNNzJtFVqRqDAXgswhF
	 e8AWE/O0YpFpBXMcanOHFQhgHfr6hf0tYqUs4ato=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18 247/270] io_uring/tw: serialize ctx->retry_llist with ->uring_lock
Date: Tue, 12 May 2026 19:40:48 +0200
Message-ID: <20260512173943.639027649@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA5ED527733
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246301-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit 17666e2d7592c3e85260cafd3950121524acc2c5 upstream.

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
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1370,8 +1370,18 @@ void io_req_task_work_add_remote(struct
 
 static void __cold io_move_task_work_from_local(struct io_ring_ctx *ctx)
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



