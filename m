Return-Path: <stable+bounces-212918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC4iBLUsfWmYQgIAu9opvQ
	(envelope-from <stable+bounces-212918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 23:12:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D635BF0A7
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 23:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 358513012C55
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 22:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C837F738;
	Fri, 30 Jan 2026 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2lLwCJuD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7O9jDY4s"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D22155757;
	Fri, 30 Jan 2026 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811119; cv=none; b=NCPp5YLdfY8OGPiHXiYxFoDBFXKE4MC1N+Of2OwK62GZ+icd/iZpaazdedELADPf1lx4saG/yQfen+5lLAJudTk/+NLpMtuDaYcV4PCOPmKAN8NWWqZntUdOvXqpPrhoR/TBV3scS2gTEUhbne5z9MB7b6JWsAnTqpOIH5TNTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811119; c=relaxed/simple;
	bh=331GDWlK9opFl6puEIjQ1O+p808+RqqqgANR0ooSlgo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hkXDh3NZAKbzEmI0O5xoVZM4ogfBZrEEwbw2rsKzGtAhxQinmCI56/Ha4IHPmZOxHLFOk9+azYvPj13tVrEjAPpeR1Cl2xswf4uAXktgRrYAWWUhUVWMeHoYgDBjDzdEbBOHSurdrz4r9CWp1w+0c60Dy04ilatprnOFUkJyo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2lLwCJuD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7O9jDY4s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 22:11:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769811116;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEjHSkuExPun8eMncOcQnDc/DmWjBdF0RVlL6mI6Y2E=;
	b=2lLwCJuD15Om1AsP4acm4XhmXGPfUzBavegXC97tABVedi/oEEti7A483zhsESvqnXCvij
	ZKCJDExR9YBjw55NclRYBOr1XIgfwFfFjEoFQ0GCKgXRKSNOg+wYvCfZq3gN5x5bpKvDcf
	y3RJruRb5ON3In1oQsldKRwx8CA88aZQtVPzEF0J+I6SuxRPEOCnbLHpGNJJORZGQS5xIg
	YVGZ+kSPTgJC84ZKKy6O7KdCZofBRLu099UZncWlSwW8SaaXBDNdJ1hvdO4iFDYBBt3r7O
	Tu0mxI2lY7P2Ew/9IMCc7cvINyeNsg8BQWzvWBWcavjPA/1U0xDPKLU+EPgqBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769811116;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEjHSkuExPun8eMncOcQnDc/DmWjBdF0RVlL6mI6Y2E=;
	b=7O9jDY4s5k9lbVr2SwT3XHOkcTdEHLZET6IQjeBryenXX5DS+dTkOijXYqdvKRNzcCiKn8
	imSFn/b0nTW0giCg==
From: "tip-bot2 for Steven Rostedt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf: sched: Fix perf crash with new is_user_task() helper
Cc: Guenter Roeck <linux@roeck-us.net>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260129102821.46484722@gandalf.local.home>
References: <20260129102821.46484722@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176981111509.2495410.12577775645614090252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212918-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:replyto,goodmis.org:email,infradead.org:email,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D635BF0A7
X-Rspamd-Action: no action

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     76ed27608f7dd235b727ebbb12163438c2fbb617
Gitweb:        https://git.kernel.org/tip/76ed27608f7dd235b727ebbb12163438c2f=
bb617
Author:        Steven Rostedt <rostedt@goodmis.org>
AuthorDate:    Thu, 29 Jan 2026 10:28:21 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 30 Jan 2026 23:06:07 +01:00

perf: sched: Fix perf crash with new is_user_task() helper

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

Fixes: 90942f9fac05 ("perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER in=
stead of current->mm =3D=3D NULL")
Closes: https://lore.kernel.org/all/0d877e6f-41a7-4724-875d-0b0a27b8a545@roec=
k-us.net/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260129102821.46484722@gandalf.local.home
---
 include/linux/sched.h     | 5 +++++
 kernel/events/callchain.c | 2 +-
 kernel/events/core.c      | 6 +++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index da01335..5f00b5e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1776,6 +1776,11 @@ static __always_inline bool is_percpu_thread(void)
 		(current->nr_cpus_allowed  =3D=3D 1);
 }
=20
+static __always_inline bool is_user_task(struct task_struct *task)
+{
+	return task->mm && !(task->flags & (PF_KTHREAD | PF_USER_WORKER));
+}
+
 /* Per-process atomic flags. */
 #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
 #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1f65895..9d24b6e 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,7 +246,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, boo=
l user,
=20
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
-			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+			if (!is_user_task(current))
 				goto exit_put;
 			regs =3D task_pt_regs(current);
 		}
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a0fa488..8cca800 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7460,7 +7460,7 @@ static void perf_sample_regs_user(struct perf_regs *reg=
s_user,
 	if (user_mode(regs)) {
 		regs_user->abi =3D perf_reg_abi(current);
 		regs_user->regs =3D regs;
-	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+	} else if (is_user_task(current)) {
 		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi =3D PERF_SAMPLE_REGS_ABI_NONE;
@@ -8100,7 +8100,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+		if (is_user_task(current)) {
 			struct page *p;
=20
 			pagefault_disable();
@@ -8215,7 +8215,7 @@ perf_callchain(struct perf_event *event, struct pt_regs=
 *regs)
 {
 	bool kernel =3D !event->attr.exclude_callchain_kernel;
 	bool user   =3D !event->attr.exclude_callchain_user &&
-		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
+		is_user_task(current);
 	/* Disallow cross-task user callchains. */
 	bool crosstask =3D event->ctx->task && event->ctx->task !=3D current;
 	bool defer_user =3D IS_ENABLED(CONFIG_UNWIND_USER) && user &&

