Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B678770B
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbjHXRWr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242876AbjHXRWS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:22:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984AB19BB
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78DDD675F4
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81978C43391;
        Thu, 24 Aug 2023 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897734;
        bh=xP1ygXacqJMcw+C2geleA9385ZeP0eLt+jFRZknvfUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KV3X09X2Wmilh25W70puBGGteWZwNxnU475KQURtJGlcn37GU7RmNx93bLZs/G666
         d2SqPp08q0gmgPtFCTmAurvLaqvfCVp3MZwf4yRpG/nCUKrDaodvv1xVYsnHGEKgNp
         HqVkL94S9gvx8VMuWRNfZjlo+kbt3yPIeXW9LXjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 122/135] objtool: Add frame-pointer-specific function ignore
Date:   Thu, 24 Aug 2023 19:09:54 +0200
Message-ID: <20230824170622.561490699@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit e028c4f7ac7ca8c96126fe46c54ab3d56ffe6a66 ]

Add a CONFIG_FRAME_POINTER-specific version of
STACK_FRAME_NON_STANDARD() for the case where a function is
intentionally missing frame pointer setup, but otherwise needs
objtool/ORC coverage when frame pointers are disabled.

Link: https://lkml.kernel.org/r/163163047364.489837.17377799909553689661.stgit@devnote2

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: c8c301abeae5 ("x86/ibt: Add ANNOTATE_NOENDBR")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/objtool.h       |   12 ++++++++++++
 tools/include/linux/objtool.h |   12 ++++++++++++
 2 files changed, 24 insertions(+)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -71,6 +71,17 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
+ * for the case where a function is intentionally missing frame pointer setup,
+ * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
+ */
+#ifdef CONFIG_FRAME_POINTER
+#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
+#else
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#endif
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -126,6 +137,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -71,6 +71,17 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
+ * for the case where a function is intentionally missing frame pointer setup,
+ * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
+ */
+#ifdef CONFIG_FRAME_POINTER
+#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
+#else
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#endif
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -126,6 +137,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0


