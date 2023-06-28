Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE827418EF
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 21:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjF1TiR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 15:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjF1TiR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 15:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9671EA2
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 12:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 265D26139D
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 19:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38651C433C8;
        Wed, 28 Jun 2023 19:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687981094;
        bh=xULRKn8CqpK+nTls9lNz4b0TwnM3S/NFaUgiuf/Cu3Y=;
        h=Subject:To:Cc:From:Date:From;
        b=Rup8BaHry+RUnRMwyetVXObP8sm05UnTMiipYXWzdx3d9mWTSYxIrtrYDgMmV3B/i
         53JuylZkZvCw3ixYuWl2VucBxx7D0PxLrINgkmsy5BMf2IoytREPJe8GGM5VhHdJpU
         otP62Q8K5gV6VrTtvvZRcrKWCKRhNTSUy7qohEvk=
Subject: FAILED: patch "[PATCH] x86/smp: Cure kexec() vs. mwait_play_dead() breakage" failed to apply to 4.14-stable tree
To:     tglx@linutronix.de, ashok.raj@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 28 Jun 2023 21:38:06 +0200
Message-ID: <2023062806-handcuff-depress-af1d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x d7893093a7417527c0d73c9832244e65c9d0114f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062806-handcuff-depress-af1d@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d7893093a7417527c0d73c9832244e65c9d0114f Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 15 Jun 2023 22:33:57 +0200
Subject: [PATCH] x86/smp: Cure kexec() vs. mwait_play_dead() breakage

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

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4e91054c84be..d4ce5cb5c953 100644
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
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index d842875f986f..174d6232b87f 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/gfp.h>
+#include <linux/kexec.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -157,6 +158,10 @@ static void native_stop_other_cpus(int wait)
 	if (atomic_cmpxchg(&stopping_cpu, -1, cpu) != -1)
 		return;
 
+	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
+	if (kexec_in_progress)
+		smp_kick_mwait_play_dead();
+
 	/*
 	 * 1) Send an IPI on the reboot vector to all other CPUs.
 	 *
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c5ac5d74cdd4..483df0427678 100644
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
@@ -106,6 +107,9 @@ struct mwait_cpu_dead {
 	unsigned int	status;
 };
 
+#define CPUDEAD_MWAIT_WAIT	0xDEADBEEF
+#define CPUDEAD_MWAIT_KEXEC_HLT	0x4A17DEAD
+
 /*
  * Cache line aligned data for mwait_play_dead(). Separate on purpose so
  * that it's unlikely to be touched by other CPUs.
@@ -173,6 +177,10 @@ static void smp_callin(void)
 {
 	int cpuid;
 
+	/* Mop up eventual mwait_play_dead() wreckage */
+	this_cpu_write(mwait_cpu_dead.status, 0);
+	this_cpu_write(mwait_cpu_dead.control, 0);
+
 	/*
 	 * If waken up by an INIT in an 82489DX configuration
 	 * cpu_callout_mask guarantees we don't get here before
@@ -1807,6 +1815,10 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
+	/* Set up state for the kexec() hack below */
+	md->status = CPUDEAD_MWAIT_WAIT;
+	md->control = CPUDEAD_MWAIT_WAIT;
+
 	wbinvd();
 
 	while (1) {
@@ -1824,10 +1836,57 @@ static inline void mwait_play_dead(void)
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
 void __noreturn hlt_play_dead(void)
 {
 	if (__this_cpu_read(cpu_info.x86) >= 4)

