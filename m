Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF69775512D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGPTxi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjGPTxh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:53:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9391B4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0F6160EAD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92043C433C7;
        Sun, 16 Jul 2023 19:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537215;
        bh=fGdbaeHQJFUY/CK04IMVnmJmJCdRF5i4aN4IPHq21CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtCE33WIeuBJGAeYxy5C8/32ugJyQSizRaPlDTh+HQRWdXh0K/EesH/LkJ8JW3VAE
         2ZISDaYNi+mE7mVCsYLQniJ+u5XTUg69G0+kFFOyUhZRqxquUxhf2eEfO7mUiSyh29
         NVikJOCKPkprOGRvDdb9HUd+t9tJ1MXBUPCZlyA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 017/800] block/rq_qos: protect rq_qos apis with a new lock
Date:   Sun, 16 Jul 2023 21:37:50 +0200
Message-ID: <20230716194949.504846122@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit a13bd91be22318768d55470cbc0b0f4488ef9edf ]

commit 50e34d78815e ("block: disable the elevator int del_gendisk")
move rq_qos_exit() from disk_release() to del_gendisk(), this will
introduce some problems:

1) If rq_qos_add() is triggered by enabling iocost/iolatency through
   cgroupfs, then it can concurrent with del_gendisk(), it's not safe to
   write 'q->rq_qos' concurrently.

2) Activate cgroup policy that is relied on rq_qos will call
   rq_qos_add() and blkcg_activate_policy(), and if rq_qos_exit() is
   called in the middle, null-ptr-dereference will be triggered in
   blkcg_activate_policy().

3) blkg_conf_open_bdev() can call blkdev_get_no_open() first to find the
   disk, then if rq_qos_exit() from del_gendisk() is done before
   rq_qos_add(), then memory will be leaked.

This patch add a new disk level mutex 'rq_qos_mutex':

1) The lock will protect rq_qos_exit() directly.

2) For wbt that doesn't relied on blk-cgroup, rq_qos_add() can only be
   called from disk initialization for now because wbt can't be
   destructed until rq_qos_exit(), so it's safe not to protect wbt for
   now. Hoever, in case that rq_qos dynamically destruction is supported
   in the furture, this patch also protect rq_qos_add() from wbt_init()
   directly, this is enough because blk-sysfs already synchronize
   writers with disk removal.

3) For iocost and iolatency, in order to synchronize disk removal and
   cgroup configuration, the lock is held after blkdev_get_no_open()
   from blkg_conf_open_bdev(), and is released in blkg_conf_exit().
   In order to fix the above memory leak, disk_live() is checked after
   holding the new lock.

Fixes: 50e34d78815e ("block: disable the elevator int del_gendisk")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230414084008.2085155-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c     |  9 +++++++++
 block/blk-core.c       |  1 +
 block/blk-rq-qos.c     | 20 ++++++--------------
 block/blk-wbt.c        |  2 ++
 include/linux/blkdev.h |  1 +
 5 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index dce1548a7a0c3..5215bc7af5514 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -762,6 +762,13 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 		return -ENODEV;
 	}
 
+	mutex_lock(&bdev->bd_queue->rq_qos_mutex);
+	if (!disk_live(bdev->bd_disk)) {
+		blkdev_put_no_open(bdev);
+		mutex_unlock(&bdev->bd_queue->rq_qos_mutex);
+		return -ENODEV;
+	}
+
 	ctx->body = input;
 	ctx->bdev = bdev;
 	return 0;
@@ -906,6 +913,7 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
  */
 void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 	__releases(&ctx->bdev->bd_queue->queue_lock)
+	__releases(&ctx->bdev->bd_queue->rq_qos_mutex)
 {
 	if (ctx->blkg) {
 		spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
@@ -913,6 +921,7 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 	}
 
 	if (ctx->bdev) {
+		mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
 		blkdev_put_no_open(ctx->bdev);
 		ctx->body = NULL;
 		ctx->bdev = NULL;
diff --git a/block/blk-core.c b/block/blk-core.c
index 1da77e7d62894..3fc68b9444791 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -420,6 +420,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	mutex_init(&q->debugfs_mutex);
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->sysfs_dir_lock);
+	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index d8cc820a365e3..167be74df4eec 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -288,11 +288,13 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 void rq_qos_exit(struct request_queue *q)
 {
+	mutex_lock(&q->rq_qos_mutex);
 	while (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
 		q->rq_qos = rqos->next;
 		rqos->ops->exit(rqos);
 	}
+	mutex_unlock(&q->rq_qos_mutex);
 }
 
 int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
@@ -300,6 +302,8 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 {
 	struct request_queue *q = disk->queue;
 
+	lockdep_assert_held(&q->rq_qos_mutex);
+
 	rqos->disk = disk;
 	rqos->id = id;
 	rqos->ops = ops;
@@ -307,18 +311,13 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 	/*
 	 * No IO can be in-flight when adding rqos, so freeze queue, which
 	 * is fine since we only support rq_qos for blk-mq queue.
-	 *
-	 * Reuse ->queue_lock for protecting against other concurrent
-	 * rq_qos adding/deleting
 	 */
 	blk_mq_freeze_queue(q);
 
-	spin_lock_irq(&q->queue_lock);
 	if (rq_qos_id(q, rqos->id))
 		goto ebusy;
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
-	spin_unlock_irq(&q->queue_lock);
 
 	blk_mq_unfreeze_queue(q);
 
@@ -330,7 +329,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 
 	return 0;
 ebusy:
-	spin_unlock_irq(&q->queue_lock);
 	blk_mq_unfreeze_queue(q);
 	return -EBUSY;
 }
@@ -340,21 +338,15 @@ void rq_qos_del(struct rq_qos *rqos)
 	struct request_queue *q = rqos->disk->queue;
 	struct rq_qos **cur;
 
-	/*
-	 * See comment in rq_qos_add() about freezing queue & using
-	 * ->queue_lock.
-	 */
-	blk_mq_freeze_queue(q);
+	lockdep_assert_held(&q->rq_qos_mutex);
 
-	spin_lock_irq(&q->queue_lock);
+	blk_mq_freeze_queue(q);
 	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
 		if (*cur == rqos) {
 			*cur = rqos->next;
 			break;
 		}
 	}
-	spin_unlock_irq(&q->queue_lock);
-
 	blk_mq_unfreeze_queue(q);
 
 	mutex_lock(&q->debugfs_mutex);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 9ec2a2f1eda38..7a87506ff8e1c 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -944,7 +944,9 @@ int wbt_init(struct gendisk *disk)
 	/*
 	 * Assign rwb and add the stats callback.
 	 */
+	mutex_lock(&q->rq_qos_mutex);
 	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
+	mutex_unlock(&q->rq_qos_mutex);
 	if (ret)
 		goto err_free;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index be9d7d8237b33..67e942d776bd8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -392,6 +392,7 @@ struct request_queue {
 
 	struct blk_queue_stats	*stats;
 	struct rq_qos		*rq_qos;
+	struct mutex		rq_qos_mutex;
 
 	const struct blk_mq_ops	*mq_ops;
 
-- 
2.39.2



