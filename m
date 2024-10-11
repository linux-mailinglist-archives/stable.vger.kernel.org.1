Return-Path: <stable+bounces-83418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED24999BBD
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 06:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B87B23DD1
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 04:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7511F4736;
	Fri, 11 Oct 2024 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xoA8SCgN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74C1FCC75
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621638; cv=none; b=ahU3P7zH47EUQWfSZUd7QVHLALEsYmtbshzmqVsf1K+iAzDMSf4tgpSizNxFgJmts6qrqpKi/sgwbxtDPENEePbDEp0jN9xRCJngHIZHCDLmxSHBirxteJHxJ8XgFxjRW7Y+yq2BTDdgj1rZbc4kzmiRGEokLdQKQJt58ceGENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621638; c=relaxed/simple;
	bh=neBLCYRnIZEhQUNidthmvLDNFNjT0VEot3ArAIqkU1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvgUJ0CH95WvJ0rVaC3tZey8Fegpqg+hUPOZFhFe8b2Yfp3E37K4RWu0Q/M/grN952prbl5jnEgkWxGDoHzr2rK600w+JA74IATiU7P+Euv0Le+Ik2xrpE4XDZhNo0iPOxnYvheNXKaEf5RCj0LCtTTQtVVcFFJIN7ny1QoB4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xoA8SCgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BB3C4CEC3;
	Fri, 11 Oct 2024 04:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728621638;
	bh=neBLCYRnIZEhQUNidthmvLDNFNjT0VEot3ArAIqkU1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xoA8SCgN7MGyA6763Jw6BW9T/6ipclxcobjDzy5OAF8c4enVyrZ11BngkjXTjkm/q
	 1Z+I+nD+l/KURyChv0egeqThLp6aJa1MGq3TdzzX7Arbc8R37X3fd5YDlC8FRNrBDZ
	 tbc+GOdyfchwRICCt77sI3eqKJIs/5gspwslhyHk=
Date: Fri, 11 Oct 2024 06:34:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5.15.y] x86/fpu: Avoid writing LBR bit to IA32_XSS unless
 supported
Message-ID: <2024101158-olympics-onward-3e23@gregkh>
References: <2024090809-plaything-sash-1d57@gregkh>
 <20241010235731.10876-1-levymitchell0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010235731.10876-1-levymitchell0@gmail.com>

On Thu, Oct 10, 2024 at 04:57:31PM -0700, Mitchell Levy wrote:
> There are two distinct CPU features related to the use of XSAVES and LBR:
> whether LBR is itself supported and whether XSAVES supports LBR. The LBR
> subsystem correctly checks both in intel_pmu_arch_lbr_init(), but the
> XSTATE subsystem does not.
> 
> The LBR bit is only removed from xfeatures_mask_independent when LBR is not
> supported by the CPU, but there is no validation of XSTATE support.
> If XSAVES does not support LBR the write to IA32_XSS causes a #GP fault,
> leaving the state of IA32_XSS unchanged, i.e. zero. The fault is handled
> with a warning and the boot continues.
> 
> Consequently the next XRSTORS which tries to restore supervisor state fails
> with #GP because the RFBM has zero for all supervisor features, which does
> not match the XCOMP_BV field.
> 
> As XFEATURE_MASK_FPSTATE includes supervisor features setting up the FPU
> causes a #GP, which ends up in fpu_reset_from_exception_fixup(). That fails
> due to the same problem resulting in recursive #GPs until the kernel runs
> out of stack space and double faults.
> 
> Prevent this by storing the supported independent features in
> fpu_kernel_cfg during XSTATE initialization and use that cached value for
> retrieving the independent feature bits to be written into IA32_XSS.
> 
> [ tglx: Massaged change log ]
> 
> Fixes: f0dccc9da4c0 ("x86/fpu/xstate: Support dynamic supervisor feature for LBR")
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> [ Mitchell Levy: Backport to 5.15, since struct fpu_config is not
>   introduced until 578971f4e228 and feature masks are not included in
>   said struct until 1c253ff2287f ]
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20240812-xsave-lbr-fix-v3-1-95bac1bf62f4@gmail.com
> ---
>  arch/x86/include/asm/fpu/xstate.h | 5 +++--
>  arch/x86/kernel/fpu/xstate.c      | 7 +++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

