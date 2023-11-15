Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375087DD56C
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjJaRum (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjJaRul (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:50:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A3DA2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:50:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66898C433C7;
        Tue, 31 Oct 2023 17:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774638;
        bh=ox3QIHgcbOO2wZnJsePBzOURl5k3NCc8PjmR5NpPsJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sPzb22Vhm/UwEme7EbPLT5EiHO78sQyuHpHXF0L0uu3elc0yUOLbsNpbTNKR8UvQH
         c6CHPQDvy+I128VYH2HjYSbi9rKgUaPX0e5K7qLSZCDj5Z6V9KINAzag7leGJ4gCbB
         kBolyrh6W4rWPUmgkfM27SDx19dyUZT5VT5Hw2nA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.5 102/112] x86/tsc: Defer marking TSC unstable to a worker
Date:   Tue, 31 Oct 2023 18:01:43 +0100
Message-ID: <20231031165904.488815457@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit bd94d86f490b70c58b3fc5739328a53ad4b18d86 upstream.

Tetsuo reported the following lockdep splat when the TSC synchronization
fails during CPU hotplug:

   tsc: Marking TSC unstable due to check_tsc_sync_source failed

   WARNING: inconsistent lock state
   inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
   ffffffff8cfa1c78 (watchdog_lock){?.-.}-{2:2}, at: clocksource_watchdog+0x23/0x5a0
   {IN-HARDIRQ-W} state was registered at:
     _raw_spin_lock_irqsave+0x3f/0x60
     clocksource_mark_unstable+0x1b/0x90
     mark_tsc_unstable+0x41/0x50
     check_tsc_sync_source+0x14f/0x180
     sysvec_call_function_single+0x69/0x90

   Possible unsafe locking scenario:
     lock(watchdog_lock);
     <Interrupt>
       lock(watchdog_lock);

   stack backtrace:
    _raw_spin_lock+0x30/0x40
    clocksource_watchdog+0x23/0x5a0
    run_timer_softirq+0x2a/0x50
    sysvec_apic_timer_interrupt+0x6e/0x90

The reason is the recent conversion of the TSC synchronization function
during CPU hotplug on the control CPU to a SMP function call. In case
that the synchronization with the upcoming CPU fails, the TSC has to be
marked unstable via clocksource_mark_unstable().

clocksource_mark_unstable() acquires 'watchdog_lock', but that lock is
taken with interrupts enabled in the watchdog timer callback to minimize
interrupt disabled time. That's obviously a possible deadlock scenario,

Before that change the synchronization function was invoked in thread
context so this could not happen.

As it is not crucical whether the unstable marking happens slightly
delayed, defer the call to a worker thread which avoids the lock context
problem.

Fixes: 9d349d47f0e3 ("x86/smpboot: Make TSC synchronization function call based")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/87zg064ceg.ffs@tglx
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/tsc_sync.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index bbc440c93e08..1123ef3ccf90 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -15,6 +15,7 @@
  * ( The serial nature of the boot logic and the CPU hotplug lock
  *   protects against more than 2 CPUs entering this code. )
  */
+#include <linux/workqueue.h>
 #include <linux/topology.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
@@ -342,6 +343,13 @@ static inline unsigned int loop_timeout(int cpu)
 	return (cpumask_weight(topology_core_cpumask(cpu)) > 1) ? 2 : 20;
 }
 
+static void tsc_sync_mark_tsc_unstable(struct work_struct *work)
+{
+	mark_tsc_unstable("check_tsc_sync_source failed");
+}
+
+static DECLARE_WORK(tsc_sync_work, tsc_sync_mark_tsc_unstable);
+
 /*
  * The freshly booted CPU initiates this via an async SMP function call.
  */
@@ -395,7 +403,7 @@ retry:
 			"turning off TSC clock.\n", max_warp);
 		if (random_warps)
 			pr_warn("TSC warped randomly between CPUs\n");
-		mark_tsc_unstable("check_tsc_sync_source failed");
+		schedule_work(&tsc_sync_work);
 	}
 
 	/*
-- 
2.42.0



