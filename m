Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B172799B80
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 23:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjIIVxv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 17:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIIVxv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 17:53:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D1BB
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 14:53:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B727DC433C7;
        Sat,  9 Sep 2023 21:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694296426;
        bh=f+03fpvdj6SoWA14l49IzbtciO9x/WgU/uJY8GrJazA=;
        h=Subject:To:Cc:From:Date:From;
        b=dcVNrX+RVwx6u/YjzQPv/NSdV2dVY5e1n4RA8W7OcBPRg6tImFqFiBZufgyxWowB3
         VXRAXksW2YETmVNLXWXIdXBqdHwtoVlnO0GRp5JRNRjBbluilsc1Hx0gT3d/g9mPBh
         akl6iIZGPWAzCULyKM49P/NjRbLsPz/CLaSrC360=
Subject: FAILED: patch "[PATCH] arm64: sdei: abort running SDEI handlers during crash" failed to apply to 4.19-stable tree
To:     scott@os.amperecomputing.com, james.morse@arm.com,
        mihai.carabas@oracle.com, will@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 22:53:33 +0100
Message-ID: <2023090933-prong-impound-90c8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 5cd474e57368f0957c343bb21e309cf82826b1ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090933-prong-impound-90c8@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

5cd474e57368 ("arm64: sdei: abort running SDEI handlers during crash")
dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
ac20ffbb0279 ("arm64: scs: use vmapped IRQ and SDEI shadow stacks")
c457cc800e89 ("Merge tag 'irq-core-2020-10-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5cd474e57368f0957c343bb21e309cf82826b1ef Mon Sep 17 00:00:00 2001
From: D Scott Phillips <scott@os.amperecomputing.com>
Date: Mon, 26 Jun 2023 17:29:39 -0700
Subject: [PATCH] arm64: sdei: abort running SDEI handlers during crash

Interrupts are blocked in SDEI context, per the SDEI spec: "The client
interrupts cannot preempt the event handler." If we crashed in the SDEI
handler-running context (as with ACPI's AGDI) then we need to clean up the
SDEI state before proceeding to the crash kernel so that the crash kernel
can have working interrupts.

Track the active SDEI handler per-cpu so that we can COMPLETE_AND_RESUME
the handler, discarding the interrupted context.

Fixes: f5df26961853 ("arm64: kernel: Add arch-specific SDEI entry code and CPU masking")
Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
Cc: stable@vger.kernel.org
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: Mihai Carabas <mihai.carabas@oracle.com>
Link: https://lore.kernel.org/r/20230627002939.2758-1-scott@os.amperecomputing.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index 4292d9bafb9d..484cb6972e99 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -17,6 +17,9 @@
 
 #include <asm/virt.h>
 
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+
 extern unsigned long sdei_exit_mode;
 
 /* Software Delegated Exception entry point from firmware*/
@@ -29,6 +32,9 @@ asmlinkage void __sdei_asm_entry_trampoline(unsigned long event_num,
 						   unsigned long pc,
 						   unsigned long pstate);
 
+/* Abort a running handler. Context is discarded. */
+void __sdei_handler_abort(void);
+
 /*
  * The above entry point does the minimum to call C code. This function does
  * anything else, before calling the driver.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a40e5e50fa55..6ad61de03d0a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -986,9 +986,13 @@ SYM_CODE_START(__sdei_asm_handler)
 
 	mov	x19, x1
 
-#if defined(CONFIG_VMAP_STACK) || defined(CONFIG_SHADOW_CALL_STACK)
+	/* Store the registered-event for crash_smp_send_stop() */
 	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
-#endif
+	cbnz	w4, 1f
+	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
+	b	2f
+1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
+2:	str	x19, [x5]
 
 #ifdef CONFIG_VMAP_STACK
 	/*
@@ -1055,6 +1059,14 @@ SYM_CODE_START(__sdei_asm_handler)
 
 	ldr_l	x2, sdei_exit_mode
 
+	/* Clear the registered-event seen by crash_smp_send_stop() */
+	ldrb	w3, [x4, #SDEI_EVENT_PRIORITY]
+	cbnz	w3, 1f
+	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
+	b	2f
+1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
+2:	str	xzr, [x5]
+
 alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
 	sdei_handler_exit exit_mode=x2
 alternative_else_nop_endif
@@ -1065,4 +1077,15 @@ alternative_else_nop_endif
 #endif
 SYM_CODE_END(__sdei_asm_handler)
 NOKPROBE(__sdei_asm_handler)
+
+SYM_CODE_START(__sdei_handler_abort)
+	mov_q	x0, SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME
+	adr	x1, 1f
+	ldr_l	x2, sdei_exit_mode
+	sdei_handler_exit exit_mode=x2
+	// exit the handler and jump to the next instruction.
+	// Exit will stomp x0-x17, PSTATE, ELR_ELx, and SPSR_ELx.
+1:	ret
+SYM_CODE_END(__sdei_handler_abort)
+NOKPROBE(__sdei_handler_abort)
 #endif /* CONFIG_ARM_SDE_INTERFACE */
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 830be01af32d..255d12f881c2 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -47,6 +47,9 @@ DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
 #endif
 
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+
 static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
 {
 	unsigned long *p;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index edd63894d61e..960b98b43506 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1044,10 +1044,8 @@ void crash_smp_send_stop(void)
 	 * If this cpu is the only one alive at this point in time, online or
 	 * not, there are no stop messages to be sent around, so just back out.
 	 */
-	if (num_other_online_cpus() == 0) {
-		sdei_mask_local_cpu();
-		return;
-	}
+	if (num_other_online_cpus() == 0)
+		goto skip_ipi;
 
 	cpumask_copy(&mask, cpu_online_mask);
 	cpumask_clear_cpu(smp_processor_id(), &mask);
@@ -1066,7 +1064,9 @@ void crash_smp_send_stop(void)
 		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
 			cpumask_pr_args(&mask));
 
+skip_ipi:
 	sdei_mask_local_cpu();
+	sdei_handler_abort();
 }
 
 bool smp_crash_stop_failed(void)
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index f9040bd61081..285fe7ad490d 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1095,3 +1095,22 @@ int sdei_event_handler(struct pt_regs *regs,
 	return err;
 }
 NOKPROBE_SYMBOL(sdei_event_handler);
+
+void sdei_handler_abort(void)
+{
+	/*
+	 * If the crash happened in an SDEI event handler then we need to
+	 * finish the handler with the firmware so that we can have working
+	 * interrupts in the crash kernel.
+	 */
+	if (__this_cpu_read(sdei_active_critical_event)) {
+	        pr_warn("still in SDEI critical event context, attempting to finish handler.\n");
+	        __sdei_handler_abort();
+	        __this_cpu_write(sdei_active_critical_event, NULL);
+	}
+	if (__this_cpu_read(sdei_active_normal_event)) {
+	        pr_warn("still in SDEI normal event context, attempting to finish handler.\n");
+	        __sdei_handler_abort();
+	        __this_cpu_write(sdei_active_normal_event, NULL);
+	}
+}
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 14dc461b0e82..255701e1251b 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -47,10 +47,12 @@ int sdei_unregister_ghes(struct ghes *ghes);
 int sdei_mask_local_cpu(void);
 int sdei_unmask_local_cpu(void);
 void __init sdei_init(void);
+void sdei_handler_abort(void);
 #else
 static inline int sdei_mask_local_cpu(void) { return 0; }
 static inline int sdei_unmask_local_cpu(void) { return 0; }
 static inline void sdei_init(void) { }
+static inline void sdei_handler_abort(void) { }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
 

