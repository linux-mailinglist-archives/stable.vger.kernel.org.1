Return-Path: <stable+bounces-99669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAD19E72D9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41783164762
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3D20C00E;
	Fri,  6 Dec 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6tFYIKp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734E20B1F7;
	Fri,  6 Dec 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497957; cv=none; b=GOl8Cn1w5Y6lRW7lUmX6U7pHis4e/c5D9KbK8KbPr5WvyLd5ME2DEGcP3rHnNClcDHgPsmbPTQfFjfF8gR0G/eLCKfxKHj3rjD/IE4B9S2dBJj9zONN08sRD75aVS2mcozpxTd3CY/4ylkwAjLq1D0GGy4cA46q6hyeNQz26PwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497957; c=relaxed/simple;
	bh=nBxHtdhQB5FLlrFFA527YiECEEEtLZr/yyEPczDfXps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYDNx8M8uesafvQ62CWLearjv07uIEgCXJfuUVMKd0i88oBHXiXzm2nOQA4lg517k5yta1CdP2tCVVBKEaZiB5KzU+6vV1sEyw+W0G3QEI54+qfXnkamn1J3GPX4UC3kchpQTsR5Sw9ADEceYOJRX//cXqbTOCvrtvjEK4N6eQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6tFYIKp; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso27276671fa.0;
        Fri, 06 Dec 2024 07:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733497953; x=1734102753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W73679HmQ8KlBF8NSlHlv/uvxLcjA1X6Vo9+LFPoX88=;
        b=j6tFYIKpy6upMel7KzLJZvBXYW0xnlrIVlMOOERPaIR0FBmTba6ZrAP7MQG/z9eVxE
         t/QRe7zkIjYCoFlWlOBUi/bJXUFnJvXN2HWQxisPA76/iU8eiwaiqqm+qEpB3gpVXv/p
         0CJDctrd2SF9anfRrt1SB0UoZp68tMU9Y8ZgRYUxKdFOm2CEKTSvh+nHWUyzVGnqyszW
         EM8zK+QLvd/7+hzAeSOvfMn83tSMvVGjVbJLR595nS1wsyRd7Jgtxh1GbJWMsWfejRiC
         8oYGEHtU36zNQxmbtSNoJczbS2L4ck84Nbjw/kXQLKGBzaqDuZVZkNJXSYSlbo/IUl0L
         mmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733497953; x=1734102753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W73679HmQ8KlBF8NSlHlv/uvxLcjA1X6Vo9+LFPoX88=;
        b=K3ZWGghwGZl7QnPB83ZgYIQ3fU4sro6bBM5s16DCEIFAcKZpSh4x9w4ewUtZCu4SAD
         Q/ZIdrPIGtp4oyULrLAO5Fvc1N2uXAB0boEjAefzJV6SmHnND/i5+e03YTJRubpM7hyi
         GCAuBtiekHHTovSZ00ACBviN+0zFv3dfqNYB7YqEMCIYs3yDSn+Dm5X018rGsY5Tr5/K
         qE3tN1aoPYSIgnpQlL5cxtHlftWr5BoZzaDcRWpMwwtoVyQFcLd51LuNGag2v9nzoQZT
         vOH3lbXsUbR89F8mPnXaTqM5PhrclDMo/dnSfHv6Ul74UxGnPkNPwTx7RqiT6vWFqbmJ
         Qttw==
X-Forwarded-Encrypted: i=1; AJvYcCU0RLXvnvHEkv2/WCcKFC1X7DeT+1lL/boeStpaGAwFACpt88FKZ1SiTShT2vDLt25ZE/CjpqX8@vger.kernel.org, AJvYcCUWW4PpRlHV9qQ6LKFRMxOrXglh3vAwXTirTIFEU7qtuXucXoTtrWg4ItaST5IuiGrYhlyPMgtw49QR7K4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mkh0F67MRcDYp75mmFbXdNFSKF3gCr5HcfiVU7ux7uHw1BJw
	Si/i86P31vrnKmiMOH81XGjYIGN8h9MA/FHb1rznw4DpS4wBJdmy3grkxc9i//w/wfv87HvBW3o
	fPiPvlquqOGt+hQ2On6Qlr0DP8g==
X-Gm-Gg: ASbGnctMrgs88VHCYijUeWnpIkWWfE682RjPWf1yGN9lG+8SqslfAmAZ0TTkbX5ArMI
	RgtLRXIOsXqLZCmpgXsC9kmyr3NouqDlp1B4ywDOXf9ahoA==
X-Google-Smtp-Source: AGHT+IHwK0hARRMdu/ZslO7Jdrs0a5LHFRqi533TRz4TWoZ2vLhjJ6JLSNL1SEj9Z3vQyPSDb/d/7EYLL4Ue0VsfGbY=
X-Received: by 2002:a05:6512:2342:b0:53d:f1cb:6258 with SMTP id
 2adb3069b0e04-53e2c2c23afmr2410284e87.32.1733497952400; Fri, 06 Dec 2024
 07:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-2-brgerst@gmail.com>
 <20241206123207.GA2091@redhat.com> <CAMj1kXGKCJfBVqgsqjX1bA_SY=503Z-tJV893y5JAwoVs0BUfw@mail.gmail.com>
 <20241206142152.GB31748@redhat.com> <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
In-Reply-To: <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 6 Dec 2024 10:12:21 -0500
Message-ID: <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:37=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Fri, 6 Dec 2024 at 15:22, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 12/06, Ard Biesheuvel wrote:
> > >
> > > On Fri, 6 Dec 2024 at 13:32, Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > +#ifdef CONFIG_STACKPROTECTOR
> > > >  /* needed for Clang - see arch/x86/entry/entry.S */
> > > >  PROVIDE(__ref_stack_chk_guard =3D __stack_chk_guard);
> > > > +#endif
> > > >
> > > >  #ifdef CONFIG_X86_64
> > > >  /*
> > >
> > > This shouldn't be necessary - PROVIDE() is only evaluated if a
> > > reference exists to the symbol it defines.
> > >
> > > Also, I'm failing to reproduce this. Could you share your .config,
> > > please, and the error that you get during the build?
> >
> > Please see the attached .config
> >
> > without the change above:
> >
> >         $ make bzImage
> >           CALL    scripts/checksyscalls.sh
> >           DESCEND objtool
> >           INSTALL libsubcmd_headers
> >           UPD     include/generated/utsversion.h
> >           CC      init/version-timestamp.o
> >           KSYMS   .tmp_vmlinux0.kallsyms.S
> >           AS      .tmp_vmlinux0.kallsyms.o
> >           LD      .tmp_vmlinux1
> >         ./arch/x86/kernel/vmlinux.lds:154: undefined symbol `__stack_ch=
k_guard' referenced in expression
> >         scripts/Makefile.vmlinux:77: recipe for target 'vmlinux' failed
> >         make[2]: *** [vmlinux] Error 1
> >         /home/oleg/tmp/LINUX/Makefile:1225: recipe for target 'vmlinux'=
 failed
> >         make[1]: *** [vmlinux] Error 2
> >         Makefile:251: recipe for target '__sub-make' failed
> >         make: *** [__sub-make] Error 2
> >
> > perhaps this is because my toolchain is quite old,
> >
> >         $ ld -v
> >         GNU ld version 2.25-17.fc23
> >
> > but according to Documentation/process/changes.rst
> >
> >         binutils               2.25             ld -v
> >
> > it is still supported.
> >
>
> We're about to bump the minimum toolchain requirements to GCC 8.1 (and
> whichever version of binutils was current at the time), so you might
> want to consider upgrading.
>
> However, you are right that these are still supported today, and so we
> need this fix this, especially because this has been backported to
> older stable kernels too.
>
> For the patch,
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Using PROVIDES() is now unnecessary.


Brian Gerst

