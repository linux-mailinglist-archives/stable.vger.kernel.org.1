Return-Path: <stable+bounces-89915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DFF9BD5AF
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 20:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6332B219D5
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4EF1EABD6;
	Tue,  5 Nov 2024 19:13:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B71E2007;
	Tue,  5 Nov 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833991; cv=none; b=St/RWQsiQxZ3G/5oGxqFK2x7D5WVVVRpLQ8Sh8elQ4QQET53HjIvHiTE4dQzUQR7bYxMyugD12WAAFmx853PAVk9nYDDStmaIlVR/iGbbq8SoPCIky1uRbwjtllLRf4KbwWSIOBO0VPEyK94TcmNhRlJ+SGYEtk+uJskD5EBRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833991; c=relaxed/simple;
	bh=rl3Vm+n9p/rsVev3vkvR4xc1wfklDcCqP/0PnSiJQow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys6yiO+G4Elg6u/BKojW7SxxmfdLYS0jWaHhuQG621P668mFCTgXzMRDG77ySI19NMcqVJiC9wNGERRsL/EgzKFngOJ/1b5BBBxFwasrITSbjIWFWa3OGw2026sdPaHl+MzfZxWvHBGwahEKPBChhcwK59y7qANDOU8xdTgAYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8EAA1063;
	Tue,  5 Nov 2024 11:13:37 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B989B3F528;
	Tue,  5 Nov 2024 11:13:06 -0800 (PST)
Date: Tue, 5 Nov 2024 19:13:04 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/sve: Flush foreign register state in
 sve_init_regs()
Message-ID: <ZypuQNhWHKut8mLl@J2N7QTR9R3.cambridge.arm.com>
References: <20241030-arm64-fpsimd-foreign-flush-v1-0-bd7bd66905a2@kernel.org>
 <20241030-arm64-fpsimd-foreign-flush-v1-1-bd7bd66905a2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-arm64-fpsimd-foreign-flush-v1-1-bd7bd66905a2@kernel.org>

On Wed, Oct 30, 2024 at 08:23:50PM +0000, Mark Brown wrote:
> When we update the in memory register state in sve_init_regs() we neglect
> to flush the task's CPU binding, meaning if the task is rescheduled to
> the last CPU it ran on it is possible for the check for current state in
> fpsimd_thread_switch() to falsely determine that up to date register
> state is present on the CPU.  This results in it incorrectly clearing
> TIF_FOREIGN_FPSTATE and suppress reloading.
> 
> This will also suppress the sve_user_enable() done in
> fpsimd_bind_task_to_cpu() as part of return to userspace, causing
> spurious SVE access traps.
> 
> Call fpsimd_flush_task_state() to invalidate the last loaded CPU
> recorded in the task.
> 
> Fixes: cccb78ce89c4 ("arm64/sve: Rework SVE access trap to convert state in registers")
> Reported-by: Mark Rutlamd <mark.rutland@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org

How about the following:

| arm64/sve: Discard stale CPU state when handling SVE traps
| 
| The logic for handling SVE traps manipulates saved FPSIMD/SVE state
| incorrectly, and a race with preemption can result in a task having
| TIF_SVE set and TIF_FOREIGN_FPSTATE clear even though the live CPU state
| is stale (e.g. with SVE traps enabled). This has been observed to result
| in warnings from do_sve_acc() where SVE traps are not expected while
| TIF_SVE is set:
| 
| |         if (test_and_set_thread_flag(TIF_SVE))
| |                 WARN_ON(1); /* SVE access shouldn't have trapped */
| 
| Warnings of this form have been reported intermittently, e.g.
| 
|   https://lore.kernel.org/linux-arm-kernel/CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com/
|   https://lore.kernel.org/linux-arm-kernel/000000000000511e9a060ce5a45c@google.com/
| 
| The race can occur when the SVE trap handler is preempted before and
| after manipulating the saved FPSIMD/SVE state, starting and ending on
| the same CPU, e.g.
| 
| | void do_sve_acc(unsigned long esr, struct pt_regs *regs)
| | {
| |         // Trap on CPU 0 with TIF_SVE clear, SVE traps enabled
| |         // task->fpsimd_cpu is 0.
| |         // per_cpu_ptr(&fpsimd_last_state, 0) is task.
| | 
| |         ...
| | 
| |         // Preempted; migrated from CPU 0 to CPU 1.
| |         // TIF_FOREIGN_FPSTATE is set.
| | 
| |         get_cpu_fpsimd_context();
| | 
| |         if (test_and_set_thread_flag(TIF_SVE))
| |                 WARN_ON(1); /* SVE access shouldn't have trapped */
| | 
| |         sve_init_regs() {
| |                 if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
| |                         ...
| |                         fpsimd_bind_task_to_cpu();
| |                 } else {
| |                         fpsimd_to_sve(current);
| |                         current->thread.fp_type = FP_STATE_SVE;
| |                 }
| |         }
| | 
| |         put_cpu_fpsimd_context();
| | 
| |         // Preempted; migrated from CPU 1 to CPU 0.
| |         // task->fpsimd_cpu is still 0
| |         // If per_cpu_ptr(&fpsimd_last_state, 0) is still task then:
| |         // - Stale HW state is reused (with SVE traps enabled)
| |         // - TIF_FOREIGN_FPSTATE is cleared
| |         // - A return to userspace skips HW state restore
| | }
| 
| In the case where sve_init_regs() is called while the state is live and
| TIF_FOREIGN_FPSTATE is clear, the state is correctly modified and the
| call to fpsimd_bind_task_to_cpu() disables the SVE trap.
| 
| Fix the case where the state is not live and TIF_FOREIGN_FPSTATE is set
| by calling fpsimd_flush_task_state() to detach from the saved CPU
| state. This ensures that a subsequent context switch will not reuse the
| stale CPU state, and will instead set TIF_FOREIGN_FPSTATE, forcing the
| new state to be reloaded from memory prior to a return to userspace.
| 
| Fixes: cccb78ce89c4 ("arm64/sve: Rework SVE access trap to convert state in registers")
| Reported-by: Mark Rutland <mark.rutland@arm.com>
| Signed-off-by: Mark Brown <broonie@kernel.org>
| Cc: stable@vger.kernel.org

Note: I fixed the typo (s/Rutlamd/Rutland)

With that:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/fpsimd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 77006df20a75aee7c991cf116b6d06bfe953d1a4..6d21971ae5594f32947480cfa168db400a69a283 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1367,6 +1367,7 @@ static void sve_init_regs(void)
>  	} else {
>  		fpsimd_to_sve(current);
>  		current->thread.fp_type = FP_STATE_SVE;
> +		fpsimd_flush_task_state(current);
>  	}
>  }
>  
> 
> -- 
> 2.39.2
> 
> 

