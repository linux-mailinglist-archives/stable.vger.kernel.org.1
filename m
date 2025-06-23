Return-Path: <stable+bounces-158036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A70AE56A5
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718311C22651
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91930222599;
	Mon, 23 Jun 2025 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cc8zEDMl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD47199FBA;
	Mon, 23 Jun 2025 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717326; cv=none; b=jLYtraVs2HXndGptXSEu2+CHLeLxGOXj3OWcn6RgzMVPtkEl4JaUAYxMTShclLwWCYy5ec5C+EMTzhV+Fr8+vbCpY0sdUeotE3TQsa+mdWCMaaQmEA1+9xoKjVkP5fEdtFJe8mQbVtWM8/IQsaS99IuR1rb1f572DGKi9yGZtrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717326; c=relaxed/simple;
	bh=PbqY/EBSdKIRHsUpJj9egCyBu5tl0+njpr9LxAkle1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNyWcBT1S8KLmrdgj7Ks244uppyrWfeN2YnXfEEVfJJ6IsSVh2CD5jckIF5UWDKTIyxs51NqGnBq9MyN/w0fwmcwvQNuNoqhYvofV9eW4zIU9tWrgFnUJ4vnXuQT7B++EA204R5cnqmF2ebbtuIpZXCnVMzduIJrpqcl7COJHxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cc8zEDMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD220C4CEEA;
	Mon, 23 Jun 2025 22:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717326;
	bh=PbqY/EBSdKIRHsUpJj9egCyBu5tl0+njpr9LxAkle1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cc8zEDMlwnF5qyyICUMFkpOfl0SK+/qHzWwY44TFJeiOfdrJ9CJUvbNBAIvvY+5gl
	 3uF7uSD3O1VmEiWz6yJvlGnXcxuNB+2p+sGoUIWAki7O//V9Fycb+VEIuaV60/wh/R
	 iPvTtVk6EYJNG/tLrSrvDDtCtqEoU3WQ9eJ9WIpg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+763e12bbf004fb1062e4@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 366/414] io_uring/sqpoll: dont put task_struct on tctx setup failure
Date: Mon, 23 Jun 2025 15:08:23 +0200
Message-ID: <20250623130651.111663741@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit f2320f1dd6f6f82cb2c7aff23a12bab537bdea89 ]

A recent commit moved the error handling of sqpoll thread and tctx
failures into the thread itself, as part of fixing an issue. However, it
missed that tctx allocation may also fail, and that
io_sq_offload_create() does its own error handling for the task_struct
in that case.

Remove the manual task putting in io_sq_offload_create(), as
io_sq_thread() will notice that the tctx did not get setup and hence it
should put itself and exit.

Reported-by: syzbot+763e12bbf004fb1062e4@syzkaller.appspotmail.com
Fixes: ac0b8b327a56 ("io_uring: fix use-after-free of sq->thread in __io_uring_show_fdinfo()")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/sqpoll.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 9a63068948957..2faa3058b2d0e 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -426,7 +426,6 @@ void io_sqpoll_wait_sq(struct io_ring_ctx *ctx)
 __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 				struct io_uring_params *p)
 {
-	struct task_struct *task_to_put = NULL;
 	int ret;
 
 	/* Retain compatibility with failing for an invalid attach attempt */
@@ -510,7 +509,7 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		rcu_assign_pointer(sqd->thread, tsk);
 		mutex_unlock(&sqd->lock);
 
-		task_to_put = get_task_struct(tsk);
+		get_task_struct(tsk);
 		ret = io_uring_alloc_task_context(tsk, ctx);
 		wake_up_new_task(tsk);
 		if (ret)
@@ -525,8 +524,6 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 	complete(&ctx->sq_data->exited);
 err:
 	io_sq_thread_finish(ctx);
-	if (task_to_put)
-		put_task_struct(task_to_put);
 	return ret;
 }
 
-- 
2.39.5




