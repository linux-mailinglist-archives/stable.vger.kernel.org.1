Return-Path: <stable+bounces-16423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05525840AFC
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0AF1C219D9
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5423155A2C;
	Mon, 29 Jan 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BDNn3dRO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D615531E
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544730; cv=none; b=RyO+ZUxd97k31WlvsLvZNg6z6TGtl/4fIPQEKfQbbsSs9h5fM7VOnWdhMgje3SqH+qfeA8N9a/wmmjK4iqq5auVmihFx2dKtq4vHH0omV1UsCexn5LhkPpWe3SPu5B3w1k++maF9eMFgK/Gk2d6z3/fG9/zlAggfkbDpr4ZLS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544730; c=relaxed/simple;
	bh=yQi4bkcZ5nGHrn2LFKCDyGHARlSruBqHoRyKMR0ZBhA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bqvPuDXYP3QmRxZurrvBFoTrB2Sh6NVvBfejuqpgXjacXxm0xLKsxhDQIgM2F1Qlu4Roe7P0iE5Q8ufTYw2SQ+aUPz6q8/4Z7Ek3cfXBQfuEBLKbaVyT86PY/mToaikcR/q38ok4O5MtLng+9o7bP452KcABSoZQ+eWJqid3jzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BDNn3dRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB69C433C7;
	Mon, 29 Jan 2024 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706544730;
	bh=yQi4bkcZ5nGHrn2LFKCDyGHARlSruBqHoRyKMR0ZBhA=;
	h=Subject:To:Cc:From:Date:From;
	b=BDNn3dROllpal5Utc8Xl1AKx7bxr/EN2zKZXnwiK6Dnhem9+wdf6EByUvekTYjuqg
	 7edl/VTKFLa/aJl1ZFVpzUXZBm6XuSojf4bdKp0q+omoJU/sgZiG1z8Aoe6+1K9up7
	 mZkkOxrkB0/CmzcgZgmD0PMIzOnrrO6mBd91T5T0=
Subject: FAILED: patch "[PATCH] clocksource: Skip watchdog check for large watchdog intervals" failed to apply to 5.15-stable tree
To: jwiesner@suse.de,feng.tang@intel.com,paulmck@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jan 2024 08:12:09 -0800
Message-ID: <2024012908-footing-happily-57fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 644649553508b9bacf0fc7a5bdc4f9e0165576a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012908-footing-happily-57fa@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

644649553508 ("clocksource: Skip watchdog check for large watchdog intervals")
c37e85c135ce ("clocksource: Loosen clocksource watchdog constraints")
fc153c1c58cb ("clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW")
c86ff8c55b8a ("clocksource: Avoid accidental unstable marking of clocksources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 644649553508b9bacf0fc7a5bdc4f9e0165576a5 Mon Sep 17 00:00:00 2001
From: Jiri Wiesner <jwiesner@suse.de>
Date: Mon, 22 Jan 2024 18:23:50 +0100
Subject: [PATCH] clocksource: Skip watchdog check for large watchdog intervals

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

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..3052b1f1168e 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -99,6 +99,7 @@ static u64 suspend_start;
  * Interval: 0.5sec.
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_INTERVAL_MAX_NS ((2 * WATCHDOG_INTERVAL) * (NSEC_PER_SEC / HZ))
 
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
@@ -134,6 +135,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
+static int64_t watchdog_max_interval;
 
 static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
@@ -399,8 +401,8 @@ static inline void clocksource_reset_watchdog(void)
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
+	int64_t wd_nsec, cs_nsec, interval;
 	int next_cpu, reset_pending;
-	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
 	unsigned long extra_wait = 0;
@@ -470,6 +472,27 @@ static void clocksource_watchdog(struct timer_list *unused)
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


