Return-Path: <stable+bounces-19752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B20853482
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5859FB221F6
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AEA5D902;
	Tue, 13 Feb 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1p0gfWM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ueKYiRaI"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297515A7B7
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837826; cv=none; b=BbwqEcoYzcNTQYXs2K7G1AKGOaWcJXbxG8ezD5svdSCJSd3BrITuXD6tLeJHNIO8V1R1LUD/AGD4bSMnVWEtMpQMeMR4evAHpcDSMWMTjvxEG/kYgyahAbGQv2Wxj6GMbTQokLyhcrRjrkfAYccjPcSP92Jle6QACaZkpDr9f98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837826; c=relaxed/simple;
	bh=J8cFLhaL5e1PtriNHAkr4lFFYxhs+TkLh5fFeZDM39M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bwBnsTQ8aU7FXcRtCKlkvtkCPG5703pfLvjfr6JvrDobZUVnnmtYzfwz3kAvR02qdmJmx/cJSj3j8HtaivGp5f4QxSmlNQoUrVmcH2OwOedyggKSzXiqMsnCBHGzgczDLfZDXj0mGawY7sKG3kE/heSwrrPgoqR2kbYB8rGBQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I1p0gfWM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ueKYiRaI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707837822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AaBknUysLxvKTx4XB50m5+FY4VicPzpDnNPiIoLGaGA=;
	b=I1p0gfWMcftVcuSi3+p+IIVlZKaCuHDovYGwYbDLZ83KEsDg234pNpcsRkvRPXETjQKusz
	yw+nZsZcBJeApL4Azvzb13BKCG60NVRR4hW3Ah0afPbtLd9ymnBug/1mPBPlCepKq6mYLL
	q7s6RHAGaNJQgtGvs7nTb3U2yZ6GdfH0atdRXxQo04dKbN+Uo86n8X+jgeLYwup67k067a
	toxwt72qvB6Lz8TMJXkOxdMOiKeb5qW3PIKHEjtuPXq7J2XqJdoQTIkyQ/X2YeC88aiLiO
	qUCpeQOtEWnMvl9V+Rl9GHgjGFCOWmbeWX5UkBhe2bwAx/4UVtnSAQ5QEVtqNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707837822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AaBknUysLxvKTx4XB50m5+FY4VicPzpDnNPiIoLGaGA=;
	b=ueKYiRaI/p7PvaEFb6h7mLCT55Wc3/QRIizXbaUc0wZfjfOaBbiE/lSebUpVDE98HJTAI4
	M16YZ8eYt05tqfDg==
To: gregkh@linuxfoundation.org, jwiesner@suse.de, feng.tang@intel.com,
 paulmck@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1, 5.15, 5.10] clocksource: Skip watchdog check for large
 watchdog intervals
In-Reply-To: <2024012905-carry-revolt-b8d5@gregkh>
References: <2024012905-carry-revolt-b8d5@gregkh>
Date: Tue, 13 Feb 2024 16:23:41 +0100
Message-ID: <87jzn8gzgi.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Jiri Wiesner <jwiesner@suse.de>

commit 644649553508b9bacf0fc7a5bdc4f9e0165576a5 upstream.

There have been reports of the watchdog marking clocksources unstable on
machines with 8 NUMA nodes:

  clocksource: timekeeping watchdog on CPU373:
  Marking clocksource 'tsc' as unstable because the skew is too large:
  clocksource:   'hpet' wd_nsec: 14523447520
  clocksource:   'tsc'  cs_nsec: 14524115132

The measured clocksource skew - the absolute difference between cs_nsec
and wd_nsec - was 668 microseconds:

  cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612

The kernel used 200 microseconds for the uncertainty_margin of both the
clocksource and watchdog, resulting in a threshold of 400 microseconds (the
md variable). Both the cs_nsec and the wd_nsec value indicate that the
readout interval was circa 14.5 seconds.  The observed behaviour is that
watchdog checks failed for large readout intervals on 8 NUMA node
machines. This indicates that the size of the skew was directly proportinal
to the length of the readout interval on those machines. The measured
clocksource skew, 668 microseconds, was evaluated against a threshold (the
md variable) that is suited for readout intervals of roughly
WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 0.5 second.

The intention of 2e27e793e280 ("clocksource: Reduce clocksource-skew
threshold") was to tighten the threshold for evaluating skew and set the
lower bound for the uncertainty_margin of clocksources to twice
WATCHDOG_MAX_SKEW. Later in c37e85c135ce ("clocksource: Loosen clocksource
watchdog constraints"), the WATCHDOG_MAX_SKEW constant was increased to
125 microseconds to fit the limit of NTP, which is able to use a
clocksource that suffers from up to 500 microseconds of skew per second.
Both the TSC and the HPET use default uncertainty_margin. When the
readout interval gets stretched the default uncertainty_margin is no
longer a suitable lower bound for evaluating skew - it imposes a limit
that is far stricter than the skew with which NTP can deal.

The root causes of the skew being directly proportinal to the length of
the readout interval are:

  * the inaccuracy of the shift/mult pairs of clocksources and the watchdog
  * the conversion to nanoseconds is imprecise for large readout intervals

Prevent this by skipping the current watchdog check if the readout
interval exceeds 2 * WATCHDOG_INTERVAL. Considering the maximum readout
interval of 2 * WATCHDOG_INTERVAL, the current default uncertainty margin
(of the TSC and HPET) corresponds to a limit on clocksource skew of 250
ppm (microseconds of skew per second).  To keep the limit imposed by NTP
(500 microseconds of skew per second) for all possible readout intervals,
the margins would have to be scaled so that the threshold value is
proportional to the length of the actual readout interval.

As for why the readout interval may get stretched: Since the watchdog is
executed in softirq context the expiration of the watchdog timer can get
severely delayed on account of a ksoftirqd thread not getting to run in a
timely manner. Surely, a system with such belated softirq execution is not
working well and the scheduling issue should be looked into but the
clocksource watchdog should be able to deal with it accordingly.

Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
Suggested-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240122172350.GA740@incl
---

Backport to 6.1, 5.15, 5.10 because tglx has too much spare time

---
 kernel/time/clocksource.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -118,6 +118,7 @@ static DECLARE_WORK(watchdog_work, clock
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
+static int64_t watchdog_max_interval;
 
 static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
@@ -136,6 +137,7 @@ static void __clocksource_change_rating(
  * Interval: 0.5sec.
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_INTERVAL_MAX_NS ((2 * WATCHDOG_INTERVAL) * (NSEC_PER_SEC / HZ))
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -324,8 +326,8 @@ static inline void clocksource_reset_wat
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
+	int64_t wd_nsec, cs_nsec, interval;
 	int next_cpu, reset_pending;
-	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
 	unsigned long extra_wait = 0;
@@ -395,6 +397,27 @@ static void clocksource_watchdog(struct
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
+		/*
+		 * The processing of timer softirqs can get delayed (usually
+		 * on account of ksoftirqd not getting to run in a timely
+		 * manner), which causes the watchdog interval to stretch.
+		 * Skew detection may fail for longer watchdog intervals
+		 * on account of fixed margins being used.
+		 * Some clocksources, e.g. acpi_pm, cannot tolerate
+		 * watchdog intervals longer than a few seconds.
+		 */
+		interval = max(cs_nsec, wd_nsec);
+		if (unlikely(interval > WATCHDOG_INTERVAL_MAX_NS)) {
+			if (system_state > SYSTEM_SCHEDULING &&
+			    interval > 2 * watchdog_max_interval) {
+				watchdog_max_interval = interval;
+				pr_warn("Long readout interval, skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
+					cs_nsec, wd_nsec);
+			}
+			watchdog_timer.expires = jiffies;
+			continue;
+		}
+
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {

