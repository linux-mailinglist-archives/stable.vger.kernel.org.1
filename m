Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A17E233B
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjKFNKK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKFNKK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:10:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9489F91
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:10:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D763CC433C9;
        Mon,  6 Nov 2023 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276206;
        bh=MIMvgkRikEsqCx1E6O+LFIH8tuToCiRgZM9s8pPZ6eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZD56Gy0HTueWP/sA7R88xGSdDWnWH3UYrVKuCwCtuEI4GRpPFR7b6xGKLLqlnHqwi
         ovcSTck8YJkW3n3sGE19mifqTJDnIR/Ltt8V0oyiQeShzai+0LlQPnfHQ6j7i/1JPB
         /gZpbjiXJ3URk2PDifnAWH0dtjtrHSXVgnUuqnAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nicolas Pitre <nico@fluxnic.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Jian Cai <jiancai@google.com>,
        Peter Smith <peter.smith@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 25/61] ARM: 8933/1: replace Sun/Solaris style flag on section directive
Date:   Mon,  6 Nov 2023 14:03:21 +0100
Message-ID: <20231106130300.477463576@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <ndesaulniers@google.com>

[ Upstream commit 790756c7e0229dedc83bf058ac69633045b1000e ]

It looks like a section directive was using "Solaris style" to declare
the section flags. Replace this with the GNU style so that Clang's
integrated assembler can assemble this directive.

The modified instances were identified via:
$ ag \.section | grep #

Link: https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_7.html#SEC119
Link: https://github.com/ClangBuiltLinux/linux/issues/744
Link: https://bugs.llvm.org/show_bug.cgi?id=43759
Link: https://reviews.llvm.org/D69296

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Jian Cai <jiancai@google.com>
Suggested-by: Peter Smith <peter.smith@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/bootp/init.S            | 2 +-
 arch/arm/boot/compressed/big-endian.S | 2 +-
 arch/arm/boot/compressed/head.S       | 2 +-
 arch/arm/boot/compressed/piggy.S      | 2 +-
 arch/arm/mm/proc-arm1020.S            | 2 +-
 arch/arm/mm/proc-arm1020e.S           | 2 +-
 arch/arm/mm/proc-arm1022.S            | 2 +-
 arch/arm/mm/proc-arm1026.S            | 2 +-
 arch/arm/mm/proc-arm720.S             | 2 +-
 arch/arm/mm/proc-arm740.S             | 2 +-
 arch/arm/mm/proc-arm7tdmi.S           | 2 +-
 arch/arm/mm/proc-arm920.S             | 2 +-
 arch/arm/mm/proc-arm922.S             | 2 +-
 arch/arm/mm/proc-arm925.S             | 2 +-
 arch/arm/mm/proc-arm926.S             | 2 +-
 arch/arm/mm/proc-arm940.S             | 2 +-
 arch/arm/mm/proc-arm946.S             | 2 +-
 arch/arm/mm/proc-arm9tdmi.S           | 2 +-
 arch/arm/mm/proc-fa526.S              | 2 +-
 arch/arm/mm/proc-feroceon.S           | 2 +-
 arch/arm/mm/proc-mohawk.S             | 2 +-
 arch/arm/mm/proc-sa110.S              | 2 +-
 arch/arm/mm/proc-sa1100.S             | 2 +-
 arch/arm/mm/proc-v6.S                 | 2 +-
 arch/arm/mm/proc-v7.S                 | 2 +-
 arch/arm/mm/proc-v7m.S                | 4 ++--
 arch/arm/mm/proc-xsc3.S               | 2 +-
 arch/arm/mm/proc-xscale.S             | 2 +-
 28 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/bootp/init.S b/arch/arm/boot/bootp/init.S
index 78b508075161f..868eeeaaa46e2 100644
--- a/arch/arm/boot/bootp/init.S
+++ b/arch/arm/boot/bootp/init.S
@@ -16,7 +16,7 @@
  *  size immediately following the kernel, we could build this into
  *  a binary blob, and concatenate the zImage using the cat command.
  */
-		.section .start,#alloc,#execinstr
+		.section .start, "ax"
 		.type	_start, #function
 		.globl	_start
 
diff --git a/arch/arm/boot/compressed/big-endian.S b/arch/arm/boot/compressed/big-endian.S
index 88e2a88d324b2..0e092c36da2f2 100644
--- a/arch/arm/boot/compressed/big-endian.S
+++ b/arch/arm/boot/compressed/big-endian.S
@@ -6,7 +6,7 @@
  *  Author: Nicolas Pitre
  */
 
-	.section ".start", #alloc, #execinstr
+	.section ".start", "ax"
 
 	mrc	p15, 0, r0, c1, c0, 0	@ read control reg
 	orr	r0, r0, #(1 << 7)	@ enable big endian mode
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 69e661f574a07..e4d1b3d0b7d93 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -114,7 +114,7 @@
 #endif
 		.endm
 
-		.section ".start", #alloc, #execinstr
+		.section ".start", "ax"
 /*
  * sort out different calling conventions
  */
diff --git a/arch/arm/boot/compressed/piggy.S b/arch/arm/boot/compressed/piggy.S
index 0284f84dcf380..27577644ee721 100644
--- a/arch/arm/boot/compressed/piggy.S
+++ b/arch/arm/boot/compressed/piggy.S
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-	.section .piggydata,#alloc
+	.section .piggydata, "a"
 	.globl	input_data
 input_data:
 	.incbin	"arch/arm/boot/compressed/piggy_data"
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 774ef1323554b..4773490177c96 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -505,7 +505,7 @@ cpu_arm1020_name:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm1020_proc_info,#object
 __arm1020_proc_info:
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index ae3c27b71594d..928e8ca58f409 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -463,7 +463,7 @@ arm1020e_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm1020e_proc_info,#object
 __arm1020e_proc_info:
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index dbb2413fe04db..385584c3d2225 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -448,7 +448,7 @@ arm1022_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm1022_proc_info,#object
 __arm1022_proc_info:
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 0b37b2cef9d32..29cc818573734 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -442,7 +442,7 @@ arm1026_crval:
 	string	cpu_arm1026_name, "ARM1026EJ-S"
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm1026_proc_info,#object
 __arm1026_proc_info:
diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
index 3651cd70e4181..c08cd1b0a1d0e 100644
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -186,7 +186,7 @@ arm720_crval:
  * See <asm/procinfo.h> for a definition of this structure.
  */
 	
-		.section ".proc.info.init", #alloc
+		.section ".proc.info.init", "a"
 
 .macro arm720_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cpu_flush:req
 		.type	__\name\()_proc_info,#object
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index 024fb7732407d..6eed87103b95b 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -132,7 +132,7 @@ __arm740_setup:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 	.type	__arm740_proc_info,#object
 __arm740_proc_info:
 	.long	0x41807400
diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index 25472d94426d2..beb64a7ccb38d 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -76,7 +76,7 @@ __arm7tdmi_setup:
 
 		.align
 
-		.section ".proc.info.init", #alloc
+		.section ".proc.info.init", "a"
 
 .macro arm7tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, \
 	extra_hwcaps=0
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 7a14bd4414c9c..5d43197083622 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -448,7 +448,7 @@ arm920_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm920_proc_info,#object
 __arm920_proc_info:
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index edccfcdcd551f..7e22ca780b369 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -426,7 +426,7 @@ arm922_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm922_proc_info,#object
 __arm922_proc_info:
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 32a47cc19076c..d343e77b84567 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -491,7 +491,7 @@ arm925_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro arm925_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache
 	.type	__\name\()_proc_info,#object
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index fb827c633693c..8cf78c608c422 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -474,7 +474,7 @@ arm926_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm926_proc_info,#object
 __arm926_proc_info:
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index ee5b66f847c44..631ae64eeccd8 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -344,7 +344,7 @@ __arm940_setup:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm940_proc_info,#object
 __arm940_proc_info:
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 7361837edc312..033ad7402d67c 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -399,7 +399,7 @@ __arm946_setup:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 	.type	__arm946_proc_info,#object
 __arm946_proc_info:
 	.long	0x41009460
diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
index 7fac8c6121349..2195468ccd76d 100644
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ b/arch/arm/mm/proc-arm9tdmi.S
@@ -70,7 +70,7 @@ __arm9tdmi_setup:
 
 		.align
 
-		.section ".proc.info.init", #alloc
+		.section ".proc.info.init", "a"
 
 .macro arm9tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
 		.type	__\name\()_proc_info, #object
diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
index 4001b73af4ee1..fd3e5dd94e59e 100644
--- a/arch/arm/mm/proc-fa526.S
+++ b/arch/arm/mm/proc-fa526.S
@@ -190,7 +190,7 @@ fa526_cr1_set:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__fa526_proc_info,#object
 __fa526_proc_info:
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 92e08bf37aad9..685d324a74d38 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -584,7 +584,7 @@ feroceon_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro feroceon_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache:req
 	.type	__\name\()_proc_info,#object
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 6f07d2ef4ff26..9182321a586af 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -429,7 +429,7 @@ mohawk_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__88sv331x_proc_info,#object
 __88sv331x_proc_info:
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index ee2ce496239f5..093ad2ceff284 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -199,7 +199,7 @@ sa110_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__sa110_proc_info,#object
 __sa110_proc_info:
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 222d5836f6664..12b8fcab4b59e 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -242,7 +242,7 @@ sa1100_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro sa1100_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
 	.type	__\name\()_proc_info,#object
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 06d890a2342b1..32f4df0915ef1 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -264,7 +264,7 @@ v6_crval:
 	string	cpu_elf_name, "v6"
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	/*
 	 * Match any ARMv6 processor core.
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 339eb17c9808e..e351d682c2e36 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -637,7 +637,7 @@ __v7_setup_stack:
 	string	cpu_elf_name, "v7"
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	/*
 	 * Standard v7 proc info content
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 9c2978c128d97..0be14b64879c8 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -96,7 +96,7 @@ ENTRY(cpu_cm7_proc_fin)
 	ret	lr
 ENDPROC(cpu_cm7_proc_fin)
 
-	.section ".init.text", #alloc, #execinstr
+	.section ".init.text", "ax"
 
 __v7m_cm7_setup:
 	mov	r8, #(V7M_SCB_CCR_DC | V7M_SCB_CCR_IC| V7M_SCB_CCR_BP)
@@ -180,7 +180,7 @@ ENDPROC(__v7m_setup)
 	string cpu_elf_name "v7m"
 	string cpu_v7m_name "ARMv7-M"
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro __v7m_proc name, initfunc, cache_fns = nop_cache_fns, hwcaps = 0,  proc_fns = v7m_processor_functions
 	.long	0			/* proc_info_list.__cpu_mm_mmu_flags */
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 293dcc2c441f3..da96e4de13537 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -499,7 +499,7 @@ xsc3_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro xsc3_proc_info name:req, cpu_val:req, cpu_mask:req
 	.type	__\name\()_proc_info,#object
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 3d75b7972fd13..c7800c69921b2 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -613,7 +613,7 @@ xscale_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro xscale_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache
 	.type	__\name\()_proc_info,#object
-- 
2.42.0



