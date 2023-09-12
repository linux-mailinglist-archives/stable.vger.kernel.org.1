Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC479B1F8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358447AbjIKWKy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbjIKOY5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:24:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE55ADE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:24:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2345CC433C7;
        Mon, 11 Sep 2023 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442291;
        bh=dB8fWRTGrGUkudCpmeqDTB/B8g0n3raoqZpYdR/Ei6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKC7o9xjKaUx4NRhBbl3XIzulpOj4lal3AUDWl78XbeltWDES8u9rsu7P1w7USYg5
         4BS8y/jRLlOCFB0wvWVieDeg+BjejGW1oobqnzWYgbKMhJWKRmwfvcsjBtlz8TFjc9
         AiGeCUAgjmQQ4qZ0lSr6cwIkk04GyBNJGBUZMb58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.5 714/739] RISC-V: Add ptrace support for vectors
Date:   Mon, 11 Sep 2023 15:48:33 +0200
Message-ID: <20230911134711.022846164@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Chiu <andy.chiu@sifive.com>

commit 9300f00439743c4a34d735e1a27118eb68a1504e upstream.

This patch add back the ptrace support with the following fix:
 - Define NT_RISCV_CSR and re-number NT_RISCV_VECTOR to prevent
   conflicting with gdb's NT_RISCV_CSR.
 - Use struct __riscv_v_regset_state to handle ptrace requests

Since gdb does not directly include the note description header in
Linux and has already defined NT_RISCV_CSR as 0x900, we decide to
sync with gdb and renumber NT_RISCV_VECTOR to solve and prevent future
conflicts.

Fixes: 0c59922c769a ("riscv: Add ptrace vector support")
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Link: https://lore.kernel.org/r/20230825050248.32681-1-andy.chiu@sifive.com
[Palmer: Drop the unused "size" variable in riscv_vr_set().]
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/uapi/asm/ptrace.h | 13 +++--
 arch/riscv/kernel/ptrace.c           | 79 ++++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |  2 +
 3 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index 283800130614..575e95bb1bc3 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -103,13 +103,18 @@ struct __riscv_v_ext_state {
 	 * In signal handler, datap will be set a correct user stack offset
 	 * and vector registers will be copied to the address of datap
 	 * pointer.
-	 *
-	 * In ptrace syscall, datap will be set to zero and the vector
-	 * registers will be copied to the address right after this
-	 * structure.
 	 */
 };
 
+struct __riscv_v_regset_state {
+	unsigned long vstart;
+	unsigned long vl;
+	unsigned long vtype;
+	unsigned long vcsr;
+	unsigned long vlenb;
+	char vreg[];
+};
+
 /*
  * According to spec: The number of bits in a single vector register,
  * VLEN >= ELEN, which must be a power of 2, and must be no greater than
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 487303e3ef22..2afe460de16a 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -25,6 +25,9 @@ enum riscv_regset {
 #ifdef CONFIG_FPU
 	REGSET_F,
 #endif
+#ifdef CONFIG_RISCV_ISA_V
+	REGSET_V,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -81,6 +84,71 @@ static int riscv_fpr_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_RISCV_ISA_V
+static int riscv_vr_get(struct task_struct *target,
+			const struct user_regset *regset,
+			struct membuf to)
+{
+	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
+	struct __riscv_v_regset_state ptrace_vstate;
+
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return -EINVAL;
+
+	/*
+	 * Ensure the vector registers have been saved to the memory before
+	 * copying them to membuf.
+	 */
+	if (target == current)
+		riscv_v_vstate_save(current, task_pt_regs(current));
+
+	ptrace_vstate.vstart = vstate->vstart;
+	ptrace_vstate.vl = vstate->vl;
+	ptrace_vstate.vtype = vstate->vtype;
+	ptrace_vstate.vcsr = vstate->vcsr;
+	ptrace_vstate.vlenb = vstate->vlenb;
+
+	/* Copy vector header from vstate. */
+	membuf_write(&to, &ptrace_vstate, sizeof(struct __riscv_v_regset_state));
+
+	/* Copy all the vector registers from vstate. */
+	return membuf_write(&to, vstate->datap, riscv_v_vsize);
+}
+
+static int riscv_vr_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
+	struct __riscv_v_regset_state ptrace_vstate;
+
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return -EINVAL;
+
+	/* Copy rest of the vstate except datap */
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ptrace_vstate, 0,
+				 sizeof(struct __riscv_v_regset_state));
+	if (unlikely(ret))
+		return ret;
+
+	if (vstate->vlenb != ptrace_vstate.vlenb)
+		return -EINVAL;
+
+	vstate->vstart = ptrace_vstate.vstart;
+	vstate->vl = ptrace_vstate.vl;
+	vstate->vtype = ptrace_vstate.vtype;
+	vstate->vcsr = ptrace_vstate.vcsr;
+
+	/* Copy all the vector registers. */
+	pos = 0;
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, vstate->datap,
+				 0, riscv_v_vsize);
+	return ret;
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -100,6 +168,17 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = riscv_fpr_set,
 	},
 #endif
+#ifdef CONFIG_RISCV_ISA_V
+	[REGSET_V] = {
+		.core_note_type = NT_RISCV_VECTOR,
+		.align = 16,
+		.n = ((32 * RISCV_MAX_VLENB) +
+		      sizeof(struct __riscv_v_regset_state)) / sizeof(__u32),
+		.size = sizeof(__u32),
+		.regset_get = riscv_vr_get,
+		.set = riscv_vr_set,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index e0e159138331..20e285fdbc46 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -443,6 +443,8 @@ typedef struct elf64_shdr {
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
 #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
+#define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
+#define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
-- 
2.42.0



