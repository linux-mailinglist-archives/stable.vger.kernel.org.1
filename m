Return-Path: <stable+bounces-131829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473DAA8148E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D804651CF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3E024CEE2;
	Tue,  8 Apr 2025 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bkn4lpVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF8245016;
	Tue,  8 Apr 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136549; cv=none; b=petjHmj26hbbBcrnYLKlShtBpIxZl0QcNQxp5Fl4971kojfNUzTALQ4QrT6fL8nFs4EC0L8K9CDGSHVCYZ0oNG32R2zf2q5qISR29DH9tCzAeKh67/EkiSKEKz5CQeGJzXy6RhbGLGTmwOrnEQszhoUsb/xESFR8RILaA38/uxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136549; c=relaxed/simple;
	bh=S2ZI/vNeQK0jD3CUdjsvBZSRNxhtI9CvKwBhMfYkT/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j0fYOY8oB/tSsLHKpqEsvlLjpqkKt4BS6q/5RUny3JsODmOMsBX/L9hBUKNwhOSuUbFuzM3h2TvoRcfXG0QSphHl+TRbncJ76v03USat14b/l8Z/gbPGC5H8B3hI6ILDJsVCulJHNHSNisp5k11x7R9+pQPzE0Fjkyx3yFFc8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkn4lpVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E87C4CEE8;
	Tue,  8 Apr 2025 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744136549;
	bh=S2ZI/vNeQK0jD3CUdjsvBZSRNxhtI9CvKwBhMfYkT/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bkn4lpViaF8ECmsLv6VEuufq+Vje1V2hJaoxeifVo4Gr9zlWPvsG8qLvGJEZZeKtW
	 9a9pkNm6XUkfQeoiABCgOR3WJiZ+/jbbGW5K6DUkgHLZxtb9QT7huHBrk66K0ZUoJ5
	 fb2/jE7AoECs+4060Fy178Rfom9T2PylXLVt7B6xQ5F5LUXZgofsPVoJM8RtW1riti
	 Jki01zH+gCWR0gO/NwS/6ZvWIsRR2fawgqezAzwlZ0vPFRLiKkaj8WEJ3pUL1twFUt
	 lYSTA13QQnVuS+IpK5dLXXDQIsQzwvMzQRylNYJJ1nqEMbLi5qz7ON1o+DOP/iZiBK
	 zHOjPzPTuPdNw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 08 Apr 2025 19:09:59 +0100
Subject: [PATCH 5.15 v3 04/11] arm64/fpsimd: Track the saved FPSIMD state
 type separately to TIF_SVE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-stable-sve-5-15-v3-4-ca9a6b850f55@kernel.org>
References: <20250408-stable-sve-5-15-v3-0-ca9a6b850f55@kernel.org>
In-Reply-To: <20250408-stable-sve-5-15-v3-0-ca9a6b850f55@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=12553; i=broonie@kernel.org;
 h=from:subject:message-id; bh=S2ZI/vNeQK0jD3CUdjsvBZSRNxhtI9CvKwBhMfYkT/U=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhvSvmX68a4/lfTWNOK2z6MIR9VYJ1UoX2y+fPNsv6irP49Xa
 K+PZyWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBM5NFL9v+RCn0LD75/qiz1OZVf/c
 rstyuKYnd7KO7PP+95JWHX/cBLChofww3eng3y+1fVGcaQvHyLX7Ji34VMnVaDm2zsCipiEjoPfHiy
 g9at9+w3XMwSejq4bumqxHv6Wz02el2P+yFhsG/ahK6fkY2N5xlm2XeeCPbVL7O3FGEy8EowWV7Q+I
 4zp7v0Zy9DKtf99/L9sfzdb+TiFhr4exjY7c6xsb57/+GlGTkmD47UMloIXrLK2L+fhUk5/M7+zQ76
 W26rK1V96wjQM77lVL+i1Cayvm6TxC63Vc/NhbYe5W39knYi+aatovMpLj6mvOBu+Q0dem5L1FYHxf
 gZ3VeI6Tbew1/s5JK0K/qD8jMA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

[ Upstream commit baa8515281b30861cff3da7db70662d2a25c6440 ]

When we save the state for the floating point registers this can be done
in the form visible through either the FPSIMD V registers or the SVE Z and
P registers. At present we track which format is currently used based on
TIF_SVE and the SME streaming mode state but particularly in the SVE case
this limits our options for optimising things, especially around syscalls.
Introduce a new enum which we place together with saved floating point
state in both thread_struct and the KVM guest state which explicitly
states which format is active and keep it up to date when we change it.

At present we do not use this state except to verify that it has the
expected value when loading the state, future patches will introduce
functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221115094640.112848-3-broonie@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
[ Mark: fix conflicts due to earlier backports ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h    |  3 +-
 arch/arm64/include/asm/kvm_host.h  | 12 ++++++++
 arch/arm64/include/asm/processor.h |  6 ++++
 arch/arm64/kernel/fpsimd.c         | 58 ++++++++++++++++++++++++++++----------
 arch/arm64/kernel/process.c        |  3 ++
 arch/arm64/kernel/ptrace.c         |  3 ++
 arch/arm64/kernel/signal.c         |  3 ++
 arch/arm64/kvm/fpsimd.c            |  3 +-
 8 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index f7faf0f4507c..9912bfd020be 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -47,7 +47,8 @@ extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 extern void fpsimd_kvm_prepare(void);
 
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
-				     void *sve_state, unsigned int sve_vl);
+				     void *sve_state, unsigned int sve_vl,
+				     enum fp_type *type);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_save_and_flush_cpu_state(void);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4e84d75ae91c..ecae31b0dab3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -280,7 +280,19 @@ struct vcpu_reset_state {
 
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
+
+	/*
+	 * Guest floating point state
+	 *
+	 * The architecture has two main floating point extensions,
+	 * the original FPSIMD and SVE.  These have overlapping
+	 * register views, with the FPSIMD V registers occupying the
+	 * low 128 bits of the SVE Z registers.  When the core
+	 * floating point code saves the register state of a task it
+	 * records which view it saved in fp_type.
+	 */
 	void *sve_state;
+	enum fp_type fp_type;
 	unsigned int sve_max_vl;
 
 	/* Stage 2 paging state used by the hardware on next switch */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 7364530de0a7..d5c11a994291 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -115,6 +115,11 @@ struct debug_info {
 #endif
 };
 
+enum fp_type {
+	FP_STATE_FPSIMD,
+	FP_STATE_SVE,
+};
+
 struct cpu_context {
 	unsigned long x19;
 	unsigned long x20;
@@ -145,6 +150,7 @@ struct thread_struct {
 		struct user_fpsimd_state fpsimd_state;
 	} uw;
 
+	enum fp_type		fp_type;	/* registers FPSIMD or SVE? */
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
 	unsigned int		sve_vl;		/* SVE vector length */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 57e89361edcb..4e702ff0d196 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -117,6 +117,7 @@ struct fpsimd_last_state_struct {
 	struct user_fpsimd_state *st;
 	void *sve_state;
 	unsigned int sve_vl;
+	enum fp_type *fp_type;
 };
 
 static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
@@ -243,14 +244,6 @@ static void sve_free(struct task_struct *task)
  *    The task can execute SVE instructions while in userspace without
  *    trapping to the kernel.
  *
- *    When stored, Z0-Z31 (incorporating Vn in bits[127:0] or the
- *    corresponding Zn), P0-P15 and FFR are encoded in in
- *    task->thread.sve_state, formatted appropriately for vector
- *    length task->thread.sve_vl.
- *
- *    task->thread.sve_state must point to a valid buffer at least
- *    sve_state_size(task) bytes in size.
- *
  *    During any syscall, the kernel may optionally clear TIF_SVE and
  *    discard the vector state except for the FPSIMD subset.
  *
@@ -260,7 +253,15 @@ static void sve_free(struct task_struct *task)
  *    do_sve_acc() to be called, which does some preparation and then
  *    sets TIF_SVE.
  *
- *    When stored, FPSIMD registers V0-V31 are encoded in
+ * During any syscall, the kernel may optionally clear TIF_SVE and
+ * discard the vector state except for the FPSIMD subset.
+ *
+ * The data will be stored in one of two formats:
+ *
+ *  * FPSIMD only - FP_STATE_FPSIMD:
+ *
+ *    When the FPSIMD only state stored task->thread.fp_type is set to
+ *    FP_STATE_FPSIMD, the FPSIMD registers V0-V31 are encoded in
  *    task->thread.uw.fpsimd_state; bits [max : 128] for each of Z0-Z31 are
  *    logically zero but not stored anywhere; P0-P15 and FFR are not
  *    stored and have unspecified values from userspace's point of
@@ -270,6 +271,19 @@ static void sve_free(struct task_struct *task)
  *    task->thread.sve_state does not need to be non-NULL, valid or any
  *    particular size: it must not be dereferenced.
  *
+ *  * SVE state - FP_STATE_SVE:
+ *
+ *    When the full SVE state is stored task->thread.fp_type is set to
+ *    FP_STATE_SVE and Z0-Z31 (incorporating Vn in bits[127:0] or the
+ *    corresponding Zn), P0-P15 and FFR are encoded in in
+ *    task->thread.sve_state, formatted appropriately for vector
+ *    length task->thread.sve_vl or, if SVCR.SM is set,
+ *    task->thread.sme_vl. The storage for the vector registers in
+ *    task->thread.uw.fpsimd_state should be ignored.
+ *
+ *    task->thread.sve_state must point to a valid buffer at least
+ *    sve_state_size(task) bytes in size.
+ *
  *  * FPSR and FPCR are always stored in task->thread.uw.fpsimd_state
  *    irrespective of whether TIF_SVE is clear or set, since these are
  *    not vector length dependent.
@@ -287,12 +301,15 @@ static void task_fpsimd_load(void)
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE))
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
+		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_SVE);
 		sve_load_state(sve_pffr(&current->thread),
 			       &current->thread.uw.fpsimd_state.fpsr,
 			       sve_vq_from_vl(current->thread.sve_vl) - 1);
-	else
+	} else {
+		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_FPSIMD);
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
+	}
 }
 
 /*
@@ -324,8 +341,11 @@ static void fpsimd_save(void)
 			sve_save_state((char *)last->sve_state +
 						sve_ffr_offset(last->sve_vl),
 				       &last->st->fpsr);
-		} else
+			*last->fp_type = FP_STATE_SVE;
+		} else {
 			fpsimd_save_state(last->st);
+			*last->fp_type = FP_STATE_FPSIMD;
+		}
 	}
 }
 
@@ -624,8 +644,10 @@ int sve_set_vector_length(struct task_struct *task,
 	}
 
 	fpsimd_flush_task_state(task);
-	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
+	if (test_and_clear_tsk_thread_flag(task, TIF_SVE)) {
 		sve_to_fpsimd(task);
+		task->thread.fp_type = FP_STATE_FPSIMD;
+	}
 
 	if (task == current)
 		put_cpu_fpsimd_context();
@@ -1079,6 +1101,8 @@ void fpsimd_flush_thread(void)
 			current->thread.sve_vl_onexec = 0;
 	}
 
+	current->thread.fp_type = FP_STATE_FPSIMD;
+
 	put_cpu_fpsimd_context();
 }
 
@@ -1125,8 +1149,10 @@ void fpsimd_kvm_prepare(void)
 	 */
 	get_cpu_fpsimd_context();
 
-	if (test_and_clear_thread_flag(TIF_SVE))
+	if (test_and_clear_thread_flag(TIF_SVE)) {
 		sve_to_fpsimd(current);
+		current->thread.fp_type = FP_STATE_FPSIMD;
+	}
 
 	put_cpu_fpsimd_context();
 }
@@ -1145,6 +1171,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
 	last->sve_vl = current->thread.sve_vl;
+	last->fp_type = &current->thread.fp_type;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
 	if (system_supports_sve()) {
@@ -1159,7 +1186,7 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl)
+			      unsigned int sve_vl, enum fp_type *type)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1170,6 +1197,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 	last->st = st;
 	last->sve_state = sve_state;
 	last->sve_vl = sve_vl;
+	last->fp_type = type;
 }
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 839edc4ed7a4..a01f2288ee9a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -307,6 +307,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.sve_state = NULL;
 	clear_tsk_thread_flag(dst, TIF_SVE);
 
+
+	dst->thread.fp_type = FP_STATE_FPSIMD;
+
 	/* clear any pending asynchronous tag fault raised by the parent */
 	clear_tsk_thread_flag(dst, TIF_MTE_ASYNC_FAULT);
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 92de9212b7b5..4ef9e688508c 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -829,6 +829,7 @@ static int sve_set(struct task_struct *target,
 		ret = __fpr_set(target, regset, pos, count, kbuf, ubuf,
 				SVE_PT_FPSIMD_OFFSET);
 		clear_tsk_thread_flag(target, TIF_SVE);
+		target->thread.fp_type = FP_STATE_FPSIMD;
 		goto out;
 	}
 
@@ -848,6 +849,7 @@ static int sve_set(struct task_struct *target,
 	if (!target->thread.sve_state) {
 		ret = -ENOMEM;
 		clear_tsk_thread_flag(target, TIF_SVE);
+		target->thread.fp_type = FP_STATE_FPSIMD;
 		goto out;
 	}
 
@@ -858,6 +860,7 @@ static int sve_set(struct task_struct *target,
 	 */
 	fpsimd_sync_to_sve(target);
 	set_tsk_thread_flag(target, TIF_SVE);
+	target->thread.fp_type = FP_STATE_SVE;
 
 	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
 	start = SVE_PT_SVE_OFFSET;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index b3e1beccf458..768de05b616b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -207,6 +207,7 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	__get_user_error(fpsimd.fpcr, &ctx->fpcr, err);
 
 	clear_thread_flag(TIF_SVE);
+	current->thread.fp_type = FP_STATE_FPSIMD;
 
 	/* load the hardware registers from the fpsimd_state structure */
 	if (!err)
@@ -271,6 +272,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 
 	if (sve.head.size <= sizeof(*user->sve)) {
 		clear_thread_flag(TIF_SVE);
+		current->thread.fp_type = FP_STATE_FPSIMD;
 		goto fpsimd_only;
 	}
 
@@ -303,6 +305,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 		return -EFAULT;
 
 	set_thread_flag(TIF_SVE);
+	current->thread.fp_type = FP_STATE_SVE;
 
 fpsimd_only:
 	/* copy the FP and status/control registers */
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 16e29f03dcbf..f1aaad9e14bc 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -95,7 +95,8 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.fp_regs,
 					 vcpu->arch.sve_state,
-					 vcpu->arch.sve_max_vl);
+					 vcpu->arch.sve_max_vl,
+					 &vcpu->arch.fp_type);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));

-- 
2.39.5


