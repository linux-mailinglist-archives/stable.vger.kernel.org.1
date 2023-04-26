Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E636EFD2C
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 00:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDZWfg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Apr 2023 18:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZWff (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Apr 2023 18:35:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FE5186
        for <stable@vger.kernel.org>; Wed, 26 Apr 2023 15:35:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b67a26069so9826341b3a.0
        for <stable@vger.kernel.org>; Wed, 26 Apr 2023 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1682548533; x=1685140533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIx98swIb5bdb0DO2YZEhMX84/Yp5Mfgkk4e/THBAUE=;
        b=RkmkEg1LwRz7mdya1D2gVnzw3rsNI2dh1/nezkia6XMCOPxwTyHk8edAV55NLctfTO
         pbxPeI7aNOnntREU5n/nMeNLzwFmN2MsOgxtnThwYKI6U7d4c/uH3U8u9DcavglXAVF+
         do6J3ZaguFdXFMVbE4p2+SmtiCfKL3X4DkAbg/kKRBNhQM2bdHRDBGqJp08+c7ieY8DD
         zFw1bBta7SoyEOAw6naZnsyVocaQYvwGEwUAqzUNkEu/8t2hDDMZ5JU+i9mMJcEFTgx2
         aL5vghad0KUC1E9P/aKM9PxjA0bM22jOTxkawIX8B9Lm5WD7U37yoMh7w1Y+tSHsakzV
         v86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682548533; x=1685140533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIx98swIb5bdb0DO2YZEhMX84/Yp5Mfgkk4e/THBAUE=;
        b=SDKrIBqADADim5Il6Tbk1hH58WxW6XFUwtCZV6AtVr/AK+ga4rE3jA2SwyLel2Bmnr
         zVw6R8j1Dxip/m9uub1GTKuAMAXuBKVrVS9BU1JEkuQzYPrVU3LhtW77FsEmUVpRKz70
         NPE6T+3UNNXj15mYXII7yKTjyWCtCh22/uTnw1n3wG1o9lw7iutJ3WaBMUsbyIbDUkZu
         mG+Qfq+KMwbJt+ytvRNgfiasIQ1rSPGUc0lCFsEIgtGYEDESshVHSB7aaUPKgROM/v7i
         UvTodCi0/SUaOG8finfqOEm4Wd5PGNojPBaEnAU9Go/sCsEaPpimBBwsqD5XDk8jXFcK
         JfrA==
X-Gm-Message-State: AAQBX9cRMNUdiu09FmmpVznOCAlSwHH4wgwPdXWKCk5xKmCt26kkweXj
        nBDTE/MLUAwKBTMU1OAdrqckT2veJnSOhn44f3w/2A==
X-Google-Smtp-Source: AKy350a2xUldkSmePpO3Rft0Aj2NST2SAVh5gCYvhEoLb4/DTsNCcnvdOAyVBjMJgr8eqYPUrfDbgQ==
X-Received: by 2002:a05:6a21:3383:b0:f0:3987:7b33 with SMTP id yy3-20020a056a21338300b000f039877b33mr31442599pzb.42.1682548533040;
        Wed, 26 Apr 2023 15:35:33 -0700 (PDT)
Received: from localhost.localdomain (2603-8081-76f0-8ce0-3c02-84da-4ea1-b3e9.res6.spectrum.com. [2603:8081:76f0:8ce0:3c02:84da:4ea1:b3e9])
        by smtp.gmail.com with ESMTPSA id b21-20020a62a115000000b0063b64f1d6e9sm10718945pff.33.2023.04.26.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 15:35:32 -0700 (PDT)
From:   Can Sun <cansun@arista.com>
To:     stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Can Sun <cansun@arista.com>
Subject: [BACKPORT PATCH 5.10.y] x86/fpu: Prevent FPU state corruption
Date:   Wed, 26 Apr 2023 17:35:08 -0500
Message-Id: <20230426223508.71750-1-cansun@arista.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ Upstream commit 59f5ede3bc0f00eb856425f636dab0c10feb06d8 ]

The FPU usage related to task FPU management is either protected by
disabling interrupts (switch_to, return to user) or via fpregs_lock() which
is a wrapper around local_bh_disable(). When kernel code wants to use the
FPU then it has to check whether it is possible by calling irq_fpu_usable().

But the condition in irq_fpu_usable() is wrong. It allows FPU to be used
when:

   !in_interrupt() || interrupted_user_mode() || interrupted_kernel_fpu_idle()

The latter is checking whether some other context already uses FPU in the
kernel, but if that's not the case then it allows FPU to be used
unconditionally even if the calling context interrupted a fpregs_lock()
critical region. If that happens then the FPU state of the interrupted
context becomes corrupted.

Allow in kernel FPU usage only when no other context has in kernel FPU
usage and either the calling context is not hard interrupt context or the
hard interrupt did not interrupt a local bottomhalf disabled region.

It's hard to find a proper Fixes tag as the condition was broken in one way
or the other for a very long time and the eager/lazy FPU changes caused a
lot of churn. Picked something remotely connected from the history.

This survived undetected for quite some time as FPU usage in interrupt
context is rare, but the recent changes to the random code unearthed it at
least on a kernel which had FPU debugging enabled. There is probably a
higher rate of silent corruption as not all issues can be detected by the
FPU debugging code. This will be addressed in a subsequent change.

Fixes: 5d2bd7009f30 ("x86, fpu: decouple non-lazy/eager fpu restore from xsave")
Reported-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: stable@vger.kernel.org
Cc: Can Sun <cansun@arista.com>
Link: https://lore.kernel.org/r/20220501193102.588689270@linutronix.de

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 571220ac8bea..835b948095cd 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -25,17 +25,7 @@
  */
 union fpregs_state init_fpstate __read_mostly;
 
-/*
- * Track whether the kernel is using the FPU state
- * currently.
- *
- * This flag is used:
- *
- *   - by IRQ context code to potentially use the FPU
- *     if it's unused.
- *
- *   - to debug kernel_fpu_begin()/end() correctness
- */
+/* Track in-kernel FPU usage */
 static DEFINE_PER_CPU(bool, in_kernel_fpu);
 
 /*
@@ -43,42 +33,37 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
-static bool kernel_fpu_disabled(void)
-{
-	return this_cpu_read(in_kernel_fpu);
-}
-
-static bool interrupted_kernel_fpu_idle(void)
-{
-	return !kernel_fpu_disabled();
-}
-
-/*
- * Were we in user mode (or vm86 mode) when we were
- * interrupted?
- *
- * Doing kernel_fpu_begin/end() is ok if we are running
- * in an interrupt context from user mode - we'll just
- * save the FPU state as required.
- */
-static bool interrupted_user_mode(void)
-{
-	struct pt_regs *regs = get_irq_regs();
-	return regs && user_mode(regs);
-}
-
 /*
  * Can we use the FPU in kernel mode with the
  * whole "kernel_fpu_begin/end()" sequence?
- *
- * It's always ok in process context (ie "not interrupt")
- * but it is sometimes ok even from an irq.
  */
 bool irq_fpu_usable(void)
 {
-	return !in_interrupt() ||
-		interrupted_user_mode() ||
-		interrupted_kernel_fpu_idle();
+	if (WARN_ON_ONCE(in_nmi()))
+		return false;
+
+	/* In kernel FPU usage already active? */
+	if (this_cpu_read(in_kernel_fpu))
+		return false;
+
+	/*
+	 * When not in NMI or hard interrupt context, FPU can be used in:
+	 *
+	 * - Task context except from within fpregs_lock()'ed critical
+	 *   regions.
+	 *
+	 * - Soft interrupt processing context which cannot happen
+	 *   while in a fpregs_lock()'ed critical region.
+	 */
+	if (!in_irq())
+		return true;
+
+	/*
+	 * In hard interrupt context it's safe when soft interrupts
+	 * are enabled, which means the interrupt did not hit in
+	 * a fpregs_lock()'ed critical region.
+	 */
+	return !softirq_count();
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
