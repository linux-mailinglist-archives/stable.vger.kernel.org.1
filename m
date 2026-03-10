Return-Path: <stable+bounces-224511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF6QO504sGlZhQIAu9opvQ
	(envelope-from <stable+bounces-224511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:28:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0E253814
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CECA331B199
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5BB2FCC0E;
	Tue, 10 Mar 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q4lW8S1p"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED62C1593
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154529; cv=none; b=kYFGzLRrni+daqi5pCimyVMDerHIfv6hNCgvJSqCKEwrYaSAJ9s4ZOhjy2HKjmpRxs+3+ySNi8dBVQC/jqnzxingvlikjj7tyiOxc9NBZMNfiOl25DRuXyECdsQq8b6tO/XXlyu0ag5CbCfGgAXE0cbzupzf1daMpaEIq5f4AB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154529; c=relaxed/simple;
	bh=F7AyCcKDLyjgIeL62oYrRM2tU5lPLUH4zzQnMfZtRR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxg+w/2C3ECdFPowWs5QhdeBFVN6/hi5b9GldfioKkTquYUNEnDsGdrZpz7KV/9gYPZG3c/onZKW8CCBUn2Md666K/vtxBAnl6F0Uo/dL+XNI6wKE/4kAJ2OQ/bVsDLixQIUkMgiuZWPFOLHbz5APXGEbDtVODLx61C5Ls7lEf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q4lW8S1p; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-466f59dbe4bso506260b6e.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773154527; x=1773759327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPULb14kNMQTAj3BrqOQcDmn91h9zoOXOyDBRnihkhw=;
        b=Q4lW8S1pK83xbOZgetN1Qmh2ATojfR+FkLIYTJY7RbHZoLSaBI3KGV0V2mZhbJHI56
         xhCvHD+U1UGVQEOc8B9dnqepnEmMARqZ5VzaDKz3UWDLsSHqfQH0lJMRey+2xlZQczPq
         A5QuUbAKZ8eXDHt1999vLZkxHPgLBPsvvNSAJYrXtPliZ5DMQeTWlpxX50Fd0ErXLbpj
         /SIrEKcpjrChjx3vEBIIq0lJOEYl/ssHgJ9bnVE5baq5GDEVirhPHEwRGnSOWp6IifOm
         2gNTdgytAAn/stP45Jl9MW7+D5TSvB+lQQBklfhkz6ea1XkCYwHPoTkJBAD+ctkj0Z8h
         J+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154527; x=1773759327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPULb14kNMQTAj3BrqOQcDmn91h9zoOXOyDBRnihkhw=;
        b=ijB50AZ7GTyIwvkbn32bBguJjlV7ZIs9L5QbFGW3rFmR6Y6NWzr9j48ZKokmAbTFdv
         wO/wrVn3G7I+1zp2Y5CVj4gm+yiTlqNr+pDP1lGoaYn8krr8KTrrwByjsQ8TwnNG3GVi
         zuzmGPJUexWvJ/LKyY/uc29ecHzsg4WrPEQG9V4OPD4Y4BwFdbtGPl7QH6Z4u51xHjrh
         liHGzpB7W8ChQxUyLwcBSpyDE4mt2+s4IoJBPi2wAynoV+B7gJoUcRk8QRTiInNvtk/3
         ObcBT6E1TOVe5DuzXl80NjMdZXimdXyJFIJ2SiBMVNxil9SsMm0fbz8U20Czqh4R3bjT
         Bt5g==
X-Forwarded-Encrypted: i=1; AJvYcCUsTb07ESn509fYwz7rBcKjwU+pzxiu8e5EsCwLmW3q6ijWR/iD1eFWz1swvsSxzMA+CDldzD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdIf6Ybqzbcah185wY5VKDzwrULSU0zZgvmDzgFmYpMQqR7fE
	qZEb1sY/amiiFHqxRn8oCon8vigHcHBNcF+9pNqqqBwvNbOGGoPWJ4f08FzVda73H1ujn6XaN0o
	dSu9q6/w=
X-Gm-Gg: ATEYQzyOewZDMroycn6et1rQbPhhF7jqNNJqxvFY1wsAH7V3PBY9DUkCEr9wChHWKxV
	M2W6mlk/HJgOKNAlNwms6ZZbKL5JzTVc2si1d//OK+t44MeBe4HQiSvWTGKJHRmJm6T2cY2u0x8
	n0YONxFWBuUqWJsnrtJRmN3Sj7eiOo2Ub0Tpsi6rfXYyfrxU+6WIGFVUZoIPIDY4Hus4c6IzhsZ
	wsW7QDkfBBALM5xM1EjCCstVc1utb2RSmvOmmHtc1gSUrGz8vRjvi4PZ+Ryrjd0dF7PzYFaeuE+
	eot2f5FYFCPEBCqqb2elcGMGAnQfGIFZ+ykJvwaIm9AwISmzZv4Mw3YQhDjGbzsdJC3bhySrklw
	sT+PWEC9rfjwZdEGu6VA5VPbyl7LxhJa1SCvuAnYE9GjmCaJFs1fLppfsis22HQElXmoLng0IxF
	WlQdg95aoU/eEWemHk1ip/JqWIWBlUesontMO4txMBO3GNpW3Z4U0HRDmzEZddFzQkPzcl
X-Received: by 2002:a05:6808:1308:b0:467:155f:8c2a with SMTP id 5614622812f47-467155fbd27mr2525921b6e.35.1773154526824;
        Tue, 10 Mar 2026 07:55:26 -0700 (PDT)
Received: from m2max ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466f429c7fcsm5786865b6e.9.2026.03.10.07.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:55:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	naup96721@gmail.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring: ensure ctx->rings is stable for task work flags manipulation
Date: Tue, 10 Mar 2026 08:45:48 -0600
Message-ID: <20260310145521.68268-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310145521.68268-1-axboe@kernel.dk>
References: <20260310145521.68268-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8DD0E253814
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-224511-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[kernel.dk];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
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
 io_uring/register.c            | 20 ++++++++++++++++++--
 io_uring/tw.c                  | 24 ++++++++++++++++++++++--
 4 files changed, 43 insertions(+), 4 deletions(-)

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
index a839b22fd392..5f2985ba0879 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -487,6 +487,18 @@ static void io_register_free_rings(struct io_ring_ctx *ctx,
 			 IORING_SETUP_CQE32 | IORING_SETUP_NO_MMAP | \
 			 IORING_SETUP_CQE_MIXED | IORING_SETUP_SQE_MIXED)
 
+static void io_resize_assign_rings(struct io_ring_ctx *ctx, struct io_rings *rings)
+{
+	/*
+	 * Just mark any flag we may have missed and that the application
+	 * should act on unconditionally. Worst case it'll be an extra
+	 * syscall.
+	 */
+	atomic_or(IORING_SQ_TASKRUN | IORING_SQ_NEED_WAKEUP, &rings->sq_flags);
+	ctx->rings = rings;
+	rcu_assign_pointer(ctx->rings_rcu, rings);
+}
+
 static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 {
 	struct io_ctx_config config;
@@ -579,6 +591,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 	spin_lock(&ctx->completion_lock);
 	o.rings = ctx->rings;
 	ctx->rings = NULL;
+	RCU_INIT_POINTER(ctx->rings_rcu, NULL);
 	o.sq_sqes = ctx->sq_sqes;
 	ctx->sq_sqes = NULL;
 
@@ -604,7 +617,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 	if (tail - old_head > p->cq_entries) {
 overflow:
 		/* restore old rings, and return -EOVERFLOW via cleanup path */
-		ctx->rings = o.rings;
+		io_resize_assign_rings(ctx, o.rings);
 		ctx->sq_sqes = o.sq_sqes;
 		to_free = &n;
 		ret = -EOVERFLOW;
@@ -633,7 +646,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 	ctx->sq_entries = p->sq_entries;
 	ctx->cq_entries = p->cq_entries;
 
-	ctx->rings = n.rings;
+	io_resize_assign_rings(ctx, n.rings);
 	ctx->sq_sqes = n.sq_sqes;
 	swap_old(ctx, o, n, ring_region);
 	swap_old(ctx, o, n, sq_region);
@@ -642,6 +655,9 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 out:
 	spin_unlock(&ctx->completion_lock);
 	mutex_unlock(&ctx->mmap_lock);
+	/* Wait for concurrent io_ctx_mark_taskrun() */
+	if (to_free == &o)
+		synchronize_rcu();
 	io_register_free_rings(ctx, to_free);
 
 	if (ctx->sq_data)
diff --git a/io_uring/tw.c b/io_uring/tw.c
index 1ee2b8ab07c8..c104e1e30d7c 100644
--- a/io_uring/tw.c
+++ b/io_uring/tw.c
@@ -152,6 +152,23 @@ void tctx_task_work(struct callback_head *cb)
 	WARN_ON_ONCE(ret);
 }
 
+/*
+ * Sets IORING_SQ_TASKRUN in the sq_flags shared with userspace, using the
+ * RCU protected rings pointer to be safe against concurrent ring resizing.
+ * Must be called inside an RCU read-side critical section.
+ */
+static void io_ctx_mark_taskrun(struct io_ring_ctx *ctx)
+{
+	struct io_rings *rings;
+
+	if (!(ctx->flags & IORING_SETUP_TASKRUN_FLAG))
+		return;
+
+	rings = rcu_dereference(ctx->rings_rcu);
+	if (rings)
+		atomic_or(IORING_SQ_TASKRUN, &rings->sq_flags);
+}
+
 void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -206,8 +223,7 @@ void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
 	 */
 
 	if (!head) {
-		if (ctx->flags & IORING_SETUP_TASKRUN_FLAG)
-			atomic_or(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
+		io_ctx_mark_taskrun(ctx);
 		if (ctx->has_evfd)
 			io_eventfd_signal(ctx, false);
 	}
@@ -231,6 +247,10 @@ void io_req_normal_work_add(struct io_kiocb *req)
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


