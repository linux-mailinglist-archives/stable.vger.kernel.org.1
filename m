Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4DB742C31
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjF2Sr1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjF2SrH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53202D55
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F028615E2
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4221BC433C8;
        Thu, 29 Jun 2023 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064421;
        bh=RZBDDT/RdEJIL5rNi3jrEECSEQ4P0H6KNvIMekKpX7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CC73XmyOHitkkSJNDxpB/n6WgIja0TPNjZkK7/MfIGUCarFUU2lYkYsTC68erXkd2
         enawE3MsxgDFQ8ceoQnEidEHxJBBgp6X0vrQEg5hz1W7MrGbRx+/OHRZSDBp2BYmeJ
         fYs7IkITeLOM55L3avBzKa0XqjGRArfnbTarx25s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Battersby <tonyb@cybernetics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 6.3 04/29] x86/smp: Make stop_other_cpus() more robust
Date:   Thu, 29 Jun 2023 20:43:34 +0200
Message-ID: <20230629184151.910531195@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.705870770@linuxfoundation.org>
References: <20230629184151.705870770@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 1f5e7eb7868e42227ac426c96d437117e6e06e8e upstream.

Tony reported intermittent lockups on poweroff. His analysis identified the
wbinvd() in stop_this_cpu() as the culprit. This was added to ensure that
on SME enabled machines a kexec() does not leave any stale data in the
caches when switching from encrypted to non-encrypted mode or vice versa.

That wbinvd() is conditional on the SME feature bit which is read directly
from CPUID. But that readout does not check whether the CPUID leaf is
available or not. If it's not available the CPU will return the value of
the highest supported leaf instead. Depending on the content the "SME" bit
might be set or not.

That's incorrect but harmless. Making the CPUID readout conditional makes
the observed hangs go away, but it does not fix the underlying problem:

CPU0					CPU1

 stop_other_cpus()
   send_IPIs(REBOOT);			stop_this_cpu()
   while (num_online_cpus() > 1);         set_online(false);
   proceed... -> hang
				          wbinvd()

WBINVD is an expensive operation and if multiple CPUs issue it at the same
time the resulting delays are even larger.

But CPU0 already observed num_online_cpus() going down to 1 and proceeds
which causes the system to hang.

This issue exists independent of WBINVD, but the delays caused by WBINVD
make it more prominent.

Make this more robust by adding a cpumask which is initialized to the
online CPU mask before sending the IPIs and CPUs clear their bit in
stop_this_cpu() after the WBINVD completed. Check for that cpumask to
become empty in stop_other_cpus() instead of watching num_online_cpus().

The cpumask cannot plug all holes either, but it's better than a raw
counter and allows to restrict the NMI fallback IPI to be sent only the
CPUs which have not reported within the timeout window.

Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
Reported-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com
Link: https://lore.kernel.org/r/87h6r770bv.ffs@tglx
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpu.h |    2 +
 arch/x86/kernel/process.c  |   23 +++++++++++++++-
 arch/x86/kernel/smp.c      |   62 +++++++++++++++++++++++++++++----------------
 3 files changed, 64 insertions(+), 23 deletions(-)

--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -98,4 +98,6 @@ extern u64 x86_read_arch_cap_msr(void);
 int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
 int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
 
+extern struct cpumask cpus_stop_mask;
+
 #endif /* _ASM_X86_CPU_H */
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -752,13 +752,23 @@ bool xen_set_default_idle(void)
 }
 #endif
 
+struct cpumask cpus_stop_mask;
+
 void __noreturn stop_this_cpu(void *dummy)
 {
+	unsigned int cpu = smp_processor_id();
+
 	local_irq_disable();
+
 	/*
-	 * Remove this CPU:
+	 * Remove this CPU from the online mask and disable it
+	 * unconditionally. This might be redundant in case that the reboot
+	 * vector was handled late and stop_other_cpus() sent an NMI.
+	 *
+	 * According to SDM and APM NMIs can be accepted even after soft
+	 * disabling the local APIC.
 	 */
-	set_cpu_online(smp_processor_id(), false);
+	set_cpu_online(cpu, false);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 
@@ -776,6 +786,15 @@ void __noreturn stop_this_cpu(void *dumm
 	 */
 	if (cpuid_eax(0x8000001f) & BIT(0))
 		native_wbinvd();
+
+	/*
+	 * This brings a cache line back and dirties it, but
+	 * native_stop_other_cpus() will overwrite cpus_stop_mask after it
+	 * observed that all CPUs reported stop. This write will invalidate
+	 * the related cache line on this CPU.
+	 */
+	cpumask_clear_cpu(cpu, &cpus_stop_mask);
+
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/proto.h>
 #include <asm/apic.h>
+#include <asm/cpu.h>
 #include <asm/idtentry.h>
 #include <asm/nmi.h>
 #include <asm/mce.h>
@@ -146,31 +147,43 @@ static int register_stop_handler(void)
 
 static void native_stop_other_cpus(int wait)
 {
-	unsigned long flags;
-	unsigned long timeout;
+	unsigned int cpu = smp_processor_id();
+	unsigned long flags, timeout;
 
 	if (reboot_force)
 		return;
 
-	/*
-	 * Use an own vector here because smp_call_function
-	 * does lots of things not suitable in a panic situation.
-	 */
+	/* Only proceed if this is the first CPU to reach this code */
+	if (atomic_cmpxchg(&stopping_cpu, -1, cpu) != -1)
+		return;
 
 	/*
-	 * We start by using the REBOOT_VECTOR irq.
-	 * The irq is treated as a sync point to allow critical
-	 * regions of code on other cpus to release their spin locks
-	 * and re-enable irqs.  Jumping straight to an NMI might
-	 * accidentally cause deadlocks with further shutdown/panic
-	 * code.  By syncing, we give the cpus up to one second to
-	 * finish their work before we force them off with the NMI.
+	 * 1) Send an IPI on the reboot vector to all other CPUs.
+	 *
+	 *    The other CPUs should react on it after leaving critical
+	 *    sections and re-enabling interrupts. They might still hold
+	 *    locks, but there is nothing which can be done about that.
+	 *
+	 * 2) Wait for all other CPUs to report that they reached the
+	 *    HLT loop in stop_this_cpu()
+	 *
+	 * 3) If #2 timed out send an NMI to the CPUs which did not
+	 *    yet report
+	 *
+	 * 4) Wait for all other CPUs to report that they reached the
+	 *    HLT loop in stop_this_cpu()
+	 *
+	 * #3 can obviously race against a CPU reaching the HLT loop late.
+	 * That CPU will have reported already and the "have all CPUs
+	 * reached HLT" condition will be true despite the fact that the
+	 * other CPU is still handling the NMI. Again, there is no
+	 * protection against that as "disabled" APICs still respond to
+	 * NMIs.
 	 */
-	if (num_online_cpus() > 1) {
-		/* did someone beat us here? */
-		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
-			return;
+	cpumask_copy(&cpus_stop_mask, cpu_online_mask);
+	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
+	if (!cpumask_empty(&cpus_stop_mask)) {
 		/* sync above data before sending IRQ */
 		wmb();
 
@@ -183,12 +196,12 @@ static void native_stop_other_cpus(int w
 		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
-		while (num_online_cpus() > 1 && timeout--)
+		while (!cpumask_empty(&cpus_stop_mask) && timeout--)
 			udelay(1);
 	}
 
 	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if (num_online_cpus() > 1) {
+	if (!cpumask_empty(&cpus_stop_mask)) {
 		/*
 		 * If NMI IPI is enabled, try to register the stop handler
 		 * and send the IPI. In any case try to wait for the other
@@ -200,7 +213,8 @@ static void native_stop_other_cpus(int w
 
 			pr_emerg("Shutting down cpus with NMI\n");
 
-			apic_send_IPI_allbutself(NMI_VECTOR);
+			for_each_cpu(cpu, &cpus_stop_mask)
+				apic->send_IPI(cpu, NMI_VECTOR);
 		}
 		/*
 		 * Don't wait longer than 10 ms if the caller didn't
@@ -208,7 +222,7 @@ static void native_stop_other_cpus(int w
 		 * one or more CPUs do not reach shutdown state.
 		 */
 		timeout = USEC_PER_MSEC * 10;
-		while (num_online_cpus() > 1 && (wait || timeout--))
+		while (!cpumask_empty(&cpus_stop_mask) && (wait || timeout--))
 			udelay(1);
 	}
 
@@ -216,6 +230,12 @@ static void native_stop_other_cpus(int w
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 	local_irq_restore(flags);
+
+	/*
+	 * Ensure that the cpus_stop_mask cache lines are invalidated on
+	 * the other CPUs. See comment vs. SME in stop_this_cpu().
+	 */
+	cpumask_clear(&cpus_stop_mask);
 }
 
 /*


