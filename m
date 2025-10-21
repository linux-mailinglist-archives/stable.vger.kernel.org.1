Return-Path: <stable+bounces-188395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8659BF800E
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B7424EDC7F
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFBF34E759;
	Tue, 21 Oct 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lbn5QIw/"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1AB34D4CD
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069528; cv=none; b=E9xzAK2svw0SW4vdAPGXExf8LIdTS5vYmvpqaIg1cj3lbHwGdEFrvu2Xi5rNOrSwau96UUanQP2xWUay3jdSzhQDKf9khblFV8uMyTpLqSgEnP1Kyf7SfcjkIS9A/9FBGIWdo+3cQ4vnUFqiFOq2S7LTv7bkf+Awiz6+IImVOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069528; c=relaxed/simple;
	bh=dYaqtba+lcEi9oMjWIvqfn4QBsARq3VcoPkYULF3kZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U12+laxJVXbyWHbcYpa3H1Fn8ayGxSrUcwLCVaRXqIs034eMJK166bfsJkPzPCWACty3sWjWbPFKTiswpwM2ZZm4NIYam8sFqs/o7FulXn9tw2lZ9OQJegDOCFCOMUazfMzaSlwmnKFcvoQCTBQH3ZL46l8X1cgdgIAartUfb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lbn5QIw/; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93bccd4901aso494732339f.2
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761069525; x=1761674325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//rgOuzlc3oY7UoauIetEGfK45OBiE/hDMSHNfmVnPo=;
        b=lbn5QIw/Gghs+2i3V40XsiNANLkSFoty0ZI052ly43juN+QPLMwx6Qwkbnh7yzsxue
         n+C1PO06o1fMNYT8tprIFPbi1HL7u31+cfJj64VtwDBKlT2aK8PVOowdRZwwQhz2xsF9
         hiSQaU0nx1LCY0+n3jzjvjgAxroAxO+KNPz1mzQjzQfD9uZiVj8LFzNl0LLJ0rq516/3
         X/Gc1cqwddf4x5tYb6pb6+jIimq/lEobFH7vwnKipXwbFJea8nLXkYEb4N0wA204puZ0
         C8i2CZOMTlDvBUu+GIWHFS+3SuJO55OfmZAdh4lPwoMJpXx71LEqt4pHbRn7D6a9UUce
         Ympw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069525; x=1761674325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//rgOuzlc3oY7UoauIetEGfK45OBiE/hDMSHNfmVnPo=;
        b=JuNiQi9/wXaf2xhKefUpztzAuWg7hQ4f24IC0TQGb/Th2F+q0OdJOYVsDyS75A5XKD
         5TwAcK/+nV/9IA8LZoE6j1r3b5drqdTwjLourjzVhIY/uEdqAmCJ1rZhji0Dgmnud4N1
         C71T5HfLkgbRnDIjQVkttKr7M0SGBMi3jPVcdUWXcaHWg5yhH/BmWZeMznte0mBosLjm
         8kT0Cy0KW1l39RYGDpLAtlSqbNThWoLNnh0puJPQD49OI2q3as3TjnaJxVZ05n5VDUWb
         HD1K36s03x+qXdguFGeA0rxpXp5almrk3vTo3A3fumvvTVZ0HnSwPIkVq16r12YQgy1v
         c5fA==
X-Forwarded-Encrypted: i=1; AJvYcCV80jS8LBVWcJGFA5/1frWGGBBrdxkW+be1FnS7xn8sg3TCP6V2F8XIBHZ/6YLE17FqELne+Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyajnl7nFga1KVtFxuxasjftNJEuJx5lDLP38O4Lqc46sjZb90G
	hYZ/kcmJg9/c6zVzym2OqA6NgkX7oTlxhbxYKqi0lcQaK37AjaTTtvdLziGtAH93MBuao9ZYyLh
	AuMXByLY=
X-Gm-Gg: ASbGncu9580gViqrDm2TohFwm2Jpd4e/G0fVyt9JvGUu7cnptsXKqscR9u66lmNLrOU
	lXHb5h0gWOQTRcD4mE4pkU3dlpBLFrilXUL5YpTpE02C12qCw0tkPGrmpnqDdJ3R/gPiTB9hETJ
	1tVWNB5fNNet5zMoHtoh+dWpPsq49uQbzBbkh5IWHuU0+X21AZX7Lf9ltXgkOxxoe6kd5KPFz3O
	n7/L3oKfZVqspXJ1SUoOc0gygMZWuqgTnUcFaGvRXKC62qvHZ+QOy8cWSb+qRppZ9hQSMLZROic
	ObVzPdEAAYJ7GXOpS8LA2FseyYw4PQsy5nriOZsFdpWDkaNWIFNAjZOiVMkngaiYl7uGS83kvxn
	394fkUT+EZqF/1EraubD1O+/VD9Lt1LoIYW7nbQJ6kpvYk3BHlI4iMCu4sKQ=
X-Google-Smtp-Source: AGHT+IF8VMNfHV/EXMnTNxc2gcDU2NQQY//hClJ3pbjTujeEWZe7CHdGVuvCphR23vF9zUqANRkYDA==
X-Received: by 2002:a05:6602:2c01:b0:920:865c:a8a9 with SMTP id ca18e2360f4ac-93e7643157cmr2907822539f.14.1761069525182;
        Tue, 21 Oct 2025 10:58:45 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e866e0afbsm419906339f.17.2025.10.21.10.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:58:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: changfengnan@bytedance.com,
	xiaobing.li@samsung.com,
	lidiangang@bytedance.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring/sqpoll: switch away from getrusage() for CPU accounting
Date: Tue, 21 Oct 2025 11:55:54 -0600
Message-ID: <20251021175840.194903-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021175840.194903-1-axboe@kernel.dk>
References: <20251021175840.194903-1-axboe@kernel.dk>
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
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/fdinfo.c |  9 +++++----
 io_uring/sqpoll.c | 34 ++++++++++++++++++++--------------
 io_uring/sqpoll.h |  1 +
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index ff3364531c77..966e06b078f6 100644
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
@@ -152,14 +151,16 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 		 * thread termination.
 		 */
 		if (tsk) {
+			struct timespec64 ts;
+
 			get_task_struct(tsk);
 			rcu_read_unlock();
-			getrusage(tsk, RUSAGE_SELF, &sq_usage);
+			ts = io_sq_cpu_time(tsk);
 			put_task_struct(tsk);
 			sq_pid = sq->task_pid;
 			sq_cpu = sq->sq_cpu;
-			sq_total_time = (sq_usage.ru_stime.tv_sec * 1000000
-					 + sq_usage.ru_stime.tv_usec);
+			sq_total_time = (ts.tv_sec * 1000000
+					 + ts.tv_nsec / 1000);
 			sq_work_time = sq->work_time;
 		} else {
 			rcu_read_unlock();
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index a3f11349ce06..8705b0aa82e0 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -11,6 +11,7 @@
 #include <linux/audit.h>
 #include <linux/security.h>
 #include <linux/cpuset.h>
+#include <linux/sched/cputime.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
@@ -169,6 +170,22 @@ static inline bool io_sqd_events_pending(struct io_sq_data *sqd)
 	return READ_ONCE(sqd->state);
 }
 
+struct timespec64 io_sq_cpu_time(struct task_struct *tsk)
+{
+	u64 utime, stime;
+
+	task_cputime_adjusted(tsk, &utime, &stime);
+	return ns_to_timespec64(stime);
+}
+
+static void io_sq_update_worktime(struct io_sq_data *sqd, struct timespec64 start)
+{
+	struct timespec64 ts;
+
+	ts = timespec64_sub(io_sq_cpu_time(current), start);
+	sqd->work_time += ts.tv_sec * 1000000 + ts.tv_nsec / 1000;
+}
+
 static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 {
 	unsigned int to_submit;
@@ -255,23 +272,12 @@ static bool io_sq_tw_pending(struct llist_node *retry_list)
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
+	struct timespec64 start;
 	unsigned long timeout = 0;
 	char buf[TASK_COMM_LEN] = {};
 	DEFINE_WAIT(wait);
@@ -317,7 +323,7 @@ static int io_sq_thread(void *data)
 		}
 
 		cap_entries = !list_is_singular(&sqd->ctx_list);
-		getrusage(current, RUSAGE_SELF, &start);
+		start = io_sq_cpu_time(current);
 		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
 			int ret = __io_sq_thread(ctx, cap_entries);
 
@@ -333,7 +339,7 @@ static int io_sq_thread(void *data)
 
 		if (sqt_spin || !time_after(jiffies, timeout)) {
 			if (sqt_spin) {
-				io_sq_update_worktime(sqd, &start);
+				io_sq_update_worktime(sqd, start);
 				timeout = jiffies + sqd->sq_thread_idle;
 			}
 			if (unlikely(need_resched())) {
diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
index b83dcdec9765..84ed2b312e88 100644
--- a/io_uring/sqpoll.h
+++ b/io_uring/sqpoll.h
@@ -29,6 +29,7 @@ void io_sq_thread_unpark(struct io_sq_data *sqd);
 void io_put_sq_data(struct io_sq_data *sqd);
 void io_sqpoll_wait_sq(struct io_ring_ctx *ctx);
 int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx, cpumask_var_t mask);
+struct timespec64 io_sq_cpu_time(struct task_struct *tsk);
 
 static inline struct task_struct *sqpoll_task_locked(struct io_sq_data *sqd)
 {
-- 
2.51.0


