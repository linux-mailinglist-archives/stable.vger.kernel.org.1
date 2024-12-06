Return-Path: <stable+bounces-99085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ED69E7023
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974B1281DA9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3019614A4F0;
	Fri,  6 Dec 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlKxJnzK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57A1494CF;
	Fri,  6 Dec 2024 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495875; cv=none; b=jzQ9HKDv1xd3S64Wr8OpcHMi/M7H/JNQ8DKwl7XVRdVS36hHLK4fhOEBdujm+wD+caksLBODoGSKHcYurePfS0IJyIaF3NaVkoLhdNtdCKThxtR4yfZJYC3d/HaVzBWz4L7tE0cqo9FXIhcKQHb9eFadDim0ytqO80WIeCwiPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495875; c=relaxed/simple;
	bh=Vad/gaFOZo00t3jVkRc7ys3RP3DGADAqE2QNBCoEsMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lb8KH+giw8hFXUY8D8/X96OWmHCB6XlcJCM8xpZwFtlTf/gMnLwVvaxg8FVh7BRM9D7+kQ7ahX3kNLVF+TIQc3QrILFeQ+dTTztXYTwlpdSDuAOwkskEipgg6uJCySuT25OcuKLqSaUeCjusmXtOdPKLnJfKv3yGrxOKelKzR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlKxJnzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED91C4CEDF;
	Fri,  6 Dec 2024 14:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733495874;
	bh=Vad/gaFOZo00t3jVkRc7ys3RP3DGADAqE2QNBCoEsMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DlKxJnzKFSPFUrNyea4IEYGwtkpzzJtAT8ZbPhuQED6E6N9fzx3qbJnBcaIxbm6b7
	 zlvruo21p6u+hiEg91PJjFautNq5hx8b5F7VAA39Ytyd75AqYx56DJSruMcVVBd1+W
	 gaCzMrGXbH7nT48ZhgN4/ixa/RlnCnicRQ4+QjJpVBp/d/HGPvfgR7fdYWCZ+IB19m
	 /Z7eIvF2wWrn+UIaKcnZx/Vx93WojegIobuiRskuab7SW/iO+4MeTDgcxfzXDAAnpB
	 a6n384wclXUzTErCETDt+mHfjfIWri+tZoMZGjlnF7f5ISwEtF6Un63j9ukX3FPo80
	 uf8dsj+Nn5COQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e0844ee50so2225922e87.0;
        Fri, 06 Dec 2024 06:37:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXU5rILW0TrXTOnos4zAojIURPeN5HsgMLYRcwRhSBLcj5mCbHcur/lJyqkthfONf7ssuOMCmFeu/3Cf9Y=@vger.kernel.org, AJvYcCXnHhYRv+JkviZ2Bid8h+E7sJMxmomuGQJ+n1RAXR9BE5PxXGbanVIYsL8vyM2zjT42AVnsItIQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwHnIHRCUhtZakspgEVEX361pD+GO+wJl39IdeRUXrd2eySNDET
	1anFR9uUpw4NveXqaLDFh/eW5s0oaCXdXXyzcDkn9XZziR5yznk8a0kUfuHe5y0GAlU6bY4ofxq
	aIEdQOMdRLKxCHKL9eAy9LjMbuAM=
X-Google-Smtp-Source: AGHT+IHuAwM83m6+RWKkl64yD9mP7ESuGRFj2a5bEHkGgsjkDaR3MMY8Gib/HB7B7MzOB3nYzufARDGGygTbWB8ilEY=
X-Received: by 2002:a05:6512:398f:b0:53e:1d92:46c with SMTP id
 2adb3069b0e04-53e2c2b9fcfmr988007e87.15.1733495872705; Fri, 06 Dec 2024
 06:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-2-brgerst@gmail.com>
 <20241206123207.GA2091@redhat.com> <CAMj1kXGKCJfBVqgsqjX1bA_SY=503Z-tJV893y5JAwoVs0BUfw@mail.gmail.com>
 <20241206142152.GB31748@redhat.com>
In-Reply-To: <20241206142152.GB31748@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 6 Dec 2024 15:37:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
Message-ID: <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
To: Oleg Nesterov <oleg@redhat.com>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 15:22, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 12/06, Ard Biesheuvel wrote:
> >
> > On Fri, 6 Dec 2024 at 13:32, Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > +#ifdef CONFIG_STACKPROTECTOR
> > >  /* needed for Clang - see arch/x86/entry/entry.S */
> > >  PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
> > > +#endif
> > >
> > >  #ifdef CONFIG_X86_64
> > >  /*
> >
> > This shouldn't be necessary - PROVIDE() is only evaluated if a
> > reference exists to the symbol it defines.
> >
> > Also, I'm failing to reproduce this. Could you share your .config,
> > please, and the error that you get during the build?
>
> Please see the attached .config
>
> without the change above:
>
>         $ make bzImage
>           CALL    scripts/checksyscalls.sh
>           DESCEND objtool
>           INSTALL libsubcmd_headers
>           UPD     include/generated/utsversion.h
>           CC      init/version-timestamp.o
>           KSYMS   .tmp_vmlinux0.kallsyms.S
>           AS      .tmp_vmlinux0.kallsyms.o
>           LD      .tmp_vmlinux1
>         ./arch/x86/kernel/vmlinux.lds:154: undefined symbol `__stack_chk_guard' referenced in expression
>         scripts/Makefile.vmlinux:77: recipe for target 'vmlinux' failed
>         make[2]: *** [vmlinux] Error 1
>         /home/oleg/tmp/LINUX/Makefile:1225: recipe for target 'vmlinux' failed
>         make[1]: *** [vmlinux] Error 2
>         Makefile:251: recipe for target '__sub-make' failed
>         make: *** [__sub-make] Error 2
>
> perhaps this is because my toolchain is quite old,
>
>         $ ld -v
>         GNU ld version 2.25-17.fc23
>
> but according to Documentation/process/changes.rst
>
>         binutils               2.25             ld -v
>
> it is still supported.
>

We're about to bump the minimum toolchain requirements to GCC 8.1 (and
whichever version of binutils was current at the time), so you might
want to consider upgrading.

However, you are right that these are still supported today, and so we
need this fix this, especially because this has been backported to
older stable kernels too.

For the patch,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

