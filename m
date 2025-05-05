Return-Path: <stable+bounces-140205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE294AAA61D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5E516A17C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A07131F055;
	Mon,  5 May 2025 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAu1JNXo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9631F05A;
	Mon,  5 May 2025 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484338; cv=none; b=roZkQZKDfE8malsxzmAmRdomkSms5a/77WKWEf5HFguEvIZrhZb13phbx0VMj5AzVUar/I8z2xUOmQs0OKtXqEl8zsf2cKh99w81ksJCjPJx7php8IJjqu7mZDD77nUzv018B1fZ0AXXnT9ceN6SSHjyelruo8qYp4OXEICjt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484338; c=relaxed/simple;
	bh=aWwkPj6JIZPJ12ijNcUYfCCvAOBlK+qnpbAZ0dtBuSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwjZuQpIhAq6WxehGHjh0IdjEZl3kN6wnS2Nol5u6/0g4XgaIoPJWfkWCEStAklWRy1WqMk+ZVA0TW7Ek3vH85Ai9foKSjxGquGLJr83g99ThdmK4gzNiUqs4Jz8tGfWe6o6C5v6VxpEebqG6jU3q54NqLOXXwsx8sEP7jewhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAu1JNXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D33C4CEED;
	Mon,  5 May 2025 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484338;
	bh=aWwkPj6JIZPJ12ijNcUYfCCvAOBlK+qnpbAZ0dtBuSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sAu1JNXotXEwuUsnuvyW/nQiQPS1sZoMx40TpDfz1gpQhfeAiQI+m9754c73hLPdT
	 OJULor3n7eP1ZSxrvgEK3vftHGEH+IF7Aa733yKEN/Z8cG3zruy6PBV7Beng73M3dF
	 GHXIodjdDANRZVw2PgCGeR5LzswqTLwMF9Wd0eNTYoYX4P4i693EE7YXsKBaeW8LxX
	 Yqez9sxZdwoiJz4I4+Gh6aUk187OIKyUpWOuEL9CwM/BFTkovbGdNptSedqV5Qjtrg
	 TKIqhDXMuMADQ03EP4zYV9MG+GUjLRByTo47EAzSM1jCP7yNDb4aDVRJSQxI02uOML
	 89SC4u5WM/+PQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3105ef2a06cso47748971fa.2;
        Mon, 05 May 2025 15:32:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuarNdq8TRW+e+DVU/Rxzbt3Jugwrk0W3+8AMhj4X0r5vkQt25y5NkVAXi+Zr30iUF7mkseLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhioywc/xoiy926pIsiaPfvUF6xm5kGmbQEBQJQznLFosMnOjI
	/tAjiphH8YVlblVIpF03GQuQ0uHMuu9c9pGBFUJcBpGmSU/X6Qsa1/2TOrPEDQMRN/p86T+9gxK
	9DU7a4P6SBQ8e1kF9/Ru3v9sGc+E=
X-Google-Smtp-Source: AGHT+IGZPEdy4d5fs2vkYk9CSAe2Oj8skd9Oz00HKf8ZahGb+jEF8RkEAovv9ahgTsLBUwVJyNy2paElHXC6LQymzcg=
X-Received: by 2002:a05:6512:234f:b0:54d:6aa1:8f5a with SMTP id
 2adb3069b0e04-54fb4a5d314mr217077e87.13.1746484336579; Mon, 05 May 2025
 15:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505221419.2672473-1-sashal@kernel.org> <20250505221419.2672473-400-sashal@kernel.org>
In-Reply-To: <20250505221419.2672473-400-sashal@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 6 May 2025 00:32:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF6=t9NoH5Lsh4=RwhUTHtpBt9VmZr3bEVm6=1zGiOf2w@mail.gmail.com>
X-Gm-Features: ATxdqUErh1T2txHfXNjzmhH5BJ_P7lEmzSx0aae_jJOJZrFCc7iYj59jh6IImPo
Message-ID: <CAMj1kXF6=t9NoH5Lsh4=RwhUTHtpBt9VmZr3bEVm6=1zGiOf2w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 400/642] x86/relocs: Handle
 R_X86_64_REX_GOTPCRELX relocations
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, nathan@kernel.org, 
	ubizjak@gmail.com, thomas.weissschuh@linutronix.de, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 00:30, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Brian Gerst <brgerst@gmail.com>
>
> [ Upstream commit cb7927fda002ca49ae62e2782c1692acc7b80c67 ]
>
> Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
> stack protector location.  Treat them as another type of PC-relative
> relocation.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/20250123190747.745588-6-brgerst@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch was one of a series of about 20 patches. Did you pick all of them?


> ---
>  arch/x86/tools/relocs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index e937be979ec86..92a1e503305ef 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -32,6 +32,11 @@ static struct relocs         relocs32;
>  static struct relocs           relocs32neg;
>  static struct relocs           relocs64;
>  # define FMT PRIu64
> +
> +#ifndef R_X86_64_REX_GOTPCRELX
> +# define R_X86_64_REX_GOTPCRELX 42
> +#endif
> +
>  #else
>  # define FMT PRIu32
>  #endif
> @@ -227,6 +232,7 @@ static const char *rel_type(unsigned type)
>                 REL_TYPE(R_X86_64_PC16),
>                 REL_TYPE(R_X86_64_8),
>                 REL_TYPE(R_X86_64_PC8),
> +               REL_TYPE(R_X86_64_REX_GOTPCRELX),
>  #else
>                 REL_TYPE(R_386_NONE),
>                 REL_TYPE(R_386_32),
> @@ -861,6 +867,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
>
>         case R_X86_64_PC32:
>         case R_X86_64_PLT32:
> +       case R_X86_64_REX_GOTPCRELX:
>                 /*
>                  * PC relative relocations don't need to be adjusted unless
>                  * referencing a percpu symbol.
> --
> 2.39.5
>

