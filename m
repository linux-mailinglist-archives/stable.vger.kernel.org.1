Return-Path: <stable+bounces-123225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB4A5C3A0
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB65316BC18
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1325BAAA;
	Tue, 11 Mar 2025 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="FqUZnOD1"
X-Original-To: stable@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8A1917E3
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702649; cv=none; b=Yqk9oQiHm6rhmUK4AI6DmpDkCDBrHi/GFfK3IjjJPOhjznP+Zvu2Y44MM/wRZAt3aRsc7o/+dpy0sDhj9T9gEzcsQSEMZ+/cpLtc8GeHYLk55qN9nsAbazPR3m6JmOEHjzSI4fmDl9DOdL+P42nWVtmFRv+mNOzC7NoOh9pdEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702649; c=relaxed/simple;
	bh=zuVi/E1Al6TUmc/+jkkv6LNyuS+TtK/JPKUr/5q7Lmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibJbXvg5PL7umXiPJDovIIZajoW598+d5z1mxlUq3I2fA4ZuojClV/ay5svGH3CxGFQGvMXWPQkxa6n2j5aSzLc+qxQM6EO3r/78Nd1HJapsI20e0C8ZqHoNDJ6ArZ2GaKgIpTLI47A49q3hdGvprPgBdFNjGLHSoGLR1AFbRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=FqUZnOD1; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250311140717a5f3b724c1e267d663
        for <stable@vger.kernel.org>;
        Tue, 11 Mar 2025 15:07:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=W7gdTvCCbDeK3IYfYXUgbt4+QqIUYRanJjLcRGdDaGM=;
 b=FqUZnOD19JNRvztWfWX4fNsOIeGHvkLNDFvhMuUsFZdA4HJOT8ed7nV4n8k2XSXSE/UeY3
 XBN0MOgVtQAnCWf2y4JFOow+qjrzPyDk7oh+iXRDgJvlMqLMN4F1d32OKrzSF29jAXKbEnrw
 rmNDjoDXENRajJyx8mJPHztSFon5AWjBsbMqZ+rrMHxmUbabNf9LSqoBMIRJtqd986ep4Jxk
 edu67kdMlFI+j7JwtQ1iTpUW3VrxmiCiii2AKnQaQY4cRQec2NXc3b6x9oYkXYmywVxn77FX
 +WJrAGjy9tuWYV5ZDrO8I+QXbeIW8vjgdZrfAOefwPIa+tyWHl0bkVJw==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: stable@vger.kernel.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	qyousef@layalina.io,
	frederic@kernel.org,
	jan.kiszka@siemens.com,
	bigeasy@linutronix.de,
	anna-maria@linutronix.de
Subject: [PATCH 6.1.y 1/1] hrtimer: Use and report correct timerslack values for realtime tasks
Date: Tue, 11 Mar 2025 15:07:05 +0100
Message-ID: <20250311140706.435615-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

commit ed4fb6d7ef68111bb539283561953e5c6e9a6e38 upstream.

The timerslack_ns setting is used to specify how much the hardware
timers should be delayed, to potentially dispatch multiple timers in a
single interrupt. This is a performance optimization. Timers of
realtime tasks (having a realtime scheduling policy) should not be
delayed.

This logic was inconsitently applied to the hrtimers, leading to delays
of realtime tasks which used timed waits for events (e.g. condition
variables). Due to the downstream override of the slack for rt tasks,
the procfs reported incorrect (non-zero) timerslack_ns values.

This is changed by setting the timer_slack_ns task attribute to 0 for
all tasks with a rt policy. By that, downstream users do not need to
specially handle rt tasks (w.r.t. the slack), and the procfs entry
shows the correct value of "0". Setting non-zero slack values (either
via procfs or PR_SET_TIMERSLACK) on tasks with a rt policy is ignored,
as stated in "man 2 PR_SET_TIMERSLACK":

  Timer slack is not applied to threads that are scheduled under a
  real-time scheduling policy (see sched_setscheduler(2)).

The special handling of timerslack on rt tasks in downstream users
is removed as well.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240814121032.368444-2-felix.moessbauer@siemens.com
---
 fs/proc/base.c        |  9 +++++----
 fs/select.c           | 11 ++++-------
 kernel/sched/core.c   |  8 ++++++++
 kernel/sys.c          |  2 ++
 kernel/time/hrtimer.c | 18 +++---------------
 5 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ecc45389ea793..82e4a8805bae6 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2633,10 +2633,11 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 	}
 
 	task_lock(p);
-	if (slack_ns == 0)
-		p->timer_slack_ns = p->default_timer_slack_ns;
-	else
-		p->timer_slack_ns = slack_ns;
+	if (task_is_realtime(p))
+		slack_ns = 0;
+	else if (slack_ns == 0)
+		slack_ns = p->default_timer_slack_ns;
+	p->timer_slack_ns = slack_ns;
 	task_unlock(p);
 
 out:
diff --git a/fs/select.c b/fs/select.c
index 3f730b8581f65..e66b6189845ea 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -77,19 +77,16 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 {
 	u64 ret;
 	struct timespec64 now;
+	u64 slack = current->timer_slack_ns;
 
-	/*
-	 * Realtime tasks get a slack of 0 for obvious reasons.
-	 */
-
-	if (rt_task(current))
+	if (slack == 0)
 		return 0;
 
 	ktime_get_ts64(&now);
 	now = timespec64_sub(*tv, now);
 	ret = __estimate_accuracy(&now);
-	if (ret < current->timer_slack_ns)
-		return current->timer_slack_ns;
+	if (ret < slack)
+		return slack;
 	return ret;
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0a483fd9f5de5..9be8a509b5f3f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7380,6 +7380,14 @@ static void __setscheduler_params(struct task_struct *p,
 	else if (fair_policy(policy))
 		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
 
+	/* rt-policy tasks do not have a timerslack */
+	if (task_is_realtime(p)) {
+		p->timer_slack_ns = 0;
+	} else if (p->timer_slack_ns == 0) {
+		/* when switching back to non-rt policy, restore timerslack */
+		p->timer_slack_ns = p->default_timer_slack_ns;
+	}
+
 	/*
 	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
 	 * !rt_policy. Always setting this ensures that things like
diff --git a/kernel/sys.c b/kernel/sys.c
index d06eda1387b69..06a9a87a8d3e0 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2477,6 +2477,8 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = current->timer_slack_ns;
 		break;
 	case PR_SET_TIMERSLACK:
+		if (task_is_realtime(current))
+			break;
 		if (arg2 <= 0)
 			current->timer_slack_ns =
 					current->default_timer_slack_ns;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8db65e2db14c7..f6d799646dd9c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2090,14 +2090,9 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
 	int ret = 0;
-	u64 slack;
-
-	slack = current->timer_slack_ns;
-	if (dl_task(current) || rt_task(current))
-		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -2278,7 +2273,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2305,13 +2300,6 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
-	/*
-	 * Override any slack passed by the user if under
-	 * rt contraints.
-	 */
-	if (rt_task(current))
-		delta = 0;
-
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2331,7 +2319,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has
-- 
2.47.2


