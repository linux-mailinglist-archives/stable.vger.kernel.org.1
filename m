Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0B754F63
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 17:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGPP0l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 11:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPP0l (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 11:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6814690
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 08:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D950160ADE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 15:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F64C433C7;
        Sun, 16 Jul 2023 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689521198;
        bh=aHd+fxGWBK5SDXBQGga9sKdftelKI+dQu4fxQ02HXxo=;
        h=Subject:To:Cc:From:Date:From;
        b=w0NqDM6Hb2+bEf4QQsb1okiaExbFSklwV9ytBPCGtcv/mYeql0ojCh/eQTMvrSUBp
         So+oqm48Jq+VBQRgOqX1JGBTn8gHY+uIACjBIOCbfi2q2n6nsgLyJ+i6mJEVd3kX1m
         UX6b3Vs85TidWaUbiZOZsAyR1ViP1VGEaf13wyFc=
Subject: FAILED: patch "[PATCH] blk-cgroup: Flush stats before releasing blkcg_gq" failed to apply to 6.1-stable tree
To:     ming.lei@redhat.com, axboe@kernel.dk, jaeshin@redhat.com,
        longman@redhat.com, tj@kernel.org, yosryahmed@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 17:26:35 +0200
Message-ID: <2023071635-handsaw-enclosure-0363@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 20cb1c2fb7568a6054c55defe044311397e01ddb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071635-handsaw-enclosure-0363@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

20cb1c2fb756 ("blk-cgroup: Flush stats before releasing blkcg_gq")
2c275afeb61d ("block: make blkcg_punt_bio_submit optional")
12be09fe18f2 ("block: async_bio_lock does not need to be bh-safe")
3480373ebdf7 ("btrfs, block: move REQ_CGROUP_PUNT to btrfs")
0a0596fbbe5b ("btrfs, mm: remove the punt_to_cgroup field in struct writeback_control")
05d06a5c9d9c ("btrfs: move kthread_associate_blkcg out of btrfs_submit_compressed_write")
ae42a154ca89 ("btrfs: pass a btrfs_bio to btrfs_submit_bio")
34f888ce3a35 ("btrfs: cleanup main loop in btrfs_encoded_read_regular_fill_pages")
72b505dc5757 ("btrfs: add a wbc pointer to struct btrfs_bio_ctrl")
794c26e214ab ("btrfs: remove the sync_io flag in struct btrfs_bio_ctrl")
c000bc04bad4 ("btrfs: store the bio opf in struct btrfs_bio_ctrl")
eb8d0c6d042f ("btrfs: remove the force_bio_submit to submit_extent_page")
67998cf438e2 ("btrfs: don't set force_bio_submit in read_extent_buffer_subpage")
10e924bc320a ("btrfs: factor out a btrfs_add_compressed_bio_pages helper")
e7aff33e3161 ("btrfs: use the bbio file offset in btrfs_submit_compressed_read")
798c9fc74d03 ("btrfs: remove redundant free_extent_map in btrfs_submit_compressed_read")
544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio")
3822a7c40997 ("Merge tag 'mm-stable-2023-02-20-13-37' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 20cb1c2fb7568a6054c55defe044311397e01ddb Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 10 Jun 2023 07:42:49 +0800
Subject: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq

As noted by Michal, the blkg_iostat_set's in the lockless list hold
reference to blkg's to protect against their removal. Those blkg's
hold reference to blkcg. When a cgroup is being destroyed,
cgroup_rstat_flush() is only called at css_release_work_fn() which
is called when the blkcg reference count reaches 0. This circular
dependency will prevent blkcg and some blkgs from being freed after
they are made offline.

It is less a problem if the cgroup to be destroyed also has other
controllers like memory that will call cgroup_rstat_flush() which will
clean up the reference count. If block is the only controller that uses
rstat, these offline blkcg and blkgs may never be freed leaking more
and more memory over time.

To prevent this potential memory leak:

- flush blkcg per-cpu stats list in __blkg_release(), when no new stat
can be added

- add global blkg_stat_lock for covering concurrent parent blkg stat
update

- don't grab bio->bi_blkg reference when adding the stats into blkcg's
per-cpu stat list since all stats are guaranteed to be consumed before
releasing blkg instance, and grabbing blkg reference for stats was the
most fragile part of original patch

Based on Waiman's patch:

https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/

Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Cc: stable@vger.kernel.org
Reported-by: Jay Shin <jaeshin@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: mkoutny@suse.com
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230609234249.1412858-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0ce64dd73cfe..f0b5c9c41cde 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -34,6 +34,8 @@
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
 
+static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
+
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
  * blkcg_pol_register_mutex nests outside of it and synchronizes entire
@@ -56,6 +58,8 @@ static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
 bool blkcg_debug_stats = false;
 
+static DEFINE_RAW_SPINLOCK(blkg_stat_lock);
+
 #define BLKG_DESTROY_BATCH_SIZE  64
 
 /*
@@ -163,10 +167,20 @@ static void blkg_free(struct blkcg_gq *blkg)
 static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
+	struct blkcg *blkcg = blkg->blkcg;
+	int cpu;
 
 #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
 	WARN_ON(!bio_list_empty(&blkg->async_bios));
 #endif
+	/*
+	 * Flush all the non-empty percpu lockless lists before releasing
+	 * us, given these stat belongs to us.
+	 *
+	 * blkg_stat_lock is for serializing blkg stat update
+	 */
+	for_each_possible_cpu(cpu)
+		__blkcg_rstat_flush(blkcg, cpu);
 
 	/* release the blkcg and parent blkg refs this blkg has been holding */
 	css_put(&blkg->blkcg->css);
@@ -951,23 +965,26 @@ static void blkcg_iostat_update(struct blkcg_gq *blkg, struct blkg_iostat *cur,
 	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 }
 
-static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 {
-	struct blkcg *blkcg = css_to_blkcg(css);
 	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
 	struct llist_node *lnode;
 	struct blkg_iostat_set *bisc, *next_bisc;
 
-	/* Root-level stats are sourced from system-wide IO stats */
-	if (!cgroup_parent(css->cgroup))
-		return;
-
 	rcu_read_lock();
 
 	lnode = llist_del_all(lhead);
 	if (!lnode)
 		goto out;
 
+	/*
+	 * For covering concurrent parent blkg update from blkg_release().
+	 *
+	 * When flushing from cgroup, cgroup_rstat_lock is always held, so
+	 * this lock won't cause contention most of time.
+	 */
+	raw_spin_lock(&blkg_stat_lock);
+
 	/*
 	 * Iterate only the iostat_cpu's queued in the lockless list.
 	 */
@@ -991,13 +1008,19 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		if (parent && parent->parent)
 			blkcg_iostat_update(parent, &blkg->iostat.cur,
 					    &blkg->iostat.last);
-		percpu_ref_put(&blkg->refcnt);
 	}
-
+	raw_spin_unlock(&blkg_stat_lock);
 out:
 	rcu_read_unlock();
 }
 
+static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	/* Root-level stats are sourced from system-wide IO stats */
+	if (cgroup_parent(css->cgroup))
+		__blkcg_rstat_flush(css_to_blkcg(css), cpu);
+}
+
 /*
  * We source root cgroup stats from the system-wide stats to avoid
  * tracking the same information twice and incurring overhead when no
@@ -2075,7 +2098,6 @@ void blk_cgroup_bio_start(struct bio *bio)
 
 		llist_add(&bis->lnode, lhead);
 		WRITE_ONCE(bis->lqueued, true);
-		percpu_ref_get(&bis->blkg->refcnt);
 	}
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);

