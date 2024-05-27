Return-Path: <stable+bounces-46330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039DB8D02F1
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC06E29C038
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08F1649BF;
	Mon, 27 May 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfskwN56"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3C161B43;
	Mon, 27 May 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819152; cv=none; b=HWfCw/X50t1i4RwzsmnZTJUpgumuoRoEK/T4vVKhZHut1GxiDydLuETPz//pYlFr8FyWZrRwYsxBWj+ew5bNsxtCWCKBy4/A9b0TgHsqut7YSP+w2FzZVJktv34B616XlQfpfl1f12ARcYuHJNNfj6aM8/qDY8vdtuNI5nf1pJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819152; c=relaxed/simple;
	bh=4UCZ9Acw7KWuLNqIvfegDpagqJsTXQPI7lE5VQ5BZD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc/zoOLq/Y5q05BBwpeuxGnwni+iLrWGgtCT6pkS6NGvyB/OAYRdalYGkU94DvYgloREO0IqNEYp06dvYvVHpoty/b6OhmBh0Sam4LBnkvmHSppy8nIYApGc1aFz8RKxeAsEwMAvj4ppOXX8bCZ+93kgwO9CfVx+CD8pEevXCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfskwN56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F9EC32781;
	Mon, 27 May 2024 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819152;
	bh=4UCZ9Acw7KWuLNqIvfegDpagqJsTXQPI7lE5VQ5BZD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfskwN56JiTDS6iVmVWmWKvzwPXfB+8GywLQlLkXxhZHBOvLKCTf9GsP7gCEmtFCd
	 drt9oe7AsSX2XzuKnsvQKp0MvrvM6HwzBcAFIwDuIwIh6o/ClBZtyH/JuHLUYB3pNq
	 kfxLT862+WthmVkiahO7O3lvT9k3cNmnKGr4590Ysy8JQlhd13npuiMyst8scShjy4
	 VrkFyb+sz7OKY4wHINLEjXamKREy7wHQ5b8jyeB82DfAdtMcrFOPI+bjsFd+Lf2CCt
	 YdJzo2vGtLMzjBR4LGAA6/0WEyPJP2KYw6Grg2MFbZD2+bZf5QgNkOEIpx8cn1TS/p
	 ZuaJebtf0jiZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	jstultz@google.com
Subject: [PATCH AUTOSEL 6.9 10/35] clocksource: Make watchdog and suspend-timing multiplication overflow safe
Date: Mon, 27 May 2024 10:11:15 -0400
Message-ID: <20240527141214.3844331-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit d0304569fb019d1bcfbbbce1ce6df6b96f04079b ]

Kernel timekeeping is designed to keep the change in cycles (since the last
timer interrupt) below max_cycles, which prevents multiplication overflow
when converting cycles to nanoseconds. However, if timer interrupts stop,
the clocksource_cyc2ns() calculation will eventually overflow.

Add protection against that. Simplify by folding together
clocksource_delta() and clocksource_cyc2ns() into cycles_to_nsec_safe().
Check against max_cycles, falling back to a slower higher precision
calculation.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-20-adrian.hunter@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/clocksource.c | 42 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e5b260aa0e02c..4d50d53ac719f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -20,6 +20,16 @@
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
 
+static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u64 end)
+{
+	u64 delta = clocksource_delta(end, start, cs->mask);
+
+	if (likely(delta < cs->max_cycles))
+		return clocksource_cyc2ns(delta, cs->mult, cs->shift);
+
+	return mul_u64_u32_shr(delta, cs->mult, cs->shift);
+}
+
 /**
  * clocks_calc_mult_shift - calculate mult/shift factors for scaled math of clocks
  * @mult:	pointer to mult variable
@@ -222,8 +232,8 @@ enum wd_read_status {
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
 	unsigned int nretries, max_retries;
-	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
+	u64 wd_end, wd_end2;
 
 	max_retries = clocksource_get_max_watchdog_retry();
 	for (nretries = 0; nretries <= max_retries; nretries++) {
@@ -234,9 +244,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		wd_end2 = watchdog->read(watchdog);
 		local_irq_enable();
 
-		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
-		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
-					      watchdog->shift);
+		wd_delay = cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
 			if (nretries > 1 || nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
@@ -254,8 +262,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		 * report system busy, reinit the watchdog and skip the current
 		 * watchdog test.
 		 */
-		wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
-		wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
+		wd_seq_delay = cycles_to_nsec_safe(watchdog, wd_end, wd_end2);
 		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
 			goto skip_test;
 	}
@@ -366,8 +373,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		delta = (csnow_end - csnow_mid) & cs->mask;
 		if (delta < 0)
 			cpumask_set_cpu(cpu, &cpus_ahead);
-		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		cs_nsec = cycles_to_nsec_safe(cs, csnow_begin, csnow_end);
 		if (cs_nsec > cs_nsec_max)
 			cs_nsec_max = cs_nsec;
 		if (cs_nsec < cs_nsec_min)
@@ -398,8 +404,8 @@ static inline void clocksource_reset_watchdog(void)
 
 static void clocksource_watchdog(struct timer_list *unused)
 {
-	u64 csnow, wdnow, cslast, wdlast, delta;
 	int64_t wd_nsec, cs_nsec, interval;
+	u64 csnow, wdnow, cslast, wdlast;
 	int next_cpu, reset_pending;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
@@ -456,12 +462,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		delta = clocksource_delta(wdnow, cs->wd_last, watchdog->mask);
-		wd_nsec = clocksource_cyc2ns(delta, watchdog->mult,
-					     watchdog->shift);
-
-		delta = clocksource_delta(csnow, cs->cs_last, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		wd_nsec = cycles_to_nsec_safe(watchdog, cs->wd_last, wdnow);
+		cs_nsec = cycles_to_nsec_safe(cs, cs->cs_last, csnow);
 		wdlast = cs->wd_last; /* save these in case we print them */
 		cslast = cs->cs_last;
 		cs->cs_last = csnow;
@@ -832,7 +834,7 @@ void clocksource_start_suspend_timing(struct clocksource *cs, u64 start_cycles)
  */
 u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 cycle_now)
 {
-	u64 now, delta, nsec = 0;
+	u64 now, nsec = 0;
 
 	if (!suspend_clocksource)
 		return 0;
@@ -847,12 +849,8 @@ u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 cycle_now)
 	else
 		now = suspend_clocksource->read(suspend_clocksource);
 
-	if (now > suspend_start) {
-		delta = clocksource_delta(now, suspend_start,
-					  suspend_clocksource->mask);
-		nsec = mul_u64_u32_shr(delta, suspend_clocksource->mult,
-				       suspend_clocksource->shift);
-	}
+	if (now > suspend_start)
+		nsec = cycles_to_nsec_safe(suspend_clocksource, suspend_start, now);
 
 	/*
 	 * Disable the suspend timer to save power if current clocksource is
-- 
2.43.0


