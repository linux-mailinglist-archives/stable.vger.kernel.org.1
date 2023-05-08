Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69C6FA3B7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjEHJvX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjEHJvL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA3623A2E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12B5F621BB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209CBC433EF;
        Mon,  8 May 2023 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539455;
        bh=1fYRg93c9MiVpQNZIJe92pp2i1LRO2vQkjgDV2j3MHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2qlTAfQsLtmxuczMhrTPVJm+WxiAmeAI+iEzqkN6bLgp7n8HM8ozW/424dkLj8A9
         JgdL+ZOCrM4vmKEcfgebxFVSGwwPE5Hvx8GSNxxnAEy2u3Db+9+oMNE7p0a3kPNQ6V
         OMhQ3edU261I94oYtZ+DF2vjrpO1r8QfctiTtm8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.1 022/611] arm64: Always load shadow stack pointer directly from the task struct
Date:   Mon,  8 May 2023 11:37:44 +0200
Message-Id: <20230508094422.442651627@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ard Biesheuvel <ardb@kernel.org>

commit 2198d07c509f1db4a1185d1f65aaada794c6ea59 upstream.

All occurrences of the scs_load macro load the value of the shadow call
stack pointer from the task which is current at that point. So instead
of taking a task struct register argument in the scs_load macro to
specify the task struct to load from, let's always reference the current
task directly. This should make it much harder to exploit any
instruction sequences reloading the shadow call stack pointer register
from memory.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230109174800.3286265-2-ardb@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/scs.h |    7 ++++---
 arch/arm64/kernel/entry.S    |    4 ++--
 arch/arm64/kernel/head.S     |    2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -9,15 +9,16 @@
 #ifdef CONFIG_SHADOW_CALL_STACK
 	scs_sp	.req	x18
 
-	.macro scs_load tsk
-	ldr	scs_sp, [\tsk, #TSK_TI_SCS_SP]
+	.macro scs_load_current
+	get_current_task scs_sp
+	ldr	scs_sp, [scs_sp, #TSK_TI_SCS_SP]
 	.endm
 
 	.macro scs_save tsk
 	str	scs_sp, [\tsk, #TSK_TI_SCS_SP]
 	.endm
 #else
-	.macro scs_load tsk
+	.macro scs_load_current
 	.endm
 
 	.macro scs_save tsk
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -272,7 +272,7 @@ alternative_if ARM64_HAS_ADDRESS_AUTH
 alternative_else_nop_endif
 1:
 
-	scs_load tsk
+	scs_load_current
 	.else
 	add	x21, sp, #PT_REGS_SIZE
 	get_current_task tsk
@@ -845,7 +845,7 @@ SYM_FUNC_START(cpu_switch_to)
 	msr	sp_el0, x1
 	ptrauth_keys_install_kernel x1, x8, x9, x10
 	scs_save x0
-	scs_load x1
+	scs_load_current
 	ret
 SYM_FUNC_END(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -404,7 +404,7 @@ SYM_FUNC_END(create_kernel_mapping)
 	stp	xzr, xzr, [sp, #S_STACKFRAME]
 	add	x29, sp, #S_STACKFRAME
 
-	scs_load \tsk
+	scs_load_current
 
 	adr_l	\tmp1, __per_cpu_offset
 	ldr	w\tmp2, [\tsk, #TSK_TI_CPU]


