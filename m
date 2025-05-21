Return-Path: <stable+bounces-145748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C173CABE97F
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 04:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1AA188FDB1
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 02:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F45221D8D;
	Wed, 21 May 2025 02:03:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35571804A
	for <stable@vger.kernel.org>; Wed, 21 May 2025 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792990; cv=none; b=B0xDS0mWCBTCQfQD2QeRzkj/j1UUh/sSHZZBKMw3uIIkbnacWBIvbB6OnnAgcSyamAU3Pz0olmNpiOvSCqmuFsUYTIm7iNP9jdvNiYaEnf3ZxOvmgqJOn4dEh0xhTrQ5KCjp5yUYcYq1mLJTKOR8JxLRNm0W/JgH9SVcre+WiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792990; c=relaxed/simple;
	bh=f7QkmyYzHpfUpqA7PZdHa+TzYR7hN+HAjc1xVBE1jXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXS7Gd46PiXh0zXRRXsHtizy/QQc0ZFIW/LeWxlI434Y/FebLvDAO5q/rm4uJB46uG6+KsQeM0UkW9v3MZn0cEeshnQc1bwbA+w6/s8HkbXcUC1nvGlNSoZFiTN/CL/taje510NjMGi/17ywicD1Exr2sMRXKAsLFtADL4efwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAB3f3csNC1oDiddAQ--.25969S2;
	Wed, 21 May 2025 10:02:20 +0800 (CST)
Received: from ubuntu.localdomain (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wDXSAopNC1o60sfAw--.9556S4;
	Wed, 21 May 2025 10:02:17 +0800 (CST)
From: Zhaoyang Li <lizy04@hust.edu.cn>
To: stable@vger.kernel.org
Cc: dzm91@hust.edu.cn,
	Frederic Weisbecker <frederic@kernel.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Usama Arif <usamaarif642@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zhaoyang Li <lizy04@hust.edu.cn>
Subject: [PATCH 6.1.y] hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
Date: Wed, 21 May 2025 10:02:16 +0800
Message-Id: <20250521020216.539748-1-lizy04@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025021053-unranked-silt-0282@gregkh>
References: <2025021053-unranked-silt-0282@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAB3f3csNC1oDiddAQ--.25969S2
Authentication-Results: app2; spf=neutral smtp.mail=lizy04@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoW3Zw4DtFWDAw1fZw43Xr1kKrg_yoWDWr1xpF
	W8KrZxtr4kJrWDJa95JF4DZryaqw4xCr17Jr1fKF9YyF13GFyUJF40qF43XFWfurW09r42
	vryxtF9Ykr4DAa7anT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQSb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUkCedUUUUU
X-CM-SenderInfo: rpsqjjixsriko6kx23oohg3hdfq/1tbiAQgJB2gr+2JSFQAAsa

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 53dac345395c0d2493cbc2f4c85fe38aef5b63f5 ]

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

Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
---
 include/linux/hrtimer.h |   1 +
 kernel/time/hrtimer.c   | 103 ++++++++++++++++++++++++++++++++--------
 2 files changed, 83 insertions(+), 21 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 8f77bb0f4ae0..05f8b7d7d1e9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -237,6 +237,7 @@ struct hrtimer_cpu_base {
 	ktime_t				softirq_expires_next;
 	struct hrtimer			*softirq_next_timer;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+	call_single_data_t		csd;
 } ____cacheline_aligned;
 
 static inline void hrtimer_set_expires(struct hrtimer *timer, ktime_t time)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e60863ab74b5..b3860ec12450 100644
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
@@ -111,7 +113,8 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_TAI,
 			.get_time = &ktime_get_clocktai,
 		},
-	}
+	},
+	.csd = CSD_INIT(retrigger_next_event, NULL)
 };
 
 static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
@@ -124,6 +127,14 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
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
@@ -177,27 +188,54 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
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
@@ -248,8 +286,8 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 		raw_spin_unlock(&base->cpu_base->lock);
 		raw_spin_lock(&new_base->cpu_base->lock);
 
-		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		if (!hrtimer_suitable_target(timer, new_base, new_cpu_base,
+					     this_cpu_base)) {
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
 			new_cpu_base = this_cpu_base;
@@ -258,8 +296,7 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 		}
 		WRITE_ONCE(timer->base, new_base);
 	} else {
-		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		if (!hrtimer_suitable_target(timer, new_base,  new_cpu_base, this_cpu_base)) {
 			new_cpu_base = this_cpu_base;
 			goto again;
 		}
@@ -718,8 +755,6 @@ static inline int hrtimer_is_hres_enabled(void)
 	return hrtimer_hres_enabled;
 }
 
-static void retrigger_next_event(void *arg);
-
 /*
  * Switch to high resolution mode
  */
@@ -1205,6 +1240,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 				    u64 delta_ns, const enum hrtimer_mode mode,
 				    struct hrtimer_clock_base *base)
 {
+	struct hrtimer_cpu_base *this_cpu_base = this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *new_base;
 	bool force_local, first;
 
@@ -1216,9 +1252,15 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	 * and enforce reprogramming after it is queued no matter whether
 	 * it is the new first expiring timer again or not.
 	 */
-	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
+	force_local = base->cpu_base == this_cpu_base;
 	force_local &= base->cpu_base->next_timer == timer;
 
+	/*
+	 * Don't force local queuing if this enqueue happens on a unplugged
+	 * CPU after hrtimer_cpu_dying() has been invoked.
+	 */
+	force_local &= this_cpu_base->online;
+
 	/*
 	 * Remove an active timer from the queue. In case it is not queued
 	 * on the current CPU, make sure that remove_hrtimer() updates the
@@ -1248,8 +1290,27 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
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
-- 
2.25.1


