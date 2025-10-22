Return-Path: <stable+bounces-189021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550BBBFD7BB
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 19:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFEC3B031D
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D58274B55;
	Wed, 22 Oct 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xD3FkPxc"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D71B7F4
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152665; cv=none; b=YgRwVcmn2g6cTzJy6QhSqfmMWUq/7oAQ1SigJwMWyf3vWACIfK1OyiLE6y9bRFefBDXxKu4N//2151DuGJRw6nHFvEGScU2AjWCvINOMJ2WuZeLSYy8hVHfn6I5ZzzdwnGk7n3/UCkP6GTzvTDaOd1wLbFlyCHXmmmRIH7Nd90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152665; c=relaxed/simple;
	bh=geRMEPTgQWgqA1c1O6saREfXxs9Kp/ukScF4km9sTdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZX2Wxukfigs++CzaIuNkRgRvCeTh6exuH1OYuO0iGw1YIdfoaGu8L1e45VMmr1p9dkl/IXpocdlg/NQZkha//k7VcyFab2LRwfd1idCAIaX74Yyw4+h5wr/rG+p2qaiucFF+NO/ENheKojCoPnAjy4ie+AVx8GvhNstCW5Oeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xD3FkPxc; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-930cfdfabb3so62790239f.1
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761152660; x=1761757460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6TFBeIrUuC/8GE5lsCClpuGYMrWqE761ZQSTQsicA4=;
        b=xD3FkPxcoXl+ZtfnKN3kFb5XBHTJwqemMjiMywpSraVJd6EdAgxDCYEFndcCxnzik2
         V/dDON+uw+f4Db5WGwzAX4vNakXsZaWj+ZalmCYdWuf0Og9/9THF7RDjiVU4+Kodoo7S
         EAjvqSDAERUN5OW0/Zlst5jCkFG3LH5ZNwoFY1NAJB+LHIb+LN4itFM2IxZi33wlpi5g
         I8BIW53/KV2khva1zIsOoHtNlO/5PAnNvtp9Ow5KXknoPetEK/YT/OvG8/nHS21zGuNy
         NA3wVs8DKKHmbj7MkDeLgHk0RoQzVsGFs1vejn/eZeUSGkNxkt59QeO7FzcxsZmjUq8b
         F2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152660; x=1761757460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6TFBeIrUuC/8GE5lsCClpuGYMrWqE761ZQSTQsicA4=;
        b=SvWLbPT4I0BmHow2V2Dtd3ELqDz+hegh14CD3sACd0q4g2YBob0rwOOsGTrCUxN75O
         ERbfPJUR2Rkf0QdCdChSx6eqS5qcu6mSFq0hdEVwDtDAnV06XmD1ov/GoYJ+lU0NL/qz
         dcCiPNTrs3lgXeHMyB4g3zqqKP7x7uglx81o4z+q8Id8LS1b0qkQQTm+EVxtt5Enq74Z
         FpKFAYsTTOYxoJU8IdtRKMPJpYWD2ow13whTwTNpBgzWxxcJ9U9Wip3YLQ7QhQynjTUD
         njy5XPfhOhX3n9+NKw8J2BmWRMfCO7EY1e5JbSnq8hh9p4Mwmh+x50sX6qC9uF5rNqt9
         M82Q==
X-Forwarded-Encrypted: i=1; AJvYcCUci2kDuKz8E9C+FW5xrkCbKWv9rAiOK3HysiDhukLT3qxQKkhXMLQUsDWiuhmymXrTtefawjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysRt4GuppRQZo4IGFSXkty3hMOuEyRZb9dcKMJF2TMEbsvmCEp
	3mfdsivkSPpmtNcXtU9K48AKqNpOx6qmdC89uOFtlXMTePMCQD4lo2tjQoGYb2jlnuQ=
X-Gm-Gg: ASbGncs0phL6r3Z65xgw5Y28MGaLG+yz/zkijjTFCE/9oQyoEI74PZIr+Jr03KV/YeV
	thnnw+NavXaXnqvekKdmz0P2rxxIEZ1DTCAKqGNz93kHdC8Xgef2/N0I9dhZZY6STi81Y2mHvbg
	SqOg+1JSfgWDZ8rgKbB7kNa+wkUp49mlHVhai6yDhYxF05h/UHe1yEhrDFoS1y9yTQyFJoq1oTL
	zxxL2pfzAUiMgrkBGZ6xnZ0GYvH0OHNBpE38U0YBCeDQtwCOknqvg5wH5sC5rXgSuWD3yUjzOKw
	O5Dio7FdS2tyE8KmGoz2lbdezq+HdE9UDUsDU15DlAENrNWLQkq44VRyuflk8HOP2B6oTy114TR
	p1ffEStzBYTVt+WJDOZhNjwqwDOSTypY1Nzob5QcR/ivpOULbj+Mo9NpFxEKsCHUXmC4lmw==
X-Google-Smtp-Source: AGHT+IEvMnVdDLdJZCnpFrS3Tw6u50EBpbCl/3SpKIL8oqaUiKpNEb9FtVe+PSdg7hsWAzZ8wObU9Q==
X-Received: by 2002:a05:6e02:3f03:b0:430:c928:fd90 with SMTP id e9e14a558f8ab-431d7326961mr30378225ab.10.1761152660247;
        Wed, 22 Oct 2025 10:04:20 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a95fede6sm5352995173.12.2025.10.22.10.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:04:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: changfengnan@bytedance.com,
	xiaobing.li@samsung.com,
	lidiangang@bytedance.com,
	krisman@suse.de,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring/sqpoll: switch away from getrusage() for CPU accounting
Date: Wed, 22 Oct 2025 11:02:47 -0600
Message-ID: <20251022170416.116554-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022170416.116554-1-axboe@kernel.dk>
References: <20251022170416.116554-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

getrusage() does a lot more than what the SQPOLL accounting needs, the
latter only cares about (and uses) the stime. Rather than do a full
RUSAGE_SELF summation, just query the used stime instead.

Cc: stable@vger.kernel.org
Fixes: 3fcb9d17206e ("io_uring/sqpoll: statistics of the true utilization of sq threads")
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/fdinfo.c |  8 ++++----
 io_uring/sqpoll.c | 32 ++++++++++++++++++--------------
 io_uring/sqpoll.h |  1 +
 3 files changed, 23 insertions(+), 18 deletions(-)

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
-- 
2.51.0


