Return-Path: <stable+bounces-40219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A80348AA417
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 22:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFDC1F21EB9
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 20:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69497190672;
	Thu, 18 Apr 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCIu2P61"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43AF2E416
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472601; cv=none; b=QsiuQEks67d1kjwJYPgYBZn+PlZlU3rvB0g0OhIWxgYyu8VGSRWeocAJBMW/pii4c5a3+t9GDeTcOMb/mN+dUKradDnZmHkKJ5mo4b9UtDcWbuX69Vg4TbOKCnHu1Pc8fGEE+vctLLpcmIYlN1qfa6LrP/ulNVKRA+tCuByHp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472601; c=relaxed/simple;
	bh=Mh9F5g+oXDReUBU4BN7gIrjCxYn7HhvawXsn2aMyfys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHkyukCT1bArhAbowXHEWwS8zKG9ABbKD57dZhpPcLwnjk/4Oy+I+Fh5Nwi9fjT9TKiND2HzHZnKsnGJiNg87LB8zn2/LcYBsqnvcRpDH0sjPzq2AWRxUgx0wFHDVKhzl3SaZ3BbeF27o9Y6mUwZQKPOY37ycuu3ddWW9HG2bjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iCIu2P61; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-418f1d77adaso6790135e9.2
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713472597; x=1714077397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPfiNmCGro4QcNjJ3nhSDpGjz+OaJx9a/1wRIxpFgzM=;
        b=iCIu2P61J+hhXakJ7d+xXEVgSSM7nIV2x9JOrQjUVsxNu+C4DOjSgJr9J0Hw7RjYDz
         gHjtItDWLGkAZr4rBVuHHMmpRFE1dCwTR57qg0GyiAs3Ft7GSwK8LFn/ZvhvUhg1gYKi
         m1C3M8vsWa3I1E/Xb9daTi6P369kEEr0t+1e5yXPSQvcA5wc0uAdYH9du5syViNYk0ki
         BOLbGegpCN9T2zIpM4FFzu3iOOxy36nh5gBlRjneNL/q/uHdiDBG46wmEfWyzmM9ySVs
         2feYtQnDqWYQu5iQ5Ho47SvJNE2mzdZV06iTEjNX/QbcCvsbe2DrwoZHN/PnHph6WBzL
         ogDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472597; x=1714077397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPfiNmCGro4QcNjJ3nhSDpGjz+OaJx9a/1wRIxpFgzM=;
        b=P0rlDbEBwDDLadiq8VGLi4R/NchkKurA7KFltNGZ1tT4/rWabuv5p1D3AeHtRHDRu7
         GH44sE1GSD/OeCMLUABG+zjOJu4YeDl/SO1Jxx8K3asPzcyJ6ja7VUznAqt6k7zCJ2Fo
         vsOXI8ZNgUnbATqKcTUpRSqAv79BknB3Jz4PmGwsNCjZ2gZs+cCUEkqk77SImav+VyvW
         W1ehRW7r4tb1wB0RFfj+x6Bu/P5tSbQ/UT3faUdQCMreAckoLmRXRxYaP5VMcvSpLU/7
         a56Wni0Ujd8ZkHXfsIzK7YNkFTqxcYmP1VD2Trp/TraVo7LSClUQNs06lZWd5GD3//y5
         OAkw==
X-Forwarded-Encrypted: i=1; AJvYcCUCIrIyeysSzZVi2j2eKZnsTu0NYUK14jRBVgCI0Bi4PIkF0RhWY5Hcz03tQqBJnLtrKLEvLeBA0hA/iy8RLMxc+s0LuZYm
X-Gm-Message-State: AOJu0YyViRI6DKBB4pxDVSEuzLa7WydeHOqKuGWON8v9oZXIC8fvUX/v
	3ndJL9C8tbLrW0GR0K6TXuyDtNlKR4SKb3hLMoC/XYqaB9ouNTtzLvplQHRvc3JsRwrm3R8V9fN
	F1NWPJprfZ/sIRZIwSqSjbvFWFX+kHaGdHwG7
X-Google-Smtp-Source: AGHT+IEklnrO2WDKzaHiHi1PW4ToHeoh/2oQmHUuqMoeV/OGXWxyGt114S8v7P7qexVSDvkVt7+5mI6IM3kvYQJn1V0=
X-Received: by 2002:adf:a495:0:b0:341:d6c3:5c4f with SMTP id
 g21-20020adfa495000000b00341d6c35c4fmr32719wrb.21.1713472596846; Thu, 18 Apr
 2024 13:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418201705.3673200-2-ardb+git@google.com>
In-Reply-To: <20240418201705.3673200-2-ardb+git@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 18 Apr 2024 13:36:22 -0700
Message-ID: <CAKwvOdnNurTJNb7iOVW4dpkV-rZGWg2t3HuLkL+B5sNOin39WA@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Song Liu <song@kernel.org>, 
	Ricardo Ribalda <ribalda@kernel.org>, Fangrui Song <maskray@google.com>, 
	Arthur Eubanks <aeubanks@google.com>, stable@vger.kernel.org, 
	Steve Wahl <steve.wahl@hpe.com>, Vaibhav Rustagi <vaibhavrustagi@google.com>, 
	Andreas Smas <andreas@lonelycoder.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:17=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> On x86, the ordinary, position dependent 'small' and 'kernel' code models=
 only
> support placement of the executable in 32-bit addressable memory, due to
> the use of 32-bit signed immediates to generate references to global
> variables. For the kernel, this implies that all global variables must
> reside in the top 2 GiB of the kernel virtual address space, where the
> implicit address bits 63:32 are equal to sign bit 31.
>
> This means the kernel code model is not suitable for other bare metal
> executables such as the kexec purgatory, which can be placed arbitrarily
> in the physical address space, where its address may no longer be
> representable as a sign extended 32-bit quantity. For this reason,
> commit
>
>   e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=3Dker=
nel to -mcmodel=3Dlarge to fix kexec relocation errors")
>
> switched to the 'large' code model, which uses 64-bit immediates for all
> symbol references, including function calls, in order to avoid relying
> on any assumptions regarding proximity of symbols in the final
> executable.
>
> The large code model is rarely used, clunky and the least likely to
> operate in a similar fashion when comparing GCC and Clang, so it is best
> avoided. This is especially true now that Clang 18 has started to emit
> executable code in two separate sections (.text and .ltext), which
> triggers an issue in the kexec loading code at runtime.
>
> Instead, use the position independent small code model, which makes no
> assumptions about placement but only about proximity, where all
> referenced symbols must be within -/+ 2 GiB, i.e., in range for a
> RIP-relative reference. Use hidden visibility to suppress the use of a
> GOT, which carries absolute addresses that are not covered by static ELF
> relocations, and is therefore incompatible with the kexec loader's
> relocation logic.
>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>

Thanks Ard!

Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: ns <0n-s@users.noreply.github.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2016
Fixes: e16c2983fba0 ("x86/purgatory: Change compiler flags from
-mcmodel=3Dkernel to -mcmodel=3Dlarge to fix kexec relocation errors")

(I don't have a kexec setup ready to go; maybe someone that does can
help test it.)

> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Ricardo Ribalda <ribalda@kernel.org>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Arthur Eubanks <aeubanks@google.com>
> Link: https://lore.kernel.org/all/20240417-x86-fix-kexec-with-llvm-18-v1-=
0-5383121e8fb7@kernel.org/
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/purgatory/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index bc31863c5ee6..a18591f6e6d9 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -42,7 +42,8 @@ KCOV_INSTRUMENT :=3D n
>  # make up the standalone purgatory.ro
>
>  PURGATORY_CFLAGS_REMOVE :=3D -mcmodel=3Dkernel
> -PURGATORY_CFLAGS :=3D -mcmodel=3Dlarge -ffreestanding -fno-zero-initiali=
zed-in-bss -g0
> +PURGATORY_CFLAGS :=3D -mcmodel=3Dsmall -ffreestanding -fno-zero-initiali=
zed-in-bss -g0
> +PURGATORY_CFLAGS +=3D -fpic -fvisibility=3Dhidden
>  PURGATORY_CFLAGS +=3D $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFI=
LING
>  PURGATORY_CFLAGS +=3D -fno-stack-protector
>
> --
> 2.44.0.769.g3c40516874-goog
>


--=20
Thanks,
~Nick Desaulniers

