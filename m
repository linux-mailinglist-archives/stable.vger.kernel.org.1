Return-Path: <stable+bounces-213307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGjvIUpagmlhSwMAu9opvQ
	(envelope-from <stable+bounces-213307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:27:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD5DE7DB
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1148F308699E
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9617A36D4E5;
	Tue,  3 Feb 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPCMgS6e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561DF36D4E3
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150468; cv=none; b=bZQiBSHLQrN10DQVa2o2o6dq1L6ikKhh7BgcQGQqIFn4oWUFlOo0yHE2lzdd3ECiexb33o295YsMKT0jlu5Y34e42FYsprLUQSK698J7uofWmfmCOIhtAWOleZSnhykak6kRfuJDF8RHmaQbWuqhCmUdebno9szpF/0Q7olTqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150468; c=relaxed/simple;
	bh=qhMSAoRuN7Mm85tjV3mFC0jHQ8on/jR9CbTFobbsFaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsH0nXHiqzoVx0t9mMLgcYmXawkuJQuQGEu8qrHf3bEErLL2w24j0DOEn6BDBenLI5KPhn9386+hzYM3R4CTlnNHUgNMqPU3PCzVGrPC2bKFwlam/i4ps7UxBkT4TBOgfhihBf8tV0t50vPY+ew2LbZnnd7x0XKMpZs6sKi/84s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPCMgS6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62415C19422;
	Tue,  3 Feb 2026 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770150468;
	bh=qhMSAoRuN7Mm85tjV3mFC0jHQ8on/jR9CbTFobbsFaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPCMgS6eDDCb9t5rb+kTw+w/z9dzEQ/RiXH4lQFvTuFLsMJ8RoDVtHN0ZQ9VZWLl0
	 TfKjQDuvkxHW87UoLFDwEVV4NTBcW9GsSFX5qlN4yHliXY9Et9gE2nILj+tAnuLWd+
	 P5BSoLKZwXOSNjIPLTlbn8kCg1Xj700S5b9uRM/cf20v6PgPMxoxGnB1nKWRAS1Irj
	 aIQzj19+H5qM8pIgL5lKoq1VpMWelbmthhttVcpxGQ8Nbp1TAmIVQ6xkM1sHCM9sdR
	 OBCeBQQvgRuq9sXzgYivYErIDspRRsiib5AV4+SGb6ZisDA43HAidj/MA1+CBtukgt
	 ggaxK52anroLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Guenter Roeck <linux@roeck-us.net>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] perf: sched: Fix perf crash with new is_user_task() helper
Date: Tue,  3 Feb 2026 15:27:45 -0500
Message-ID: <20260203202745.1391918-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020314-bazooka-gauntlet-ce30@gregkh>
References: <2026020314-bazooka-gauntlet-ce30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213307-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,roeck-us.net:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EAD5DE7DB
X-Rspamd-Action: no action

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 76ed27608f7dd235b727ebbb12163438c2fbb617 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h     | 5 +++++
 kernel/events/callchain.c | 2 +-
 kernel/events/core.c      | 6 +++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9559501236af0..9c7c67efce346 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1800,6 +1800,11 @@ static __always_inline bool is_percpu_thread(void)
 #endif
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
index ee01cfcc35064..0bd9cb625111b 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -206,7 +206,7 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
-			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+			if (!is_user_task(current))
 				regs = NULL;
 			else
 				regs = task_pt_regs(current);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9a3fb6fdb2f6..9a6be06176bb4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6985,7 +6985,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+	} else if (is_user_task(current)) {
 		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
@@ -7612,7 +7612,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+		if (is_user_task(current)) {
 			struct page *p;
 
 			pagefault_disable();
@@ -7725,7 +7725,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
 	bool user   = !event->attr.exclude_callchain_user &&
-		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
+		is_user_task(current);
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
-- 
2.51.0


