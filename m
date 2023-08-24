Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A77787390
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbjHXPET (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242093AbjHXPEH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7954B19A6
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E2386719F
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F618C433C8;
        Thu, 24 Aug 2023 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889444;
        bh=SV4Zsllm1mqna02Pgr7jzr8wLlHHGU9kPGmXRf7uQkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvHpiPe85Lpg/YeXf4MxvPd4UqDvdNkDjhMVHmopAqdKs0QeEZGtnPiPxqV5ElXFh
         DYKHFm2lRAWYyVQHZrqqcC1wPt1dLjhWBEEi1CVZ7VLQ69ZrH9tVjHSltjRnGv7Fdi
         aks293EImzhPAmtXWW2uefQNmy7emzrPR2s2k0ic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 123/135] x86/ibt: Add ANNOTATE_NOENDBR
Date:   Thu, 24 Aug 2023 16:51:06 +0200
Message-ID: <20230824145032.317504537@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit c8c301abeae58ec756b8fcb2178a632bd3c9e284 ]

In order to have objtool warn about code references to !ENDBR
instruction, we need an annotation to allow this for non-control-flow
instances -- consider text range checks, text patching, or return
trampolines etc.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.578968224@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/objtool.h       |   16 ++++++++++++++++
 tools/include/linux/objtool.h |   16 ++++++++++++++++
 2 files changed, 32 insertions(+)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -82,6 +82,12 @@ struct unwind_hint {
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
+#define ANNOTATE_NOENDBR					\
+	"986: \n\t"						\
+	".pushsection .discard.noendbr\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -128,6 +134,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro ANNOTATE_NOENDBR
+.Lhere_\@:
+	.pushsection .discard.noendbr
+	.quad	.Lhere_\@
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -138,10 +151,13 @@ struct unwind_hint {
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
+#define ANNOTATE_NOENDBR
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
 .endm
+.macro ANNOTATE_NOENDBR
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -82,6 +82,12 @@ struct unwind_hint {
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
+#define ANNOTATE_NOENDBR					\
+	"986: \n\t"						\
+	".pushsection .discard.noendbr\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -128,6 +134,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro ANNOTATE_NOENDBR
+.Lhere_\@:
+	.pushsection .discard.noendbr
+	.quad	.Lhere_\@
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -138,10 +151,13 @@ struct unwind_hint {
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
+#define ANNOTATE_NOENDBR
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
 .endm
+.macro ANNOTATE_NOENDBR
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */


