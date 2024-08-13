Return-Path: <stable+bounces-67497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8307C950781
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E221C217DB
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3219D086;
	Tue, 13 Aug 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUqMMlqO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B819D07B
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559281; cv=none; b=dXQ7o5H7uYwevxyUAm2bpBRhtXn9b2KQYXJLf0696BaTBi8vg4JeJSMTstPRkUixdJyhZH7CN+SJorOjHBViTv/aiL5fqZpRhufMWqsEtSG5Uq5j2S/Ui4JNroH1tDJt/u5OgzeISeV152KJh7sPFV1RAZyCPQsoXsqME/o8Ky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559281; c=relaxed/simple;
	bh=QuzXOOcw0p+Hwecp8XS47xiaICPrsrPtHudJrttUAAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUu//XGOx0t0Cu9R/7X3Nq+ILw9Xh9GcaCnW0xxJnd4DPZ3vKMXZ1HKaIt1pO62Wwm4RUX0nR4vvsuQWvJSvqsB+E4V06sXdlxLxQyYt3THa5scVntKNomuAKbin7Jh6Y1zdJ+ydcXi1lBdtMYv7CxjcXqhz4BCZmyPN+aI+PyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUqMMlqO; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-64b417e1511so50591127b3.3
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723559278; x=1724164078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9XaW33utQWkxaHgKfkoizdJFqJGFa4Kya6woGbcGpQ=;
        b=lUqMMlqO46dT7gMm4Dtf80RJgOsSADHaoOadSn9DKZHe4isg/OrRe73lCSpXrtcR2t
         jRQ3VY4q0UORTQkBHxqyeaMA+KzUrQdGtPDELiAKfutuEiqdYlVwgv49ncfLoiYNQcFq
         haE7gjAza+lXOalYAfP0lDufq4Q+KsJs3SYGwTn8B5dpGoEYjNrwGsXFBDsRM3Y2Ht4Y
         p4r7qDi67x+UGbzpQkTJCAqubMWMXGB8vRDtGooYxkDRdZTVuIykJjeTbPyK8Dmv5Meg
         BgdVnx8Cv6HdgjDRaCJjKxdwB7n/9yo7/W/nk5xV5xQ4N3NZBNBi+Gvqu9WSqvfACoA2
         dc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559278; x=1724164078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9XaW33utQWkxaHgKfkoizdJFqJGFa4Kya6woGbcGpQ=;
        b=rY2dpTlGZoQETkHSHfUMItvaLtmC5lN7Y6VThjn2vw/zXL9PCejRipYXAXfZYSAycm
         S2OLD5BfFXDy+5fPJFQ0j1E+BivU+6eYqqFv2Yl/zjCawkAFgowmP2e79hRy2d4aDAJt
         +EBjXABhQlIds+ibPrpiMF2iQl4PsnueGf7sS81IVN2tKiymFkzFTnAb7aqjm5n8nH9v
         /hoqC3onuO3lmJW+skq+DCucAQXwdFeXE/SlDpkhJdgeKWtZrHPWdM4h4C4KU3lzj8LQ
         haqlyR7ffyj1g8wbrBnWtUXWwFCMpDiGIBA38ZSvQt1sEWKpqUb5LR8Ghja19IOwhkH6
         /0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWFFV45aUlpgESPqLGNpvn3iT5wCrCdc5wUSzwHDKWMs9giwhWaYCLxZMbkFjr/x6wOX1vTinG11EWEXHd/4/YEQ2y3wPar
X-Gm-Message-State: AOJu0Yzum+75b3XArivBkllLuLFWy8r6LwblTv4BypzH/r9hnbmRD/F8
	70xluzY3hUnMJNq3nrHTcw0U2F9XLF+JU/eQC1ycnAJLSFgDepz8lPm2ooJ4my+3wia0hKPS1G1
	3JHti4q5PWghI4A08YPB7HWfm/0OYwlYHU7rU
X-Google-Smtp-Source: AGHT+IFGCRKANvH4yro0riVKSiJgV/hErH8P3ghOvKIlIw38M8A5+86ZG0mL5CZ6ZYkY+g7RPr4lUQGROSh6loh32zQ=
X-Received: by 2002:a05:690c:c0d:b0:64b:2cf2:391c with SMTP id
 00721157ae682-6a97285f833mr49095967b3.18.1723559278254; Tue, 13 Aug 2024
 07:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812192428.151825-1-surenb@google.com> <471af0a8-92fc-4fe0-85e4-193d713d4e57@redhat.com>
In-Reply-To: <471af0a8-92fc-4fe0-85e4-193d713d4e57@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Aug 2024 07:27:44 -0700
Message-ID: <CAJuCfpExN+esSMgOSmSXivDEeiwSqkeOAr6_Pw-yL+-8ajtGYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] alloc_tag: mark pages reserved during CMA
 activation as not tagged
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:25=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.08.24 21:24, Suren Baghdasaryan wrote:
> > During CMA activation, pages in CMA area are prepared and then freed
> > without being allocated. This triggers warnings when memory allocation
> > debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
> > by marking these pages not tagged before freeing them.
> >
> > Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages =
as empty")
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org # v6.10
> > ---
> > changes since v1 [1]
> > - Added Fixes tag
> > - CC'ed stable
> >
> > [1] https://lore.kernel.org/all/20240812184455.86580-1-surenb@google.co=
m/
> >
> >   mm/mm_init.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 75c3bd42799b..ec9324653ad9 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -2245,6 +2245,16 @@ void __init init_cma_reserved_pageblock(struct p=
age *page)
> >
> >       set_pageblock_migratetype(page, MIGRATE_CMA);
> >       set_page_refcounted(page);
> > +
> > +     /* pages were reserved and not allocated */
> > +     if (mem_alloc_profiling_enabled()) {
> > +             union codetag_ref *ref =3D get_page_tag_ref(page);
> > +
> > +             if (ref) {
> > +                     set_codetag_empty(ref);
> > +                     put_page_tag_ref(ref);
> > +             }
> > +     }
>
> Should we have a helper like clear_page_tag_ref() that wraps this?

With this one we have 3 instances of this sequence, so it makes sense
to have a helper. I'm going to send a v3 with 2 patches - one
introducing clear_page_tag_ref() and the next one adding this
instance.
Thanks for the suggestion, David!

>
> --
> Cheers,
>
> David / dhildenb
>

