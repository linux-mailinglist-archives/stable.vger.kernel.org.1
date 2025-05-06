Return-Path: <stable+bounces-141774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FDDAAC04B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 11:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE8E3B600C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63F9267389;
	Tue,  6 May 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7kAkwfX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072026FD8B;
	Tue,  6 May 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524478; cv=none; b=ea2pDy48i71a4QzUT5yVzO8G9a6oyn7bSlhoEpNf+qxdLbhng4BUujUs0k2EVdZNxKPxVKpNwkOESozxx06fIbgFvT1yafjEXMKQ5FaZ61Szl35AsLkhgP9xCbNR7T3X1exQsJ9gaHayvRinzclbUwAD44AvuzDXWmT8RoGp4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524478; c=relaxed/simple;
	bh=br72ww44nN9vuAjzP+3KW+ZVFIk7/0bblmuQ7sdKp3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TET/l4AxVp86VGsVIhg5bHQO0K0N4NrZ1Z4ib4F5gnJroVnk8g4rnZZpE6zMs5+FzN1EN8bIBNTqJw17aLFc0Z3h5n57HzS6xuKIJ4TX2Tgv0n5osFFN51/RN7MPay8x8pRGAX0nAlwUjn9dU5+U0AVEU0pnyWge+feQRw8dmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7kAkwfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20186C4CEF2;
	Tue,  6 May 2025 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746524478;
	bh=br72ww44nN9vuAjzP+3KW+ZVFIk7/0bblmuQ7sdKp3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C7kAkwfXVBJgJLjRZHUyukIyhm03dtJAasR/1UdcHz+JzfvPuMhC32t33R51WK/Qg
	 P7uNYYLu2hzyCMjbRsD05nI852tLfx9s3uiQutpvdCoJYDUth/bzLlz5jlyHeO359x
	 Lp2RWOKnOXJFgai/zCGcQpN8XShh6xdhOefiROEncGCzfTNf8P08Sim6d1G9rNK419
	 sA08qCHEUpJVENk1wkgAbNx+ZvQhC4IvzIMaUXa7eFeDhrqYf46z0CY78C1DXXhZZb
	 hPmFzEl/VtK8/Y5scGLWPd717pb2TyxWIThqS2aXcgexjuUW/t6KWRI6YAm8QytKDo
	 ttUxIoJgWmXWA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-549963b5551so6026911e87.2;
        Tue, 06 May 2025 02:41:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+PAb46JT/1ICExEaokBCNBXANnpB+ZQPEil8NGSbqdTqicmJ4W63vkqjPXn5Sk/iOTeCkhBqD@vger.kernel.org, AJvYcCU+u+nTVvGHu74DVHT93cW2UbDI3kXuwYvkuEL+MmqaG5V10OabCws6tAXK2rti1obHOhvH96MQayrc8aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNSFk+bIdKEgRxu57ajIxdzFiXpbe+m0VpoHt+l+Qv2rBn7M+
	4Vt98zzYpLTSatNRqXbZAGvDyHpHbyYNJDGBLYx7M0rpynC8Isyf23hBgTyrUS3K429CXZga5T5
	KQdU4P9p9qWbXyYUPgXix0UAuif4=
X-Google-Smtp-Source: AGHT+IEjeZbst1pQGA92OmhjPfI/oOusUk2csD0mgQFEIaa7RUAqCWbSuTrzE+pZLh2YflGxsAOAY9FTC9nE+zZ0n6I=
X-Received: by 2002:a05:6512:a85:b0:545:2300:9256 with SMTP id
 2adb3069b0e04-54fb4a30ea0mr751630e87.12.1746524476461; Tue, 06 May 2025
 02:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502180412.3774883-1-yeoreum.yun@arm.com> <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com> <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com> <aBnDqvY5c6a3qQ4H@e129823.arm.com> <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
In-Reply-To: <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 6 May 2025 11:41:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFAYDeCgtPspQubkY688tcqwCMzCD+jEXb6Ea=9mBcdcQ@mail.gmail.com>
X-Gm-Features: ATxdqUF3rsIatyGROlcnz-MTnOMfbB4SgCxO0t-VeVXO3pVmMlbooW1DvC6xzx4
Message-ID: <CAMj1kXFAYDeCgtPspQubkY688tcqwCMzCD+jEXb6Ea=9mBcdcQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, broonie@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, 
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com, 
	hardevsinh.palaniya@siliconsignals.io, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 10:16, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 06/05/2025 09:09, Yeoreum Yun wrote:
> > Hi Catalin,
> >
> >> On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
> >>> Hi Catalin,
> >>>
> >>>> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> >>>>> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> >>>>>> create_init_idmap() could be called before .bss section initialization
> >>>>>> which is done in early_map_kernel().
> >>>>>> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> >>>>>>
> >>>>>> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> >>>>>> and this variable places in .bss section.
> >>>>>>
> >>>>>> [...]
> >>>>>
> >>>>> Applied to arm64 (for-next/fixes), with some slight tweaking of the
> >>>>> comment, thanks!
> >>>>>
> >>>>> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> >>>>>       https://git.kernel.org/arm64/c/12657bcd1835
> >>>>
> >>>> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> >>>> version I have around (Debian sid) fails to boot, gets stuck early on:
> >>>>
> >>>> $ clang --version
> >>>> Debian clang version 19.1.5 (1)
> >>>> Target: aarch64-unknown-linux-gnu
> >>>> Thread model: posix
> >>>> InstalledDir: /usr/lib/llvm-19/bin
> >>>>
> >>>> I didn't have time to investigate, disassemble etc. I'll have a look
> >>>> next week.
> >>>
> >>> Just for your information.
> >>> When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
> >>>  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
> >>>
> >>> and the default version for sid is below:
> >>>
> >>> $ clang-19 --version
> >>> Debian clang version 19.1.7 (3)
> >>> Target: aarch64-unknown-linux-gnu
> >>> Thread model: posix
> >>> InstalledDir: /usr/lib/llvm-19/bin
> >>>
> >>> When I tested with above version with arm64-linux's for-next/fixes
> >>> including this patch. it works well.
> >>
> >> It doesn't seem to be toolchain related. It fails with gcc as well from
> >> Debian stable but you'd need some older CPU (even if emulated, e.g.
> >> qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
> >> Neoverse-N2. Also changing the annotation from __ro_after_init to
> >> __read_mostly also works.
>
> I think this is likely because __ro_after_init is also "ro before init" - i.e.
> if you try to write to it in the PI code an exception is generated due to it
> being mapped RO. Looks like early_map_kernel() is writiing to it.
>

Indeed.

> I've noticed a similar problem in the past and it would be nice to fix it so
> that PI code maps __ro_after_init RW.
>

The issue is that the store occurs via the ID map, which only consists
of one R-X and one RW- section. I'm not convinced that it's worth the
hassle to relax this.

If moving the variable to .data works, then let's just do that.

