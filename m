Return-Path: <stable+bounces-151521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC021ACEE6D
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 13:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D871177A85
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947E43C465;
	Thu,  5 Jun 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnaInRd9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F629A2;
	Thu,  5 Jun 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122335; cv=none; b=Th238j3xChZhCk7tPRaI5mJL2jwiuTYQjSvSKtdn3oBLnZITT0Mt4+j1qtaHQi567ZMmm4J+/aYJvaFsxlOMvTJnw40eT280jwUhrwjSTNJWRJ8Ch2DSJjl/luqpeOI8bd+PJoc/k+SGgZ3ich4vDi0YRTZLGhoABb286O3UXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122335; c=relaxed/simple;
	bh=sEF2Wh91g+2MAiwlPUrHuJSSHBGA3izZZAqjWgbw5vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADJK8t2JG0RmwirOoTpwYi8ukcVEOdqDJzKdhPp9WrHpJD9+FfKha/n1YINPv2hO5+qAwznlBZgadLRpmPfZpRn8iliAV7iTKJKV7e1GgGz5DhRpRfzBYivvBD6nXtogqARRZjTouMGRAoQS2+Sh9yKTFsY29dzzmpPcUypnBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnaInRd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD14C4CEEE;
	Thu,  5 Jun 2025 11:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749122335;
	bh=sEF2Wh91g+2MAiwlPUrHuJSSHBGA3izZZAqjWgbw5vk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nnaInRd9srmOfTHdxWD5f9eq81ZcmX83BJ7FI82YSPRwojBRZ4PBYy4vBKnkIrB3a
	 WT6cQvaa8rzhz8cK4Zg64j/U7S0O0804nH4J2pyDMGfwvGO1CRw1TzlfzQYP5oixcD
	 yduoW9hTv0PqncUMAghXjTwYKekK7+HST8UhGSVN6vcONWnuYSD86dtp5ju/gOH0el
	 rM290P3ry7FMXYwmVYq8I7N50RY3ZT2beUV04fDLYwUD8rnzC7kS3+sgVw7s20u6P/
	 Rv04LPevSRGSEhBLvRytmf47+rrNu6iJpJIHWmaPfHN3wE2+0Ubr0pThPPZ+EO0VXx
	 G+TqdW6MkPPkA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad88d77314bso167037766b.1;
        Thu, 05 Jun 2025 04:18:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxTsvxw1KoXBMepyB1ZM7Okgdw1ViQNFq057kRZS0rm55RcikK8jT4d8Ebyn6DhUmQDJeqayMu@vger.kernel.org, AJvYcCXOzpir7nYdCVH6Jlr5NThdNyGZ8nkxAII6Mu8InqnBGG9rISbw2BeK0D/0Yf6aVh5sQi83R5rOOZlUHwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5WkeRtrx2Gp5YV8l3GbWGtwmdfkZ6dBX+fnvcpuCJbkF+F7b
	iV5Cv1a9WaOhfxi7mBhqg0iEaJfiOz9gsHsckPvIVGl7ENTbUoMyOIzaXHENwG5C74s1GyDIHCc
	2RUG8LanOLnXn2vdN8aNKX7RERCqM2BI=
X-Google-Smtp-Source: AGHT+IGC5Decy1JDZOZPWzuYA+Z4FxX8IFqU5x0RGGVN+b3H9/e4EjYtTrXycJOoTxMxkeqG3JLtTqu/qlQohmyQy/Q=
X-Received: by 2002:a17:907:3da3:b0:ad8:a41a:3cdc with SMTP id
 a640c23a62f3a-addf8c98fbbmr637680066b.2.1749122333746; Thu, 05 Jun 2025
 04:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-loongarch-vdso-syscall-v1-1-6d12d6dfbdd0@linutronix.de>
 <CAAhV-H4Ba7DMV6AvGnvNBJ8FL_YcHjeeHYZWw2NG6JHL=X4PkQ@mail.gmail.com>
 <5a5329feaab84acb91bbb4f48ea548b3fb4eab0f.camel@xry111.site> <20250605092735-bd76e803-e896-4d4c-a1f1-c30f8d321a9a@linutronix.de>
In-Reply-To: <20250605092735-bd76e803-e896-4d4c-a1f1-c30f8d321a9a@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 5 Jun 2025 19:18:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H68vDzU7XPefDYG+MRMs560q8o2GhiqYRm1hsA+3DND3A@mail.gmail.com>
X-Gm-Features: AX0GCFtDn_nikl0og6nMjd-vJWnNxYltI6wUf_W_Ll6MRRjnSmv1DM1kurWk8GI
Message-ID: <CAAhV-H68vDzU7XPefDYG+MRMs560q8o2GhiqYRm1hsA+3DND3A@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: vDSO: correctly use asm parameters in syscall wrappers
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Xi Ruoyao <xry111@xry111.site>, WANG Xuerui <kernel@xen0n.name>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 3:37=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Wed, Jun 04, 2025 at 10:30:55PM +0800, Xi Ruoyao wrote:
> > On Wed, 2025-06-04 at 22:05 +0800, Huacai Chen wrote:
> > > On Tue, Jun 3, 2025 at 7:49=E2=80=AFPM Thomas Wei=C3=9Fschuh
> > > <thomas.weissschuh@linutronix.de> wrote:
> > > >
> > > > The syscall wrappers use the "a0" register for two different regist=
er
> > > > variables, both the first argument and the return value. The "ret"
> > > > variable is used as both input and output while the argument regist=
er is
> > > > only used as input. Clang treats the conflicting input parameters a=
s
> > > > undefined behaviour and optimizes away the argument assignment.
> > > >
> > > > The code seems to work by chance for the most part today but that m=
ay
> > > > change in the future. Specifically clock_gettime_fallback() fails w=
ith
> > > > clockids from 16 to 23, as implemented by the upcoming auxiliary cl=
ocks.
> > > >
> > > > Switch the "ret" register variable to a pure output, similar to the=
 other
> > > > architectures' vDSO code. This works in both clang and GCC.
> > > Hmmm, at first the constraint is "=3Dr", during the progress of
> > > upstream, Xuerui suggested me to use "+r" instead [1].
> > > [1]  https://lore.kernel.org/linux-arch/5b14144a-9725-41db-7179-c059c=
41814cf@xen0n.name/
> >
> > Based on the example at
> > https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html:
> >
> >    To force an operand into a register, create a local variable and spe=
cify
> >    the register name after the variable=E2=80=99s declaration. Then use=
 the local
> >    variable for the asm operand and specify any constraint letter that
> >    matches the register:
> >
> >    register int *p1 asm ("r0") =3D =E2=80=A6;
> >    register int *p2 asm ("r1") =3D =E2=80=A6;
> >    register int *result asm ("r0");
> >    asm ("sysint" : "=3Dr" (result) : "0" (p1), "r" (p2));
> >
> > I think this should actually be written
> >
> >       asm volatile(
> >       "      syscall 0\n"
> >       : "=3Dr" (ret)
> >       : "r" (nr), "0" (buffer), "r" (len), "r" (flags)
> >       : "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
> > "$t8",
> >         "memory");
> >
> > i.e. "=3D" should be used for the output operand 0, and "0" should be u=
sed
> > for the input operand 2 (buffer) to emphasis the same register as
> > operand 0 is used.
>
> I would have expected that matching constraints ("0") would only really m=
ake
> sense if the compiler selects the specific register to use. When the regi=
ster is
> already selected manually it seems redundant.
> But my inline ASM knowledge is limited and this is a real example from th=
e GCC
> docs, so it is probably more correct.
> On the other hand all the other vDSO implementations use "r" over "0" for=
 the
> input operand 2 and I'd like to keep them consistent.
OK, if there are no objections, I will take this patch.

Huacai

>
>
> Thomas

