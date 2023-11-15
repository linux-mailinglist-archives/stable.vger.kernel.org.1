Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD877E2371
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjKFNL5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjKFNL5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:11:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC0CA9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:11:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCF2C433C8;
        Mon,  6 Nov 2023 13:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276314;
        bh=d+Bh1rTp5JwHDQFSgXECJ5otoeTnyD2wynBr+i/13zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=abtkK8LYEpbOPlCwlMnHa4I444DFirwfnmt3JE4leuU13+OWbHXfzsdayywxTf/Wo
         AisiyoATxokXm3cA9sfRV+ot9vW5T5aX7bwvggvZ4XP8fa3cr5uZLw+k4r5X92VKt/
         m2mW3q/R2sX02KieT9xPGodNQMR0rMf5V/T//KfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joe Damato <jdamato@fastly.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 4.19 33/61] x86/mm: Fix RESERVE_BRK() for older binutils
Date:   Mon,  6 Nov 2023 14:03:29 +0100
Message-ID: <20231106130300.747752820@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

commit e32683c6f7d22ba624e0bfc58b02cf3348bdca63 upstream.

With binutils 2.26, RESERVE_BRK() causes a build failure:

  /tmp/ccnGOKZ5.s: Assembler messages:
  /tmp/ccnGOKZ5.s:98: Error: missing ')'
  /tmp/ccnGOKZ5.s:98: Error: missing ')'
  /tmp/ccnGOKZ5.s:98: Error: missing ')'
  /tmp/ccnGOKZ5.s:98: Error: junk at end of line, first unrecognized
  character is `U'

The problem is this line:

  RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE)

Specifically, the INIT_PGT_BUF_SIZE macro which (via PAGE_SIZE's use
_AC()) has a "1UL", which makes older versions of the assembler unhappy.
Unfortunately the _AC() macro doesn't work for inline asm.

Inline asm was only needed here to convince the toolchain to add the
STT_NOBITS flag.  However, if a C variable is placed in a section whose
name is prefixed with ".bss", GCC and Clang automatically set
STT_NOBITS.  In fact, ".bss..page_aligned" already relies on this trick.

So fix the build failure (and simplify the macro) by allocating the
variable in C.

Also, add NOLOAD to the ".brk" output section clause in the linker
script.  This is a failsafe in case the ".bss" prefix magic trick ever
stops working somehow.  If there's a section type mismatch, the GNU
linker will force the ".brk" output section to be STT_NOBITS.  The LLVM
linker will fail with a "section type mismatch" error.

Note this also changes the name of the variable from .brk.##name to
__brk_##name.  The variable names aren't actually used anywhere, so it's
harmless.

Fixes: a1e2c031ec39 ("x86/mm: Simplify RESERVE_BRK()")
Reported-by: Joe Damato <jdamato@fastly.com>
Reported-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Joe Damato <jdamato@fastly.com>
Link: https://lore.kernel.org/r/22d07a44c80d8e8e1e82b9a806ddc8c6bbb2606e.1654759036.git.jpoimboe@kernel.org
[nathan: Fix conflict due to lack of 360db4ace311 and resolve silent
         conflict with 360db4ace3117]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/setup.h  |   38 +++++++++++++++++++++-----------------
 arch/x86/kernel/vmlinux.lds.S |    4 ++--
 2 files changed, 23 insertions(+), 19 deletions(-)

--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -91,19 +91,16 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
 
 /*
- * Reserve space in the brk section.  The name must be unique within the file,
- * and somewhat descriptive.  The size is in bytes.
+ * Reserve space in the .brk section, which is a block of memory from which the
+ * caller is allowed to allocate very early (before even memblock is available)
+ * by calling extend_brk().  All allocated memory will be eventually converted
+ * to memblock.  Any leftover unallocated memory will be freed.
  *
- * The allocation is done using inline asm (rather than using a section
- * attribute on a normal variable) in order to allow the use of @nobits, so
- * that it doesn't take up any space in the vmlinux file.
+ * The size is in bytes.
  */
-#define RESERVE_BRK(name, size)						\
-	asm(".pushsection .brk_reservation,\"aw\",@nobits\n\t"		\
-	    ".brk." #name ":\n\t"					\
-	    ".skip " __stringify(size) "\n\t"				\
-	    ".size .brk." #name ", " __stringify(size) "\n\t"		\
-	    ".popsection\n\t")
+#define RESERVE_BRK(name, size)					\
+	__section(.bss..brk) __aligned(1) __used	\
+	static char __brk_##name[size]
 
 /* Helper for reserving space for arrays of things */
 #define RESERVE_BRK_ARRAY(type, name, entries)		\
@@ -121,12 +118,19 @@ asmlinkage void __init x86_64_start_rese
 
 #endif /* __i386__ */
 #endif /* _SETUP */
-#else
-#define RESERVE_BRK(name,sz)				\
-	.pushsection .brk_reservation,"aw",@nobits;	\
-.brk.name:						\
-1:	.skip sz;					\
-	.size .brk.name,.-1b;				\
+
+#else  /* __ASSEMBLY */
+
+.macro __RESERVE_BRK name, size
+	.pushsection .bss..brk, "aw"
+GLOBAL(__brk_\name)
+	.skip \size
+END(__brk_\name)
 	.popsection
+.endm
+
+#define RESERVE_BRK(name, size) __RESERVE_BRK name, size
+
 #endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_SETUP_H */
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -380,10 +380,10 @@ SECTIONS
 	}
 
 	. = ALIGN(PAGE_SIZE);
-	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
+	.brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
-		*(.brk_reservation)	/* areas brk users have reserved */
+		*(.bss..brk)		/* areas brk users have reserved */
 		__brk_limit = .;
 	}
 


