Return-Path: <stable+bounces-86598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8BB9A207A
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7DC1F276A2
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101E1DACBE;
	Thu, 17 Oct 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVYvrOQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07041D517A
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163009; cv=none; b=NNXkqxz5/V9mXMGGu9WorIMpY8dBg+oN8Zv6T/TLd7OqtbzeByAUa3moIzmREQIZyLZmQhnHdqhBtDvsMpV0dImu0jwSnFeULE/afhbrb/pDI2YfBs9ITIipLR2SAz5UfvIKuMnQv7ZWGprmP14q/+xdqFnAu+KzusF6ayyfjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163009; c=relaxed/simple;
	bh=BxzV3Q3Kns6mqX5qJ4uWTj9fdHOeg+aLWIck9ypRMSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpfgqI+b5omvt51X+rxHNa3MrRKdTcDAWZacjjZUHOLHWyYR54myh9BG05w3atM8K/4jCL7+1i/uR1wCvvf+H22MqIqSW0Ii3Q5FpymSWTGjUpP5JAdhypq6NhR48YzkMnWc6r3VwWsEm/ywiQA9ccj38c/nn8osijQ1GRmMWNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVYvrOQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9FDC4CED1
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729163009;
	bh=BxzV3Q3Kns6mqX5qJ4uWTj9fdHOeg+aLWIck9ypRMSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tVYvrOQjfb9J1ThETVIdg5sr9FRMFoz4f30y5VzDusV59u8M51EObHvPfofUhnkjw
	 nlrEmc529zZt1OlbTcf0eJwjKru1jtv8w8snl/0+nMRqFSEr0Zqzr3JtkTkdxOI1GH
	 aOda9FhIAqHIp6rEvCOq3VKqdFPtULWprrrp3ZJSyeLaJV+bqgCe06d934rJnnomrP
	 4QMGwgZLWhSozgMM8V8zCS2nvvs9Q8tFjA+4aU9gPPw25m9hLJw5GLETlW/FkUFN8S
	 xXS6J0AhwXMiHDDU7v5S7LgbCa5OuQJePCRAPSh1w1Vx0zRv+BvkOLKCktljIxIZjC
	 Xl8a7FqnMe1jg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f58c68c5so1335709e87.3
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 04:03:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUA3ixmDqDPX1BFb1Co3LjmolWT8O+h1rpKaSY2s6Bybp4k5fbcT1agktMGX+mP4i4xZt7w9/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHThU52SWL9tI9j2SlfLRbu7O1Kz17n6k5wqCnsFH3j8Taq/bk
	9g+9fJhRubIJdGWoOgioB1qUZKE/oiSKF2TMdIz5+iym5Yy2ipvWTNA2YpEibGZD0Syx/HXRcnF
	USmfnlnCs08tXscDNxni1s68CD54=
X-Google-Smtp-Source: AGHT+IGCO8vS29Sa5K89HG8yPcVAVf4A86d08xdVfeLGJGg8X8cFtVrgc8q8oFI8bwatzVhSSwEl1zXdJj1pRyFe+co=
X-Received: by 2002:a05:6512:3e06:b0:536:a7a4:c3d4 with SMTP id
 2adb3069b0e04-539e571c959mr14127110e87.39.1729163007547; Thu, 17 Oct 2024
 04:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-arm-kasan-vmalloc-crash-v2-0-0a52fd086eef@linaro.org>
 <20241016-arm-kasan-vmalloc-crash-v2-1-0a52fd086eef@linaro.org> <ZxDnP3rAAHLHgEXc@J2N7QTR9R3>
In-Reply-To: <ZxDnP3rAAHLHgEXc@J2N7QTR9R3>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 17 Oct 2024 13:03:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFpR7MNTTLxdURE7k+PZ0vStQD_BMk92kjSbneqN3WnZQ@mail.gmail.com>
Message-ID: <CAMj1kXFpR7MNTTLxdURE7k+PZ0vStQD_BMk92kjSbneqN3WnZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Oct 2024 at 12:30, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Oct 16, 2024 at 09:15:21PM +0200, Linus Walleij wrote:
> > When sync:ing the VMALLOC area to other CPUs, make sure to also
> > sync the KASAN shadow memory for the VMALLOC area, so that we
> > don't get stale entries for the shadow memory in the top level PGD.
> >
> > Since we are now copying PGDs in two instances, create a helper
> > function named memcpy_pgd() to do the actual copying, and
> > create a helper to map the addresses of VMALLOC_START and
> > VMALLOC_END into the corresponding shadow memory.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 565cbaad83d8 ("ARM: 9202/1: kasan: support CONFIG_KASAN_VMALLOC")
> > Link: https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com/
> > Reported-by: Clement LE GOFFIC <clement.legoffic@foss.st.com>
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  arch/arm/mm/ioremap.c | 25 +++++++++++++++++++++----
> >  1 file changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> > index 794cfea9f9d4..94586015feed 100644
> > --- a/arch/arm/mm/ioremap.c
> > +++ b/arch/arm/mm/ioremap.c
> > @@ -23,6 +23,7 @@
> >   */
> >  #include <linux/module.h>
> >  #include <linux/errno.h>
> > +#include <linux/kasan.h>
> >  #include <linux/mm.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/io.h>
> > @@ -115,16 +116,32 @@ int ioremap_page(unsigned long virt, unsigned long phys,
> >  }
> >  EXPORT_SYMBOL(ioremap_page);
> >
> > +static unsigned long arm_kasan_mem_to_shadow(unsigned long addr)
> > +{
> > +     return (unsigned long)kasan_mem_to_shadow((void *)addr);
> > +}
> > +
> > +static void memcpy_pgd(struct mm_struct *mm, unsigned long start,
> > +                    unsigned long end)
> > +{
> > +     memcpy(pgd_offset(mm, start), pgd_offset_k(start),
> > +            sizeof(pgd_t) * (pgd_index(end) - pgd_index(start)));
> > +}
> > +
> >  void __check_vmalloc_seq(struct mm_struct *mm)
> >  {
> >       int seq;
> >
> >       do {
> >               seq = atomic_read(&init_mm.context.vmalloc_seq);
> > -             memcpy(pgd_offset(mm, VMALLOC_START),
> > -                    pgd_offset_k(VMALLOC_START),
> > -                    sizeof(pgd_t) * (pgd_index(VMALLOC_END) -
> > -                                     pgd_index(VMALLOC_START)));
> > +             memcpy_pgd(mm, VMALLOC_START, VMALLOC_END);
> > +             if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> > +                     unsigned long start =
> > +                             arm_kasan_mem_to_shadow(VMALLOC_START);
> > +                     unsigned long end =
> > +                             arm_kasan_mem_to_shadow(VMALLOC_END);
> > +                     memcpy_pgd(mm, start, end);
> > +             }
>
> This looks good; FWIW:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> As a separate thing, I believe we also need to use atomic_read_acquire()
> for the reads of vmalloc_seq to pair with the atomic_*_release() on each
> update.
>
> Otherwise, this can be reordered, e.g.
>
>         do {
>                 memcpy_pgd(...);
>                 seq = atomic_read(&init_mm.context.vmalloc_seq);
>                 atomic_set_release(&mm->context.vmalloc_seq, seq);
>         } while (seq != atomic_read(&init_mm.context.vmalloc_seq)
>
> ... and we might fail to copy the relevant table entries from init_mm,
> but still think we're up-to-date and update mm's vmalloc_seq.
>

The compiler cannot reorder this as it has to assume that the memcpy()
may have side effects that affect the result of the atomic read.

So the question is whether this CPU can observe the new value of
init_mm.context.vmalloc_seq but still see the old contents of its page
tables in case another CPU is modifying init_mm concurrently.
atomic_read_acquire() definitely seems more appropriate here to
prevent that from happening, and I don't recall why I didn't use that
at the time.

