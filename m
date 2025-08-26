Return-Path: <stable+bounces-172934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 454C6B359F7
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AF11B66531
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BE329D273;
	Tue, 26 Aug 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPtLm3/t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A01EE7B9;
	Tue, 26 Aug 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203512; cv=none; b=p9vgwWPceMWiMYpaHeCPUTGVNvTvnKYKwcTS7xQhoWa6YZN2R9mBHwvqzCGE/KhKht1wuEDTc4neeoVzrA6JQSxApE9ygTndt/VhwkbQTSPHWbkU8bw4Hrewh8W4wo8emhAtzdBUP6ov3hJKW8jMo5y0zevmIRrdebQima84G6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203512; c=relaxed/simple;
	bh=XW94ARsAYWdpvdAcDSjqwuuAwW3+zyLA+n3xm8R6vww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcPhgrdW0C3wrmN/CTkhLdU7nCPA0bvCc6R+fkSHQpFigjlCkLqQK9ijbUYqkIv1fTYOitKmDrUjiMf/UlfLCRcpyPIJ1fuK6xomYSQVhX/sF4qOl2QD94tVYnfmnlP4OccpJ3JQhRrNJ56TjWNDhrE9qBkoPcIIoUS8drVSDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPtLm3/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB63DC116D0;
	Tue, 26 Aug 2025 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756203511;
	bh=XW94ARsAYWdpvdAcDSjqwuuAwW3+zyLA+n3xm8R6vww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qPtLm3/t0KCfoA+fQ0IaW8dA+DhnsTTxkhpPJ5XPQEQwQo/j750JGyIp2sOeTtTCo
	 RANtT1wJYrMdhaR04YWep4xlZGIPOjSx5rvbOSWYLPTyZHwxdcObucLZ87zIJcHurR
	 mMJ12pPRxDYJdTVLF5JjE6i2GFLi+N2i/Mz0SLtjRnC5kULuBMO9JoXmmj9bWC5Tkv
	 eHPx+46dTcgLwaud8jDqsYHOs7mYvPTErIMAi4YkSK7eFhaLuSbq6X0b9hEDtpNZ6v
	 Pe2HTrYfEkNyrkWvQ2vbs4qB0BeIb1hTUbigXB2ye5oBOlbuGb1lLrSmqNtfCyhQYI
	 bc+n6xFRqhhWQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f3a3f2f60so2314658e87.2;
        Tue, 26 Aug 2025 03:18:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVLQZqBzMputDqF3AXUvLsK6OPGWU/u9NKNUAnLO4HMvXbo2oVScpaYX+CkjS8yDyWqLXpKhxG@vger.kernel.org, AJvYcCVcwM5Obow9+Azdfv/q+0BU0RNiyXbwjQhE0hXxnYs2bUdv7oeENHNaldhmISpzHmUl99n4dRe+vZgPuN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83AfwJKbkk2OBhbtaZrZA7ItdSB5Z2to3qMVHqQ59UU9ddqMG
	uck4gT/1GIah9a472iDh7/eiOKsCBXKCytMRAHwRy7CXCW6XtyCbElHP4axsXLy2E4qp1qpQW2O
	2Jf2nguhnEPbcnwrby9af2W/g3jLnykA=
X-Google-Smtp-Source: AGHT+IF/0ug3SV/FAX5eoPEUU/Da+VDJuyPoxaddRGepCWv1w/xY4z4BQAzf4549DpJ+aBumgQFf+tT6KaBI6cSKHFY=
X-Received: by 2002:a05:6512:2282:b0:55f:4f99:f3cb with SMTP id
 2adb3069b0e04-55f4f99f618mr290219e87.15.1756203510050; Tue, 26 Aug 2025
 03:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041526.467434-1-CFSworks@gmail.com> <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
 <CAH5Ym4gTTLcyucnXjxFtNutVR1HQ0G2k_YBSNO-7G3-4YXUtag@mail.gmail.com> <aK2DV_joOnaU85Tx@J2N7QTR9R3>
In-Reply-To: <aK2DV_joOnaU85Tx@J2N7QTR9R3>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 26 Aug 2025 12:18:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGWjC3_hNDUxiZWU6UVHoViU=iZuZ2VbCsaqDr-5tMK8w@mail.gmail.com>
X-Gm-Features: Ac12FXxBzU25zpKnUCQ1ltgebYmqMtG_M6IUTnGxLleVMo1UTZ2tTlc1ZEsKm40
Message-ID: <CAMj1kXGWjC3_hNDUxiZWU6UVHoViU=iZuZ2VbCsaqDr-5tMK8w@mail.gmail.com>
Subject: Re: [PATCH] arm64/boot: Zero-initialize idmap PGDs before use
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sam Edwards <cfsworks@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baruch Siach <baruch@tkos.co.il>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025 at 11:50, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Sat, Aug 23, 2025 at 04:55:44PM -0700, Sam Edwards wrote:
> > On Sat, Aug 23, 2025 at 3:25=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > Hi Sam,
> > >
> > > On Fri, 22 Aug 2025 at 14:15, Sam Edwards <cfsworks@gmail.com> wrote:
> > > >
> > > > In early boot, Linux creates identity virtual->physical address map=
pings
> > > > so that it can enable the MMU before full memory management is read=
y.
> > > > To ensure some available physical memory to back these structures,
> > > > vmlinux.lds reserves some space (and defines marker symbols) in the
> > > > middle of the kernel image. However, because they are defined outsi=
de of
> > > > PROGBITS sections, they aren't pre-initialized -- at least as far a=
s ELF
> > > > is concerned.
> > > >
> > > > In the typical case, this isn't actually a problem: the boot image =
is
> > > > prepared with objcopy, which zero-fills the gaps, so these structur=
es
> > > > are incidentally zero-initialized (an all-zeroes entry is considere=
d
> > > > absent, so zero-initialization is appropriate).
> > > >
> > > > However, that is just a happy accident: the `vmlinux` ELF output
> > > > authoritatively represents the state of memory at entry. If the ELF
> > > > says a region of memory isn't initialized, we must treat it as
> > > > uninitialized. Indeed, certain bootloaders (e.g. Broadcom CFE) inge=
st
> > > > the ELF directly -- sidestepping the objcopy-produced image entirel=
y --
> > > > and therefore do not initialize the gaps. This results in the early=
 boot
> > > > code crashing when it attempts to create identity mappings.
> > > >
> > > > Therefore, add boot-time zero-initialization for the following:
> > > > - __pi_init_idmap_pg_dir..__pi_init_idmap_pg_end
> > > > - idmap_pg_dir
> > > > - reserved_pg_dir
> > >
> > > I don't think this is the right approach.
> > >
> > > If the ELF representation is inaccurate, it should be fixed, and this
> > > should be achievable without impacting the binary image at all.
> >
> > Hi Ard,
> >
> > I don't believe I can declare the ELF output "inaccurate" per se,
> > since it's the linker's final determination about the state of memory
> > at kernel entry -- including which regions are not the loader's
> > responsibility to initialize (and should therefore be initialized at
> > runtime, e.g. .bss). But, I think I understand your meaning: you would
> > prefer consistent load-time zero-initialization over run-time. I'm
> > open to that approach if that's the consensus here, but it will make
> > `vmlinux` dozens of KBs larger (even though it keeps `Image` the same
> > size).
>
> Our intent was that these are zeroed at build time in the Image. If the
> vmlinux isn't consistent with that, that's a problem with the way we
> generate the vmlinux, and hence "the ELF representation is inaccurate".
>
> I agree with Ard that it's better to bring the vmlinux into line with
> that (if we need to handlr this at all), even if that means making the
> vmlinux a few KB bigger.
>

Indeed. And actually, it should still be the ELF loader's job to
zero-initialize NOBITS sections, so ideally, we'd make these NOBITS
rather than PROGBITS, and the bloat issue should go away.

If the ELF loader in question relies on the executable's startup code
to clear NOBITS sections, it needs to be fixed in any case. Clearing
BSS like we do at startup time is really only appropriate for
bare-metal images such as arm64's Image, but a platform that elects to
use an ELF loader instead (even though that is not a supported
bootable format for arm64 Linux) should at least adhere to the ELF
spec.

