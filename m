Return-Path: <stable+bounces-185616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B01BD8925
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AE0543D24
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4819E3090DC;
	Tue, 14 Oct 2025 09:46:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAF630F949
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435206; cv=none; b=TxvwEi23QLzeC/DteUobzGJMuF0WvESS5DYw9esnOH8vROawFhZIs5S05NolU9ptra3+LOcPass3ZSr3qVlNc+x6kIxTyTKhP3Ua/Zjw35SYo+kS0UCjolBaXERZMkAHf7bDt47RVh6AHuFCkdSjd6Nm+LCgxuwfi5aKMjw+pU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435206; c=relaxed/simple;
	bh=tYCZz6/tjNK8T5rI6nLF3lp6wp5duq74odWhG6Ojg3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBvp8Iqi5sXUY1bPaAEWdZ+DToFPp/FiJfOMzo+osXDE158wW2iGVPw+1SeYPcCWeUICaRsjhSxjFvNLlh0J1rVq8d2gKLS46OVlO/Gajc81HZPuafsRM0imV5LitBDDxjhuO4i9HW85xDBDYn//7+vbeTxzSm4eu6QwPST7zoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 443291A9A;
	Tue, 14 Oct 2025 02:46:35 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4329B3F66E;
	Tue, 14 Oct 2025 02:46:42 -0700 (PDT)
Date: Tue, 14 Oct 2025 10:46:37 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: debug: always unmask interrupts in
 el0_softstp()
Message-ID: <aO4b_Ubig2FXowLa@J2N7QTR9R3.cambridge.arm.com>
References: <20251013174317.74791-1-ada.coupriediaz@arm.com>
 <20251014092536.18831-1-ada.coupriediaz@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014092536.18831-1-ada.coupriediaz@arm.com>

On Tue, Oct 14, 2025 at 10:25:36AM +0100, Ada Couprie Diaz wrote:
> EL0 exception handlers should always call `exit_to_user_mode()` with
> interrupts unmasked.
> When handling a completed single-step, we skip the if block and
> `local_daif_restore(DAIF_PROCCTX)` never gets called,
> which ends up calling `exit_to_user_mode()` with interrupts masked.
>
> This is broken if pNMI is in use, as `do_notify_resume()` will try
> to enable interrupts, but `local_irq_enable()` will only change the PMR,
> leaving interrupts masked via DAIF.

I think we might want to spell thius out a bit more, e.g.

| We intend that EL0 exception handlers unmask all DAIF exceptions
| before calling exit_to_user_mode().
|
| When completing single-step of a suspended breakpoint, we do not call
| local_daif_restore(DAIF_PROCCTX) before calling exit_to_user_mode(),
| leaving all DAIF exceptions masked.
|
| When pseudo-NMIs are not in use this is benign.
|
| When pseudo-NMIs are in use, this is unsound. At this point interrupts
| are masked by both DAIF.IF and PMR_EL1, and subsequent irq flag
| manipulation may not work correctly. For example, a subsequent
| local_irq_enable() within exit_to_user_mode_loop() will only unmask
| interrupts via PMR_EL1 (leaving those masked via DAIF.IF), and
| anything depending on interrupts being unmasked (e.g. delivery of
| signals) will not work correctly.
|
| This can by detected by CONFIG_ARM64_DEBUG_PRIORITY_MASKING.

With or without that, this looks good to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> Move the call to `try_step_suspended_breakpoints()` outside of the check
> so that interrupts can be unmasked even if we don't call the step handler.
> 
> Fixes: 0ac7584c08ce ("arm64: debug: split single stepping exception entry")
> Cc: <stable@vger.kernel.org> # 6.17
> Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> ----
> This was already broken in a similar fashion in kernels prior to v6.17,
> as `local_daif_restore()` was called _after_ the debug handlers, with some
> calling `send_user_sigtrap()` which would unmask interrupts via PMR
> while leaving them masked by DAIF.
> 
> v2: Add missing semicolon so that the patch compiles.
> My mistake for rushing a fix late, apologies.
> ---
>  arch/arm64/kernel/entry-common.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 2b0c5925502e..8473fe4791bc 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -832,6 +832,7 @@ static void noinstr el0_breakpt(struct pt_regs *regs, unsigned long esr)
>  
>  static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
>  {
> +	bool step_done;
>  	if (!is_ttbr0_addr(regs->pc))
>  		arm64_apply_bp_hardening();
>  
> @@ -842,10 +843,11 @@ static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
>  	 * If we are stepping a suspended breakpoint there's nothing more to do:
>  	 * the single-step is complete.
>  	 */
> -	if (!try_step_suspended_breakpoints(regs)) {
> -		local_daif_restore(DAIF_PROCCTX);
> +	step_done = try_step_suspended_breakpoints(regs);
> +	local_daif_restore(DAIF_PROCCTX);
> +	if (!step_done)
>  		do_el0_softstep(esr, regs);
> -	}
> +
>  	exit_to_user_mode(regs);
>  }
>  
> 
> base-commit: 449d48b1b99fdaa076166e200132705ac2bee711
> -- 
> 2.43.0
> 

