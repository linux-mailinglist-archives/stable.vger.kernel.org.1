Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280B575D1C1
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGUSwh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjGUSwg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16AB359B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 670D261D80
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4990DC433C8;
        Fri, 21 Jul 2023 18:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965547;
        bh=O6ii9QHhzBZmfEuJkd3kxifIruJiZwgSdr+wrqiBt7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2EF0RRaiDu8qhoqFcxnOlPRUAwTozQYzeHUIfwdUC9RH06lGidmM8zwZHA/rGKEBV
         Qdsfgu5e87IRarY3LKz5T5dp117u0GUA+528qrFiJBpGPyRzuxGt2xWQA/cnIO7eYL
         EenX/OHaLkUnLcqf4Ut0AaXqCQPrFQlLgcB78Ex4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 029/532] locking/atomic: arm: fix sync ops
Date:   Fri, 21 Jul 2023 17:58:53 +0200
Message-ID: <20230721160616.239127646@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit dda5f312bb09e56e7a1c3e3851f2000eb2e9c879 ]

The sync_*() ops on arch/arm are defined in terms of the regular bitops
with no special handling. This is not correct, as UP kernels elide
barriers for the fully-ordered operations, and so the required ordering
is lost when such UP kernels are run under a hypervsior on an SMP
system.

Fix this by defining sync ops with the required barriers.

Note: On 32-bit arm, the sync_*() ops are currently only used by Xen,
which requires ARMv7, but the semantics can be implemented for ARMv6+.

Fixes: e54d2f61528165bb ("xen/arm: sync_bitops")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-2-mark.rutland@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/assembler.h   | 17 +++++++++++++++++
 arch/arm/include/asm/sync_bitops.h | 29 +++++++++++++++++++++++++----
 arch/arm/lib/bitops.h              | 14 +++++++++++---
 arch/arm/lib/testchangebit.S       |  4 ++++
 arch/arm/lib/testclearbit.S        |  4 ++++
 arch/arm/lib/testsetbit.S          |  4 ++++
 6 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 09c241280ed9c..5d52da168ab3a 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -326,6 +326,23 @@
 #endif
 	.endm
 
+/*
+ * Raw SMP data memory barrier
+ */
+	.macro	__smp_dmb mode
+#if __LINUX_ARM_ARCH__ >= 7
+	.ifeqs "\mode","arm"
+	dmb	ish
+	.else
+	W(dmb)	ish
+	.endif
+#elif __LINUX_ARM_ARCH__ == 6
+	mcr	p15, 0, r0, c7, c10, 5	@ dmb
+#else
+	.error "Incompatible SMP platform"
+#endif
+	.endm
+
 #if defined(CONFIG_CPU_V7M)
 	/*
 	 * setmode is used to assert to be in svc mode during boot. For v7-M
diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
index 6f5d627c44a3c..f46b3c570f92e 100644
--- a/arch/arm/include/asm/sync_bitops.h
+++ b/arch/arm/include/asm/sync_bitops.h
@@ -14,14 +14,35 @@
  * ops which are SMP safe even on a UP kernel.
  */
 
+/*
+ * Unordered
+ */
+
 #define sync_set_bit(nr, p)		_set_bit(nr, p)
 #define sync_clear_bit(nr, p)		_clear_bit(nr, p)
 #define sync_change_bit(nr, p)		_change_bit(nr, p)
-#define sync_test_and_set_bit(nr, p)	_test_and_set_bit(nr, p)
-#define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
-#define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
 #define sync_test_bit(nr, addr)		test_bit(nr, addr)
-#define arch_sync_cmpxchg		arch_cmpxchg
 
+/*
+ * Fully ordered
+ */
+
+int _sync_test_and_set_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_set_bit(nr, p)	_sync_test_and_set_bit(nr, p)
+
+int _sync_test_and_clear_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_clear_bit(nr, p)	_sync_test_and_clear_bit(nr, p)
+
+int _sync_test_and_change_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_change_bit(nr, p)	_sync_test_and_change_bit(nr, p)
+
+#define arch_sync_cmpxchg(ptr, old, new)				\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	__smp_mb__before_atomic();					\
+	__ret = arch_cmpxchg_relaxed((ptr), (old), (new));		\
+	__smp_mb__after_atomic();					\
+	__ret;								\
+})
 
 #endif
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 95bd359912889..f069d1b2318e6 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -28,7 +28,7 @@ UNWIND(	.fnend		)
 ENDPROC(\name		)
 	.endm
 
-	.macro	testop, name, instr, store
+	.macro	__testop, name, instr, store, barrier
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
@@ -38,7 +38,7 @@ UNWIND(	.fnstart	)
 	mov	r0, r0, lsr #5
 	add	r1, r1, r0, lsl #2	@ Get word offset
 	mov	r3, r2, lsl r3		@ create mask
-	smp_dmb
+	\barrier
 #if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
 	.arch_extension	mp
 	ALT_SMP(W(pldw)	[r1])
@@ -50,13 +50,21 @@ UNWIND(	.fnstart	)
 	strex	ip, r2, [r1]
 	cmp	ip, #0
 	bne	1b
-	smp_dmb
+	\barrier
 	cmp	r0, #0
 	movne	r0, #1
 2:	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
 	.endm
+
+	.macro	testop, name, instr, store
+	__testop \name, \instr, \store, smp_dmb
+	.endm
+
+	.macro	sync_testop, name, instr, store
+	__testop \name, \instr, \store, __smp_dmb
+	.endm
 #else
 	.macro	bitop, name, instr
 ENTRY(	\name		)
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 4ebecc67e6e04..f13fe9bc2399a 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_change_bit, eor, str
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_change_bit, eor, str
+#endif
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 009afa0f5b4a7..4d2c5ca620ebf 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_clear_bit, bicne, strne
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_clear_bit, bicne, strne
+#endif
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index f3192e55acc87..649dbab65d8d0 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_set_bit, orreq, streq
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_set_bit, orreq, streq
+#endif
-- 
2.39.2



