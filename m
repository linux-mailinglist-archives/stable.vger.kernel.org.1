Return-Path: <stable+bounces-211821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJG9FSvHeGmltAEAu9opvQ
	(envelope-from <stable+bounces-211821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:09:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EAACB955F5
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BC7830054FF
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EF927F00A;
	Tue, 27 Jan 2026 14:09:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF07286D57
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522985; cv=none; b=SbLRZRfpops+Mm4Ss/N8uxHztSNax32qRYBs0zgK1Pw2BSLH8xSkVwmd1po+tJf/ztM3LF2lq3lh25YCmJey/3POJmIJL0Ln4Nt3NGKh1ljWmPGg0pI9Mq/V5wp1KXP5MOk2ebyUVSNnOi9MHyx593pJCPtPHazdbU1RdCzC2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522985; c=relaxed/simple;
	bh=mbafKTMkpdoTAf6cuB5PAt4qba9HdDLpJHhTIJeKJK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlOM1vzt5ahTZ0O7HlRuv6+R5IY/skF32CvA+SflzTjosldKGi8XtwFaDv17ocWsxxpGYbcpBawQ4Q+Q4MfenjysBZhEqJGjdutO+nLCvKEas4QVbaSwyABQbXaPRjwJgYoYzHJnkQe30BQy9uXUqDlaC7ZsBjDCWhyyB821crE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E9731595;
	Tue, 27 Jan 2026 06:09:36 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF8DC3F73F;
	Tue, 27 Jan 2026 06:09:41 -0800 (PST)
Date: Tue, 27 Jan 2026 14:09:35 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org, catalin.marinas@arm.com, stable@vger.kernel.org,
	will@kernel.org
Subject: Re: FAILED: patch "[PATCH] arm64/fpsimd: signal: Fix restoration of
 SVE context" failed to apply to 6.12-stable tree
Message-ID: <aXjG0i9r-FeZ4iXc@J2N7QTR9R3>
References: <2026012701-tile-landowner-8d31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026012701-tile-landowner-8d31@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211821-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,gregkh:email,svcr.sm:url]
X-Rspamd-Queue-Id: EAACB955F5
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:16:01PM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

As a heads-up for the others on Cc, I've seen this and will chase this
up shortly.

At present this patch doesn't strictly matter since we haven't
re-enabled SME support in the upstream stable trees, and at this point I
reckon we shouldn't.

Mark.

> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x d2907cbe9ea0a54cbe078076f9d089240ee1e2d9
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012701-tile-landowner-8d31@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From d2907cbe9ea0a54cbe078076f9d089240ee1e2d9 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Tue, 20 Jan 2026 14:51:07 +0000
> Subject: [PATCH] arm64/fpsimd: signal: Fix restoration of SVE context
> 
> When SME is supported, Restoring SVE signal context can go wrong in a
> few ways, including placing the task into an invalid state where the
> kernel may read from out-of-bounds memory (and may potentially take a
> fatal fault) and/or may kill the task with a SIGKILL.
> 
> (1) Restoring a context with SVE_SIG_FLAG_SM set can place the task into
>     an invalid state where SVCR.SM is set (and sve_state is non-NULL)
>     but TIF_SME is clear, consequently resuting in out-of-bounds memory
>     reads and/or killing the task with SIGKILL.
> 
>     This can only occur in unusual (but legitimate) cases where the SVE
>     signal context has either been modified by userspace or was saved in
>     the context of another task (e.g. as with CRIU), as otherwise the
>     presence of an SVE signal context with SVE_SIG_FLAG_SM implies that
>     TIF_SME is already set.
> 
>     While in this state, task_fpsimd_load() will NOT configure SMCR_ELx
>     (leaving some arbitrary value configured in hardware) before
>     restoring SVCR and attempting to restore the streaming mode SVE
>     registers from memory via sve_load_state(). As the value of
>     SMCR_ELx.LEN may be larger than the task's streaming SVE vector
>     length, this may read memory outside of the task's allocated
>     sve_state, reading unrelated data and/or triggering a fault.
> 
>     While this can result in secrets being loaded into streaming SVE
>     registers, these values are never exposed. As TIF_SME is clear,
>     fpsimd_bind_task_to_cpu() will configure CPACR_ELx.SMEN to trap EL0
>     accesses to streaming mode SVE registers, so these cannot be
>     accessed directly at EL0. As fpsimd_save_user_state() verifies the
>     live vector length before saving (S)SVE state to memory, no secret
>     values can be saved back to memory (and hence cannot be observed via
>     ptrace, signals, etc).
> 
>     When the live vector length doesn't match the expected vector length
>     for the task, fpsimd_save_user_state() will send a fatal SIGKILL
>     signal to the task. Hence the task may be killed after executing
>     userspace for some period of time.
> 
> (2) Restoring a context with SVE_SIG_FLAG_SM clear does not clear the
>     task's SVCR.SM. If SVCR.SM was set prior to restoring the context,
>     then the task will be left in streaming mode unexpectedly, and some
>     register state will be combined inconsistently, though the task will
>     be left in legitimate state from the kernel's PoV.
> 
>     This can only occur in unusual (but legitimate) cases where ptrace
>     has been used to set SVCR.SM after entry to the sigreturn syscall,
>     as syscall entry clears SVCR.SM.
> 
>     In these cases, the the provided SVE register data will be loaded
>     into the task's sve_state using the non-streaming SVE vector length
>     and the FPSIMD registers will be merged into this using the
>     streaming SVE vector length.
> 
> Fix (1) by setting TIF_SME when setting SVCR.SM. This also requires
> ensuring that the task's sme_state has been allocated, but as this could
> contain live ZA state, it should not be zeroed. Fix (2) by clearing
> SVCR.SM when restoring a SVE signal context with SVE_SIG_FLAG_SM clear.
> 
> For consistency, I've pulled the manipulation of SVCR, TIF_SVE, TIF_SME,
> and fp_type earlier, immediately after the allocation of
> sve_state/sme_state, before the restore of the actual register state.
> This makes it easier to ensure that these are always modified
> consistently, even if a fault is taken while reading the register data
> from the signal context. I do not expect any software to depend on the
> exact state restored when a fault is taken while reading the context.
> 
> Fixes: 85ed24dad290 ("arm64/sme: Implement streaming SVE signal handling")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: <stable@vger.kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 9c2e26e01d72..08ffc5a5aea4 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -449,12 +449,28 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
>  	if (user->sve_size < SVE_SIG_CONTEXT_SIZE(vq))
>  		return -EINVAL;
>  
> +	if (sm) {
> +		sme_alloc(current, false);
> +		if (!current->thread.sme_state)
> +			return -ENOMEM;
> +	}
> +
>  	sve_alloc(current, true);
>  	if (!current->thread.sve_state) {
>  		clear_thread_flag(TIF_SVE);
>  		return -ENOMEM;
>  	}
>  
> +	if (sm) {
> +		current->thread.svcr |= SVCR_SM_MASK;
> +		set_thread_flag(TIF_SME);
> +	} else {
> +		current->thread.svcr &= ~SVCR_SM_MASK;
> +		set_thread_flag(TIF_SVE);
> +	}
> +
> +	current->thread.fp_type = FP_STATE_SVE;
> +
>  	err = __copy_from_user(current->thread.sve_state,
>  			       (char __user const *)user->sve +
>  					SVE_SIG_REGS_OFFSET,
> @@ -462,12 +478,6 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
>  	if (err)
>  		return -EFAULT;
>  
> -	if (flags & SVE_SIG_FLAG_SM)
> -		current->thread.svcr |= SVCR_SM_MASK;
> -	else
> -		set_thread_flag(TIF_SVE);
> -	current->thread.fp_type = FP_STATE_SVE;
> -
>  	err = read_fpsimd_context(&fpsimd, user);
>  	if (err)
>  		return err;
> 

