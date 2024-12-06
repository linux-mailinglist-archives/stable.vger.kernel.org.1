Return-Path: <stable+bounces-99767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901BF9E733F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595BC1882095
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795CB153BE8;
	Fri,  6 Dec 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UARJmyrV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470B53A7;
	Fri,  6 Dec 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498283; cv=none; b=CWR6Lv9LyJnps9YJKwtxxsbUw16IDwFrQh9F0/F4ByD9AGZVXZru7c88p7pKKiwMD5iUUzTTSBo5HzRPl4+LxusieKwjH8UVgjLNIOx7yn3BrQXocL0SHT4wDl+jhk5FNzKTUdrm/CJclIh67gbUKGjUY6I7rAYlZMF2Jx4FzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498283; c=relaxed/simple;
	bh=7ZkkG9sI4gnvWA3PVy2tvr1W2lr2ZYeU7WA/gXOhtaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+J7oA6Mi5qrXRQawHSq6EZg9dkIvWH6Ulatoq2XGsl3OdKnd48z7ulo1X6FeXF7sr+jSSwRVIkwkWVeX8dLRgEQ1lJaH7IzPA8wplFIsFNxHdvMhJ/cb5a2bvcxiEuSq175G68YUy18Wu8wEgVxuQwtZufosJOQBH2lP7pFI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UARJmyrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0302C4CEE5;
	Fri,  6 Dec 2024 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733498282;
	bh=7ZkkG9sI4gnvWA3PVy2tvr1W2lr2ZYeU7WA/gXOhtaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UARJmyrVsplk3Y4d668cEaXnOm8+YZvO8ziweiaWimxl7XfRWIQFuRDKkGBDJZtev
	 ow2PtLYVvygcdvbNqo3HPjyMvCa1JLWP7I7Pk8moYlj4khcvgKVWBHxV3mKw407BEZ
	 vO+l6U8I6epP0FU0St1UzfSkr5ew2/L1HFB5e5T/YChACSrRZAL+BZ6cjDu1R7IfqM
	 W92uykTug/GG61bg63jf6DxYpMD0zp/M+aQFHvIsuKs7F8C4Su84w0CWVv3MKVeZ0P
	 uiTb0vStL2iQBBokq8GKraoDlqZxGNgRv1jPcoAQM2BRcu2sl3O+S4uH67dO29C7iJ
	 BhlET8it0hmyg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffc016f301so19066521fa.1;
        Fri, 06 Dec 2024 07:18:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyK5ByQ2qVXe5evZdwApS3VBKrrz5hLMbxX1cO82HKGFxWWmLgItfPRj2aj7ivFS9HIRj7ccSRAyx4nwg=@vger.kernel.org, AJvYcCXcvt6LCbpDS24EjXCyRy/YEB6LgvnO2jpKI8/ax2jBWbERVNtGD/IXRvlC/vz27cxRnuYc8kJE@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbKWbfmWPjrlmTMi7YwElyp2wGI8LJmiioTFtFcNW164RGEFE
	UQIBmhWM46G5B0HFgF3Ji0kPoEyoUhpEKUhB2K384fHg1930RpfcGwQtyZseS5rzSu319qfy1qq
	qOE4zpdxa1penlQYPLVx0OfcbeMY=
X-Google-Smtp-Source: AGHT+IGEDJ8Is8k/WRknAfEBV/J8olF8npu0JAL2v2Ao1IHNxcz/+L+AjjCTl7mVwRDRYRvPXdXxyCZMs21ZsKuKxkU=
X-Received: by 2002:a05:651c:1b06:b0:300:159a:1637 with SMTP id
 38308e7fff4ca-3002f912ae2mr10531431fa.20.1733498281007; Fri, 06 Dec 2024
 07:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-2-brgerst@gmail.com>
 <20241206123207.GA2091@redhat.com> <CAMj1kXGKCJfBVqgsqjX1bA_SY=503Z-tJV893y5JAwoVs0BUfw@mail.gmail.com>
 <20241206142152.GB31748@redhat.com> <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
 <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
In-Reply-To: <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 6 Dec 2024 16:17:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
Message-ID: <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
To: Brian Gerst <brgerst@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 16:12, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Fri, Dec 6, 2024 at 9:37=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Fri, 6 Dec 2024 at 15:22, Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 12/06, Ard Biesheuvel wrote:
> > > >
> > > > On Fri, 6 Dec 2024 at 13:32, Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >
> > > > > +#ifdef CONFIG_STACKPROTECTOR
> > > > >  /* needed for Clang - see arch/x86/entry/entry.S */
> > > > >  PROVIDE(__ref_stack_chk_guard =3D __stack_chk_guard);
> > > > > +#endif
> > > > >
> > > > >  #ifdef CONFIG_X86_64
> > > > >  /*
> > > >
> > > > This shouldn't be necessary - PROVIDE() is only evaluated if a
> > > > reference exists to the symbol it defines.
> > > >
> > > > Also, I'm failing to reproduce this. Could you share your .config,
> > > > please, and the error that you get during the build?
> > >
> > > Please see the attached .config
> > >
> > > without the change above:
> > >
> > >         $ make bzImage
> > >           CALL    scripts/checksyscalls.sh
> > >           DESCEND objtool
> > >           INSTALL libsubcmd_headers
> > >           UPD     include/generated/utsversion.h
> > >           CC      init/version-timestamp.o
> > >           KSYMS   .tmp_vmlinux0.kallsyms.S
> > >           AS      .tmp_vmlinux0.kallsyms.o
> > >           LD      .tmp_vmlinux1
> > >         ./arch/x86/kernel/vmlinux.lds:154: undefined symbol `__stack_=
chk_guard' referenced in expression
> > >         scripts/Makefile.vmlinux:77: recipe for target 'vmlinux' fail=
ed
> > >         make[2]: *** [vmlinux] Error 1
> > >         /home/oleg/tmp/LINUX/Makefile:1225: recipe for target 'vmlinu=
x' failed
> > >         make[1]: *** [vmlinux] Error 2
> > >         Makefile:251: recipe for target '__sub-make' failed
> > >         make: *** [__sub-make] Error 2
> > >
> > > perhaps this is because my toolchain is quite old,
> > >
> > >         $ ld -v
> > >         GNU ld version 2.25-17.fc23
> > >
> > > but according to Documentation/process/changes.rst
> > >
> > >         binutils               2.25             ld -v
> > >
> > > it is still supported.
> > >
> >
> > We're about to bump the minimum toolchain requirements to GCC 8.1 (and
> > whichever version of binutils was current at the time), so you might
> > want to consider upgrading.
> >
> > However, you are right that these are still supported today, and so we
> > need this fix this, especially because this has been backported to
> > older stable kernels too.
> >
> > For the patch,
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> Using PROVIDES() is now unnecessary.
>

At this point, the use of -mstack-protector-guard-symbol is still
limited to 32-bit x86. However, if we drop PROVIDE() here, the 64-bit
kernel will also gain a symbol `__ref_stack_chk_guard` in its symbol
table (and /proc/kallsyms, most likely).

Not sure whether that matters or not, but I'd rather keep the
PROVIDE() as it doesn't do any harm.

