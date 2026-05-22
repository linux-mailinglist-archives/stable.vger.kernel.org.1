Return-Path: <stable+bounces-253858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAEKObfLEGpAdwYAu9opvQ
	(envelope-from <stable+bounces-253858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:33:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248E5BA7B1
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C254430160DB
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9C638BF61;
	Fri, 22 May 2026 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c7bAQ9Cb"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547A38A299
	for <stable@vger.kernel.org>; Fri, 22 May 2026 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485501; cv=none; b=CfGixmKG/7cbgeFNPi4uLXiwVGA3WAWE8x2lDs5WDhbpSVd22wWBmQIxxNu/iu8OdlzdgWxzr20XOkuL3G6xL5D/3KJtzKb8yaM4ZnKpYMAxVG4/k3gBNFcLVqKAXgL3dDUx0egB1Gvn2g8Z3P0rhH+vGfdnIBVbklRMB3jFtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485501; c=relaxed/simple;
	bh=HAzsPcDEV+uv9UvnsU30a8VkkAPRZ6f5rf5HBQz7dcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKJpOlc7TDREsaUE6ZP8pSZ7ZH6r6G0Gub1laV6p3OqF9tR2wDRwGripRe4Qm0cSE4rzc+QTcCtyIYs0utNtNugt83ssAIq7OZbS5t7Nneztc411qh/Oj8jYnlXRfMiRrIhKsrYSv+d14XHJ9gteQsil8tjRxBSu+08dd269D1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=c7bAQ9Cb; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gMdkw0hwQz9try;
	Fri, 22 May 2026 23:31:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779485496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fdnfm8bzB6Poz/dqMRz+MdKQsAsypfBQnLKlr2qHi+s=;
	b=c7bAQ9Cb7PeAVzp6prMrNQ45AK6uAfKJgvJbUKwAXipr92NvCTDbVmOzsphejwx7ztKHcW
	ys4pEfphNIbwj2lpaG9uzofX5nFA535jGBYsL5O1p8P4SdusHEz9SM/qQwsQCuxbRL4EWx
	aqH6cD8EQjG16JKZX8UctwLz8t07It58/G19Rgo5pL6soy4rKw76F1FyNpq6BMjxfkttmv
	ISHLJ+D0+oJaoNz0/KbmGNOiYIpXqhWkVU2XVNhR41uL095iEad/LtxLvm8iaOs9DULWAB
	15tzAXUIbulRrRlp3DncfEne0OYfd6GVvi+l5KRcRYbo5zhPVdrQT7JCp27UdA==
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Mike Galbraith <efault@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 6.12.y 3/3] sched/deadline: Fix dl_server behaviour
Date: Fri, 22 May 2026 23:31:20 +0200
Message-ID: <20260522213120.1205100-4-lbckmnn@mailbox.org>
In-Reply-To: <20260522213120.1205100-1-lbckmnn@mailbox.org>
References: <20260522213120.1205100-1-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4s3etycwry9hxhocttsnqwwbqeidnkj3
X-MBO-RS-ID: 0fd10756926be2ffc84
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmx.de,infradead.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253858-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: 6248E5BA7B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peter Zijlstra <peterz@infradead.org>

commit a3a70caf7906708bf9bbc80018752a6b36543808 upstream.

John reported undesirable behaviour with the dl_server since commit:
cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling").

When starving fair tasks on purpose (starting spinning FIFO tasks),
his fair workload, which often goes (briefly) idle, would delay fair
invocations for a second, running one invocation per second was both
unexpected and terribly slow.

The reason this happens is that when dl_se->server_pick_task() returns
NULL, indicating no runnable tasks, it would yield, pushing any later
jobs out a whole period (1 second).

Instead simply stop the server. This should restore behaviour in that
a later wakeup (which restarts the server) will be able to continue
running (subject to the CBS wakeup rules).

Notably, this does not re-introduce the behaviour cccb45d7c4295 set
out to solve, any start/stop cycle is naturally throttled by the timer
period (no active cancel).

Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
Reported-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: John Stultz <jstultz@google.com>
[ adjust dl_server_stopped (which this patch removes) ]
Closes: https://lore.kernel.org/regressions/04657838-46d1-432d-95e1-eb73b930b032@mailbox.org
Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
---
 include/linux/sched.h   |  1 -
 kernel/sched/deadline.c | 23 ++---------------------
 kernel/sched/sched.h    | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 464d281aa2e4..f9ffe42cae17 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -674,7 +674,6 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
-	unsigned int			dl_server_idle    : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7a2ea2183975..a6c699e43111 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1621,10 +1621,8 @@ void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime = fair server disabled */
-	if (dl_se->dl_runtime) {
-		dl_se->dl_server_idle = 0;
+	if (dl_se->dl_runtime)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
-	}
 }
 
 /*
@@ -1868,20 +1866,6 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	dl_se->dl_server_active = 0;
 }
 
-static bool dl_server_stopped(struct sched_dl_entity *dl_se)
-{
-	if (!dl_se->dl_server_active)
-		return false;
-
-	if (dl_se->dl_server_idle) {
-		dl_server_stop(dl_se);
-		return true;
-	}
-
-	dl_se->dl_server_idle = 1;
-	return false;
-}
-
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_pick_f pick_task)
 {
@@ -2637,10 +2621,7 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	if (dl_server(dl_se)) {
 		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
-			if (!dl_server_stopped(dl_se)) {
-				dl_se->dl_yielded = 1;
-				update_curr_dl_se(rq, dl_se, 0);
-			}
+			dl_server_stop(dl_se);
 			goto again;
 		}
 		rq->dl_server = dl_se;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9391ff62cdaa..7956abeb9154 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -377,10 +377,39 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s6
  *   dl_server_update() -- called from update_curr_common(), propagates runtime
  *                         to the server.
  *
- *   dl_server_start()
- *   dl_server_stop()  -- start/stop the server when it has (no) tasks.
+ *   dl_server_start() -- start the server when it has tasks; it will stop
+ *			  automatically when there are no more tasks, per
+ *			  dl_se::server_pick() returning NULL.
+ *
+ *   dl_server_stop() -- (force) stop the server; use when updating
+ *                       parameters.
  *
  *   dl_server_init() -- initializes the server.
+ *
+ * When started the dl_server will (per dl_defer) schedule a timer for its
+ * zero-laxity point -- that is, unlike regular EDF tasks which run ASAP, a
+ * server will run at the very end of its period.
+ *
+ * This is done such that any runtime from the target class can be accounted
+ * against the server -- through dl_server_update() above -- such that when it
+ * becomes time to run, it might already be out of runtime and get deferred
+ * until the next period. In this case dl_server_timer() will alternate
+ * between defer and replenish but never actually enqueue the server.
+ *
+ * Only when the target class does not manage to exhaust the server's runtime
+ * (there's actualy starvation in the given period), will the dl_server get on
+ * the runqueue. Once queued it will pick tasks from the target class and run
+ * them until either its runtime is exhaused, at which point its back to
+ * dl_server_timer, or until there are no more tasks to run, at which point
+ * the dl_server stops itself.
+ *
+ * By stopping at this point the dl_server retains bandwidth, which, if a new
+ * task wakes up imminently (starting the server again), can be used --
+ * subject to CBS wakeup rules -- without having to wait for the next period.
+ *
+ * Additionally, because of the dl_defer behaviour the start/stop behaviour is
+ * naturally thottled to once per period, avoiding high context switch
+ * workloads from spamming the hrtimer program/cancel paths.
  */
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);
-- 
2.54.0


