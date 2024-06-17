Return-Path: <stable+bounces-52576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E3190B891
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 19:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D594285494
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA4E18EFF9;
	Mon, 17 Jun 2024 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZXTwYi9F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A716CD3D
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646861; cv=none; b=lij/0ADNfUcECOywO7lDgkGmbPfyqWGK5Jrweyv5/9ceHWCv7h3MqIY4sicQSVvut3SwdUKFbfOXOwiywSUX2NDHatSWHP3hsE4Qv3IzE6ayqHQe+0LRmjKeu0ghpBRk+CHr1IsBGKBPhh+tZW3HCDDJKGNzzYLq4rRxeKPwUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646861; c=relaxed/simple;
	bh=hZOPCOpRpihDMabGBVfDTlPHah9HCfRJpyhLY+cURL4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rEDhMd+394MB43WN9zCqQUjS3+13pm2P0cz/Cx/WljcIRMCVTxIuQrLXX94VJj61IRW70ARdYHJPzM/eEnDbuRD2/0YRnt9DQzgMyQWGzUb7dkX4j5WFYvHJl956fNKTgu6OmEqJ4xq4KGf3tWKX5TNkqYl5nw7zrsKdtNqRgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZXTwYi9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27978C2BD10;
	Mon, 17 Jun 2024 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718646861;
	bh=hZOPCOpRpihDMabGBVfDTlPHah9HCfRJpyhLY+cURL4=;
	h=Subject:To:Cc:From:Date:From;
	b=ZXTwYi9F7MTGHuBsqn78AfxPwVSgsj3Ba4ncd3f1MRxDh0o/VAXI8QqNtn2K9dfbS
	 +1RpJANLnc+K+DbLMuuJ6nLtTK4o23+7iI2DEeNbP2bgDOointP1udHC6B6ot8/W5Z
	 zU1N0rynvs5evLKkTYsO7aZFr0jKfqqNAj+9FbQ8=
Subject: FAILED: patch "[PATCH] tick/nohz_full: Don't abuse smp_call_function_single() in" failed to apply to 5.4-stable tree
To: oleg@redhat.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 19:54:09 +0200
Message-ID: <2024061709-nearly-woozy-adfe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 07c54cc5988f19c9642fd463c2dbdac7fc52f777
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061709-nearly-woozy-adfe@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

07c54cc5988f ("tick/nohz_full: Don't abuse smp_call_function_single() in tick_setup_device()")
f87cbcb345d0 ("timekeeping: Use READ/WRITE_ONCE() for tick_do_timer_cpu")
a478ffb2ae23 ("tick: Move individual bit features to debuggable mask accesses")
3ce74f1a8566 ("tick: Move got_idle_tick away from common flags")
3ad6eb0683a1 ("tick: Start centralizing tick related CPU hotplug operations")
3650f49bfb95 ("tick/sched: Rename tick_nohz_stop_sched_tick() to tick_nohz_full_stop_tick()")
27dc08096ce4 ("tick: Use IS_ENABLED() whenever possible")
37263ba0c44b ("tick/nohz: Remove duplicate between lowres and highres handlers")
ffb7e01c4e65 ("tick/nohz: Remove duplicate between tick_nohz_switch_to_nohz() and tick_setup_sched_timer()")
4c532939aa2e ("tick/sched: Split out jiffies update helper function")
73129cf4b69c ("timers: Optimization for timer_base_try_to_set_idle()")
e2e1d724e948 ("timers: Move marking timer bases idle into tick_nohz_stop_tick()")
39ed699fb660 ("timers: Split out get next timer interrupt")
bebed6649e85 ("timers: Restructure get_next_timer_interrupt()")
f365d0550615 ("tick/sched: Add function description for tick_nohz_next_event()")
da65f29dada7 ("timers: Fix nextevt calculation when no timers are pending")
bb8caad5083f ("timers: Rework idle logic")
7a39a5080ef0 ("timers: Use already existing function for forwarding timer base")
b5e6f59888c7 ("timers: Move store of next event into __next_timer_interrupt()")
b573c73101d8 ("tracing/timers: Add tracepoint for tracking timer base is_idle flag")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07c54cc5988f19c9642fd463c2dbdac7fc52f777 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 28 May 2024 14:20:19 +0200
Subject: [PATCH] tick/nohz_full: Don't abuse smp_call_function_single() in
 tick_setup_device()

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

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index d88b13076b79..a47bcf71defc 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -178,26 +178,6 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
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
@@ -221,19 +201,25 @@ static void tick_setup_device(struct tick_device *td,
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
-			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
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
 


