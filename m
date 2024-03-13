Return-Path: <stable+bounces-27790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A387ACBF
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 18:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D8628F7F1
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC39B62144;
	Wed, 13 Mar 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS4sn6N5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9512C541;
	Wed, 13 Mar 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348064; cv=none; b=k8BYQHFfu/fp0hEmjc5J/wRmXw4s4qnkajFPT5w3s6/KXGZggdFo/5n6J+xJwm35oxtzuqMIMiNOB+gnYLZ3kwxAPGFP0WoQPkwdomJnynsfcF/QrCgCcy8hRWw0fit7VtPR1dCAGd6E769nhvy3Z5Qs74/+kXMQRU18R7pMrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348064; c=relaxed/simple;
	bh=ZWeEf5IWXzoY/NR/md4LG/dbLRw0MXOOt+be7tflzzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ba2585zW0IPGHnuw+BHcAPNWro+i/OXBNQKE2tfeLMFdu4qLlIgzFFGaenkpa+uib1nPcabV598BjP++rtdx5floS2VtzS6W3piUEI5226Z2RQR/JYQwfR/pNOeK/D9yTOApcB+b6gbwuRmebEGmN/xqe9crk57Yae4Ot9CPR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS4sn6N5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBE6C433F1;
	Wed, 13 Mar 2024 16:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348064;
	bh=ZWeEf5IWXzoY/NR/md4LG/dbLRw0MXOOt+be7tflzzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bS4sn6N5dj/Ux8WMtePLmEubSsLsMyyq5OibLODUSh0j8wGV5TCwGe3ZocwXCirGs
	 vniw6oyoUhBZx9+OMqIzz4fGKNaZfwu/7HggD+4tKDITeG12qYYNFt1OkWvoricJDZ
	 heHHJZjT5iqZIowvIHYoujMc4iN8tJsINJChKCZ1WMo980Ye7Xig7XD38uo2CCSB0v
	 248YTDNUlIVdS6iPxswH1vEBhxXP3pYrPApP7i94xme9WYWwe3fiaezxFB0nXrsNi0
	 kFydT6jiZGbS27nj15BXQ3WcVWAlAFGU3VdvG6Bs8vezgU25Q2JmPKq8CNk8XjAcz7
	 NfLMPF2U3gNgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 55/71] blk-rq-qos: move rq_qos_add and rq_qos_del out of line
Date: Wed, 13 Mar 2024 12:39:41 -0400
Message-ID: <20240313163957.615276-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit b494f9c566ba5fe2cc8abe67fdeb0332c6b48d4b ]

These two functions are rather larger and not in a fast path, so move
them out of line.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230203150400.3199230-13-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-rq-qos.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h | 61 ++--------------------------------------------
 2 files changed, 62 insertions(+), 59 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 88f0fe7dcf545..aae98dcb01ebe 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -294,3 +294,63 @@ void rq_qos_exit(struct request_queue *q)
 		rqos->ops->exit(rqos);
 	}
 }
+
+int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
+{
+	/*
+	 * No IO can be in-flight when adding rqos, so freeze queue, which
+	 * is fine since we only support rq_qos for blk-mq queue.
+	 *
+	 * Reuse ->queue_lock for protecting against other concurrent
+	 * rq_qos adding/deleting
+	 */
+	blk_mq_freeze_queue(q);
+
+	spin_lock_irq(&q->queue_lock);
+	if (rq_qos_id(q, rqos->id))
+		goto ebusy;
+	rqos->next = q->rq_qos;
+	q->rq_qos = rqos;
+	spin_unlock_irq(&q->queue_lock);
+
+	blk_mq_unfreeze_queue(q);
+
+	if (rqos->ops->debugfs_attrs) {
+		mutex_lock(&q->debugfs_mutex);
+		blk_mq_debugfs_register_rqos(rqos);
+		mutex_unlock(&q->debugfs_mutex);
+	}
+
+	return 0;
+ebusy:
+	spin_unlock_irq(&q->queue_lock);
+	blk_mq_unfreeze_queue(q);
+	return -EBUSY;
+
+}
+
+void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
+{
+	struct rq_qos **cur;
+
+	/*
+	 * See comment in rq_qos_add() about freezing queue & using
+	 * ->queue_lock.
+	 */
+	blk_mq_freeze_queue(q);
+
+	spin_lock_irq(&q->queue_lock);
+	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
+		if (*cur == rqos) {
+			*cur = rqos->next;
+			break;
+		}
+	}
+	spin_unlock_irq(&q->queue_lock);
+
+	blk_mq_unfreeze_queue(q);
+
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_unregister_rqos(rqos);
+	mutex_unlock(&q->debugfs_mutex);
+}
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 1ef1f7d4bc3cb..805eee8b031d0 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -85,65 +85,8 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 	init_waitqueue_head(&rq_wait->wait);
 }
 
-static inline int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
-{
-	/*
-	 * No IO can be in-flight when adding rqos, so freeze queue, which
-	 * is fine since we only support rq_qos for blk-mq queue.
-	 *
-	 * Reuse ->queue_lock for protecting against other concurrent
-	 * rq_qos adding/deleting
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	if (rq_qos_id(q, rqos->id))
-		goto ebusy;
-	rqos->next = q->rq_qos;
-	q->rq_qos = rqos;
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	if (rqos->ops->debugfs_attrs) {
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_register_rqos(rqos);
-		mutex_unlock(&q->debugfs_mutex);
-	}
-
-	return 0;
-ebusy:
-	spin_unlock_irq(&q->queue_lock);
-	blk_mq_unfreeze_queue(q);
-	return -EBUSY;
-
-}
-
-static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
-{
-	struct rq_qos **cur;
-
-	/*
-	 * See comment in rq_qos_add() about freezing queue & using
-	 * ->queue_lock.
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
-		if (*cur == rqos) {
-			*cur = rqos->next;
-			break;
-		}
-	}
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	mutex_lock(&q->debugfs_mutex);
-	blk_mq_debugfs_unregister_rqos(rqos);
-	mutex_unlock(&q->debugfs_mutex);
-}
+int rq_qos_add(struct request_queue *q, struct rq_qos *rqos);
+void rq_qos_del(struct request_queue *q, struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
 typedef void (cleanup_cb_t)(struct rq_wait *rqw, void *private_data);
-- 
2.43.0


