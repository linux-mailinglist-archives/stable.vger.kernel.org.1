Return-Path: <stable+bounces-115456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6CA343F7
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503C21895E53
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9456724167D;
	Thu, 13 Feb 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E0GoAjl9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B7241678;
	Thu, 13 Feb 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458117; cv=none; b=bdppBszfWl0Tr9zfp4TZAvXiJMnIu3h248YsRPd50HXqc3HIUiAu/TT3OgxsvxFs/usv0qY5PncAcRn/v56VluFEMPpDGL+HkjGzKQNGuvMjsGSeJ8jnAdoRdeowc9bOK5Tv/1/lbsFTZHi6p7R+hk8Ig11sadxwqitgnQrSrKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458117; c=relaxed/simple;
	bh=CbKpPraKttw635pDlTHidnfTSL/rMtht+8TpJJpYYaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQPyfP7WSSqlg8bFq1G/ATGcY4hdvWDki3nXnTFyhhVnN3zRKG3faJF7tmKj/VLe8f6LJx0uXgWnxOGfhzF9AUMn3fs7rfbmseIu0hq54V+v3L8WRwlof21rzvrGUqA7vwqv3uaRg3QZvuwdP6rNUigy9OsxyBGTiDBHQVziscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E0GoAjl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5658C4CED1;
	Thu, 13 Feb 2025 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458117;
	bh=CbKpPraKttw635pDlTHidnfTSL/rMtht+8TpJJpYYaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0GoAjl95mKkQaMQjAvZ+agChtNm2Jl4EiMJ1fgmUgl18TaYpvFEz57spbcJcuzcf
	 2Rvm683Acbfl94xwYNca5BLpj/8h0V8t+dFqEpQNK0HeOzA1LyjR5UcB5/mL6QG2eN
	 /xURFDnykC6FyR6N+zME2VyIz0pSas1WDJ946KO0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.12 307/422] hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
Date: Thu, 13 Feb 2025 15:27:36 +0100
Message-ID: <20250213142448.390565951@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <frederic@kernel.org>

commit 53dac345395c0d2493cbc2f4c85fe38aef5b63f5 upstream.

hrtimers are migrated away from the dying CPU to any online target at
the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth timers
handling tasks involved in the CPU hotplug forward progress.

However wakeups can still be performed by the outgoing CPU after
CPUHP_AP_HRTIMERS_DYING. Those can result again in bandwidth timers being
armed. Depending on several considerations (crystal ball power management
based election, earliest timer already enqueued, timer migration enabled or
not), the target may eventually be the current CPU even if offline. If that
happens, the timer is eventually ignored.

The most notable example is RCU which had to deal with each and every of
those wake-ups by deferring them to an online CPU, along with related
workarounds:

_ e787644caf76 (rcu: Defer RCU kthreads wakeup when CPU is dying)
_ 9139f93209d1 (rcu/nocb: Fix RT throttling hrtimer armed from offline CPU)
_ f7345ccc62a4 (rcu/nocb: Fix rcuog wake-up from offline softirq)

The problem isn't confined to RCU though as the stop machine kthread
(which runs CPUHP_AP_HRTIMERS_DYING) reports its completion at the end
of its work through cpu_stop_signal_done() and performs a wake up that
eventually arms the deadline server timer:

   WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086 hrtimer_start_range_ns+0x289/0x2d0
   CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
   Stopper: multi_cpu_stop+0x0/0x120 <- stop_machine_cpuslocked+0x66/0xc0
   RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
   Call Trace:
   <TASK>
     start_dl_timer
     enqueue_dl_entity
     dl_server_start
     enqueue_task_fair
     enqueue_task
     ttwu_do_activate
     try_to_wake_up
     complete
     cpu_stopper_thread

Instead of providing yet another bandaid to work around the situation, fix
it in the hrtimers infrastructure instead: always migrate away a timer to
an online target whenever it is enqueued from an offline CPU.

This will also allow to revert all the above RCU disgraceful hacks.

Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
Reported-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/all/20250117232433.24027-1-frederic@kernel.org
Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/hrtimer_defs.h |    1 
 kernel/time/hrtimer.c        |  103 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 83 insertions(+), 21 deletions(-)

--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -125,6 +125,7 @@ struct hrtimer_cpu_base {
 	ktime_t				softirq_expires_next;
 	struct hrtimer			*softirq_next_timer;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+	call_single_data_t		csd;
 } ____cacheline_aligned;
 
 
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -58,6 +58,8 @@
 #define HRTIMER_ACTIVE_SOFT	(HRTIMER_ACTIVE_HARD << MASK_SHIFT)
 #define HRTIMER_ACTIVE_ALL	(HRTIMER_ACTIVE_SOFT | HRTIMER_ACTIVE_HARD)
 
+static void retrigger_next_event(void *arg);
+
 /*
  * The timer bases:
  *
@@ -111,7 +113,8 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base,
 			.clockid = CLOCK_TAI,
 			.get_time = &ktime_get_clocktai,
 		},
-	}
+	},
+	.csd = CSD_INIT(retrigger_next_event, NULL)
 };
 
 static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
@@ -124,6 +127,14 @@ static const int hrtimer_clock_to_base_t
 	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
 };
 
+static inline bool hrtimer_base_is_online(struct hrtimer_cpu_base *base)
+{
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		return true;
+	else
+		return likely(base->online);
+}
+
 /*
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
@@ -183,27 +194,54 @@ struct hrtimer_clock_base *lock_hrtimer_
 }
 
 /*
- * We do not migrate the timer when it is expiring before the next
- * event on the target cpu. When high resolution is enabled, we cannot
- * reprogram the target cpu hardware and we would cause it to fire
- * late. To keep it simple, we handle the high resolution enabled and
- * disabled case similar.
+ * Check if the elected target is suitable considering its next
+ * event and the hotplug state of the current CPU.
+ *
+ * If the elected target is remote and its next event is after the timer
+ * to queue, then a remote reprogram is necessary. However there is no
+ * guarantee the IPI handling the operation would arrive in time to meet
+ * the high resolution deadline. In this case the local CPU becomes a
+ * preferred target, unless it is offline.
+ *
+ * High and low resolution modes are handled the same way for simplicity.
  *
  * Called with cpu_base->lock of target cpu held.
  */
-static int
-hrtimer_check_target(struct hrtimer *timer, struct hrtimer_clock_base *new_base)
+static bool hrtimer_suitable_target(struct hrtimer *timer, struct hrtimer_clock_base *new_base,
+				    struct hrtimer_cpu_base *new_cpu_base,
+				    struct hrtimer_cpu_base *this_cpu_base)
 {
 	ktime_t expires;
 
+	/*
+	 * The local CPU clockevent can be reprogrammed. Also get_target_base()
+	 * guarantees it is online.
+	 */
+	if (new_cpu_base == this_cpu_base)
+		return true;
+
+	/*
+	 * The offline local CPU can't be the default target if the
+	 * next remote target event is after this timer. Keep the
+	 * elected new base. An IPI will we issued to reprogram
+	 * it as a last resort.
+	 */
+	if (!hrtimer_base_is_online(this_cpu_base))
+		return true;
+
 	expires = ktime_sub(hrtimer_get_expires(timer), new_base->offset);
-	return expires < new_base->cpu_base->expires_next;
+
+	return expires >= new_base->cpu_base->expires_next;
 }
 
-static inline
-struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
-					 int pinned)
+static inline struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base, int pinned)
 {
+	if (!hrtimer_base_is_online(base)) {
+		int cpu = cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TIMER));
+
+		return &per_cpu(hrtimer_bases, cpu);
+	}
+
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	if (static_branch_likely(&timers_migration_enabled) && !pinned)
 		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
@@ -254,8 +292,8 @@ again:
 		raw_spin_unlock(&base->cpu_base->lock);
 		raw_spin_lock(&new_base->cpu_base->lock);
 
-		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		if (!hrtimer_suitable_target(timer, new_base, new_cpu_base,
+					     this_cpu_base)) {
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
 			new_cpu_base = this_cpu_base;
@@ -264,8 +302,7 @@ again:
 		}
 		WRITE_ONCE(timer->base, new_base);
 	} else {
-		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		if (!hrtimer_suitable_target(timer, new_base,  new_cpu_base, this_cpu_base)) {
 			new_cpu_base = this_cpu_base;
 			goto again;
 		}
@@ -725,8 +762,6 @@ static inline int hrtimer_is_hres_enable
 	return hrtimer_hres_enabled;
 }
 
-static void retrigger_next_event(void *arg);
-
 /*
  * Switch to high resolution mode
  */
@@ -1215,6 +1250,7 @@ static int __hrtimer_start_range_ns(stru
 				    u64 delta_ns, const enum hrtimer_mode mode,
 				    struct hrtimer_clock_base *base)
 {
+	struct hrtimer_cpu_base *this_cpu_base = this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *new_base;
 	bool force_local, first;
 
@@ -1226,10 +1262,16 @@ static int __hrtimer_start_range_ns(stru
 	 * and enforce reprogramming after it is queued no matter whether
 	 * it is the new first expiring timer again or not.
 	 */
-	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
+	force_local = base->cpu_base == this_cpu_base;
 	force_local &= base->cpu_base->next_timer == timer;
 
 	/*
+	 * Don't force local queuing if this enqueue happens on a unplugged
+	 * CPU after hrtimer_cpu_dying() has been invoked.
+	 */
+	force_local &= this_cpu_base->online;
+
+	/*
 	 * Remove an active timer from the queue. In case it is not queued
 	 * on the current CPU, make sure that remove_hrtimer() updates the
 	 * remote data correctly.
@@ -1258,8 +1300,27 @@ static int __hrtimer_start_range_ns(stru
 	}
 
 	first = enqueue_hrtimer(timer, new_base, mode);
-	if (!force_local)
-		return first;
+	if (!force_local) {
+		/*
+		 * If the current CPU base is online, then the timer is
+		 * never queued on a remote CPU if it would be the first
+		 * expiring timer there.
+		 */
+		if (hrtimer_base_is_online(this_cpu_base))
+			return first;
+
+		/*
+		 * Timer was enqueued remote because the current base is
+		 * already offline. If the timer is the first to expire,
+		 * kick the remote CPU to reprogram the clock event.
+		 */
+		if (first) {
+			struct hrtimer_cpu_base *new_cpu_base = new_base->cpu_base;
+
+			smp_call_function_single_async(new_cpu_base->cpu, &new_cpu_base->csd);
+		}
+		return 0;
+	}
 
 	/*
 	 * Timer was forced to stay on the current CPU to avoid



