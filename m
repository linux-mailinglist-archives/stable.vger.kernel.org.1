Return-Path: <stable+bounces-126048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A06A6FE72
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1DF172E37
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EE2264A7C;
	Tue, 25 Mar 2025 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="toSQ+fpG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C726463D;
	Tue, 25 Mar 2025 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905503; cv=none; b=axJ6hWuprGM+MM3Io689bKHsxSUheoAKKb5CChmQQt5kwuerVi+GhD91o+xxBIZbjnYqqFD+IbIMCpKT7QaSml/T8njgQO320Ml+ydHy70LJwoEajT1cGR49Sbkxr22zXc0krc5CGAsu5IDHcug8mZve1M3Q4uiTLoRhhck5r1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905503; c=relaxed/simple;
	bh=Bj+NiideMlh4Kf4Qg6uML1MMcMkcxkMqSxjf72oXc74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7BqxMY0S7VHplwNuIJL/LFCh7/P6wkwqnrEiXOWd12nCEAzGbFryQjEKKXI1qugAeCTez+9xbZxSmV7LDPozYjrtwPALnDhauu85hdbkE+2tjzNNng/0BqiSS9in8peuLmvUJOpm8ghM/Kll+YoXLY8EGXwvYCBR47we1gGW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=toSQ+fpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56558C4CEE9;
	Tue, 25 Mar 2025 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905503;
	bh=Bj+NiideMlh4Kf4Qg6uML1MMcMkcxkMqSxjf72oXc74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toSQ+fpGu0OI42nD3iMZc7Z72qOnEYgdyjkkakOP7+KyHFKDzNlwoVf4HyVILZyEP
	 CIfE+PUw40vu8kkeMULdCBNBh7WCOkqg0YyUiTGMWh7qoJM02UGvQ3JAHn/1hxjpCf
	 KBl+MjsI8wCUQOyZVwwMEd4G/Vs2Hp6muSgbi2ho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.1 003/198] hrtimer: Use and report correct timerslack values for realtime tasks
Date: Tue, 25 Mar 2025 08:19:25 -0400
Message-ID: <20250325122156.728999071@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Moessbauer <felix.moessbauer@siemens.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/base.c        |    9 +++++----
 fs/select.c           |   11 ++++-------
 kernel/sched/core.c   |    8 ++++++++
 kernel/sys.c          |    2 ++
 kernel/time/hrtimer.c |   18 +++---------------
 5 files changed, 22 insertions(+), 26 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2633,10 +2633,11 @@ static ssize_t timerslack_ns_write(struc
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
--- a/fs/select.c
+++ b/fs/select.c
@@ -77,19 +77,16 @@ u64 select_estimate_accuracy(struct time
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
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7380,6 +7380,14 @@ static void __setscheduler_params(struct
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
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2477,6 +2477,8 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 			error = current->timer_slack_ns;
 		break;
 	case PR_SET_TIMERSLACK:
+		if (task_is_realtime(current))
+			break;
 		if (arg2 <= 0)
 			current->timer_slack_ns =
 					current->default_timer_slack_ns;
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2090,14 +2090,9 @@ long hrtimer_nanosleep(ktime_t rqtp, con
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
@@ -2305,13 +2300,6 @@ schedule_hrtimeout_range_clock(ktime_t *
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
@@ -2331,7 +2319,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_ran
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has



