Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C1178337F
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHUUEo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjHUUEo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387DFA8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C30D8648BF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A32C433C7;
        Mon, 21 Aug 2023 20:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648281;
        bh=RDrlG9vp35FJFATzWOWeHg2fk6TBc4xGobiTTc7tN2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmpKFtdHnyt7z+PELbCI1tnTbmtK8CNPZrKBDwOlFVxOG4jJsVgr6ciU/XblseIDl
         yG5fH8K6VjYQj5r2POOXiwcrQd3yjHzCkS9hRmjwZ3bBxkkHqQw5XMuZykxNCApsxI
         gI3CmE9Sv+sT/z7fxtZGWQ9JN0u53IVJs0XxQNEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.4 119/234] x86/cpu: Rename original retbleed methods
Date:   Mon, 21 Aug 2023 21:41:22 +0200
Message-ID: <20230821194134.087911209@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
@@ -268,7 +268,7 @@
 .endm
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_ZEN_UNTRAIN_RET	"call zen_untrain_ret"
+#define CALL_ZEN_UNTRAIN_RET	"call retbleed_untrain_ret"
 #else
 #define CALL_ZEN_UNTRAIN_RET	""
 #endif
@@ -278,7 +278,7 @@
  * return thunk isn't mapped into the userspace tables (then again, AMD
  * typically has NO_MELTDOWN).
  *
- * While zen_untrain_ret() doesn't clobber anything but requires stack,
+ * While retbleed_untrain_ret() doesn't clobber anything but requires stack,
  * entry_ibpb() will clobber AX, CX, DX.
  *
  * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
@@ -343,11 +343,11 @@ extern void __x86_return_thunk(void);
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
@@ -1043,7 +1043,7 @@ do_cmd_auto:
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
 		if (IS_ENABLED(CONFIG_RETHUNK))
-			x86_return_thunk = zen_return_thunk;
+			x86_return_thunk = retbleed_return_thunk;
 
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -523,7 +523,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #ifdef CONFIG_RETHUNK
-. = ASSERT((zen_return_thunk & 0x3f) == 0, "zen_return_thunk not cacheline-aligned");
+. = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -188,32 +188,32 @@ SYM_CODE_END(srso_alias_return_thunk)
 
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
-SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
+SYM_START(retbleed_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
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
@@ -225,13 +225,13 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL,
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
@@ -242,13 +242,13 @@ SYM_CODE_END(zen_return_thunk)
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
@@ -829,6 +829,6 @@ bool arch_is_rethunk(struct symbol *sym)
 
 bool arch_is_embedded_insn(struct symbol *sym)
 {
-	return !strcmp(sym->name, "zen_return_thunk") ||
+	return !strcmp(sym->name, "retbleed_return_thunk") ||
 	       !strcmp(sym->name, "srso_safe_ret");
 }
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1655,7 +1655,7 @@ static int add_jump_destinations(struct
 			struct symbol *sym = find_symbol_by_offset(dest_sec, dest_off);
 
 			/*
-			 * This is a special case for zen_untrain_ret().
+			 * This is a special case for retbleed_untrain_ret().
 			 * It jumps to __x86_return_thunk(), but objtool
 			 * can't find the thunk's starting RET
 			 * instruction, because the RET is also in the


