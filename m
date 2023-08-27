Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C50789B96
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 08:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjH0Gpa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 02:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjH0GpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 02:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4801AA
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 23:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67BF661FD6
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 06:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54549C433C8;
        Sun, 27 Aug 2023 06:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693118708;
        bh=bUOsYHmlVUMAKb4Y7MByH1vCmgiGtY5+fJotYdJ16nA=;
        h=Subject:To:Cc:From:Date:From;
        b=rQOzRUIkwRGnvCDR/BdI5z6jRSzGGI0u4RINMtmPqFkycSIwotA2Z0M6f8qF7ZDXC
         bTqZtEQOE52L4OXiH96MS4U57OWGC9U1cEYTXURxlBe7HDkcuHZBUmX54aivrjFnfI
         Y7w1WgfardKdG1+kEAoTA03S8FbMfKsHgRSyf7cs=
Subject: FAILED: patch "[PATCH] LoongArch: Ensure FP/SIMD registers in the core dump file is" failed to apply to 6.4-stable tree
To:     chenhuacai@kernel.org, chenhuacai@loongson.cn
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 27 Aug 2023 08:45:05 +0200
Message-ID: <2023082705-predator-enjoyable-15fb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 656f9aec07dba7c61d469727494a5d1b18d0bef4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082705-predator-enjoyable-15fb@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 656f9aec07dba7c61d469727494a5d1b18d0bef4 Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 26 Aug 2023 22:21:57 +0800
Subject: [PATCH] LoongArch: Ensure FP/SIMD registers in the core dump file is
 up to date

This is a port of commit 379eb01c21795edb4c ("riscv: Ensure the value
of FP registers in the core dump file is up to date").

The values of FP/SIMD registers in the core dump file come from the
thread.fpu. However, kernel saves the FP/SIMD registers only before
scheduling out the process. If no process switch happens during the
exception handling, kernel will not have a chance to save the latest
values of FP/SIMD registers. So it may cause their values in the core
dump file incorrect. To solve this problem, force fpr_get()/simd_get()
to save the FP/SIMD registers into the thread.fpu if the target task
equals the current task.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index b541f6248837..c2d8962fda00 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -173,16 +173,30 @@ static inline void restore_fp(struct task_struct *tsk)
 		_restore_fp(&tsk->thread.fpu);
 }
 
-static inline union fpureg *get_fpu_regs(struct task_struct *tsk)
+static inline void save_fpu_regs(struct task_struct *tsk)
 {
+	unsigned int euen;
+
 	if (tsk == current) {
 		preempt_disable();
-		if (is_fpu_owner())
+
+		euen = csr_read32(LOONGARCH_CSR_EUEN);
+
+#ifdef CONFIG_CPU_HAS_LASX
+		if (euen & CSR_EUEN_LASXEN)
+			_save_lasx(&current->thread.fpu);
+		else
+#endif
+#ifdef CONFIG_CPU_HAS_LSX
+		if (euen & CSR_EUEN_LSXEN)
+			_save_lsx(&current->thread.fpu);
+		else
+#endif
+		if (euen & CSR_EUEN_FPEN)
 			_save_fp(&current->thread.fpu);
+
 		preempt_enable();
 	}
-
-	return tsk->thread.fpu.fpr;
 }
 
 static inline int is_simd_owner(void)
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index a0767c3a0f0a..f72adbf530c6 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -147,6 +147,8 @@ static int fpr_get(struct task_struct *target,
 {
 	int r;
 
+	save_fpu_regs(target);
+
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
 		r = gfpr_get(target, &to);
 	else
@@ -278,6 +280,8 @@ static int simd_get(struct task_struct *target,
 {
 	const unsigned int wr_size = NUM_FPU_REGS * regset->size;
 
+	save_fpu_regs(target);
+
 	if (!tsk_used_math(target)) {
 		/* The task hasn't used FP or LSX, fill with 0xff */
 		copy_pad_fprs(target, regset, &to, 0);

