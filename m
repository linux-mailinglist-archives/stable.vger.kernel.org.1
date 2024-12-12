Return-Path: <stable+bounces-100912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8329EE74C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4122188837E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296F8212F9E;
	Thu, 12 Dec 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TDKGixqk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98D211A1B
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008587; cv=none; b=gmwAN6vpodWZ/xZ83Yz73eN9hfC/l8zjqzn6QBuGPkpJ4s6OaJKjYBgQnH/cVZOPzTZ5rBtD5isM0iEJzCcsDsBRQtbbxCtNkVfkuX2cG2/nMGXzHgveE9j3BleLJDe4Jg3LOOdGGNcLjOQSqADOnKah84cfHaiT/UIvFQ1tjEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008587; c=relaxed/simple;
	bh=KufcWWUbMAXgDiyf33gtiJ6TcMsJc3Bpi8AAik0o+Jo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MbR6FZxdzwM3eGG1kEFSwrQVLaSLYgT+YXLKQWbtQ3aQDZN++P7XJpYGJpIQGZgcaOOH5SQ2ef+FLXSUGY88Yept5zkesK771NE0K6OzTqpuLVuyggMYO4TVrIov+Jrhjcc51RKjeUrLqnwkzYwTvctTV7UwbvpGXiu2jKeKAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TDKGixqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3B2C4CECE;
	Thu, 12 Dec 2024 13:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734008586;
	bh=KufcWWUbMAXgDiyf33gtiJ6TcMsJc3Bpi8AAik0o+Jo=;
	h=Subject:To:Cc:From:Date:From;
	b=TDKGixqk73eEJVeDcPx+oon6b8+TWTiQSIrsegfM+CLlsar49vDZgNtWiSoRfg0LE
	 eesHpiqWwy3RBoUfoCujtQQCT/rjQiybPHBXMCsCUsmdfkIZAdoeX/FAlGQ+kRReBR
	 E1WsgYZaEX6pQFDeUg1d/FffpBqL5fWSCd7ypHyU=
Subject: FAILED: patch "[PATCH] clocksource: Make negative motion detection more robust" failed to apply to 6.12-stable tree
To: tglx@linutronix.de,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 12 Dec 2024 14:03:03 +0100
Message-ID: <2024121203-griminess-blah-4e97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 76031d9536a076bf023bedbdb1b4317fc801dd67
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121203-griminess-blah-4e97@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76031d9536a076bf023bedbdb1b4317fc801dd67 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 3 Dec 2024 11:16:30 +0100
Subject: [PATCH] clocksource: Make negative motion detection more robust

Guenter reported boot stalls on a emulated ARM 32-bit platform, which has a
24-bit wide clocksource.

It turns out that the calculated maximal idle time, which limits idle
sleeps to prevent clocksource wrap arounds, is close to the point where the
negative motion detection triggers.

  max_idle_ns:                    597268854 ns
  negative motion tripping point: 671088640 ns

If the idle wakeup is delayed beyond that point, the clocksource
advances far enough to trigger the negative motion detection. This
prevents the clock to advance and in the worst case the system stalls
completely if the consecutive sleeps based on the stale clock are
delayed as well.

Cure this by calculating a more robust cut-off value for negative motion,
which covers 87.5% of the actual clocksource counter width. Compare the
delta against this value to catch negative motion. This is specifically for
clock sources with a small counter width as their wrap around time is close
to the half counter width. For clock sources with wide counters this is not
a problem because the maximum idle time is far from the half counter width
due to the math overflow protection constraints.

For the case at hand this results in a tripping point of 1174405120ns.

Note, that this cannot prevent issues when the delay exceeds the 87.5%
margin, but that's not different from the previous unchecked version which
allowed arbitrary time jumps.

Systems with small counter width are prone to invalid results, but this
problem is unlikely to be seen on real hardware. If such a system
completely stalls for more than half a second, then there are other more
urgent problems than the counter wrapping around.

Fixes: c163e40af9b2 ("timekeeping: Always check for negative motion")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/8734j5ul4x.ffs@tglx
Closes: https://lore.kernel.org/all/387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index ef1b16da6ad5..65b7c41471c3 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -49,6 +49,7 @@ struct module;
  * @archdata:		Optional arch-specific data
  * @max_cycles:		Maximum safe cycle value which won't overflow on
  *			multiplication
+ * @max_raw_delta:	Maximum safe delta value for negative motion detection
  * @name:		Pointer to clocksource name
  * @list:		List head for registration (internal)
  * @freq_khz:		Clocksource frequency in khz.
@@ -109,6 +110,7 @@ struct clocksource {
 	struct arch_clocksource_data archdata;
 #endif
 	u64			max_cycles;
+	u64			max_raw_delta;
 	const char		*name;
 	struct list_head	list;
 	u32			freq_khz;
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index aab6472853fa..7304d7cf47f2 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -24,7 +24,7 @@ static void clocksource_enqueue(struct clocksource *cs);
 
 static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u64 end)
 {
-	u64 delta = clocksource_delta(end, start, cs->mask);
+	u64 delta = clocksource_delta(end, start, cs->mask, cs->max_raw_delta);
 
 	if (likely(delta < cs->max_cycles))
 		return clocksource_cyc2ns(delta, cs->mult, cs->shift);
@@ -993,6 +993,15 @@ static inline void clocksource_update_max_deferment(struct clocksource *cs)
 	cs->max_idle_ns = clocks_calc_max_nsecs(cs->mult, cs->shift,
 						cs->maxadj, cs->mask,
 						&cs->max_cycles);
+
+	/*
+	 * Threshold for detecting negative motion in clocksource_delta().
+	 *
+	 * Allow for 0.875 of the counter width so that overly long idle
+	 * sleeps, which go slightly over mask/2, do not trigger the
+	 * negative motion detection.
+	 */
+	cs->max_raw_delta = (cs->mask >> 1) + (cs->mask >> 2) + (cs->mask >> 3);
 }
 
 static struct clocksource *clocksource_find_best(bool oneshot, bool skipcur)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0ca85ff4fbb4..3d128825d343 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -755,7 +755,8 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 	u64 cycle_now, delta;
 
 	cycle_now = tk_clock_read(&tk->tkr_mono);
-	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
+	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
+				  tk->tkr_mono.clock->max_raw_delta);
 	tk->tkr_mono.cycle_last = cycle_now;
 	tk->tkr_raw.cycle_last  = cycle_now;
 
@@ -2230,7 +2231,8 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 		return false;
 
 	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
-				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
+				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
+				   tk->tkr_mono.clock->max_raw_delta);
 
 	/* Check if there's really nothing to do */
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 63e600e943a7..8c9079108ffb 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -30,15 +30,15 @@ static inline void timekeeping_inc_mg_floor_swaps(void)
 
 #endif
 
-static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
+static inline u64 clocksource_delta(u64 now, u64 last, u64 mask, u64 max_delta)
 {
 	u64 ret = (now - last) & mask;
 
 	/*
-	 * Prevent time going backwards by checking the MSB of mask in
-	 * the result. If set, return 0.
+	 * Prevent time going backwards by checking the result against
+	 * @max_delta. If greater, return 0.
 	 */
-	return ret & ~(mask >> 1) ? 0 : ret;
+	return ret > max_delta ? 0 : ret;
 }
 
 /* Semi public for serialization of non timekeeper VDSO updates. */


