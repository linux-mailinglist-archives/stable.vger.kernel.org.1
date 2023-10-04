Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF49F7B8769
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbjJDSFB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243777AbjJDSFB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:05:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8D6E4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:04:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86D9C433C7;
        Wed,  4 Oct 2023 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442696;
        bh=GDoI6ldgpBuWQV3iCofsAOnNCR7Hkqz9+dVxyudNpLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IA/3j3xzWuR/wql+T6e5Xq9IWS4hQAJfXSISFQHneSBvTG0iGkMie12JjsrioxYAw
         DdCKRgrItyXljCbULqWyvyPaba+waSP27YlbvNSQbf9A6FHeOF0GlbkY2wq09tPxD7
         Z99y/LvhQUVqmlO1aYzgaMP1uJDhaPc/UPQi3Iqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 077/183] xfs: fix xfs_inodegc_stop racing with mod_delayed_work
Date:   Wed,  4 Oct 2023 19:55:08 +0200
Message-ID: <20231004175207.101494052@linuxfoundation.org>
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

From: Darrick J. Wong <djwong@kernel.org>

[ Upstream commit 2254a7396a0ca6309854948ee1c0a33fa4268cec ]

syzbot reported this warning from the faux inodegc shrinker that tries
to kick off inodegc work:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 102 at kernel/workqueue.c:1445 __queue_work+0xd44/0x1120 kernel/workqueue.c:1444
RIP: 0010:__queue_work+0xd44/0x1120 kernel/workqueue.c:1444
Call Trace:
 __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1672
 mod_delayed_work_on+0xe1/0x220 kernel/workqueue.c:1746
 xfs_inodegc_shrinker_scan fs/xfs/xfs_icache.c:2212 [inline]
 xfs_inodegc_shrinker_scan+0x250/0x4f0 fs/xfs/xfs_icache.c:2191
 do_shrink_slab+0x428/0xaa0 mm/vmscan.c:853
 shrink_slab+0x175/0x660 mm/vmscan.c:1013
 shrink_one+0x502/0x810 mm/vmscan.c:5343
 shrink_many mm/vmscan.c:5394 [inline]
 lru_gen_shrink_node mm/vmscan.c:5511 [inline]
 shrink_node+0x2064/0x35f0 mm/vmscan.c:6459
 kswapd_shrink_node mm/vmscan.c:7262 [inline]
 balance_pgdat+0xa02/0x1ac0 mm/vmscan.c:7452
 kswapd+0x677/0xd60 mm/vmscan.c:7712
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

This warning corresponds to this code in __queue_work:

	/*
	 * For a draining wq, only works from the same workqueue are
	 * allowed. The __WQ_DESTROYING helps to spot the issue that
	 * queues a new work item to a wq after destroy_workqueue(wq).
	 */
	if (unlikely(wq->flags & (__WQ_DESTROYING | __WQ_DRAINING) &&
		     WARN_ON_ONCE(!is_chained_work(wq))))
		return;

For this to trip, we must have a thread draining the inodedgc workqueue
and a second thread trying to queue inodegc work to that workqueue.
This can happen if freezing or a ro remount race with reclaim poking our
faux inodegc shrinker and another thread dropping an unlinked O_RDONLY
file:

Thread 0	Thread 1	Thread 2

xfs_inodegc_stop

				xfs_inodegc_shrinker_scan
				xfs_is_inodegc_enabled
				<yes, will continue>

xfs_clear_inodegc_enabled
xfs_inodegc_queue_all
<list empty, do not queue inodegc worker>

		xfs_inodegc_queue
		<add to list>
		xfs_is_inodegc_enabled
		<no, returns>

drain_workqueue
<set WQ_DRAINING>

				llist_empty
				<no, will queue list>
				mod_delayed_work_on(..., 0)
				__queue_work
				<sees WQ_DRAINING, kaboom>

In other words, everything between the access to inodegc_enabled state
and the decision to poke the inodegc workqueue requires some kind of
coordination to avoid the WQ_DRAINING state.  We could perhaps introduce
a lock here, but we could also try to eliminate WQ_DRAINING from the
picture.

We could replace the drain_workqueue call with a loop that flushes the
workqueue and queues workers as long as there is at least one inode
present in the per-cpu inodegc llists.  We've disabled inodegc at this
point, so we know that the number of queued inodes will eventually hit
zero as long as xfs_inodegc_start cannot reactivate the workers.

There are four callers of xfs_inodegc_start.  Three of them come from the
VFS with s_umount held: filesystem thawing, failed filesystem freezing,
and the rw remount transition.  The fourth caller is mounting rw (no
remount or freezing possible).

There are three callers ofs xfs_inodegc_stop.  One is unmounting (no
remount or thaw possible).  Two of them come from the VFS with s_umount
held: fs freezing and ro remount transition.

Hence, it is correct to replace the drain_workqueue call with a loop
that drains the inodegc llists.

Fixes: 6191cf3ad59f ("xfs: flush inodegc workqueue tasks before cancel")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_icache.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 02022164772de..eab98d76dbe1f 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -448,18 +448,23 @@ xfs_iget_check_free_state(
 }
 
 /* Make all pending inactivation work start immediately. */
-static void
+static bool
 xfs_inodegc_queue_all(
 	struct xfs_mount	*mp)
 {
 	struct xfs_inodegc	*gc;
 	int			cpu;
+	bool			ret = false;
 
 	for_each_online_cpu(cpu) {
 		gc = per_cpu_ptr(mp->m_inodegc, cpu);
-		if (!llist_empty(&gc->list))
+		if (!llist_empty(&gc->list)) {
 			mod_delayed_work_on(cpu, mp->m_inodegc_wq, &gc->work, 0);
+			ret = true;
+		}
 	}
+
+	return ret;
 }
 
 /*
@@ -1902,24 +1907,41 @@ xfs_inodegc_flush(
 
 /*
  * Flush all the pending work and then disable the inode inactivation background
- * workers and wait for them to stop.
+ * workers and wait for them to stop.  Caller must hold sb->s_umount to
+ * coordinate changes in the inodegc_enabled state.
  */
 void
 xfs_inodegc_stop(
 	struct xfs_mount	*mp)
 {
+	bool			rerun;
+
 	if (!xfs_clear_inodegc_enabled(mp))
 		return;
 
+	/*
+	 * Drain all pending inodegc work, including inodes that could be
+	 * queued by racing xfs_inodegc_queue or xfs_inodegc_shrinker_scan
+	 * threads that sample the inodegc state just prior to us clearing it.
+	 * The inodegc flag state prevents new threads from queuing more
+	 * inodes, so we queue pending work items and flush the workqueue until
+	 * all inodegc lists are empty.  IOWs, we cannot use drain_workqueue
+	 * here because it does not allow other unserialized mechanisms to
+	 * reschedule inodegc work while this draining is in progress.
+	 */
 	xfs_inodegc_queue_all(mp);
-	drain_workqueue(mp->m_inodegc_wq);
+	do {
+		flush_workqueue(mp->m_inodegc_wq);
+		rerun = xfs_inodegc_queue_all(mp);
+	} while (rerun);
 
 	trace_xfs_inodegc_stop(mp, __return_address);
 }
 
 /*
  * Enable the inode inactivation background workers and schedule deferred inode
- * inactivation work if there is any.
+ * inactivation work if there is any.  Caller must hold sb->s_umount to
+ * coordinate changes in the inodegc_enabled state.
  */
 void
 xfs_inodegc_start(
-- 
2.40.1



