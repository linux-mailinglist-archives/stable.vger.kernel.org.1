Return-Path: <stable+bounces-66153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604094CE01
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B218D284D83
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38D3192B93;
	Fri,  9 Aug 2024 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ehJrsrJ9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KhzFSLh"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B9191F8E;
	Fri,  9 Aug 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197165; cv=none; b=unFh7Cwz4YhfUnP6Ikd3hnvziZNwyUcaFCiDbLz4uS6VIzyfKb+gmk23NQb8bT3wMafB9354+8KxxfeitAHs0SBDa3Q/LPFyz2D03vrFeDV9uoQgqQDG3DoFZ3rCpUPCJIFsd7ApMxZaKC3VPwYpce0N+cA/19JqgCM69NRW3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197165; c=relaxed/simple;
	bh=ozjwcTkep7DlLLDrypYARbPv61jzZZlIlGR4j6ifn6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BkFy3tPnnBodtPpG++dIYTZ4WBrUlIvbEd4leQGe03mSPCJISmTXar5+5xY2T3UwR3rbIec/1g7cpxWLmsYTWbfB+dmsjNeuuW80ZOaj8yepiKqb5W4cNCgoZ2wLWiz1OoVrKDSunErA3QZVNWPvp4Mld9EuKf7VGpeJGEq3vcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ehJrsrJ9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KhzFSLh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723197161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5YjwTCU2OQM/Narg4Ewd7nmD1UPLyqIGINOuM2x29Lo=;
	b=ehJrsrJ9F00Y787XjJnoEvLxrmp4W/Bqc3flQ+mgygYYgwO4v4uoSUZedrxMepxmiLIbbS
	SCMPXiOBac0s2/eySDz7LkSa02Dg3MOTmEEr2le18pBPEo0EXSx+9aFXW0RQB1GjgZS1kE
	2DX+VZHbOMFTo0YpZcyEJ/Hy2aApM6xeTle4CR09qpFW2mUiEEq+CUWmAFlC0rw8SWKAwv
	vj29KH0GKJ9Fg/1J8fEc9ZW5oZ0doXfYIZUhIbt1TDpUJfzPbZKElhdq+ILcMskGBicS63
	3/HZTq9ZbwiZYE+v8wI7AvzpbxHaPPd2N7qoJmgRMvpiIO4ZeHRYGcs61D+nuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723197161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5YjwTCU2OQM/Narg4Ewd7nmD1UPLyqIGINOuM2x29Lo=;
	b=0KhzFSLhzKsCrkz+o1K/E4y6oHgNrfBt2UUwPqHEvba1a+3gCE4v/Ah9lEo8OWSbtQxtfI
	/FuorVCU/pD+eqDQ==
To: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
 linux-kernel@vger.kernel.org, Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH] x86/fpu: Avoid writing LBR bit to IA32_XSS unless
 supported
In-Reply-To: <20240808-xsave-lbr-fix-v1-1-a223806c83e7@gmail.com>
References: <20240808-xsave-lbr-fix-v1-1-a223806c83e7@gmail.com>
Date: Fri, 09 Aug 2024 11:52:40 +0200
Message-ID: <87sevet447.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 08 2024 at 16:30, Mitchell Levy via wrote:
> From: Mitchell Levy <levymitchell0@gmail.com>
>
> When computing which xfeatures are available, make sure that LBR is only
> present if both LBR is supported in general, as well as by XSAVES.
>
> There are two distinct CPU features related to the use of XSAVES as it
> applies to LBR: whether LBR is itself supported (strictly speaking, I'm
> not sure that this is necessary to check though it's certainly a good
> sanity check), and whether XSAVES supports LBR (see sections 13.2 and
> 13.5.12 of the Intel 64 and IA-32 Architectures Software Developer's
> Manual, Volume 1). Currently, the LBR subsystem correctly checks both
> (see intel_pmu_arch_lbr_init), however the xstate initialization
> subsystem does not.
>
> When calculating what value to place in the IA32_XSS MSR,
> xfeatures_mask_independent only checks whether LBR support is present,
> not whether XSAVES supports LBR. If XSAVES does not support LBR, this
> write causes #GP, leaving the state of IA32_XSS unchanged (i.e., set to
> zero, as its not written with other values, and its default value is
> zero out of RESET per section 13.3 of the arch manual).
>
> Then, the next time XRSTORS is used to restore supervisor state, it will
> fail with #GP (because the RFBM has zero for all supervisor features,
> which does not match the XCOMP_BV field). In particular,
> XFEATURE_MASK_FPSTATE includes supervisor features, so setting up the FPU
> will cause a #GP. This results in a call to fpu_reset_from_exception_fixup,
> which by the same process results in another #GP. Eventually this causes
> the kernel to run out of stack space and #DF.

Cute.

> Fixes: d72c87018d00 ("x86/fpu/xstate: Move remaining xfeature helpers to core")

This is not the culprit/

> Cc: stable@vger.kernel.org
>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  arch/x86/kernel/fpu/xstate.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
> index 2ee0b9c53dcc..574d2c2ea227 100644
> --- a/arch/x86/kernel/fpu/xstate.h
> +++ b/arch/x86/kernel/fpu/xstate.h
> @@ -61,7 +61,8 @@ static inline u64 xfeatures_mask_supervisor(void)
>  
>  static inline u64 xfeatures_mask_independent(void)
>  {
> -	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
> +	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) ||
> +	    (fpu_kernel_cfg.max_features & XFEATURE_MASK_LBR) != XFEATURE_MASK_LBR)

This is wrong because fpu_kernel_cfg.max_features never contains
XFEATURE_MASK_LBR. It only contains the bits which are managed by the
FPU subsystem.

Thanks,

        tglx

