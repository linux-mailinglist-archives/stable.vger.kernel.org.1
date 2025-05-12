Return-Path: <stable+bounces-143179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E08E6AB3451
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BD87A891B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6C818B47E;
	Mon, 12 May 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1PXo1CSz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01DB11712
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044077; cv=none; b=oD92GOn9IXZbxntZwDlxhuv3prmUpP4TrzWQhzeARmN37aHQdH92cuMcZCV83RzxTBCuc3Th008ACvkqEjTbFifsEAgrVfsoiJAtCF5d8JmjYoeRpCvVA7rKbJt8Fef8oRKPaNlFKvPKbdotmYka3t2uyr9y7sK437/Bucl/obM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044077; c=relaxed/simple;
	bh=g8G6gq2aV+3Z8mfCfZvglS4uCvm9tnQRgfKdKnN6lg0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SFJrJD9eIh4BH84BwErt0LWP9v5nze4DdF6mHX9XnMvlDRszbGwBoTmCV1JkHmEsQPyYISXu7fRrzWgec3fWesd3n4y5IuzCCCs8ulthq6XRpi+mYlHPGuMQSKKefW9m3jqXphMNKZOjLDy+28nrYdidKgks9MX94rsfCfhyvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1PXo1CSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7E5C4CEE9;
	Mon, 12 May 2025 10:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044075;
	bh=g8G6gq2aV+3Z8mfCfZvglS4uCvm9tnQRgfKdKnN6lg0=;
	h=Subject:To:Cc:From:Date:From;
	b=1PXo1CSzTWeCdWjumf5ZukD1SmRXEFWSwiBbCz2Rva3NCI4O+b5MX2CCLO9wzL8hY
	 QFYs0R+UwWZb3vbOX8mkB44yi6O0THPVMPioqcqeOSp3KOxe/RqusyDUpsvD2xeajT
	 Bzuw4R8h3oV09MhrOI1Cy4cwH2yruuXdCeduiNBw=
Subject: FAILED: patch "[PATCH] io_uring: ensure deferred completions are flushed for" failed to apply to 6.1-stable tree
To: axboe@kernel.dk,christian.mazakas@gmail.com,norman_maurer@apple.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:01:12 +0200
Message-ID: <2025051212-antirust-outshoot-07f7@gregkh>
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
git cherry-pick -x 687b2bae0efff9b25e071737d6af5004e6e35af5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051212-antirust-outshoot-07f7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 687b2bae0efff9b25e071737d6af5004e6e35af5 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 7 May 2025 07:34:24 -0600
Subject: [PATCH] io_uring: ensure deferred completions are flushed for
 multishot

Multishot normally uses io_req_post_cqe() to post completions, but when
stopping it, it may finish up with a deferred completion. This is fine,
except if another multishot event triggers before the deferred completions
get flushed. If this occurs, then CQEs may get reordered in the CQ ring,
as new multishot completions get posted before the deferred ones are
flushed. This can cause confusion on the application side, if strict
ordering is required for the use case.

When multishot posting via io_req_post_cqe(), flush any pending deferred
completions first, if any.

Cc: stable@vger.kernel.org # 6.1+
Reported-by: Norman Maurer <norman_maurer@apple.com>
Reported-by: Christian Mazakas <christian.mazakas@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 769814d71153..541e65a1eebf 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -848,6 +848,14 @@ bool io_req_post_cqe(struct io_kiocb *req, s32 res, u32 cflags)
 	struct io_ring_ctx *ctx = req->ctx;
 	bool posted;
 
+	/*
+	 * If multishot has already posted deferred completions, ensure that
+	 * those are flushed first before posting this one. If not, CQEs
+	 * could get reordered.
+	 */
+	if (!wq_list_empty(&ctx->submit_state.compl_reqs))
+		__io_submit_flush_completions(ctx);
+
 	lockdep_assert(!io_wq_current_is_worker());
 	lockdep_assert_held(&ctx->uring_lock);
 


