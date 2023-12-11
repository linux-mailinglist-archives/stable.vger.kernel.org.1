Return-Path: <stable+bounces-6284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABFC80D9D9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8035D1F20CA6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69808524D2;
	Mon, 11 Dec 2023 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HP1wU1oW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B5E548;
	Mon, 11 Dec 2023 18:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB3BC433C8;
	Mon, 11 Dec 2023 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702321012;
	bh=VsKPg+CnHSrkc2puV0krDQabHkF2wVAOCZslqjPdSLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HP1wU1oW6rCKrOPjip3vZIIAGuU9oGKZDYkGvujlA+Xwyz1PWL0ND+14v6J6OcGkX
	 O+MrMY9nAV606HEsDJ/BRo6ChvdZxM0tkZGQA8WnFUgrjf0OCj3mFttAJs7xDd33X9
	 yagoWvip5RbsAWr0mc+H17Vwp8H/cCPXgZTOAiAk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 078/141] io_uring: fix mutex_unlock with unreferenced ctx
Date: Mon, 11 Dec 2023 19:22:17 +0100
Message-ID: <20231211182029.936971617@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

commit f7b32e785042d2357c5abc23ca6db1b92c91a070 upstream.

Callers of mutex_unlock() have to make sure that the mutex stays alive
for the whole duration of the function call. For io_uring that means
that the following pattern is not valid unless we ensure that the
context outlives the mutex_unlock() call.

mutex_lock(&ctx->uring_lock);
req_put(req); // typically via io_req_task_submit()
mutex_unlock(&ctx->uring_lock);

Most contexts are fine: io-wq pins requests, syscalls hold the file,
task works are taking ctx references and so on. However, the task work
fallback path doesn't follow the rule.

Cc:  <stable@vger.kernel.org>
Fixes: 04fc6c802d ("io_uring: save ctx put/get for task_work submit")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/io-uring/CAG48ez3xSoYb+45f1RLtktROJrpiDQ1otNvdR+YLQf7m+Krj5Q@mail.gmail.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2601,6 +2601,7 @@ static void io_iopoll_try_reap_events(st
 	if (!(ctx->flags & IORING_SETUP_IOPOLL))
 		return;
 
+	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
 	while (!list_empty(&ctx->iopoll_list)) {
 		unsigned int nr_events = 0;
@@ -2622,6 +2623,7 @@ static void io_iopoll_try_reap_events(st
 		}
 	}
 	mutex_unlock(&ctx->uring_lock);
+	percpu_ref_put(&ctx->refs);
 }
 
 static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
@@ -9771,12 +9773,7 @@ static void io_ring_exit_work(struct wor
 	init_completion(&exit.completion);
 	init_task_work(&exit.task_work, io_tctx_exit_cb);
 	exit.ctx = ctx;
-	/*
-	 * Some may use context even when all refs and requests have been put,
-	 * and they are free to do so while still holding uring_lock or
-	 * completion_lock, see io_req_task_submit(). Apart from other work,
-	 * this lock/unlock section also waits them to finish.
-	 */
+
 	mutex_lock(&ctx->uring_lock);
 	while (!list_empty(&ctx->tctx_list)) {
 		WARN_ON_ONCE(time_after(jiffies, timeout));



