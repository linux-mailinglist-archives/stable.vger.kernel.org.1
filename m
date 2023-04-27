Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030976F0AB3
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbjD0RVx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 13:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243368AbjD0RVw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 13:21:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9919DE9
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 10:21:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b7b54642cso6234382b3a.0
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1682616111; x=1685208111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNtL1ToyaDI49KILneoIml17t1O23zAqm7k615OmH8s=;
        b=EypZ5APoR9XMiLmVdsSgmTIo1krz2s63NHHb+2JdoeWKmy8NKzNHq+xEcjyw6/7wCC
         CRn/9cHQEb1ZzEkUQ6MIdZSgSuXwEH4IPNL172raD7ogdGAffM1iyPFEmPnwq8B9aOBj
         V0WUz+Vxf4tLD47CPZdLOUyByErJVaeSaYL/fVHwiS52+t6VENbDNIx6Ju3G2x9eHkCd
         ZA23Nes1ntH6miZpUktyde7XNROemSs9yKx5Dd0h3WD93SY11Krfkhi/ZPP+aWIdcbO8
         ecIljWJzamKikq8iWAufJXjCyitVbFFMI48zws+izarItifLqH8tjB6I/GEYaVV6I9Tv
         XapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682616111; x=1685208111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNtL1ToyaDI49KILneoIml17t1O23zAqm7k615OmH8s=;
        b=LgLFMiOiStEUiLUzlBE1Z7c3xIaMvvWVVvc9AoFlftLouYCk3n8qppO0ppiKdPq9yr
         cReZ0v8NbSXIzoPisEjouSCYnjFM6k/Er+dwCYq8CRnBGkzA4aQeUe6vPekue8xR37Y/
         F4ruhFriuvzOtLYSTI+8nGbaRkGW1PtT69+gefV5fRTX5E5Dd4Mk3T0eBYI0lXjbHZ2n
         gqUNKGW6F+JQH+h5EpT7Olr4PcbavtESpWWut9M2pZbfOBIETRdEnTz8W1g0StahtKgq
         VWCGpDxNxj1JY99gTeuWI75iUzxJnX1wNvYhXtXGWFCAbjA4/KTKGOrFkH8iqOSpGqoH
         tkPQ==
X-Gm-Message-State: AC+VfDyMjknUcFew2l4z1o9+45RLvSQvwNN88DXOYQN+D5btddd15nQ4
        2gTFpJc39fs4yWxj2ltYZOjRb6beiBO5ZFVWK+Deo27H
X-Google-Smtp-Source: ACHHUZ4KeeACGoIbUAVTXrFepdSEFNiZsiSKQTqi0VOiieCL8Lb13DFQfZ1LiYB8kF4DFNJcTDpqNw==
X-Received: by 2002:a05:6a00:181e:b0:624:7c9a:c832 with SMTP id y30-20020a056a00181e00b006247c9ac832mr3832092pfa.8.1682616110582;
        Thu, 27 Apr 2023 10:21:50 -0700 (PDT)
Received: from localhost.localdomain (2603-8081-76f0-8ce0-7554-9eea-496e-b331.res6.spectrum.com. [2603:8081:76f0:8ce0:7554:9eea:496e:b331])
        by smtp.gmail.com with ESMTPSA id y136-20020a62ce8e000000b0063d63d48215sm13438810pfg.3.2023.04.27.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:21:50 -0700 (PDT)
From:   Can Sun <cansun@arista.com>
To:     stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Can Sun <cansun@arista.com>
Subject: [BACKPORT PATCH 5.10.y] x86/fpu: Prevent FPU state corruption
Date:   Thu, 27 Apr 2023 12:21:34 -0500
Message-Id: <20230427172134.75628-1-cansun@arista.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Can Sun <cansun@arista.com>
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
 
