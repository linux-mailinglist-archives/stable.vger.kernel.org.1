Return-Path: <stable+bounces-106554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2819FE8D0
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D4E161F5C
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099DF15748F;
	Mon, 30 Dec 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jOq8PrmY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10315E8B;
	Mon, 30 Dec 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735574380; cv=none; b=Qlo59LXMUDJchguX4I/7ImFEn1nqbJa1Vgs/8+ymuqSBNC+eAqOMeSExi1wER6paxVDzpc9+/RWJpwnm64yGYogKGhz4wE27e59mSXDxAG+DF0VKwtHVExoe3p8ptiYZbTxjfmQRwtYkdiAN862ap2kzTgAPjMqHaqW0mVgIgD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735574380; c=relaxed/simple;
	bh=pNyKpCmWmExDRb7ZqkngpcEUhqsYg/3oNx2nnq6tQ1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVwDfi2/BWETPW/5BG/FbLKWXOsQ1nuAhsa++UXINBrvUhUBZNP4bsPSn4dESCtMhQCr19zS8T/ymRp5gUmRsz41dBVoaxYuPd8ajthMMWl0iAMl0gyEZNBjMG6eSgZSgbh7nqk+fs8+JqionB+IzkHOw5bxZyrdDKz9lCgXSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jOq8PrmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B61CC4CED6;
	Mon, 30 Dec 2024 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735574380;
	bh=pNyKpCmWmExDRb7ZqkngpcEUhqsYg/3oNx2nnq6tQ1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOq8PrmYcUE+ZfUR4DpKs35YkFmqt+r2bWfP6C+F/PmZ8LiRSg8hwCVc0Fd7gDaqe
	 mB+nXpTSNJsKp2kZY+hyQgU3ITM3cvDYLnVMLhhjOVwuRXijhu1XBl8Q+9GEcK0nLi
	 T59+TJvl5G1a4LBwWW6ET5qxKxYzi1hnMizTZDdY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kun Hu <huk23@m.fudan.edu.cn>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 088/114] io_uring/sqpoll: fix sqpoll error handling races
Date: Mon, 30 Dec 2024 16:43:25 +0100
Message-ID: <20241230154221.479925982@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>
References: <20241230154218.044787220@linuxfoundation.org>
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

From: Pavel Begunkov <asml.silence@gmail.com>

commit e33ac68e5e21ec1292490dfe061e75c0dbdd3bd4 upstream.

BUG: KASAN: slab-use-after-free in __lock_acquire+0x370b/0x4a10 kernel/locking/lockdep.c:5089
Call Trace:
<TASK>
...
_raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
try_to_wake_up+0xb5/0x23c0 kernel/sched/core.c:4205
io_sq_thread_park+0xac/0xe0 io_uring/sqpoll.c:55
io_sq_thread_finish+0x6b/0x310 io_uring/sqpoll.c:96
io_sq_offload_create+0x162/0x11d0 io_uring/sqpoll.c:497
io_uring_create io_uring/io_uring.c:3724 [inline]
io_uring_setup+0x1728/0x3230 io_uring/io_uring.c:3806
...

Kun Hu reports that the SQPOLL creating error path has UAF, which
happens if io_uring_alloc_task_context() fails and then io_sq_thread()
manages to run and complete before the rest of error handling code,
which means io_sq_thread_finish() is looking at already killed task.

Note that this is mostly theoretical, requiring fault injection on
the allocation side to trigger in practice.

Cc: stable@vger.kernel.org
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/0f2f1aa5729332612bd01fe0f2f385fd1f06ce7c.1735231717.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/sqpoll.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -412,6 +412,7 @@ void io_sqpoll_wait_sq(struct io_ring_ct
 __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 				struct io_uring_params *p)
 {
+	struct task_struct *task_to_put = NULL;
 	int ret;
 
 	/* Retain compatibility with failing for an invalid attach attempt */
@@ -492,6 +493,7 @@ __cold int io_sq_offload_create(struct i
 		}
 
 		sqd->thread = tsk;
+		task_to_put = get_task_struct(tsk);
 		ret = io_uring_alloc_task_context(tsk, ctx);
 		wake_up_new_task(tsk);
 		if (ret)
@@ -502,11 +504,15 @@ __cold int io_sq_offload_create(struct i
 		goto err;
 	}
 
+	if (task_to_put)
+		put_task_struct(task_to_put);
 	return 0;
 err_sqpoll:
 	complete(&ctx->sq_data->exited);
 err:
 	io_sq_thread_finish(ctx);
+	if (task_to_put)
+		put_task_struct(task_to_put);
 	return ret;
 }
 



