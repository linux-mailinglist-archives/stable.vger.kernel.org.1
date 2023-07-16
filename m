Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3875566A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGPUuV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjGPUuV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED998D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B24E60EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973EEC433C8;
        Sun, 16 Jul 2023 20:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540619;
        bh=5yUpshApNav88vZIvKAdFXNkOTF+7eIyBAzeo0SK7Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/rthxLBMNEiUEOJztF0sF2sWFddGKKOFbwOWuLT7ux6mKWkXimg1h+mFBcDgoVJs
         vIh/vd7MZFHlYYPbqN1vy1kuWByz0+KTBu4qqLQ4Ih4vJuEKkxaDW47fMhJ21lUO7b
         KBxmDZ1+Es77+BbCXepP+8KZumZ9M2ZspalBTSDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 427/591] sh: Avoid using IRQ0 on SH3 and SH4
Date:   Sun, 16 Jul 2023 21:49:26 +0200
Message-ID: <20230716194934.962902864@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit a8ac2961148e8c720dc760f2e06627cd5c55a154 ]

IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
return -EINVAL instead.  However, the kernel code supporting SH3/4-based
SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
IRQ #s from 16 instead.

The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
indeed are using IRQ0 for the SMSC911x compatible Ethernet chip.

Fixes: ce753ad1549c ("platform: finally disallow IRQ0 in platform_get_irq() and its ilk")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/include/mach-common/mach/highlander.h | 2 +-
 arch/sh/include/mach-common/mach/r2d.h        | 2 +-
 arch/sh/include/mach-dreamcast/mach/sysasic.h | 2 +-
 arch/sh/include/mach-se/mach/se7724.h         | 2 +-
 arch/sh/kernel/cpu/sh3/entry.S                | 4 ++--
 include/linux/sh_intc.h                       | 6 +++---
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sh/include/mach-common/mach/highlander.h b/arch/sh/include/mach-common/mach/highlander.h
index fb44c299d0337..b12c795584225 100644
--- a/arch/sh/include/mach-common/mach/highlander.h
+++ b/arch/sh/include/mach-common/mach/highlander.h
@@ -176,7 +176,7 @@
 #define IVDR_CK_ON	4		/* iVDR Clock ON */
 #endif
 
-#define HL_FPGA_IRQ_BASE	200
+#define HL_FPGA_IRQ_BASE	(200 + 16)
 #define HL_NR_IRL		15
 
 #define IRQ_AX88796		(HL_FPGA_IRQ_BASE + 0)
diff --git a/arch/sh/include/mach-common/mach/r2d.h b/arch/sh/include/mach-common/mach/r2d.h
index 0d7e483c7d3f5..69bc1907c5637 100644
--- a/arch/sh/include/mach-common/mach/r2d.h
+++ b/arch/sh/include/mach-common/mach/r2d.h
@@ -47,7 +47,7 @@
 
 #define IRLCNTR1	(PA_BCR + 0)	/* Interrupt Control Register1 */
 
-#define R2D_FPGA_IRQ_BASE	100
+#define R2D_FPGA_IRQ_BASE	(100 + 16)
 
 #define IRQ_VOYAGER		(R2D_FPGA_IRQ_BASE + 0)
 #define IRQ_EXT			(R2D_FPGA_IRQ_BASE + 1)
diff --git a/arch/sh/include/mach-dreamcast/mach/sysasic.h b/arch/sh/include/mach-dreamcast/mach/sysasic.h
index ed69ce7f20301..3b27be9a527ea 100644
--- a/arch/sh/include/mach-dreamcast/mach/sysasic.h
+++ b/arch/sh/include/mach-dreamcast/mach/sysasic.h
@@ -22,7 +22,7 @@
    takes.
 */
 
-#define HW_EVENT_IRQ_BASE  48
+#define HW_EVENT_IRQ_BASE  (48 + 16)
 
 /* IRQ 13 */
 #define HW_EVENT_VSYNC     (HW_EVENT_IRQ_BASE +  5) /* VSync */
diff --git a/arch/sh/include/mach-se/mach/se7724.h b/arch/sh/include/mach-se/mach/se7724.h
index 1fe28820dfa95..ea6c46633b337 100644
--- a/arch/sh/include/mach-se/mach/se7724.h
+++ b/arch/sh/include/mach-se/mach/se7724.h
@@ -37,7 +37,7 @@
 #define IRQ2_IRQ        evt2irq(0x640)
 
 /* Bits in IRQ012 registers */
-#define SE7724_FPGA_IRQ_BASE	220
+#define SE7724_FPGA_IRQ_BASE	(220 + 16)
 
 /* IRQ0 */
 #define IRQ0_BASE	SE7724_FPGA_IRQ_BASE
diff --git a/arch/sh/kernel/cpu/sh3/entry.S b/arch/sh/kernel/cpu/sh3/entry.S
index e48b3dd996f58..b1f5b3c58a018 100644
--- a/arch/sh/kernel/cpu/sh3/entry.S
+++ b/arch/sh/kernel/cpu/sh3/entry.S
@@ -470,9 +470,9 @@ ENTRY(handle_interrupt)
 	mov	r4, r0		! save vector->jmp table offset for later
 
 	shlr2	r4		! vector to IRQ# conversion
-	add	#-0x10, r4
 
-	cmp/pz	r4		! is it a valid IRQ?
+	mov	#0x10, r5
+	cmp/hs	r5, r4		! is it a valid IRQ?
 	bt	10f
 
 	/*
diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index 37ad81058d6ae..27ae79191bdc3 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -13,9 +13,9 @@
 /*
  * Convert back and forth between INTEVT and IRQ values.
  */
-#ifdef CONFIG_CPU_HAS_INTEVT
-#define evt2irq(evt)		(((evt) >> 5) - 16)
-#define irq2evt(irq)		(((irq) + 16) << 5)
+#ifdef CONFIG_CPU_HAS_INTEVT	/* Avoid IRQ0 (invalid for platform devices) */
+#define evt2irq(evt)		((evt) >> 5)
+#define irq2evt(irq)		((irq) << 5)
 #else
 #define evt2irq(evt)		(evt)
 #define irq2evt(irq)		(irq)
-- 
2.39.2



