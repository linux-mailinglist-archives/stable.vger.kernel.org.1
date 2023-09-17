Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941C07A38DE
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbjIQTlw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbjIQTl0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:41:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5FA126
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:41:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9780FC433CA;
        Sun, 17 Sep 2023 19:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979680;
        bh=4JN/a8ePkq9pP2y/g29cc2UkAxkQQMNqXU4f1Dtdz6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmwVgNSZekL1fTfkKx3I6ddKrY/IS1QTX1B4ameRfuqy6L3448P2wb+ifDUe+Y5ts
         kPUS4GekiNdYx8MJWbGQoxZxsIDQeUt8ebZZB1f1HG/taKfkeLUvnR7yvQK+FH9PFc
         WP7HACno07Ggwmsvy2S6l6SB3GJndqppWTqJOeH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        D Scott Phillips <scott@os.amperecomputing.com>,
        James Morse <james.morse@arm.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 382/406] arm64: sdei: abort running SDEI handlers during crash
Date:   Sun, 17 Sep 2023 21:13:56 +0200
Message-ID: <20230917191111.349423019@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: D Scott Phillips <scott@os.amperecomputing.com>

[ Upstream commit 5cd474e57368f0957c343bb21e309cf82826b1ef ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/sdei.h |  6 ++++++
 arch/arm64/kernel/entry.S     | 27 +++++++++++++++++++++++++--
 arch/arm64/kernel/sdei.c      |  3 +++
 arch/arm64/kernel/smp.c       |  8 ++++----
 drivers/firmware/arm_sdei.c   | 19 +++++++++++++++++++
 include/linux/arm_sdei.h      |  2 ++
 6 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index 63e0b92a5fbb0..5882c0e29331e 100644
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
index 55e477f73158d..a94acea770c7c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1137,9 +1137,13 @@ SYM_CODE_START(__sdei_asm_handler)
 
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
@@ -1204,6 +1208,14 @@ SYM_CODE_START(__sdei_asm_handler)
 
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
@@ -1214,4 +1226,15 @@ alternative_else_nop_endif
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
index 793c46d6a4479..0083f5afa51db 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -38,6 +38,9 @@ DEFINE_PER_CPU(unsigned long *, sdei_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_stack_critical_ptr);
 #endif
 
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+
 static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
 {
 	unsigned long *p;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index feee5a3cd1288..ae0977b632a18 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1072,10 +1072,8 @@ void crash_smp_send_stop(void)
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
@@ -1094,7 +1092,9 @@ void crash_smp_send_stop(void)
 		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
 			cpumask_pr_args(&mask));
 
+skip_ipi:
 	sdei_mask_local_cpu();
+	sdei_handler_abort();
 }
 
 bool smp_crash_stop_failed(void)
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 9c4ebaf1f0c8f..68e55ca7491e5 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1109,3 +1109,22 @@ int sdei_event_handler(struct pt_regs *regs,
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
index 14dc461b0e829..255701e1251b4 100644
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
 
 
-- 
2.40.1



