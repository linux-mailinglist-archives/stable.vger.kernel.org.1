Return-Path: <stable+bounces-60511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575F093470A
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 06:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CE9B212C9
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 04:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888A939FFE;
	Thu, 18 Jul 2024 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OwIeU3WY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD91E520;
	Thu, 18 Jul 2024 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721275923; cv=none; b=NuxSekqcM3xdeGNHSxWfmDwkN2SaZeVdWVTC2Z8hQmFwTggWIHC1nsMr7nH6WjGuBOZoGhWat5BVEK07NzzQ8v6pJYtZ59EaYUe0Zx3oMiPN17DssY4Ida42eLym+qXEXrFzdURPtOnhuOKEQu53wdEOOkqoLjPdCVbnDMUGYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721275923; c=relaxed/simple;
	bh=Ay9NhtVBIFatm0zSxuRWzwzlGYV2fotX9GvF/RYYVdc=;
	h=Date:To:From:Subject:Message-Id; b=r0eQlozrjk3WjidWNmURzEu6gopSP9eAP3sAmf6mniibELdWbVe4zfiB1y+ee3XO1Il76RMm8eOtmfetXuRnRaQY3CdfJG4IjwymAybyc4fGRcqyAnN43q5vBSSn6Nmr6A1Q8mrtpYp2ohghHf3kCk+RzrSrx2f4DzRpXozwQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OwIeU3WY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CAAC116B1;
	Thu, 18 Jul 2024 04:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721275923;
	bh=Ay9NhtVBIFatm0zSxuRWzwzlGYV2fotX9GvF/RYYVdc=;
	h=Date:To:From:Subject:From;
	b=OwIeU3WYEzRkNnmpwcNJdCuWfVCXkSWEUP/cacp1Z4DQa1SXZbSzN6uT19LzWNN9N
	 OgwW7ITt+MAV4zxve+DNcXbijvwTnIYJ/NWwon+5gImFFgsnjk7MzNAxztnfKKVsEE
	 JwSnWtAxNW2msYcl+Jnuy6Wab9Y9xZmm2U9gElRw=
Date: Wed, 17 Jul 2024 21:12:02 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,peterz@infradead.org,arjan@linux.intel.com,tglx@linutronix.de,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-nonmm-stable] watchdog-perf-properly-initialize-the-turbo-mode-timestamp-and-rearm-counter.patch removed from -mm tree
Message-Id: <20240718041203.01CAAC116B1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: watchdog/perf: properly initialize the turbo mode timestamp and rearm counter
has been removed from the -mm tree.  Its filename was
     watchdog-perf-properly-initialize-the-turbo-mode-timestamp-and-rearm-counter.patch

This patch was dropped because it was merged into the mm-nonmm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Thomas Gleixner <tglx@linutronix.de>
Subject: watchdog/perf: properly initialize the turbo mode timestamp and rearm counter
Date: Thu, 11 Jul 2024 22:25:21 +0200

For systems on which the performance counter can expire early due to turbo
modes the watchdog handler has a safety net in place which validates that
since the last watchdog event there has at least 4/5th of the watchdog
period elapsed.

This works reliably only after the first watchdog event because the per
CPU variable which holds the timestamp of the last event is never
initialized.

So a first spurious event will validate against a timestamp of 0 which
results in a delta which is likely to be way over the 4/5 threshold of the
period.  As this might happen before the first watchdog hrtimer event
increments the watchdog counter, this can lead to false positives.

Fix this by initializing the timestamp before enabling the hardware event.
Reset the rearm counter as well, as that might be non zero after the
watchdog was disabled and reenabled.

Link: https://lkml.kernel.org/r/87frsfu15a.ffs@tglx
Fixes: 7edaeb6841df ("kernel/watchdog: Prevent false positives with turbo modes")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/watchdog_perf.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/kernel/watchdog_perf.c~watchdog-perf-properly-initialize-the-turbo-mode-timestamp-and-rearm-counter
+++ a/kernel/watchdog_perf.c
@@ -75,11 +75,15 @@ static bool watchdog_check_timestamp(voi
 	__this_cpu_write(last_timestamp, now);
 	return true;
 }
-#else
-static inline bool watchdog_check_timestamp(void)
+
+static void watchdog_init_timestamp(void)
 {
-	return true;
+	__this_cpu_write(nmi_rearmed, 0);
+	__this_cpu_write(last_timestamp, ktime_get_mono_fast_ns());
 }
+#else
+static inline bool watchdog_check_timestamp(void) { return true; }
+static inline void watchdog_init_timestamp(void) { }
 #endif
 
 static struct perf_event_attr wd_hw_attr = {
@@ -161,6 +165,7 @@ void watchdog_hardlockup_enable(unsigned
 	if (!atomic_fetch_inc(&watchdog_cpus))
 		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
 
+	watchdog_init_timestamp();
 	perf_event_enable(this_cpu_read(watchdog_ev));
 }
 
_

Patches currently in -mm which might be from tglx@linutronix.de are



