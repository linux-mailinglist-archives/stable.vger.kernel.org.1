Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B16FAA48
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjEHLBO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjEHLA5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE829C9C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEB2962A15
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE02DC433EF;
        Mon,  8 May 2023 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543582;
        bh=ZFtxEkoyIM91pwb5W2teSJjQ0FQmaALSSZaGTpaoUEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8waQZk379iq2MyXV75zhdHGpS79peX/XuJdzCInufNEi8ksy5iYDmLvWzHzUD6gh
         qBIBz2ONxNG3uX8tFYANltchylcCGMfeOJyYsUYxLBGwRfbrT64zvHKnA1aRe3uCCc
         uTaJcxgT377Nysc7+qJg0xORPTM4iPavJtwd0Ukw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 136/694] ARM: 9292/1: vfp: Pass thread_info pointer to vfp_support_entry
Date:   Mon,  8 May 2023 11:39:31 +0200
Message-Id: <20230508094436.875285899@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit dae904d96ad6a5fa79bd9d99a3decf93685d398b ]

Instead of dereferencing thread_info in do_vfp, pass the thread_info
pointer to vfp_support_entry via R1. That way, we only use a single
caller save register, which makes it easier to convert do_vfp to C code
in a subsequent patch.

Note that, unlike the CPU number, which can change due to preemption,
passing the thread_info pointer can safely be done with preemption
enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Stable-dep-of: c76c6c4ecbec ("ARM: 9294/2: vfp: Fix broken softirq handling with instrumentation enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/vfp/entry.S |  5 +----
 arch/arm/vfp/vfphw.S | 10 +++++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 9a89264cdcc0b..cfedc2a3dbd68 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -22,15 +22,12 @@
 @  IRQs enabled.
 @
 ENTRY(do_vfp)
-	local_bh_disable r10, r4
+	mov	r1, r10
  	ldr	r4, .LCvfp
-	ldr	r11, [r10, #TI_CPU]	@ CPU number
-	add	r10, r10, #TI_VFPSTATE	@ r10 = workspace
 	ldr	pc, [r4]		@ call VFP entry point
 ENDPROC(do_vfp)
 
 ENTRY(vfp_null_entry)
-	local_bh_enable_ti r10, r4
 	ret	lr
 ENDPROC(vfp_null_entry)
 
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 26c4f61ecfa39..6d056d810e486 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -6,9 +6,9 @@
  *  Written by Deep Blue Solutions Limited.
  *
  * This code is called from the kernel's undefined instruction trap.
+ * r1 holds the thread_info pointer
  * r9 holds the return address for successful handling.
  * lr holds the return address for unrecognised instructions.
- * r10 points at the start of the private FP workspace in the thread structure
  * sp points to a struct pt_regs (as defined in include/asm/proc/ptrace.h)
  */
 #include <linux/init.h>
@@ -69,13 +69,17 @@
 @ VFP hardware support entry point.
 @
 @  r0  = instruction opcode (32-bit ARM or two 16-bit Thumb)
+@  r1  = thread_info pointer
 @  r2  = PC value to resume execution after successful emulation
 @  r9  = normal "successful" return address
-@  r10 = vfp_state union
-@  r11 = CPU number
 @  lr  = unrecognised instruction return address
 @  IRQs enabled.
 ENTRY(vfp_support_entry)
+	local_bh_disable r1, r4
+
+	ldr	r11, [r1, #TI_CPU]	@ CPU number
+	add	r10, r1, #TI_VFPSTATE	@ r10 = workspace
+
 	DBGSTR3	"instr %08x pc %08x state %p", r0, r2, r10
 
 	.fpu	vfpv2
-- 
2.39.2



