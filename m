Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E1A783299
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjHUUGh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjHUUGg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D65A8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B09664960
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B930C433C8;
        Mon, 21 Aug 2023 20:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648393;
        bh=UfIKA4hL1r0T4NnkypjaxWqx9VvtPqe2fYDXMYMJvIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPWtRjmSlotngtyLWU6rTzkEFZmcyEvw8ZDIcckfEN7SsGlo3wBV3nt0/6WvERL5K
         U9ffy/dHo3Im+I5A3GFam4ZceuU+uZOqX9ThTRasUylZqDfMd4Mtrb9CCQzki7aXbl
         jNxJ2vDypc7kcoFI7y0UTwLTf/FkS+jTsHRFxulk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.4 130/234] x86/retpoline,kprobes: Skip optprobe check for indirect jumps with retpolines and IBT
Date:   Mon, 21 Aug 2023 21:41:33 +0200
Message-ID: <20230821194134.593846745@linuxfoundation.org>
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

From: Petr Pavlu <petr.pavlu@suse.com>

commit 833fd800bf56b74d39d71d3f5936dffb3e0409c6 upstream.

The kprobes optimization check can_optimize() calls
insn_is_indirect_jump() to detect indirect jump instructions in
a target function. If any is found, creating an optprobe is disallowed
in the function because the jump could be from a jump table and could
potentially land in the middle of the target optprobe.

With retpolines, insn_is_indirect_jump() additionally looks for calls to
indirect thunks which the compiler potentially used to replace original
jumps. This extra check is however unnecessary because jump tables are
disabled when the kernel is built with retpolines. The same is currently
the case with IBT.

Based on this observation, remove the logic to look for calls to
indirect thunks and skip the check for indirect jumps altogether if the
kernel is built with retpolines or IBT. Remove subsequently the symbols
__indirect_thunk_start and __indirect_thunk_end which are no longer
needed.

Dropping this logic indirectly fixes a problem where the range
[__indirect_thunk_start, __indirect_thunk_end] wrongly included also the
return thunk. It caused that machines which used the return thunk as
a mitigation and didn't have it patched by any alternative ended up not
being able to use optprobes in any regular function.

Fixes: 0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20230711091952.27944-3-petr.pavlu@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    3 --
 arch/x86/kernel/kprobes/opt.c        |   40 ++++++++++++++---------------------
 arch/x86/kernel/vmlinux.lds.S        |    2 -
 tools/perf/util/thread-stack.c       |    4 ---
 4 files changed, 17 insertions(+), 32 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -482,9 +482,6 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_SECCOMP,
 };
 
-extern char __indirect_thunk_start[];
-extern char __indirect_thunk_end[];
-
 static __always_inline
 void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
 {
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -226,7 +226,7 @@ static int copy_optimized_instructions(u
 }
 
 /* Check whether insn is indirect jump */
-static int __insn_is_indirect_jump(struct insn *insn)
+static int insn_is_indirect_jump(struct insn *insn)
 {
 	return ((insn->opcode.bytes[0] == 0xff &&
 		(X86_MODRM_REG(insn->modrm.value) & 6) == 4) || /* Jump */
@@ -260,26 +260,6 @@ static int insn_jump_into_range(struct i
 	return (start <= target && target <= start + len);
 }
 
-static int insn_is_indirect_jump(struct insn *insn)
-{
-	int ret = __insn_is_indirect_jump(insn);
-
-#ifdef CONFIG_RETPOLINE
-	/*
-	 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
-	 * Note that even with CONFIG_RETPOLINE=y, the kernel compiled with
-	 * older gcc may use indirect jump. So we add this check instead of
-	 * replace indirect-jump check.
-	 */
-	if (!ret)
-		ret = insn_jump_into_range(insn,
-				(unsigned long)__indirect_thunk_start,
-				(unsigned long)__indirect_thunk_end -
-				(unsigned long)__indirect_thunk_start);
-#endif
-	return ret;
-}
-
 /* Decode whole function to ensure any instructions don't jump into target */
 static int can_optimize(unsigned long paddr)
 {
@@ -334,9 +314,21 @@ static int can_optimize(unsigned long pa
 		/* Recover address */
 		insn.kaddr = (void *)addr;
 		insn.next_byte = (void *)(addr + insn.length);
-		/* Check any instructions don't jump into target */
-		if (insn_is_indirect_jump(&insn) ||
-		    insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
+		/*
+		 * Check any instructions don't jump into target, indirectly or
+		 * directly.
+		 *
+		 * The indirect case is present to handle a code with jump
+		 * tables. When the kernel uses retpolines, the check should in
+		 * theory additionally look for jumps to indirect thunks.
+		 * However, the kernel built with retpolines or IBT has jump
+		 * tables disabled so the check can be skipped altogether.
+		 */
+		if (!IS_ENABLED(CONFIG_RETPOLINE) &&
+		    !IS_ENABLED(CONFIG_X86_KERNEL_IBT) &&
+		    insn_is_indirect_jump(&insn))
+			return 0;
+		if (insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
 					 DISP32_SIZE))
 			return 0;
 		addr += insn.length;
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -133,10 +133,8 @@ SECTIONS
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_RETPOLINE
-		__indirect_thunk_start = .;
 		*(.text..__x86.indirect_thunk)
 		*(.text..__x86.return_thunk)
-		__indirect_thunk_end = .;
 #endif
 		STATIC_CALL_TEXT
 
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -1037,9 +1037,7 @@ static int thread_stack__trace_end(struc
 
 static bool is_x86_retpoline(const char *name)
 {
-	const char *p = strstr(name, "__x86_indirect_thunk_");
-
-	return p == name || !strcmp(name, "__indirect_thunk_start");
+	return strstr(name, "__x86_indirect_thunk_") == name;
 }
 
 /*


