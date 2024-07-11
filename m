Return-Path: <stable+bounces-59139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF9392EC48
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 18:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01931F24A54
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD015957E;
	Thu, 11 Jul 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9arS0BK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ma7Ss06n"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AD916C69E;
	Thu, 11 Jul 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714022; cv=none; b=tQedCMh0EhOfum9aA8uYCRLZM20q+oovbC7PIX1Oa++EFZxSzoRGbNkx85Uqw/bHeHb1iKan/n+QrU03spaDWhWp9ij0N16PHtdyGmPwzjppUIYgS8kkUUSUI+cAe8Z4dbNrdeZZBNqyPh9dmPB5l3yDcO4qo9mNhHfB9XEE8Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714022; c=relaxed/simple;
	bh=k/cUo7dH3Eo5j9NZX+3QsVBiaKAvS7c6muMxFDyM3Kg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S3SV0sNZylSSvk0jBRVayEj6uBe8QwYEQASCs11HoS+vnOSzhH3KrHabAMMAmrZ88j5v1Oalu6jG4miEb5cQA8WQwJc5rXGGG8CuawFoJUKMUm0R7DU6QqrMQMi8o9oxiM7CA7VVsxCav7i4hrBl4YhWjniWD+ftfNkgiTfkLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9arS0BK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ma7Ss06n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Jul 2024 16:06:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720714018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAGDyZyfCkgG40wlqg0n4WYmBPMmUk6LdRnbM3J6A/8=;
	b=M9arS0BKaHSrRdkGVOZ3J83FGdUF6uRtNGeR0m63EijHfCrN6H6POGpfjZkhgNccsr/Zyu
	FEAdqTWoJgNh05/FXzhuuyGxHedIwdVL4Hq8brKYY5/w2KiEG1tkIwgssP41agRx5HJBHt
	HyiYgfB9E5RQg8K+QITKDTJ3eh+3qu+1dIzJcDKL+tu/HHeNQ2EV++hUnwGzYCXpOyyzJj
	Vc13kufI9uWnAC5DRvI7A3W70GlbRc1opIhtHROkKS8z1nQiQdfL96or6M8JMGNMFgt8n3
	wYTvT+Dr0jvAvpv72SsuG+voXPBiC5fgJ162prvh2x9jcuXVR8ovDZIUuvQ2Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720714018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAGDyZyfCkgG40wlqg0n4WYmBPMmUk6LdRnbM3J6A/8=;
	b=Ma7Ss06nNOtx3RWA9rtSsrTSEtzY2zqrKOTLRUF+/47LQbQmukotb6ihaEb9hwcotINnf/
	rQE3gLK9HymECqAA==
From: "tip-bot2 for Yu Liao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/broadcast: Make takeover of broadcast hrtimer
 reliable
Cc: Yu Liao <liaoyu15@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240711124843.64167-1-liaoyu15@huawei.com>
References: <20240711124843.64167-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172071401838.2215.15659302983448251280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f7d43dd206e7e18c182f200e67a8db8c209907fa
Gitweb:        https://git.kernel.org/tip/f7d43dd206e7e18c182f200e67a8db8c209907fa
Author:        Yu Liao <liaoyu15@huawei.com>
AuthorDate:    Thu, 11 Jul 2024 20:48:43 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Jul 2024 18:00:24 +02:00

tick/broadcast: Make takeover of broadcast hrtimer reliable

Running the LTP hotplug stress test on a aarch64 machine results in
rcu_sched stall warnings when the broadcast hrtimer was owned by the
un-plugged CPU. The issue is the following:

CPU1 (owns the broadcast hrtimer)	CPU2

				tick_broadcast_enter()
				  // shutdown local timer device
				  broadcast_shutdown_local()
				...
				tick_broadcast_exit()
				  clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT)
				  // timer device is not programmed
				  cpumask_set_cpu(cpu, tick_broadcast_force_mask)

				initiates offlining of CPU1
take_cpu_down()
/*
 * CPU1 shuts down and does not
 * send broadcast IPI anymore
 */
				takedown_cpu()
				  hotplug_cpu__broadcast_tick_pull()
				    // move broadcast hrtimer to this CPU
				    clockevents_program_event()
				      bc_set_next()
					hrtimer_start()
					/*
					 * timer device is not programmed
					 * because only the first expiring
					 * timer will trigger clockevent
					 * device reprogramming
					 */

What happens is that CPU2 exits broadcast mode with force bit set, then the
local timer device is not reprogrammed and CPU2 expects to receive the
expired event by the broadcast IPI. But this does not happen because CPU1
is offlined by CPU2. CPU switches the clockevent device to ONESHOT state,
but does not reprogram the device.

The subsequent reprogramming of the hrtimer broadcast device does not
program the clockevent device of CPU2 either because the pending expiry
time is already in the past and the CPU expects the event to be delivered.
As a consequence all CPUs which wait for a broadcast event to be delivered
are stuck forever.

Fix this issue by reprogramming the local timer device if the broadcast
force bit of the CPU is set so that the broadcast hrtimer is delivered.

[ tglx: Massage comment and change log. Add Fixes tag ]

Fixes: 989dcb645ca7 ("tick: Handle broadcast wakeup of multiple cpus")
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240711124843.64167-1-liaoyu15@huawei.com
---
 kernel/time/tick-broadcast.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 771d1e0..b484309 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1141,6 +1141,7 @@ void tick_broadcast_switch_to_oneshot(void)
 #ifdef CONFIG_HOTPLUG_CPU
 void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 {
+	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *bc;
 	unsigned long flags;
 
@@ -1148,6 +1149,28 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 	bc = tick_broadcast_device.evtdev;
 
 	if (bc && broadcast_needs_cpu(bc, deadcpu)) {
+		/*
+		 * If the broadcast force bit of the current CPU is set,
+		 * then the current CPU has not yet reprogrammed the local
+		 * timer device to avoid a ping-pong race. See
+		 * ___tick_broadcast_oneshot_control().
+		 *
+		 * If the broadcast device is hrtimer based then
+		 * programming the broadcast event below does not have any
+		 * effect because the local clockevent device is not
+		 * running and not programmed because the broadcast event
+		 * is not earlier than the pending event of the local clock
+		 * event device. As a consequence all CPUs waiting for a
+		 * broadcast event are stuck forever.
+		 *
+		 * Detect this condition and reprogram the cpu local timer
+		 * device to avoid the starvation.
+		 */
+		if (tick_check_broadcast_expired()) {
+			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
+			tick_program_event(td->evtdev->next_event, 1);
+		}
+
 		/* This moves the broadcast assignment to this CPU: */
 		clockevents_program_event(bc, bc->next_event, 1);
 	}

