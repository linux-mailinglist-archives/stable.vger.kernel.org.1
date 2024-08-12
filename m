Return-Path: <stable+bounces-66855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D494F2C8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1660CB23FA9
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC0187335;
	Mon, 12 Aug 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FoGdB4KO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA1183CD9;
	Mon, 12 Aug 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479006; cv=none; b=Nij03LVxJTsr8YATlDIi4jSQOrCirdRTf+MBPXIxkjLyvJVK0yS7Z+2TPOdLNNgiVCs+eAiC9HEeMGRKCUSkN1uCoIvdeUA0qFXg/vEjmGLawS0MtH4+xwejZXi5ldbXXFMTPfFh8458hSRY6Ve4wb6eeKKrnCXg5SljkarM/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479006; c=relaxed/simple;
	bh=xp2akxgmvGug2Yx5FV2YUJEEpiQOwfCzmvL0KvYD7ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fx9PrDJDMO7WfRCvGqMHM6Zp+HnaH0A5xXBqteSsdAoo6KJ31K0CFUFCzIHtcTCeSG/DzHtJFefAwoiD8BEhyYsZ8yCwW7wrbmfmbLfHrlT9KD5tqfHYzMSIEhLaToNeFxpxlqYwal1eYo8fCiTVMbkyPXzXPO3dJ6ukm00wAn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FoGdB4KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DF7C32782;
	Mon, 12 Aug 2024 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479006;
	bh=xp2akxgmvGug2Yx5FV2YUJEEpiQOwfCzmvL0KvYD7ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoGdB4KOcmWnnzr9NURGLw+OHm0kHBgV+1Dxq3xqfpTU2kmr7WLAgEktVx0sg7E1y
	 e5qLh5fnOiZhZpsaH1zN6e6jnx8UZUDBWY/4OdnkrzIJ1/rZR4FjYsS3sYWBcWpeMu
	 GZravoA1SkZ7wVOxxF1OoNjBrkWcqjseAltFm8bs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Feng Tang <feng.tang@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jin Wang <jin1.wang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/150] clocksource: Scale the watchdog read retries automatically
Date: Mon, 12 Aug 2024 18:03:05 +0200
Message-ID: <20240812160129.175005012@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Feng Tang <feng.tang@intel.com>

[ Upstream commit 2ed08e4bc53298db3f87b528cd804cb0cce066a9 ]

On a 8-socket server the TSC is wrongly marked as 'unstable' and disabled
during boot time on about one out of 120 boot attempts:

    clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
    wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
    tsc: Marking TSC unstable due to clocksource watchdog
    TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
    sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
    clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
    clocksource: Switched to clocksource hpet

The reason is that for platform with a large number of CPUs, there are
sporadic big or huge read latencies while reading the watchog/clocksource
during boot or when system is under stress work load, and the frequency and
maximum value of the latency goes up with the number of online CPUs.

The cCurrent code already has logic to detect and filter such high latency
case by reading the watchdog twice and checking the two deltas. Due to the
randomness of the latency, there is a low probabilty that the first delta
(latency) is big, but the second delta is small and looks valid. The
watchdog code retries the readouts by default twice, which is not
necessarily sufficient for systems with a large number of CPUs.

There is a command line parameter 'max_cswd_read_retries' which allows to
increase the number of retries, but that's not user friendly as it needs to
be tweaked per system. As the number of required retries is proportional to
the number of online CPUs, this parameter can be calculated at runtime.

Scale and enlarge the number of retries according to the number of online
CPUs and remove the command line parameter completely.

[ tglx: Massaged change log and comments ]

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jin Wang <jin1.wang@intel.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240221060859.1027450-1-feng.tang@intel.com
Stable-dep-of: f2655ac2c06a ("clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt   |  6 ------
 include/linux/clocksource.h                       | 14 +++++++++++++-
 kernel/time/clocksource-wdtest.c                  | 13 +++++++------
 kernel/time/clocksource.c                         | 10 ++++------
 tools/testing/selftests/rcutorture/bin/torture.sh |  2 +-
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a29ff7a773c7c..8df4c1c5c6197 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -637,12 +637,6 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clocksource.max_cswd_read_retries= [KNL]
-			Number of clocksource_watchdog() retries due to
-			external delays before the clock will be marked
-			unstable.  Defaults to two retries, that is,
-			three attempts to read the clock under test.
-
 	clocksource.verify_n_cpus= [KNL]
 			Limit the number of CPUs checked for clocksources
 			marked with CLOCK_SOURCE_VERIFY_PERCPU that
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b173271..0ad8b550bb4b4 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -291,7 +291,19 @@ static inline void timer_probe(void) {}
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
-extern ulong max_cswd_read_retries;
+static inline unsigned int clocksource_get_max_watchdog_retry(void)
+{
+	/*
+	 * When system is in the boot phase or under heavy workload, there
+	 * can be random big latencies during the clocksource/watchdog
+	 * read, so allow retries to filter the noise latency. As the
+	 * latency's frequency and maximum value goes up with the number of
+	 * CPUs, scale the number of retries with the number of online
+	 * CPUs.
+	 */
+	return (ilog2(num_online_cpus()) / 2) + 1;
+}
+
 void clocksource_verify_percpu(struct clocksource *cs);
 
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index df922f49d171b..d06185e054ea2 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -104,8 +104,8 @@ static void wdtest_ktime_clocksource_reset(void)
 static int wdtest_func(void *arg)
 {
 	unsigned long j1, j2;
+	int i, max_retries;
 	char *s;
-	int i;
 
 	schedule_timeout_uninterruptible(holdoff * HZ);
 
@@ -139,18 +139,19 @@ static int wdtest_func(void *arg)
 	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
 
 	/* Verify tsc-like stability with various numbers of errors injected. */
-	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
-		if (i <= 1 && i < max_cswd_read_retries)
+	max_retries = clocksource_get_max_watchdog_retry();
+	for (i = 0; i <= max_retries + 1; i++) {
+		if (i <= 1 && i < max_retries)
 			s = "";
-		else if (i <= max_cswd_read_retries)
+		else if (i <= max_retries)
 			s = ", expect message";
 		else
 			s = ", expect clock skew";
-		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
+		pr_info("--- Watchdog with %dx error injection, %d retries%s.\n", i, max_retries, s);
 		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
 		schedule_timeout_uninterruptible(2 * HZ);
 		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
-		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
+		WARN_ON_ONCE((i <= max_retries) !=
 			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
 		wdtest_ktime_clocksource_reset();
 	}
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cc6db3bce1b2f..6d5a0fc98e398 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -207,9 +207,6 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
-ulong max_cswd_read_retries = 2;
-module_param(max_cswd_read_retries, ulong, 0644);
-EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
 
@@ -221,11 +218,12 @@ enum wd_read_status {
 
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
-	unsigned int nretries;
+	unsigned int nretries, max_retries;
 	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
 
-	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
+	max_retries = clocksource_get_max_watchdog_retry();
+	for (nretries = 0; nretries <= max_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
@@ -237,7 +235,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
 					      watchdog->shift);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_cswd_read_retries) {
+			if (nretries > 1 || nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 91bca30e8587c..483f22f5abd7c 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -408,7 +408,7 @@ then
 	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 	torture_set "clocksourcewd-1" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 clocksource.max_cswd_read_retries=1 tsc=watchdog"
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 	torture_set "clocksourcewd-2" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
 	# In case our work is already done...
-- 
2.43.0




