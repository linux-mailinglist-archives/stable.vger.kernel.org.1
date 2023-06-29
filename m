Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A4742C36
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjF2SpP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjF2So4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A2E3AA8
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3892615DC
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C30C433C8;
        Thu, 29 Jun 2023 18:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064282;
        bh=Cf+nWbM4Ptor9TESagN2X1izvK46KQyHFIELmV6ryso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DihfpGIOyZhKAI+PoVUKAAuz1kbSnQCjLwN2oOQR3WcRVCncJ3N+rUap8e8h6cwuY
         xkMY2WtK3EZ3EeBKizAgEAu4z+2YUYhJ0aL5+XAQ8pF8dlgVhi9L9oEPxAmNaseTib
         riDxYtvYZH1Z6kY8BUxlCqGyNxgC/1PSVAz/AaWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.1 11/30] x86/smp: Cure kexec() vs. mwait_play_dead() breakage
Date:   Thu, 29 Jun 2023 20:43:30 +0200
Message-ID: <20230629184152.118895023@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
References: <20230629184151.651069086@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit d7893093a7417527c0d73c9832244e65c9d0114f upstream.

TLDR: It's a mess.

When kexec() is executed on a system with offline CPUs, which are parked in
mwait_play_dead() it can end up in a triple fault during the bootup of the
kexec kernel or cause hard to diagnose data corruption.

The reason is that kexec() eventually overwrites the previous kernel's text,
page tables, data and stack. If it writes to the cache line which is
monitored by a previously offlined CPU, MWAIT resumes execution and ends
up executing the wrong text, dereferencing overwritten page tables or
corrupting the kexec kernels data.

Cure this by bringing the offlined CPUs out of MWAIT into HLT.

Write to the monitored cache line of each offline CPU, which makes MWAIT
resume execution. The written control word tells the offlined CPUs to issue
HLT, which does not have the MWAIT problem.

That does not help, if a stray NMI, MCE or SMI hits the offlined CPUs as
those make it come out of HLT.

A follow up change will put them into INIT, which protects at least against
NMI and SMI.

Fixes: ea53069231f9 ("x86, hotplug: Use mwait to offline a processor, fix the legacy case")
Reported-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615193330.492257119@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/smp.h |    2 +
 arch/x86/kernel/smp.c      |    5 +++
 arch/x86/kernel/smpboot.c  |   59 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -132,6 +132,8 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 void cond_wakeup_cpu0(void);
 
+void smp_kick_mwait_play_dead(void);
+
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/gfp.h>
+#include <linux/kexec.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -157,6 +158,10 @@ static void native_stop_other_cpus(int w
 	if (atomic_cmpxchg(&stopping_cpu, -1, cpu) != -1)
 		return;
 
+	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
+	if (kexec_in_progress)
+		smp_kick_mwait_play_dead();
+
 	/*
 	 * 1) Send an IPI on the reboot vector to all other CPUs.
 	 *
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -53,6 +53,7 @@
 #include <linux/tboot.h>
 #include <linux/gfp.h>
 #include <linux/cpuidle.h>
+#include <linux/kexec.h>
 #include <linux/numa.h>
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
@@ -104,6 +105,9 @@ struct mwait_cpu_dead {
 	unsigned int	status;
 };
 
+#define CPUDEAD_MWAIT_WAIT	0xDEADBEEF
+#define CPUDEAD_MWAIT_KEXEC_HLT	0x4A17DEAD
+
 /*
  * Cache line aligned data for mwait_play_dead(). Separate on purpose so
  * that it's unlikely to be touched by other CPUs.
@@ -166,6 +170,10 @@ static void smp_callin(void)
 {
 	int cpuid;
 
+	/* Mop up eventual mwait_play_dead() wreckage */
+	this_cpu_write(mwait_cpu_dead.status, 0);
+	this_cpu_write(mwait_cpu_dead.control, 0);
+
 	/*
 	 * If waken up by an INIT in an 82489DX configuration
 	 * cpu_callout_mask guarantees we don't get here before
@@ -1795,6 +1803,10 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
+	/* Set up state for the kexec() hack below */
+	md->status = CPUDEAD_MWAIT_WAIT;
+	md->control = CPUDEAD_MWAIT_WAIT;
+
 	wbinvd();
 
 	while (1) {
@@ -1812,10 +1824,57 @@ static inline void mwait_play_dead(void)
 		mb();
 		__mwait(eax, 0);
 
+		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
+			/*
+			 * Kexec is about to happen. Don't go back into mwait() as
+			 * the kexec kernel might overwrite text and data including
+			 * page tables and stack. So mwait() would resume when the
+			 * monitor cache line is written to and then the CPU goes
+			 * south due to overwritten text, page tables and stack.
+			 *
+			 * Note: This does _NOT_ protect against a stray MCE, NMI,
+			 * SMI. They will resume execution at the instruction
+			 * following the HLT instruction and run into the problem
+			 * which this is trying to prevent.
+			 */
+			WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
+			while(1)
+				native_halt();
+		}
+
 		cond_wakeup_cpu0();
 	}
 }
 
+/*
+ * Kick all "offline" CPUs out of mwait on kexec(). See comment in
+ * mwait_play_dead().
+ */
+void smp_kick_mwait_play_dead(void)
+{
+	u32 newstate = CPUDEAD_MWAIT_KEXEC_HLT;
+	struct mwait_cpu_dead *md;
+	unsigned int cpu, i;
+
+	for_each_cpu_andnot(cpu, cpu_present_mask, cpu_online_mask) {
+		md = per_cpu_ptr(&mwait_cpu_dead, cpu);
+
+		/* Does it sit in mwait_play_dead() ? */
+		if (READ_ONCE(md->status) != CPUDEAD_MWAIT_WAIT)
+			continue;
+
+		/* Wait up to 5ms */
+		for (i = 0; READ_ONCE(md->status) != newstate && i < 1000; i++) {
+			/* Bring it out of mwait */
+			WRITE_ONCE(md->control, newstate);
+			udelay(5);
+		}
+
+		if (READ_ONCE(md->status) != newstate)
+			pr_err_once("CPU%u is stuck in mwait_play_dead()\n", cpu);
+	}
+}
+
 void hlt_play_dead(void)
 {
 	if (__this_cpu_read(cpu_info.x86) >= 4)


