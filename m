Return-Path: <stable+bounces-52606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5972F90BC3E
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 22:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6641C22AF8
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E10197A62;
	Mon, 17 Jun 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hfoHj61h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="409rWPFX"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123EC8E1
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656514; cv=none; b=VdR2oF9+7NnKyA4n/WAOR2A+GhM/R8Emi911Cej6KCQQ8LiXH3C6vYMkpX4XtKI2WOxLQ38n+lhyT+4GduHoxnlKgYHu7hdRCYKcOHYXLqM3/ZpAzZ4hZrFOJ3nT9/43+kqbYOac03vu5nAXmrQ5gSh2g+wEJVW3f9c8pvVRm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656514; c=relaxed/simple;
	bh=OBytqoJYtnKAKc+6RdBm2QtxKrzKXI43MP1S2MlfGOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CbU8RwY2yvscKxLxTKMTsDIbT8sRnxdgBE8PqIQeicr97kEMRQkJ3NdEy0975r/qJQxXUSi4lPi40JmhwKXOlh+lgwhc2rwJTru2wlQdb7et4lYrMWtLEhcjMnNSMGZ9s31XP3uv6ZOoqLg87D40cfCYzyrV4pAerjHzS183Bpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hfoHj61h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=409rWPFX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718656511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FDeagGCN7NpJ2oUlMcOvt0L9n25wpjBn2Aor03CJ9uQ=;
	b=hfoHj61he12acouG2ub78E3bL5u1aYa6S1lAbR5AGa8NhXCdlNlCyePUY/OQeLxr/RB3s7
	+g5EGWe/zsxMzCBqAnr9zBFU+xlS6imgaXHjTcOiSAf21pw+9IUY/UafboFivB1RhatAgA
	MULtaNcC5DV5gsc/2EZ57W+/dLnbhiZe4RjhZVOe4er8GDd87Z0gIo+JtT4Pf8xW+mNCeL
	MONURQfc5jtnowLk3qaok6UczAJPQQBDwklj5bPjAJbKGUNSdMm6svNnJR1SQsZiWEm6v3
	u/TIdT+TLIwEds/HWCJrSWGCWJDlW34DUz3BbglVhal4azlYSL083R30S8FPsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718656511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FDeagGCN7NpJ2oUlMcOvt0L9n25wpjBn2Aor03CJ9uQ=;
	b=409rWPFXwPh4KaiJxNKwRd2pnr4XKl/W/N6dNeAEyg56tLPsfhJMFQEM/jbl9jvgmKfKvW
	HcrM0m+xoe/TVcDA==
To: gregkh@linuxfoundation.org, oleg@redhat.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y and earlier] tick/nohz_full: Don't abuse
 smp_call_function_single() in tick_setup_device()
In-Reply-To: <2024061706-smudgy-gumball-93c0@gregkh>
References: <2024061706-smudgy-gumball-93c0@gregkh>
Date: Mon, 17 Jun 2024 22:35:10 +0200
Message-ID: <87ed8vs3y9.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


From: Oleg Nesterov <oleg@redhat.com>

commit 07c54cc5988f19c9642fd463c2dbdac7fc52f777 upstream.

After the recent commit 5097cbcb38e6 ("sched/isolation: Prevent boot crash
when the boot CPU is nohz_full") the kernel no longer crashes, but there is
another problem.

In this case tick_setup_device() calls tick_take_do_timer_from_boot() to
update tick_do_timer_cpu and this triggers the WARN_ON_ONCE(irqs_disabled)
in smp_call_function_single().

Kill tick_take_do_timer_from_boot() and just use WRITE_ONCE(), the new
comment explains why this is safe (thanks Thomas!).

Fixes: 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240528122019.GA28794@redhat.com
Link: https://lore.kernel.org/all/20240522151742.GA10400@redhat.com
---
Backport to v6.6.y and earlier
---
 kernel/time/tick-common.c |   42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -177,26 +177,6 @@ void tick_setup_periodic(struct clock_ev
 	}
 }
 
-#ifdef CONFIG_NO_HZ_FULL
-static void giveup_do_timer(void *info)
-{
-	int cpu = *(unsigned int *)info;
-
-	WARN_ON(tick_do_timer_cpu != smp_processor_id());
-
-	tick_do_timer_cpu = cpu;
-}
-
-static void tick_take_do_timer_from_boot(void)
-{
-	int cpu = smp_processor_id();
-	int from = tick_do_timer_boot_cpu;
-
-	if (from >= 0 && from != cpu)
-		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
-}
-#endif
-
 /*
  * Setup the tick device
  */
@@ -220,19 +200,25 @@ static void tick_setup_device(struct tic
 			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
-			 * The boot CPU may be nohz_full, in which case set
-			 * tick_do_timer_boot_cpu so the first housekeeping
-			 * secondary that comes up will take do_timer from
-			 * us.
+			 * The boot CPU may be nohz_full, in which case the
+			 * first housekeeping secondary will take do_timer()
+			 * from it.
 			 */
 			if (tick_nohz_full_cpu(cpu))
 				tick_do_timer_boot_cpu = cpu;
 
-		} else if (tick_do_timer_boot_cpu != -1 &&
-						!tick_nohz_full_cpu(cpu)) {
-			tick_take_do_timer_from_boot();
+		} else if (tick_do_timer_boot_cpu != -1 && !tick_nohz_full_cpu(cpu)) {
 			tick_do_timer_boot_cpu = -1;
-			WARN_ON(tick_do_timer_cpu != cpu);
+			/*
+			 * The boot CPU will stay in periodic (NOHZ disabled)
+			 * mode until clocksource_done_booting() called after
+			 * smp_init() selects a high resolution clocksource and
+			 * timekeeping_notify() kicks the NOHZ stuff alive.
+			 *
+			 * So this WRITE_ONCE can only race with the READ_ONCE
+			 * check in tick_periodic() but this race is harmless.
+			 */
+			WRITE_ONCE(tick_do_timer_cpu, cpu);
 #endif
 		}
 

