Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA36F9206
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjEFMet (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 08:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjEFMes (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 08:34:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C71C156AA
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:34:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5AFF60EB2
        for <stable@vger.kernel.org>; Sat,  6 May 2023 12:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBC8C4339B;
        Sat,  6 May 2023 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683376486;
        bh=7ktqfUpgKKXSmSvII8wxR3qfkhpfJ28stocPlaKve04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mg2hQv/ddN7Qh+FuTzEd37haLa2WtLwtM9OQsEEuuDfwzRxBR0GEi4zRnk9VBLQ4z
         JK/FJfnrDhGiFsZpBMAaYPdw5gXK/YN26w0NptVxJ32JL3j+0JvuOba2MgjB0xFaT7
         5nkDQcqt2H6+vTCYLgqiRsX5+1Qax7lfs5iiQX9uly9rKJL93fiuSfcXStATTCwMKL
         viWZQj9zHku/gCYGe2XrXtnr6Y+a3rKpvYGyDiRoEyVdjlOCORzUpDitnoPH5GL22e
         ythcI940jhJ8VxwYYO8Plqd9QyXhXKWiSLOz513pvwU0jA7ltLkYpzAUgiGc0JnmMQ
         SyujggEGaRSbA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.10.y 2/2] arm64: Stash shadow stack pointer in the task struct on interrupt
Date:   Sat,  6 May 2023 14:34:34 +0200
Message-Id: <20230506123434.63470-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506123434.63470-1-ardb@kernel.org>
References: <20230506123434.63470-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097; i=ardb@kernel.org; h=from:subject; bh=7ktqfUpgKKXSmSvII8wxR3qfkhpfJ28stocPlaKve04=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISXMMzKG0XPuxjW3n88RqGqOFS/kXXRi3t7gq1OtC1rZD y02f97fUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZifoDhf+DW/77b/JICYgzr GT/+bNzMM+H9z8QWLo19e00T3D+IlDH8FVP/cuB4JO+a+TE9ByM///xdWlq69ajsXofMxM6FvFW fuQE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 59b37fe52f49955791a460752c37145f1afdcad1 upstream.

Instead of reloading the shadow call stack pointer from the ordinary
stack *, which may be vulnerable to the kind of gadget based attacks
shadow call stacks were designed to prevent, let's store a task's shadow
call stack pointer in the task struct when switching to the shadow IRQ
stack.

Given that currently, the task_struct::scs_sp field is only used to
preserve the shadow call stack pointer while a task is scheduled out or
running in user space, reusing this field to preserve and restore it
while running off the IRQ stack must be safe, as those occurrences are
guaranteed to never overlap. (The stack switching logic only switches
stacks when running from the task stack, and so the value being saved
here always corresponds to the task mode shadow stack)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230109174800.3286265-3-ardb@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ardb: v5.10 backport, which doesn't have call_on_irq_stack() yet *]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/entry.S | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 28d4cdeee5ae6083..55e477f73158d6f8 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -431,9 +431,7 @@ SYM_CODE_END(__swpan_exit_el0)
 
 	.macro	irq_stack_entry
 	mov	x19, sp			// preserve the original sp
-#ifdef CONFIG_SHADOW_CALL_STACK
-	mov	x24, scs_sp		// preserve the original shadow stack
-#endif
+	scs_save tsk			// preserve the original shadow stack
 
 	/*
 	 * Compare sp with the base of the task stack.
@@ -467,9 +465,7 @@ SYM_CODE_END(__swpan_exit_el0)
 	 */
 	.macro	irq_stack_exit
 	mov	sp, x19
-#ifdef CONFIG_SHADOW_CALL_STACK
-	mov	scs_sp, x24
-#endif
+	scs_load_current
 	.endm
 
 /* GPRs used by entry code */
-- 
2.39.2

