Return-Path: <stable+bounces-151851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C747AD0E23
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A1D3AF5F8
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794971D7984;
	Sat,  7 Jun 2025 15:33:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138BD1DEFD2
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310390; cv=none; b=XglYdKrTxEIricUW8xeZT/+XXsa8syEcUuuvgV6lYURul3YqB6p4ipdeRGlF0L1spDGoQTASnBuvvl0NCgkWvm4zn7CfOFe6Z+mfPWw0b37QgnLWW1WqR2AeDB1ekz1r6t+Wly1D96GgbmtX1tg2L/dSx+7dY37rPKhzxt9InJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310390; c=relaxed/simple;
	bh=iST2jIKQHOBMK2+YxXaaVnwuy14Xfx57kBGspuQYT94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSOPhhA0hsh8EjiqLNFlEyh0r0TibGJG+ppyRtIlg/cBz6e61Rpyhr1v4EFu29dFMwGA8rvQO/CaKWzgBP+FYAc6dSVyD3Ar7L4D3/4hhnOTp6JlJKDOtZ294APXwRrEcmdLihp2m5aK4KQP+quB3JyWeqLYvGx+jhdhWD03hP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bF2JM2dWmzYQvdk
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 65AC71A0E2F
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:06 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBH5sCwW0Rod05JOg--.5386S9;
	Sat, 07 Jun 2025 23:33:06 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.15 7/9] arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
Date: Sat,  7 Jun 2025 15:35:33 +0000
Message-Id: <20250607153535.3613861-8-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250607153535.3613861-1-pulehui@huaweicloud.com>
References: <20250607153535.3613861-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBH5sCwW0Rod05JOg--.5386S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4DZr4fXF1rCw4xArW5KFg_yoW7XFykpa
	n8Crn3GrWvgF1UWa4fJFyxAF90k3yvgr43Kryj934FyFnFvr9xWFn8K34akFZ5ArWrX3yr
	uFWUt3yrKa1UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUrfOzUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: James Morse <james.morse@arm.com>

[ Upstream commit 0dfefc2ea2f29ced2416017d7e5b1253a54c2735 ]

A malicious BPF program may manipulate the branch history to influence
what the hardware speculates will happen next.

On exit from a BPF program, emit the BHB mititgation sequence.

This is only applied for 'classic' cBPF programs that are loaded by
seccomp.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/include/asm/spectre.h |  1 +
 arch/arm64/kernel/proton-pack.c  |  2 +-
 arch/arm64/net/bpf_jit_comp.c    | 55 +++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 56d1427b95d0..0c55d6ed435d 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -97,6 +97,7 @@ enum mitigation_state arm64_get_meltdown_state(void);
 
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
+extern bool __nospectre_bhb;
 u8 get_spectre_bhb_loop_value(void);
 bool is_spectre_bhb_fw_mitigated(void);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 9cc14f6de63e..535fab25fde6 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -1023,7 +1023,7 @@ static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
 	isb();
 }
 
-static bool __read_mostly __nospectre_bhb;
+bool __read_mostly __nospectre_bhb;
 static int __init parse_spectre_bhb_param(char *str)
 {
 	__nospectre_bhb = true;
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 4895b4d7e150..2691e53007eb 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -7,14 +7,17 @@
 
 #define pr_fmt(fmt) "bpf_jit: " fmt
 
+#include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/cpu.h>
 #include <linux/filter.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 
 #include <asm/byteorder.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
 #include <asm/set_memory.h>
@@ -327,7 +330,48 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 #undef jmp_offset
 }
 
-static void build_epilogue(struct jit_ctx *ctx)
+/* Clobbers BPF registers 1-4, aka x0-x3 */
+static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
+{
+	const u8 r1 = bpf2a64[BPF_REG_1]; /* aka x0 */
+	u8 k = get_spectre_bhb_loop_value();
+
+	if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY) ||
+	    cpu_mitigations_off() || __nospectre_bhb ||
+	    arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE)
+		return;
+
+	if (supports_clearbhb(SCOPE_SYSTEM)) {
+		emit(aarch64_insn_gen_hint(AARCH64_INSN_HINT_CLEARBHB), ctx);
+		return;
+	}
+
+	if (k) {
+		emit_a64_mov_i64(r1, k, ctx);
+		emit(A64_B(1), ctx);
+		emit(A64_SUBS_I(true, r1, r1, 1), ctx);
+		emit(A64_B_(A64_COND_NE, -2), ctx);
+		emit(aarch64_insn_gen_dsb(AARCH64_INSN_MB_ISH), ctx);
+		emit(aarch64_insn_get_isb_value(), ctx);
+	}
+
+	if (is_spectre_bhb_fw_mitigated()) {
+		emit(A64_ORR_I(false, r1, AARCH64_INSN_REG_ZR,
+			       ARM_SMCCC_ARCH_WORKAROUND_3), ctx);
+		switch (arm_smccc_1_1_get_conduit()) {
+		case SMCCC_CONDUIT_HVC:
+			emit(aarch64_insn_get_hvc_value(), ctx);
+			break;
+		case SMCCC_CONDUIT_SMC:
+			emit(aarch64_insn_get_smc_value(), ctx);
+			break;
+		default:
+			pr_err_once("Firmware mitigation enabled with unknown conduit\n");
+		}
+	}
+}
+
+static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
 {
 	const u8 r0 = bpf2a64[BPF_REG_0];
 	const u8 r6 = bpf2a64[BPF_REG_6];
@@ -346,10 +390,13 @@ static void build_epilogue(struct jit_ctx *ctx)
 	emit(A64_POP(r8, r9, A64_SP), ctx);
 	emit(A64_POP(r6, r7, A64_SP), ctx);
 
+	if (was_classic)
+		build_bhb_mitigation(ctx);
+
 	/* Restore FP/LR registers */
 	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
 
-	/* Set return value */
+	/* Move the return value from bpf:r0 (aka x7) to x0 */
 	emit(A64_MOV(1, A64_R(0), r0), ctx);
 
 	emit(A64_RET(A64_LR), ctx);
@@ -1062,7 +1109,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx.epilogue_offset = ctx.idx;
-	build_epilogue(&ctx);
+	build_epilogue(&ctx, was_classic);
 
 	extable_size = prog->aux->num_exentries *
 		sizeof(struct exception_table_entry);
@@ -1094,7 +1141,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
-	build_epilogue(&ctx);
+	build_epilogue(&ctx, was_classic);
 
 	/* 3. Extra pass to validate JITed code. */
 	if (validate_code(&ctx)) {
-- 
2.34.1


