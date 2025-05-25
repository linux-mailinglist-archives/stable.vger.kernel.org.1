Return-Path: <stable+bounces-146288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5684AC3223
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 04:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B091894358
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 02:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8472622;
	Sun, 25 May 2025 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVLGQtfI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9394E376;
	Sun, 25 May 2025 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748139816; cv=none; b=Bv7n5EBdo3LCRa5NLpBdrHyPnzDFrJu7h6ylEgratmPMvxlqtbq8FsuQEW9pZsftjHYew1705PAkXVUN3l3dNfC2vcSHdhREkZkjPupHt9YEeSEaHeR/lkmwLjlQ9ZBQuMMv91+ztA1wO3wg28lH2q6te6PuITlZGlYBDN9DEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748139816; c=relaxed/simple;
	bh=1cfNEG0UCWBQAA7qNRsrYyvpBd8oaOSgCrpCEd5TqMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvAir8IlW9kgPVtxWX3ZMFVYW8MKUIoCgDD8uYq04eM9b/UBrIpFuZWQ0zEJ+yhs5VKHpLSKiIIKIMfaADzTRWR5egEjlRXpsVFGPh3t5YS6yiGJmrjy/fUvcAFvC+IdcjTLrBnrW4hKy3EbmjNqy2+jr60DMYkRWOMTEUQhJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVLGQtfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DDBC4CEEE;
	Sun, 25 May 2025 02:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748139816;
	bh=1cfNEG0UCWBQAA7qNRsrYyvpBd8oaOSgCrpCEd5TqMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RVLGQtfIMYcFNjNrM5hObrRU/2bot4tnksuN8PAa/IXzMVlWDrew/feA0yzA891Dt
	 7wXBzCtM9nhJ3BlM4/ghSqI1STQ5y1UQpUixZr1ruQ3lM9zIuF+7AswPOatZpsK+3h
	 TGzRTV/0E2v4MjqQX+fijiVQWcbw75gxuIzeVlojbCqeJGFE0p2uJeyit6EF7cCzL7
	 S5NYHgVLbHOH8jbcLd/HG4DxF8UcKk0aaBUGtYfICq0OcziyWMB4TkCl8j1cTNIxIi
	 tOxccasfZ1FqRCR+Z/vLLfGkmDQknNFndTG0a2tHQe++IfZTy6KQUze9Iw+/foCJ0K
	 Wn05c+ez/uRYA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-604533a2f62so1348532a12.3;
        Sat, 24 May 2025 19:23:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVf/yo5TYL734SihObMe0znu6Q3pgPzBWzLlJ/y+lCmApe+9A9k0RyrbNDEE97D8fMw/aYLdgzA@vger.kernel.org, AJvYcCXLseuzsJ+qgib4bx9A51K9ZLcjBYwprUUqZDpWFqHeQRn94N/4V9ygZWtAtW79Mp4mx05b9uxynx7mPU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaHXA3Wwdk2ofF+THMpdc80rgprCfBtYDMx51BEl2ubsvBMgW
	pdXF8W2kyMjUzfZ4iHGzhO3at7loVHkqVAqf9mbphF5ahVfgGY0HfysQNGDzKZ5fz+WvuGEXCpE
	t4TBnvpvPGfIfqb/prIiJsMVCMncfG9g=
X-Google-Smtp-Source: AGHT+IHR5Pd7VftI9ROXkdi3jJwV1V1TcZBGuknhr9JV1+8yAt5BhRufkA0ggfUqNBlVx4kHt34h1EFbIE/knX54PVQ=
X-Received: by 2002:a05:6402:909:b0:5ff:abf8:3563 with SMTP id
 4fb4d7f45d1cf-602d9afa16bmr3076073a12.14.1748139814362; Sat, 24 May 2025
 19:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524142345.8045-1-chenhuacai@loongson.cn> <CAHirt9hF8zZUh+mm=XQvPwG56r4RDuqvJ6WVGfKEEivfJSiZig@mail.gmail.com>
In-Reply-To: <CAHirt9hF8zZUh+mm=XQvPwG56r4RDuqvJ6WVGfKEEivfJSiZig@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 25 May 2025 10:23:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H76MgYT0dk-A4bhBdTmyanUn4J28gCUL2+Wacv-ahYSFg@mail.gmail.com>
X-Gm-Features: AX0GCFtavRmZCKxux0RnlcPw9q5LAZ8Jij0x_nPlq-ruoEB1YkIXCGvEuOV_rJ8
Message-ID: <CAAhV-H76MgYT0dk-A4bhBdTmyanUn4J28gCUL2+Wacv-ahYSFg@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Avoid using $r0/$r1 as "mask" for csrxchg
To: WANG Rui <wangrui@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yanteng Si <si.yanteng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 10:01=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wro=
te:
>
> On Sat, May 24, 2025 at 10:24=E2=80=AFPM Huacai Chen <chenhuacai@loongson=
.cn> wrote:
> >
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
> >
> > To prevent the compiler from allocating $r0 or $r1 for the "mask" of th=
e
> > csrxchg instruction, the 'q' constraint must be used but Clang < 22 doe=
s
> > not support it. So force to use $t0 in the inline asm, in order to avoi=
d
> > using $r0/$r1 while keeping the backward compatibility.
>
> Clang < 21
OK, V3 sent.

Huacai
>
> >
> > Cc: stable@vger.kernel.org
> > Link: https://github.com/llvm/llvm-project/pull/141037
> > Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
> > Suggested-by: WANG Rui <wangrui@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V2: Update commit messages.
> >
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
> >         u32 flags =3D CSR_CRMD_IE;
> > +       register u32 mask asm("t0") =3D CSR_CRMD_IE;
> > +
> >         __asm__ __volatile__(
> >                 "csrxchg %[val], %[mask], %[reg]\n\t"
> >                 : [val] "+r" (flags)
> > -               : [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CR=
MD)
> > +               : [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> >                 : "memory");
> >  }
> >
> >  static inline void arch_local_irq_disable(void)
> >  {
> >         u32 flags =3D 0;
> > +       register u32 mask asm("t0") =3D CSR_CRMD_IE;
> > +
> >         __asm__ __volatile__(
> >                 "csrxchg %[val], %[mask], %[reg]\n\t"
> >                 : [val] "+r" (flags)
> > -               : [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CR=
MD)
> > +               : [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> >                 : "memory");
> >  }
> >
> >  static inline unsigned long arch_local_irq_save(void)
> >  {
> >         u32 flags =3D 0;
> > +       register u32 mask asm("t0") =3D CSR_CRMD_IE;
> > +
> >         __asm__ __volatile__(
> >                 "csrxchg %[val], %[mask], %[reg]\n\t"
> >                 : [val] "+r" (flags)
> > -               : [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CR=
MD)
> > +               : [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> >                 : "memory");
> >         return flags;
> >  }
> >
> >  static inline void arch_local_irq_restore(unsigned long flags)
> >  {
> > +       register u32 mask asm("t0") =3D CSR_CRMD_IE;
> > +
> >         __asm__ __volatile__(
> >                 "csrxchg %[val], %[mask], %[reg]\n\t"
> >                 : [val] "+r" (flags)
> > -               : [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CR=
MD)
> > +               : [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> >                 : "memory");
> >  }
> >
> > --
> > 2.47.1
> >
> >
>

