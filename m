Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10261789CF3
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 12:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjH0KRw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjH0KRi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 06:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083D132
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 03:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EC6062ACF
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 10:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6E7C433C8;
        Sun, 27 Aug 2023 10:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693131454;
        bh=Ym/Ofw9kfGb6pWnRy7M1f15SGfzDc/3Pn5zFDcJT52k=;
        h=Subject:To:Cc:From:Date:From;
        b=Zh5RWhFilayabdBOordGffAJvd2wP1eoCMBBWLOWfW5hIBLeKqcdnrln+rUAXKKol
         v+jxjOVbjZCDVB2C7O66HTLkSIszHRCKgGcro/4iFfcpDUO6/Z6NFeslZM64dHIbgt
         /qOPtF1jW/5dnLzxp+bz7zuJ5RH95Bduo41XpqR4=
Subject: FAILED: patch "[PATCH] objtool/x86: Fixup frame-pointer vs rethunk" failed to apply to 5.15-stable tree
To:     peterz@infradead.org, bp@alien8.de, jpoimboe@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 27 Aug 2023 12:17:23 +0200
Message-ID: <2023082723-bribe-sporty-3c8c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x dbf46008775516f7f25c95b7760041c286299783
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082723-bribe-sporty-3c8c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

dbf460087755 ("objtool/x86: Fixup frame-pointer vs rethunk")
c6f5dc28fb3d ("objtool: Union instruction::{call_dest,jump_table}")
0932dbe1f568 ("objtool: Remove instruction::reloc")
8b2de412158e ("objtool: Shrink instruction::{type,visited}")
d54066546121 ("objtool: Make instruction::alts a single-linked list")
3ee88df1b063 ("objtool: Make instruction::stack_ops a single-linked list")
20a554638dd2 ("objtool: Change arch_decode_instruction() signature")
5f6e430f931d ("Merge tag 'powerpc-6.2-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dbf46008775516f7f25c95b7760041c286299783 Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 16 Aug 2023 13:59:21 +0200
Subject: [PATCH] objtool/x86: Fixup frame-pointer vs rethunk

For stack-validation of a frame-pointer build, objtool validates that
every CALL instruction is preceded by a frame-setup. The new SRSO
return thunks violate this with their RSB stuffing trickery.

Extend the __fentry__ exception to also cover the embedded_insn case
used for this. This cures:

  vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without frame pointer save/setup

Fixes: 4ae68b26c3ab ("objtool/x86: Fix SRSO mess")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20230816115921.GH980931@hirez.programming.kicks-ass.net

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7a9aaf400873..1384090530db 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2650,12 +2650,17 @@ static int decode_sections(struct objtool_file *file)
 	return 0;
 }
 
-static bool is_fentry_call(struct instruction *insn)
+static bool is_special_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL &&
-	    insn_call_dest(insn) &&
-	    insn_call_dest(insn)->fentry)
-		return true;
+	if (insn->type == INSN_CALL) {
+		struct symbol *dest = insn_call_dest(insn);
+
+		if (!dest)
+			return false;
+
+		if (dest->fentry || dest->embedded_insn)
+			return true;
+	}
 
 	return false;
 }
@@ -3656,7 +3661,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (opts.stackval && func && !is_fentry_call(insn) &&
+			if (opts.stackval && func && !is_special_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_INSN(insn, "call without frame pointer save/setup");
 				return 1;

