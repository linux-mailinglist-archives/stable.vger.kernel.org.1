Return-Path: <stable+bounces-224689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF4QFJtqsWnsugIAu9opvQ
	(envelope-from <stable+bounces-224689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:14:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B9B2643BB
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11354301BA5D
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF6D30AD15;
	Wed, 11 Mar 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ndKwhqse"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8A2FE575
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234826; cv=none; b=CoYoiW1PxWQUYnFOQ3HhC11mkgCpbHTUiGO9JFxsQrQWl8wBicmwKBE1209LUnSF9uamL+8VgaiB+RH04XEu3V5Kvi/Sv8ZvybBuVGk7SBIu9u3UejHcUwzobwSN8QMuyRUeEfbt4P5nI6d7HL1ij8qp7re5j4+aOQcKnTN/wZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234826; c=relaxed/simple;
	bh=/gRvdwFsueP4KDXlFTGJUrGoHx6ib/Ha7C5vNfnjzL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMa7nF/lLeDlrFRTvt3Z1fvYFa04h5BgFI5NYZQPwMT+WJGXWSjqYHu7TEtiqFxZlW7O4Bu/y1LGjWCEGkaW24ovBo3nz30Sko97HQsj07r+VbyGFM8SLC/y8549aTGFRcCsLCxGcgIV/dY3AzpOZ6NfB5YuD2TBBIYXhpOPHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ndKwhqse; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-46701f2077cso845781b6e.0
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773234823; x=1773839623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yhviBqIRh/9iFlrPxeHeHh9ik2w1XcH2i8WbdYRMfM=;
        b=ndKwhqseHhlO5HGHRAfhbNrX88xf37hrGqQQvf11dPtJSX1SKUjR9h8Ifz3ZHDb9bp
         Vp3T6nHh+aJlYcHG9pRojsII5R3RgEI6ZpMSK1xCmho3k7ry6d0+7gtJuqHz3+1CBwcO
         LQvHt6J/NQ4h7b6DFMPuvcowFbj72wh1f/c+3qD72MFYH1LSnjiExuA8tTWJGpWPyDGj
         VAhxiVGiAxctuM260wdR32ehIWLoIwMyHXutG0AEdcuKLbTIneHAzvlqdfU0TFEHel4M
         GvOY7xjBqA9RsF03kWxO4/I0/U+ScO5Kb213d+NiwKq/sotESP1adtVQbNIhBlHHyVh2
         aWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234823; x=1773839623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0yhviBqIRh/9iFlrPxeHeHh9ik2w1XcH2i8WbdYRMfM=;
        b=qAKtYmPvS0Rj9jRn1v+zIKt2OBl03AwvRs1KtkyV28i5LA9/1SFe9yMgFk+p3jNUbf
         2NS3qZJ4CSKHd49YVD7xYsIaVpQerUmHJ0Otxwx8jG2Dnk2gctWDS3ZJwyo5JahkZJDp
         YszQBnMsFcuvlRmbeBiZWR7llpegZWC5Lt4yM9EUAcjjeGdueNe0hJ3+8lvq6Ot2t0WL
         H5w/JRTvRmAPSXmAXokTrSHUPmj6NzGJla93Vfd5RM8BYyF491Cgo2iz0rIQvu+W7738
         y30MffN3WDbRVZyJI0gQKw3Dc830Sc0QnD49jCSOUffwpgXQvUpXVui30XwZZ7LSb2q4
         PSoA==
X-Forwarded-Encrypted: i=1; AJvYcCW0MfnsAZQ9UrByKoQXvJp5AjecsBGgW8JuDY3h50gR8vNLC1kTpnRZcz5X8BCgrTQEiNKULtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKcQjHEr9xyNwdiaUo6lBG8CvLQEYgJV0sVFEIe9HruTaX2BGe
	OTdbxlfT9pvIfM9MfuckSFAOLJ8D26agyLWWTnOsbYQJ6C6r894tG2sX80uxrw67d88=
X-Gm-Gg: ATEYQzy9LzjMXh9vwvwNzO2goaND3WJs/4g6AKrDbFpw5iVzGs4SjDdHM8+zSus0ikg
	hifj8SjLU3B/O2/llvY49MzHHqbJGcvaFtXqBwljZituaxz9BTBFmnzRMMphyI6T1fBzrxLMZdH
	PVpYyJTn+Bkn4D1FEw7/P5/JWuCzNg1lzHTK+XCOX1zlBTyPJT0yUSavgjlXiMmiXSywKqTnYgg
	+qYnD7rYEAMsRm4r/tXq7xh0drCQ8Yd/j7bgfWDdnUsS8bRQNZBDLScl2d9KfqhAf8Th6K+XZeF
	EFngiQqrEl7wMyy4TfatNzKHzdH/fpur+dE1bESQ6Iwa5OiYKVKrIrMQVnCKbPAmTwvdjtecOQm
	/rBx4ceK321lt0KqLNRlrZ9nab1SYBuBs/wkoCaycLKfCZm4m6YYoA1e6FSwqpx9Q6NIRzrEguY
	LSy9qTQFw0lCCBof3YBetogVmCMbq3RXGkhciuxogv7OrpHpzocngfKhP0TX5+F/bGkVfJ
X-Received: by 2002:a05:6820:3092:b0:67b:b411:47fd with SMTP id 006d021491bc7-67bc9150691mr1086399eaf.35.1773234823043;
        Wed, 11 Mar 2026 06:13:43 -0700 (PDT)
Received: from m2max ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm2286127fac.12.2026.03.11.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:13:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	naup96721@gmail.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring: ensure ctx->rings is stable for task work flags manipulation
Date: Wed, 11 Mar 2026 07:11:55 -0600
Message-ID: <20260311131336.197028-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311131336.197028-1-axboe@kernel.dk>
References: <20260311131336.197028-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C6B9B2643BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224689-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kernel.dk:mid,kernel.dk:email,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

If DEFER_TASKRUN | SETUP_TASKRUN is used and task work is added while
the ring is being resized, it's possible for the OR'ing of
IORING_SQ_TASKRUN to happen in the small window of swapping into the
new rings and the old rings being freed.

Prevent this by adding a 2nd ->rings pointer, ->rings_rcu, which is
protected by RCU. The task work flags manipulation is inside RCU
already, and if the resize ring freeing is done post an RCU synchronize,
then there's no need to add locking to the fast path of task work
additions.

Note: this is only done for DEFER_TASKRUN, as that's the only setup mode
that supports ring resizing. If this ever changes, then they too need to
use the io_ctx_mark_taskrun() helper.

Link: https://lore.kernel.org/io-uring/20260309062759.482210-1-naup96721@gmail.com/
Cc: stable@vger.kernel.org
Fixes: 79cfe9e59c2a ("io_uring/register: add IORING_REGISTER_RESIZE_RINGS")
Reported-by: Hao-Yu Yang <naup96721@gmail.com>
Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/io_uring_types.h |  1 +
 io_uring/io_uring.c            |  2 ++
 io_uring/register.c            | 11 +++++++++++
 io_uring/tw.c                  | 21 +++++++++++++++++++--
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 3e4a82a6f817..dd1420bfcb73 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -388,6 +388,7 @@ struct io_ring_ctx {
 	 * regularly bounce b/w CPUs.
 	 */
 	struct {
+		struct io_rings	__rcu	*rings_rcu;
 		struct llist_head	work_llist;
 		struct llist_head	retry_llist;
 		unsigned long		check_cq;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ccab8562d273..20fdc442e014 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2066,6 +2066,7 @@ static void io_rings_free(struct io_ring_ctx *ctx)
 	io_free_region(ctx->user, &ctx->sq_region);
 	io_free_region(ctx->user, &ctx->ring_region);
 	ctx->rings = NULL;
+	RCU_INIT_POINTER(ctx->rings_rcu, NULL);
 	ctx->sq_sqes = NULL;
 }
 
@@ -2703,6 +2704,7 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	if (ret)
 		return ret;
 	ctx->rings = rings = io_region_get_ptr(&ctx->ring_region);
+	rcu_assign_pointer(ctx->rings_rcu, rings);
 	if (!(ctx->flags & IORING_SETUP_NO_SQARRAY))
 		ctx->sq_array = (u32 *)((char *)rings + rl->sq_array_offset);
 
diff --git a/io_uring/register.c b/io_uring/register.c
index a839b22fd392..6d3e65b17514 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -633,7 +633,15 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 	ctx->sq_entries = p->sq_entries;
 	ctx->cq_entries = p->cq_entries;
 
+	/*
+	 * Just mark any flag we may have missed and that the application
+	 * should act on unconditionally. Worst case it'll be an extra
+	 * syscall.
+	 */
+	atomic_or(IORING_SQ_TASKRUN | IORING_SQ_NEED_WAKEUP, &n.rings->sq_flags);
 	ctx->rings = n.rings;
+	rcu_assign_pointer(ctx->rings_rcu, n.rings);
+
 	ctx->sq_sqes = n.sq_sqes;
 	swap_old(ctx, o, n, ring_region);
 	swap_old(ctx, o, n, sq_region);
@@ -642,6 +650,9 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 out:
 	spin_unlock(&ctx->completion_lock);
 	mutex_unlock(&ctx->mmap_lock);
+	/* Wait for concurrent io_ctx_mark_taskrun() */
+	if (to_free == &o)
+		synchronize_rcu();
 	io_register_free_rings(ctx, to_free);
 
 	if (ctx->sq_data)
diff --git a/io_uring/tw.c b/io_uring/tw.c
index 1ee2b8ab07c8..0c860a7e6c61 100644
--- a/io_uring/tw.c
+++ b/io_uring/tw.c
@@ -152,6 +152,20 @@ void tctx_task_work(struct callback_head *cb)
 	WARN_ON_ONCE(ret);
 }
 
+/*
+ * Sets IORING_SQ_TASKRUN in the sq_flags shared with userspace, using the
+ * RCU protected rings pointer to be safe against concurrent ring resizing.
+ * Must be called inside an RCU read-side critical section.
+ */
+static void io_ctx_mark_taskrun(struct io_ring_ctx *ctx)
+{
+	if (ctx->flags & IORING_SETUP_TASKRUN_FLAG) {
+		struct io_rings *rings = rcu_dereference(ctx->rings_rcu);
+
+		atomic_or(IORING_SQ_TASKRUN, &rings->sq_flags);
+	}
+}
+
 void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -206,8 +220,7 @@ void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
 	 */
 
 	if (!head) {
-		if (ctx->flags & IORING_SETUP_TASKRUN_FLAG)
-			atomic_or(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
+		io_ctx_mark_taskrun(ctx);
 		if (ctx->has_evfd)
 			io_eventfd_signal(ctx, false);
 	}
@@ -231,6 +244,10 @@ void io_req_normal_work_add(struct io_kiocb *req)
 	if (!llist_add(&req->io_task_work.node, &tctx->task_list))
 		return;
 
+	/*
+	 * Doesn't need to use ->rings_rcu, as resizing isn't supported for
+	 * !DEFER_TASKRUN.
+	 */
 	if (ctx->flags & IORING_SETUP_TASKRUN_FLAG)
 		atomic_or(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
 
-- 
2.53.0


