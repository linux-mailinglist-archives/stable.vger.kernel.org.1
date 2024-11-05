Return-Path: <stable+bounces-89920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D833C9BD5DF
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 20:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A961F23395
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946252022FA;
	Tue,  5 Nov 2024 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hj0eMOvF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4E201278;
	Tue,  5 Nov 2024 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835057; cv=none; b=rG0yo2zE65g1jc5oQO1oY9/yn+8MS8vql/bAQn0sgsFW5EGtAgYkUfakjl66PxC53PyHn28ueEcZTMvAcGPj91FjJFr7qHo12BQXG4Od8epHiepCNvnlL4RakH0Xq4nUbgny8QhKK1Jn/nYE4+HI+X8R6wUKzvqALFnrNLeUuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835057; c=relaxed/simple;
	bh=ZQOWG60wEyTniaPcAjViHBQcAhVnAgLXozzoU1MMhgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrbWMQR6nurF/UNSm/rmXkjIF1JadgASLu65vnUlXxuHe5/YluTjcDtw+/hjKMeA4PulwjKLNICpgYb7PHTSF8fI01YCSwrFXXXmVe5CwkgMf+6V0HCVzJEm7fVmbtrC3XQWKWUOZxFl1fUwa+CGuvgIfEtA5k4Z+PKxqdtSaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hj0eMOvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE1AC4CECF;
	Tue,  5 Nov 2024 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730835056;
	bh=ZQOWG60wEyTniaPcAjViHBQcAhVnAgLXozzoU1MMhgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hj0eMOvF79w9Fgzm9nFH4KX8NCPfvOQ6upP+8rRKTm9KdzF0no1Mp2BhoSoNb3ye6
	 FX4cyjUhhPKA9Q+LL9gTL8IvJenI8zdTZusRBd0C47q5AmXJB+H5cAceRxJLW6R8/Z
	 FVw9m+O65PlxGjD2e7uA02mz4xUmsFDutz89nx9/pF7tPNfnpXCeID3TqXpgl/CoQQ
	 mxSH+t04APPx1pGcgg4lCUG13rArOr64ySQjkh1Am8WgQpzCGpLUr8wXd24yVSRjhI
	 XRo64XiJd4az5HsaKlxtBUNaZjLWxZoHchH77DIXsoQZ40c68CxOlGVwhtw9db8WSP
	 V55oumlklOeIA==
Date: Tue, 5 Nov 2024 12:30:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v5 01/16] x86/stackprotector: Work around strict Clang
 TLS symbol requirements
Message-ID: <20241105193054.GA927577@thelio-3990X>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <20241105155801.1779119-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105155801.1779119-2-brgerst@gmail.com>

On Tue, Nov 05, 2024 at 10:57:46AM -0500, Brian Gerst wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> GCC and Clang both implement stack protector support based on Thread
> Local Storage (TLS) variables, and this is used in the kernel to
> implement per-task stack cookies, by copying a task's stack cookie into
> a per-CPU variable every time it is scheduled in.
> 
> Both now also implement -mstack-protector-guard-symbol=, which permits
> the TLS variable to be specified directly. This is useful because it
> will allow us to move away from using a fixed offset of 40 bytes into
> the per-CPU area on x86_64, which requires a lot of special handling in
> the per-CPU code and the runtime relocation code.
> 
> However, while GCC is rather lax in its implementation of this command
> line option, Clang actually requires that the provided symbol name
> refers to a TLS variable (i.e., one declared with __thread), although it
> also permits the variable to be undeclared entirely, in which case it
> will use an implicit declaration of the right type.
> 
> The upshot of this is that Clang will emit the correct references to the
> stack cookie variable in most cases, e.g.,
> 
>    10d:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
>                       10f: R_386_32   __stack_chk_guard
> 
> However, if a non-TLS definition of the symbol in question is visible in
> the same compilation unit (which amounts to the whole of vmlinux if LTO
> is enabled), it will drop the per-CPU prefix and emit a load from a
> bogus address.
> 
> Work around this by using a symbol name that never occurs in C code, and
> emit it as an alias in the linker script.
> 
> Fixes: 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")
> Cc: <stable@vger.kernel.org>
> Cc: Fangrui Song <i@maskray.me>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1854
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

From https://lore.kernel.org/20241016021045.GA1000009@thelio-3990X/:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/Makefile                     |  5 +++--
>  arch/x86/entry/entry.S                | 16 ++++++++++++++++
>  arch/x86/include/asm/asm-prototypes.h |  3 +++
>  arch/x86/kernel/cpu/common.c          |  2 ++
>  arch/x86/kernel/vmlinux.lds.S         |  3 +++
>  5 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index cd75e78a06c1..5b773b34768d 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -142,9 +142,10 @@ ifeq ($(CONFIG_X86_32),y)
>  
>      ifeq ($(CONFIG_STACKPROTECTOR),y)
>          ifeq ($(CONFIG_SMP),y)
> -			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
> +            KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
> +                             -mstack-protector-guard-symbol=__ref_stack_chk_guard
>          else
> -			KBUILD_CFLAGS += -mstack-protector-guard=global
> +            KBUILD_CFLAGS += -mstack-protector-guard=global
>          endif
>      endif
>  else
> diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
> index 324686bca368..b7ea3e8e9ecc 100644
> --- a/arch/x86/entry/entry.S
> +++ b/arch/x86/entry/entry.S
> @@ -51,3 +51,19 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
>  .popsection
>  
>  THUNK warn_thunk_thunk, __warn_thunk
> +
> +#ifndef CONFIG_X86_64
> +/*
> + * Clang's implementation of TLS stack cookies requires the variable in
> + * question to be a TLS variable. If the variable happens to be defined as an
> + * ordinary variable with external linkage in the same compilation unit (which
> + * amounts to the whole of vmlinux with LTO enabled), Clang will drop the
> + * segment register prefix from the references, resulting in broken code. Work
> + * around this by avoiding the symbol used in -mstack-protector-guard-symbol=
> + * entirely in the C code, and use an alias emitted by the linker script
> + * instead.
> + */
> +#ifdef CONFIG_STACKPROTECTOR
> +EXPORT_SYMBOL(__ref_stack_chk_guard);
> +#endif
> +#endif
> diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
> index 25466c4d2134..3674006e3974 100644
> --- a/arch/x86/include/asm/asm-prototypes.h
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -20,3 +20,6 @@
>  extern void cmpxchg8b_emu(void);
>  #endif
>  
> +#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
> +extern unsigned long __ref_stack_chk_guard;
> +#endif
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 8f41ab219cf1..9d42bd15e06c 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2091,8 +2091,10 @@ void syscall_init(void)
>  
>  #ifdef CONFIG_STACKPROTECTOR
>  DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
> +#ifndef CONFIG_SMP
>  EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
>  #endif
> +#endif
>  
>  #endif	/* CONFIG_X86_64 */
>  
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 410546bacc0f..d61c3584f3e6 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -468,6 +468,9 @@ SECTIONS
>  . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
>  	   "kernel image bigger than KERNEL_IMAGE_SIZE");
>  
> +/* needed for Clang - see arch/x86/entry/entry.S */
> +PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
> +
>  #ifdef CONFIG_X86_64
>  /*
>   * Per-cpu symbols which need to be offset from __per_cpu_load
> -- 
> 2.47.0
> 

