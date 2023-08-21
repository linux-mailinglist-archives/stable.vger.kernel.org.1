Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F17F78338E
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjHUUFq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjHUUFq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:05:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E87A12A
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C882D648FC
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FBBC433C9;
        Mon, 21 Aug 2023 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648343;
        bh=4nD8u9nNpJpZ5wAZW7xX1mvhw11J97gYxsm1YDatnJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kv8hf0UY/1JCC3px44iOapS7MgNKEchdK4a9zyEIXvA90+hxcNSoBD8WiCif1Owcg
         3As2aKvK2LALVJoqYWfKuG0liIsEwYDKynwMjxtOOcwdC7ZupqTP/mNCgB4F1fmb3V
         179wAk/ap3HwvKHLHCumUk7QhSRBF8zpVZ/s++74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 6.4 124/234] objtool/x86: Fixup frame-pointer vs rethunk
Date:   Mon, 21 Aug 2023 21:41:27 +0200
Message-ID: <20230821194134.308191977@linuxfoundation.org>
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

commit dbf46008775516f7f25c95b7760041c286299783 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/objtool/check.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2698,12 +2698,17 @@ static int decode_sections(struct objtoo
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
@@ -3701,7 +3706,7 @@ static int validate_branch(struct objtoo
 			if (ret)
 				return ret;
 
-			if (opts.stackval && func && !is_fentry_call(insn) &&
+			if (opts.stackval && func && !is_special_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_INSN(insn, "call without frame pointer save/setup");
 				return 1;


