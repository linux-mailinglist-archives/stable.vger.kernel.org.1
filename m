Return-Path: <stable+bounces-188396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B05D3BF8015
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 930754ED602
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B127B34E75C;
	Tue, 21 Oct 2025 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vUwPXxiJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F732ABC3
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069530; cv=none; b=bJosNsIZW/W29VRh2YSmaOeS1pRASbY7bvwlDG45E0XVP4T6KOithbUCHXwCo0ChtZxUEpAcniwCjV8Lzyr25jA3Wo929md+Nco6GGNd+j6E18R+tvIsrkJVoYRJiCJkP9JOSPAQRvJ/76VzK+XODyclODCzjKDBWwpBnFd5Zk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069530; c=relaxed/simple;
	bh=B5+O6d34wyqaRGN7PvYb7wOB/q8e1LLZ771SzDFiwDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2xJ7HjXZkGSFK0bF2lp1XAraJhjl+7nDffVvPynMB4zvzeCec6j/MDdJbQaGtL8iM9JiliBGXzfpL55iAmCVl95NlRO/bPDBKCLDuztNA+qJ0MEO9JkzduY8IdmZ1AXque4WpYtm2rvnTWoS4x9nq5ZRJYRXTBPmIlSM2H9Ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vUwPXxiJ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93e89a59d68so143775639f.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761069527; x=1761674327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgZQRtGeuoQklO886vEuJlhDunqTcH03TlpEwBIf62c=;
        b=vUwPXxiJRzn9uP7hz+reaWIxgGzasqQqXI4S29ykAjbfABatJNGLeE5mAi0Z8jNQeD
         gw6WIQW5UFlZbKCPQyg+vTspGfFJtD1s3MeDnOj2hTk0/ZMbzsKDnNg/eUTKzZq2DG35
         KHyVF0Nr+yGKzapmvEVe7qANqrZwqZmO9pZ4fTbRYPffosU6cStr+1RPk75nLT4J26Sb
         r3kabNikotCq2BXbCxUnbyr8RBlQ1QNEpbiGoNnsz6XXDjlUadzOBYnZKddfgAWPFTrn
         05C1F0bZyACbPsyRIUVLThHkVXwZdgY9gD3ewugfN2WiMuPn2nKvO7cFknTjU+MwMpOy
         2Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069527; x=1761674327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgZQRtGeuoQklO886vEuJlhDunqTcH03TlpEwBIf62c=;
        b=nxP8pDdSXPvcGY3nQTlJ2TQ4wQs6KcgvD2pgTu4rYoIYked1inTZDh3C6iM1NH9kcO
         xmVC9oGuCHjm0ebn42PorHFp4If/UX1K+XzoQOS4p4RcENv0EsluxRrKGcMqXC2CSYCF
         m7vcbXwM1Oq5A8OOAo9EkWUnicLShcR0rrgub59sgrJ8Wl6dP0f9xerWPu9JscB/pIUH
         a7sgHltZ31Y6NxFxaJUYezbBQ5CCCiBpF4qVkCAnu6l5luGTCcvb80zBd9fQXfWz9TWY
         Koqn2iIQgeoarliHliYCADXnGBAzdF58/H/OFxoialT9oPNVT6JnxZhlq4nSuk6tjEQX
         D75g==
X-Forwarded-Encrypted: i=1; AJvYcCXmrogVnbpohnn0C5kA1mnhM/hUeX0sejY9xHfgHSDMuYY3MGdEKtVELY+kukglg3ulFZlUC5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7QL06G7FAuL5SmlJmkhoDyRLT/61CvbJ6cghJlKthcXtjkXE
	45HUcrj7RLxC9eFD5/L13/JNGzjgAllj/FAy4wFe1sW/jgilQOmNqUEaw6o71uhvVhIkeePRiJI
	1mKhkz7Y=
X-Gm-Gg: ASbGncsdkbLchHGJ3REqI5+um4itgDIlA+vJrpIE/JQ0jw3XJCl7eo961Ih0rwLu8Bn
	3RxSRI8tS6y1Dktk6BPean+LnIfjaCYDHYaiwjnqPk0lBdrZy+2KQbYxYDUPctHJ4z3/f8nu2cM
	MuWKGpCY6WNa8Gbky2UdfDkmQXCefJUXOhlgbnd6DIKNe0YZctfDIs7iXhZNC1UBXdDJvsUAMzb
	MSufhMd1Nmq7eoOjhAQhrfGu8WZ411EfePHsV6M1JggoosYUVIHzxsNTnvAHcYRBEehZFGDC72V
	52LuJalW8JcUV1UrFwxhM9wxIlOd4bdvZwv/dlRQnKjd6yWvbFqVXKp0IOYdK/zxR1AJcbUc+Xs
	+s04LrvgEtBiL657Z4LlFgEVS8q04gKyg4H+68riImwd9mSvo6RgyJqD5DFQ=
X-Google-Smtp-Source: AGHT+IHoAXAFkj81hhaUL511dlYYMDo7yOasZiz+snOCjO386a1+BN7G1zoRlL13OUxLW8MlFGyLNw==
X-Received: by 2002:a05:6602:2b02:b0:93e:7d6a:b0fd with SMTP id ca18e2360f4ac-93e7d6abbecmr2891644439f.7.1761069527363;
        Tue, 21 Oct 2025 10:58:47 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e866e0afbsm419906339f.17.2025.10.21.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:58:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: changfengnan@bytedance.com,
	xiaobing.li@samsung.com,
	lidiangang@bytedance.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring/sqpoll: be smarter on when to update the stime usage
Date: Tue, 21 Oct 2025 11:55:55 -0600
Message-ID: <20251021175840.194903-3-axboe@kernel.dk>
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
---
 io_uring/sqpoll.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 8705b0aa82e0..f6916f46c047 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -170,6 +170,11 @@ static inline bool io_sqd_events_pending(struct io_sq_data *sqd)
 	return READ_ONCE(sqd->state);
 }
 
+struct io_sq_time {
+	bool started;
+	struct timespec64 ts;
+};
+
 struct timespec64 io_sq_cpu_time(struct task_struct *tsk)
 {
 	u64 utime, stime;
@@ -178,15 +183,27 @@ struct timespec64 io_sq_cpu_time(struct task_struct *tsk)
 	return ns_to_timespec64(stime);
 }
 
-static void io_sq_update_worktime(struct io_sq_data *sqd, struct timespec64 start)
+static void io_sq_update_worktime(struct io_sq_data *sqd, struct io_sq_time *ist)
 {
 	struct timespec64 ts;
 
-	ts = timespec64_sub(io_sq_cpu_time(current), start);
+	if (!ist->started)
+		return;
+	ist->started = false;
+	ts = timespec64_sub(io_sq_cpu_time(current), ist->ts);
 	sqd->work_time += ts.tv_sec * 1000000 + ts.tv_nsec / 1000;
 }
 
-static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
+static void io_sq_start_worktime(struct io_sq_time *ist)
+{
+	if (ist->started)
+		return;
+	ist->started = true;
+	ist->ts = io_sq_cpu_time(current);
+}
+
+static int __io_sq_thread(struct io_ring_ctx *ctx, struct io_sq_data *sqd,
+			  bool cap_entries, struct io_sq_time *ist)
 {
 	unsigned int to_submit;
 	int ret = 0;
@@ -199,6 +216,8 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 	if (to_submit || !wq_list_empty(&ctx->iopoll_list)) {
 		const struct cred *creds = NULL;
 
+		io_sq_start_worktime(ist);
+
 		if (ctx->sq_creds != current_cred())
 			creds = override_creds(ctx->sq_creds);
 
@@ -277,7 +296,6 @@ static int io_sq_thread(void *data)
 	struct llist_node *retry_list = NULL;
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
-	struct timespec64 start;
 	unsigned long timeout = 0;
 	char buf[TASK_COMM_LEN] = {};
 	DEFINE_WAIT(wait);
@@ -315,6 +333,7 @@ static int io_sq_thread(void *data)
 	mutex_lock(&sqd->lock);
 	while (1) {
 		bool cap_entries, sqt_spin = false;
+		struct io_sq_time ist = { };
 
 		if (io_sqd_events_pending(sqd) || signal_pending(current)) {
 			if (io_sqd_handle_event(sqd))
@@ -323,9 +342,8 @@ static int io_sq_thread(void *data)
 		}
 
 		cap_entries = !list_is_singular(&sqd->ctx_list);
-		start = io_sq_cpu_time(current);
 		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
-			int ret = __io_sq_thread(ctx, cap_entries);
+			int ret = __io_sq_thread(ctx, sqd, cap_entries, &ist);
 
 			if (!sqt_spin && (ret > 0 || !wq_list_empty(&ctx->iopoll_list)))
 				sqt_spin = true;
@@ -333,15 +351,18 @@ static int io_sq_thread(void *data)
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
-- 
2.51.0


