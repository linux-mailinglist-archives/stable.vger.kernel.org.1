Return-Path: <stable+bounces-172667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 858B6B32C98
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 01:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4FA1BC120A
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 23:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C90247DEA;
	Sat, 23 Aug 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmlIRdGB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D77192B7D;
	Sat, 23 Aug 2025 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755993359; cv=none; b=BzRWD6odnOfHywGzaVbH2/S54SVeltwWP2AOA/zqNB1pb0KC/YMnEThwRBEgVa3rSg1alEKC11PxAvsYAXTwYoqfvPPDS29HQV89JmNI5lt8NMgEHgjEUrMhrmTElvUTxliSZrv8bzqOEDqN1uRl6Mhs89z0SVcQIe3w8r0EwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755993359; c=relaxed/simple;
	bh=aX2aDYu4AdsDK5JbbvK4eNjyFRAzNO0/4FuENrsKVSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5vb8Zy5eI3KOGoJUO5RWaoD5S+jaZnGHZdXsp7IpsJb9h+nrPeb+A4mluUGt9XodjxSPjAcsnfQ6K2eIThUp0XiF4yghkA2/OruIMsounkavuAIIk19gQus5hCWbGCWj0wGyoPbibpgYnFQTj2m7NZIZFxIOsn7/I4xtQN4800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmlIRdGB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c79f0a606fso416797f8f.0;
        Sat, 23 Aug 2025 16:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755993356; x=1756598156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/i0r8CSjkvOyfYzF5swg0iOz418PMdocvZNGpsIEKQ=;
        b=lmlIRdGBSBmOFq4MwGcssOoISdteu0Sz3PK+CgPFxtGpSTXc+jiT6IY12XmLIzizBQ
         /r5egO4sK1sdtuppGLlviB42wQMH+3xA+RJhoInHvxYVVaILNCzsRClTqBjN2cdyqkLU
         At4KXUZNdGY3ntF/Q3sm4U4IoRxdnej4CIk6ZO9AaAfqxFoSrG9sBytOqr4UyPvNNLdr
         PGoAYNkNF3jUyuxJ+Aa/zEzsLFQH1TYiGKYj5j58mx9By3oeDLhCGV46afaEe6kmOTne
         rhx2u3IgK82hfzQtvwMZq10yxySjJFhgdh1MC3+eMj+FxkfDtF860af+EFtC54tXN8Mz
         JigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755993356; x=1756598156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/i0r8CSjkvOyfYzF5swg0iOz418PMdocvZNGpsIEKQ=;
        b=Gjq5O8m4I4+ziLuoTVUmsylyV01e764lSVSS/5SNPB+DW3sHvi7omZoCb0rns6kM+n
         tsxhVvRusixi4bdlQt+6fIcy0Y1vmLb1E7A5bageh5i5Fh8Fe84CBG1Im8wRzuNAvY0K
         3mXfSNTVFpX2BzbbmvDNw08FoHsWjrX3xhW8YRX1eXMgvJpOryYyWP5//DGMbqV6B/nL
         8IFuttivZKTzDH/exD87ZfSoFIo2i2L6iIhWgPtGlYWb+Wfvjhdz9/BYLs6I9aUpJ0Ii
         cOgaU/KiJrRpItZJ0mKbtqMN5QrAgU2hxcz0fxyCPlIyMXKtFCCsTdtfU9HqgBt+FEK0
         BuJw==
X-Forwarded-Encrypted: i=1; AJvYcCUHHdRHlP5UMAlmyg16LOKcVIp/5cFJRICzAobdpkbpg5SRM+ftD+ivz3Fbz54Sj0OK+s1B52XOJNaTk50=@vger.kernel.org, AJvYcCVVbPQi7Fbtx2Y0G5G8yG6asekUxZmoWl2vgfuiQnjOFNMAYFIDKkcmf7mNfQ9eAf2QQawqK8VX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1GT9zGLtx+0yJSMO5AgJ2fB9llr/eAadbyc/2hvimEICVWpUd
	EvQt55y38CKRDuB77/CHg08ckTqJ//JToRTPUGqsIRaavqDNXd4LLHDziyc76IW38XlgeA+KaO1
	ExkgRUAfxOSrCR4JTpvZR5HXF32CFxOE=
X-Gm-Gg: ASbGncvQgkZr3Qj+cb2o1Jnvs4PK8zDk5XaycC9iAGKeNoQuS8wnvRFBXH4eQdgc2Hx
	tpmSy8/cEY0JAstCYX8TkaLMw9rTlI+MT7+b0CFPZckjvVs7BgCicHvNpCceTbrYw3me2tWdQY5
	jYxVRus2AF3ZPJvUcE8J/4N7nkBiRW6+V4fNlJOmQeQK6wTk30BAknxLWhYlf9dWo78AQH8+1mV
	c2lYZVaL3Co7H3hCy2UmYyTAKVK1MYci4/YrBAUOE42hlF0p2Yg3ZhTgbD5eSxkcPfB9AUHaI9w
	NbzFh70=
X-Google-Smtp-Source: AGHT+IHK1fFEfBRswoC+cOAU3MdBdRobccnz9keTzt26DXyo+x/aCKmIwF4hKmckMQOQbQ9SoFcLpAUeNsNYEcrqdFQ=
X-Received: by 2002:a05:600c:3596:b0:458:bd31:2c35 with SMTP id
 5b1f17b1804b1-45b517cca56mr65377045e9.25.1755993355886; Sat, 23 Aug 2025
 16:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041526.467434-1-CFSworks@gmail.com> <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
In-Reply-To: <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sat, 23 Aug 2025 16:55:44 -0700
X-Gm-Features: Ac12FXzGG0H-pxXhscueUgsXpOWwmZNae3mF28D68WdANbXrFVlmWCQ-8wPwR4Q
Message-ID: <CAH5Ym4gTTLcyucnXjxFtNutVR1HQ0G2k_YBSNO-7G3-4YXUtag@mail.gmail.com>
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

On Sat, Aug 23, 2025 at 3:25=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Hi Sam,
>
> On Fri, 22 Aug 2025 at 14:15, Sam Edwards <cfsworks@gmail.com> wrote:
> >
> > In early boot, Linux creates identity virtual->physical address mapping=
s
> > so that it can enable the MMU before full memory management is ready.
> > To ensure some available physical memory to back these structures,
> > vmlinux.lds reserves some space (and defines marker symbols) in the
> > middle of the kernel image. However, because they are defined outside o=
f
> > PROGBITS sections, they aren't pre-initialized -- at least as far as EL=
F
> > is concerned.
> >
> > In the typical case, this isn't actually a problem: the boot image is
> > prepared with objcopy, which zero-fills the gaps, so these structures
> > are incidentally zero-initialized (an all-zeroes entry is considered
> > absent, so zero-initialization is appropriate).
> >
> > However, that is just a happy accident: the `vmlinux` ELF output
> > authoritatively represents the state of memory at entry. If the ELF
> > says a region of memory isn't initialized, we must treat it as
> > uninitialized. Indeed, certain bootloaders (e.g. Broadcom CFE) ingest
> > the ELF directly -- sidestepping the objcopy-produced image entirely --
> > and therefore do not initialize the gaps. This results in the early boo=
t
> > code crashing when it attempts to create identity mappings.
> >
> > Therefore, add boot-time zero-initialization for the following:
> > - __pi_init_idmap_pg_dir..__pi_init_idmap_pg_end
> > - idmap_pg_dir
> > - reserved_pg_dir
>
> I don't think this is the right approach.
>
> If the ELF representation is inaccurate, it should be fixed, and this
> should be achievable without impacting the binary image at all.

Hi Ard,

I don't believe I can declare the ELF output "inaccurate" per se,
since it's the linker's final determination about the state of memory
at kernel entry -- including which regions are not the loader's
responsibility to initialize (and should therefore be initialized at
runtime, e.g. .bss). But, I think I understand your meaning: you would
prefer consistent load-time zero-initialization over run-time. I'm
open to that approach if that's the consensus here, but it will make
`vmlinux` dozens of KBs larger (even though it keeps `Image` the same
size).

>
> > - tramp_pg_dir # Already done, but this patch corrects the size
> >
>
> What is wrong with the size?

On higher-VABIT targets, that memset is overflowing by writing
PGD_SIZE bytes despite tramp_pg_dir being only PAGE_SIZE bytes in
size. My understanding is that only userspace (TTBR0) PGDs are
PGD_SIZE and kernelspace (TTBR1) PGDs like the trampoline mapping are
always PAGE_SIZE. Please correct me if I'm wrong; I might be misled by
how vmlinux.lds.S is making space for those PGDs. :)

(If you'd like, I can break that one-line change out as a separate
patch to apply immediately? It seems like a more critical concern than
everything else here.)

Best,
Sam

>
> > Note, swapper_pg_dir is already initialized (by copy from idmap_pg_dir)
> > before use, so this patch does not need to address it.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  arch/arm64/kernel/head.S | 12 ++++++++++++
> >  arch/arm64/mm/mmu.c      |  3 ++-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index ca04b338cb0d..0c3be11d0006 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -86,6 +86,18 @@ SYM_CODE_START(primary_entry)
> >         bl      record_mmu_state
> >         bl      preserve_boot_args
> >
> > +       adrp    x0, reserved_pg_dir
> > +       add     x1, x0, #PAGE_SIZE
> > +0:     str     xzr, [x0], 8
> > +       cmp     x0, x1
> > +       b.lo    0b
> > +
> > +       adrp    x0, __pi_init_idmap_pg_dir
> > +       adrp    x1, __pi_init_idmap_pg_end
> > +1:     str     xzr, [x0], 8
> > +       cmp     x0, x1
> > +       b.lo    1b
> > +
> >         adrp    x1, early_init_stack
> >         mov     sp, x1
> >         mov     x29, xzr
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 34e5d78af076..aaf823565a65 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -761,7 +761,7 @@ static int __init map_entry_trampoline(void)
> >         pgprot_val(prot) &=3D ~PTE_NG;
> >
> >         /* Map only the text into the trampoline page table */
> > -       memset(tramp_pg_dir, 0, PGD_SIZE);
> > +       memset(tramp_pg_dir, 0, PAGE_SIZE);
> >         __create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS,
> >                              entry_tramp_text_size(), prot,
> >                              pgd_pgtable_alloc_init_mm, NO_BLOCK_MAPPIN=
GS);
> > @@ -806,6 +806,7 @@ static void __init create_idmap(void)
> >         u64 end   =3D __pa_symbol(__idmap_text_end);
> >         u64 ptep  =3D __pa_symbol(idmap_ptes);
> >
> > +       memset(idmap_pg_dir, 0, PAGE_SIZE);
> >         __pi_map_range(&ptep, start, end, start, PAGE_KERNEL_ROX,
> >                        IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
> >                        __phys_to_virt(ptep) - ptep);
> > --
> > 2.49.1
> >

