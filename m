Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D7D79B25F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbjIKWp6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbjIKPAa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFAE1B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C15C433C9;
        Mon, 11 Sep 2023 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444425;
        bh=Ao29eAZGGIdCWuRwrX2OJ1hblcnY0rFIbgt2zNQvSgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAHVBIwZQm8tl030bcJZUbpr/nPGgzW8NzFe4L8CPJG/eHOWeSCoCR5Q0Fbn1EONU
         kfpdhIZSjSI1v8Zrro5FYykIRZcfWa+p6HZc9eYbzC/Jg7RV3JDLFTa4SDU13MMNk4
         THYQhV/S81U5srzQ/TfIAjo3ylJRlWU/hrtlzquM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 725/737] LoongArch: Ensure FP/SIMD registers in the core dump file is up to date
Date:   Mon, 11 Sep 2023 15:49:44 +0200
Message-ID: <20230911134710.762393290@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 656f9aec07dba7c61d469727494a5d1b18d0bef4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/fpu.h | 22 ++++++++++++++++++----
 arch/loongarch/kernel/ptrace.c   |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index 192f8e35d9126..b1dc4200ae6a4 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -117,16 +117,30 @@ static inline void restore_fp(struct task_struct *tsk)
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
 
 #endif /* _ASM_FPU_H */
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index 5fcffb4523676..286c0ca39eae0 100644
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
-- 
2.40.1



