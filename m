Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A47781F1A
	for <lists+stable@lfdr.de>; Sun, 20 Aug 2023 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjHTSBf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 20 Aug 2023 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjHTSBc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 20 Aug 2023 14:01:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5169711C
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 10:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB1460A6D
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 17:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E910DC433C8;
        Sun, 20 Aug 2023 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692554221;
        bh=6XElO8RnQWK6JiFjBAoG38cTrPs/SXSKC/4W24vA/Pk=;
        h=Subject:To:Cc:From:Date:From;
        b=b54EWLEhlefrK+sQsxoWX0ng2EJCp10k6L0YAAFibdc+cjuS5XjjQavEfV2vbamvj
         trqbvPKdPF6bP7rs3kmBkaoUda4M6RWi1NAnE1wlt2S6JU+OeKdR1dr7Oj+5dojXet
         EI6FLMehAXdxfTeFTthwG8k1V19YF1mtMkxrw7v4=
Subject: FAILED: patch "[PATCH] objtool/x86: Fix SRSO mess" failed to apply to 6.1-stable tree
To:     peterz@infradead.org, bp@alien8.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 20 Aug 2023 19:56:58 +0200
Message-ID: <2023082058-catalog-reconvene-ddce@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082058-catalog-reconvene-ddce@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

4ae68b26c3ab ("objtool/x86: Fix SRSO mess")
fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
6f612579be9d ("Merge tag 'objtool-core-2023-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40 Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 14 Aug 2023 13:44:29 +0200
Subject: [PATCH] objtool/x86: Fix SRSO mess

Objtool --rethunk does two things:

 - it collects all (tail) call's of __x86_return_thunk and places them
   into .return_sites. These are typically compiler generated, but
   RET also emits this same.

 - it fudges the validation of the __x86_return_thunk symbol; because
   this symbol is inside another instruction, it can't actually find
   the instruction pointed to by the symbol offset and gets upset.

Because these two things pertained to the same symbol, there was no
pressing need to separate these two separate things.

However, alas, along comes SRSO and more crazy things to deal with
appeared.

The SRSO patch itself added the following symbol names to identify as
rethunk:

  'srso_untrain_ret', 'srso_safe_ret' and '__ret'

Where '__ret' is the old retbleed return thunk, 'srso_safe_ret' is a
new similarly embedded return thunk, and 'srso_untrain_ret' is
completely unrelated to anything the above does (and was only included
because of that INT3 vs UD2 issue fixed previous).

Clear things up by adding a second category for the embedded instruction
thing.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.704502245@infradead.org

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 2d51fa8da9e8..cba8a7be040e 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -824,8 +824,11 @@ bool arch_is_retpoline(struct symbol *sym)
 
 bool arch_is_rethunk(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__x86_return_thunk") ||
-	       !strcmp(sym->name, "srso_untrain_ret") ||
-	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "__ret");
+	return !strcmp(sym->name, "__x86_return_thunk");
+}
+
+bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return !strcmp(sym->name, "__ret") ||
+	       !strcmp(sym->name, "srso_safe_ret");
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e2ee10ce7703..191656ee9fbc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -455,7 +455,7 @@ static int decode_instructions(struct objtool_file *file)
 				return -1;
 			}
 
-			if (func->return_thunk || func->alias != func)
+			if (func->embedded_insn || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -1288,16 +1288,33 @@ static int add_ignore_alternatives(struct objtool_file *file)
 	return 0;
 }
 
+/*
+ * Symbols that replace INSN_CALL_DYNAMIC, every (tail) call to such a symbol
+ * will be added to the .retpoline_sites section.
+ */
 __weak bool arch_is_retpoline(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that replace INSN_RETURN, every (tail) call to such a symbol
+ * will be added to the .return_sites section.
+ */
 __weak bool arch_is_rethunk(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that are embedded inside other instructions, because sometimes crazy
+ * code exists. These are mostly ignored for validation purposes.
+ */
+__weak bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return false;
+}
+
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
 {
 	struct reloc *reloc;
@@ -1583,7 +1600,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * middle of another instruction.  Objtool only
 			 * knows about the outer instruction.
 			 */
-			if (sym && sym->return_thunk) {
+			if (sym && sym->embedded_insn) {
 				add_return_call(file, insn, false);
 				continue;
 			}
@@ -2502,6 +2519,9 @@ static int classify_symbols(struct objtool_file *file)
 		if (arch_is_rethunk(func))
 			func->return_thunk = true;
 
+		if (arch_is_embedded_insn(func))
+			func->embedded_insn = true;
+
 		if (arch_ftrace_match(func->name))
 			func->fentry = true;
 
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 2b6d2ce4f9a5..0b303eba660e 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -90,6 +90,7 @@ int arch_decode_hint_reg(u8 sp_reg, int *base);
 
 bool arch_is_retpoline(struct symbol *sym);
 bool arch_is_rethunk(struct symbol *sym);
+bool arch_is_embedded_insn(struct symbol *sym);
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index c532d70864dc..9f71e988eca4 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -66,6 +66,7 @@ struct symbol {
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
 	u8 warned	     : 1;
+	u8 embedded_insn     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };

