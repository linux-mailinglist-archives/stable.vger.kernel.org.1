Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2903775B24
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjHILOs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjHILOr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:14:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5D5ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ABFD62457
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD8AC433C7;
        Wed,  9 Aug 2023 11:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579685;
        bh=OTNG/ysHhnRdqsIky9K/xCdaG6fR/3rOa+a0/cLbH8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PiEDQnvNvO8jz/4ne8DxwB1ObzATXC6s7RtJmj1TILVsu8AFBFckI0eRKCFPOy2IW
         N5e3CUqKPLGnYBauRCqIYIdOW3nihTEVTlwpjlk3hqeI2G6rthvuc966l6rjhmdXap
         9cLHYELfkTp552wGzZ7Q0VP5/hwFAq0oQcc9wUs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 080/323] ARCv2: entry: comments about hardware auto-save on taken interrupts
Date:   Wed,  9 Aug 2023 12:38:38 +0200
Message-ID: <20230809103701.797548716@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

[ Upstream commit 45869eb0c0afd72bd5ab2437d4b00915697c044a ]

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Stable-dep-of: 92e2921eeafd ("ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/entry-arcv2.h | 78 ++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 225e7df2d8ed8..1c3520d1fa420 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -7,15 +7,54 @@
 #include <asm/irqflags-arcv2.h>
 #include <asm/thread_info.h>	/* For THREAD_SIZE */
 
+/*
+ * Interrupt/Exception stack layout (pt_regs) for ARCv2
+ *   (End of struct aligned to end of page [unless nested])
+ *
+ *  INTERRUPT                          EXCEPTION
+ *
+ *    manual    ---------------------  manual
+ *              |      orig_r0      |
+ *              |      event/ECR    |
+ *              |      bta          |
+ *              |      user_r25     |
+ *              |      gp           |
+ *              |      fp           |
+ *              |      sp           |
+ *              |      r12          |
+ *              |      r30          |
+ *              |      r58          |
+ *              |      r59          |
+ *  hw autosave ---------------------
+ *    optional  |      r0           |
+ *              |      r1           |
+ *              ~                   ~
+ *              |      r9           |
+ *              |      r10          |
+ *              |      r11          |
+ *              |      blink        |
+ *              |      lpe          |
+ *              |      lps          |
+ *              |      lpc          |
+ *              |      ei base      |
+ *              |      ldi base     |
+ *              |      jli base     |
+ *              ---------------------
+ *  hw autosave |       pc / eret   |
+ *   mandatory  | stat32 / erstatus |
+ *              ---------------------
+ */
+
 /*------------------------------------------------------------------------*/
 .macro INTERRUPT_PROLOGUE	called_from
-
-	; Before jumping to Interrupt Vector, hardware micro-ops did following:
+	; (A) Before jumping to Interrupt Vector, hardware micro-ops did following:
 	;   1. SP auto-switched to kernel mode stack
-	;   2. STATUS32.Z flag set to U mode at time of interrupt (U:1, K:0)
-	;   3. Auto saved: r0-r11, blink, LPE,LPS,LPC, JLI,LDI,EI, PC, STAT32
+	;   2. STATUS32.Z flag set if in U mode at time of interrupt (U:1,K:0)
+	;   3. Auto save: (mandatory) Push PC and STAT32 on stack
+	;                 hardware does even if CONFIG_ARC_IRQ_NO_AUTOSAVE
+	;   4. Auto save: (optional) r0-r11, blink, LPE,LPS,LPC, JLI,LDI,EI
 	;
-	; Now manually save: r12, sp, fp, gp, r25
+	; (B) Manually saved some regs: r12,r25,r30, sp,fp,gp, ACCL pair
 
 #ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
 .ifnc \called_from, exception
@@ -57,14 +96,17 @@
 	;  - U mode: retrieve it from AUX_USER_SP
 	;  - K mode: add the offset from current SP where H/w starts auto push
 	;
-	; Utilize the fact that Z bit is set if Intr taken in U mode
+	; 1. Utilize the fact that Z bit is set if Intr taken in U mode
+	; 2. Upon entry SP is always saved (for any inspection, unwinding etc),
+	;    but on return, restored only if U mode
+
 	mov.nz	r9, sp
-	add.nz	r9, r9, SZ_PT_REGS - PT_sp - 4
+	add.nz	r9, r9, SZ_PT_REGS - PT_sp - 4		; K mode SP
 	bnz	1f
 
-	lr	r9, [AUX_USER_SP]
+	lr	r9, [AUX_USER_SP]			; U mode SP
 1:
-	PUSH	r9	; SP
+	PUSH	r9					; SP (pt_regs->sp)
 
 	PUSH	fp
 	PUSH	gp
@@ -85,6 +127,8 @@
 /*------------------------------------------------------------------------*/
 .macro INTERRUPT_EPILOGUE	called_from
 
+	; INPUT: r0 has STAT32 of calling context
+	; INPUT: Z flag set if returning to K mode
 .ifnc \called_from, exception
 	add	sp, sp, 12	; skip BTA/ECR/orig_r0 placeholderss
 .endif
@@ -98,9 +142,10 @@
 	POP	gp
 	POP	fp
 
-	; Don't touch AUX_USER_SP if returning to K mode (Z bit set)
-	; (Z bit set on K mode is inverse of INTERRUPT_PROLOGUE)
-	add.z	sp, sp, 4
+	; Restore SP (into AUX_USER_SP) only if returning to U mode
+	;  - for K mode, it will be implicitly restored as stack is unwound
+	;  - Z flag set on K is inverse of what hardware does on interrupt entry
+	;    but that doesn't really matter
 	bz	1f
 
 	POPAX	AUX_USER_SP
@@ -145,11 +190,11 @@
 /*------------------------------------------------------------------------*/
 .macro EXCEPTION_PROLOGUE
 
-	; Before jumping to Exception Vector, hardware micro-ops did following:
+	; (A) Before jumping to Exception Vector, hardware micro-ops did following:
 	;   1. SP auto-switched to kernel mode stack
-	;   2. STATUS32.Z flag set to U mode at time of interrupt (U:1,K:0)
+	;   2. STATUS32.Z flag set if in U mode at time of exception (U:1,K:0)
 	;
-	; Now manually save the complete reg file
+	; (B) Manually save the complete reg file below
 
 	PUSH	r9		; freeup a register: slot of erstatus
 
@@ -195,12 +240,13 @@
 	PUSHAX	ecr		; r9 contains ECR, expected by EV_Trap
 
 	PUSH	r0		; orig_r0
+	; OUTPUT: r9 has ECR
 .endm
 
 /*------------------------------------------------------------------------*/
 .macro EXCEPTION_EPILOGUE
 
-	; Assumes r0 has PT_status32
+	; INPUT: r0 has STAT32 of calling context
 	btst   r0, STATUS_U_BIT	; Z flag set if K, used in INTERRUPT_EPILOGUE
 
 	add	sp, sp, 8	; orig_r0/ECR don't need restoring
-- 
2.39.2



