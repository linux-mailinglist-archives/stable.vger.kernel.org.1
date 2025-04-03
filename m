Return-Path: <stable+bounces-127683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F02A7A719
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B39176AEC
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629EE24CEE5;
	Thu,  3 Apr 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ2pMVdK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FEF2417C4
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694718; cv=none; b=StGP+VLFjjO7tmXmQwV62TaD4D72sVV/C56FUN7BWzIiHs1ahX+tsLQCUtRMv/uRwxsO5+xMKy1UtXKtmsJ5VuumK+Ln5/563rTYaUIUBjJYI+IQbvHkSo3fP7e2n73AAlprr4jOHnjhmfPmNZvPYLVrsSdJKiAM7Zsh314EEHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694718; c=relaxed/simple;
	bh=8xX5pOwIhews4r/h5d5+/Ky9JeJ0fxzWpFHfGV5oGnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0fIRBCY6ugSdg1yR3e8D0aOxYxMJq6XXon3+uxSKkWmnpA+YBZ+9hwNhkgJ71REBa9JWMRpQjrt8RSrqk09/71LQVcYMhTvPbI05WJNXebXQl66yJYFkNSiHwsxSfM6A6fzISDjEGj5HXKiq/hkCamXS7jDGStTGLV3ygj3mDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ2pMVdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82228C4CEE3;
	Thu,  3 Apr 2025 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694718;
	bh=8xX5pOwIhews4r/h5d5+/Ky9JeJ0fxzWpFHfGV5oGnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJ2pMVdKt8EkfrTppN9F1EVNWrz1+Hor9DGIA8oXQoTzDKzaJPG7Evxhh9ZKknwBd
	 xFuWdVEJyKbMROQsokxr/HrR/7WiuFbPHf00viJzUqr5GXRvpzh0kTlUE4oVp3CNtN
	 wVRQQTOUFXxUfShIhKI/sbdH2SuNirJsI9KFCPY+kjdXU5xTcE+Hm0GDIIJ47CUJUe
	 n6hUcmfxeM+lhrxnVlXEL+o1nBkjyaLNnotMQjTHIFKo2KAUfvZevcG0EmrmDFlUYr
	 7EwMKUgq+scDBFuhktPCTRAcPRw7i20mjNx3Xeihx491agi7kqtAPrWzRRwGFo07sO
	 BfmCfZJRsIY+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 03/10] arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE
Date: Thu,  3 Apr 2025 11:38:35 -0400
Message-Id: <20250403095427-6690dadd0b0b61dc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403-stable-sve-5-15-v2-3-30a36a78a20a@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: baa8515281b30861cff3da7db70662d2a25c6440

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  baa8515281b30 ! 1:  e5d18d62553b8 arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE
    @@ Metadata
      ## Commit message ##
         arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE
     
    +    [ Upstream commit baa8515281b30861cff3da7db70662d2a25c6440 ]
    +
         When we save the state for the floating point registers this can be done
         in the form visible through either the FPSIMD V registers or the SVE Z and
         P registers. At present we track which format is currently used based on
    @@ Commit message
         Reviewed-by: Marc Zyngier <maz@kernel.org>
         Link: https://lore.kernel.org/r/20221115094640.112848-3-broonie@kernel.org
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [ Mark: fix conflicts due to earlier backports ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/fpsimd.h ##
    -@@ arch/arm64/include/asm/fpsimd.h: extern void fpsimd_kvm_prepare(void);
    +@@ arch/arm64/include/asm/fpsimd.h: extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
    + extern void fpsimd_kvm_prepare(void);
    + 
      extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
    - 				     void *sve_state, unsigned int sve_vl,
    - 				     void *za_state, unsigned int sme_vl,
    --				     u64 *svcr);
    -+				     u64 *svcr, enum fp_type *type);
    +-				     void *sve_state, unsigned int sve_vl);
    ++				     void *sve_state, unsigned int sve_vl,
    ++				     enum fp_type *type);
      
      extern void fpsimd_flush_task_state(struct task_struct *target);
      extern void fpsimd_save_and_flush_cpu_state(void);
     
      ## arch/arm64/include/asm/kvm_host.h ##
     @@ arch/arm64/include/asm/kvm_host.h: struct vcpu_reset_state {
    + 
      struct kvm_vcpu_arch {
      	struct kvm_cpu_context ctxt;
    - 
    --	/* Guest floating point state */
    ++
     +	/*
     +	 * Guest floating point state
     +	 *
    @@ arch/arm64/include/asm/kvm_host.h: struct vcpu_reset_state {
      	void *sve_state;
     +	enum fp_type fp_type;
      	unsigned int sve_max_vl;
    - 	u64 svcr;
      
    + 	/* Stage 2 paging state used by the hardware on next switch */
     
      ## arch/arm64/include/asm/processor.h ##
    -@@ arch/arm64/include/asm/processor.h: enum vec_type {
    - 	ARM64_VEC_MAX,
    +@@ arch/arm64/include/asm/processor.h: struct debug_info {
    + #endif
      };
      
     +enum fp_type {
    @@ arch/arm64/include/asm/processor.h: struct thread_struct {
     +	enum fp_type		fp_type;	/* registers FPSIMD or SVE? */
      	unsigned int		fpsimd_cpu;
      	void			*sve_state;	/* SVE registers, if any */
    - 	void			*za_state;	/* ZA register, if any */
    + 	unsigned int		sve_vl;		/* SVE vector length */
     
      ## arch/arm64/kernel/fpsimd.c ##
     @@ arch/arm64/kernel/fpsimd.c: struct fpsimd_last_state_struct {
    - 	u64 *svcr;
    + 	struct user_fpsimd_state *st;
    + 	void *sve_state;
      	unsigned int sve_vl;
    - 	unsigned int sme_vl;
     +	enum fp_type *fp_type;
      };
      
      static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
    -@@ arch/arm64/kernel/fpsimd.c: void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
    +@@ arch/arm64/kernel/fpsimd.c: static void sve_free(struct task_struct *task)
       *    The task can execute SVE instructions while in userspace without
       *    trapping to the kernel.
       *
     - *    When stored, Z0-Z31 (incorporating Vn in bits[127:0] or the
    -- *    corresponding Zn), P0-P15 and FFR are encoded in
    +- *    corresponding Zn), P0-P15 and FFR are encoded in in
     - *    task->thread.sve_state, formatted appropriately for vector
    -- *    length task->thread.sve_vl or, if SVCR.SM is set,
    -- *    task->thread.sme_vl.
    +- *    length task->thread.sve_vl.
     - *
     - *    task->thread.sve_state must point to a valid buffer at least
     - *    sve_state_size(task) bytes in size.
    @@ arch/arm64/kernel/fpsimd.c: void task_set_vl_onexec(struct task_struct *task, en
       *    During any syscall, the kernel may optionally clear TIF_SVE and
       *    discard the vector state except for the FPSIMD subset.
       *
    -@@ arch/arm64/kernel/fpsimd.c: void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
    +@@ arch/arm64/kernel/fpsimd.c: static void sve_free(struct task_struct *task)
       *    do_sve_acc() to be called, which does some preparation and then
       *    sets TIF_SVE.
       *
    @@ arch/arm64/kernel/fpsimd.c: void task_set_vl_onexec(struct task_struct *task, en
       *    task->thread.uw.fpsimd_state; bits [max : 128] for each of Z0-Z31 are
       *    logically zero but not stored anywhere; P0-P15 and FFR are not
       *    stored and have unspecified values from userspace's point of
    -@@ arch/arm64/kernel/fpsimd.c: void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
    +@@ arch/arm64/kernel/fpsimd.c: static void sve_free(struct task_struct *task)
       *    task->thread.sve_state does not need to be non-NULL, valid or any
       *    particular size: it must not be dereferenced.
       *
    @@ arch/arm64/kernel/fpsimd.c: void task_set_vl_onexec(struct task_struct *task, en
       *    irrespective of whether TIF_SVE is clear or set, since these are
       *    not vector length dependent.
     @@ arch/arm64/kernel/fpsimd.c: static void task_fpsimd_load(void)
    - 		}
    - 	}
    + 	WARN_ON(!system_supports_fpsimd());
    + 	WARN_ON(!have_cpu_fpsimd_context());
      
    --	if (restore_sve_regs)
    -+	if (restore_sve_regs) {
    +-	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE))
    ++	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
     +		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_SVE);
      		sve_load_state(sve_pffr(&current->thread),
      			       &current->thread.uw.fpsimd_state.fpsr,
    - 			       restore_ffr);
    + 			       sve_vq_from_vl(current->thread.sve_vl) - 1);
     -	else
     +	} else {
     +		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_FPSIMD);
    @@ arch/arm64/kernel/fpsimd.c: static void task_fpsimd_load(void)
      
      /*
     @@ arch/arm64/kernel/fpsimd.c: static void fpsimd_save(void)
    - 		sve_save_state((char *)last->sve_state +
    - 					sve_ffr_offset(vl),
    - 			       &last->st->fpsr, save_ffr);
    -+		*last->fp_type = FP_STATE_SVE;
    - 	} else {
    - 		fpsimd_save_state(last->st);
    -+		*last->fp_type = FP_STATE_FPSIMD;
    + 			sve_save_state((char *)last->sve_state +
    + 						sve_ffr_offset(last->sve_vl),
    + 				       &last->st->fpsr);
    +-		} else
    ++			*last->fp_type = FP_STATE_SVE;
    ++		} else {
    + 			fpsimd_save_state(last->st);
    ++			*last->fp_type = FP_STATE_FPSIMD;
    ++		}
      	}
      }
      
    -@@ arch/arm64/kernel/fpsimd.c: int vec_set_vector_length(struct task_struct *task, enum vec_type type,
    +@@ arch/arm64/kernel/fpsimd.c: int sve_set_vector_length(struct task_struct *task,
    + 	}
      
      	fpsimd_flush_task_state(task);
    - 	if (test_and_clear_tsk_thread_flag(task, TIF_SVE) ||
    --	    thread_sm_enabled(&task->thread))
    -+	    thread_sm_enabled(&task->thread)) {
    +-	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
    ++	if (test_and_clear_tsk_thread_flag(task, TIF_SVE)) {
      		sve_to_fpsimd(task);
     +		task->thread.fp_type = FP_STATE_FPSIMD;
     +	}
      
    - 	if (system_supports_sme() && type == ARM64_VEC_SME) {
    - 		task->thread.svcr &= ~(SVCR_SM_MASK |
    -@@ arch/arm64/kernel/fpsimd.c: static void sve_init_regs(void)
    - 		fpsimd_bind_task_to_cpu();
    - 	} else {
    - 		fpsimd_to_sve(current);
    -+		current->thread.fp_type = FP_STATE_SVE;
    - 	}
    - }
    - 
    + 	if (task == current)
    + 		put_cpu_fpsimd_context();
     @@ arch/arm64/kernel/fpsimd.c: void fpsimd_flush_thread(void)
    - 		current->thread.svcr = 0;
    + 			current->thread.sve_vl_onexec = 0;
      	}
      
     +	current->thread.fp_type = FP_STATE_FPSIMD;
     +
      	put_cpu_fpsimd_context();
    - 	kfree(sve_state);
    - 	kfree(za_state);
    + }
    + 
     @@ arch/arm64/kernel/fpsimd.c: void fpsimd_kvm_prepare(void)
      	 */
      	get_cpu_fpsimd_context();
    @@ arch/arm64/kernel/fpsimd.c: void fpsimd_kvm_prepare(void)
      	put_cpu_fpsimd_context();
      }
     @@ arch/arm64/kernel/fpsimd.c: static void fpsimd_bind_task_to_cpu(void)
    - 	last->sve_vl = task_get_sve_vl(current);
    - 	last->sme_vl = task_get_sme_vl(current);
    - 	last->svcr = &current->thread.svcr;
    + 	last->st = &current->thread.uw.fpsimd_state;
    + 	last->sve_state = current->thread.sve_state;
    + 	last->sve_vl = current->thread.sve_vl;
     +	last->fp_type = &current->thread.fp_type;
      	current->thread.fpsimd_cpu = smp_processor_id();
      
    - 	/*
    + 	if (system_supports_sve()) {
     @@ arch/arm64/kernel/fpsimd.c: static void fpsimd_bind_task_to_cpu(void)
    + }
      
      void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
    - 			      unsigned int sve_vl, void *za_state,
    --			      unsigned int sme_vl, u64 *svcr)
    -+			      unsigned int sme_vl, u64 *svcr,
    -+			      enum fp_type *type)
    +-			      unsigned int sve_vl)
    ++			      unsigned int sve_vl, enum fp_type *type)
      {
      	struct fpsimd_last_state_struct *last =
      		this_cpu_ptr(&fpsimd_last_state);
     @@ arch/arm64/kernel/fpsimd.c: void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
    - 	last->za_state = za_state;
    + 	last->st = st;
    + 	last->sve_state = sve_state;
      	last->sve_vl = sve_vl;
    - 	last->sme_vl = sme_vl;
     +	last->fp_type = type;
      }
      
    @@ arch/arm64/kernel/fpsimd.c: void fpsimd_bind_state_to_cpu(struct user_fpsimd_sta
     
      ## arch/arm64/kernel/process.c ##
     @@ arch/arm64/kernel/process.c: int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
    - 		clear_tsk_thread_flag(dst, TIF_SME);
    - 	}
    + 	dst->thread.sve_state = NULL;
    + 	clear_tsk_thread_flag(dst, TIF_SVE);
      
    ++
     +	dst->thread.fp_type = FP_STATE_FPSIMD;
     +
      	/* clear any pending asynchronous tag fault raised by the parent */
    @@ arch/arm64/kernel/process.c: int arch_dup_task_struct(struct task_struct *dst, s
      
     
      ## arch/arm64/kernel/ptrace.c ##
    -@@ arch/arm64/kernel/ptrace.c: static int sve_set_common(struct task_struct *target,
    +@@ arch/arm64/kernel/ptrace.c: static int sve_set(struct task_struct *target,
    + 		ret = __fpr_set(target, regset, pos, count, kbuf, ubuf,
    + 				SVE_PT_FPSIMD_OFFSET);
      		clear_tsk_thread_flag(target, TIF_SVE);
    - 		if (type == ARM64_VEC_SME)
    - 			fpsimd_force_sync_to_sve(target);
     +		target->thread.fp_type = FP_STATE_FPSIMD;
      		goto out;
      	}
      
    -@@ arch/arm64/kernel/ptrace.c: static int sve_set_common(struct task_struct *target,
    +@@ arch/arm64/kernel/ptrace.c: static int sve_set(struct task_struct *target,
      	if (!target->thread.sve_state) {
      		ret = -ENOMEM;
      		clear_tsk_thread_flag(target, TIF_SVE);
    @@ arch/arm64/kernel/ptrace.c: static int sve_set_common(struct task_struct *target
      		goto out;
      	}
      
    -@@ arch/arm64/kernel/ptrace.c: static int sve_set_common(struct task_struct *target,
    +@@ arch/arm64/kernel/ptrace.c: static int sve_set(struct task_struct *target,
      	 */
      	fpsimd_sync_to_sve(target);
      	set_tsk_thread_flag(target, TIF_SVE);
    @@ arch/arm64/kernel/signal.c: static int restore_fpsimd_context(struct fpsimd_cont
      	/* load the hardware registers from the fpsimd_state structure */
      	if (!err)
     @@ arch/arm64/kernel/signal.c: static int restore_sve_fpsimd_context(struct user_ctxs *user)
    + 
      	if (sve.head.size <= sizeof(*user->sve)) {
      		clear_thread_flag(TIF_SVE);
    - 		current->thread.svcr &= ~SVCR_SM_MASK;
     +		current->thread.fp_type = FP_STATE_FPSIMD;
      		goto fpsimd_only;
      	}
      
     @@ arch/arm64/kernel/signal.c: static int restore_sve_fpsimd_context(struct user_ctxs *user)
    - 		current->thread.svcr |= SVCR_SM_MASK;
    - 	else
    - 		set_thread_flag(TIF_SVE);
    + 		return -EFAULT;
    + 
    + 	set_thread_flag(TIF_SVE);
     +	current->thread.fp_type = FP_STATE_SVE;
      
      fpsimd_only:
      	/* copy the FP and status/control registers */
    -@@ arch/arm64/kernel/signal.c: static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
    - 		 * FPSIMD register state - flush the saved FPSIMD
    - 		 * register state in case it gets loaded.
    - 		 */
    --		if (current->thread.svcr & SVCR_SM_MASK)
    -+		if (current->thread.svcr & SVCR_SM_MASK) {
    - 			memset(&current->thread.uw.fpsimd_state, 0,
    - 			       sizeof(current->thread.uw.fpsimd_state));
    -+			current->thread.fp_type = FP_STATE_FPSIMD;
    -+		}
    - 
    - 		current->thread.svcr &= ~(SVCR_ZA_MASK |
    - 					  SVCR_SM_MASK);
     
      ## arch/arm64/kvm/fpsimd.c ##
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
    + 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
      		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.fp_regs,
      					 vcpu->arch.sve_state,
    - 					 vcpu->arch.sve_max_vl,
    --					 NULL, 0, &vcpu->arch.svcr);
    -+					 NULL, 0, &vcpu->arch.svcr,
    +-					 vcpu->arch.sve_max_vl);
    ++					 vcpu->arch.sve_max_vl,
     +					 &vcpu->arch.fp_type);
      
      		clear_thread_flag(TIF_FOREIGN_FPSTATE);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

