Return-Path: <stable+bounces-20720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BC585AB82
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF85283992
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D404779F;
	Mon, 19 Feb 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="foFblpuk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB33376F5
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368687; cv=none; b=BR3VXRCnC6P43H9nseKvV7YHXZ9kqoX3G01raD9IC0TQCJWlaMErHVPJVDpA+QARljZPD7OlBuQkRN6H5aUSRzEDWxrIeCMc0aFGgf0RYRnY0ullk62cbLXHfhc2TkZ7Cri90wdQAFW/jOwu2+RqGHZ6ekhGIkFJm21Lz94N5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368687; c=relaxed/simple;
	bh=g+0slCOZUb8Ou2t3h/PJSb5vXeI4xk9XrvtRfBZkF+k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QERlYi+/OHMKxB2LeBeBKSMvhP6DaFDiRDWNTxYQp1H1DcFqAxBOBJT4fedRFJNogb5OhvmfUXBktWIMw+vnjvxZVVzplO5bcN9rsJgO+ErM18soGOJYHhCWAtw6QJMnuFOTVoO0wLDBc3znbxdg1jkwmB6uX7cKTiz2xzgwY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=foFblpuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EFCC433F1;
	Mon, 19 Feb 2024 18:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368687;
	bh=g+0slCOZUb8Ou2t3h/PJSb5vXeI4xk9XrvtRfBZkF+k=;
	h=Subject:To:Cc:From:Date:From;
	b=foFblpuksBqT10Fh1q5CgiI6eYdTnUKxe+sxYg1+KeOQNO5ZTosLQe6VcqCxEPWSr
	 VdIzSRq64KPA8L/7en5QOumX2MNHziJIrYrAFMJfGHM1FboLAwZcoVUKXOrO3yt8ui
	 z4aBVJSCOJvLga+WpBawVShCATWFmONS7d8FKeiI=
Subject: FAILED: patch "[PATCH] blk-wbt: Fix detection of dirty-throttled tasks" failed to apply to 5.15-stable tree
To: jack@suse.cz,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:51:21 +0100
Message-ID: <2024021921-unspoiled-despite-59cc@gregkh>
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
git cherry-pick -x f814bdda774c183b0cc15ec8f3b6e7c6f4527ba5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021921-unspoiled-despite-59cc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
ba91c849fa50 ("blk-rq-qos: store a gendisk instead of request_queue in struct rq_qos")
3963d84df797 ("blk-rq-qos: constify rq_qos_ops")
ce57b558604e ("blk-rq-qos: make rq_qos_add and rq_qos_del more useful")
b494f9c566ba ("blk-rq-qos: move rq_qos_add and rq_qos_del out of line")
de185b56e8a6 ("blk-cgroup: pass a gendisk to blkcg_schedule_throttle")
9df3e65139b9 ("blk-iocost: simplify ioc_name")
14a6e2eb7df5 ("block: don't allow the same type rq_qos add more than once")
5cf9c91ba927 ("block: serialize all debugfs operations using q->debugfs_mutex")
8a177a36da6c ("blk-iolatency: Fix inflight count imbalances and IO hangs on offline")
c97ab271576d ("blk-cgroup: remove unneeded includes from <linux/blk-cgroup.h>")
7f20ba7c42fd ("blk-cgroup: remove pointless CONFIG_BLOCK ifdefs")
bbb1ebe7a909 ("blk-cgroup: replace bio_blkcg with bio_blkcg_css")
dec223c92a46 ("blk-cgroup: move struct blkcg to block/blk-cgroup.h")
397c9f46ee4d ("blk-cgroup: move blkcg_{pin,unpin}_online out of line")
216889aad362 ("blk-cgroup: move blk_cgroup_congested out line")
d589ae0d4460 ("Merge tag 'for-5.18/block-2022-04-01' of git://git.kernel.dk/linux-block")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f814bdda774c183b0cc15ec8f3b6e7c6f4527ba5 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 23 Jan 2024 18:58:26 +0100
Subject: [PATCH] blk-wbt: Fix detection of dirty-throttled tasks

The detection of dirty-throttled tasks in blk-wbt has been subtly broken
since its beginning in 2016. Namely if we are doing cgroup writeback and
the throttled task is not in the root cgroup, balance_dirty_pages() will
set dirty_sleep for the non-root bdi_writeback structure. However
blk-wbt checks dirty_sleep only in the root cgroup bdi_writeback
structure. Thus detection of recently throttled tasks is not working in
this case (we noticed this when we switched to cgroup v2 and suddently
writeback was slow).

Since blk-wbt has no easy way to get to proper bdi_writeback and
furthermore its intention has always been to work on the whole device
rather than on individual cgroups, just move the dirty_sleep timestamp
from bdi_writeback to backing_dev_info. That fixes the checking for
recently throttled task and saves memory for everybody as a bonus.

CC: stable@vger.kernel.org
Fixes: b57d74aff9ab ("writeback: track if we're sleeping on progress in balance_dirty_pages()")
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240123175826.21452-1-jack@suse.cz
[axboe: fixup indentation errors]
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 5ba3cd574eac..0c0e270a8265 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -163,9 +163,9 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
  */
 static bool wb_recent_wait(struct rq_wb *rwb)
 {
-	struct bdi_writeback *wb = &rwb->rqos.disk->bdi->wb;
+	struct backing_dev_info *bdi = rwb->rqos.disk->bdi;
 
-	return time_before(jiffies, wb->dirty_sleep + HZ);
+	return time_before(jiffies, bdi->last_bdp_sleep + HZ);
 }
 
 static inline struct rq_wait *get_rq_wait(struct rq_wb *rwb,
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index ae12696ec492..2ad261082bba 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -141,8 +141,6 @@ struct bdi_writeback {
 	struct delayed_work dwork;	/* work item used for writeback */
 	struct delayed_work bw_dwork;	/* work item used for bandwidth estimate */
 
-	unsigned long dirty_sleep;	/* last wait */
-
 	struct list_head bdi_node;	/* anchored at bdi->wb_list */
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -179,6 +177,11 @@ struct backing_dev_info {
 	 * any dirty wbs, which is depended upon by bdi_has_dirty().
 	 */
 	atomic_long_t tot_write_bandwidth;
+	/*
+	 * Jiffies when last process was dirty throttled on this bdi. Used by
+	 * blk-wbt.
+	 */
+	unsigned long last_bdp_sleep;
 
 	struct bdi_writeback wb;  /* the root writeback info for this bdi */
 	struct list_head wb_list; /* list of all wbs */
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 1e3447bccdb1..e039d05304dd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -436,7 +436,6 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	INIT_LIST_HEAD(&wb->work_list);
 	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
 	INIT_DELAYED_WORK(&wb->bw_dwork, wb_update_bandwidth_workfn);
-	wb->dirty_sleep = jiffies;
 
 	err = fprop_local_init_percpu(&wb->completions, gfp);
 	if (err)
@@ -921,6 +920,7 @@ int bdi_init(struct backing_dev_info *bdi)
 	INIT_LIST_HEAD(&bdi->bdi_list);
 	INIT_LIST_HEAD(&bdi->wb_list);
 	init_waitqueue_head(&bdi->wb_waitq);
+	bdi->last_bdp_sleep = jiffies;
 
 	return cgwb_bdi_init(bdi);
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index cd4e4ae77c40..cc37fa7f3364 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1921,7 +1921,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			break;
 		}
 		__set_current_state(TASK_KILLABLE);
-		wb->dirty_sleep = now;
+		bdi->last_bdp_sleep = jiffies;
 		io_schedule_timeout(pause);
 
 		current->dirty_paused_when = now + pause;


