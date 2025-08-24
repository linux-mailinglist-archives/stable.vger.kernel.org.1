Return-Path: <stable+bounces-172686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 490C8B32D56
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 05:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20AD1882215
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 03:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B98B1448D5;
	Sun, 24 Aug 2025 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqyXF21h"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42BA55;
	Sun, 24 Aug 2025 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756004720; cv=none; b=lvhqB/ZHwRfqKH3XsxkD3q/zjeH8vftABz+vFkYnYaCRWgcRFb/OwGXwz/AVx8E5Z4+SvJGLuQHlbzb5oOaoTTkxo8OkvmXXIfgPU1dD4TZCPdLSKe/Mv+vzQwO0kI7qSSJ9TqtbBBltwg+Alcz3hayBVwmsf/D6JwdMAeTzTKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756004720; c=relaxed/simple;
	bh=4jyWtrQc8g2pI2pic4k6+wyMVGvRVzOyfNe1d7hw3Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD88uZOKc4thIrUbdPGSwy3+q3B4rOMywW0Zm+n4EnEU7GmahXN3i/YYrnAEhAKj0ru8rGSvxd4+CC+xRjZXxCyTMbvXkEJYmnzD3ncHqbspWGxIZp5T/BlysOKZdCEACGpbtza1lIR8WWokl25My+e11D6MfzZUHAk0YFCiMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqyXF21h; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c84925055aso365100f8f.2;
        Sat, 23 Aug 2025 20:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756004717; x=1756609517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jyWtrQc8g2pI2pic4k6+wyMVGvRVzOyfNe1d7hw3Kg=;
        b=kqyXF21hR/ew1NnnXJ220fKwPS/byS144ltCldPXztl4X2k8ArWB2rEdXbiAAercu3
         bYuq8HEqBua2+AvEQikFy9+j/7JTNUFEAqE9RLgtFutzIgNu8YqSLz0zBx7XwuPbjhcq
         6FsNoJSx4wvXwnYFjTgTkm54jRKTAiRR4HTSM9LFe3bitTaK3z6CYnJcb8HalxatNziL
         RdqftN3zsGtbxyF8MMPEDzkIP3ksPa/UG9EiCUOkWM9dpu7ArGODEHek1Nau6vwp2e2g
         1mtbU6jMA1/70+pxbyi2Tc2+PkdFzbPPW5eY5WjLiCuNHzZQgiYA/Izpu+edVNWRNnZj
         Dlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756004717; x=1756609517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jyWtrQc8g2pI2pic4k6+wyMVGvRVzOyfNe1d7hw3Kg=;
        b=mbc2+JdlhHcoziMYE0KuuRnCmUeGdex8qSWOqCAW1aMUcgv7A+dexn/fvaM9uN0t2J
         9YXB2KWlfvWPGStVFVw9oPPvksboHhlaIvytkVZVxOBp56LBN/g/vaF0+uBiRQLVINhd
         AUbHisBQ+SS9tBFAHRjxltI4CtAGf4DWRGH10nyt6vY1chqim9x74FqICb76GGBzsNEn
         7ZvoLiVp4ap2MHThaTZVnqrqH1L3jJ9zNnhUZ/8MD1EEWcgBtiTPUyC0oGpa0XHvqH9B
         /r4eflKaMZnJhPK+QQd5qBkv/MmU4inxXTg8d3y6EJgq5YmGfgDHZvUZw79x2dNnsoWT
         CwZw==
X-Forwarded-Encrypted: i=1; AJvYcCUvaWGVOzBMjGOKal5LCEC3H2dOtIjeD6TcAfzyENditnBlazaaWAMzGn7RDE+4rGI3wwOVUM9y@vger.kernel.org, AJvYcCVt1CU5S9j3t+a6QQ2q7m6N2md3c8ZXkz3ByaLWUv93aOJiV/WiF8UVamS6nbBF48Eu1FKDgikTl0M6+8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4a/NiYeDXRb479blp4yuNq3toFh/b5frSKydO28+wJ1jlKDcy
	K9Pq7CfP8ktqD7hI/byRyAr1ypICUMAAP/Cx3CWtkyAPHf139LxpLIULgZ0XNZfstpw2zz75LP0
	rg7YzIxSibECsDB+b0rT99bsdR41ENLk=
X-Gm-Gg: ASbGncvXk+EDIWK95OFqikWmlKVmCcDVQaL8vlszzw/X/cvRocS6J0h9BgOubRPBwB0
	gr2iuhFGYWmyMs88rI2UTQXX/ocskRBNFJnxVkFkPGucyXU8s2hQxENnS/xbwDdImAyoPpF+3PL
	XyQZnPBfBaqfx0HlwpqyynmociwrvMQ90cWNRIgUNH5ja0ivf/asQfhFh3QlowG24rx5ksAFYYJ
	xRC+j6Hxgy2nQiL3ixdNfAU3EwKcwzwdPKvm9Bo11Wcy2hcAjHuAU4RBQQq4usx93NiKLpDVfkL
	MmJeLPg=
X-Google-Smtp-Source: AGHT+IE/tovVvnSvhovKx4wpdK0zjfz7bDptLp7GrOq9JmFQOIKGH33Ed0788RfMSUGXgzGH/fAnHqRaO9pTqakyng8=
X-Received: by 2002:a05:6000:18aa:b0:3c7:89d1:1d85 with SMTP id
 ffacd0b85a97d-3c789d12c99mr2184560f8f.18.1756004716482; Sat, 23 Aug 2025
 20:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041526.467434-1-CFSworks@gmail.com> <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
 <CAH5Ym4gTTLcyucnXjxFtNutVR1HQ0G2k_YBSNO-7G3-4YXUtag@mail.gmail.com> <CAMj1kXF00Y0=67apXVbOC+rpbEEvyEovFYf4r_edr6mXjrj0+A@mail.gmail.com>
In-Reply-To: <CAMj1kXF00Y0=67apXVbOC+rpbEEvyEovFYf4r_edr6mXjrj0+A@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sat, 23 Aug 2025 20:05:05 -0700
X-Gm-Features: Ac12FXyI67lJWWDgtcYQ1v8MsKjdO7Ht761tYvtQRRVx6LSYMJ2W4IX8vn5NvMo
Message-ID: <CAH5Ym4h+2w6aayzsVu__3qu3-6ETq1HK7u18yGzOrRqZ--2H9w@mail.gmail.com>
Subject: Re: [PATCH] arm64/boot: Zero-initialize idmap PGDs before use
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baruch Siach <baruch@tkos.co.il>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 5:29=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Sun, 24 Aug 2025 at 09:56, Sam Edwards <cfsworks@gmail.com> wrote:
> >
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
> >
>
> Indeed, I'd like the ELF representation to be such that only the tail
> end of the image needs explicit clearing. A bit of bloat of vmlinux is
> tolerable IMO.

Since the explicit clearing region already includes the entirety of
__pi_init_pg_dir, would it make sense if I instead move the other
pg_dir items (except __pi_init_idmap_pg_dir) inside that region too,
both to keep them all grouped and to ensure that they're all cleared
in the same go? I'd still need to handle __pi_init_idmap_pg_dir, and
it would mean that reserved_pg_dir is first installed in TTBR1_EL1 a
few cycles before being zeroed, but beyond those two drawbacks it
sounds simpler to me, reduces the image size by a few pages, and meets
the "only clear the tail end" goal.

> Note that your fix is not complete: stores to memory done with the MMU
> and caches disabled need to be invalidated from the D-caches too, or
> they could carry stale clean lines. This is precisely the reason why
> manipulation of memory should be limited to the bare minimum until the
> ID map is enabled in the MMU.

ACK. ARM64 caches are one of those things that I understand in
principle but I'm still learning all of the gotchas. I appreciate that
you shared this insight despite rejecting the overall approach!

> > >
> > > > - tramp_pg_dir # Already done, but this patch corrects the size
> > > >
> > >
> > > What is wrong with the size?
> >
> > On higher-VABIT targets, that memset is overflowing by writing
> > PGD_SIZE bytes despite tramp_pg_dir being only PAGE_SIZE bytes in
> > size.
>
> Under which conditions would PGD_SIZE assume a value greater than PAGE_SI=
ZE?

I might be doing my math wrong, but wouldn't 52-bit VA with 4K
granules and 5 levels result in this?

Each PTE represents 4K of virtual memory, so covers VA bits [11:0]
(this is level 3)
Each PMD has 512 PTEs, the index of which covers VA bits [20:12] (this
is level 2)
Each PUD references 512 PMDs, the index covering VA [29:21] (this is level =
1)
Each P4D references 512 PUDs, indexed by VA [38:30] (this is level 0)
The PGD, at level -1, therefore has to cover VA bits [51:39], which
means it has a 13-bit index: 8192 entries of 8 bytes each would make
it 16 pages in size.

> Note that at stage 1, arm64 does not support page table concatenation,
> and so the root page table is never larger than a page.

Doesn't PGD_SIZE refer to the size used for userspace PGDs after the
boot progresses beyond stage 1? (What do you mean by "never" here?
"Under no circumstances is it larger than a page at stage 1"? Or
"during the entire lifecycle of the system, there is no time at which
it's larger than a page"?)

Thanks for your time and attention to this,
Sam

