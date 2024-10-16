Return-Path: <stable+bounces-86431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339309A01B8
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 08:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E652528213D
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267EE18CC01;
	Wed, 16 Oct 2024 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWnM+t+d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416918DF7F;
	Wed, 16 Oct 2024 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061330; cv=none; b=d5Z7vZMMj+FFg5ZF/7LAYchsVVXZzVw9aWE2KgCsiu8rdJlfLNXWM+fUYt3hflHpPqYtdPaGN//aVjDChlbMVJ0gTsGBQGr8uc+0K/5ADm46pufVLDMDogVilU/btYw/UZStVLkyVHNZEfHE32p4HKBcYsotHQB0+nOWYIcXDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061330; c=relaxed/simple;
	bh=fmU7uxTE54D0PHJcTsRBgR1QW1OTKNsFQljXPaCsJRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNg09MX6FtqDo63eUwaQICTce8+Xai5C97EqdYSXhU+ydnrEgA4rvcwjE7KB0CRHmKR+nVs5nYHuDHDahdGl28JKKfX8jgCSrmBh7YGzRPM1ZhivARuGIHe7sjRduduf3WVX/fQfBjpHY8yrUuAsKZhmWjXNfQNjgO5nYeJBHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWnM+t+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C365C4CECF;
	Wed, 16 Oct 2024 06:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729061330;
	bh=fmU7uxTE54D0PHJcTsRBgR1QW1OTKNsFQljXPaCsJRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VWnM+t+d/k1rHK9tCiLGn7AHfjOCmrz/bng8NXy08SjSDwsKJwHilBgpTEvYcK3+Q
	 gD65vJSlxV42tiHdEEUnAwWMLfkzujYa97w8zfnJcLQPO5gmSs2fXJgG0ckd+FbA5y
	 Rsx+p1UOLntozP24AaoCZ/sQl7/xNdAOHPwu4rT5cyTcLACDfDcIpzGlDX2TLNgjhp
	 Pt4v//HKh+mdtd8p0BMDxE7GXRWI9yfVSBIUQmiQKHljmNgY/uu2rK57k7QxeZfpu8
	 /+jiRxI9ZiN5PqkHoFDcRxitIwypIpgKeQbdut/hX+AKYifpKg2o837s1uYtqGOgXn
	 9ZZaBQaeAywXQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so35816361fa.1;
        Tue, 15 Oct 2024 23:48:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUbt5oATHNKb6xiZdfx0ORLHKqnG+vWAWB8njyrHcI4s6lPfM7nciQQNQiRAY15kmmMrYmuZtvYpqxGb41omo=@vger.kernel.org, AJvYcCWuqG7SN/g8dOaeTsRyxAqn51JDBMeL6dBsvZW1F8XCZ3q3+OdNLIDA2D1nA+AkCl8qi7+m10pC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9vHV9or8cBc4IImcqHVFWfIppMjLl/F3TVfupACI1kqclrlzT
	HS2Ron2+O2feY9m8RjAKC8hnGKILD+tFzJ5pIBR0Vlx/t8gbDqXBdQfhC3B5R1Xj91gxfJM0+zy
	GxjOKMBFDm6meUSqrW3/fu8sG80w=
X-Google-Smtp-Source: AGHT+IG9tnlXI2ZfzZkeEyz6reqUWeb7wdqsPblvzu3blaMxGsNfStStdPddqdSzbtCARYKog1dKSyNsxvGJwYlUOhg=
X-Received: by 2002:a2e:a544:0:b0:2fa:d317:b777 with SMTP id
 38308e7fff4ca-2fb61b3e457mr19589811fa.2.1729061328835; Tue, 15 Oct 2024
 23:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009124352.3105119-2-ardb+git@google.com> <202410141357.3B2A71A340@keescook>
 <CAMj1kXF7aFyBOOxQQsvsAsnvo3FYrkU=KA1BiMeSuKq1KHC1qA@mail.gmail.com> <20241016021045.GA1000009@thelio-3990X>
In-Reply-To: <20241016021045.GA1000009@thelio-3990X>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 16 Oct 2024 08:48:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEprSJpugRhVt7x2c1QfYxzFPHyBukpntPekT5N0ED-aA@mail.gmail.com>
Message-ID: <CAMj1kXEprSJpugRhVt7x2c1QfYxzFPHyBukpntPekT5N0ED-aA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/stackprotector: Work around strict Clang TLS
 symbol requirements
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, x86@kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Brian Gerst <brgerst@gmail.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Oct 2024 at 04:10, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Tue, Oct 15, 2024 at 12:56:57PM +0200, Ard Biesheuvel wrote:
> > On Mon, 14 Oct 2024 at 22:59, Kees Cook <kees@kernel.org> wrote:
> > >
> > > On Wed, Oct 09, 2024 at 02:43:53PM +0200, Ard Biesheuvel wrote:
> > > > However, if a non-TLS definition of the symbol in question is visib=
le in
> > > > the same compilation unit (which amounts to the whole of vmlinux if=
 LTO
> > > > is enabled), it will drop the per-CPU prefix and emit a load from a
> > > > bogus address.
> > >
> > > I take this to mean that x86 32-bit kernels built with the stack
> > > protector and using Clang LTO will crash very quickly?
> > >
> >
> > Yeah. The linked issue is not quite clear, but it does suggest things
> > are pretty broken in that case.
>
> Yeah, i386_defconfig with CONFIG_LTO_CLANG_FULL=3Dy explodes on boot for
> me without this change:
>
>   [    0.000000] Linux version 6.12.0-rc3-00044-g2f87d0916ce0 (nathan@the=
lio-3990X) (ClangBuiltLinux clang version 19.1.2 (https://github.com/llvm/l=
lvm-project.git 7ba7d8e2f7b6445b60679da826210cdde29eaf8b), ClangBuiltLinux =
LLD 19.1.2 (https://github.com/llvm/llvm-project.git 7ba7d8e2f7b6445b60679d=
a826210cdde29eaf8b)) #1 SMP PREEMPT_DYNAMIC Tue Oct 15 19:00:21 MST 2024
>   ...
>   [    0.631002] Freeing unused kernel image (initmem) memory: 936K
>   [    0.631613] Kernel panic - not syncing: stack-protector: Kernel stac=
k is corrupted in: free_initmem+0x95/0x98
>   [    0.632606] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-=
rc3-00044-g2f87d0916ce0 #1
>   [    0.633467] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>   [    0.634583] Call Trace:
>   [    0.634837]  panic+0xd4/0x2cc
>   [    0.635146]  ? _vdso_rng_data+0xd80/0xd80
>   [    0.635550]  ? _vdso_rng_data+0xd80/0xd80
>   [    0.635965]  ? rest_init+0xb0/0xb0
>   [    0.636312]  __stack_chk_fail+0x10/0x10
>   [    0.636701]  ? free_initmem+0x95/0x98
>   [    0.637074]  free_initmem+0x95/0x98
>   [    0.637434]  ? _vdso_rng_data+0xd80/0xd80
>   [    0.637838]  ? rest_init+0xb0/0xb0
>   [    0.638196]  kernel_init+0x42/0x1e4
>   [    0.638558]  ret_from_fork+0x2b/0x40
>   [    0.638922]  ret_from_fork_asm+0x12/0x18
>   [    0.639331]  entry_INT80_32+0x108/0x108
>   [    0.639864] Kernel Offset: disabled
>   [    0.640224] ---[ end Kernel panic - not syncing: stack-protector: Ke=
rnel stack is corrupted in: free_initmem+0x95/0x98 ]---
>
> I can confirm that this patch resolves that issue for me and LKDTM's
> REPORT_STACK_CANARY test passes with that configuration.
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>

Thanks.

> I presume the '#ifndef CONFIG_X86_64' in arch/x86/entry/entry.S is
> present because only X86_32 uses '-mstack-protector-guard-reg=3D'? I
> assume that will disappear when X86_64 supports this option (IIRC that
> was the plan)?
>

Yes, I noticed this issue while enabling
'-mstack-protector-guard-reg=3D' for x86_64, but i386 is already broken.

