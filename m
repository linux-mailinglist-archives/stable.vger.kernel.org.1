Return-Path: <stable+bounces-151417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD0ACDFD2
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA79916A5B6
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F0C28F53F;
	Wed,  4 Jun 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXv44fZ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F029009A;
	Wed,  4 Jun 2025 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045952; cv=none; b=t50tOZu0ftmpvjlU5xIcBOwBYWktx9axzSXQ+f8DdEC6vSpdm38M0wOxsMjLVGyaAlPU1tvoecxORffrbVbqBMHzo9x37AZsZu4F17z6oY/2ET+/FLTD0uGL9+aT3iG9gzQ3SXzxZ+e3ONJVemcRYP8x4uQ6NvwZaypDPXr2SJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045952; c=relaxed/simple;
	bh=IIEwGMNU/iJrUu7/3CwdVOUWTk7lAwMeHyQc/py9Ccg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPkMg4FOtMNv0UrQPYHkfA5YROY5kzo8s5otfIOLlnwdT/Pxd6+chJSrrKCihokwCorBZrGOZRHUY7f6iy6OVKEK4BUDIjdeTe/0/92hwGTzDBgsNBW578e3Ax0rCS9RBLx9+qR2o6CpFueZU1RabN2HiZKk95aG2WT2P1479D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXv44fZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFF0C4AF0B;
	Wed,  4 Jun 2025 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749045951;
	bh=IIEwGMNU/iJrUu7/3CwdVOUWTk7lAwMeHyQc/py9Ccg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YXv44fZ0Sr4s/P77xwDWM3bl+et2NQKht5j2jXoEX7yG3Eb/UtkVmKaiHHWaUB9v8
	 pJXXUkBke75VXdJPUmIfxipVu2+83CiMConF36hFMxRKyHRv0QCZA+JIwmG3dQRuVA
	 8kZdxz6G/aiqVvfTX1Aq0GmkXa7fPXDY6Qt39+1VB7XnuKf6KyD28IGbCpp50cL2XD
	 lsqvyCGCnbs5z+dx7GYJ6ZxRvM4Y+jmot4hjUu7Y2/vdmkEBUq/PdCfg8GdtunYAd2
	 +WCBSbOFnVHpLgVnXQByT23u1jd31PlAqg5NZbDroRwqAgNwoduwYrZong1X+jdoQx
	 PnsL1rGIH027A==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so7993658a12.2;
        Wed, 04 Jun 2025 07:05:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAWuVDXx3s83CKNpi5fz2Km7U+kcX94RBZ69rE0AFlM4Hkz+yV7QBBFJl9t7nakkSp0VPA4cDG@vger.kernel.org, AJvYcCXCa7IhxRjpJRYPnf3k3Au1eeVP8o5ix9TF1qDmTIBUY4ijepj71UZ4ubjovAYY7nT1GjuDvGVgrkdd5pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxteLgmecjqUXL9rpUnUDHUqZyYYde5iSJId3SxMqmCrDnyGrAs
	X9oHpVfp9dzwq8gN8KMz/sAaMFTXtauWqunvwfaXofD4t26C0l8GLNY6Tn6pZsQCH8DMtnRrjW+
	72p2Xd7lh2Y7nVFGuko4pdOiRbqaYxKE=
X-Google-Smtp-Source: AGHT+IHzLrFJ0tDCiOZ2aUxsctyLKXzDo7JOd/wEZA10wfKlrAyYi5vIntUo8b7ssgCiiur5CYeoKuJbXK6hT8b9IDw=
X-Received: by 2002:a05:6402:2351:b0:607:1973:2082 with SMTP id
 4fb4d7f45d1cf-6071973209cmr498604a12.11.1749045950321; Wed, 04 Jun 2025
 07:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-loongarch-vdso-syscall-v1-1-6d12d6dfbdd0@linutronix.de>
In-Reply-To: <20250603-loongarch-vdso-syscall-v1-1-6d12d6dfbdd0@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 4 Jun 2025 22:05:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Ba7DMV6AvGnvNBJ8FL_YcHjeeHYZWw2NG6JHL=X4PkQ@mail.gmail.com>
X-Gm-Features: AX0GCFvKA_KKer2m4iG2-t1TsphfY807WvqIwtlUIzYSRATglAOWgOM5PL3hSDQ
Message-ID: <CAAhV-H4Ba7DMV6AvGnvNBJ8FL_YcHjeeHYZWw2NG6JHL=X4PkQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: vDSO: correctly use asm parameters in syscall wrappers
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: WANG Xuerui <kernel@xen0n.name>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 7:49=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> The syscall wrappers use the "a0" register for two different register
> variables, both the first argument and the return value. The "ret"
> variable is used as both input and output while the argument register is
> only used as input. Clang treats the conflicting input parameters as
> undefined behaviour and optimizes away the argument assignment.
>
> The code seems to work by chance for the most part today but that may
> change in the future. Specifically clock_gettime_fallback() fails with
> clockids from 16 to 23, as implemented by the upcoming auxiliary clocks.
>
> Switch the "ret" register variable to a pure output, similar to the other
> architectures' vDSO code. This works in both clang and GCC.
Hmmm, at first the constraint is "=3Dr", during the progress of
upstream, Xuerui suggested me to use "+r" instead [1].
[1]  https://lore.kernel.org/linux-arch/5b14144a-9725-41db-7179-c059c41814c=
f@xen0n.name/

Huacai

>
> Link: https://lore.kernel.org/lkml/20250602102825-42aa84f0-23f1-4d10-89fc=
-e8bbaffd291a@linutronix.de/
> Link: https://lore.kernel.org/lkml/20250519082042.742926976@linutronix.de=
/
> Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
> Fixes: 18efd0b10e0f ("LoongArch: vDSO: Wire up getrandom() vDSO implement=
ation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/loongarch/include/asm/vdso/getrandom.h    | 2 +-
>  arch/loongarch/include/asm/vdso/gettimeofday.h | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch=
/include/asm/vdso/getrandom.h
> index 48c43f55b039b42168698614d0479b7a872d20f3..a81724b69f291ee49dd1f46b1=
2d6893fc18442b8 100644
> --- a/arch/loongarch/include/asm/vdso/getrandom.h
> +++ b/arch/loongarch/include/asm/vdso/getrandom.h
> @@ -20,7 +20,7 @@ static __always_inline ssize_t getrandom_syscall(void *=
_buffer, size_t _len, uns
>
>         asm volatile(
>         "      syscall 0\n"
> -       : "+r" (ret)
> +       : "=3Dr" (ret)
>         : "r" (nr), "r" (buffer), "r" (len), "r" (flags)
>         : "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8",
>           "memory");
> diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loonga=
rch/include/asm/vdso/gettimeofday.h
> index 88cfcf13311630ed5f1a734d23a2bc3f65d79a88..f15503e3336ca1bdc9675ec6e=
17bbb77abc35ef4 100644
> --- a/arch/loongarch/include/asm/vdso/gettimeofday.h
> +++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
> @@ -25,7 +25,7 @@ static __always_inline long gettimeofday_fallback(
>
>         asm volatile(
>         "       syscall 0\n"
> -       : "+r" (ret)
> +       : "=3Dr" (ret)
>         : "r" (nr), "r" (tv), "r" (tz)
>         : "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
>           "$t8", "memory");
> @@ -44,7 +44,7 @@ static __always_inline long clock_gettime_fallback(
>
>         asm volatile(
>         "       syscall 0\n"
> -       : "+r" (ret)
> +       : "=3Dr" (ret)
>         : "r" (nr), "r" (clkid), "r" (ts)
>         : "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
>           "$t8", "memory");
> @@ -63,7 +63,7 @@ static __always_inline int clock_getres_fallback(
>
>         asm volatile(
>         "       syscall 0\n"
> -       : "+r" (ret)
> +       : "=3Dr" (ret)
>         : "r" (nr), "r" (clkid), "r" (ts)
>         : "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
>           "$t8", "memory");
>
> ---
> base-commit: 546b1c9e93c2bb8cf5ed24e0be1c86bb089b3253
> change-id: 20250603-loongarch-vdso-syscall-f585a99bea03
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>

