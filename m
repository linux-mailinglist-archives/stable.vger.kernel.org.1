Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3946F9205
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjEFMer (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 08:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjEFMeq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 08:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FF5156AA
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:34:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A394C60BA4
        for <stable@vger.kernel.org>; Sat,  6 May 2023 12:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C4EC433EF;
        Sat,  6 May 2023 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683376485;
        bh=oCK2zosiK7V+lseNGVhHuyJ3LC8cIUuPvmWlIRHqfVg=;
        h=From:To:Cc:Subject:Date:From;
        b=FZVfc1s6rwgxucpKjwI7qWaDSU0d6asfum3I3BhLL8Ehj0/4Jb7eoGhhlPztdzBks
         QzMHhMsPvMcUiWKeroywzVP+HDL7mbJYicvNQEDjqwvZwn+G4uMyX2k7z0YO+y6dD+
         FkVSe1ciJCzHqJ/AzFO+iAMyPYBEUsJCOrnhuEBMff9shId+4w++/wtHL4mxVjWcY5
         SBqD4SoMzopw6oE+zWmJh+1h6aRbv16U3IWO5w+eUauHblgNnd2UIiaZbMo3JdjDSD
         GKQu2n6AZSJnL/oBgwM6oEOZMpCPCoyjYsLi+qHh7hyffGMoqj25QNVi0b+WzSJotX
         suUZKfcq/bhgg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.10.y 1/2] arm64: Always load shadow stack pointer directly from the task struct
Date:   Sat,  6 May 2023 14:34:33 +0200
Message-Id: <20230506123434.63470-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2602; i=ardb@kernel.org; h=from:subject; bh=oCK2zosiK7V+lseNGVhHuyJ3LC8cIUuPvmWlIRHqfVg=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISXMM+K3U//T6lgfZhOu6+c2bU0o+myVc+bYxn2ORqxhj ncXTA/uKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABd5zvA/ZU5Dka3y21TVAxWB qr/lEkQNDFad3vpaubKq7rZuxpabjAw/vhy60a68+nXP8ufRYYHfNquGcOtqqJyW4fj1ofi6nwY fAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
 arch/arm64/include/asm/scs.h | 7 ++++---
 arch/arm64/kernel/entry.S    | 4 ++--
 arch/arm64/kernel/head.S     | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index eaa2cd92e4c10122..7155055a5bebc17d 100644
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
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index d5bc1dbdd2fda84c..28d4cdeee5ae6083 100644
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
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index e1c25fa3b8e6ca65..351ee64c7deb4c96 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -747,7 +747,7 @@ SYM_FUNC_START_LOCAL(__secondary_switched)
 	ldr	x2, [x0, #CPU_BOOT_TASK]
 	cbz	x2, __secondary_too_slow
 	msr	sp_el0, x2
-	scs_load x2, x3
+	scs_load_current
 	mov	x29, #0
 	mov	x30, #0
 
-- 
2.39.2

