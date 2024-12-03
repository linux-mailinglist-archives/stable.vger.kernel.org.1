Return-Path: <stable+bounces-97270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5858E9E23C4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77CF168869
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681331F893F;
	Tue,  3 Dec 2024 15:33:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FE71F8928;
	Tue,  3 Dec 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240004; cv=none; b=tz/dr25StiiWdzbcKNmxrcj+FpazNsUFUuiiLJflzWNxSBCbY/SNVxUHPmTPPcsalzqthzneELFsolOtmHQktaaQXwCpQXMlOx/cdZ1Dveq6TVCRiiXE+n3eS4UNsphscyAKWDWlbAUj1RuXjwZEgB6dTrlk73XHkgo+q5dUrO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240004; c=relaxed/simple;
	bh=vshM84WALibGOhrltCH0yerSdgJaWBFl3y+DsT1WfF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPVVv0SRxz7wiwen4GaAOj8m9sqwGwnVu6qasJ1zEalDZtBKzH7VavnW8gr0bfcbEnhovo11KOYBzZ7mUN9j0tVxUBivwLG11XARSok9xDmoN5Cv2s7iBgR3ynBcH5jl0S+2qCbGXjVOGDc4I9GIUM/nN0u13VCAhB7+MVP+fGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF9AAFEC;
	Tue,  3 Dec 2024 07:33:49 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7D993F71E;
	Tue,  3 Dec 2024 07:33:20 -0800 (PST)
Date: Tue, 3 Dec 2024 15:33:18 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64/signal: Avoid corruption of SME state when
 entering signal handler
Message-ID: <Z08kvi0znVM2RHx4@e133380.arm.com>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
 <20241203-arm64-sme-reenable-v1-5-d853479d1b77@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-arm64-sme-reenable-v1-5-d853479d1b77@kernel.org>

On Tue, Dec 03, 2024 at 12:45:57PM +0000, Mark Brown wrote:
> We intend that signal handlers are entered with PSTATE.{SM,ZA}={0,0}.
> The logic for this in setup_return() manipulates the saved state and
> live CPU state in an unsafe manner, and consequently, when a task enters
> a signal handler:
> 
>  * The task entering the signal handler might not have its PSTATE.{SM,ZA}
>    bits cleared, and other register state that is affected by changes to
>    PSTATE.{SM,ZA} might not be zeroed as expected.
> 
>  * An unrelated task might have its PSTATE.{SM,ZA} bits cleared
>    unexpectedly, potentially zeroing other register state that is
>    affected by changes to PSTATE.{SM,ZA}.
> 
>    Tasks which do not set PSTATE.{SM,ZA} (i.e. those only using plain
>    FPSIMD or non-streaming SVE) are not affected, as there is no
>    resulting change to PSTATE.{SM,ZA}.
> 
> Consider for example two tasks on one CPU:
> 
>  A: Begins signal entry in kernel mode, is preempted prior to SMSTOP.
>  B: Using SM and/or ZA in userspace with register state current on the
>     CPU, is preempted.
>  A: Scheduled in, no register state changes made as in kernel mode.
>  A: Executes SMSTOP, modifying live register state.
>  A: Scheduled out.
>  B: Scheduled in, fpsimd_thread_switch() sees the register state on the
>     CPU is tracked as being that for task B so the state is not reloaded
>     prior to returning to userspace.
> 
> Task B is now running with SM and ZA incorrectly cleared.
> 
> Fix this by:
> 
>  * Checking TIF_FOREIGN_FPSTATE, and only updating the saved or live
>    state as appropriate.
> 
>  * Using {get,put}_cpu_fpsimd_context() to ensure mutual exclusion
>    against other code which manipulates this state. To allow their use,
>    the logic is moved into a new fpsimd_enter_sighandler() helper in
>    fpsimd.c.
> 
> This race has been observed intermittently with fp-stress, especially
> with preempt disabled, commonly but not exclusively reporting "Bad SVCR: 0".
> 
> While we're at it also fix a discrepancy between in register and in memory
> entries. When operating on the register state we issue a SMSTOP, exiting
> streaming mode if we were in it. This clears the V/Z and P register and
> FPMR but nothing else. The in memory version clears all the user FPSIMD
> state including FPCR and FPSR but does not clear FPMR. Add the clear of
> FPMR and limit the existing memset() to only cover the vregs, preserving
> the state of FPCR and FPSR like SMSTOP does.
> 
> Fixes: 40a8e87bb3285 ("arm64/sme: Disable ZA and streaming mode when handling signals")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/fpsimd.h |  1 +
>  arch/arm64/kernel/fpsimd.c      | 39 +++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/signal.c      | 19 +------------------
>  3 files changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index f2a84efc361858d4deda99faf1967cc7cac386c1..09af7cfd9f6c2cec26332caa4c254976e117b1bf 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -76,6 +76,7 @@ extern void fpsimd_load_state(struct user_fpsimd_state *state);
>  extern void fpsimd_thread_switch(struct task_struct *next);
>  extern void fpsimd_flush_thread(void);
>  
> +extern void fpsimd_enter_sighandler(void);
>  extern void fpsimd_signal_preserve_current_state(void);
>  extern void fpsimd_preserve_current_state(void);
>  extern void fpsimd_restore_current_state(void);
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index f02762762dbcf954e9add6dfd3575ae7055b6b0e..c5465c8ec467cb1ab8bd211dc5370f91aa2bcf35 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1696,6 +1696,45 @@ void fpsimd_signal_preserve_current_state(void)
>  		sve_to_fpsimd(current);
>  }
>  
> +/*
> + * Called by the signal handling code when preparing current to enter
> + * a signal handler. Currently this only needs to take care of exiting
> + * streaming mode and clearing ZA on SME systems.
> + */
> +void fpsimd_enter_sighandler(void)
> +{
> +	if (!system_supports_sme())
> +		return;
> +
> +	get_cpu_fpsimd_context();
> +
> +	if (test_thread_flag(TIF_FOREIGN_FPSTATE)) {
> +		/*
> +		 * Exiting streaming mode zeros the V/Z and P
> +		 * registers and FPMR.  Zero FPMR and the V registers,
> +		 * marking the state as FPSIMD only to force a clear
> +		 * of the remaining bits during reload if needed.
> +		 */
> +		if (current->thread.svcr & SVCR_SM_MASK) {
> +			memset(&current->thread.uw.fpsimd_state.vregs, 0,
> +			       sizeof(current->thread.uw.fpsimd_state.vregs));

Do we need to hold the CPU fpsimd context across this memset?

IIRC, TIF_FOREIGN_FPSTATE can be spontaneously cleared along with
dumping of the regs into thread_struct (from current's PoV), but never
spontaneously set again.  So ... -> [*]

> +			current->thread.uw.fpmr = 0;
> +			current->thread.fp_type = FP_STATE_FPSIMD;
> +		}
> +
> +		current->thread.svcr &= ~(SVCR_ZA_MASK |
> +					  SVCR_SM_MASK);
> +
> +		/* Ensure any copies on other CPUs aren't reused */
> +		fpsimd_flush_task_state(current);

(This is very similar to fpsimd_flush_thread(); can they be unified?)

> +	} else {
> +		/* The register state is current, just update it. */
> +		sme_smstop();

... [*] the critical thing seems to be that the CPU fpsimd context is
held from the test on TIF_FOREIGN_FPSTATE, across this else clause.

(Whether or not this is a worthwhile optimisation is another matter.
But if the behaviour of TIF_FOREIGN_FPSTATE is still the same, then it
may be a good idea to avoid sending mixed messages about this in the
code.)

(A similar argument applies in fpsimd_flush_thread().)

[...]

Cheers
---Dave

