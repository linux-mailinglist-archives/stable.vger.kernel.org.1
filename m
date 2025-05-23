Return-Path: <stable+bounces-146157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15334AC1BA4
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 06:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8203B44E2
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 04:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13BF2236F2;
	Fri, 23 May 2025 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyqHwnk+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E1179A3;
	Fri, 23 May 2025 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975877; cv=none; b=TpcdUekTQblbDWm4m4jJI24bxHKRQgJApWEweTxGF1sUdeQS6S+X4UCUlfvHp18n582LMy8lQgzohHx+5Oz/dRsafjOsIYgaijd5zFbPnZ9jbsPUSX3KW7IYGSndAg8yctpHIEPjBy1tKR9PaeGF+wqEM2A+/BsXLfxift601ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975877; c=relaxed/simple;
	bh=bvGqlECt3KwkjBFufymstBZjNxrZxKjrFPlMbTubDtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3to4hEJAC6L7hH6gp2iCLYeuVvyrM7+CKQe7HRlj5NqmQpk/jc+SGou/5aro8+u78c9X0jLtHFoOkRVOTRyZ4RyYTq8P13pB/l2634TTX13CvzbD3LY5eqtZNIxxsd5dt5IgIwUVbuXufFuA/eqA5tdK0U/mp1MOKtkWb4O3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyqHwnk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7FDC4CEF3;
	Fri, 23 May 2025 04:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975877;
	bh=bvGqlECt3KwkjBFufymstBZjNxrZxKjrFPlMbTubDtw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EyqHwnk+jq+yqsctjB8OW5OE4wdREJ31fw5dPcLkbCpt71RxtCgAMYgZ/YI25jhPT
	 TZXR9W1yAWOSy3OIs5JSq6UloP7t0NH8b27q8L8rMI6BDJirluLpcmEONG9dh3H6yw
	 DQiKBvrbmgPFTuBcMgh6xLSjyQSaA0krVXqi1kNeyhLyXRjAQdTKmn1tP2MlnbG9bh
	 oNWWRgJLCila52Rpu0FTxoxXAAI6vikvRXO9NWwyZbq/ZwLDWbxzQzXd9HlYj7Mo4J
	 uJWPqoYJDxF54WLgYtClFxGTgCVqwzPSTQtwLN499as3WJm8tsRSvZOr0PPn0wi1/S
	 cazXgsLcDVWow==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-601c5cd15ecso8411937a12.2;
        Thu, 22 May 2025 21:51:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURuHJqa36rPrVer+yYIJnIx9SevJZ4y+OPsRSWCjN/KLL2DCofZVnac/4eZvxHxhu/c+AdgEOS@vger.kernel.org, AJvYcCXLLHy3uMN/out7C3lHzRGWgGabTmSoVMSxS+m7hi2r8wwRm6MEVKfPqTpB/+fA7U853SlRIqU8wMruxDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMb3NDpBVlzezR3oSOWFSo/ZOZfVkYFWvsS1o6wGU6zH7VROJC
	2ff/nKIAuLSY2msFVtPnmOuaZPtoZ44ocuVqLJl4SUkCAznZrGfpABXAQCxqztSFjohTWIw6pfa
	Qn0HANsw5tpFoN2n0Jq2GBe7w8VjpOM8=
X-Google-Smtp-Source: AGHT+IHklNSCJoQ/XAz9qWP3J7knKOXYlupYiWCuTBYkMxK5HFRTTSmFPC5j4MN6W4KqhEl3JkAfBtaNbzfHFlNbRFo=
X-Received: by 2002:a05:6402:5248:b0:5ff:fa46:9095 with SMTP id
 4fb4d7f45d1cf-60119ccd0c5mr26562056a12.28.1747975875963; Thu, 22 May 2025
 21:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522125050.2215157-1-chenhuacai@loongson.cn> <fa882110d20bd824aca690ba5dfea8c0bd303fc3.camel@xry111.site>
In-Reply-To: <fa882110d20bd824aca690ba5dfea8c0bd303fc3.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 23 May 2025 12:51:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5XyN2OZZqWm2_PCSj8Exs-FSNEL0nQ2AUXgwuTAJoQFw@mail.gmail.com>
X-Gm-Features: AX0GCFtSKe1aMNQF_GMVfd092aBUDH4OMptuywDxqe3ZL8dVHk9RlfufiE8I-rE
Message-ID: <CAAhV-H5XyN2OZZqWm2_PCSj8Exs-FSNEL0nQ2AUXgwuTAJoQFw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Avoid using $r0/$r1 as "mask" for csrxchg
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	WANG Rui <wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 12:38=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
>
> On Thu, 2025-05-22 at 20:50 +0800, Huacai Chen wrote:
> > When building kernel with LLVM there are occasionally such errors:
> >
> > In file included from ./include/linux/spinlock.h:59:
> > In file included from ./include/linux/irqflags.h:17:
> > arch/loongarch/include/asm/irqflags.h:38:3: error: must not be $r0 or $=
r1
> >    38 |                 "csrxchg %[val], %[mask], %[reg]\n\t"
> >       |                 ^
> > <inline asm>:1:16: note: instantiated into assembly here
> >     1 |         csrxchg $a1, $ra, 0
> >       |                       ^
> >
> > The "mask" of the csrxchg instruction should not be $r0 or $r1, but the
> > compiler cannot avoid generating such code currently.
>
> Maybe "to prevent the compiler from allocating $r0 or $r1, the 'q'
> constraint must be used but Clang < 22 does not support it.  So force to
> use t0 in order to avoid using $r0/$r1 while keeping the backward
> compatibility."
>
> And Link: https://github.com/llvm/llvm-project/pull/141037
OK, that's better.

Huacai

>
> > So force to use t0
> > in the inline asm, in order to avoid using $r0/$r1.
> >
> > Cc: stable@vger.kernel.org
> > Suggested-by: WANG Rui <wangrui@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/irqflags.h | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/irqflags.h b/arch/loongarch/inc=
lude/asm/irqflags.h
> > index 319a8c616f1f..003172b8406b 100644
> > --- a/arch/loongarch/include/asm/irqflags.h
> > +++ b/arch/loongarch/include/asm/irqflags.h
> > @@ -14,40 +14,48 @@
> >  static inline void arch_local_irq_enable(void)
> >  {
> >       u32 flags =3D CSR_CRMD_IE;
> > +     register u32 mask asm("t0") =3D CSR_CRMD_IE;
> > +
> >       __asm__ __volatile__(
> >               "csrxchg %[val], %[mask], %[reg]\n\t"
> >               : [val] "+r" (flags)
> > -             : [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD=
)
> > +             : [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> >               : "memory");
> >  }
> >
> >  static inline void arch_local_irq_disable(void)
> >  {
> >       u32 flags =3D 0;
> > +     register u32 mask asm("t0") =3D CSR_CRMD_IE;
> > +
> >       __asm__ __volatile__(
> >               "csrxchg %[val], %[mask], %[reg]\n\t"
> >               : [val] "+r" (flags)
> > -             : [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD=
)
> > +             : [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> >               : "memory");
> >  }
> >
> >  static inline unsigned long arch_local_irq_save(void)
> >  {
> >       u32 flags =3D 0;
> > +     register u32 mask asm("t0") =3D CSR_CRMD_IE;
> > +
> >       __asm__ __volatile__(
> >               "csrxchg %[val], %[mask], %[reg]\n\t"
> >               : [val] "+r" (flags)
> > -             : [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD=
)
> > +             : [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> >               : "memory");
> >       return flags;
> >  }
> >
> >  static inline void arch_local_irq_restore(unsigned long flags)
> >  {
> > +     register u32 mask asm("t0") =3D CSR_CRMD_IE;
> > +
> >       __asm__ __volatile__(
> >               "csrxchg %[val], %[mask], %[reg]\n\t"
> >               : [val] "+r" (flags)
> > -             : [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD=
)
> > +             : [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> >               : "memory");
> >  }
> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

