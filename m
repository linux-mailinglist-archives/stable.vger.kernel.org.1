Return-Path: <stable+bounces-125605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4CEA69B08
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 22:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D2418844A7
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 21:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2B021517B;
	Wed, 19 Mar 2025 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpTVOQEf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18885199E80;
	Wed, 19 Mar 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420379; cv=none; b=EOvokYXo0itkFlu8h/am0AgoHIyXoS23XGxgaR70a2W+sxCONHgIhsa9xI8zFKocxFE3HOxzu3NamXe9thAiqifMfE82lObMBWpIjbVFC64LewHjF7OGxHulfZK/1LgpkXpG0VbA+EgMq/OlezdikbqLDShyXVJ44CRkBUU8wbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420379; c=relaxed/simple;
	bh=7BWeUOsknshXI1K2M6kV/VoXzSvzG8usO0CTtnv7+GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIayw7gUI1dU9zjgi7Hfs/KHURNk+NNyNW09momeGCxrdXIRr9p6NJ5+3HDjo6JQZgi8iNsOmP5l3Gbky9goVvikhyyPHjmvasFJ32L6ygP2nzNz8brQ0Ju4HFJYBYO/DmpmEkGtapwH9OU8o7dovR2BD4bxn4QdMiVSJsSp6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpTVOQEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F884C4CEE4;
	Wed, 19 Mar 2025 21:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742420378;
	bh=7BWeUOsknshXI1K2M6kV/VoXzSvzG8usO0CTtnv7+GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpTVOQEfTL0Z5R9LvZLSMxQ2gOhgLPfNfvDtIb2CdaQ/ZvMyJ0pNs3jEw7J7f5M1l
	 qFOQW3UD+iXHJLNCjJZej5xP6Cuf+gv2GjKXLDyQqvLiX9d8zY21Xvq13cunTu5g/J
	 +hd5YVY796EspSfwcqQBNNPiJGbXD5Hvwp1Mef7zjXdaYbbiuvYMj6uGzurdzGjRyP
	 8vSWK0I+QEH/OJcgHc78MVg0Ch0oIx3hdGTwZDIy5YQ7yr3mQczTKqLEKxHXntv1Td
	 rCX6E27fGPxeBpeWPFVkduiKmnT41mb8B9bksixuxpHlaR/EuTGpXmBdmz6eHeKIsv
	 IchtKo7p8M2UQ==
Date: Wed, 19 Mar 2025 22:39:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Akihiro Suda <suda.gitsendemail@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, stable@vger.kernel.org,
	suda.kyoto@gmail.com, regressions@lists.linux.dev,
	aruna.ramakrishna@oracle.com, tglx@linutronix.de,
	Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Subject: Re: [PATCH] x86/pkeys: Disable PKU when XFEATURE_PKRU is missing
Message-ID: <Z9s5lam2QzWCOOKi@gmail.com>
References: <CAG8fp8S92hXFxMKQtMBkGqk1sWGu7pdHYDowsYbmurt0BGjfww@mail.gmail.com>
 <20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp>


* Akihiro Suda <suda.gitsendemail@gmail.com> wrote:

> Even when X86_FEATURE_PKU and X86_FEATURE_OSPKE are available,
> XFEATURE_PKRU can be missing.
> In such a case, pkeys has to be disabled to avoid hanging up.
> 
>   WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/xstate.c:1003 get_xsave_addr_user+0x28/0x40
>   (...)
>   Call Trace:
>    <TASK>
>    ? get_xsave_addr_user+0x28/0x40
>    ? __warn.cold+0x8e/0xea
>    ? get_xsave_addr_user+0x28/0x40
>    ? report_bug+0xff/0x140
>    ? handle_bug+0x3b/0x70
>    ? exc_invalid_op+0x17/0x70
>    ? asm_exc_invalid_op+0x1a/0x20
>    ? get_xsave_addr_user+0x28/0x40
>    copy_fpstate_to_sigframe+0x1be/0x380
>    ? __put_user_8+0x11/0x20
>    get_sigframe+0xf1/0x280
>    x64_setup_rt_frame+0x67/0x2c0
>    arch_do_signal_or_restart+0x1b3/0x240
>    syscall_exit_to_user_mode+0xb0/0x130
>    do_syscall_64+0xab/0x1a0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> This fix is known to be needed on Apple Virtualization.
> Tested with macOS 13.5.2 running on MacBook Pro 2020 with
> Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz.
> 
> Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")
> Link: https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7knK38rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
> Link: https://github.com/lima-vm/lima/issues/3334
> 
> Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> ---
>  arch/x86/kernel/cpu/common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index e9464fe411ac..4c2c268af214 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -517,7 +517,8 @@ static bool pku_disabled;
>  static __always_inline void setup_pku(struct cpuinfo_x86 *c)
>  {
>  	if (c == &boot_cpu_data) {
> -		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
> +		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU) ||
> +		    !cpu_has_xfeatures(XFEATURE_PKRU, NULL))
>  			return;

Note that silent quirks are counterproductive, as they don't give VM 
vendors any incentives to fix their VM for such bugs.

So I changed your quirk to be:

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -519,6 +519,17 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 	if (c == &boot_cpu_data) {
 		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
 			return;
+		if (!cpu_has_xfeatures(XFEATURE_PKRU, NULL)) {
+			/*
+			 * Missing XFEATURE_PKRU is not really a valid CPU
+			 * configuration at this point, but apparently
+			 * Apple Virtualization is affected by this,
+			 * so return with a FW warning instead of crashing
+			 * the bootup:
+			 */
+			WARN_ONCE(1, FW_BUG "Invalid XFEATURE_PKRU configuration.\n");
+			return;
+		}
 		/*
 		 * Setting CR4.PKE will cause the X86_FEATURE_OSPKE cpuid
 		 * bit to be set.  Enforce it.

This is noisy in the syslog, but it's a WARN_ONCE() and it doesn't 
crash the bootup.

Thanks,

	Ingo

