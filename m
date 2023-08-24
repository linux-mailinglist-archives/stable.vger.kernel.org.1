Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84F4787707
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbjHXRWQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242925AbjHXRWC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C841BCE
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54100675A9
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C0C433C8;
        Thu, 24 Aug 2023 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897715;
        bh=GbbOqtqZ6+T+E4lig/s11tc0G5SNAE1ziGBL0KJfYMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fbpJttESWlYsYO6IxuW8jYojipxGugy/MMjMyKHVBb3tBdD17budKi8Qbfz9PCAYD
         0GswZLBABuCjHkMUqnvsfzUq/bknO48exp3AVfLq0Qp0Rk1k2ang3XNKTJoDkhojYj
         Yz8pOrwbalhpFhMspTz8+C9aY1Pkmxdzshn64BIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.10 125/135] x86/cpu: Rename original retbleed methods
Date:   Thu, 24 Aug 2023 19:09:57 +0200
Message-ID: <20230824170622.684765006@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit d025b7bac07a6e90b6b98b487f88854ad9247c39 upstream.

Rename the original retbleed return thunk and untrain_ret to
retbleed_return_thunk() and retbleed_untrain_ret().

No functional changes.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.909378169@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    8 ++++----
 arch/x86/kernel/cpu/bugs.c           |    2 +-
 arch/x86/kernel/vmlinux.lds.S        |    2 +-
 arch/x86/lib/retpoline.S             |   30 +++++++++++++++---------------
 tools/objtool/arch/x86/decode.c      |    2 +-
 tools/objtool/check.c                |    2 +-
 6 files changed, 23 insertions(+), 23 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -156,7 +156,7 @@
 .endm
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_ZEN_UNTRAIN_RET	"call zen_untrain_ret"
+#define CALL_ZEN_UNTRAIN_RET	"call retbleed_untrain_ret"
 #else
 #define CALL_ZEN_UNTRAIN_RET	""
 #endif
@@ -166,7 +166,7 @@
  * return thunk isn't mapped into the userspace tables (then again, AMD
  * typically has NO_MELTDOWN).
  *
- * While zen_untrain_ret() doesn't clobber anything but requires stack,
+ * While retbleed_untrain_ret() doesn't clobber anything but requires stack,
  * entry_ibpb() will clobber AX, CX, DX.
  *
  * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
@@ -201,11 +201,11 @@ extern void __x86_return_thunk(void);
 static inline void __x86_return_thunk(void) {}
 #endif
 
-extern void zen_return_thunk(void);
+extern void retbleed_return_thunk(void);
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
 
-extern void zen_untrain_ret(void);
+extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
 extern void srso_untrain_ret_alias(void);
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -984,7 +984,7 @@ do_cmd_auto:
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
 		if (IS_ENABLED(CONFIG_RETHUNK))
-			x86_return_thunk = zen_return_thunk;
+			x86_return_thunk = retbleed_return_thunk;
 
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -518,7 +518,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #ifdef CONFIG_RETHUNK
-. = ASSERT((zen_return_thunk & 0x3f) == 0, "zen_return_thunk not cacheline-aligned");
+. = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -129,32 +129,32 @@ SYM_CODE_END(srso_alias_return_thunk)
 
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
- * 1) The RET at zen_return_thunk must be on a 64 byte boundary, for
+ * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
  *    alignment within the BTB.
- * 2) The instruction at zen_untrain_ret must contain, and not
+ * 2) The instruction at retbleed_untrain_ret must contain, and not
  *    end with, the 0xc3 byte of the RET.
  * 3) STIBP must be enabled, or SMT disabled, to prevent the sibling thread
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 64 - (zen_return_thunk - zen_untrain_ret), 0xcc
-SYM_FUNC_START_NOALIGN(zen_untrain_ret);
+	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
+SYM_FUNC_START_NOALIGN(retbleed_untrain_ret);
 
 	/*
-	 * As executed from zen_untrain_ret, this is:
+	 * As executed from retbleed_untrain_ret, this is:
 	 *
 	 *   TEST $0xcc, %bl
 	 *   LFENCE
-	 *   JMP zen_return_thunk
+	 *   JMP retbleed_return_thunk
 	 *
 	 * Executing the TEST instruction has a side effect of evicting any BTB
 	 * prediction (potentially attacker controlled) attached to the RET, as
-	 * zen_return_thunk + 1 isn't an instruction boundary at the moment.
+	 * retbleed_return_thunk + 1 isn't an instruction boundary at the moment.
 	 */
 	.byte	0xf6
 
 	/*
-	 * As executed from zen_return_thunk, this is a plain RET.
+	 * As executed from retbleed_return_thunk, this is a plain RET.
 	 *
 	 * As part of the TEST above, RET is the ModRM byte, and INT3 the imm8.
 	 *
@@ -166,13 +166,13 @@ SYM_FUNC_START_NOALIGN(zen_untrain_ret);
 	 * With SMT enabled and STIBP active, a sibling thread cannot poison
 	 * RET's prediction to a type of its choice, but can evict the
 	 * prediction due to competitive sharing. If the prediction is
-	 * evicted, zen_return_thunk will suffer Straight Line Speculation
+	 * evicted, retbleed_return_thunk will suffer Straight Line Speculation
 	 * which will be contained safely by the INT3.
 	 */
-SYM_INNER_LABEL(zen_return_thunk, SYM_L_GLOBAL)
+SYM_INNER_LABEL(retbleed_return_thunk, SYM_L_GLOBAL)
 	ret
 	int3
-SYM_CODE_END(zen_return_thunk)
+SYM_CODE_END(retbleed_return_thunk)
 
 	/*
 	 * Ensure the TEST decoding / BTB invalidation is complete.
@@ -183,13 +183,13 @@ SYM_CODE_END(zen_return_thunk)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp zen_return_thunk
+	jmp retbleed_return_thunk
 	int3
-SYM_FUNC_END(zen_untrain_ret)
-__EXPORT_THUNK(zen_untrain_ret)
+SYM_FUNC_END(retbleed_untrain_ret)
+__EXPORT_THUNK(retbleed_untrain_ret)
 
 /*
- * SRSO untraining sequence for Zen1/2, similar to zen_untrain_ret()
+ * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
  * above. On kernel entry, srso_untrain_ret() is executed which is a
  *
  * movabs $0xccccccc308c48348,%rax
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -655,5 +655,5 @@ bool arch_is_rethunk(struct symbol *sym)
 	return !strcmp(sym->name, "__x86_return_thunk") ||
 	       !strcmp(sym->name, "srso_untrain_ret") ||
 	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "zen_return_thunk");
+	       !strcmp(sym->name, "retbleed_return_thunk");
 }
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1165,7 +1165,7 @@ static int add_jump_destinations(struct
 				continue;
 
 			/*
-			 * This is a special case for zen_untrain_ret().
+			 * This is a special case for retbleed_untrain_ret().
 			 * It jumps to __x86_return_thunk(), but objtool
 			 * can't find the thunk's starting RET
 			 * instruction, because the RET is also in the


