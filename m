Return-Path: <stable+bounces-172931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1C4B3595B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1644B188EBD5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6E6308F03;
	Tue, 26 Aug 2025 09:50:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F28C305E32;
	Tue, 26 Aug 2025 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201830; cv=none; b=qFOZf0gv/CgE0HBz3t3hySG9yzyZ8QJcRxnIS37BH7VifhenISKhVo/GdeUUfYrIvOx65G1jSTUN9Pu5ZZFqyU7MdfPEqiFe4//768D+jEcAlTPkACYJsROAOg5zeZ6o0JRhRBdyp3R5NEWONrN7QsuXdMLOnRD+AF5wA7YkD5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201830; c=relaxed/simple;
	bh=r5qMbe4kTDDLldGYy/rC48/6xg03WM0XcsMR1LpgIaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjMbKQAjkjh4+/JH4evv5Yy8wsVvpDKspctbr9hVPdj+BalEDjHq8gbGX/44Hy7m5qMZ2OZbCtU1n64vXhFrIV+Zo590sigT0IfJm6uKlyjwpJB2mUA9JArrHVBizMIvGjkU4+vpytkD4uAQDGSxccL2S33KSgrwraorks8Qvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3231C1A00;
	Tue, 26 Aug 2025 02:50:19 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AABA83F63F;
	Tue, 26 Aug 2025 02:50:22 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:50:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/boot: Zero-initialize idmap PGDs before use
Message-ID: <aK2DV_joOnaU85Tx@J2N7QTR9R3>
References: <20250822041526.467434-1-CFSworks@gmail.com>
 <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
 <CAH5Ym4gTTLcyucnXjxFtNutVR1HQ0G2k_YBSNO-7G3-4YXUtag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5Ym4gTTLcyucnXjxFtNutVR1HQ0G2k_YBSNO-7G3-4YXUtag@mail.gmail.com>

On Sat, Aug 23, 2025 at 04:55:44PM -0700, Sam Edwards wrote:
> On Sat, Aug 23, 2025 at 3:25 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Hi Sam,
> >
> > On Fri, 22 Aug 2025 at 14:15, Sam Edwards <cfsworks@gmail.com> wrote:
> > >
> > > In early boot, Linux creates identity virtual->physical address mappings
> > > so that it can enable the MMU before full memory management is ready.
> > > To ensure some available physical memory to back these structures,
> > > vmlinux.lds reserves some space (and defines marker symbols) in the
> > > middle of the kernel image. However, because they are defined outside of
> > > PROGBITS sections, they aren't pre-initialized -- at least as far as ELF
> > > is concerned.
> > >
> > > In the typical case, this isn't actually a problem: the boot image is
> > > prepared with objcopy, which zero-fills the gaps, so these structures
> > > are incidentally zero-initialized (an all-zeroes entry is considered
> > > absent, so zero-initialization is appropriate).
> > >
> > > However, that is just a happy accident: the `vmlinux` ELF output
> > > authoritatively represents the state of memory at entry. If the ELF
> > > says a region of memory isn't initialized, we must treat it as
> > > uninitialized. Indeed, certain bootloaders (e.g. Broadcom CFE) ingest
> > > the ELF directly -- sidestepping the objcopy-produced image entirely --
> > > and therefore do not initialize the gaps. This results in the early boot
> > > code crashing when it attempts to create identity mappings.
> > >
> > > Therefore, add boot-time zero-initialization for the following:
> > > - __pi_init_idmap_pg_dir..__pi_init_idmap_pg_end
> > > - idmap_pg_dir
> > > - reserved_pg_dir
> >
> > I don't think this is the right approach.
> >
> > If the ELF representation is inaccurate, it should be fixed, and this
> > should be achievable without impacting the binary image at all.
> 
> Hi Ard,
> 
> I don't believe I can declare the ELF output "inaccurate" per se,
> since it's the linker's final determination about the state of memory
> at kernel entry -- including which regions are not the loader's
> responsibility to initialize (and should therefore be initialized at
> runtime, e.g. .bss). But, I think I understand your meaning: you would
> prefer consistent load-time zero-initialization over run-time. I'm
> open to that approach if that's the consensus here, but it will make
> `vmlinux` dozens of KBs larger (even though it keeps `Image` the same
> size).

Our intent was that these are zeroed at build time in the Image. If the
vmlinux isn't consistent with that, that's a problem with the way we
generate the vmlinux, and hence "the ELF representation is inaccurate".

I agree with Ard that it's better to bring the vmlinux into line with
that (if we need to handlr this at all), even if that means making the
vmlinux a few KB bigger.

Mark.

