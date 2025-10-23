Return-Path: <stable+bounces-189059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F917BFF499
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 07:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D173619C75D0
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 05:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA7624677D;
	Thu, 23 Oct 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpv5Tswr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A722DF9E
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199087; cv=none; b=WnBDKqEW65h88ptwb6/dmkmKM2WrfIjzEisDWmTcfQun9u1rp9E5xuI5UhXk0svPWx63JDT51Crqx3so5R4iu16KjpqN7CrjOotcAyLj7wbVn5strjqJGruH/kc52nkYp9KqTLamy2WfmXwk4T/4Qg7LNSX5hj7brMTY0ZhtxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199087; c=relaxed/simple;
	bh=7VdE+T5JvEjyRxHDFVuvpipqpakTLilpPltYb4d6WAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkFYxpmxl5xVcDv8xjWY9kXepcAAYo6yB/JyB8BpIRTtO9fOqCz4tbDP8haUbXRenCfw8lXUQPf80DNAx+qp2zFyaZlOdGvgAn+YoT2YDg1OWSgOxGAYV3b2Dfsac5zo7msmgVcX4pPngf9DAGuma66YnVfzKns+uWoRRVaOosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hpv5Tswr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso94707166b.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761199082; x=1761803882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqT3fmbl/NyFgzc1chkjaxa8Hzi6O3hC82OBdEi+dws=;
        b=Hpv5Tswr07+6oFtdT0GtAgpBRFteYM8bhLd929TAfjNjwQNsP/5skO1qn47PfMJqku
         QfiWAEAP9qBPVgWDtoq1hVkViGDUjBGFifSY6KG3ihQMDow0/XRK5WIwysXDFYHRHldV
         SNehzupnhCtztcCnJq2Nf8cw8TobNwQqfDHeS/2v7yrJZ/NriEd9UL3TmxF1mHr8CN+h
         IH8s6tvukQpZ6126Q1b843ubHNAnjTd3WwrW5YvapNfiqy4Yb6wV2lvyRWdyCACCBop3
         VDj4LSlrBWp23b+L3vZcTP5xUEyplRD5Wv4NeFmqdEtv195/pvB7aJAZiXWN8cEn9SiC
         7jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761199082; x=1761803882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqT3fmbl/NyFgzc1chkjaxa8Hzi6O3hC82OBdEi+dws=;
        b=sU47IwYgsvhiUnXq68RLn44sbTDAkzON7P6zvM/Irb0IOZ0v5UlIjHV6r2v1HbXZch
         bnb4HeSFnmbgpyWgCnl0/lpxj52WWfJSKhEOWlnHF3I3r0LIskC9i3dpNhK0X1Sluzxo
         5iRHMOuwPWUAJAesTK8vKXh4ea0LoteSL1nN4Z52SHqKUq2HFYv4CSVccQimkl+9zTsJ
         edMPWKEtNgahpsfaQo9uzbAax7M/sJEjUrCmlCwv7T6PFdWlK29ahiDWtsYz88R9XsW+
         /EMgsqr9RiLph0VcIg5t/ZZcy7/KAggKCon/ClRxcrlsgXCKrdk/wjBp/Q06lykyV5ze
         RFtw==
X-Forwarded-Encrypted: i=1; AJvYcCUq7esTwnxXRcYLKgbAN5SeCUzG+jOtW7XreCsBIa64Mlny85SERIPFukeb7ZESx+aVLnCntRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+xHn1uYUnMdU3eEECMMgulXsQ24Y3EUUpVuJDBPrPhlhjltH
	ZUlXq9EMi8fsKGmMPhGdxQHFDUUaMxF1lOIK1JxnmWuwYJ1VvPKsYTDVT/T8dX8GRU5qCoC+8n0
	Pj0H5UXPRhgMymifCVzskTzmyF5eXgpg=
X-Gm-Gg: ASbGncuMwwBfyfsONqDWflD5iScM/xi6e8a3zO6CV4UDX9SXK00LClyQ/rzKdt1fqVf
	M8vaAdqcLEkaIXXt4bWO+IxgdTj79JCHPwY1Re3GHMCpz291+gWmZrCM5bZHMeV02WiqPLxs/E0
	XKqKHBXT30OtqGQIgo8mkPWCBYmQODJZ8/ZqgN87COM1EdoBestcX7u2CG+syinYmltFxS5Jg4x
	0Y8xXQxBwh6knlKiTya0LIlb4HHZbMZ6J+0iOvUDTXsdxCiEB13GXJ7GFdO
X-Google-Smtp-Source: AGHT+IHEgrhoMFz9wAJKmZGqrPoGLd0Yc4jrCJX0a9ZPmSZc59sboKW2LRJQWOCdJd5RmikbQ3D38I9zHdHcXkeQpug=
X-Received: by 2002:a17:907:3f12:b0:b6d:5718:d43f with SMTP id
 a640c23a62f3a-b6d5718d7b1mr65656366b.39.1761199082291; Wed, 22 Oct 2025
 22:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022105719.18321-1-ryncsn@gmail.com> <CAGsJ_4zKcxO-Tacy0jCZSs83+fGsgqQYNib9nCXoLTuL+hdLxQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zKcxO-Tacy0jCZSs83+fGsgqQYNib9nCXoLTuL+hdLxQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 23 Oct 2025 13:57:24 +0800
X-Gm-Features: AWmQ_bkGCKMn-MW625Ff-LLLuPlBu8nKTWVvjEa-19moLgG3QM5ri2QsiZJtA4k
Message-ID: <CAMgjq7CdQK_k_oGfOwCtMm18uAXrGwfwUz93pt7kaN-S64G0Cg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shmem: fix THP allocation and fallback loop
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Dev Jain <dev.jain@arm.com>, David Hildenbrand <david@redhat.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:51=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index b50ce7dbc84a..7559773ebb30 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1895,10 +1895,11 @@ static struct folio *shmem_alloc_and_add_folio(=
struct vm_fault *vmf,
> >                 order =3D highest_order(suitable_orders);
> >                 while (suitable_orders) {
> >                         pages =3D 1UL << order;
> > -                       index =3D round_down(index, pages);
> > -                       folio =3D shmem_alloc_folio(gfp, order, info, i=
ndex);
> > -                       if (folio)
> > +                       folio =3D shmem_alloc_folio(gfp, order, info, r=
ound_down(index, pages));
> > +                       if (folio) {
> > +                               index =3D round_down(index, pages);
> >                                 goto allocated;
> > +                       }
>
> Could this be a temporary variable to store round_down(index, pages)?

Right we can do that, but the generated code should be the same, the
compiler is smart enough, I just checked the generated code with gcc /
clang.

Do you think the code will be cleaner with a temporary variable? I can
send a V3 if anyone suggests, it's really a trivial change.

