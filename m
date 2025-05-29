Return-Path: <stable+bounces-148060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9C7AC794B
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 08:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB0F1C05E90
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 07:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5FB1891A9;
	Thu, 29 May 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHuqxfgd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA66B2550BB
	for <stable@vger.kernel.org>; Thu, 29 May 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748501990; cv=none; b=i8VPHrpwfgOfgOpRN4w6+r5YtPHbb4C2G6K3gQPNa5cbQv3yM76KH1ElM2lH3arwu44H8D/jVxKARH540PSQfZZrhtA16RS848dTGPWXvw8fjHI+0uCwPScl6SXmYSZiREx6bByccZRRUTQ99tOdABkXgtpF57pe+HzQWjVIL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748501990; c=relaxed/simple;
	bh=lBw+BpHjnl9eKLYNjGEFN9NrPyx0ONMGK8N3+WGluVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sShekbR9Ayv5190YVRfYPmKGGaj3HX6GpEs8oFO5fwwrYEc70Uk2f75iVoK11ypJvne/y8bYmG9ncbPc7QoCOpZhXiokjlTX+KN7PKAHOGDM76Jd/LIcEapkucd6HR+CW3Lxms42pkorW1rf4TbUbT1Bxtc/3EPbZ5izF3JSrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHuqxfgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F96C4CEEF
	for <stable@vger.kernel.org>; Thu, 29 May 2025 06:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748501990;
	bh=lBw+BpHjnl9eKLYNjGEFN9NrPyx0ONMGK8N3+WGluVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eHuqxfgdEqJqpXK5uAtuuZzYCdpO+MiUQU15/qkIzMtNM6gjhSedFbxLOupB55wUK
	 EU9ovPPmzBAh0H7y19FeHlULxa7DLdkn2GK6EZv6phY9ZVNejgzhLbXQdKlNHGSQjf
	 +sjAh98LoUtyNv98FeeVz/Hhm2vNPIIAAAPRm8uPufjpyno4217+xJfqrCp9yq+F3b
	 ljk3jfRM5z5+DDkcAmdTammckzZ3zWTv/7OlT6ngHzApP71CVBOUrdNm9xNPJqhetH
	 25fVoEjh2yo1So1kGO4euhkNDfKJcXXk2OeGdLs0doM43Nlk7z0x6w3uonaHAmzqn2
	 paD3CEPNGrzzA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-551fe46934eso785584e87.1
        for <stable@vger.kernel.org>; Wed, 28 May 2025 23:59:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAWUy62HLy8Vmofffsy6SAhRaPCkvNl3Ie2wMr3x2n/ft4CpfJTg2ZN/xn0HPdVPIBxQmX/k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYvkQI0IJkLNYhDw3ysi5yvFU/n6GIH2u04fx8dfi5QyoNkHc
	ADddUqtwlRC6T52fKQ75VypR4vA1meVLmxgqhs4nUBrI40DC3kWuvIyk35DSacY6qXvHGfbTNZm
	mujJviDLRmwcXjaHur0xDChNXt5Zup5M=
X-Google-Smtp-Source: AGHT+IFtABxJZwOan0QTOZgeMupEHtBFVj1ydEXgubx6vgjiv8RBttjqh/0nx6/RcegKjMLhZPL/RUPNV8+bYaeKfGE=
X-Received: by 2002:a05:6512:b1c:b0:553:3201:8d23 with SMTP id
 2adb3069b0e04-55335b11511mr763837e87.9.1748501988585; Wed, 28 May 2025
 23:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527162513.035720581@linuxfoundation.org> <20250527162530.470565771@linuxfoundation.org>
 <CAMzpN2hwSXUybfvcas2X5213V=Ow+nqGqqurC_tjfCdb44aFfg@mail.gmail.com> <2025052945-squabble-romp-6304@gregkh>
In-Reply-To: <2025052945-squabble-romp-6304@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 29 May 2025 08:59:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFCQ=q3O043q_Ub8aABHf5E31QrqmqJ3iYCCeLkx37pwA@mail.gmail.com>
X-Gm-Features: AX0GCFsvph-NrwnOGymvOK3gho7TjyEAvM7nMUD0lnIF9lZkKgbjrqNnXzYPFzE
Message-ID: <CAMj1kXFCQ=q3O043q_Ub8aABHf5E31QrqmqJ3iYCCeLkx37pwA@mail.gmail.com>
Subject: Re: [PATCH 6.14 426/783] x86/boot: Disable stack protector for early
 boot code
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brian Gerst <brgerst@gmail.com>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 May 2025 at 08:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 28, 2025 at 01:52:16PM -0400, Brian Gerst wrote:
> > On Tue, May 27, 2025 at 1:39=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 6.14-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: Brian Gerst <brgerst@gmail.com>
> > >
> > > [ Upstream commit a9a76b38aaf577887103e3ebb41d70e6aa5a4b19 ]
> > >
> > > On 64-bit, this will prevent crashes when the canary access is change=
d
> > > from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses f=
rom
> > > the identity-mapped early boot code will target the wrong address wit=
h
> > > zero-based percpu.  KASLR could then shift that address to an unmappe=
d
> > > page causing a crash on boot.
> > >
> > > This early boot code runs well before user-space is active and does n=
ot
> > > need stack protector enabled.
> > >
> > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Link: https://lore.kernel.org/r/20250123190747.745588-4-brgerst@gmail=
.com
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  arch/x86/kernel/Makefile | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > > index b43eb7e384eba..84cfa179802c3 100644
> > > --- a/arch/x86/kernel/Makefile
> > > +++ b/arch/x86/kernel/Makefile
> > > @@ -44,6 +44,8 @@ KCOV_INSTRUMENT_unwind_orc.o                       =
   :=3D n
> > >  KCOV_INSTRUMENT_unwind_frame.o                         :=3D n
> > >  KCOV_INSTRUMENT_unwind_guess.o                         :=3D n
> > >
> > > +CFLAGS_head32.o :=3D -fno-stack-protector
> > > +CFLAGS_head64.o :=3D -fno-stack-protector
> > >  CFLAGS_irq.o :=3D -I $(src)/../include/asm/trace
> > >
> > >  obj-y                  +=3D head_$(BITS).o
> > > --
> > > 2.39.5
> > >
> > >
> > >
> >
> > This doesn't need to be backported.  It's harmless, but not necessary
> > without the rest of the stack protector changes.
>
> What specific changes?  I see stackprotector code in this, and the 6.12
> tree, so what commit id does this "fix"?
>

It does not fix anything. I already raised this with Sasha in response
to one of his AUTOSEL spam bombs. [0]

The first patch of the series in question bumped the minimum GCC
version from 5.x to 8.1, so I am pretty sure it is out of scope for
-stable.

Please stop backporting random shit via AUTOSEL. You keep saying that
developers who don't care about -stable won't have to, but we are the
ones having to make sense of the mess you have created when AUTOSEL
picks one or two random changes out of a larger series. I don't think
AUTOSEL should be used at all until we find a solution to that
problem.


[0] https://lore.kernel.org/all/CAMj1kXF6=3Dt9NoH5Lsh4=3DRwhUTHtpBt9VmZr3bE=
Vm6=3D1zGiOf2w@mail.gmail.com/T/#u

