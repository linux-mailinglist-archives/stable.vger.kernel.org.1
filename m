Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD58703A7C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbjEORvV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbjEORvE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5599147C3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8330D6233D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BBFC433EF;
        Mon, 15 May 2023 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172946;
        bh=r6KVSG6H5mECMJ8cou6lSc555P9voLPje+R49bY+H/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGq6U4WeuqHBv2BrZIULjZKPR8CT751yHRxTgcMXSYp68rPAitsC00I/mc9H5A6nZ
         xhaO+U0UElY9Lwm4n0rdXwwP1GzocAEbmZzJbQwNKAnHZYxt+QO0rb3xTpjGtefIJM
         1l9N+zm9Uqd2plEwcBEl5zOais4/aNojLYTKiIn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.10 289/381] arm64: Always load shadow stack pointer directly from the task struct
Date:   Mon, 15 May 2023 18:29:00 +0200
Message-Id: <20230515161749.839128505@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
 
-	.macro scs_load tsk, tmp
-	ldr	scs_sp, [\tsk, #TSK_TI_SCS_SP]
+	.macro scs_load_current
+	get_current_task scs_sp
+	ldr	scs_sp, [scs_sp, #TSK_TI_SCS_SP]
 	.endm
 
 	.macro scs_save tsk, tmp
 	str	scs_sp, [\tsk, #TSK_TI_SCS_SP]
 	.endm
 #else
-	.macro scs_load tsk, tmp
+	.macro scs_load_current
 	.endm
 
 	.macro scs_save tsk, tmp
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -221,7 +221,7 @@ alternative_else_nop_endif
 
 	ptrauth_keys_install_kernel tsk, x20, x22, x23
 
-	scs_load tsk, x20
+	scs_load_current
 	.else
 	add	x21, sp, #S_FRAME_SIZE
 	get_current_task tsk
@@ -1025,7 +1025,7 @@ SYM_FUNC_START(cpu_switch_to)
 	msr	sp_el0, x1
 	ptrauth_keys_install_kernel x1, x8, x9, x10
 	scs_save x0, x8
-	scs_load x1, x8
+	scs_load_current
 	ret
 SYM_FUNC_END(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -747,7 +747,7 @@ SYM_FUNC_START_LOCAL(__secondary_switche
 	ldr	x2, [x0, #CPU_BOOT_TASK]
 	cbz	x2, __secondary_too_slow
 	msr	sp_el0, x2
-	scs_load x2, x3
+	scs_load_current
 	mov	x29, #0
 	mov	x30, #0
 


