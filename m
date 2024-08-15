Return-Path: <stable+bounces-68974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A29534D8
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493AAB22468
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DCC14AD0A;
	Thu, 15 Aug 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eVlctucH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28A63D5;
	Thu, 15 Aug 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732261; cv=none; b=qoMDjNg3DaMtkleq0cezPbIMR2AnMYeTbyn1IIsDFKG4Pmb0UXo0VKgYNxUZJ3NDmHZU0EoTbE8dnsTWKsoOZaIhGoynakeCEZfEhTF/zE6+fgz3CPVVDpA97VCQkDC7VR6OjLpm0RjcdgQRainbSbdsyQ0Eexon8cxX17QBsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732261; c=relaxed/simple;
	bh=c1e0X4SpDeWuyNGucsKRrYjbCIygFeJBqu6PfGV6Vyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB7cGn3anA7AoDusWta7O5sO43IBI0ejMw3XdTclbrYBcG4XRSFRZ2Nkz3S02Bu1nhRfB0vIM1IOlS6+/q4dYCQEkEjPFJ2jaUACvab6R+PIg9LCOngNRNI0zULHyVSWat/3FQ4wkkl25EVnCfORDfNLChVgGW6TKlRPgupaJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVlctucH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42AAC32786;
	Thu, 15 Aug 2024 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732261;
	bh=c1e0X4SpDeWuyNGucsKRrYjbCIygFeJBqu6PfGV6Vyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVlctucHpaZLSrZpgmc1QtdrdgovvAkhC2Utyd/9tCMFFdq0S2xZt4TLJoNAoKWLb
	 ZvA4X4/B97ru+L/Mt51n4BIKvmkyCQCmM94fAF1GFZN9TK8/oOyDuWVq4jItUgI9e6
	 VHgldgWInAxxNB3LNNqt0nOkChpJEc9mfG9b9yYc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Liao <liaoyu15@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.10 125/352] tick/broadcast: Make takeover of broadcast hrtimer reliable
Date: Thu, 15 Aug 2024 15:23:11 +0200
Message-ID: <20240815131924.084942835@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Liao <liaoyu15@huawei.com>

commit f7d43dd206e7e18c182f200e67a8db8c209907fa upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/tick-broadcast.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -944,6 +944,7 @@ void tick_broadcast_switch_to_oneshot(vo
 #ifdef CONFIG_HOTPLUG_CPU
 void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 {
+	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *bc;
 	unsigned long flags;
 
@@ -951,6 +952,28 @@ void hotplug_cpu__broadcast_tick_pull(in
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



