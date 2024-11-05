Return-Path: <stable+bounces-89847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA04B9BD03B
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE1D1C21AE6
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD161D7E46;
	Tue,  5 Nov 2024 15:18:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49463BB21;
	Tue,  5 Nov 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819934; cv=none; b=eeHVC65pk07lyyYeVxN00Ybrb8HOhcZXpegrHi9HVy0U0cpX7YguvtaYBqutBDvwSCsvlzWDl5SPdJNrQagX1BDHsoQFzz690ucRQzfjO7RLkybarWawlg0ROzKO0FDJi67UAau+ZbxqbXdACz0h4sweYoXawSBXxU4D8BN4+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819934; c=relaxed/simple;
	bh=oKUTKz7h6GjGrIClatLhORghr5XcUQQAikgrXqWv0o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s94ReKYrhgm/H+22Iq2ehMAHPJRs5P9Oe5HYNnheYuHEQkPDZUURxwnk1yAHjuQRth01n/Psx8D4ftpv5tVDu1Jp2+qfNaF8KCDheNrI+bRggaf4RjNqi1UGX5EBqyXFI1lklJTjC64P/F876w5/pJLGQbmQ4EascfLRUIxfUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77145FEC;
	Tue,  5 Nov 2024 07:19:15 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89A823F528;
	Tue,  5 Nov 2024 07:18:44 -0800 (PST)
Date: Tue, 5 Nov 2024 15:18:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/signal: Avoid corruption of SME state when
 entering signal handler
Message-ID: <Zyo3QU8aBGmtbTRo@J2N7QTR9R3.cambridge.arm.com>
References: <20241030-arm64-fp-sme-sigentry-v2-1-43ce805d1b20@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-arm64-fp-sme-sigentry-v2-1-43ce805d1b20@kernel.org>

On Wed, Oct 30, 2024 at 07:58:36PM +0000, Mark Brown wrote:
> We intend that signal handlers are entered with PSTATE.{SM,ZA}={0,0}.
> The logic for this in setup_return() manipulates the saved state and
> live CPU state in an unsafe manner, and consequently, when a task enters
> a signal handler:

Looking at this, I think there's a bigger question as to what we
actually intend here; explanation below, with two possible answers at
the end.

[...] 

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
> +
> +		/* Ensure any copies on other CPUs aren't reused */
> +		fpsimd_flush_task_state(current);
> +	} else {
> +		/* The register state is current, just update it. */
> +		sme_smstop();
> +	}

I don't think that the foreign / non-foreign cases are equivalent. In
the foreign case we clear the entire fpsimd_state structure, i.e. all
of:

	struct user_fpsimd_state {
		__uint128_t     vregs[32];
		__u32           fpsr;
		__u32           fpcr;
		__u32           __reserved[2];
	};

Looking at the latest ARM ARM (ARM DDI 0487K.a):

  https://developer.arm.com/documentation/ddi0487/ka/

... the descriptions for FPSR and FPCR say nothing about exiting
streaming mode, and rule RKFRQZ says:

| When the Effective value of PSTATE.SM is changed by any method from 1
| to 0, an exit from Streaming SVE mode is performed, and in the
| newly-entered mode, all implemented bits of the SVE scalable vector
| registers, SVE predicate registers, and FFR, are set to zero.	

... which doesn't say anything about FPSR or FPCR, so from the ARM ARM
it doesn't look like SMSTOP will clobber those.

Looking at the latest "Arm A-profile Architecture Registers" document
(ARM DDI 061 2024-09):

  https://developer.arm.com/documentation/ddi0601/2024-09/

... the description of FPCR says nothing about exiting streaming mode,
so it appears to be preserved.

... the description of FPMR (which is not in the latest ARM ARM) says:

| On entry to or exit from Streaming SVE mode, FPMR is set to 0.

... so we'd need code to clobber that.

... and the description of FPSR says:

| On entry to or exit from Streaming SVE mode, FPSR.{IOC, DZC, OFC, UFC,
| IXC, IDC, QC} are set to 1 and the remaining bits are set to 0.

... so we'd need something more elaborate.

AFAICT either:

(a) Our intended ABI is that signal handlers are entered as-if an SMSTOP
    is executed to exit streaming mode and disable ZA storage.

    In this case we'll need a more elaborate sequence here to simulate
    that effect.

(b) Our intended ABI is that signal handlers are entered with
    PSTATE.{SM,ZA} cleared, FPSR cleared, FPCR cleared, and FPMR
    preserved.

    In this case we cannot use SMSTOP in the non-foreign case, and it
    would be simplest to always save the value back to memory and
    manipulate it there.

Our documentation in Documentation/arch/arm64/sme.rst says:

| Signal handlers are invoked with streaming mode and ZA disabled.

... and doesn't mention FPCR/FPMR/FPSR, so we could go either way,
though I suspect we intended case (a) ?

Mark.

