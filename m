Return-Path: <stable+bounces-96262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFE69E18EA
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9048E2827F5
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846141E0E12;
	Tue,  3 Dec 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B2gVA0S9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE91E0E11
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220648; cv=none; b=pmPmPKt94JXTJJMHA2km6P+kWi9jrw+qRXR8bnHBcwYbdIO5a6Jzq2PDr9wsUSNq3LX+NC4UjhKeStT4XPzRMwIaph5SG5uJ9tG/HFIjTJpfltU5xpa2YcVZR2L3SGhJ2MyNAYjsaUqzGJZjw8jIKCiQSMps4vYTmh6Jm4GyAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220648; c=relaxed/simple;
	bh=BTVJYjVU8O5H3vezOZAkBgQN+yqhz9X2LiO39xtd/tE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tLmnaMwE+9QaKijXN3GSfmRN8iZjDdgG6A2Kc+wx9ysjtP7XrCweLnKjhI6p59zlmxNWeuxSsCG7I2bEYtHQv6naHK1vfRPw9kiqeBdQUpEuKVIhDPgZWZy/DBQL1GP5WKflNYNPvISntYCGdFskqdbCTZvtMWOu9yWI8lPEF+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B2gVA0S9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD8EC4CECF;
	Tue,  3 Dec 2024 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733220648;
	bh=BTVJYjVU8O5H3vezOZAkBgQN+yqhz9X2LiO39xtd/tE=;
	h=Subject:To:Cc:From:Date:From;
	b=B2gVA0S9ZTgxa1ZwlOOPZbeaR39FYfWCfwejsT1MiinoaI+PR43zBy0ThGnAOamct
	 FuWyOixEyqPsGWzHuCYtoRTnBnA57fY4iURS4ESEgE2378/7qZEr+RBaD5SRCWwJVN
	 fNT9MlJXDR5Pcn10SYVaBBq/nYt5boEfzHHAFKlQ=
Subject: FAILED: patch "[PATCH] block: fix ordering between checking QUEUE_FLAG_QUIESCED" failed to apply to 5.15-stable tree
To: muchun.song@linux.dev,axboe@kernel.dk,ming.lei@redhat.com,songmuchun@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:10:42 +0100
Message-ID: <2024120342-monsoon-wildcat-d0a1@gregkh>
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
git cherry-pick -x 6bda857bcbb86fb9d0e54fbef93a093d51172acc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120342-monsoon-wildcat-d0a1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6bda857bcbb86fb9d0e54fbef93a093d51172acc Mon Sep 17 00:00:00 2001
From: Muchun Song <muchun.song@linux.dev>
Date: Mon, 14 Oct 2024 17:29:33 +0800
Subject: [PATCH] block: fix ordering between checking QUEUE_FLAG_QUIESCED
 request adding

Supposing the following scenario.

CPU0                        CPU1

blk_mq_insert_request()     1) store
                            blk_mq_unquiesce_queue()
                            blk_queue_flag_clear()                3) store
                              blk_mq_run_hw_queues()
                                blk_mq_run_hw_queue()
                                  if (!blk_mq_hctx_has_pending()) 4) load
                                    return
blk_mq_run_hw_queue()
  if (blk_queue_quiesced()) 2) load
    return
  blk_mq_sched_dispatch_requests()

The full memory barrier should be inserted between 1) and 2), as well as
between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED
is cleared or CPU1 sees dispatch list or setting of bitmap of software
queue. Otherwise, either CPU will not rerun the hardware queue causing
starvation.

So the first solution is to 1) add a pair of memory barrier to fix the
problem, another solution is to 2) use hctx->queue->queue_lock to
synchronize QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since
memory barrier is not easy to be maintained.

Fixes: f4560ffe8cec ("blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20241014092934.53630-3-songmuchun@bytedance.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5deb9dffca0a..bb4ee2380dce 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2227,6 +2227,24 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
+static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hctx)
+{
+	bool need_run;
+
+	/*
+	 * When queue is quiesced, we may be switching io scheduler, or
+	 * updating nr_hw_queues, or other things, and we can't run queue
+	 * any more, even blk_mq_hctx_has_pending() can't be called safely.
+	 *
+	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
+	 * quiesced.
+	 */
+	__blk_mq_run_dispatch_ops(hctx->queue, false,
+		need_run = !blk_queue_quiesced(hctx->queue) &&
+		blk_mq_hctx_has_pending(hctx));
+	return need_run;
+}
+
 /**
  * blk_mq_run_hw_queue - Start to run a hardware queue.
  * @hctx: Pointer to the hardware queue to run.
@@ -2247,20 +2265,23 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
 
-	/*
-	 * When queue is quiesced, we may be switching io scheduler, or
-	 * updating nr_hw_queues, or other things, and we can't run queue
-	 * any more, even __blk_mq_hctx_has_pending() can't be called safely.
-	 *
-	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
-	 * quiesced.
-	 */
-	__blk_mq_run_dispatch_ops(hctx->queue, false,
-		need_run = !blk_queue_quiesced(hctx->queue) &&
-		blk_mq_hctx_has_pending(hctx));
+	need_run = blk_mq_hw_queue_need_run(hctx);
+	if (!need_run) {
+		unsigned long flags;
 
-	if (!need_run)
-		return;
+		/*
+		 * Synchronize with blk_mq_unquiesce_queue(), because we check
+		 * if hw queue is quiesced locklessly above, we need the use
+		 * ->queue_lock to make sure we see the up-to-date status to
+		 * not miss rerunning the hw queue.
+		 */
+		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		need_run = blk_mq_hw_queue_need_run(hctx);
+		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
+
+		if (!need_run)
+			return;
+	}
 
 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 		blk_mq_delay_run_hw_queue(hctx, 0);


