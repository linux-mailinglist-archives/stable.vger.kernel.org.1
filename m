Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C127B8766
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbjJDSEs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243781AbjJDSEr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:04:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8035CC4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:04:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5109C433C8;
        Wed,  4 Oct 2023 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442682;
        bh=sR2M8TJ2Cgme0hMOGsTCtZdwDH8UxIMmUG8L2IiItEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHe8QYKxX+Nl1Kuraq5f6Hg4oM3RrH5kAR+Ymcjj0kEAaz8vi4Pl0a/CP85UOOIw8
         ijMrBe7jExEfuqxruSACrD2Pgw1h9b742sCxLLLdzFdBmd6YCRXzEjN+ulY8qVKjeV
         /SVmQAiVeU65mneUfSY1lBAOh9/ICFxBnsfP2BuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 072/183] xfs: bound maximum wait time for inodegc work
Date:   Wed,  4 Oct 2023 19:55:03 +0200
Message-ID: <20231004175206.883249577@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 7cf2b0f9611b9971d663e1fc3206eeda3b902922 ]

Currently inodegc work can sit queued on the per-cpu queue until
the workqueue is either flushed of the queue reaches a depth that
triggers work queuing (and later throttling). This means that we
could queue work that waits for a long time for some other event to
trigger flushing.

Hence instead of just queueing work at a specific depth, use a
delayed work that queues the work at a bound time. We can still
schedule the work immediately at a given depth, but we no long need
to worry about leaving a number of items on the list that won't get
processed until external events prevail.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_icache.c | 36 ++++++++++++++++++++++--------------
 fs/xfs/xfs_mount.h  |  2 +-
 fs/xfs/xfs_super.c  |  2 +-
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 5e44d7bbd8fca..2c3ef553f5ef0 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -458,7 +458,7 @@ xfs_inodegc_queue_all(
 	for_each_online_cpu(cpu) {
 		gc = per_cpu_ptr(mp->m_inodegc, cpu);
 		if (!llist_empty(&gc->list))
-			queue_work_on(cpu, mp->m_inodegc_wq, &gc->work);
+			mod_delayed_work_on(cpu, mp->m_inodegc_wq, &gc->work, 0);
 	}
 }
 
@@ -1851,8 +1851,8 @@ void
 xfs_inodegc_worker(
 	struct work_struct	*work)
 {
-	struct xfs_inodegc	*gc = container_of(work, struct xfs_inodegc,
-							work);
+	struct xfs_inodegc	*gc = container_of(to_delayed_work(work),
+						struct xfs_inodegc, work);
 	struct llist_node	*node = llist_del_all(&gc->list);
 	struct xfs_inode	*ip, *n;
 
@@ -2021,6 +2021,7 @@ xfs_inodegc_queue(
 	struct xfs_inodegc	*gc;
 	int			items;
 	unsigned int		shrinker_hits;
+	unsigned long		queue_delay = 1;
 
 	trace_xfs_inode_set_need_inactive(ip);
 	spin_lock(&ip->i_flags_lock);
@@ -2032,19 +2033,26 @@ xfs_inodegc_queue(
 	items = READ_ONCE(gc->items);
 	WRITE_ONCE(gc->items, items + 1);
 	shrinker_hits = READ_ONCE(gc->shrinker_hits);
-	put_cpu_ptr(gc);
 
-	if (!xfs_is_inodegc_enabled(mp))
+	/*
+	 * We queue the work while holding the current CPU so that the work
+	 * is scheduled to run on this CPU.
+	 */
+	if (!xfs_is_inodegc_enabled(mp)) {
+		put_cpu_ptr(gc);
 		return;
-
-	if (xfs_inodegc_want_queue_work(ip, items)) {
-		trace_xfs_inodegc_queue(mp, __return_address);
-		queue_work(mp->m_inodegc_wq, &gc->work);
 	}
 
+	if (xfs_inodegc_want_queue_work(ip, items))
+		queue_delay = 0;
+
+	trace_xfs_inodegc_queue(mp, __return_address);
+	mod_delayed_work(mp->m_inodegc_wq, &gc->work, queue_delay);
+	put_cpu_ptr(gc);
+
 	if (xfs_inodegc_want_flush_work(ip, items, shrinker_hits)) {
 		trace_xfs_inodegc_throttle(mp, __return_address);
-		flush_work(&gc->work);
+		flush_delayed_work(&gc->work);
 	}
 }
 
@@ -2061,7 +2069,7 @@ xfs_inodegc_cpu_dead(
 	unsigned int		count = 0;
 
 	dead_gc = per_cpu_ptr(mp->m_inodegc, dead_cpu);
-	cancel_work_sync(&dead_gc->work);
+	cancel_delayed_work_sync(&dead_gc->work);
 
 	if (llist_empty(&dead_gc->list))
 		return;
@@ -2080,12 +2088,12 @@ xfs_inodegc_cpu_dead(
 	llist_add_batch(first, last, &gc->list);
 	count += READ_ONCE(gc->items);
 	WRITE_ONCE(gc->items, count);
-	put_cpu_ptr(gc);
 
 	if (xfs_is_inodegc_enabled(mp)) {
 		trace_xfs_inodegc_queue(mp, __return_address);
-		queue_work(mp->m_inodegc_wq, &gc->work);
+		mod_delayed_work(mp->m_inodegc_wq, &gc->work, 0);
 	}
+	put_cpu_ptr(gc);
 }
 
 /*
@@ -2180,7 +2188,7 @@ xfs_inodegc_shrinker_scan(
 			unsigned int	h = READ_ONCE(gc->shrinker_hits);
 
 			WRITE_ONCE(gc->shrinker_hits, h + 1);
-			queue_work_on(cpu, mp->m_inodegc_wq, &gc->work);
+			mod_delayed_work_on(cpu, mp->m_inodegc_wq, &gc->work, 0);
 			no_items = false;
 		}
 	}
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 86564295fce6d..3d58938a6f75b 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -61,7 +61,7 @@ struct xfs_error_cfg {
  */
 struct xfs_inodegc {
 	struct llist_head	list;
-	struct work_struct	work;
+	struct delayed_work	work;
 
 	/* approximate count of inodes in the list */
 	unsigned int		items;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index df1d6be61bfa3..8fe6ca9208de6 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1061,7 +1061,7 @@ xfs_inodegc_init_percpu(
 		gc = per_cpu_ptr(mp->m_inodegc, cpu);
 		init_llist_head(&gc->list);
 		gc->items = 0;
-		INIT_WORK(&gc->work, xfs_inodegc_worker);
+		INIT_DELAYED_WORK(&gc->work, xfs_inodegc_worker);
 	}
 	return 0;
 }
-- 
2.40.1



