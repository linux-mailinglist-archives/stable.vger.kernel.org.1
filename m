Return-Path: <stable+bounces-189775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1461C0A9E1
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13DB14E87A6
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E62225401;
	Sun, 26 Oct 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OLbQqL1i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154FE18D656
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488542; cv=none; b=Hk12qqF3pBxZWGd/e0zZxDcf+U2FLc0iBrrZ/7OVoURpRMMnelBtHjQanVXFENG4vodDVDeoZVhLgVjmq009d1pPfnMtuyOBW8wzTClp3bakA4BQ2qxcfQYhv5JZy4OwjVcMu4zoYo2SZQJRl3OkVKgwi1+OtN6QhKlzu3kHPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488542; c=relaxed/simple;
	bh=3rrt7jetr1puCj2TgYevf9Eyu+hpBXpBU4RppvwrQNk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sfOeyaWDYLJylg3SLY5T5hZGhmPV73sSpTS+/clTg4KdNbeD7/+4KEfrnOiVsYNdcupOfp+SUwcNUFc6b0Ijx7FhexKIzzwAE9+u7tbV1nrPukgp9GYmNVgA4jjYKBKJVDCeG1pO9Fbf9OYKFUEXPk1JoxOX4pdj/Ce9zrwY8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OLbQqL1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8C6C4CEE7;
	Sun, 26 Oct 2025 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488541;
	bh=3rrt7jetr1puCj2TgYevf9Eyu+hpBXpBU4RppvwrQNk=;
	h=Subject:To:Cc:From:Date:From;
	b=OLbQqL1iHbqppS1Zr49+Qv0oM1r3IMJTHoClvB/LFxO3zOBfxhv09xSEWPDgOoKEa
	 HZSNfh80Ob4afYI5H639DfOgSE61h1RMfvxSI5CWy1YlzXp2gWQH/liJ4/tuLo/tfg
	 fZGvgQqqSyVWzca+FgeCSJFZMECEvc607KLKFn20=
Subject: FAILED: patch "[PATCH] io_uring/sqpoll: be smarter on when to update the stime usage" failed to apply to 6.12-stable tree
To: axboe@kernel.dk,changfengnan@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:22:19 +0100
Message-ID: <2025102618-plastic-eldercare-f957@gregkh>
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
git cherry-pick -x a94e0657269c5b8e1a90b17aa2c048b3d276e16d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102618-plastic-eldercare-f957@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a94e0657269c5b8e1a90b17aa2c048b3d276e16d Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 21 Oct 2025 11:44:39 -0600
Subject: [PATCH] io_uring/sqpoll: be smarter on when to update the stime usage

The current approach is a bit naive, and hence calls the time querying
way too often. Only start the "doing work" timer when there's actual
work to do, and then use that information to terminate (and account) the
work time once done. This greatly reduces the frequency of these calls,
when they cannot have changed anyway.

Running a basic random reader that is setup to use SQPOLL, a profile
before this change shows these as the top cycle consumers:

+   32.60%  iou-sqp-1074  [kernel.kallsyms]  [k] thread_group_cputime_adjusted
+   19.97%  iou-sqp-1074  [kernel.kallsyms]  [k] thread_group_cputime
+   12.20%  io_uring      io_uring           [.] submitter_uring_fn
+    4.13%  iou-sqp-1074  [kernel.kallsyms]  [k] getrusage
+    2.45%  iou-sqp-1074  [kernel.kallsyms]  [k] io_submit_sqes
+    2.18%  iou-sqp-1074  [kernel.kallsyms]  [k] __pi_memset_generic
+    2.09%  iou-sqp-1074  [kernel.kallsyms]  [k] cputime_adjust

and after this change, top of profile looks as follows:

+   36.23%  io_uring     io_uring           [.] submitter_uring_fn
+   23.26%  iou-sqp-819  [kernel.kallsyms]  [k] io_sq_thread
+   10.14%  iou-sqp-819  [kernel.kallsyms]  [k] io_sq_tw
+    6.52%  iou-sqp-819  [kernel.kallsyms]  [k] tctx_task_work_run
+    4.82%  iou-sqp-819  [kernel.kallsyms]  [k] nvme_submit_cmds.part.0
+    2.91%  iou-sqp-819  [kernel.kallsyms]  [k] io_submit_sqes
[...]
     0.02%  iou-sqp-819  [kernel.kallsyms]  [k] cputime_adjust

where it's spending the cycles on things that actually matter.

Reported-by: Fengnan Chang <changfengnan@bytedance.com>
Cc: stable@vger.kernel.org
Fixes: 3fcb9d17206e ("io_uring/sqpoll: statistics of the true utilization of sq threads")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 2b816fdb9866..e22f072c7d5f 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -170,6 +170,11 @@ static inline bool io_sqd_events_pending(struct io_sq_data *sqd)
 	return READ_ONCE(sqd->state);
 }
 
+struct io_sq_time {
+	bool started;
+	u64 usec;
+};
+
 u64 io_sq_cpu_usec(struct task_struct *tsk)
 {
 	u64 utime, stime;
@@ -179,12 +184,24 @@ u64 io_sq_cpu_usec(struct task_struct *tsk)
 	return stime;
 }
 
-static void io_sq_update_worktime(struct io_sq_data *sqd, u64 usec)
+static void io_sq_update_worktime(struct io_sq_data *sqd, struct io_sq_time *ist)
 {
-	sqd->work_time += io_sq_cpu_usec(current) - usec;
+	if (!ist->started)
+		return;
+	ist->started = false;
+	sqd->work_time += io_sq_cpu_usec(current) - ist->usec;
 }
 
-static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
+static void io_sq_start_worktime(struct io_sq_time *ist)
+{
+	if (ist->started)
+		return;
+	ist->started = true;
+	ist->usec = io_sq_cpu_usec(current);
+}
+
+static int __io_sq_thread(struct io_ring_ctx *ctx, struct io_sq_data *sqd,
+			  bool cap_entries, struct io_sq_time *ist)
 {
 	unsigned int to_submit;
 	int ret = 0;
@@ -197,6 +214,8 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 	if (to_submit || !wq_list_empty(&ctx->iopoll_list)) {
 		const struct cred *creds = NULL;
 
+		io_sq_start_worktime(ist);
+
 		if (ctx->sq_creds != current_cred())
 			creds = override_creds(ctx->sq_creds);
 
@@ -278,7 +297,6 @@ static int io_sq_thread(void *data)
 	unsigned long timeout = 0;
 	char buf[TASK_COMM_LEN] = {};
 	DEFINE_WAIT(wait);
-	u64 start;
 
 	/* offload context creation failed, just exit */
 	if (!current->io_uring) {
@@ -313,6 +331,7 @@ static int io_sq_thread(void *data)
 	mutex_lock(&sqd->lock);
 	while (1) {
 		bool cap_entries, sqt_spin = false;
+		struct io_sq_time ist = { };
 
 		if (io_sqd_events_pending(sqd) || signal_pending(current)) {
 			if (io_sqd_handle_event(sqd))
@@ -321,9 +340,8 @@ static int io_sq_thread(void *data)
 		}
 
 		cap_entries = !list_is_singular(&sqd->ctx_list);
-		start = io_sq_cpu_usec(current);
 		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
-			int ret = __io_sq_thread(ctx, cap_entries);
+			int ret = __io_sq_thread(ctx, sqd, cap_entries, &ist);
 
 			if (!sqt_spin && (ret > 0 || !wq_list_empty(&ctx->iopoll_list)))
 				sqt_spin = true;
@@ -331,15 +349,18 @@ static int io_sq_thread(void *data)
 		if (io_sq_tw(&retry_list, IORING_TW_CAP_ENTRIES_VALUE))
 			sqt_spin = true;
 
-		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
-			if (io_napi(ctx))
+		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
+			if (io_napi(ctx)) {
+				io_sq_start_worktime(&ist);
 				io_napi_sqpoll_busy_poll(ctx);
+			}
+		}
+
+		io_sq_update_worktime(sqd, &ist);
 
 		if (sqt_spin || !time_after(jiffies, timeout)) {
-			if (sqt_spin) {
-				io_sq_update_worktime(sqd, start);
+			if (sqt_spin)
 				timeout = jiffies + sqd->sq_thread_idle;
-			}
 			if (unlikely(need_resched())) {
 				mutex_unlock(&sqd->lock);
 				cond_resched();


