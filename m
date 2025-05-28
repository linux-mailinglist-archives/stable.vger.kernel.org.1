Return-Path: <stable+bounces-148020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A830AC7338
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 23:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427501C02F8C
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 22:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A09F21CC55;
	Wed, 28 May 2025 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM2cnRNq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5168221736;
	Wed, 28 May 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469379; cv=none; b=VCriAWTcv6o27cbIqru1q3iC0O8cZVZB0TYxCct+RqELt/txvOJ8FfqU5bvfqEbETCV0sF1XlI3zH5HrZeH/Xtv4uV/JcZcfi5Ov+SGMGbWt4IYrwtImhFEHfYrdTM+929UL2VECmRZg5XWO9iOtBpC7yEXVOttv2bKLe9bMyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469379; c=relaxed/simple;
	bh=oqVJoyr0C4/f9iDyvnbxTN8UmJXvvDFSsB9YY7n7y2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJlnW7WEJHjC2AYY3EkaxMWfa70YGRj1ozXQN4MGjREFhRq++X4N5/1ZV1+Z5QzrwYY8s7kN64/M+z5XO6AkCXwCbDGO/Aq5a3O63jX1Bo6GkGAW8TK4fRkqpL4WgmaU0Kcfw2tnK3P6oCq+dxwzfKAymx2bkD1Yg56oTC0SZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM2cnRNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3B1C4CEE3;
	Wed, 28 May 2025 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748469379;
	bh=oqVJoyr0C4/f9iDyvnbxTN8UmJXvvDFSsB9YY7n7y2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fM2cnRNqBFn0Q5QkuRefQCqTJP/fAt8Quvgyj48sjYVVg7A3ySilBI2FBN0U1Yei3
	 j9+ea9h8ErYgg+Ao2hVhkE753va+wzacEqnv3YED8jYW+UYhJlCP/+qpOT8lt59h0L
	 I/FpfPH7TE8qxGxs4hxDYGv+OBLfVy7Q4DQf9CrpCenm+FoH92Q/PitJQHhwMp9488
	 GaG0sNAREpKqS/NDhg2gq39E+UGWam98bNbXOD1AMb0uCKULq6qcYj5hA8wBPM/g0W
	 GLvK/ITi7dADp//3V4TcrdH7e1nm0d2usxR3ar0YeBpLvNnMq8h4ayFYQ95QETUti9
	 XO5E1YeQoY1wA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 6/8] io_uring: fix spurious drain flushing
Date: Wed, 28 May 2025 17:56:09 -0400
Message-Id: <20250528215611.1983429-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528215611.1983429-1-sashal@kernel.org>
References: <20250528215611.1983429-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit fde04c7e2775feb0746301e0ef86a04d3598c3fe ]

io_queue_deferred() is not tolerant to spurious calls not completing
some requests. You can have an inflight drain-marked request and another
request that came after and got queued into the drain list. Now, if
io_queue_deferred() is called before the first request completes, it'll
check the 2nd req with req_need_defer(), find that there is no drain
flag set, and queue it for execution.

To make io_queue_deferred() work, it should at least check sequences for
the first request, and then we need also need to check if there is
another drain request creating another bubble.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/972bde11b7d4ef25b3f5e3fd34f80e4d2aa345b8.1746788718.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Let me analyze the commit by examining the differences between what the
commit shows and what should be the fix: Based on my analysis of the
commit message and code changes, here is my evaluation: **YES** This
commit should be backported to stable kernel trees. Here's my extensive
analysis: ## Bug Analysis The commit fixes a serious correctness issue
in the io_uring drain mechanism. The problem described is: 1. **Spurious
drain flushing**: The original `io_queue_deferred()` function was not
tolerant to spurious calls 2. **Race condition**: When a drain-marked
request is inflight and another request gets queued into the defer list,
calling `io_queue_deferred()` before the first request completes could
incorrectly queue the second request for execution 3. **Incorrect
sequence checking**: The function only checked `req_need_defer()` which
looks for the drain flag, but didn't properly handle the sequencing
requirements ## Code Changes Analysis The fix introduces several
important changes: 1. **New helper function `io_drain_defer_seq()`**:
```c static bool io_drain_defer_seq(struct io_kiocb *req, u32 seq) {
struct io_ring_ctx *ctx = req->ctx; return seq +
READ_ONCE(ctx->cq_extra) != ctx->cached_cq_tail; } ``` This properly
checks sequence ordering for drain requests. 2. **Enhanced
`io_queue_deferred()` logic**: - Tracks if any drain request has been
seen (`drain_seen`) - Uses `first` flag to handle the initial request
specially - Replaces the simple `req_need_defer()` check with
`io_drain_defer_seq()` when drain semantics are involved 3. **Proper
drain bubble handling**: The new logic ensures that when there's a drain
request, subsequent requests wait for proper sequencing, preventing the
"spurious drain flushing" problem. ## Backport Criteria Assessment ✅
**Fixes important bug**: This addresses a correctness issue in
io_uring's drain mechanism that could lead to out-of-order execution of
requests, violating user expectations and potentially causing data
corruption or race conditions. ✅ **Small and contained**: The changes
are minimal and focused - adding one helper function and modifying the
logic in one existing function. The change is about 20 lines total. ✅
**No architectural changes**: This doesn't change the overall io_uring
architecture, just fixes the drain sequencing logic. ✅ **Low regression
risk**: The fix makes the drain checking more conservative (stricter),
which is safer than the current buggy behavior. ✅ **Critical
subsystem**: io_uring is a critical high-performance I/O subsystem used
by databases, storage systems, and other performance-critical
applications. ## Comparison with Similar Commits Looking at the provided
similar commits: - Most drain-related fixes were marked as **NO**
because they were optimizations or refactoring - However, the one marked
**YES** (commit about "counter inc/dec mismatch") was a correctness fix
similar to this one - This commit fits the pattern of the **YES**
example: it fixes a functional bug rather than optimizing code ## Risk
Assessment **Minimal risk**: The change makes drain checking more
conservative, so the worst case would be slightly more restrictive
ordering, which maintains correctness. There's no risk of introducing
the opposite problem (allowing incorrect reordering). ## Conclusion This
commit fixes a real correctness bug in a critical kernel subsystem with
minimal, conservative changes. It prevents potential data races and
ordering violations in io_uring drain operations, making it an excellent
candidate for stable backporting.

 io_uring/io_uring.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index a60cb9d30cc0d..5949d3214b4c7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -532,18 +532,30 @@ void io_req_queue_iowq(struct io_kiocb *req)
 	io_req_task_work_add(req);
 }
 
+static bool io_drain_defer_seq(struct io_kiocb *req, u32 seq)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+
+	return seq + READ_ONCE(ctx->cq_extra) != ctx->cached_cq_tail;
+}
+
 static __cold noinline void io_queue_deferred(struct io_ring_ctx *ctx)
 {
+	bool drain_seen = false, first = true;
+
 	spin_lock(&ctx->completion_lock);
 	while (!list_empty(&ctx->defer_list)) {
 		struct io_defer_entry *de = list_first_entry(&ctx->defer_list,
 						struct io_defer_entry, list);
 
-		if (req_need_defer(de->req, de->seq))
+		drain_seen |= de->req->flags & REQ_F_IO_DRAIN;
+		if ((drain_seen || first) && io_drain_defer_seq(de->req, de->seq))
 			break;
+
 		list_del_init(&de->list);
 		io_req_task_queue(de->req);
 		kfree(de);
+		first = false;
 	}
 	spin_unlock(&ctx->completion_lock);
 }
-- 
2.39.5


