Return-Path: <stable+bounces-103973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD429F059F
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 08:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B82F1884B26
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6C4197A9F;
	Fri, 13 Dec 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/JXoaeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB47188CC9
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075687; cv=none; b=OuwxbLKBZ7/IkitBQjlurTpD6V2uJwvcH9VMSv5as4UShhi2c7ElZ1OEIzhMGeOYsZRKVlfIzF5eDj77GRVXO7l0kQrfeyuSPxYQiePVbbF82vOOT2ZRixHAUrf15tV6bc1xVgL2K7UV7TsUoLMJhTVciP0ZdPzmTgtCIeNGieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075687; c=relaxed/simple;
	bh=lvqUJ7Qds2BkYSqskrqGS75fndgTrpqMGru04p0kLqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gS4L1k8qIa7Ogxk4wSeJ10/uu7lYY62Mr2Hd9PEEgKk0HXBm5ooynnddFWjpxw/QxULqbBUcqvot1qLeTDxTClLyCp6yZUI8mOO53gd9hJnC/aY9ZuHrsLvDbFFFyKr06ZDE56rZ6imcph1m1KIbZOHX4zGI120BYzt4w+KV22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/JXoaeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609E6C4AF09
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 07:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075686;
	bh=lvqUJ7Qds2BkYSqskrqGS75fndgTrpqMGru04p0kLqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R/JXoaeC7RGxR40mgvEm5NmUiKq+ihf4cY7ed2H00nDyQB8wI2pJxbRonXYpD6gYZ
	 oiAc3al59wjRZQn4lPgH07D1nofjDjY3CZIJLn30l+u6E7pT+J67zQ+868zC+iJllO
	 ibDHoLZ2r+sQSg4mqe5Ky/FPa961gTrNwYd2m/svWp/HcpU3krtvCHTJJe/nSceZCO
	 U5gqAdXHkqUpih4e5P2zxvZ86AG1gcsszEaFTFqYxl0RfJmJNqtHQeQUwSR+1Ag207
	 pujb4gEqRMD3sQNF2cKTxV92kw6pUTLfNGQcvVK7s/u0DiYxiCMKJhMTP+co/0cCzf
	 b4hzaRGevGkig==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so10827751fa.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 23:41:26 -0800 (PST)
X-Gm-Message-State: AOJu0YyTdBHa0nJ8GweHC3FGd0s24pX+O8bTjVBMDwtBkD6X0k67/Y9Z
	B0mHo9eKIWWMrTC/8OSScdc9n1ZxxtXmBIhN4lB/02/tjAvukkO3mkfQENGsBxFs9k2k+oLFNzE
	gTkR64wq5mjEB9m/rY0ytnlK8VOc=
X-Google-Smtp-Source: AGHT+IHn+PXTbVJ6SRnhazgkPz0oGtjMB3WUveV3e0JaEsIPX1EA5O/HukSFPrGsGV2CFB2K39mFM/dXlFVcHr4NPVo=
X-Received: by 2002:a2e:bea2:0:b0:300:1aa5:4967 with SMTP id
 38308e7fff4ca-302544cf37dmr5415621fa.25.1734075684672; Thu, 12 Dec 2024
 23:41:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144253.511169641@linuxfoundation.org> <20241212144255.537255677@linuxfoundation.org>
In-Reply-To: <20241212144255.537255677@linuxfoundation.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Dec 2024 08:41:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGBhBj0H=vsn7C3POQwhxxqeELjD0+BDi88mySHF+GgEw@mail.gmail.com>
Message-ID: <CAMj1kXGBhBj0H=vsn7C3POQwhxxqeELjD0+BDi88mySHF+GgEw@mail.gmail.com>
Subject: Re: [PATCH 5.10 051/459] x86/stackprotector: Work around strict Clang
 TLS symbol requirements
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Brian Gerst <brgerst@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Nathan Chancellor <nathan@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

NAK

See other replies re this backport

On Thu, 12 Dec 2024 at 18:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 5.10-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> [ Upstream commit 577c134d311b9b94598d7a0c86be1f431f823003 ]
>
> GCC and Clang both implement stack protector support based on Thread Local
> Storage (TLS) variables, and this is used in the kernel to implement per-task
> stack cookies, by copying a task's stack cookie into a per-CPU variable every
> time it is scheduled in.
>
> Both now also implement -mstack-protector-guard-symbol=, which permits the TLS
> variable to be specified directly. This is useful because it will allow to
> move away from using a fixed offset of 40 bytes into the per-CPU area on
> x86_64, which requires a lot of special handling in the per-CPU code and the
> runtime relocation code.
>
> However, while GCC is rather lax in its implementation of this command line
> option, Clang actually requires that the provided symbol name refers to a TLS
> variable (i.e., one declared with __thread), although it also permits the
> variable to be undeclared entirely, in which case it will use an implicit
> declaration of the right type.
>
> The upshot of this is that Clang will emit the correct references to the stack
> cookie variable in most cases, e.g.,
>
>   10d:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
>                      10f: R_386_32   __stack_chk_guard
>
> However, if a non-TLS definition of the symbol in question is visible in the
> same compilation unit (which amounts to the whole of vmlinux if LTO is
> enabled), it will drop the per-CPU prefix and emit a load from a bogus
> address.
>
> Work around this by using a symbol name that never occurs in C code, and emit
> it as an alias in the linker script.
>
> Fixes: 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://github.com/ClangBuiltLinux/linux/issues/1854
> Link: https://lore.kernel.org/r/20241105155801.1779119-2-brgerst@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/Makefile                     |  3 ++-
>  arch/x86/entry/entry.S                | 15 +++++++++++++++
>  arch/x86/include/asm/asm-prototypes.h |  3 +++
>  arch/x86/kernel/cpu/common.c          |  2 ++
>  arch/x86/kernel/vmlinux.lds.S         |  3 +++
>  5 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 8b9fa777f513b..dcd8c6f676cac 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -90,7 +90,8 @@ ifeq ($(CONFIG_X86_32),y)
>
>         ifeq ($(CONFIG_STACKPROTECTOR),y)
>                 ifeq ($(CONFIG_SMP),y)
> -                       KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
> +                       KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
> +                                        -mstack-protector-guard-symbol=__ref_stack_chk_guard
>                 else
>                         KBUILD_CFLAGS += -mstack-protector-guard=global
>                 endif
> diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
> index f4419afc7147d..23f9efbe9d705 100644
> --- a/arch/x86/entry/entry.S
> +++ b/arch/x86/entry/entry.S
> @@ -48,3 +48,18 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
>
>  .popsection
>
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
> index 5cdccea455544..390b13db24b81 100644
> --- a/arch/x86/include/asm/asm-prototypes.h
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -18,3 +18,6 @@
>  extern void cmpxchg8b_emu(void);
>  #endif
>
> +#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
> +extern unsigned long __ref_stack_chk_guard;
> +#endif
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index bdcf1e9375ee2..f8e5598408bfd 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1974,8 +1974,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
>
>  #ifdef CONFIG_STACKPROTECTOR
>  DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
> +#ifndef CONFIG_SMP
>  EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
>  #endif
> +#endif
>
>  #endif /* CONFIG_X86_64 */
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 740f87d8aa481..60fb61dffe98e 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -490,6 +490,9 @@ SECTIONS
>         ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
>  }
>
> +/* needed for Clang - see arch/x86/entry/entry.S */
> +PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
> +
>  #ifdef CONFIG_X86_32
>  /*
>   * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
> --
> 2.43.0
>
>
>

