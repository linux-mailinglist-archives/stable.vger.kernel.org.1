Return-Path: <stable+bounces-233622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BBYLOMa1WmZ0wcAu9opvQ
	(envelope-from <stable+bounces-233622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:55:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4901A3B0705
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28BAC301B04B
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0394E33C53F;
	Tue,  7 Apr 2026 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xj0SNZB2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884633B6EA
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573724; cv=none; b=pNUT/7Fp/pABPRfJXVxx+o1BuWrnSDgqxKkHwBKGBTfYaTLcKaFKufvKL9jUdnmOgenAs2t/xs9vyzvMUnMK/igmimWtrYB5xF4soeLau0Ri1KNM1Ty67WNxjslw+qx69T+U1/oivqtH/1msXjNVv9DfjsdhJn5+g6oAdaxeDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573724; c=relaxed/simple;
	bh=hf0VU5HW1fzJ+7aNQIi3vmquQMlhPncBtz4MlR9MvAE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KT9caXG1dRiU2NKoqu3KFRjPvqF32PR0wDiaqB7FQEJMz772OIu/Ob1c/8kmKW4FyrX9by0bqwevAfrKaAer0pZ59y8Sr2AR767gTUwd/eJ8St2+XHuYHBDJnsu3oEYuOAfKdyo2xY+TbYi00brFpDb56RH+HL2jHVGKw0kx1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xj0SNZB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BBFC116C6;
	Tue,  7 Apr 2026 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775573724;
	bh=hf0VU5HW1fzJ+7aNQIi3vmquQMlhPncBtz4MlR9MvAE=;
	h=Subject:To:Cc:From:Date:From;
	b=Xj0SNZB29wXcuNifcA+ZNPFdcQIZxtmjY0+o4uEBfYgIp/ln5aVUeqbqaYzfJjrnN
	 aXG0UnpEx+FPmThUAjWuS2c+Ep2Nqn5ccq4s1dWAiBHzQPb+s3LBUg7YqWvPLGWaqe
	 tp+fDWNYWGdVYkyxobXabmYsD9RIf+e7QiOKBPyg=
Subject: FAILED: patch "[PATCH] io_uring: protect remaining lockless ctx->rings accesses with" failed to apply to 6.18-stable tree
To: axboe@kernel.dk,qjx1298677004@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 16:55:13 +0200
Message-ID: <2026040713-lucid-wireless-bd2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233622-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.dk,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: 4901A3B0705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 61a11cf4812726aceaee17c96432e1c08f6ed6cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040713-lucid-wireless-bd2e@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61a11cf4812726aceaee17c96432e1c08f6ed6cb Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 31 Mar 2026 07:07:47 -0600
Subject: [PATCH] io_uring: protect remaining lockless ctx->rings accesses with
 RCU

Commit 96189080265e addressed one case of ctx->rings being potentially
accessed while a resize is happening on the ring, but there are still
a few others that need handling. Add a helper for retrieving the
rings associated with an io_uring context, and add some sanity checking
to that to catch bad uses. ->rings_rcu is always valid, as long as it's
used within RCU read lock. Any use of ->rings_rcu or ->rings inside
either ->uring_lock or ->completion_lock is sane as well.

Do the minimum fix for the current kernel, but set it up such that this
basic infra can be extended for later kernels to make this harder to
mess up in the future.

Thanks to Junxi Qian for finding and debugging this issue.

Cc: stable@vger.kernel.org
Fixes: 79cfe9e59c2a ("io_uring/register: add IORING_REGISTER_RESIZE_RINGS")
Reviewed-by: Junxi Qian <qjx1298677004@gmail.com>
Tested-by: Junxi Qian <qjx1298677004@gmail.com>
Link: https://lore.kernel.org/io-uring/20260330172348.89416-1-qjx1298677004@gmail.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 20ec8fdafcae..48f2f627319d 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2015,7 +2015,7 @@ int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
 	if (ctx->flags & IORING_SETUP_SQ_REWIND)
 		entries = ctx->sq_entries;
 	else
-		entries = io_sqring_entries(ctx);
+		entries = __io_sqring_entries(ctx);
 
 	entries = min(nr, entries);
 	if (unlikely(!entries))
@@ -2250,7 +2250,9 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 	 */
 	poll_wait(file, &ctx->poll_wq, wait);
 
-	if (!io_sqring_full(ctx))
+	rcu_read_lock();
+
+	if (!__io_sqring_full(ctx))
 		mask |= EPOLLOUT | EPOLLWRNORM;
 
 	/*
@@ -2270,6 +2272,7 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 	if (__io_cqring_events_user(ctx) || io_has_work(ctx))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	rcu_read_unlock();
 	return mask;
 }
 
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 0fa844faf287..ee24bc5d77b3 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -142,16 +142,28 @@ struct io_wait_queue {
 #endif
 };
 
+static inline struct io_rings *io_get_rings(struct io_ring_ctx *ctx)
+{
+	return rcu_dereference_check(ctx->rings_rcu,
+			lockdep_is_held(&ctx->uring_lock) ||
+			lockdep_is_held(&ctx->completion_lock));
+}
+
 static inline bool io_should_wake(struct io_wait_queue *iowq)
 {
 	struct io_ring_ctx *ctx = iowq->ctx;
-	int dist = READ_ONCE(ctx->rings->cq.tail) - (int) iowq->cq_tail;
+	struct io_rings *rings;
+	int dist;
+
+	guard(rcu)();
+	rings = io_get_rings(ctx);
 
 	/*
 	 * Wake up if we have enough events, or if a timeout occurred since we
 	 * started waiting. For timeouts, we always want to return to userspace,
 	 * regardless of event count.
 	 */
+	dist = READ_ONCE(rings->cq.tail) - (int) iowq->cq_tail;
 	return dist >= 0 || atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
 }
 
@@ -431,9 +443,9 @@ static inline void io_cqring_wake(struct io_ring_ctx *ctx)
 	__io_wq_wake(&ctx->cq_wait);
 }
 
-static inline bool io_sqring_full(struct io_ring_ctx *ctx)
+static inline bool __io_sqring_full(struct io_ring_ctx *ctx)
 {
-	struct io_rings *r = ctx->rings;
+	struct io_rings *r = io_get_rings(ctx);
 
 	/*
 	 * SQPOLL must use the actual sqring head, as using the cached_sq_head
@@ -445,9 +457,15 @@ static inline bool io_sqring_full(struct io_ring_ctx *ctx)
 	return READ_ONCE(r->sq.tail) - READ_ONCE(r->sq.head) == ctx->sq_entries;
 }
 
-static inline unsigned int io_sqring_entries(struct io_ring_ctx *ctx)
+static inline bool io_sqring_full(struct io_ring_ctx *ctx)
 {
-	struct io_rings *rings = ctx->rings;
+	guard(rcu)();
+	return __io_sqring_full(ctx);
+}
+
+static inline unsigned int __io_sqring_entries(struct io_ring_ctx *ctx)
+{
+	struct io_rings *rings = io_get_rings(ctx);
 	unsigned int entries;
 
 	/* make sure SQ entry isn't read before tail */
@@ -455,6 +473,12 @@ static inline unsigned int io_sqring_entries(struct io_ring_ctx *ctx)
 	return min(entries, ctx->sq_entries);
 }
 
+static inline unsigned int io_sqring_entries(struct io_ring_ctx *ctx)
+{
+	guard(rcu)();
+	return __io_sqring_entries(ctx);
+}
+
 /*
  * Don't complete immediately but use deferred completion infrastructure.
  * Protected by ->uring_lock and can only be used either with
diff --git a/io_uring/wait.c b/io_uring/wait.c
index 0581cadf20ee..91df86ce0d18 100644
--- a/io_uring/wait.c
+++ b/io_uring/wait.c
@@ -79,12 +79,15 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 	if (io_has_work(ctx))
 		goto out_wake;
 	/* got events since we started waiting, min timeout is done */
-	if (iowq->cq_min_tail != READ_ONCE(ctx->rings->cq.tail))
-		goto out_wake;
-	/* if we have any events and min timeout expired, we're done */
-	if (io_cqring_events(ctx))
-		goto out_wake;
+	scoped_guard(rcu) {
+		struct io_rings *rings = io_get_rings(ctx);
 
+		if (iowq->cq_min_tail != READ_ONCE(rings->cq.tail))
+			goto out_wake;
+		/* if we have any events and min timeout expired, we're done */
+		if (io_cqring_events(ctx))
+			goto out_wake;
+	}
 	/*
 	 * If using deferred task_work running and application is waiting on
 	 * more than one request, ensure we reset it now where we are switching
@@ -186,9 +189,9 @@ int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 		   struct ext_arg *ext_arg)
 {
 	struct io_wait_queue iowq;
-	struct io_rings *rings = ctx->rings;
+	struct io_rings *rings;
 	ktime_t start_time;
-	int ret;
+	int ret, nr_wait;
 
 	min_events = min_t(int, min_events, ctx->cq_entries);
 
@@ -201,15 +204,23 @@ int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 
 	if (unlikely(test_bit(IO_CHECK_CQ_OVERFLOW_BIT, &ctx->check_cq)))
 		io_cqring_do_overflow_flush(ctx);
-	if (__io_cqring_events_user(ctx) >= min_events)
+
+	rcu_read_lock();
+	rings = io_get_rings(ctx);
+	if (__io_cqring_events_user(ctx) >= min_events) {
+		rcu_read_unlock();
 		return 0;
+	}
 
 	init_waitqueue_func_entry(&iowq.wq, io_wake_function);
 	iowq.wq.private = current;
 	INIT_LIST_HEAD(&iowq.wq.entry);
 	iowq.ctx = ctx;
-	iowq.cq_tail = READ_ONCE(ctx->rings->cq.head) + min_events;
-	iowq.cq_min_tail = READ_ONCE(ctx->rings->cq.tail);
+	iowq.cq_tail = READ_ONCE(rings->cq.head) + min_events;
+	iowq.cq_min_tail = READ_ONCE(rings->cq.tail);
+	nr_wait = (int) iowq.cq_tail - READ_ONCE(rings->cq.tail);
+	rcu_read_unlock();
+	rings = NULL;
 	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
 	iowq.hit_timeout = 0;
 	iowq.min_timeout = ext_arg->min_time;
@@ -240,14 +251,6 @@ int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 	trace_io_uring_cqring_wait(ctx, min_events);
 	do {
 		unsigned long check_cq;
-		int nr_wait;
-
-		/* if min timeout has been hit, don't reset wait count */
-		if (!iowq.hit_timeout)
-			nr_wait = (int) iowq.cq_tail -
-					READ_ONCE(ctx->rings->cq.tail);
-		else
-			nr_wait = 1;
 
 		if (ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
 			atomic_set(&ctx->cq_wait_nr, nr_wait);
@@ -298,11 +301,20 @@ int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 			break;
 		}
 		cond_resched();
+
+		/* if min timeout has been hit, don't reset wait count */
+		if (!iowq.hit_timeout)
+			scoped_guard(rcu)
+				nr_wait = (int) iowq.cq_tail -
+						READ_ONCE(io_get_rings(ctx)->cq.tail);
+		else
+			nr_wait = 1;
 	} while (1);
 
 	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
 		finish_wait(&ctx->cq_wait, &iowq.wq);
 	restore_saved_sigmask_unless(ret == -EINTR);
 
-	return READ_ONCE(rings->cq.head) == READ_ONCE(rings->cq.tail) ? ret : 0;
+	guard(rcu)();
+	return READ_ONCE(io_get_rings(ctx)->cq.head) == READ_ONCE(io_get_rings(ctx)->cq.tail) ? ret : 0;
 }
diff --git a/io_uring/wait.h b/io_uring/wait.h
index 5e236f74e1af..3a145fcfd3dd 100644
--- a/io_uring/wait.h
+++ b/io_uring/wait.h
@@ -28,12 +28,15 @@ void io_cqring_do_overflow_flush(struct io_ring_ctx *ctx);
 
 static inline unsigned int __io_cqring_events(struct io_ring_ctx *ctx)
 {
-	return ctx->cached_cq_tail - READ_ONCE(ctx->rings->cq.head);
+	struct io_rings *rings = io_get_rings(ctx);
+	return ctx->cached_cq_tail - READ_ONCE(rings->cq.head);
 }
 
 static inline unsigned int __io_cqring_events_user(struct io_ring_ctx *ctx)
 {
-	return READ_ONCE(ctx->rings->cq.tail) - READ_ONCE(ctx->rings->cq.head);
+	struct io_rings *rings = io_get_rings(ctx);
+
+	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
 }
 
 /*


