Return-Path: <stable+bounces-189022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE21ABFD719
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 19:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDFF19A1E49
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F4274B42;
	Wed, 22 Oct 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Bpa6Ue4A"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AEC25E824
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152665; cv=none; b=qVjCSdeCaST2f50kkr9oqToLyUdXaepoDvGfOTfr8u037552paMHnlCHTlQfGwtiQJJl/jd1cgnBZ8Y/dX+NI3DraydiJ/8oGDdGqzqm3vpvYLWpPANvuuY2s/tccJfRXNEyB37OttvwFyZLEqAGQaxKvAAh8CVlyRsJ3Du4igk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152665; c=relaxed/simple;
	bh=i2eQI3XaFWULmqdYv3Ny6NLiIEgT6YS61RrHqGyQgdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jR21fqftI4ql658/44cpKmKM7xgrGnmTuEFE1SPTPlaVMit6wyoavlnfDcRm1/JGIy5YMV7ZRZR8EC4mFgkSZLbyowuytLpjztYWsbf7LU1j3q+chronc8ODUQLiQSCjiD4BVObQ7gNoDKQ1q4fOBJ+rPZvjqQpb2COw+Y+dsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Bpa6Ue4A; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430c151ca28so28184345ab.2
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761152662; x=1761757462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cedYix93UpXuofahRWuOpgf8u8HttF8oaEywpS7Ki3c=;
        b=Bpa6Ue4At2+Hv3K8vQI8nax33G7EN1SKCh4HLKNyi1lNUdt1JGicHUsYv1VfWZZjTi
         tnlXD403d2+IpH3fsXvnO3hPIt9hPw0nBdjo2GuNZR0iFJNI5OgbZZM+7G4XAYXncww1
         PlOjepelpSgjmOn8v7bwazO/LSP/sfXieMcYegbGzz+YcO7d/aYuPYy+lIEwOYFBDxeO
         OwKJdi0DSIfCTXrj1TRjCT/3PMtA5LvisQMoxZtoem7wNEhdoHoDfh2gj0K558oyCUQI
         RWcPBcCnyxB8DgVux0lX0nOddvvwQpirSLhP4lBMaH8FlOMT41Pba/8vvTSRacPskT+1
         dNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152662; x=1761757462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cedYix93UpXuofahRWuOpgf8u8HttF8oaEywpS7Ki3c=;
        b=dNPyWb1B2cKg8tTfj9Pzy+qxVIO8Q2HZ6nIcpXTHFUVVooG//WRjFDtuKt2NZH1fz7
         2AKI1MrZLLNatC9kSZo2kSTZlAYfsKU2+3HVbG2yctI9Gsv7zBz/iOLrhpgpGjICFFyO
         JsAT4nDp+bEUlREzW7/HdbyNzDpbXzZhXM+jvXVRXmzhoLoiz44MAnbEd090ie15NiSe
         DlOg6MQFgm1DQdxOX+GWwQWlMEAxIhOKXCoF9hLumceWcQY0+pNnDnj9wOeAP+MQBX31
         8iqk2PBctLhNXnTXk5YXZLwgQMSV0LzIf3yddi3GzLIn7VTzE+rLPpWrsCkg/uaWt8B2
         13AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOPcuVGDHuZ9PifVrazfwMxvylO3kz/AX1xpZ0ueAbVAAocXbuYjV/EFhJsaq3qZ1wFXiEfHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8w3U3HVKbASo/i3LY2K6XmMmUwV4xa9Or9M2wAMXhFn+k+/I
	L5jt9MLe2MFOuxkYRHoks0L9yOKrA+sD/aEbWTpWmtAzCj3d7wNeOaOuldRCQnUS5K0=
X-Gm-Gg: ASbGnctL+CJkvNQ5V/2XUS03fVNWGhgVXS1Nzq1WJ6aQOW99U+qxHdW0R+bu/2yP+Vb
	NAwkdnqE3d/2ICare0h/rZouhQUodNbfNFd1jtw9h8DXzUdITPFb+auVxbD+P8a66t+e1SfZIs8
	tMCe34TTdcmZz7OnieOBeFQ0eYkwSYRZPfvWfu+lIzhCtYQy7X0/AneWSvcCyAA9Am4HmdGaYLb
	/mU0ioFzPiIulmFyNF/LxQIIAP4tdTYDlNy4DGxDqScLVNq+tuxOhTHa0ECa7e6AKguD0M/hAQ4
	YhY4klLkaGorlZc/MZr2lcHJGkBwUwkgxCAKOqppJ7nszMj48mitb81xzz4TBEed8WPhow1TgtN
	lJE37usTV6N6cvYm9ENgTrg+VGZMnc1zQHQ5Y7MlH4eqguZJZ+0NTlUq8yB5gdeotf/gvgw==
X-Google-Smtp-Source: AGHT+IEJRLIffhnekfUs4Wa5GpeiQRdkAifYgfyJsZn6gm0eOsIz3qpZGPGBALf4SfP+0qwODAn0xw==
X-Received: by 2002:a05:6e02:178e:b0:430:d061:d9f7 with SMTP id e9e14a558f8ab-430d061da22mr242828915ab.23.1761152661583;
        Wed, 22 Oct 2025 10:04:21 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a95fede6sm5352995173.12.2025.10.22.10.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:04:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: changfengnan@bytedance.com,
	xiaobing.li@samsung.com,
	lidiangang@bytedance.com,
	krisman@suse.de,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring/sqpoll: be smarter on when to update the stime usage
Date: Wed, 22 Oct 2025 11:02:48 -0600
Message-ID: <20251022170416.116554-3-axboe@kernel.dk>
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
+{
+	if (!ist->started)
+		return;
+	ist->started = false;
+	sqd->work_time += io_sq_cpu_usec(current) - ist->usec;
+}
+
+static void io_sq_start_worktime(struct io_sq_time *ist)
 {
-	sqd->work_time += io_sq_cpu_usec(current) - usec;
+	if (ist->started)
+		return;
+	ist->started = true;
+	ist->usec = io_sq_cpu_usec(current);
 }
 
-static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
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
-- 
2.51.0


