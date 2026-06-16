Return-Path: <stable+bounces-263761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FVNQDIlcMWpSiAUAu9opvQ
	(envelope-from <stable+bounces-263761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:24:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE969070A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=jxTC35Rg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263761-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263761-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1AA33093EE1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0B36403D;
	Tue, 16 Jun 2026 14:16:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353E3368A7
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 14:16:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619410; cv=none; b=gKJ4ksespIC6mIi/NppspEE9OwzZkf3n+GOMgkCda99NucC7U8hVAcswfrtEQc40gWsSJgUCSduou4bZJEcNNXQvsf2f5bw/x+HMpFt4Hwu8eYvueWZaQd/b3AjZFt2rioa38tLJQx4j0cvxNWT1v3xClmgBLyqh5bkqChkDX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619410; c=relaxed/simple;
	bh=o7bdVEsbt6KGhe9AJO7W7f3l30ifqiWb4W+Pvo6TkC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+hz4P0kc/k+NPT+zYNFfrJshXB+oHynq7h1skq+bWW5krVjssvYcaXHHLEaNzVhFx0g1LnXdkbQ9uPbInxyUBNhd0RPwbZZI2vb9GuCbNTH722MKgV6u9mQOG92sWKb7PBJat1zlMFGbdN7bbz0ns1gilXFU819s7Adt/P6jJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jxTC35Rg; arc=none smtp.client-ip=95.215.58.181
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781619397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZN8C+9GRlvXNc1Ra52cny7qtJJM6e8aPGn6zNCjDFHI=;
	b=jxTC35RgtFx1z86cthtWkocpazcQLXzUOYgQ62gYPVPEK2MhctnL1RvS1OWvfXcgo8J9Pu
	n4PMCDAx5qfYZJzl2+cLg3eUGpMYReCywXVzdQTsRuiuM1Estu65IgUkX0O7y4CLxQLJIn
	my5kcbkjkz5ov6hGyVVwcjc3IYuEDA4=
From: Usama Arif <usama.arif@linux.dev>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Cc: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] block: invalidate cached plug timestamp after task switch
Date: Tue, 16 Jun 2026 07:15:18 -0700
Message-ID: <20260616141604.328820-3-usama.arif@linux.dev>
In-Reply-To: <20260616141604.328820-1-usama.arif@linux.dev>
References: <20260616141604.328820-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263761-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:bsegall@google.com,m:dietmar.eggemann@arm.com,m:juri.lelli@redhat.com,m:kprateek.nayak@amd.com,m:linux-kernel@vger.kernel.org,m:mgorman@suse.de,m:mingo@redhat.com,m:peterz@infradead.org,m:rostedt@goodmis.org,m:vincent.guittot@linaro.org,m:vschneid@redhat.com,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:riel@surriel.com,m:kernel-team@meta.com,m:usama.arif@linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EAE969070A

blk_time_get_ns() caches ktime_get_ns() in current->plug->cur_ktime
and marks the task with PF_BLOCK_TS. That cache is only valid while the
task keeps running; if the task is switched out, wall-clock time
advances and the cached value must not be reused when the task runs again.

The existing invalidation covers explicit plug flushes through
__blk_flush_plug(), and the schedule() / rtmutex paths through
sched_update_worker(). It does not cover in-kernel preemption paths such
as preempt_schedule(), preempt_schedule_notrace(), and
preempt_schedule_irq(), which enter __schedule(SM_PREEMPT) directly and
return without calling sched_update_worker().

As a result, a task preempted while holding a plug with PF_BLOCK_TS set
can reuse a stale plug->cur_ktime after it is scheduled back in. blk-iocost
then consumes that stale timestamp through ioc_now(), producing stale vnow
values for throttle decisions, and through ioc_rqos_done(), inflating
on-queue time and feeding false missed-QoS samples into vrate
adjustment.

Move the schedule-side invalidation to finish_task_switch(), which runs
for the scheduled-in task after every actual context switch regardless
of which schedule entry point was used. Keep __blk_flush_plug() as the
explicit flush/finish-plug invalidation path, and remove only the
PF_BLOCK_TS handling from sched_update_worker().

Fixes: 06b23f92af87 ("block: update cached timestamp post schedule/preemption")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/blkdev.h | 16 ++++++----------
 kernel/sched/core.c    | 12 ++++++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 57e84d59a642..c285a4d9837d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1216,16 +1216,12 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 		__blk_flush_plug(plug, async);
 }
 
-/*
- * tsk == current here
- */
-static inline void blk_plug_invalidate_ts(struct task_struct *tsk)
+static __always_inline void blk_plug_invalidate_ts(void)
 {
-	struct blk_plug *plug = tsk->plug;
-
-	if (plug)
-		plug->cur_ktime = 0;
-	current->flags &= ~PF_BLOCK_TS;
+	if (unlikely(current->flags & PF_BLOCK_TS)) {
+		current->plug->cur_ktime = 0;
+		current->flags &= ~PF_BLOCK_TS;
+	}
 }
 
 int blkdev_issue_flush(struct block_device *bdev);
@@ -1251,7 +1247,7 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 {
 }
 
-static inline void blk_plug_invalidate_ts(struct task_struct *tsk)
+static inline void blk_plug_invalidate_ts(void)
 {
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8b791e9e9f67..e97e98c33be5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5368,6 +5368,12 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 */
 	kmap_local_sched_in();
 
+	/*
+	 * Any cached block-layer timestamp (plug->cur_ktime) is stale now,
+	 * invalidate it.
+	 */
+	blk_plug_invalidate_ts();
+
 	fire_sched_in_preempt_notifiers(current);
 	/*
 	 * When switching through a kernel thread, the loop in
@@ -7290,12 +7296,10 @@ static inline void sched_submit_work(struct task_struct *tsk)
 
 static void sched_update_worker(struct task_struct *tsk)
 {
-	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_BLOCK_TS)) {
-		if (tsk->flags & PF_BLOCK_TS)
-			blk_plug_invalidate_ts(tsk);
+	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
-		else if (tsk->flags & PF_IO_WORKER)
+		else
 			io_wq_worker_running(tsk);
 	}
 }
-- 
2.53.0-Meta


