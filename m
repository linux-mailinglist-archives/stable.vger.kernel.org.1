Return-Path: <stable+bounces-136291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED77A9930E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0389A35D1
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F41289368;
	Wed, 23 Apr 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wnjyx9hJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE942820B1;
	Wed, 23 Apr 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422159; cv=none; b=tCK5nfyWsyqXngnXaMn9luBetoQLEUqePP92pcSzBt5z4qMBCpayo519Z+/oVHZ0Z5p8+njNpGGCQAdPanhObkjKRIIMF7y5IKzJZNTa7CsnugNwNw9I1dcLw6m5ZblDSm/pR8A07Kn2I+Iihug1qp83xjt52rbSixTIsCMrchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422159; c=relaxed/simple;
	bh=9GQSUQ3hj8EI0uW8xEL3wfzdkSSqYqf8XtzK7U/ulfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1s6iBHBs7gWaBzjWYOu+0svTj+rYSNEb7qtvfWADYHQwB4bGwfJiqEgODcdhuth83H/hlSnGBHxZCdMqQqIE4mGkEirv2mEtmkwIaZnX+bICzEAjxYQwGRqGIx7aO1hu5V6wxoo+P83bcFIS2JSaPbk4i788LM578+7JjmG+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wnjyx9hJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56312C4CEE2;
	Wed, 23 Apr 2025 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422159;
	bh=9GQSUQ3hj8EI0uW8xEL3wfzdkSSqYqf8XtzK7U/ulfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wnjyx9hJczoN5nTabqJFBxZTP29xh3mAhipRn6JMx4lzchC3XKG24vhVH+j0oGwU2
	 QRtCy6CeKWxuhm5pdVGLR0O4pdXEwxb9AiQu0qzUHM9RkImGmdWuIZ1vSWYvVe4Jh9
	 7+nHJ8z+WvXMXwFemJPUbiDVLjf6xKgtYrlYHo04=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 6.1 247/291] arm64/fpsimd: Have KVM explicitly say which FP registers to save
Date: Wed, 23 Apr 2025 16:43:56 +0200
Message-ID: <20250423142634.510173822@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/fpsimd.h    |    3 ++-
 arch/arm64/include/asm/processor.h |    1 +
 arch/arm64/kernel/fpsimd.c         |   27 ++++++++++++++++++++++++---
 arch/arm64/kvm/fpsimd.c            |    9 ++++++++-
 4 files changed, 35 insertions(+), 5 deletions(-)

--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -61,7 +61,8 @@ extern void fpsimd_kvm_prepare(void);
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 				     void *sve_state, unsigned int sve_vl,
 				     void *za_state, unsigned int sme_vl,
-				     u64 *svcr, enum fp_type *type);
+				     u64 *svcr, enum fp_type *type,
+				     enum fp_type to_save);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_save_and_flush_cpu_state(void);
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -123,6 +123,7 @@ enum vec_type {
 };
 
 enum fp_type {
+	FP_STATE_CURRENT,	/* Save based on current task state. */
 	FP_STATE_FPSIMD,
 	FP_STATE_SVE,
 };
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -126,6 +126,7 @@ struct fpsimd_last_state_struct {
 	unsigned int sve_vl;
 	unsigned int sme_vl;
 	enum fp_type *fp_type;
+	enum fp_type to_save;
 };
 
 static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
@@ -356,7 +357,8 @@ void task_set_vl_onexec(struct task_stru
  *    but userspace is discouraged from relying on this.
  *
  *    task->thread.sve_state does not need to be non-NULL, valid or any
- *    particular size: it must not be dereferenced.
+ *    particular size: it must not be dereferenced and any data stored
+ *    there should be considered stale and not referenced.
  *
  *  * SVE state - FP_STATE_SVE:
  *
@@ -369,7 +371,9 @@ void task_set_vl_onexec(struct task_stru
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
@@ -459,6 +463,21 @@ static void fpsimd_save(void)
 		vl = last->sve_vl;
 	}
 
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
 	if (system_supports_sme()) {
 		u64 *svcr = last->svcr;
 
@@ -1709,6 +1728,7 @@ static void fpsimd_bind_task_to_cpu(void
 	last->sme_vl = task_get_sme_vl(current);
 	last->svcr = &current->thread.svcr;
 	last->fp_type = &current->thread.fp_type;
+	last->to_save = FP_STATE_CURRENT;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
 	/*
@@ -1733,7 +1753,7 @@ static void fpsimd_bind_task_to_cpu(void
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 			      unsigned int sve_vl, void *za_state,
 			      unsigned int sme_vl, u64 *svcr,
-			      enum fp_type *type)
+			      enum fp_type *type, enum fp_type to_save)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1748,6 +1768,7 @@ void fpsimd_bind_state_to_cpu(struct use
 	last->sve_vl = sve_vl;
 	last->sme_vl = sme_vl;
 	last->fp_type = type;
+	last->to_save = to_save;
 }
 
 /*
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -130,9 +130,16 @@ void kvm_arch_vcpu_ctxflush_fp(struct kv
  */
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 {
+	enum fp_type fp_type;
+
 	WARN_ON_ONCE(!irqs_disabled());
 
 	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED) {
+		if (vcpu_has_sve(vcpu))
+			fp_type = FP_STATE_SVE;
+		else
+			fp_type = FP_STATE_FPSIMD;
+
 		/*
 		 * Currently we do not support SME guests so SVCR is
 		 * always 0 and we just need a variable to point to.
@@ -141,7 +148,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm
 					 vcpu->arch.sve_state,
 					 vcpu->arch.sve_max_vl,
 					 NULL, 0, &vcpu->arch.svcr,
-					 &vcpu->arch.fp_type);
+					 &vcpu->arch.fp_type, fp_type);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));



