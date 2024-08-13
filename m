Return-Path: <stable+bounces-67511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F207E9508CB
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4C1287259
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2546F1A01D8;
	Tue, 13 Aug 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4++gcdL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6077B1A01BD
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562321; cv=none; b=ohQCUr61rNKUQ008XIvPJi4haAcz/lm9nl2dbG38OkViyqBcWhBPJ3oymjMVu1wSpn9tnS9ATa2BmkGDEVM2F4O0cCOsIZedtJXENWm810XT+LZpIoYFSaNpjcYkIwsJGucTA5IjMfDcKMSeihzf/pqi2nB1bvCXa2gzBymjNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562321; c=relaxed/simple;
	bh=Ej33Pi0y1BZjP0RXTGl1hPdpCuV/K98CocLFZsWewWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akjLZEtvUJ0y+HdCJPxDfYjX1DPHkw2Vx7fpGCNSnwJ8MQNw2WjTx2Jhywx4wHjzOpcce7ZeOXPgsLztWPNappfpwu3rEZAfRt17AT+f+5o04ndItzZl/7VuMTScYUc5vIGqnqVUz8J8pq4WNX9m/0bp2NsFtnQ4WqwHl0Lp240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4++gcdL; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66526e430e0so52949517b3.2
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723562319; x=1724167119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orcsmtL/8cZEhUN0C11+6AWr3aA646WIhi/b8LGiqsY=;
        b=p4++gcdLHb8Um61Rra1TG41spdwA0pt9/UmqY7EkPO4606s/7SI87GmnB8O6epkLyl
         io5oJt4I9ut/M18fgMPjwp/GIPjZw5WC+wNmJWlgywKISqf2woewWwHpwDz4qBgdPiMn
         7rJwiC0+kCS+FitlB7cx0G3BUUBiVldOQL6PSNsXIu52RB6pw1MXr2IDjZzUa/ZkbeJB
         68f2B5CoaYKvpQE9SS5Vqm7BbVtVRipTuN20wEX4xrDugoNa6p3e6Gt4XJWPhzssiNd0
         uDh/dDlgp3pt0GKhac2ftRwcrUZey52vkOGqupy1i3wJWBDUBLPlIx0/cPYJumr4pfzC
         opXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562319; x=1724167119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orcsmtL/8cZEhUN0C11+6AWr3aA646WIhi/b8LGiqsY=;
        b=fNR6iHJYKgY6nx6VBYrj9OD/BlcI00SqMCtW1T7PO1tzHRAsvi97ZIhiaQhMighd7A
         fAxHMl87XoMn1l9f1HIkzznHHKx72TgL7Xa/DMop4jDbp7y7238V/wa/LRT1EUnSuGTB
         Fdk8/j3PPQwRzhiS8pHxXHAHLHSjiWqIAS4G9C7o6fZzB1aM8il0Kl2a+iBuarBYKq5N
         CNvVj98PmzWBLPc8hlJmawxCd8WgkuATpTwKQVutg4Kfm3gMqYoiZyVOwqBhXWNa38Bn
         zN5EDTxe6iAZrYP6Y8CoO7UfhUc4B4zNEgzHVJIGU2zSyPO/vCShUy+/AkMsmkpVc8K9
         NIPg==
X-Forwarded-Encrypted: i=1; AJvYcCWEtelN0y6BHD0h/OLUAsNf9TOW5XJGBLUiwn+X98Th68u612L6Xl0g+eGJk+IOBEj0gGyBhQcZYZ9HJ9bAKtb92O293GZG
X-Gm-Message-State: AOJu0YxEWmqKJmyQuUzXFvfEliFBV8ALRstNexASs/sPiEhqjrXtjWV6
	TUW9Hm25ojoBfesL2zXP/9y2PNJW1FHMGnsn/8ObZ4eX9Tls4T+CDlxOZeJgI+MIHqZB+LzsfUN
	kWvxkX7K6w2n+NfjqPhzfCVC/KWkTx93wQvgV
X-Google-Smtp-Source: AGHT+IGJoMp1feg1oGb2ZdcYiOSno19Nh1KQI24Vgz8RgE0LN3DGPO7716w962lCozndyaBR4SE5D1AmZRzVRSaqFaQ=
X-Received: by 2002:a05:6902:c08:b0:e0b:e2e2:8a87 with SMTP id
 3f1490d57ef6-e113ceef41dmr4661079276.34.1723562318817; Tue, 13 Aug 2024
 08:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812192428.151825-1-surenb@google.com> <471af0a8-92fc-4fe0-85e4-193d713d4e57@redhat.com>
 <CAJuCfpExN+esSMgOSmSXivDEeiwSqkeOAr6_Pw-yL+-8ajtGYQ@mail.gmail.com>
In-Reply-To: <CAJuCfpExN+esSMgOSmSXivDEeiwSqkeOAr6_Pw-yL+-8ajtGYQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Aug 2024 08:18:25 -0700
Message-ID: <CAJuCfpGp_EJQ2xA5s0nj5qt6HA69G91+xpC7rTKZ5QE2fVr1ig@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] alloc_tag: mark pages reserved during CMA
 activation as not tagged
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:27=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Aug 13, 2024 at 2:25=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 12.08.24 21:24, Suren Baghdasaryan wrote:
> > > During CMA activation, pages in CMA area are prepared and then freed
> > > without being allocated. This triggers warnings when memory allocatio=
n
> > > debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
> > > by marking these pages not tagged before freeing them.
> > >
> > > Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved page=
s as empty")
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: stable@vger.kernel.org # v6.10
> > > ---
> > > changes since v1 [1]
> > > - Added Fixes tag
> > > - CC'ed stable
> > >
> > > [1] https://lore.kernel.org/all/20240812184455.86580-1-surenb@google.=
com/
> > >
> > >   mm/mm_init.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > >
> > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > index 75c3bd42799b..ec9324653ad9 100644
> > > --- a/mm/mm_init.c
> > > +++ b/mm/mm_init.c
> > > @@ -2245,6 +2245,16 @@ void __init init_cma_reserved_pageblock(struct=
 page *page)
> > >
> > >       set_pageblock_migratetype(page, MIGRATE_CMA);
> > >       set_page_refcounted(page);
> > > +
> > > +     /* pages were reserved and not allocated */
> > > +     if (mem_alloc_profiling_enabled()) {
> > > +             union codetag_ref *ref =3D get_page_tag_ref(page);
> > > +
> > > +             if (ref) {
> > > +                     set_codetag_empty(ref);
> > > +                     put_page_tag_ref(ref);
> > > +             }
> > > +     }
> >
> > Should we have a helper like clear_page_tag_ref() that wraps this?
>
> With this one we have 3 instances of this sequence, so it makes sense
> to have a helper. I'm going to send a v3 with 2 patches - one
> introducing clear_page_tag_ref() and the next one adding this
> instance.
> Thanks for the suggestion, David!

v3 posted at https://lore.kernel.org/all/20240813150758.855881-1-surenb@goo=
gle.com/

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

