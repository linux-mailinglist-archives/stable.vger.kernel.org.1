Return-Path: <stable+bounces-179401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B06B55905
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 00:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB41617ACD6
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B04283C89;
	Fri, 12 Sep 2025 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xZJk2lDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809627979F;
	Fri, 12 Sep 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715260; cv=none; b=iEDYK+bxdhhSHPFxIFxzwYjql5+p8ReoAOLqXSx99UZqIQSWz2nR6cXXGfZfvbxT/2xOidXVdXIkSPTlcSH5Y/2aleMtbhP9bxxXYYq76WWzm8sMRdbDAzOeKJ/hw8SHBO2LgORAtykR6KW/W0CnehZ0GJM7BIyyYIv/kf1s0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715260; c=relaxed/simple;
	bh=yS9OoSZrML+y8HJpcN/56F/LVqR0nephD0txzJnT7R0=;
	h=Date:To:From:Subject:Message-Id; b=WnZiLHE3O5QKk2kTjTNvELTGsxIBsxPByvD6Mb2r2laFJmN+2i7hFnexNU1+6xkxV9DvSZ6+kQa1aGOibBBtZgjvzMaQfoXwNHig6zZSt1/l19UHjy5ROuDzdCC/yYUTYejk5LBzGBJ5+T23XyXHHagrJofuzV6WPvLAlCAYMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xZJk2lDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B9AC4CEF1;
	Fri, 12 Sep 2025 22:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757715260;
	bh=yS9OoSZrML+y8HJpcN/56F/LVqR0nephD0txzJnT7R0=;
	h=Date:To:From:Subject:From;
	b=xZJk2lDe+u2ZkNHUkfyBW/YiPBs354hy8Pr2FGDFOObchLC31HZuLJYruNrMenO2q
	 nogri+ziXfnwv+gHA/8fAC0L4fiZizkAQ79lyfoL/mwyyBG5D1hL/Cx3r+rbQCwGqf
	 peFn7vwh2jvJk5KOWLt3QyVS7dIi45ZJZnjPw8JA=
Date: Fri, 12 Sep 2025 15:14:19 -0700
To: mm-commits@vger.kernel.org,venkat88@linux.ibm.com,tj@kernel.org,stable@vger.kernel.org,songmuchun@bytedance.com,shakeelb@google.com,roman.gushchin@linux.dev,mhocko@suse.com,hannes@cmpxchg.org,sunjunchao@bytedance.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] memcg-dont-wait-writeback-completion-when-release-memcg.patch removed from -mm tree
Message-Id: <20250912221419.F3B9AC4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: memcg: don't wait writeback completion when release memcg
has been removed from the -mm tree.  Its filename was
     memcg-dont-wait-writeback-completion-when-release-memcg.patch

This patch was dropped because an updated version will be issued

------------------------------------------------------
From: Julian Sun <sunjunchao@bytedance.com>
Subject: memcg: don't wait writeback completion when release memcg
Date: Thu, 28 Aug 2025 04:45:57 +0800

Recently, we encountered the following hung task:

INFO: task kworker/4:1:1334558 blocked for more than 1720 seconds.
[Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork_fn
[Wed Jul 30 17:47:45 2025] Call Trace:
[Wed Jul 30 17:47:45 2025]  __schedule+0x934/0xe10
[Wed Jul 30 17:47:45 2025]  ? complete+0x3b/0x50
[Wed Jul 30 17:47:45 2025]  ? _cond_resched+0x15/0x30
[Wed Jul 30 17:47:45 2025]  schedule+0x40/0xb0
[Wed Jul 30 17:47:45 2025]  wb_wait_for_completion+0x52/0x80
[Wed Jul 30 17:47:45 2025]  ? finish_wait+0x80/0x80
[Wed Jul 30 17:47:45 2025]  mem_cgroup_css_free+0x22/0x1b0
[Wed Jul 30 17:47:45 2025]  css_free_rwork_fn+0x42/0x380
[Wed Jul 30 17:47:45 2025]  process_one_work+0x1a2/0x360
[Wed Jul 30 17:47:45 2025]  worker_thread+0x30/0x390
[Wed Jul 30 17:47:45 2025]  ? create_worker+0x1a0/0x1a0
[Wed Jul 30 17:47:45 2025]  kthread+0x110/0x130
[Wed Jul 30 17:47:45 2025]  ? __kthread_cancel_work+0x40/0x40
[Wed Jul 30 17:47:45 2025]  ret_from_fork+0x1f/0x30

The direct cause is that memcg spends a long time waiting for dirty page
writeback of foreign memcgs during release.

The root causes are:
    a. The wb may have multiple writeback tasks, containing millions
       of dirty pages, as shown below:

>>> for work in list_for_each_entry("struct wb_writeback_work", \
				    wb.work_list.address_of_(), "list"):
...     print(work.nr_pages, work.reason, hex(work))
...
900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
1275228 WB_REASON_FOREIGN_FLUSH 0xffff969d9b444bc0
1099673 WB_REASON_FOREIGN_FLUSH 0xffff969f0954d6c0
1351522 WB_REASON_FOREIGN_FLUSH 0xffff969e76713340
2567437 WB_REASON_FOREIGN_FLUSH 0xffff9694ae208400
2954033 WB_REASON_FOREIGN_FLUSH 0xffff96a22d62cbc0
3008860 WB_REASON_FOREIGN_FLUSH 0xffff969eee8ce3c0
3337932 WB_REASON_FOREIGN_FLUSH 0xffff9695b45156c0
3348916 WB_REASON_FOREIGN_FLUSH 0xffff96a22c7a4f40
3345363 WB_REASON_FOREIGN_FLUSH 0xffff969e5d872800
3333581 WB_REASON_FOREIGN_FLUSH 0xffff969efd0f4600
3382225 WB_REASON_FOREIGN_FLUSH 0xffff969e770edcc0
3418770 WB_REASON_FOREIGN_FLUSH 0xffff96a252ceea40
3387648 WB_REASON_FOREIGN_FLUSH 0xffff96a3bda86340
3385420 WB_REASON_FOREIGN_FLUSH 0xffff969efc6eb280
3418730 WB_REASON_FOREIGN_FLUSH 0xffff96a348ab1040
3426155 WB_REASON_FOREIGN_FLUSH 0xffff969d90beac00
3397995 WB_REASON_FOREIGN_FLUSH 0xffff96a2d7288800
3293095 WB_REASON_FOREIGN_FLUSH 0xffff969dab423240
3293595 WB_REASON_FOREIGN_FLUSH 0xffff969c765ff400
3199511 WB_REASON_FOREIGN_FLUSH 0xffff969a72d5e680
3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00

    b. The writeback might severely throttled by wbt, with a speed
       possibly less than 100kb/s, leading to a very long writeback time.

>>> wb.write_bandwidth
(unsigned long)24
>>> wb.write_bandwidth
(unsigned long)13

The wb_wait_for_completion() here is probably only used to prevent
use-after-free.  Therefore, we manage 'done' separately and automatically
free it.

This allows us to remove wb_wait_for_completion() while preventing the
use-after-free issue.

Link: https://lkml.kernel.org/r/20250827204557.90112-1-sunjunchao@bytedance.com
Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Venkat <venkat88@linux.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/memcontrol.h |    7 +++-
 mm/memcontrol.c            |   53 +++++++++++++++++++++++++++++------
 2 files changed, 51 insertions(+), 9 deletions(-)

--- a/include/linux/memcontrol.h~memcg-dont-wait-writeback-completion-when-release-memcg
+++ a/include/linux/memcontrol.h
@@ -157,11 +157,16 @@ struct mem_cgroup_thresholds {
  */
 #define MEMCG_CGWB_FRN_CNT	4
 
+struct cgwb_frn_wait {
+	struct wb_completion done;
+	struct wait_queue_entry wq_entry;
+};
+
 struct memcg_cgwb_frn {
 	u64 bdi_id;			/* bdi->id of the foreign inode */
 	int memcg_id;			/* memcg->css.id of foreign inode */
 	u64 at;				/* jiffies_64 at the time of dirtying */
-	struct wb_completion done;	/* tracks in-flight foreign writebacks */
+	struct cgwb_frn_wait *wait;	/* tracks in-flight foreign writebacks */
 };
 
 /*
--- a/mm/memcontrol.c~memcg-dont-wait-writeback-completion-when-release-memcg
+++ a/mm/memcontrol.c
@@ -3457,7 +3457,7 @@ void mem_cgroup_track_foreign_dirty_slow
 		    frn->memcg_id == wb->memcg_css->id)
 			break;
 		if (time_before64(frn->at, oldest_at) &&
-		    atomic_read(&frn->done.cnt) == 1) {
+		    atomic_read(&frn->wait->done.cnt) == 1) {
 			oldest = i;
 			oldest_at = frn->at;
 		}
@@ -3504,12 +3504,12 @@ void mem_cgroup_flush_foreign(struct bdi
 		 * already one in flight.
 		 */
 		if (time_after64(frn->at, now - intv) &&
-		    atomic_read(&frn->done.cnt) == 1) {
+		    atomic_read(&frn->wait->done.cnt) == 1) {
 			frn->at = 0;
 			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
 			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
 					       WB_REASON_FOREIGN_FLUSH,
-					       &frn->done);
+					       &frn->wait->done);
 		}
 	}
 }
@@ -3700,13 +3700,29 @@ static void mem_cgroup_free(struct mem_c
 	__mem_cgroup_free(memcg);
 }
 
+#ifdef CONFIG_CGROUP_WRITEBACK
+static int memcg_cgwb_waitq_callback_fn(struct wait_queue_entry *wq_entry, unsigned int mode,
+					int flags, void *key)
+{
+	struct cgwb_frn_wait *frn_wait = container_of(wq_entry,
+						      struct cgwb_frn_wait, wq_entry);
+
+	if (!atomic_read(&frn_wait->done.cnt)) {
+		list_del(&wq_entry->entry);
+		kfree(frn_wait);
+	}
+
+	return 0;
+}
+#endif
+
 static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 {
 	struct memcg_vmstats_percpu *statc;
 	struct memcg_vmstats_percpu __percpu *pstatc_pcpu;
 	struct mem_cgroup *memcg;
 	int node, cpu;
-	int __maybe_unused i;
+	int __maybe_unused i = 0;
 	long error;
 
 	memcg = kmem_cache_zalloc(memcg_cachep, GFP_KERNEL);
@@ -3761,9 +3777,17 @@ static struct mem_cgroup *mem_cgroup_all
 	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		memcg->cgwb_frn[i].done =
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
+
+		frn->wait = kmalloc(sizeof(struct cgwb_frn_wait), GFP_KERNEL);
+		if (!frn->wait)
+			goto fail;
+
+		frn->wait->done =
 			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
+		init_wait_func(&frn->wait->wq_entry, memcg_cgwb_waitq_callback_fn);
+	}
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
@@ -3773,6 +3797,10 @@ static struct mem_cgroup *mem_cgroup_all
 	lru_gen_init_memcg(memcg);
 	return memcg;
 fail:
+#ifdef CONFIG_CGROUP_WRITEBACK
+	while (i--)
+		kfree(memcg->cgwb_frn[i].wait);
+#endif
 	mem_cgroup_id_remove(memcg);
 	__mem_cgroup_free(memcg);
 	return ERR_PTR(error);
@@ -3910,8 +3938,17 @@ static void mem_cgroup_css_free(struct c
 	int __maybe_unused i;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct cgwb_frn_wait *wait = memcg->cgwb_frn[i].wait;
+
+		/*
+		 * Not necessary to wait for wb completion which might cause task hung,
+		 * only used to free resources. See memcg_cgwb_waitq_callback_fn().
+		 */
+		__add_wait_queue_entry_tail(wait->done.waitq, &wait->wq_entry);
+		if (atomic_dec_and_test(&wait->done.cnt))
+			wake_up_all(wait->done.waitq);
+	}
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
_

Patches currently in -mm which might be from sunjunchao@bytedance.com are



