Return-Path: <stable+bounces-253856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHGiOLPLEGpAdwYAu9opvQ
	(envelope-from <stable+bounces-253856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:33:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED725BA7AA
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD7D83012BE8
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879C038B7B4;
	Fri, 22 May 2026 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GX2gdHxK"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC138A299
	for <stable@vger.kernel.org>; Fri, 22 May 2026 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485497; cv=none; b=T6cRyQ+tL4G/EwzjLJLX5vumlZozWIW18sElgFoeSu4Y+PhqKyCgMs0YKoNXMZ8kDYhblhHe4B3udUjAu9gdgmugj6sVvc25L7hqnzW2HHXu6syub4awE4qWCcJS4bHzS8PXN4K8E5RdufRSsKfmsMWcZbCdGt4Swy/1PN/+RK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485497; c=relaxed/simple;
	bh=vcMNDE+hOT51Fh5tW0+/q5lQ+FknIWM2KMavnMOpM+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt3rjobmx00c7XfpbzH7y7Iv6Vv4viT2sX/MsCdJhMYFRMSSeBvOinY2m5w8VbatfP3nAVGa+PabXM+XWLgsdR7b4kVN1ZBLDzwlVFg4jX7CMAodUbqS9rEQArYSWX0fTXh0P/cGb8JhWJhHDmTxCV1ftqTUNxaqXMOG8FRNpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GX2gdHxK; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gMdkt0jNJz9v5j;
	Fri, 22 May 2026 23:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779485494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ga6yOivf1BItHTEhFihWVIi+//+QToeV8i2rNnNMJZo=;
	b=GX2gdHxKLfhlpD1ffSz3VUszrQGlD/AcTDi3plZ7JasBy9ZvSZwQuCKMeuN/HT9ra4XPN2
	Z9f8z74l3joXxpTL9s1SYHAI7ABGRs4zvrwv6cTo5zFqp0a1ru7akFT9u/cyU9KFkF9v5u
	9UOAJd61pX0PvKcZwTx5WO/BNdUC+nCkUa99gcj1ZZNrhsvhdPF9F28Xu+GXFiLnQAUeLo
	wqWRZuMIzv0fuxb4UnFgFpkVIgVVfz4jFWpABWUT1s4/RMqERHFOWKJCLxEAgxVbp8oqZ/
	83ldIrHRziBGe/ltHLuj1B/NkFWJ1CaUk4gQwCeKNZ2Rbv0ElLNU1XAOPPOMjg==
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Mike Galbraith <efault@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 6.12.y 2/3] sched/deadline: Fix dl_server getting stuck
Date: Fri, 22 May 2026 23:31:19 +0200
Message-ID: <20260522213120.1205100-3-lbckmnn@mailbox.org>
In-Reply-To: <20260522213120.1205100-1-lbckmnn@mailbox.org>
References: <20260522213120.1205100-1-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c71a87632b9704e5746
X-MBO-RS-META: gq1c5zginjropqhjymmbbxn5qtdspeeb
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmx.de,infradead.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253856-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: 5ED725BA7AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peter Zijlstra <peterz@infradead.org>

commit 4ae8d9aa9f9dc7137ea5e564d79c5aa5af1bc45c upstream.

John found it was easy to hit lockup warnings when running locktorture
on a 2 CPU VM, which he bisected down to: commit cccb45d7c429
("sched/deadline: Less agressive dl_server handling").

While debugging it seems there is a chance where we end up with the
dl_server dequeued, with dl_se->dl_server_active. This causes
dl_server_start() to return without enqueueing the dl_server, thus it
fails to run when RT tasks starve the cpu.

When this happens, dl_server_timer() catches the
'!dl_se->server_has_tasks(dl_se)' case, which then calls
replenish_dl_entity() and dl_server_stopped() and finally return
HRTIMER_NO_RESTART.

This ends in no new timer and also no enqueue, leaving the dl_server
'dead', allowing starvation.

What should have happened is for the bandwidth timer to start the
zero-laxity timer, which in turn would enqueue the dl_server and cause
dl_se->server_pick_task() to be called -- which will stop the
dl_server if no fair tasks are observed for a whole period.

IOW, it is totally irrelevant if there are fair tasks at the moment of
bandwidth refresh.

This removes all dl_se->server_has_tasks() users, so remove the whole
thing.

Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
Reported-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: John Stultz <jstultz@google.com>
[ adjust renamed variable in fair_server_has_tasks (which this patch
removes) ]
Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
---
 include/linux/sched.h   |  1 -
 kernel/sched/deadline.c | 12 +-----------
 kernel/sched/fair.c     |  7 +------
 kernel/sched/sched.h    |  4 ----
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 299a65a92d2e..464d281aa2e4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -701,7 +701,6 @@ struct sched_dl_entity {
 	 * runnable task.
 	 */
 	struct rq			*rq;
-	dl_server_has_tasks_f		server_has_tasks;
 	dl_server_pick_f		server_pick_task;
 
 #ifdef CONFIG_RT_MUTEXES
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9c5fa95b345a..7a2ea2183975 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -916,7 +916,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 */
 	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
 	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
-		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
+		if (!is_dl_boosted(dl_se)) {
 
 			/*
 			 * Set dl_se->dl_defer_armed and dl_throttled variables to
@@ -1201,8 +1201,6 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
 static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
 
-static bool dl_server_stopped(struct sched_dl_entity *dl_se);
-
 static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = rq_of_dl_se(dl_se);
@@ -1220,12 +1218,6 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 		if (!dl_se->dl_runtime)
 			return HRTIMER_NORESTART;
 
-		if (!dl_se->server_has_tasks(dl_se)) {
-			replenish_dl_entity(dl_se);
-			dl_server_stopped(dl_se);
-			return HRTIMER_NORESTART;
-		}
-
 		if (dl_se->dl_defer_armed) {
 			/*
 			 * First check if the server could consume runtime in background.
@@ -1891,11 +1883,9 @@ static bool dl_server_stopped(struct sched_dl_entity *dl_se)
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
-		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task)
 {
 	dl_se->rq = rq;
-	dl_se->server_has_tasks = has_tasks;
 	dl_se->server_pick_task = pick_task;
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d26e078d0623..f36512892adf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9058,11 +9058,6 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_stru
 	return pick_next_task_fair(rq, prev, NULL);
 }
 
-static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
-{
-	return !!dl_se->rq->cfs.nr_running;
-}
-
 static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
 {
 	return pick_task_fair(dl_se->rq);
@@ -9074,7 +9069,7 @@ void fair_server_init(struct rq *rq)
 
 	init_dl_entity(dl_se);
 
-	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_task);
+	dl_server_init(dl_se, rq, fair_server_pick_task);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a09e2d25edd5..9391ff62cdaa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -371,9 +371,6 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s6
  *
  *   dl_se::rq -- runqueue we belong to.
  *
- *   dl_se::server_has_tasks() -- used on bandwidth enforcement; we 'stop' the
- *                                server when it runs out of tasks to run.
- *
  *   dl_se::server_pick() -- nested pick_next_task(); we yield the period if this
  *                           returns NULL.
  *
@@ -389,7 +386,6 @@ extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
-		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task);
 
 extern void dl_server_update_idle_time(struct rq *rq,
-- 
2.54.0


