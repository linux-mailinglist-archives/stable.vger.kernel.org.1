Return-Path: <stable+bounces-50111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22669028A6
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 20:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E01C1F21EF1
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F741494B9;
	Mon, 10 Jun 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hojsg24F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XZx53xQD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB3147C74;
	Mon, 10 Jun 2024 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043986; cv=none; b=dHt1KY3IzQ22q91xIr3fK+Oe068k2LkE4AngfNlVZyZrVSUZgBm0a4klTLIXjEmMxg57Hm4+UIZNG78fHZbBTapSnAv4tLJTJTs8pwZU3fGtYR8s4XcUewSxlKa3eSiZTxc6870pw1MIdly+V/RLQG/CytV3YUFrWXFe2NgOSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043986; c=relaxed/simple;
	bh=NB6uKNBRhesh/bGHTHz2+3wjDrsHamI6Xa28lGDgbsw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p5qVS0p5asxD55pARrAYc8+QcLn5TvrAMZ9nxcj6DC/jyHJZz6l5xBNH4sS+Y94slkv6eTD0nZu0UjLOuHa9uMudNi44jO3SnzRHSsStJ0gSNi5fKdZJh8YIOCM1M7eo82bpegUsTyIaTb7SDSmFMwy38XtEonyaUKPxS2in7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hojsg24F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XZx53xQD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Jun 2024 18:26:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718043982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1rbopp/c/YrNiZNFagLV/gFV+MgNRT3mcwHObKLgRI=;
	b=Hojsg24FHmyk6jBZsFSg8IB1jk6uAX4vZ5j2UQojuxC3ndeuLA36N0zqQ0SIWJDT4zxjne
	sdCKO7q6+kzZXjuGDYStVn0WrZilvY+Pj6hOPC7RVOE5a3zHz/pXo/AJdXGSV8sy8UDHLt
	TWxosrARZj9DWy+iuURAkU/KeVbhxixUDmOMZkA3qH1Fbqzp6M7ea2TtX1I3zZayFAwuKI
	pNx4NTxNRh1EKIbSp7+ESCGIsIh+8j0pT5JqyWS8IZ0xiDSVRzc/RYvILj9MUnURvcbDqq
	xiYKpuUAV6RZkdD+Hs8ZyRjFfKJG0QS1zsE4WcvfToU5mvv9vZLU2M2EN4ZHjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718043982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1rbopp/c/YrNiZNFagLV/gFV+MgNRT3mcwHObKLgRI=;
	b=XZx53xQDUpG6t+jL5MHuF7ji2YT5CTF0BLom+DDsJ6itdcT/rPwLGhJU9PO4hUpDHXx0+k
	H1EurmWdUtSSxhCQ==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/nohz_full: Don't abuse
 smp_call_function_single() in tick_setup_device()
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240528122019.GA28794@redhat.com>
References: <20240528122019.GA28794@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171804398181.10875.7931386382573929520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     07c54cc5988f19c9642fd463c2dbdac7fc52f777
Gitweb:        https://git.kernel.org/tip/07c54cc5988f19c9642fd463c2dbdac7fc52f777
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Tue, 28 May 2024 14:20:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 10 Jun 2024 20:18:13 +02:00

tick/nohz_full: Don't abuse smp_call_function_single() in tick_setup_device()

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
 kernel/time/tick-common.c | 42 ++++++++++++--------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index d88b130..a47bcf7 100644
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
 

