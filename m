Return-Path: <stable+bounces-83198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 321F39969F1
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A598FB20F64
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CFC193078;
	Wed,  9 Oct 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSY4ugFb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0175191489;
	Wed,  9 Oct 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476841; cv=none; b=aLk9w1PV58Q7YWbj+JmLLY1Te2lYzQwxVpbH0pJy4meGvyW9qtWeZ29ur7PxOb5Oayutr8BzaJJpMaAoXYACY8SqZ7iQXyOC4ehRcT6iA2Z7vdUZk5Lu9qVwcDJl1QpNyl5VTW3JDwwSvA9Uxw56iPVE4+XkbkUKoYZUZ7yGH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476841; c=relaxed/simple;
	bh=gGlKI2Ghw8RXjO7e8Jn+hmXiV5nmCS+aULlMA6zfZNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVD7HNnOqXbXZTN+7UgSkRDUW1y7oNwpv6x5aNQ+eo7GTAocLFaRqdc4rzRA3E246dI5Bs2Qp284dk4eRVDd/Wy1GrxRjCxf4gkuWyhiQGgWu3AhXUGsBmH+iGxG7r+uqqQ4S5GyygAcYXGR5AVxi3pSsVj4n5oyCnSEiAilD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSY4ugFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE14C4CECD;
	Wed,  9 Oct 2024 12:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728476841;
	bh=gGlKI2Ghw8RXjO7e8Jn+hmXiV5nmCS+aULlMA6zfZNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rSY4ugFbSKEHum4I8CRjqug0ZpFg8/qEtXGqyoZcmxtV4rQWP+MQJLYbtWG0rGaSz
	 QY2HEEawystRAMeDzYtp60zd1buykZD4IKKH+nx+a3ZOOrmOrgw0gDrbF1qZFIybUn
	 zjMctKhf3Di9ye56x0OCbawUzfyPLed3KUl2zcVHjABs6fZUTipasx0KAogN9kCulX
	 LGbKzG+4RFPco8pWKypYmEwbfjP30hvVAD4eLCTvOADm5bCuu8wjW/yXIEgMMwiLZ2
	 Z4CQTlMxYTuyBTJ0qWNienG/nH7TJtKBNDBwkbGmWhuP/iAh7C/VIxQI9kc4DPatVP
	 SvHYlbJufQ6Vw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fad6de2590so102893901fa.0;
        Wed, 09 Oct 2024 05:27:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHbCodjAOQE3QvJhCqsiOgSCoNZ+j17tH/3UD99et3EAPbDPUYUQur9cqNnbvZqiWXGBYZmXhx3FZ290Q=@vger.kernel.org, AJvYcCVSBUkEQbRkH7AFbS/t4ubVPMNziPc8ApYPP8GM34Vm9EgOmIjZuFNOYtJBN49eLTnENHJuo0ld@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5k3TlFacpIr5raI1/gtLsaVOnuXPMeOhZVUyExo8HuHuWG3E
	bo3Lbx7GPUYDu3FjWmyHIKFiC4axkfcaZblRCA3NIgPt9Tiky4Vl5XiUD8WPmX6NZNjm5jzyd5m
	1EH9VytWcdz0WuEa14i3RebDJ6Y8=
X-Google-Smtp-Source: AGHT+IH0dPG2wqVuMOnNoSFxcnaCV4CzYdY+iU0F0bRiSknP5S7czXVhTnsoAdNx7/Jcv7he9JunULlVxDPEU5rbbps=
X-Received: by 2002:a05:6512:b19:b0:536:542e:ce1f with SMTP id
 2adb3069b0e04-539c48997d5mr2181997e87.18.1728476829120; Wed, 09 Oct 2024
 05:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002092534.3163838-2-ardb+git@google.com> <CAMj1kXGDmkuwSROhnFkX_jYbWyAL738KmHbk5qYnThL6JWHapg@mail.gmail.com>
 <CAMzpN2i-EyGjkb9S6fWBXmZoj6GUEQNjSZ0-MviPJy-GiRxnPw@mail.gmail.com>
In-Reply-To: <CAMzpN2i-EyGjkb9S6fWBXmZoj6GUEQNjSZ0-MviPJy-GiRxnPw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Oct 2024 14:26:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEVSqy=Gd9-aUeix6J6i3Tt7MhrC4TmZqVvObWP+Z42vg@mail.gmail.com>
Message-ID: <CAMj1kXEVSqy=Gd9-aUeix6J6i3Tt7MhrC4TmZqVvObWP+Z42vg@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: Work around strict Clang TLS symbol requirements
To: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, x86@kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Uros Bizjak <ubizjak@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Oct 2024 at 17:48, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Wed, Oct 2, 2024 at 7:04=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Wed, 2 Oct 2024 at 11:25, Ard Biesheuvel <ardb+git@google.com> wrote=
:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > GCC and Clang both implement stack protector support based on Thread
> > > Local Storage (TLS) variables, and this is used in the kernel to
> > > implement per-task stack cookies, by copying a task's stack cookie in=
to
> > > a per-CPU variable every time it is scheduled in.
> > >
> > > Both now also implement -mstack-protector-guard-symbol=3D, which perm=
its
> > > the TLS variable to be specified directly. This is useful because it
> > > will allow us to move away from using a fixed offset of 40 bytes into
> > > the per-CPU area on x86_64, which requires a lot of special handling =
in
> > > the per-CPU code and the runtime relocation code.
> > >
> > > However, while GCC is rather lax in its implementation of this comman=
d
> > > line option, Clang actually requires that the provided symbol name
> > > refers to a TLS variable (i.e., one declared with __thread), although=
 it
> > > also permits the variable to be undeclared entirely, in which case it
> > > will use an implicit declaration of the right type.
> > >
> > > The upshot of this is that Clang will emit the correct references to =
the
> > > stack cookie variable in most cases, e.g.,
> > >
> > >    10d:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
> > >                       10f: R_386_32   __stack_chk_guard
> > >
> > > However, if a non-TLS definition of the symbol in question is visible=
 in
> > > the same compilation unit (which amounts to the whole of vmlinux if L=
TO
> > > is enabled), it will drop the per-CPU prefix and emit a load from a
> > > bogus address.
> > >
> > > Work around this by using a symbol name that never occurs in C code, =
and
> > > emit it as an alias in the linker script.
> > >
> > > Fixes: 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a r=
egular percpu variable")
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Fangrui Song <i@maskray.me>
> > > Cc: Brian Gerst <brgerst@gmail.com>
> > > Cc: Uros Bizjak <ubizjak@gmail.com>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1854
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/Makefile             |  5 +++--
> > >  arch/x86/entry/entry.S        | 16 ++++++++++++++++
> > >  arch/x86/kernel/cpu/common.c  |  2 ++
> > >  arch/x86/kernel/vmlinux.lds.S |  3 +++
> > >  4 files changed, 24 insertions(+), 2 deletions(-)
> > >
> >
> > This needs the hunk below applied on top for CONFIG_MODVERSIONS:
> >
> > --- a/arch/x86/include/asm/asm-prototypes.h
> > +++ b/arch/x86/include/asm/asm-prototypes.h
> > @@ -20,3 +20,6 @@
> >  extern void cmpxchg8b_emu(void);
> >  #endif
> >
> > +#ifdef CONFIG_STACKPROTECTOR
> > +extern unsigned long __ref_stack_chk_guard;
> > +#endif
>
> Shouldn't this also be guarded by __GENKSYMS__, since the whole point
> of this is to hide the declaration from the compiler?
>

Yes, good point. Even though it does not matter in practice (the issue
is tickled only by a visible *definition*, not by a declaration), this
file is included into C code, which should be avoided.

