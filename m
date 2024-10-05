Return-Path: <stable+bounces-81171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0BF9917EB
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3221F22B4B
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3941154BEC;
	Sat,  5 Oct 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKFbqlaB"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B91C2C9;
	Sat,  5 Oct 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728143325; cv=none; b=eS8obqXb3FHk9GdzLxrPxDV05OCCS6ayecSiklDWm7KLeO93YMw0xBCPwyVeeiRG+1i1ahwkiAEh3GDhr0Y6/lZZ+ozWz3z/GAotzygaH21dE1sufJFGKVsF2FXNYBtU3Bm5G2XihEG0+lsqO5a0LLCDOyAS5Kgt40JyOuiFqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728143325; c=relaxed/simple;
	bh=CAwZZ/cbkZfNcTx3fD33ENauVSXB4fGFVU4Z9VQV5ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZ/ldRArIcJLsiPqB0K3N7q+moapEM3n9JomwZPkm8uEyogCXYwK4Llt0HlHTlFatHeANu8WksvNsVA17D2DfwOC8UHPa/Yv56f96zKyGpZmqcRneeYysTtHuDgqOnlqto17+Nfov/IP3SSQKwCjitBQD88QLm8hALpr4Bgebck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKFbqlaB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fad8337aa4so35567851fa.0;
        Sat, 05 Oct 2024 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728143322; x=1728748122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtxqmhjvfS2LHPA1jTETD3JSTrJ84jElXfjubNHHF9c=;
        b=jKFbqlaBTJa52QmBbsJlcZAvczNuxgwoRyIjfhD5i3ZbvltGoSsYa+GvV55RSSB7Bw
         M00fN/cx9Gmz+lDgpwFt9XBedx4hgwsLJond7HSqArH1tGMzslcJ7ANJXsF8tf2pEKW8
         6j+SCXnOBmwWvLgr1j2nlOhJ4GtiUGUf+pE2gtZGuUXgxfXaZELqa9swpib3YQtEY+bp
         Up2tAkSnrCnQisLGq+oHil83eWWncXo7eFZsm9cVWCEAfGVYNOcZYLjHwfRFxmM6Wu4H
         fz8UKcvFu1/XoRsUs2iJJF2qBNHhOFWymCCSCURtVAIdjDK2ZlnMAXpJ8bg4nbjEtGE9
         lCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728143322; x=1728748122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtxqmhjvfS2LHPA1jTETD3JSTrJ84jElXfjubNHHF9c=;
        b=RxIvCN2p9vzmJoFmoIjTYBuUuBguz7A/yw5y3iYFYiM35VYkh0s5Pnn4u2hfsFwQYn
         RhbXXApgz6avY/CHq+82DPZyFnq+t+SA7PQUxojB1Ee+MNam0gxJJJ6c8XgIoGGSj3+9
         vXXtCNrGGDyVT5heNNMdy+L/FfmJi5TFDSxeGkSsmWUU/Pt8hxPz/Ny6g0mn6I5WJbWh
         FoFASoXbdcg0cfz/j0nFsGqeFNdJDax661KLu3blBMvXNf3CTWMz0fL8zFlc9MSE14Z6
         duBG2Kc7/2J/FQnbnwZiWtP6sa/JgeNlyvj0mMn+3PXjB2wcZTXm7g/CzxJMX3PYUbNq
         QrJA==
X-Forwarded-Encrypted: i=1; AJvYcCUM/spSq9veJHXQppgIxrn9DGpzIZeDHMGnfg1sx86m9tBuCU3I72XMQQ+S0TvOx3G4HXvC8AuFe5tX9GA=@vger.kernel.org, AJvYcCXgaxTQid2filfQcIi1pGaaGZNtqxYDC/SWx78xE0ulXJ0vvim1E1vzz5pShsYU8aVZ1HvEXTwa@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmP+gNAJMltchgH4OJzyOTb3PIkBQ6EnIl8fPLOp98IauFkrV
	RVaDQEKT8JBo7pEZLE9gs6RdbJLii//Regt5B95k57Ux+OreH3kXb7rfvNejJRcgzAu/ohL5B1Q
	NvyWdESZBd7XEGILIAw7XMS1VOQ==
X-Google-Smtp-Source: AGHT+IFQhJujfFuTsYWjO3cyatW0jMKx8lC6zgFbyjgoqUx/Eap6iQT+vvVetq98t3rLbrv3vwXyYl9HWoEEK7CMN2w=
X-Received: by 2002:a05:6512:baa:b0:534:3cdc:dbef with SMTP id
 2adb3069b0e04-539ab8add1fmr3167920e87.43.1728143321606; Sat, 05 Oct 2024
 08:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002092534.3163838-2-ardb+git@google.com> <CAMj1kXGDmkuwSROhnFkX_jYbWyAL738KmHbk5qYnThL6JWHapg@mail.gmail.com>
In-Reply-To: <CAMj1kXGDmkuwSROhnFkX_jYbWyAL738KmHbk5qYnThL6JWHapg@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 5 Oct 2024 11:48:30 -0400
Message-ID: <CAMzpN2i-EyGjkb9S6fWBXmZoj6GUEQNjSZ0-MviPJy-GiRxnPw@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: Work around strict Clang TLS symbol requirements
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, x86@kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Uros Bizjak <ubizjak@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 7:04=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Wed, 2 Oct 2024 at 11:25, Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > GCC and Clang both implement stack protector support based on Thread
> > Local Storage (TLS) variables, and this is used in the kernel to
> > implement per-task stack cookies, by copying a task's stack cookie into
> > a per-CPU variable every time it is scheduled in.
> >
> > Both now also implement -mstack-protector-guard-symbol=3D, which permit=
s
> > the TLS variable to be specified directly. This is useful because it
> > will allow us to move away from using a fixed offset of 40 bytes into
> > the per-CPU area on x86_64, which requires a lot of special handling in
> > the per-CPU code and the runtime relocation code.
> >
> > However, while GCC is rather lax in its implementation of this command
> > line option, Clang actually requires that the provided symbol name
> > refers to a TLS variable (i.e., one declared with __thread), although i=
t
> > also permits the variable to be undeclared entirely, in which case it
> > will use an implicit declaration of the right type.
> >
> > The upshot of this is that Clang will emit the correct references to th=
e
> > stack cookie variable in most cases, e.g.,
> >
> >    10d:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
> >                       10f: R_386_32   __stack_chk_guard
> >
> > However, if a non-TLS definition of the symbol in question is visible i=
n
> > the same compilation unit (which amounts to the whole of vmlinux if LTO
> > is enabled), it will drop the per-CPU prefix and emit a load from a
> > bogus address.
> >
> > Work around this by using a symbol name that never occurs in C code, an=
d
> > emit it as an alias in the linker script.
> >
> > Fixes: 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a reg=
ular percpu variable")
> > Cc: <stable@vger.kernel.org>
> > Cc: Fangrui Song <i@maskray.me>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1854
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/Makefile             |  5 +++--
> >  arch/x86/entry/entry.S        | 16 ++++++++++++++++
> >  arch/x86/kernel/cpu/common.c  |  2 ++
> >  arch/x86/kernel/vmlinux.lds.S |  3 +++
> >  4 files changed, 24 insertions(+), 2 deletions(-)
> >
>
> This needs the hunk below applied on top for CONFIG_MODVERSIONS:
>
> --- a/arch/x86/include/asm/asm-prototypes.h
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -20,3 +20,6 @@
>  extern void cmpxchg8b_emu(void);
>  #endif
>
> +#ifdef CONFIG_STACKPROTECTOR
> +extern unsigned long __ref_stack_chk_guard;
> +#endif

Shouldn't this also be guarded by __GENKSYMS__, since the whole point
of this is to hide the declaration from the compiler?

Brian Gerst

