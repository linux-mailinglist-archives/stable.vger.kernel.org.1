Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D09878334D
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHUT6n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjHUT6m (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:58:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2164D123
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5766646CD
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88BDC433C9;
        Mon, 21 Aug 2023 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647920;
        bh=ku46R3nMTxJvAhX2qfk6n2OZ1fmeak2j4wyA6XofgR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zz8LFkOu8jtanrIKP8Be4sVF6YZ/Nd/0NMGIJb4q3a9tPdI2cU4iu6Piiu2PRoNNB
         O5hZKpDwWYb+y+luFGqbFP5UH9MOpy4QsttU/OT7fyPiLkPrC9QKoshsfX+qGsraQS
         HwkMrZRGLxtPxE8QE7Uf7reQeHg2KkAE4qV4dQcY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Pavlu <petr.pavlu@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 185/194] x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG
Date:   Mon, 21 Aug 2023 21:42:44 +0200
Message-ID: <20230821194130.835426134@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Petr Pavlu <petr.pavlu@suse.com>

commit 79cd2a11224eab86d6673fe8a11d2046ae9d2757 upstream.

The linker script arch/x86/kernel/vmlinux.lds.S matches the thunk
sections ".text.__x86.*" from arch/x86/lib/retpoline.S as follows:

  .text {
    [...]
    TEXT_TEXT
    [...]
    __indirect_thunk_start = .;
    *(.text.__x86.*)
    __indirect_thunk_end = .;
    [...]
  }

Macro TEXT_TEXT references TEXT_MAIN which normally expands to only
".text". However, with CONFIG_LTO_CLANG, TEXT_MAIN becomes
".text .text.[0-9a-zA-Z_]*" which wrongly matches also the thunk
sections. The output layout is then different than expected. For
instance, the currently defined range [__indirect_thunk_start,
__indirect_thunk_end] becomes empty.

Prevent the problem by using ".." as the first separator, for example,
".text..__x86.indirect_thunk". This pattern is utilized by other
explicit section names which start with one of the standard prefixes,
such as ".text" or ".data", and that need to be individually selected in
the linker script.

  [ nathan: Fix conflicts with SRSO and fold in fix issue brought up by
    Andrew Cooper in post-review:
    https://lore.kernel.org/20230803230323.1478869-1-andrew.cooper3@citrix.com ]

Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230711091952.27944-2-petr.pavlu@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/vmlinux.lds.S |    8 ++++----
 arch/x86/lib/retpoline.S      |    8 ++++----
 tools/objtool/check.c         |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -134,7 +134,7 @@ SECTIONS
 		KPROBES_TEXT
 		ALIGN_ENTRY_TEXT_BEGIN
 #ifdef CONFIG_CPU_SRSO
-		*(.text.__x86.rethunk_untrain)
+		*(.text..__x86.rethunk_untrain)
 #endif
 
 		ENTRY_TEXT
@@ -145,7 +145,7 @@ SECTIONS
 		 * definition.
 		 */
 		. = srso_alias_untrain_ret | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
-		*(.text.__x86.rethunk_safe)
+		*(.text..__x86.rethunk_safe)
 #endif
 		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
@@ -154,8 +154,8 @@ SECTIONS
 
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
-		*(.text.__x86.indirect_thunk)
-		*(.text.__x86.return_thunk)
+		*(.text..__x86.indirect_thunk)
+		*(.text..__x86.return_thunk)
 		__indirect_thunk_end = .;
 #endif
 	} :text =0xcccc
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -11,7 +11,7 @@
 #include <asm/frame.h>
 #include <asm/nops.h>
 
-	.section .text.__x86.indirect_thunk
+	.section .text..__x86.indirect_thunk
 
 .macro RETPOLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
@@ -91,7 +91,7 @@ SYM_CODE_END(__x86_indirect_thunk_array)
  * As a result, srso_alias_safe_ret() becomes a safe return.
  */
 #ifdef CONFIG_CPU_SRSO
-	.section .text.__x86.rethunk_untrain
+	.section .text..__x86.rethunk_untrain
 
 SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	UNWIND_HINT_FUNC
@@ -102,7 +102,7 @@ SYM_START(srso_alias_untrain_ret, SYM_L_
 SYM_FUNC_END(srso_alias_untrain_ret)
 __EXPORT_THUNK(srso_alias_untrain_ret)
 
-	.section .text.__x86.rethunk_safe
+	.section .text..__x86.rethunk_safe
 #else
 /* dummy definition for alternatives */
 SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
@@ -120,7 +120,7 @@ SYM_START(srso_alias_safe_ret, SYM_L_GLO
 	int3
 SYM_FUNC_END(srso_alias_safe_ret)
 
-	.section .text.__x86.return_thunk
+	.section .text..__x86.return_thunk
 
 SYM_CODE_START(srso_alias_return_thunk)
 	UNWIND_HINT_FUNC
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -379,7 +379,7 @@ static int decode_instructions(struct ob
 
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
-		    !strncmp(sec->name, ".text.__x86.", 12))
+		    !strncmp(sec->name, ".text..__x86.", 13))
 			sec->noinstr = true;
 
 		for (offset = 0; offset < sec->sh.sh_size; offset += insn->len) {


