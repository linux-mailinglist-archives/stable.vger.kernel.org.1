Return-Path: <stable+bounces-256491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA0vGZwVGWr+qAgAu9opvQ
	(envelope-from <stable+bounces-256491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:27:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F6D5FCF55
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02C5430427FE
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 04:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BFA372062;
	Fri, 29 May 2026 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hFFSHlHc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D6371D0F;
	Fri, 29 May 2026 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780028743; cv=none; b=CmGWmg7BINA7PVPjUCkVYrPDvKbAAdw2GLYjeP+eoFz7bzQI+UWqDTWBECnh6H3+hm2J8coJGVw0oD4kcTeQXDBTnrcriaE0j3XMeXE3RYB5X5Mt98WP3EeHgdZt/Apo0uITGyeYgLUAmnnY+x/GznGq63c9fDD1riy7lFLhmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780028743; c=relaxed/simple;
	bh=RsWB7qlkk7HZXkAzkkoObVal23tEbuaELqWlQVDXU5w=;
	h=Date:To:From:Subject:Message-Id; b=u0kAvPDnINnjtRQUL+VR6Cvu0SImw9eLkb9mgWf8E2Z0vSjjH/C+LR0Cx7zo3yWvcOqLDJsfcwk7voJcnT0ulimxrC7nLOBxJTRrcKVwZlOUYrj865ZIZiCGLAqgVnCq4akP9KCc7qJV+AvMmqT0/TL0CpmM0VJXwBs3lTdZAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hFFSHlHc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBC61F00893;
	Fri, 29 May 2026 04:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780028741;
	bh=/ldqS4psVspjISEGcqHskwgpyjuOS96psTICtTzgGs0=;
	h=Date:To:From:Subject;
	b=hFFSHlHc8KjXadZ1nwf/MDllLyiZRbtBTGnneQQbnCE/D470o4/baAz+QOXu8hy5a
	 4dUHt5gNHgf6Xz7B9Zz01d8XmUDif4wiGj09MqaBHrEwke2x2m1lTzQY8/P9XiXQTU
	 jX1iQ2lqXt58IiI0CfCB7hTgzXxQYc3jJ9hgL7/M=
Date: Thu, 28 May 2026 21:25:40 -0700
To: mm-commits@vger.kernel.org,yang.yang29@zte.com.cn,wang.yaxin@zte.com.cn,thomas.orgis@uni-hamburg.de,stable@vger.kernel.org,oleg@redhat.com,balbirs@nvidia.com,cyyzero16@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-nonmm-stable] taskstats-retain-dead-thread-stats-in-tgid-queries.patch removed from -mm tree
Message-Id: <20260529042541.5FBC61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256491-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,zte.com.cn,uni-hamburg.de,redhat.com,nvidia.com,gmail.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linux-foundation.org:dkim,zte.com.cn:email,smtp.kernel.org:mid,nvidia.com:email]
X-Rspamd-Queue-Id: B4F6D5FCF55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: taskstats: retain dead thread stats in TGID queries
has been removed from the -mm tree.  Its filename was
     taskstats-retain-dead-thread-stats-in-tgid-queries.patch

This patch was dropped because it was merged into the mm-nonmm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Yiyang Chen <cyyzero16@gmail.com>
Subject: taskstats: retain dead thread stats in TGID queries
Date: Mon, 13 Apr 2026 23:45:44 +0800

Patch series "taskstats: fix TGID dead-thread stat retention", v3.

This series fixes a taskstats TGID aggregation bug where fields added in
the TGID query path were not preserved after thread exit, and adds a
kselftest covering the regression.

The first patch keeps the cached TGID aggregate used for dead threads in
step with the fields already accumulated for live threads, and also fixes
the final TGID exit notification emitted when group_dead is true.

The second patch adds a kselftest that verifies TGID CPU stats do not
regress after a worker thread exits and has been reaped.


This patch (of 2):

fill_stats_for_tgid() builds TGID stats from two sources: the cached
aggregate in signal->stats and a scan of the live threads in the group.

However, fill_tgid_exit() only accumulates delay accounting into
signal->stats.  This means that once a thread exits, TGID queries lose the
fields that fill_stats_for_tgid() adds for live threads.

This gap was introduced incrementally by two earlier changes that extended
fill_stats_for_tgid() but did not make the corresponding update to
fill_tgid_exit():

- commit 8c733420bdd5 ("taskstats: add e/u/stime for TGID command")
  added ac_etime, ac_utime, and ac_stime to the TGID query path.
- commit b663a79c1915 ("taskstats: add context-switch counters")
  added nvcsw and nivcsw to the TGID query path.

As a result, those fields were accounted for live threads in TGID queries,
but were dropped from the cached TGID aggregate after thread exit.  The
final TGID exit notification emitted when group_dead is true also copies
that cached aggregate, so it loses the same fields.

Factor the per-task TGID accumulation into tgid_stats_add_task() and use
it in both fill_stats_for_tgid() and fill_tgid_exit().  This keeps the
cached aggregate used for dead threads aligned with the live-thread
accumulation used by TGID queries.

Link: https://lore.kernel.org/cover.1776094300.git.cyyzero16@gmail.com
Link: https://lore.kernel.org/abd2a15d33343636ab5ba43d540bcfe508bd66c7.1776094300.git.cyyzero16@gmail.com
Fixes: 8c733420bdd5 ("taskstats: add e/u/stime for TGID command")
Fixes: b663a79c1915 ("taskstats: add context-switch counters")
Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Cc: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/taskstats.c |   62 ++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

--- a/kernel/taskstats.c~taskstats-retain-dead-thread-stats-in-tgid-queries
+++ a/kernel/taskstats.c
@@ -210,13 +210,39 @@ static int fill_stats_for_pid(pid_t pid,
 	return 0;
 }
 
+static void tgid_stats_add_task(struct taskstats *stats,
+				struct task_struct *tsk, u64 now_ns)
+{
+	u64 delta, utime, stime;
+
+	/*
+	 * Each accounting subsystem calls its functions here to
+	 * accumulate its per-task stats for tsk, into the per-tgid structure
+	 *
+	 *	per-task-foo(stats, tsk);
+	 */
+	delayacct_add_tsk(stats, tsk);
+
+	/* calculate task elapsed time in nsec */
+	delta = now_ns - tsk->start_time;
+	/* Convert to micro seconds */
+	do_div(delta, NSEC_PER_USEC);
+	stats->ac_etime += delta;
+
+	task_cputime(tsk, &utime, &stime);
+	stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
+	stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
+
+	stats->nvcsw += tsk->nvcsw;
+	stats->nivcsw += tsk->nivcsw;
+}
+
 static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 {
 	struct task_struct *tsk, *first;
 	unsigned long flags;
 	int rc = -ESRCH;
-	u64 delta, utime, stime;
-	u64 start_time;
+	u64 now_ns;
 
 	/*
 	 * Add additional stats from live tasks except zombie thread group
@@ -233,30 +259,12 @@ static int fill_stats_for_tgid(pid_t tgi
 	else
 		memset(stats, 0, sizeof(*stats));
 
-	start_time = ktime_get_ns();
+	now_ns = ktime_get_ns();
 	for_each_thread(first, tsk) {
 		if (tsk->exit_state)
 			continue;
-		/*
-		 * Accounting subsystem can call its functions here to
-		 * fill in relevant parts of struct taskstsats as follows
-		 *
-		 *	per-task-foo(stats, tsk);
-		 */
-		delayacct_add_tsk(stats, tsk);
-
-		/* calculate task elapsed time in nsec */
-		delta = start_time - tsk->start_time;
-		/* Convert to micro seconds */
-		do_div(delta, NSEC_PER_USEC);
-		stats->ac_etime += delta;
-
-		task_cputime(tsk, &utime, &stime);
-		stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
-		stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
 
-		stats->nvcsw += tsk->nvcsw;
-		stats->nivcsw += tsk->nivcsw;
+		tgid_stats_add_task(stats, tsk, now_ns);
 	}
 
 	unlock_task_sighand(first, &flags);
@@ -275,18 +283,14 @@ out:
 static void fill_tgid_exit(struct task_struct *tsk)
 {
 	unsigned long flags;
+	u64 now_ns;
 
 	spin_lock_irqsave(&tsk->sighand->siglock, flags);
 	if (!tsk->signal->stats)
 		goto ret;
 
-	/*
-	 * Each accounting subsystem calls its functions here to
-	 * accumalate its per-task stats for tsk, into the per-tgid structure
-	 *
-	 *	per-task-foo(tsk->signal->stats, tsk);
-	 */
-	delayacct_add_tsk(tsk->signal->stats, tsk);
+	now_ns = ktime_get_ns();
+	tgid_stats_add_task(tsk->signal->stats, tsk, now_ns);
 ret:
 	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 	return;
_

Patches currently in -mm which might be from cyyzero16@gmail.com are



