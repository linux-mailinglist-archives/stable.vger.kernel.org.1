Return-Path: <stable+bounces-172668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C28B32CB3
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 02:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B87446721
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 00:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456AB72613;
	Sun, 24 Aug 2025 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neLs/0m5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3895211F;
	Sun, 24 Aug 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755995367; cv=none; b=YwY9pFlD7qqtwcCGWOhJe6WXWlQInbHD0I1UfMB8sA06ZO4ODrcY3uuMcSUhNpKSB2ovt7jqHEFryzorCtglQkpZHhz0EKIzys9Rf5nMkIbPcna0w+l0LjWRfMViC+PBLN60AyqQZzExgVlUL2qNHYjhKVPTwi1SUuU6i+SezGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755995367; c=relaxed/simple;
	bh=ZS1Pmn3yqYykXEYlhI/MX9i0W3Yj98iOBAiItOhZVaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6/QuEecKydrH2tstOPbfMWzJmMKtI95mtwlvyiJNRI6Roz2yB4tHeMnTFgVRmvQeYZRRn72aHx0AVwLBDu+x2fFpISwBaZEI8LT76gGabXmpBFYVAMpA9NXSzU08IspDBqzCSi80W3vYEjQroa1OaxCLqJ4WUR2C8epEIRWL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neLs/0m5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4A6C113D0;
	Sun, 24 Aug 2025 00:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755995366;
	bh=ZS1Pmn3yqYykXEYlhI/MX9i0W3Yj98iOBAiItOhZVaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=neLs/0m5O+k7OmfrAg0NTpe0LOifYqrvnXhx8YpdoTZ8h7842r7dIxuwIsofkhbOE
	 jXbIdFDWqDPGblF0SoggrZssVfmuml0OKO+Td1E4hPYLuWIWz7IywWb06vFYk55Cft
	 zKLF5qkdxrAHn9YyrDFFgEWleuvLbUYH2lxFk3YQn6qhalZdYNhUQ5sMk9s+8PUTh2
	 iSUbDzIwo4YLvXP8GJMltw7RR8HuMiYpIB39r2vbNcQBcGNqy1YUuBjq/mBGxowT1T
	 ycuCK+IG+r8Zx9U03WlgvHkaXJ+Rtu/I270qWe+GWENkpJSDneahTd1PhANgbkRxqm
	 bvcjtMrgZw3gQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f3dcb2b9fso485422e87.1;
        Sat, 23 Aug 2025 17:29:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmlk4sndDQVlSm9cydpF5EqpI7QQdpO00vIPplxpZ0egMc1vFDRSBTkZYginoGFLV/KtGVxfn4Zfm5O9Y=@vger.kernel.org, AJvYcCWvBRW4GNRbHkmGk0gtBjrv5jfxO9WxVD7DN8p2kVL9MQmRB5eOKbwQmIRwpLvkiybbS80AQqUo@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmjownrDe16z+fvRdh4sVYReLzWBJz1/rWzm3raHc2hgDsqOx
	LbZwXIbtSS686kg5v7sNuoLUktJfdUQMs92H+LM2jKoSYW4fPvy/VAUS29Fl/cCswxQr+2N2jxq
	00zd2kLVTlbmEdOKkm3GE+/MxzN1h4z4=
X-Google-Smtp-Source: AGHT+IHetBc+qV1sYoQ7G48l8PH/wSQryi0VIQHlCMRsICo02GB2FdJo2ZJ2wt8u1VtB7ilkizOV7y0lBxLVnRC8qP4=
X-Received: by 2002:a05:6512:63d6:20b0:55f:eb7:e1be with SMTP id
 2adb3069b0e04-55f0eb7e248mr1508559e87.6.1755995364734; Sat, 23 Aug 2025
 17:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041526.467434-1-CFSworks@gmail.com> <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
 <CAH5Ym4gTTLcyucnXjxFtNutVR1HQ0G2k_YBSNO-7G3-4YXUtag@mail.gmail.com>
In-Reply-To: <CAH5Ym4gTTLcyucnXjxFtNutVR1HQ0G2k_YBSNO-7G3-4YXUtag@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 24 Aug 2025 10:29:12 +1000
X-Gmail-Original-Message-ID: <CAMj1kXF00Y0=67apXVbOC+rpbEEvyEovFYf4r_edr6mXjrj0+A@mail.gmail.com>
X-Gm-Features: Ac12FXxcUNd_f0UkC6N6FYHMSqWFXrcHvK9WPOz9rtw9Q7N35R1BhKCa6AeFuX0
Message-ID: <CAMj1kXF00Y0=67apXVbOC+rpbEEvyEovFYf4r_edr6mXjrj0+A@mail.gmail.com>
Subject: Re: [PATCH] arm64/boot: Zero-initialize idmap PGDs before use
To: Sam Edwards <cfsworks@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baruch Siach <baruch@tkos.co.il>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Aug 2025 at 09:56, Sam Edwards <cfsworks@gmail.com> wrote:
>
> On Sat, Aug 23, 2025 at 3:25=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > Hi Sam,
> >
> > On Fri, 22 Aug 2025 at 14:15, Sam Edwards <cfsworks@gmail.com> wrote:
> > >
> > > In early boot, Linux creates identity virtual->physical address mappi=
ngs
> > > so that it can enable the MMU before full memory management is ready.
> > > To ensure some available physical memory to back these structures,
> > > vmlinux.lds reserves some space (and defines marker symbols) in the
> > > middle of the kernel image. However, because they are defined outside=
 of
> > > PROGBITS sections, they aren't pre-initialized -- at least as far as =
ELF
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
> > > the ELF directly -- sidestepping the objcopy-produced image entirely =
--
> > > and therefore do not initialize the gaps. This results in the early b=
oot
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
>

Indeed, I'd like the ELF representation to be such that only the tail
end of the image needs explicit clearing. A bit of bloat of vmlinux is
tolerable IMO.

Note that your fix is not complete: stores to memory done with the MMU
and caches disabled need to be invalidated from the D-caches too, or
they could carry stale clean lines. This is precisely the reason why
manipulation of memory should be limited to the bare minimum until the
ID map is enabled in the MMU.


> >
> > > - tramp_pg_dir # Already done, but this patch corrects the size
> > >
> >
> > What is wrong with the size?
>
> On higher-VABIT targets, that memset is overflowing by writing
> PGD_SIZE bytes despite tramp_pg_dir being only PAGE_SIZE bytes in
> size.

Under which conditions would PGD_SIZE assume a value greater than PAGE_SIZE=
?

Note that at stage 1, arm64 does not support page table concatenation,
and so the root page table is never larger than a page.

