Return-Path: <stable+bounces-119854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C7A485A0
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 17:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDD23AC14A
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728D81D5CFF;
	Thu, 27 Feb 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfOjuzLe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9841A9B5B
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674863; cv=none; b=rQz0DPTYaSnz6mA3LHktO7hx+OWCw3miuaeZCT16UZOYgullKhHkGHzN6+3Ju7ySbYjRVN6uuQP0xznwXQ+Bte218yb1Q+pw6XdEhPFiGYRZNUqQaMv1cFEJdNMZ50kMQ071KWWTdabEnN4S+4Dhy4rZnUhw0aeFesjh/JhMJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674863; c=relaxed/simple;
	bh=A0O7VaCBvhIde6HUIo2weVzpqQbN5OmJVjtijzFCX4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thQgtcmHWkM+YACBJ3SuMIzz8QxDn0xD0b4kv2kbIWn4ZNOT+TSkjfkc2zZN/C68f5zEnc9EP04Z4SPo2IELsYS3oaoZ+8BSa9AYgWTbSwxxyyO8tPBgDTs2znzvMYP5D3fb5ehcUD5iZF4oRMLbpgyBbiYlkwzbq7inQQ0qvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfOjuzLe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221ac1f849fso159275ad.1
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740674860; x=1741279660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjQglI5Jx4hFLotBiZ0PYZgwKxX6om4t0kw+FgWAq7w=;
        b=tfOjuzLeg+lf3R98BJBKMP5KLYX8Y1V6Kvb8r08S9mBE42q1hMf80GB5ZoXq2ltLKC
         F8vsvF/xtRIraFBD+6kOh/UG0h379xDZnbbibHC0wf6cImU//+yNPtfOOmRbhvauA9dE
         MEiHwLotuFklhLfB6Xh9dFju/w1f1rfX60QirXhhcg/oROjdhvdlLPYNopmoroOXXREY
         6VWSrpraCoy4qt7vL8zJr+MbeY/IiwJP+On7BJbPsZwZQvOT9KhO+lCq49egNx/zeAC+
         wQS2/99CdB0YLhXQqmwWm14N5FQeigMPlqnOsEabF6FXwzVTLHM9RfVxp6LmjulCF73o
         nj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674860; x=1741279660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjQglI5Jx4hFLotBiZ0PYZgwKxX6om4t0kw+FgWAq7w=;
        b=oJJjLemE05055/EkuamqdD+YNzdJRCWssV26tmQ6lpCBJKS8iQCV+cwY9wy4lmWi2O
         X7NGxy2Ed39FvLynB+E15Q4fQ+8XPY4hjGWyYDk2QWJjNyjvSTUO/ZVZ60J2Fe6a3h3H
         tNA5ztKosfDD12n7bJLHK6Kmn8fUjrCPs4wA2NBrcC2P4uKZse2nyofhxC8ebqhTGl4A
         ujkRYmi4zJa9qrCkVKC4RZ5FR2MKaPN3bTSDqB63vpUEXq8wvcBviUsqP/xggNudKZ8c
         mWRwqTqE3K2/ziE0IGczfvU1k+nvfA8sBroLtcbv9X6lIulpax6bVl0Ze0pKMDwfmzcY
         OopA==
X-Forwarded-Encrypted: i=1; AJvYcCUFYGrZNBno8PdK1B54P+ElE6jZ3CTIhw71n2DKdAWC1tnr30WG9QsThaia5FNWdKIg4nHItLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIILD2MG90gTmszDzW3CJPjXdTSm8bjR/v/qVrVtQaE1cnefq1
	88TlT2gCh+6/vJ0nkYwuDUi9c2vNWANnSZikCuQo+F4VuUpwA8i35+Ju59JFcc6eyBk0McTKZ4G
	OEoC5WzbpTI2tIcxSlBhVNlUP4+B3CTGHp1kq
X-Gm-Gg: ASbGnctdEJ8Q2MWVfCMau/FunW+2FOnLY49KcJ6p7pdZxUNs+EI56P1euOcnqOM6GFv
	6p8cZBWoaK9pppcLlpB7duKA+dTJab2TVB9/6uoZQhZb7EI9BxfRs9E1y/x/ubKq4+MXUNM2BmH
	1fy70FLQ==
X-Google-Smtp-Source: AGHT+IGbh2l4ajVTrlNsPmTCm4a8bZF9mLdxtA25l6wpBcMDhLAicmrXnr5nMHmIUgLPCdLGS7Du7gykIKVTKfuq8/g=
X-Received: by 2002:a17:903:2647:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-2234d3abb47mr3241885ad.0.1740674859774; Thu, 27 Feb 2025
 08:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226114815.758217-1-bgeffon@google.com> <20250226162341.915535-1-bgeffon@google.com>
 <19624e55-ba41-41e7-ba11-38b6ab3b96e5@linux.alibaba.com>
In-Reply-To: <19624e55-ba41-41e7-ba11-38b6ab3b96e5@linux.alibaba.com>
From: Brian Geffon <bgeffon@google.com>
Date: Thu, 27 Feb 2025 11:47:02 -0500
X-Gm-Features: AQ5f1JrSljmPZJRVpwmBaun-Y2rCm8rPURUzFaXgFgfmntTS2L4B3GhyxYNcs0U
Message-ID: <CADyq12zgFigdBHiCv=AkZNLfbrmnCe2AVVOkjxNy9PwvJZsETQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fix finish_fault() handling for large folios
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	Marek Maslanka <mmaslanka@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 2:34=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/2/27 00:23, Brian Geffon wrote:
> > When handling faults for anon shmem finish_fault() will attempt to inst=
all
> > ptes for the entire folio. Unfortunately if it encounters a single
> > non-pte_none entry in that range it will bail, even if the pte that
> > triggered the fault is still pte_none. When this situation happens the
> > fault will be retried endlessly never making forward progress.
> >
> > This patch fixes this behavior and if it detects that a pte in the rang=
e
> > is not pte_none it will fall back to setting a single pte.
> >
> > Cc: stable@vger.kernel.org
> > Cc: Hugh Dickins <hughd@google.com>
> > Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support larg=
e folio")
> > Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Reported-by: Marek Maslanka <mmaslanka@google.com>
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >   mm/memory.c | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index b4d3d4893267..b6c467fdbfa4 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5183,7 +5183,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >       bool is_cow =3D (vmf->flags & FAULT_FLAG_WRITE) &&
> >                     !(vma->vm_flags & VM_SHARED);
> >       int type, nr_pages;
> > -     unsigned long addr =3D vmf->address;
> > +     unsigned long addr;
> > +     bool needs_fallback =3D false;
> > +
> > +fallback:
> > +     addr =3D vmf->address;
> >
> >       /* Did we COW the page? */
> >       if (is_cow)
> > @@ -5222,7 +5226,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >        * approach also applies to non-anonymous-shmem faults to avoid
> >        * inflating the RSS of the process.
> >        */
> > -     if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) =
{
> > +     if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) |=
|
> > +                     unlikely(needs_fallback)) {
>
> Nit: can you align the code? Otherwise look good to me.

I mailed a v3 with adjusted alignment, I'll let Andrew decide which
variation he prefers.

>
> >               nr_pages =3D 1;
> >       } else if (nr_pages > 1) {
> >               pgoff_t idx =3D folio_page_idx(folio, page);
> > @@ -5258,9 +5263,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >               ret =3D VM_FAULT_NOPAGE;
> >               goto unlock;
> >       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> > -             update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
> > -             ret =3D VM_FAULT_NOPAGE;
> > -             goto unlock;
> > +             needs_fallback =3D true;
> > +             pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +             goto fallback;
> >       }
> >
> >       folio_ref_add(folio, nr_pages - 1);

Thanks for looking
Brian

