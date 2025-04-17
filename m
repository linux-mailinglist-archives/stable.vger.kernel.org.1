Return-Path: <stable+bounces-133915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5EBA928FC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2527B60B6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86825743D;
	Thu, 17 Apr 2025 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NhEuO/M0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0AB2528FA;
	Thu, 17 Apr 2025 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914532; cv=none; b=a4d8BZFUNVXZBYkkXKgD7oN39Tf8uews7Cx3Fvv3JuTIl8c6Y3fJHr7m69AXlL9k3vf/d1OFjPMUmKXNtmi5clNbUs1nRgpeNr1QjX+xSrcteQqegqoJNcapGBlgvzhqvVgqHK8UOB6FsgM40LCQKwVgbPpDgthmHCk4C8eXRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914532; c=relaxed/simple;
	bh=s5ni4ydf/qYO2MgsCLXVrAMSBuqU3spoBocjru0oVC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nq8xsOAGVVww0YqcTJUQDxOJkkPOXlODUkeKt33nPG0CvSfSL0pQNIRfLfS+5rSzqQdnfotkKHpB1Rsit4GOUsSiEDCPxiTRdSR+KSOqBUAuMZAt3WxxXSldlfXuvBDR48paqeyTCNR6st5CNKjz0cLRsV7aVDTByDGYcgMXHxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NhEuO/M0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4640C4CEE4;
	Thu, 17 Apr 2025 18:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914532;
	bh=s5ni4ydf/qYO2MgsCLXVrAMSBuqU3spoBocjru0oVC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhEuO/M0lKFeYodryCRcXeJCZnpsyUpqpmiSI4L0fI08dXJIO2cdj7NikSHN67Hyk
	 CJFbXDs65WHjBJWoprSdyEw/LFqssKun9WqxGuDjzzHTKq8Xrbw1g8T4PT48LT5Mks
	 bc2RNf+43OkibEAgnCY6Z4w0f8FhfhwPzF9xyND8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 6.13 216/414] KVM: arm64: Set HCR_EL2.TID1 unconditionally
Date: Thu, 17 Apr 2025 19:49:34 +0200
Message-ID: <20250417175120.122943973@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Upton <oliver.upton@linux.dev>

commit 4cd48565b0e5df398e7253c0d2d8c0403d69e7bf upstream.

commit 90807748ca3a ("KVM: arm64: Hide SME system registers from
guests") added trap handling for SMIDR_EL1, treating it as UNDEFINED as
KVM does not support SME. This is right for the most part, however KVM
needs to set HCR_EL2.TID1 to _actually_ trap the register.

Unfortunately, this comes with some collateral damage as TID1 forces
REVIDR_EL1 and AIDR_EL1 to trap as well. KVM has long treated these
registers as "invariant" which is an awful term for the following:

 - Userspace sees the boot CPU values on all vCPUs

 - The guest sees the hardware values of the CPU on which a vCPU is
   scheduled

Keep the plates spinning by adding trap handling for the affected
registers and repaint all of the "invariant" crud into terms of
identifying an implementation. Yes, at this point we only need to
set TID1 on SME hardware, but REVIDR_EL1 and AIDR_EL1 are about to
become mutable anyway.

Cc: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 90807748ca3a ("KVM: arm64: Hide SME system registers from guests")
[maz: handle traps from 32bit]
Co-developed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20250225005401.679536-2-oliver.upton@linux.dev
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_arm.h |    4 
 arch/arm64/kvm/sys_regs.c        |  183 ++++++++++++++++++++-------------------
 2 files changed, 100 insertions(+), 87 deletions(-)

--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -92,12 +92,12 @@
  * SWIO:	Turn set/way invalidates into set/way clean+invalidate
  * PTW:		Take a stage2 fault if a stage1 walk steps in device memory
  * TID3:	Trap EL1 reads of group 3 ID registers
- * TID2:	Trap CTR_EL0, CCSIDR2_EL1, CLIDR_EL1, and CSSELR_EL1
+ * TID1:	Trap REVIDR_EL1, AIDR_EL1, and SMIDR_EL1
  */
 #define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
 			 HCR_BSU_IS | HCR_FB | HCR_TACR | \
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
-			 HCR_FMO | HCR_IMO | HCR_PTW | HCR_TID3)
+			 HCR_FMO | HCR_IMO | HCR_PTW | HCR_TID3 | HCR_TID1)
 #define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
 #define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2450,6 +2450,93 @@ static bool access_mdcr(struct kvm_vcpu
 	return true;
 }
 
+/*
+ * For historical (ahem ABI) reasons, KVM treated MIDR_EL1, REVIDR_EL1, and
+ * AIDR_EL1 as "invariant" registers, meaning userspace cannot change them.
+ * The values made visible to userspace were the register values of the boot
+ * CPU.
+ *
+ * At the same time, reads from these registers at EL1 previously were not
+ * trapped, allowing the guest to read the actual hardware value. On big-little
+ * machines, this means the VM can see different values depending on where a
+ * given vCPU got scheduled.
+ *
+ * These registers are now trapped as collateral damage from SME, and what
+ * follows attempts to give a user / guest view consistent with the existing
+ * ABI.
+ */
+static bool access_imp_id_reg(struct kvm_vcpu *vcpu,
+			      struct sys_reg_params *p,
+			      const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	switch (reg_to_encoding(r)) {
+	case SYS_REVIDR_EL1:
+		p->regval = read_sysreg(revidr_el1);
+		break;
+	case SYS_AIDR_EL1:
+		p->regval = read_sysreg(aidr_el1);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	return true;
+}
+
+static u64 __ro_after_init boot_cpu_midr_val;
+static u64 __ro_after_init boot_cpu_revidr_val;
+static u64 __ro_after_init boot_cpu_aidr_val;
+
+static void init_imp_id_regs(void)
+{
+	boot_cpu_midr_val = read_sysreg(midr_el1);
+	boot_cpu_revidr_val = read_sysreg(revidr_el1);
+	boot_cpu_aidr_val = read_sysreg(aidr_el1);
+}
+
+static int get_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			  u64 *val)
+{
+	switch (reg_to_encoding(r)) {
+	case SYS_MIDR_EL1:
+		*val = boot_cpu_midr_val;
+		break;
+	case SYS_REVIDR_EL1:
+		*val = boot_cpu_revidr_val;
+		break;
+	case SYS_AIDR_EL1:
+		*val = boot_cpu_aidr_val;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int set_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			  u64 val)
+{
+	u64 expected;
+	int ret;
+
+	ret = get_imp_id_reg(vcpu, r, &expected);
+	if (ret)
+		return ret;
+
+	return (expected == val) ? 0 : -EINVAL;
+}
+
+#define IMPLEMENTATION_ID(reg) {			\
+	SYS_DESC(SYS_##reg),				\
+	.access = access_imp_id_reg,			\
+	.get_user = get_imp_id_reg,			\
+	.set_user = set_imp_id_reg,			\
+}
 
 /*
  * Architected system registers.
@@ -2499,7 +2586,9 @@ static const struct sys_reg_desc sys_reg
 
 	{ SYS_DESC(SYS_DBGVCR32_EL2), undef_access, reset_val, DBGVCR32_EL2, 0 },
 
+	IMPLEMENTATION_ID(MIDR_EL1),
 	{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1 },
+	IMPLEMENTATION_ID(REVIDR_EL1),
 
 	/*
 	 * ID regs: all ID_SANITISED() entries here must have corresponding
@@ -2770,6 +2859,7 @@ static const struct sys_reg_desc sys_reg
 	  .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
+	IMPLEMENTATION_ID(AIDR_EL1),
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	ID_FILTERED(CTR_EL0, ctr_el0,
 		    CTR_EL0_DIC_MASK |
@@ -4203,9 +4293,13 @@ int kvm_handle_cp15_32(struct kvm_vcpu *
 	 * Certain AArch32 ID registers are handled by rerouting to the AArch64
 	 * system register table. Registers in the ID range where CRm=0 are
 	 * excluded from this scheme as they do not trivially map into AArch64
-	 * system register encodings.
+	 * system register encodings, except for AIDR/REVIDR.
 	 */
-	if (params.Op1 == 0 && params.CRn == 0 && params.CRm)
+	if (params.Op1 == 0 && params.CRn == 0 &&
+	    (params.CRm || params.Op2 == 6 /* REVIDR */))
+		return kvm_emulate_cp15_id_reg(vcpu, &params);
+	if (params.Op1 == 1 && params.CRn == 0 &&
+	    params.CRm == 0 && params.Op2 == 7 /* AIDR */)
 		return kvm_emulate_cp15_id_reg(vcpu, &params);
 
 	return kvm_handle_cp_32(vcpu, &params, cp15_regs, ARRAY_SIZE(cp15_regs));
@@ -4506,65 +4600,6 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu
 	return r;
 }
 
-/*
- * These are the invariant sys_reg registers: we let the guest see the
- * host versions of these, so they're part of the guest state.
- *
- * A future CPU may provide a mechanism to present different values to
- * the guest, or a future kvm may trap them.
- */
-
-#define FUNCTION_INVARIANT(reg)						\
-	static u64 reset_##reg(struct kvm_vcpu *v,			\
-			       const struct sys_reg_desc *r)		\
-	{								\
-		((struct sys_reg_desc *)r)->val = read_sysreg(reg);	\
-		return ((struct sys_reg_desc *)r)->val;			\
-	}
-
-FUNCTION_INVARIANT(midr_el1)
-FUNCTION_INVARIANT(revidr_el1)
-FUNCTION_INVARIANT(aidr_el1)
-
-/* ->val is filled in by kvm_sys_reg_table_init() */
-static struct sys_reg_desc invariant_sys_regs[] __ro_after_init = {
-	{ SYS_DESC(SYS_MIDR_EL1), NULL, reset_midr_el1 },
-	{ SYS_DESC(SYS_REVIDR_EL1), NULL, reset_revidr_el1 },
-	{ SYS_DESC(SYS_AIDR_EL1), NULL, reset_aidr_el1 },
-};
-
-static int get_invariant_sys_reg(u64 id, u64 __user *uaddr)
-{
-	const struct sys_reg_desc *r;
-
-	r = get_reg_by_id(id, invariant_sys_regs,
-			  ARRAY_SIZE(invariant_sys_regs));
-	if (!r)
-		return -ENOENT;
-
-	return put_user(r->val, uaddr);
-}
-
-static int set_invariant_sys_reg(u64 id, u64 __user *uaddr)
-{
-	const struct sys_reg_desc *r;
-	u64 val;
-
-	r = get_reg_by_id(id, invariant_sys_regs,
-			  ARRAY_SIZE(invariant_sys_regs));
-	if (!r)
-		return -ENOENT;
-
-	if (get_user(val, uaddr))
-		return -EFAULT;
-
-	/* This is what we mean by invariant: you can't change it. */
-	if (r->val != val)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int demux_c15_get(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 {
 	u32 val;
@@ -4646,15 +4681,10 @@ int kvm_sys_reg_get_user(struct kvm_vcpu
 int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
-	int err;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_get(vcpu, reg->id, uaddr);
 
-	err = get_invariant_sys_reg(reg->id, uaddr);
-	if (err != -ENOENT)
-		return err;
-
 	return kvm_sys_reg_get_user(vcpu, reg,
 				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 }
@@ -4690,15 +4720,10 @@ int kvm_sys_reg_set_user(struct kvm_vcpu
 int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
-	int err;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_set(vcpu, reg->id, uaddr);
 
-	err = set_invariant_sys_reg(reg->id, uaddr);
-	if (err != -ENOENT)
-		return err;
-
 	return kvm_sys_reg_set_user(vcpu, reg,
 				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 }
@@ -4787,23 +4812,14 @@ static int walk_sys_regs(struct kvm_vcpu
 
 unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu)
 {
-	return ARRAY_SIZE(invariant_sys_regs)
-		+ num_demux_regs()
+	return num_demux_regs()
 		+ walk_sys_regs(vcpu, (u64 __user *)NULL);
 }
 
 int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
-	unsigned int i;
 	int err;
 
-	/* Then give them all the invariant registers' indices. */
-	for (i = 0; i < ARRAY_SIZE(invariant_sys_regs); i++) {
-		if (put_user(sys_reg_to_index(&invariant_sys_regs[i]), uindices))
-			return -EFAULT;
-		uindices++;
-	}
-
 	err = walk_sys_regs(vcpu, uindices);
 	if (err < 0)
 		return err;
@@ -5021,15 +5037,12 @@ int __init kvm_sys_reg_table_init(void)
 	valid &= check_sysreg_table(cp14_64_regs, ARRAY_SIZE(cp14_64_regs), true);
 	valid &= check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs), true);
 	valid &= check_sysreg_table(cp15_64_regs, ARRAY_SIZE(cp15_64_regs), true);
-	valid &= check_sysreg_table(invariant_sys_regs, ARRAY_SIZE(invariant_sys_regs), false);
 	valid &= check_sysreg_table(sys_insn_descs, ARRAY_SIZE(sys_insn_descs), false);
 
 	if (!valid)
 		return -EINVAL;
 
-	/* We abuse the reset function to overwrite the table itself. */
-	for (i = 0; i < ARRAY_SIZE(invariant_sys_regs); i++)
-		invariant_sys_regs[i].reset(NULL, &invariant_sys_regs[i]);
+	init_imp_id_regs();
 
 	ret = populate_nv_trap_config();
 



