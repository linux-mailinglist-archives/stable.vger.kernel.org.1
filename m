Return-Path: <stable+bounces-106845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9353BA02686
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118523A4679
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B9B1D9595;
	Mon,  6 Jan 2025 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duxRDbrY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB71D86F1
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169994; cv=none; b=gGoO4C568Hi4T23Zep99kMe/wncuxRyucFPodFaneKGoo8h2dtk0A2Z3Ou192MZ9LF5dFS9WhFqBO5L/bJt4H4wU15LnpgWm68juf/0Vn+DwUNHnQVx2oFKq1buKuvU0PI8sow+lwztmZABOtRu7MOYT4HbCC4cFA9zfK1IuR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169994; c=relaxed/simple;
	bh=uxKka6cBonkW+bGY7gOyH+0mwHP/tlxaRVlvPIuhhUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syyqVVQ0wjWb9cBpPF+sRP3PykrlC+RPGgaPzqO43svcYNt1LE0ivy0WmsS+EV+hpEO/qJ1SyaJ+Work8IpTHwv7n7i4xYQG0toDH+SYXBs3znXug4ccFZbzeUH52G6TSrG/lzVdZ1PWZgPlI1dj3COdRvoA7GCNhIGHKA+toJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=duxRDbrY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so10992a12.0
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 05:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736169990; x=1736774790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/Onh7BDntJnMrPDANtJEjOaq7lcSNnutCvQxYiXeEw=;
        b=duxRDbrY+9qzh4BQxGFzHx38+G/QXVoEBk5F/GJkENV433H/4YkpVN9j4o7JKMkoGd
         RKiLlH14jyNstFlaCLcI3iILxEtsOB2nCFe9GaZuXFtMRzTOwWtnMViGT4Hoq0nhk3dw
         dlrgaYyZC2jIf9JQLx89SyWTh6BpudawA1MpjtYrs3nVmAFt2487PofW1HAgFGuxeMfS
         Gv8oCDz5Hm0q42dCXa3jMNlcSrAvA30+f2ahnK8Gy97tEVbqPp+4MnlfzTQkiNL9zPlE
         Z9UGi5aypKEmSC+2rg2YYhIESvCrMM+FF0lt9mlo/hobo72IJ0qqajZwq2Xx+zDi0lP/
         GIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169990; x=1736774790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/Onh7BDntJnMrPDANtJEjOaq7lcSNnutCvQxYiXeEw=;
        b=NCiCU070rpbgYATRFtHWrs3ptp7t2eWsizKGSd3+pBvtNNBjU22icayHFsK2XJ9BXK
         XwvkoBbfoSE0ddcsRXL9x4e+vb//s9lob0Plra1hR76PeVPm4oLs7vHryJIp94nRomUV
         ddQhB38m0kJWm/6xEIagQi3acYnuKS/yDhKNSpB1VtyQJjq6AqbgGlQyxUv5Ujo2VKFb
         gBcUroaPZLxRHjaDn6WtBIS4UgbA1R1acay/OlWRZ/UC8jSq1d1J0l/q/a5wsScxSaSK
         0z1VvkdIhy23xPw0IokbvEo9EfprvfsfVpou7rsDWuiCx6hhcu7dCCKCFxkuCRvAC3r/
         JASg==
X-Forwarded-Encrypted: i=1; AJvYcCV4o9TSSImtxHIKPUXYU0nlsY50Gha1fa85AJQ9o+rA0FNoDPSt4H2A6a1Ifvk9bzM1+lVoTbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiy3HpGx47MGpyuZccQOM0lQ60Pv9/lrCJk9Ngfoo7I5PUGdR0
	Uy6Y4Xnko4gWxO+wUX0WMJOhPnNF86uh1R3CnqF6SzNGDoJUIS89EFetXgBK611K06PCFlBdJOZ
	fvRty1k/wFJJFxIsq22S2qwQ19iQknn98k8YI
X-Gm-Gg: ASbGnctT7tvTimewVjNxwBLx5NOBwFPDA5rh6EJPWHGSqXF4abDUPHZ+Hz675Fm/CV4
	ATqUIMYbAxFeHjwPOezmavyY3gLiAJJUQJhojV9tmj0bZsD4biX7jZVtc2Gne3zDkVA==
X-Google-Smtp-Source: AGHT+IEO2IVnLahP8/8ARpXoGdW2UZjRHc5kdD5zahzOeAvmnUbTK3mmqX5uk3JbxKxwAM300/h3I/grFlBA+HNl9a0=
X-Received: by 2002:a50:9f82:0:b0:5d0:acf3:e3a6 with SMTP id
 4fb4d7f45d1cf-5d92bc4cf86mr96793a12.1.1736169990076; Mon, 06 Jan 2025
 05:26:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com>
 <a1fff596435121b01766bed27e401e8a27bf8f92.camel@surriel.com>
 <CAG48ez1d9VdW+UQ3RYXMAe1-9muqz3SrC_cZ4UvcB=jpfR2X=Q@mail.gmail.com> <dad8250f5ed1773a2a48b40ed518678f96932ac1.camel@surriel.com>
In-Reply-To: <dad8250f5ed1773a2a48b40ed518678f96932ac1.camel@surriel.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 6 Jan 2025 14:25:54 +0100
X-Gm-Features: AbW1kvbhQY4r7KQBnj59F9WlbqEaDC8c0R14eNdPyfBACXyYNPaPxluYyoUEaVQ
Message-ID: <CAG48ez39-KgQ6wFy65huzaCPZfiuBQoPJR-D9peS++i7aaVMfA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Fix flush_tlb_range() when used for zapping
 normal PMDs
To: Rik van Riel <riel@surriel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 4:09=E2=80=AFAM Rik van Riel <riel@surriel.com> wrot=
e:
> On Fri, 2025-01-03 at 23:11 +0100, Jann Horn wrote:
> > On Fri, Jan 3, 2025 at 10:55=E2=80=AFPM Rik van Riel <riel@surriel.com>
> > wrote:
> > > On Fri, 2025-01-03 at 19:39 +0100, Jann Horn wrote:
> > > > 02fc2aa06e9e0ecdba3fe948cafe5892b72e86c0..3da645139748538daac7016
> > > > 6618d
> > > > 8ad95116eb74 100644
> > > > --- a/arch/x86/include/asm/tlbflush.h
> > > > +++ b/arch/x86/include/asm/tlbflush.h
> > > > @@ -242,7 +242,7 @@ void flush_tlb_multi(const struct cpumask
> > > > *cpumask,
> > > >       flush_tlb_mm_range((vma)->vm_mm, start,
> > > > end,                  \
> > > >                          ((vma)->vm_flags &
> > > > VM_HUGETLB)           \
> > > >                               ?
> > > > huge_page_shift(hstate_vma(vma))      \
> > > > -                             : PAGE_SHIFT, false)
> > > > +                             : PAGE_SHIFT, true)
> > > >
> > > >
> > >
> > > The code looks good, but should this macro get
> > > a comment indicating that code that only frees
> > > pages, but not page tables, should be calling
> > > flush_tlb() instead?
> >
> > Documentation/core-api/cachetlb.rst seems to be the common place
> > that's supposed to document the rules - the macro I'm touching is
> > just
> > the x86 implementation. (The arm64 implementation also has some
> > fairly
> > extensive comments that say flush_tlb_range() "also invalidates any
> > walk-cache entries associated with translations for the specified
> > address range" while flush_tlb_page() "only invalidates a single,
> > last-level page-table entry and therefore does not affect any
> > walk-caches".) I wouldn't want to add yet more documentation for this
> > API inside the X86 code. I guess it would make sense to add pointers
> > from the x86 code to the documentation (and copy the details about
> > last-level TLBs from the arm64 code into the docs).
> >
> > I don't see a function flush_tlb() outside of some (non-x86) arch
> > code.
>
> I see zap_pte_range() calling tlb_flush_mmu(),
> which calls tlb_flush_mmu_tlbonly() in include/asm-generic/tlb.h,
> which in turn calls tlb_flush().
>
> The asm-generic version of tlb_flush() goes through
> flush_tlb_mm(), which on x86 would call flush_tlb_mm_range
> with flush_tables =3D true.
>
> Luckily x86 seems to have its own implementation of
> tlb_flush(), which avoids that issue.

Aah, right. Yeah, I think the tlb_flush() infrastructure with "struct
mmu_gather" is probably one of the two really optimized TLB flushing
hotpaths (the other one being the reclaim path).

I think tlb_flush() is for somewhat different use cases though - my
understanding is that it is mainly for operations that need batching
and/or want to delay TLB flushes while dropping page table locks.

> > I don't know if it makes sense to tell developers to not use
> > flush_tlb_range() for freeing pages. If the performance of
> > flush_tlb_range() actually is an issue, I guess one fix would be to
> > refactor this and add a parameter or something?
> >
>
> I don't know whether this is a real issue on
> architectures other than x86.

arm64 seems to have code specifically for doing flushes without
affecting cached higher-level entries - __flush_tlb_range_nosync()
receives a "last_level" parameter (which is plumbed through from the
arm64 version of tlb_flush()) and picks "vale1is" or "vae1is"
depending on it.

> For now it looks like the code does the right
> thing when only pages are being freed, so we
> may not need that parameter.
>
> --
> All Rights Reversed.

