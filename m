Return-Path: <stable+bounces-99072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992959E6F2D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E63B1614BD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1672D206F3C;
	Fri,  6 Dec 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnjHwrLO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC91E1C11;
	Fri,  6 Dec 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491033; cv=none; b=DUv8jSDMVUbeyYiQPLLFLMxP2yFXrNBd77I9qaESzG3T6D/Mh+/o2Q6SS1RSXZGE7pkzR8cKUM3Z0FyuPrszSNl1e+ihy4nD/H1bk00Cl5HhFUNUPr8I5up6wpSSANM7NmorxvVjwLrBOiTRy9gZOruAe2rNt3tHzwz15GPE51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491033; c=relaxed/simple;
	bh=W+2lps82yn7GdVsgLHvkw7CIhl5RQOcg6pgyV26KpL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udAAXf4cqr+RUB1Frd4qGSMqdiBVLvjZYjDXnTU7hmzYJA5+FRbNt0MPXCdiONWTqeXOx0igHs6jVEagRYZVi0R+5YS+qwvRX0X33hHP974cR2OIhPSyovhNteW6wmlNYg+3FWrQ+j9s47NwDHDhmFh8N7S156Om/50lKgmtQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnjHwrLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB91C4CEDF;
	Fri,  6 Dec 2024 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733491033;
	bh=W+2lps82yn7GdVsgLHvkw7CIhl5RQOcg6pgyV26KpL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cnjHwrLO5EALvg0HHMP5tf3OGE5gVzifH1vM0F1rVcppuW1N2Zlck0ZYb+d6wN0RI
	 5sd+grFC4Ox+sie/C/R3dAC7/nNExYXGLrxks51XslXgTpttmuMW2URpavx9xpPplf
	 JJxL/+bVBlsyWNwkjR9o6/rQhkZb0hye/PssovpNZCc00YT/qZiFM6fae4aa5RL4sH
	 doqSN+05X6ArlVurm2aGeEbsczmY5JhB/h4YO61S0rC8jLox3JiUuJRmUWQousp1Dd
	 mYySHKziqjURpLWMJ8M39f0zbSabqeCmP8pWD1KB4nDkCmi51gH4aOeHKa+RPlFnVV
	 cjieVizqIpsuQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e0844ee50so2149013e87.0;
        Fri, 06 Dec 2024 05:17:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4JP41QDPXP79/24abfSE2b7+nkpkRy/mxDEoARMAw/OugP/1c3XXhtXohtntpYUfgEPaxr5p+@vger.kernel.org, AJvYcCXByyQWE6eTueyz2mn7yRReDkHgM3UayAmKHy7El3ECdqtz/TygdfFAXF78WaOkctpgok8135pU/muL5co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQwTH0YhZHpVjdQ9C7jMAVnoUxtkUIzyrgOknfDZfftrH3vAn
	/SKFSAztw+udFV/Iu2XioVJWIuVmDo7w4jXDV5t9GdKPMTL2Kq4a00RwgvWghVy17Hl8cvt1ns4
	cfTTBJoafpQ9+KL2JmoIKqAd3bKg=
X-Google-Smtp-Source: AGHT+IF7tUMRg52WWaAz6X12GM5qKhJYLqIJ2WOfMXjwuEOmJoTBVKqRvTAOkkyXnsHhE1w1Qaa7PKZGl2A4P9tHVIQ=
X-Received: by 2002:a05:6512:2822:b0:53e:2306:6dd6 with SMTP id
 2adb3069b0e04-53e2c2c4eaemr898595e87.31.1733491031769; Fri, 06 Dec 2024
 05:17:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-2-brgerst@gmail.com>
 <20241206123207.GA2091@redhat.com>
In-Reply-To: <20241206123207.GA2091@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 6 Dec 2024 14:17:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGKCJfBVqgsqjX1bA_SY=503Z-tJV893y5JAwoVs0BUfw@mail.gmail.com>
Message-ID: <CAMj1kXGKCJfBVqgsqjX1bA_SY=503Z-tJV893y5JAwoVs0BUfw@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
To: Oleg Nesterov <oleg@redhat.com>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 13:32, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Add the necessary '#ifdef CONFIG_STACKPROTECTOR' into
> arch/x86/kernel/vmlinux.lds.S
>
> Fixes: 577c134d311b ("x86/stackprotector: Work around strict Clang TLS symbol requirements")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index fab3ac9a4574..2ff48645bab9 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -472,8 +472,10 @@ SECTIONS
>  . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
>            "kernel image bigger than KERNEL_IMAGE_SIZE");
>
> +#ifdef CONFIG_STACKPROTECTOR
>  /* needed for Clang - see arch/x86/entry/entry.S */
>  PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
> +#endif
>
>  #ifdef CONFIG_X86_64
>  /*

This shouldn't be necessary - PROVIDE() is only evaluated if a
reference exists to the symbol it defines.

Also, I'm failing to reproduce this. Could you share your .config,
please, and the error that you get during the build?

