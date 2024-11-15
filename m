Return-Path: <stable+bounces-93491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B79CDB01
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE92282A6B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB91189BAC;
	Fri, 15 Nov 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8db1pBc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA99189B9C
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661241; cv=none; b=V2/vwWIjkH7pP+sGDkSFvEdwNa3lotK87cEuk5MWgrSBni8/4sS9kAnn/UTxTCzJLp0Q2EhQkkx6vgVt/4yj2pwbj/clrQCOkMrzLhWaY//9Xq4n5WJjKpT5EJL2eNsDyDpAP7LOFrJtpuG+Gcoc5ogXg3AFPRVyEVexPyi6MeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661241; c=relaxed/simple;
	bh=ep6e6vrM90+sANFQNBPsBH/0puLJC8rHexalC7iAPdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9uIDvny5ddSL9QQEorP28lDCTGeNKtVRvgslrSLerVVzNrYglYpIAt9L8wisyy8JI1QKKu1IpaQ3ZWZHBWzZenOPSI0S40WsKANcpQJc1LQWnRgdchksdoiEPJE1CeaG9LhVnXZBLUvBzIuLMVuJH0h67iRvigVeytRsGwOJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8db1pBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432B9C4AF09
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 09:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731661241;
	bh=ep6e6vrM90+sANFQNBPsBH/0puLJC8rHexalC7iAPdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g8db1pBccH96DxqOHKfc2GWxOPNR7o2mN9YY+T59BAxt1TwyNKOr48DtTjyEif4Q7
	 FVYSU084mEIJQyyRLgv7i1VZ9nVCCiKg7BYDPssj4M5omGZvrMRjmg0bEYHfVNHr1b
	 J7VwOQ+PkWEDWKn763/e/l6iAQRbUOn+nVhS+o2/yIcYc31q1b/hiAum8bLetOGOGc
	 67e9kLWGznHq+ghh8hORihpKixZdnPVGySZ7pK/cGJtMpcary0eaJBrECEjArhsKhh
	 lAxLUU9qabRAi+yktNp62IdbPsVBzTuxmLX7ej4MLBkDndcEgpRFPyAfx6dDKdXmCQ
	 JHArw365ycE5A==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso15749801fa.0
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 01:00:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5+SbMQITxsuU/CiKQ6sbrRqt5Nf5rTOL0Eix7v+vR9vu5/03QxXTeU4YrUF+AySO3A/5duk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTwmbJ7yKJ2tXuO2sHtZVtrUb/WJdWyyzA4fiPjVnoBCozWHY
	FfB6Gn1IkExThxo/vV/vwhmCWecJI2DrG8fChyeLlFwgnDQj3+y0NMyLLT2D0bnPkIU0EsS/Yer
	nCdy3XpDR4+pBHSuD0M2F+0+wBfk=
X-Google-Smtp-Source: AGHT+IE0QJBljUkm8oRmVb4pgis/ZjWPlu7BiybmSlxSYB+SiOgXWAJnKXSwfSr9IRUZHqmg2tA8/0dnJAWqKj//OnU=
X-Received: by 2002:a2e:a9a8:0:b0:2fb:6110:c5cb with SMTP id
 38308e7fff4ca-2ff6070e6c1mr10431401fa.34.1731661239537; Fri, 15 Nov 2024
 01:00:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111083544.1845845-8-ardb+git@google.com> <20241111083544.1845845-10-ardb+git@google.com>
 <ea124997-8dee-457c-bef1-d5d829c84da3@arm.com>
In-Reply-To: <ea124997-8dee-457c-bef1-d5d829c84da3@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Nov 2024 10:00:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF1kYaiJmQXdvfSzGmgO78cechpm-JC=n3yGhRBXQF6nw@mail.gmail.com>
Message-ID: <CAMj1kXF1kYaiJmQXdvfSzGmgO78cechpm-JC=n3yGhRBXQF6nw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64/mm: Override PARange for !LPA2 and use it consistently
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anshuman,

On Fri, 15 Nov 2024 at 07:05, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> On 11/11/24 14:05, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > When FEAT_LPA{,2} are not implemented, the ID_AA64MMFR0_EL1.PARange and
> > TCR.IPS values corresponding with 52-bit physical addressing are
> > reserved.
> >
> > Setting the TCR.IPS field to 0b110 (52-bit physical addressing) has side
> > effects, such as how the TTBRn_ELx.BADDR fields are interpreted, and so
> > it is important that disabling FEAT_LPA2 (by overriding the
> > ID_AA64MMFR0.TGran fields) also presents a PARange field consistent with
> > that.
> >
> > So limit the field to 48 bits unless LPA2 is enabled, and update
> > existing references to use the override consistently.
> >
> > Fixes: 352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/assembler.h    | 5 +++++
> >  arch/arm64/kernel/cpufeature.c        | 2 +-
> >  arch/arm64/kernel/pi/idreg-override.c | 9 +++++++++
> >  arch/arm64/kernel/pi/map_kernel.c     | 6 ++++++
> >  arch/arm64/mm/init.c                  | 2 +-
> >  5 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> > index 3d8d534a7a77..ad63457a05c5 100644
> > --- a/arch/arm64/include/asm/assembler.h
> > +++ b/arch/arm64/include/asm/assembler.h
> > @@ -343,6 +343,11 @@ alternative_cb_end
> >       // Narrow PARange to fit the PS field in TCR_ELx
> >       ubfx    \tmp0, \tmp0, #ID_AA64MMFR0_EL1_PARANGE_SHIFT, #3
> >       mov     \tmp1, #ID_AA64MMFR0_EL1_PARANGE_MAX
> > +#ifdef CONFIG_ARM64_LPA2
> > +alternative_if_not ARM64_HAS_VA52
> > +     mov     \tmp1, #ID_AA64MMFR0_EL1_PARANGE_48
> > +alternative_else_nop_endif
> > +#endif
>
> I guess this will only take effect after cpu features have been finalized
> but will not be applicable for __cpu_setup() during primary and secondary
> cpu bring up during boot.
>

It is the other way around, actually. This limit will always be
applied on primary boot, which is why IPS is updated again in
set_ttbr0_for_lpa2() [below]. Before booting the secondaries (or other
subsequent invocations of this code, e.g., in the resume path), this
MOV will be NOPed out if LPA2 support is enabled.


> >       cmp     \tmp0, \tmp1
> >       csel    \tmp0, \tmp1, \tmp0, hi
> >       bfi     \tcr, \tmp0, \pos, #3
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 37e4c02e0272..6f5137040ff6 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -3399,7 +3399,7 @@ static void verify_hyp_capabilities(void)
> >               return;
> >
> >       safe_mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
> > -     mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
> > +     mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
>
> Small nit, should be renamed as safe_mmfr0 to be consistent with safe_mmfr1 ?
>

safe_mmfr1 exists because there is also mmfr1 in the same scope. No
such distinction exists for mmfr0, so I opted for keeping the name.

> >       mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
> >
> >       /* Verify VMID bits */
> > diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
> > index 22159251eb3a..c6b185b885f7 100644
> > --- a/arch/arm64/kernel/pi/idreg-override.c
> > +++ b/arch/arm64/kernel/pi/idreg-override.c
> > @@ -83,6 +83,15 @@ static bool __init mmfr2_varange_filter(u64 val)
> >               id_aa64mmfr0_override.val |=
> >                       (ID_AA64MMFR0_EL1_TGRAN_LPA2 - 1) << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
> >               id_aa64mmfr0_override.mask |= 0xfU << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
> > +
> > +             /*
> > +              * Override PARange to 48 bits - the override will just be
> > +              * ignored if the actual PARange is smaller, but this is
> > +              * unlikely to be the case for LPA2 capable silicon.
> > +              */
> > +             id_aa64mmfr0_override.val |=
> > +                     ID_AA64MMFR0_EL1_PARANGE_48 << ID_AA64MMFR0_EL1_PARANGE_SHIFT;
> > +             id_aa64mmfr0_override.mask |= 0xfU << ID_AA64MMFR0_EL1_PARANGE_SHIFT;
> Could these be used instead ?
>
> SYS_FIELD_PREP_ENUM(ID_AA64MMFR0_EL1, PARANGE, 48)
> ID_AA64MMFR0_EL1_PARANGE_MASK ?
>

Yes, but 2 lines before, there is another occurrence of this idiom,
and I did not want to deviate from that.

We could update both, or update the other one first in a separate
patch, I suppose.


>
> >       }
> >  #endif
> >       return true;
> > diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
> > index f374a3e5a5fe..e57b043f324b 100644
> > --- a/arch/arm64/kernel/pi/map_kernel.c
> > +++ b/arch/arm64/kernel/pi/map_kernel.c
> > @@ -136,6 +136,12 @@ static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
> >  {
> >       u64 sctlr = read_sysreg(sctlr_el1);
> >       u64 tcr = read_sysreg(tcr_el1) | TCR_DS;
> > +     u64 mmfr0 = read_sysreg(id_aa64mmfr0_el1);
> > +     u64 parange = cpuid_feature_extract_unsigned_field(mmfr0,
> > +                                                        ID_AA64MMFR0_EL1_PARANGE_SHIFT);
> > +
> > +     tcr &= ~TCR_IPS_MASK;
>
> Could there be a different IPS value in TCR ? OR is this just a normal
> clean up instead.
>

As explained above, TCR.IPS will be capped at 48 bits up to this point.

> > +     tcr |= parange << TCR_IPS_SHIFT;
>
> Wondering if FIELD_PREP() could be used here.
>

AIUI we'd end up with

tcr &= ~TCR_IPS_MASK;
tcr |= FIELD_PREP(TCR_IPS_MASK, parange);

Is that really so much better?


> >
> >       asm("   msr     sctlr_el1, %0           ;"
> >           "   isb                             ;"
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index d21f67d67cf5..4db9887b2aef 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -280,7 +280,7 @@ void __init arm64_memblock_init(void)
> >
> >       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> >               extern u16 memstart_offset_seed;
> > -             u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
> > +             u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
>
> Could this have a comment explaining the need for sanitized value ?
>

Sure. Actually, it shouldn't make any difference here (unless we allow
PARange to be narrowed even further, which might make sense if we care
about enabling randomization of the linear map on systems where
PARange is much larger than the size of the physical address space
that is actually populated). However, for consistency, it is better to
avoid the 52-bit PARange if LPA2 is disabled.


> >               int parange = cpuid_feature_extract_unsigned_field(
> >                                       mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
> >               s64 range = linear_region_size -
>
> Otherwise LGTM.

Thanks!

