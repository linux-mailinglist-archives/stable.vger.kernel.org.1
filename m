Return-Path: <stable+bounces-253855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HKXNpnLEGpAdwYAu9opvQ
	(envelope-from <stable+bounces-253855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:33:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CA85BA79B
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C214730151F6
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F638A71B;
	Fri, 22 May 2026 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t+tpgf/g"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FD38AC72
	for <stable@vger.kernel.org>; Fri, 22 May 2026 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485497; cv=none; b=LqaEnFYPBM9OQ/tHLF4KXPaJqnf9zccYuQxsgVtcT7pquwCs9ujuYytl2cpHb2Zojzc08Ey9So6SWR8WH0uHq/fav1tsg8AwiPcceWT8BRYmQl492Lrsub+SoMu01Tl69gPWPVLjyUBYt7NMNhLrlfVgIq0iV2QOmiKaOiUoF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485497; c=relaxed/simple;
	bh=7rrYcqS0BJywmsHQbi5p3H6gWVSZH7LBj6DdkqDToZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbK/O2cQVTNDSfrpFrt4rlc7IsnjyaeYMLhl4XcQdC/xvqup0/7XLnpi4ry7ZdfgzQxqSFv/k689W8gxBWKJ3bHxK/8T/rgHbX1oYep31+1B+zrUPnYjxhjbs+hKrmEbsB9RUzwnkhyHSudJjAPkd6nB8/elfeE2GJYgulGyQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=t+tpgf/g; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gMdkr1RGWz9twv;
	Fri, 22 May 2026 23:31:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779485492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7afLc46o4xKYzT0WryKR4atAd90LyQvI2Q0mPtH/qto=;
	b=t+tpgf/gi+e4qtIfZNgGSE6z3quGFlDt506hPIjrucu715yJBX4WNPY2HKWpG14p37Ih7l
	c9LwxFiYEH+ZqzPTyPfc1cC1tEtSI7xIjvvRwuyYWWTLQKa7iiyeZ9ZLWKgUUaob4lBLuq
	H5GjAfNPZybNNKd6PMMNLPYybH66syIgEg5gy/zJnb9+7TItmHK1V2ENH18XgfVLxHQtaE
	VN1O7HQvwCeq1iroY6cpFzAWKDyPfJZOQdVrj+TV/FbWRmmfgwDtWiFADYzNPLFW3dF/Hn
	pR5uKIgZZLq2r/rB9uhiy2GC2h0q0lutQOSHLci/JRmrk7FaFtVEjFXO1EM8wQ==
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Mike Galbraith <efault@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 6.12.y 1/3] sched/deadline: Less agressive dl_server handling
Date: Fri, 22 May 2026 23:31:18 +0200
Message-ID: <20260522213120.1205100-2-lbckmnn@mailbox.org>
In-Reply-To: <20260522213120.1205100-1-lbckmnn@mailbox.org>
References: <20260522213120.1205100-1-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: d695cgfbddajd7gfjipkxhdqjr4uzjuw
X-MBO-RS-ID: eff4f47ea90d931ab91
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmx.de,infradead.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253855-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lbckmnn@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: 41CA85BA79B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peter Zijlstra <peterz@infradead.org>

commit cccb45d7c4295bbfeba616582d0249f2d21e6df5 upstream.

Chris reported that commit 5f6bd380c7bd ("sched/rt: Remove default
bandwidth control") caused a significant dip in his favourite
benchmark of the day. Simply disabling dl_server cured things.

His workload hammers the 0->1, 1->0 transitions, and the
dl_server_{start,stop}() overhead kills it -- fairly obviously a bad
idea in hind sight and all that.

Change things around to only disable the dl_server when there has not
been a fair task around for a whole period. Since the default period
is 1 second, this ensures the benchmark never trips this, overhead
gone.

Fixes: 557a6bfc662c ("sched/fair: Add trivial fair server")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20250702121158.465086194@infradead.org
[ adjust context for renamed/removed variable names ]
Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
---
 include/linux/sched.h   |  1 +
 kernel/sched/deadline.c | 25 ++++++++++++++++++++++---
 kernel/sched/fair.c     |  9 ---------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2e4c437c7c90..299a65a92d2e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -674,6 +674,7 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
+	unsigned int			dl_server_idle    : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1ef891f8e3f2..9c5fa95b345a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1201,6 +1201,8 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
 static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
 
+static bool dl_server_stopped(struct sched_dl_entity *dl_se);
+
 static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = rq_of_dl_se(dl_se);
@@ -1220,6 +1222,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 
 		if (!dl_se->server_has_tasks(dl_se)) {
 			replenish_dl_entity(dl_se);
+			dl_server_stopped(dl_se);
 			return HRTIMER_NORESTART;
 		}
 
@@ -1626,8 +1629,10 @@ void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime = fair server disabled */
-	if (dl_se->dl_runtime)
+	if (dl_se->dl_runtime) {
+		dl_se->dl_server_idle = 0;
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+	}
 }
 
 /*
@@ -1850,7 +1855,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 		setup_new_dl_entity(dl_se);
 	}
 
-	if (!dl_se->dl_runtime)
+	if (!dl_se->dl_runtime || dl_se->dl_server_active)
 		return;
 
 	dl_se->dl_server_active = 1;
@@ -1871,6 +1876,20 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	dl_se->dl_server_active = 0;
 }
 
+static bool dl_server_stopped(struct sched_dl_entity *dl_se)
+{
+	if (!dl_se->dl_server_active)
+		return false;
+
+	if (dl_se->dl_server_idle) {
+		dl_server_stop(dl_se);
+		return true;
+	}
+
+	dl_se->dl_server_idle = 1;
+	return false;
+}
+
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task)
@@ -2628,7 +2647,7 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	if (dl_server(dl_se)) {
 		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
-			if (dl_server_active(dl_se)) {
+			if (!dl_server_stopped(dl_se)) {
 				dl_se->dl_yielded = 1;
 				update_curr_dl_se(rq, dl_se, 0);
 			}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a0a47e50b71c..d26e078d0623 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5972,7 +5972,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long queued_delta, runnable_delta, idle_task_delta, delayed_delta, dequeue = 1;
-	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -6059,10 +6058,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, queued_delta);
-
-	/* Stop the fair server if throttling resulted in no runnable tasks */
-	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
-		dl_server_stop(&rq->fair_server);
 done:
 	/*
 	 * Note: distribution will already see us throttled via the
@@ -7162,7 +7157,6 @@ static void set_next_buddy(struct sched_entity *se);
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 {
 	bool was_sched_idle = sched_idle_rq(rq);
-	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
@@ -7251,9 +7245,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 	sub_nr_running(rq, h_nr_queued);
 
-	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
-		dl_server_stop(&rq->fair_server);
-
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
-- 
2.54.0


