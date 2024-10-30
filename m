Return-Path: <stable+bounces-89352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ACC9B6B13
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 18:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F00282122
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC87196C86;
	Wed, 30 Oct 2024 17:34:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BB71BD9C1;
	Wed, 30 Oct 2024 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309672; cv=none; b=cwfDQ5mFbvk9cZaBwFsucgN267lv/kMRbGYj+aPhFHC32PqB8eTY8d2Cxa+X74bYF4JsCoHxHRY976EhMYVULFFkhxE8xQEylkar7434lwCvfDy2ohSvPQlXy56/onjadN78PdAqW+4W923KrRcREqeUzsBs6ynP7hAEwBa0ITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309672; c=relaxed/simple;
	bh=kMawLNH9aQV2M84jka7WgJJuF+vt/gGttx+f3HtUv+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7+liYrabIN8RFgIn6CIZX+XISy2gGCWRYJLO5SW+Bd7SpgzRNY7fbQFUnnn5TyboSBpccmmTMa3xikxlHLXUoOVwAOa81f72rNILb3K5pXPm4BQZmaYJxLAEKa1nNmN7rKITp3uuq+vkUftXTA45UERGQwK+t61AjCNlhzLChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51713113E;
	Wed, 30 Oct 2024 10:34:57 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0B983F66E;
	Wed, 30 Oct 2024 10:34:25 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:34:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andre.Przywara@arm.com
Subject: Re: [PATCH] arm64/signal: Avoid corruption of SME state when
 entering signal handler
Message-ID: <ZyJuEBC1wFPrTLAS@J2N7QTR9R3>
References: <20241023-arm64-fp-sme-sigentry-v1-1-249ff7ec3ad0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-arm64-fp-sme-sigentry-v1-1-249ff7ec3ad0@kernel.org>

Hi Mark,

Thanks for this.

I originally just had a few comments on the commit message, but I
believe I've found a logic issue in this patch, and more general issue
throughout our FPSIMD/SVE/SME manipulation -- more details below.

On Wed, Oct 23, 2024 at 10:31:24PM +0100, Mark Brown wrote:
> When we enter a signal handler we exit streaming mode in order to ensure
> that signal handlers can run normal FPSIMD code, and while we're at it we
> also clear PSTATE.ZA. Currently the code in setup_return() updates both the
> in memory copy of the state and the register state. Not only is this
> redundant it can also lead to corruption if we are preempted.

It would be nice if we could be clearer regarding the implications, e.g.
that this has no effect on tasks which only use plain FPSIMD or SVE.

How about:

| We intend that signal handlers are entered with PSTATE.{SM,ZA}={0,0}.
| The logic for this in setup_return() manipulates the saved state and
| live CPU state in an unsafe manner, and consequently, when a task enters
| a signal handler:
| 
| * The task entering the signal handler might not have its PSTATE.{SM,ZA}
|   bits cleared, and other register state that is affected by changes to
|   PSTATE.{SM,ZA} might not be zeroed as expected.
| 
| * An unrelated task might have its PSTATE.{SM,ZA} bits cleared
|   unexpectedly, potentially zeroing other register state that is
|   affected by changes to PSTATE.{SM,ZA}.
| 
|   Tasks which do not set PSTATE.{SM,ZA} (i.e. those only using plain
|   FPSIMD or non-streaming SVE) are not affected, as there is no
|   resulting change to PSTATE.{SM,ZA}.

> Consider two tasks on one CPU:

Minor nit, but can we say:

| For example, consider two tasks on one CPU:

... since there are other races possible.

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

[ moving the "Fix ..." later ]

> This race has been observed intermittently with fp-stress, especially
> with preempt disabled.

It would be nice to have the signature of the failure as well, e.g.

| This is intermittently detected by the fp-stress test, which
| intermittently reports "ZA-VL-*-*: Bad SVCR: 0".

> Fix this by check TIF_FOREIGN_FPSTATE and only updating one of the live
> register context or the in memory copy when entering a signal handler.
> Since this needs to happen atomically and all code that atomically
> accesses FP state is in fpsimd.c also move the code there to ensure
> consistency.

How about:

| Fix this by:
| 
| * Checking TIF_FOREIGN_FPSTATE, and only updating the saved or live
|   state as appropriate.
| 
| * Using {get,put}_cpu_fpsimd_context() to ensure mutual exclusion
|   against other code which manipulates this state. To allow their use,
|   the logic is moved into a new fpsimd_enter_sighandler() helper in
|   fpsimd.c.

> Fixes: 40a8e87bb3285 ("arm64/sme: Disable ZA and streaming mode when handling signals")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/fpsimd.h |  1 +
>  arch/arm64/kernel/fpsimd.c      | 30 ++++++++++++++++++++++++++++++
>  arch/arm64/kernel/signal.c      | 19 +------------------
>  3 files changed, 32 insertions(+), 18 deletions(-)
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
> index 77006df20a75aee7c991cf116b6d06bfe953d1a4..e6b086dc09f21e7f30df32ab4f6875b53c4228fd 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1693,6 +1693,36 @@ void fpsimd_signal_preserve_current_state(void)
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
> +		/* Exiting streaming mode zeros the FPSIMD state */
> +		if (current->thread.svcr & SVCR_SM_MASK) {
> +			memset(&current->thread.uw.fpsimd_state, 0,
> +			       sizeof(current->thread.uw.fpsimd_state));
> +			current->thread.fp_type = FP_STATE_FPSIMD;
> +		}
> +
> +		current->thread.svcr &= ~(SVCR_ZA_MASK |
> +					  SVCR_SM_MASK);
> +	} else {
> +		/* The register state is current, just update it. */
> +		sme_smstop();
> +	}
> +
> +	put_cpu_fpsimd_context();
> +}

I don't think this is correct in the TIF_FOREIGN_FPSTATE case. We don't
unbind the saved state from another CPU it might still be resident on,
and so IIUC there's a race whereby the updates to the saved state can
end up discarded:

	CPU 0				CPU 1

	1. trap from user->kernel
	   with live state.
	2. context-switch out
	   - fpsimd_thread_switch()
	     saves the HW state
					3. context-switch in.
					   - fpsimd_thread_switch()
					     sets TIF_FOREIGN_FPSTATE

					4. fpsimd_enter_sighandler()
					5. context-switch out
					   - fpsimd_thread_switch() sees
					     TIF_FOREIGN_FPSTATE, saves
					     nothing

	6. context-switch in
	   - fpsimd_last_state.st is
	     this task's state
	   - this task's fpsimd_cIpu
	     is CPU 0
	   ... so fpsimd_thread_switch()
	   clears TIF_FOREIGN_FPSTATE
	
	7. running with stale live
	   state from step 1.

... and either:

* A subsequent return to userspace will see TIF_FOREIGN_FPSTATE is
  clear and not restore the in-memory state.

* A subsequent context-switch will see TIF_FOREIGN_FPSTATE is clear an 
  save the (stale) HW state again.

It looks like we have a similar pattern all over the place, e.g.  in
do_sve_acc():

void do_sve_acc(unsigned long esr, struct pt_regs *regs)
{
	...

	<< preempt; migrate from CPU 0 to CPU 1 >>
        
        get_cpu_fpsimd_context();

        if (test_and_set_thread_flag(TIF_SVE))
                WARN_ON(1); /* SVE access shouldn't have trapped */

        /*
         * Even if the task can have used streaming mode we can only
         * generate SVE access traps in normal SVE mode and
         * transitioning out of streaming mode may discard any
         * streaming mode state.  Always clear the high bits to avoid
         * any potential errors tracking what is properly initialised.
         */
        sve_init_regs();

        put_cpu_fpsimd_context();
	
	<< preempt; migrate from CPU 1 to CPU 0 >>

	<< TIF_SVE is set, as above >>
	<< TIF_FOREIGN_FPSTATE clear due to reusing old HW state >>
	<< Old HW state has CPACR_EL1.ZEN set to trap SVE >>
	<< Return to userapce won't reload HW state because >>
}

... which would explain the do_sve_acc() issue, and why it's so rare.

This is going to need a careful audit and a proper series of
fixes that can be backported to stable.

Mark.

