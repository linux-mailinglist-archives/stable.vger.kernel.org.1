Return-Path: <stable+bounces-127457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99BAA798B5
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 01:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB3F1892884
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196401F8BCC;
	Wed,  2 Apr 2025 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrIW8pSu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA21F8BD0;
	Wed,  2 Apr 2025 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636068; cv=none; b=Mm4KVdVuSr3Fv9WO7n2+53MG9EpxoIqu9NOzLKJazdVyPjVGrV76hOcaklZJsVGtbA4/zgIyp+gufNNdgxi5+YZ9MYcMkQJzVn6lS5JRRYnngs8pMOBIc++BVNQh7jJxS+jVhnyk/WjWvKvuof8i40DfzxsVzprrArmqfOsdfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636068; c=relaxed/simple;
	bh=tZlWo93wGbEj8iC3H71eb10+hrSLcFB1nwvaPgD4lfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNUO1S53vIQmEqT7pD1j76mxgJL4jS2Mnhh3ie3LAEILy6572gMjkYVU1u2uuBoa/SR0B6/hj/B2CGVrpUaAJyOJHBFKD6wdNGKRDUX62bE9kCIebtGS6hNWRiIiVtVAW0p6Nc5t7lsaFQVaV1nQyrIWE1rALNc9giAlO8fzLt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrIW8pSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530F9C4CEEC;
	Wed,  2 Apr 2025 23:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743636068;
	bh=tZlWo93wGbEj8iC3H71eb10+hrSLcFB1nwvaPgD4lfo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OrIW8pSu9GLIxpY4nARjmZjtn3zgB/AhsPyU0Z4W7LwSgXn2AHVRoxASgVvpuMCTV
	 R6rf2AsSYFH5lcAZ+VxDj7rje2gScNAhuE0uiV3NfKxDaTbbOb9EKt17FO7zMX91gG
	 IFz9zKlFfZSf9sLbwOyeKwaZMcr+qYADO3cXJ07mludQ/G+kLrQhEennRvLWskMG94
	 NjwI6GLDExODPdY4oDtiWOTLtqNvx2Bl6RldE2gaCA+vJbd2QFc4hIz09VBrZekIYf
	 aiK9eMgkSCFNtGDPcSMqTweAjCelHuuqbfy9WJs7bRVg6R0wWUDE07VmjpjcE/3WfU
	 2HHDFqatOIRcQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Apr 2025 00:20:19 +0100
Subject: [PATCH 5.15 v2 04/10] arm64/fpsimd: Have KVM explicitly say which
 FP registers to save
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-stable-sve-5-15-v2-4-30a36a78a20a@kernel.org>
References: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
In-Reply-To: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8729; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tZlWo93wGbEj8iC3H71eb10+hrSLcFB1nwvaPgD4lfo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn7cZOYF2iqxLSukQqmw3CEXNCXiVnXyOMCfGA3byL
 Eo+A7hqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ+3GTgAKCRAk1otyXVSH0CwkB/
 wO0kfhmTPQuVU0kYRQrl5wdKvrWzG3BBzlRPcqcRZ5RcBDM7sLgQeujlwAwaRi2yUorkVJXyoC9LnU
 kTXiqV/TZv+IDsuKp/7IIAeZMaruYZSe2brADJE0e48t6FYpr56yOOHVyUgbitwOdi5/K8Upm8/Pkl
 jnByP+GO72Rs7RZXOGdGbwwNaZ02nsSzZlDu4GQTxmpKcweHG38A87GtP2VCgYKcJKub7ZRJD04zkp
 ZnL2F3thu9UR5UZ6IqWDGUXGchOEdefPa0W70O9SJrc1RmqPk3snEsEZ1btrKNvi1avdUFJajsP+45
 pyGKkqBzdMQtrPO8Cm9iuApXNro8wU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

[ Upstream commit deeb8f9a80fdae5a62525656d65c7070c28bd3a4 ]

In order to avoid needlessly saving and restoring the guest registers KVM
relies on the host FPSMID code to save the guest registers when we context
switch away from the guest. This is done by binding the KVM guest state to
the CPU on top of the task state that was originally there, then carefully
managing the TIF_SVE flag for the task to cause the host to save the full
SVE state when needed regardless of the needs of the host task. This works
well enough but isn't terribly direct about what is going on and makes it
much more complicated to try to optimise what we're doing with the SVE
register state.

Let's instead have KVM pass in the register state it wants saving when it
binds to the CPU. We introduce a new FP_STATE_CURRENT for use
during normal task binding to indicate that we should base our
decisions on the current task. This should not be used when
actually saving. Ideally we might want to use a separate enum for
the type to save but this enum and the enum values would then
need to be named which has problems with clarity and ambiguity.

In order to ease any future debugging that might be required this patch
does not actually update any of the decision making about what to save,
it merely starts tracking the new information and warns if the requested
state is not what we would otherwise have decided to save.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221115094640.112848-4-broonie@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
[ Mark: trivial backport ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h    |  2 +-
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/kernel/fpsimd.c         | 79 +++++++++++++++++++++++++++-----------
 arch/arm64/kvm/fpsimd.c            | 13 ++++++-
 4 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 9912bfd020be..7a407c3767b6 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -48,7 +48,7 @@ extern void fpsimd_kvm_prepare(void);
 
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 				     void *sve_state, unsigned int sve_vl,
-				     enum fp_type *type);
+				     enum fp_type *type, enum fp_type to_save);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_save_and_flush_cpu_state(void);
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index d5c11a994291..1da032444dac 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -116,6 +116,7 @@ struct debug_info {
 };
 
 enum fp_type {
+	FP_STATE_CURRENT,	/* Save based on current task state. */
 	FP_STATE_FPSIMD,
 	FP_STATE_SVE,
 };
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 4e702ff0d196..105b8aa0c038 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -118,6 +118,7 @@ struct fpsimd_last_state_struct {
 	void *sve_state;
 	unsigned int sve_vl;
 	enum fp_type *fp_type;
+	enum fp_type to_save;
 };
 
 static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
@@ -269,7 +270,8 @@ static void sve_free(struct task_struct *task)
  *    but userspace is discouraged from relying on this.
  *
  *    task->thread.sve_state does not need to be non-NULL, valid or any
- *    particular size: it must not be dereferenced.
+ *    particular size: it must not be dereferenced and any data stored
+ *    there should be considered stale and not referenced.
  *
  *  * SVE state - FP_STATE_SVE:
  *
@@ -282,7 +284,9 @@ static void sve_free(struct task_struct *task)
  *    task->thread.uw.fpsimd_state should be ignored.
  *
  *    task->thread.sve_state must point to a valid buffer at least
- *    sve_state_size(task) bytes in size.
+ *    sve_state_size(task) bytes in size. The data stored in
+ *    task->thread.uw.fpsimd_state.vregs should be considered stale
+ *    and not referenced.
  *
  *  * FPSR and FPCR are always stored in task->thread.uw.fpsimd_state
  *    irrespective of whether TIF_SVE is clear or set, since these are
@@ -321,32 +325,57 @@ static void fpsimd_save(void)
 	struct fpsimd_last_state_struct const *last =
 		this_cpu_ptr(&fpsimd_last_state);
 	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
+	bool save_sve_regs = false;
+	unsigned long vl;
 
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
-	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
-		if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-		    test_thread_flag(TIF_SVE)) {
-			if (WARN_ON(sve_get_vl() != last->sve_vl)) {
-				/*
-				 * Can't save the user regs, so current would
-				 * re-enter user with corrupt state.
-				 * There's no way to recover, so kill it:
-				 */
-				force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
-				return;
-			}
-
-			sve_save_state((char *)last->sve_state +
-						sve_ffr_offset(last->sve_vl),
-				       &last->st->fpsr);
-			*last->fp_type = FP_STATE_SVE;
-		} else {
-			fpsimd_save_state(last->st);
-			*last->fp_type = FP_STATE_FPSIMD;
+	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
+		return;
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
+	    test_thread_flag(TIF_SVE)) {
+		if (WARN_ON(sve_get_vl() != last->sve_vl)) {
+			/*
+			 * Can't save the user regs, so current would
+			 * re-enter user with corrupt state.
+			 * There's no way to recover, so kill it:
+			 */
+			force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
+			return;
 		}
 	}
+
+	if (test_thread_flag(TIF_SVE)) {
+		save_sve_regs = true;
+		vl = last->sve_vl;
+	}
+
+	/*
+	 * Validate that an explicitly specified state to save is
+	 * consistent with the task state.
+	 */
+	switch (last->to_save) {
+	case FP_STATE_CURRENT:
+		break;
+	case FP_STATE_FPSIMD:
+		WARN_ON_ONCE(save_sve_regs);
+		break;
+	case FP_STATE_SVE:
+		WARN_ON_ONCE(!save_sve_regs);
+		break;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && save_sve_regs) {
+		sve_save_state((char *)last->sve_state +
+			       sve_ffr_offset(last->sve_vl),
+			       &last->st->fpsr);
+		*last->fp_type = FP_STATE_SVE;
+	} else {
+		fpsimd_save_state(last->st);
+		*last->fp_type = FP_STATE_FPSIMD;
+	}
 }
 
 /*
@@ -987,6 +1016,7 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
 	} else {
 		fpsimd_to_sve(current);
 		fpsimd_flush_task_state(current);
+		current->thread.fp_type = FP_STATE_SVE;
 	}
 
 	put_cpu_fpsimd_context();
@@ -1172,6 +1202,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->sve_state = current->thread.sve_state;
 	last->sve_vl = current->thread.sve_vl;
 	last->fp_type = &current->thread.fp_type;
+	last->to_save = FP_STATE_CURRENT;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
 	if (system_supports_sve()) {
@@ -1186,7 +1217,8 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl, enum fp_type *type)
+			      unsigned int sve_vl, enum fp_type *type,
+			      enum fp_type to_save)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1198,6 +1230,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 	last->sve_state = sve_state;
 	last->sve_vl = sve_vl;
 	last->fp_type = type;
+	last->to_save = to_save;
 }
 
 /*
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index f1aaad9e14bc..54a31c97eb7a 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -90,13 +90,24 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
  */
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 {
+	enum fp_type fp_type;
+
 	WARN_ON_ONCE(!irqs_disabled());
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
+		if (vcpu_has_sve(vcpu))
+			fp_type = FP_STATE_SVE;
+		else
+			fp_type = FP_STATE_FPSIMD;
+
+		/*
+		 * Currently we do not support SME guests so SVCR is
+		 * always 0 and we just need a variable to point to.
+		 */
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.fp_regs,
 					 vcpu->arch.sve_state,
 					 vcpu->arch.sve_max_vl,
-					 &vcpu->arch.fp_type);
+					 &vcpu->arch.fp_type, fp_type);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));

-- 
2.39.5


