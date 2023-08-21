Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F887832D9
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHUUEg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjHUUEf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CCFE4
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50A03648D2
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D98C433C9;
        Mon, 21 Aug 2023 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648272;
        bh=tbPOFRQnVRKgnQioqoDQrlwzfdqEEKvQbEDlMcAQWgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gje8fydlKW7EIdKGSvX+5PW+QADQW1mbC8kWBnQhZ3DjuZ2Whpg0RL7vxZYnlwQcT
         KtRyRBqA8BsuVOcoVdXAHReNibJEqDjfDeF/ckVwQhKRPr+8MLuOiyf0ssdXlYfzwp
         3U4Bf7ckvjGP4Dxk2YvhxuY/tPXrpQuh5Z2ZT0ko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.4 116/234] objtool/x86: Fix SRSO mess
Date:   Mon, 21 Aug 2023 21:41:19 +0200
Message-ID: <20230821194133.962830484@linuxfoundation.org>
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

commit 4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/objtool/arch/x86/decode.c      |   11 +++++++----
 tools/objtool/check.c                |   24 ++++++++++++++++++++++--
 tools/objtool/include/objtool/arch.h |    1 +
 tools/objtool/include/objtool/elf.h  |    1 +
 4 files changed, 31 insertions(+), 6 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -824,8 +824,11 @@ bool arch_is_retpoline(struct symbol *sy
 
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
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -495,7 +495,7 @@ static int decode_instructions(struct ob
 				return -1;
 			}
 
-			if (func->return_thunk || func->alias != func)
+			if (func->embedded_insn || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -1346,16 +1346,33 @@ static int add_ignore_alternatives(struc
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
@@ -1645,7 +1662,7 @@ static int add_jump_destinations(struct
 			 * middle of another instruction.  Objtool only
 			 * knows about the outer instruction.
 			 */
-			if (sym && sym->return_thunk) {
+			if (sym && sym->embedded_insn) {
 				add_return_call(file, insn, false);
 				continue;
 			}
@@ -2550,6 +2567,9 @@ static int classify_symbols(struct objto
 		if (arch_is_rethunk(func))
 			func->return_thunk = true;
 
+		if (arch_is_embedded_insn(func))
+			func->embedded_insn = true;
+
 		if (arch_ftrace_match(func->name))
 			func->fentry = true;
 
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -90,6 +90,7 @@ int arch_decode_hint_reg(u8 sp_reg, int
 
 bool arch_is_retpoline(struct symbol *sym);
 bool arch_is_rethunk(struct symbol *sym);
+bool arch_is_embedded_insn(struct symbol *sym);
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -61,6 +61,7 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
+	u8 embedded_insn     : 1;
 	struct list_head pv_target;
 	struct list_head reloc_list;
 };


