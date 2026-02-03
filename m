Return-Path: <stable+bounces-213206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAKoOTzugWlAMwMAu9opvQ
	(envelope-from <stable+bounces-213206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:46:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 057FED9414
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AC283013781
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F53344D8F;
	Tue,  3 Feb 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RyZFjEy0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD81C69D
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122605; cv=none; b=qMIFZ8FMcg/4rbJPw4gfaINT6fmLCxXHzHDQ4jaa7pNSyljQgUROZhjtXANUbIM3JFO6F4qpLHI8w93p3LoDv1pSqdGJQ5PUByz4R2XqYwKAJddhAD7xmgofLMo+6s4lidOTsuFJ2uRt2f9v1Lq5IVqur5K6wYPIthjdVrH6E5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122605; c=relaxed/simple;
	bh=ia+BHuQqHJUmVnJ9TD9huvjKcSk+yArOm/vevUwdIkM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F0Z6OKQdJ9WNhYB8zVSG69qgnjLOBCmR2YBEQtupNDrGfeLTCeZIEBMr0+PGtOqgzXqwldemE/U0uoC7SKZYtbE1poo/9aqWwDIIPqQX16k4ylTrIEeDp5l+mP3w/8etsqS76w75KPA0XL9cI6xoOWqU/DLiVq0BWndJB2p79IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RyZFjEy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F078FC116D0;
	Tue,  3 Feb 2026 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770122605;
	bh=ia+BHuQqHJUmVnJ9TD9huvjKcSk+yArOm/vevUwdIkM=;
	h=Subject:To:Cc:From:Date:From;
	b=RyZFjEy0knY0AJaFMnoJn5q+I7WRqcQcdXjOCMELxOazdxZ2+k1GED7w6BVh9EYfb
	 dGqB+HJLEjKCeGFEi87TC4R+gWOXSA3p9iFr5yenauYw/3KbiNRAY//dFzC23blWRT
	 aPLzxg1QcHxQ54qV1dOwjT/amIyh8nRTMKBg35Os=
Subject: FAILED: patch "[PATCH] perf: sched: Fix perf crash with new is_user_task() helper" failed to apply to 6.6-stable tree
To: rostedt@goodmis.org,linux@roeck-us.net,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 13:43:14 +0100
Message-ID: <2026020314-bazooka-gauntlet-ce30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213206-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: 057FED9414
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 76ed27608f7dd235b727ebbb12163438c2fbb617
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020314-bazooka-gauntlet-ce30@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76ed27608f7dd235b727ebbb12163438c2fbb617 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 29 Jan 2026 10:28:21 -0500
Subject: [PATCH] perf: sched: Fix perf crash with new is_user_task() helper

In order to do a user space stacktrace the current task needs to be a user
task that has executed in user space. It use to be possible to test if a
task is a user task or not by simply checking the task_struct mm field. If
it was non NULL, it was a user task and if not it was a kernel task.

But things have changed over time, and some kernel tasks now have their
own mm field.

An idea was made to instead test PF_KTHREAD and two functions were used to
wrap this check in case it became more complex to test if a task was a
user task or not[1]. But this was rejected and the C code simply checked
the PF_KTHREAD directly.

It was later found that not all kernel threads set PF_KTHREAD. The io-uring
helpers instead set PF_USER_WORKER and this needed to be added as well.

But checking the flags is still not enough. There's a very small window
when a task exits that it frees its mm field and it is set back to NULL.
If perf were to trigger at this moment, the flags test would say its a
user space task but when perf would read the mm field it would crash with
at NULL pointer dereference.

Now there are flags that can be used to test if a task is exiting, but
they are set in areas that perf may still want to profile the user space
task (to see where it exited). The only real test is to check both the
flags and the mm field.

Instead of making this modification in every location, create a new
is_user_task() helper function that does all the tests needed to know if
it is safe to read the user space memory or not.

[1] https://lore.kernel.org/all/20250425204120.639530125@goodmis.org/

Fixes: 90942f9fac05 ("perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL")
Closes: https://lore.kernel.org/all/0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260129102821.46484722@gandalf.local.home

diff --git a/include/linux/sched.h b/include/linux/sched.h
index da0133524d08..5f00b5ed0f3b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1776,6 +1776,11 @@ static __always_inline bool is_percpu_thread(void)
 		(current->nr_cpus_allowed  == 1);
 }
 
+static __always_inline bool is_user_task(struct task_struct *task)
+{
+	return task->mm && !(task->flags & (PF_KTHREAD | PF_USER_WORKER));
+}
+
 /* Per-process atomic flags. */
 #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
 #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1f6589578703..9d24b6e0c91f 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,7 +246,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
-			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+			if (!is_user_task(current))
 				goto exit_put;
 			regs = task_pt_regs(current);
 		}
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a0fa488bce84..8cca80094624 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7460,7 +7460,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+	} else if (is_user_task(current)) {
 		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
@@ -8100,7 +8100,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+		if (is_user_task(current)) {
 			struct page *p;
 
 			pagefault_disable();
@@ -8215,7 +8215,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
 	bool user   = !event->attr.exclude_callchain_user &&
-		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
+		is_user_task(current);
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&


