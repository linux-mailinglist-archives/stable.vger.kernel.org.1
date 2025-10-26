Return-Path: <stable+bounces-189774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DB1C0A9D2
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6195F4EB542
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4568D248F5E;
	Sun, 26 Oct 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z6Ziv0+f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04205215191
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488530; cv=none; b=CMwm/RT0KDARQKWJ0Qk7FnLR+5zizOEkwopKBp0l7wg70YBWMfVHEp4MjsPAY814h+kc2lSnsHlTtzFsJR+gURC9Vr+yHQa1x61QujNhCLS4kvo5b4AUcn/4BkGHUlfufNh0pXSqqB9du478kfEKgVU91vGyl71iqupDCA3wt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488530; c=relaxed/simple;
	bh=ss+CGU5dI2XLM+vTWfS5y75Uos61SEmFpT3Olw0Q8rM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZN4QIfoQA3BXtjVL1uPpja0aRCZMX7FxNPOumanHudDbSrwj/y1m3aM60sU+vDZjdxK9+bfxmYDLQweugCBDlek4Cdk98Q4Fl1esAc59PiTPRKz0sj2EAEHXOD4kA8g81XnKsvNeuVXRhbG5w2GlCvp9cGGbVjoJQNCD57b17LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z6Ziv0+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348DDC4CEE7;
	Sun, 26 Oct 2025 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488529;
	bh=ss+CGU5dI2XLM+vTWfS5y75Uos61SEmFpT3Olw0Q8rM=;
	h=Subject:To:Cc:From:Date:From;
	b=Z6Ziv0+fo+JI3XuJzqebULnDjduu0ERBCrOCeMommOoL6B72kfkojCNfn47WnnU3U
	 j6rnuZXERmMFTihQl/8bsXhfYzwF2n5hsSibWq0VE9mhW3Pq2u6Tx1wu1fhLSTZosV
	 ohP2zWaY816Mgp6OQGSqCSotbP9haYH96tn7yFfA=
Subject: FAILED: patch "[PATCH] io_uring/sqpoll: switch away from getrusage() for CPU" failed to apply to 6.12-stable tree
To: axboe@kernel.dk,krisman@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:22:06 +0100
Message-ID: <2025102606-showplace-direness-c7b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8ac9b0d33e5c0a995338ee5f25fe1b6ff7d97f65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102606-showplace-direness-c7b3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ac9b0d33e5c0a995338ee5f25fe1b6ff7d97f65 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 21 Oct 2025 07:16:08 -0600
Subject: [PATCH] io_uring/sqpoll: switch away from getrusage() for CPU
 accounting

getrusage() does a lot more than what the SQPOLL accounting needs, the
latter only cares about (and uses) the stime. Rather than do a full
RUSAGE_SELF summation, just query the used stime instead.

Cc: stable@vger.kernel.org
Fixes: 3fcb9d17206e ("io_uring/sqpoll: statistics of the true utilization of sq threads")
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index ff3364531c77..294c75a8a3bd 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -59,7 +59,6 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 {
 	struct io_overflow_cqe *ocqe;
 	struct io_rings *r = ctx->rings;
-	struct rusage sq_usage;
 	unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
 	unsigned int sq_head = READ_ONCE(r->sq.head);
 	unsigned int sq_tail = READ_ONCE(r->sq.tail);
@@ -152,14 +151,15 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 		 * thread termination.
 		 */
 		if (tsk) {
+			u64 usec;
+
 			get_task_struct(tsk);
 			rcu_read_unlock();
-			getrusage(tsk, RUSAGE_SELF, &sq_usage);
+			usec = io_sq_cpu_usec(tsk);
 			put_task_struct(tsk);
 			sq_pid = sq->task_pid;
 			sq_cpu = sq->sq_cpu;
-			sq_total_time = (sq_usage.ru_stime.tv_sec * 1000000
-					 + sq_usage.ru_stime.tv_usec);
+			sq_total_time = usec;
 			sq_work_time = sq->work_time;
 		} else {
 			rcu_read_unlock();
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index a3f11349ce06..2b816fdb9866 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -11,6 +11,7 @@
 #include <linux/audit.h>
 #include <linux/security.h>
 #include <linux/cpuset.h>
+#include <linux/sched/cputime.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
@@ -169,6 +170,20 @@ static inline bool io_sqd_events_pending(struct io_sq_data *sqd)
 	return READ_ONCE(sqd->state);
 }
 
+u64 io_sq_cpu_usec(struct task_struct *tsk)
+{
+	u64 utime, stime;
+
+	task_cputime_adjusted(tsk, &utime, &stime);
+	do_div(stime, 1000);
+	return stime;
+}
+
+static void io_sq_update_worktime(struct io_sq_data *sqd, u64 usec)
+{
+	sqd->work_time += io_sq_cpu_usec(current) - usec;
+}
+
 static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 {
 	unsigned int to_submit;
@@ -255,26 +270,15 @@ static bool io_sq_tw_pending(struct llist_node *retry_list)
 	return retry_list || !llist_empty(&tctx->task_list);
 }
 
-static void io_sq_update_worktime(struct io_sq_data *sqd, struct rusage *start)
-{
-	struct rusage end;
-
-	getrusage(current, RUSAGE_SELF, &end);
-	end.ru_stime.tv_sec -= start->ru_stime.tv_sec;
-	end.ru_stime.tv_usec -= start->ru_stime.tv_usec;
-
-	sqd->work_time += end.ru_stime.tv_usec + end.ru_stime.tv_sec * 1000000;
-}
-
 static int io_sq_thread(void *data)
 {
 	struct llist_node *retry_list = NULL;
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
-	struct rusage start;
 	unsigned long timeout = 0;
 	char buf[TASK_COMM_LEN] = {};
 	DEFINE_WAIT(wait);
+	u64 start;
 
 	/* offload context creation failed, just exit */
 	if (!current->io_uring) {
@@ -317,7 +321,7 @@ static int io_sq_thread(void *data)
 		}
 
 		cap_entries = !list_is_singular(&sqd->ctx_list);
-		getrusage(current, RUSAGE_SELF, &start);
+		start = io_sq_cpu_usec(current);
 		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
 			int ret = __io_sq_thread(ctx, cap_entries);
 
@@ -333,7 +337,7 @@ static int io_sq_thread(void *data)
 
 		if (sqt_spin || !time_after(jiffies, timeout)) {
 			if (sqt_spin) {
-				io_sq_update_worktime(sqd, &start);
+				io_sq_update_worktime(sqd, start);
 				timeout = jiffies + sqd->sq_thread_idle;
 			}
 			if (unlikely(need_resched())) {
diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
index b83dcdec9765..fd2f6f29b516 100644
--- a/io_uring/sqpoll.h
+++ b/io_uring/sqpoll.h
@@ -29,6 +29,7 @@ void io_sq_thread_unpark(struct io_sq_data *sqd);
 void io_put_sq_data(struct io_sq_data *sqd);
 void io_sqpoll_wait_sq(struct io_ring_ctx *ctx);
 int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx, cpumask_var_t mask);
+u64 io_sq_cpu_usec(struct task_struct *tsk);
 
 static inline struct task_struct *sqpoll_task_locked(struct io_sq_data *sqd)
 {


