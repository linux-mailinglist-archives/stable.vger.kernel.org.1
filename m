Return-Path: <stable+bounces-189157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1143CC02C57
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 19:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AB43AC00E
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4034A76D;
	Thu, 23 Oct 2025 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIztLfdL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E773112D5
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241366; cv=none; b=KFalaf+vwhzUfdprtfDZ+fY6RyJK9qySf/v+dqZMmEZOSVfS0s+BU3zHHQjYjAKDJk//MDqYvHTgdbhMBKK1sEu0FVzud9AVHCKoso1znZt7KdZ8/8JkH9pvhVT1Ane7vKgDsCkXQkPPKF6ygdkJW0n3RwZ9MUkg6y0Y2wBRQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241366; c=relaxed/simple;
	bh=tN8Tb70+nrqsimQF3WIi1yTMIjN+5Om0ChlgLkRhs+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SE+0pYEKjSHaInPiyxZIl+qENJd8xvYJ024UkZaEPIpo7ej78AQI/jasvwRIIdoAt8Lm9gUW0/ubb9nVrGdGBO6EghBaq6CucpysRuC0f74GEX5/QuM8xTsX5E4Ff0DZSR2T2Ua7gMhx8qwIKNUzVNlgKiGiB5pDA9J1cLd+kpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIztLfdL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a26dab3a97so687651b3a.0
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241364; x=1761846164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPAtMguVYUjm2bPXdyPdBBsK+GKvEKPYmuqUzpm+2v0=;
        b=SIztLfdLp598RQ3YFRGSDgX9PXgBp8nKYfl1jWbJ3X6v6+7xYJPp8tU+oUlsDlAuhU
         YR1tqeEYla5kvVpZyy2OMSunZNoUuGfItKd/Rg/+8qOl90kNDLj/9EKANxCl/pX0IO/H
         tRp8zS6SLOVHp4H4d1i5uFD3Vgf2yb+E5uZlv1f+9jwSzO5cKIR+/Ns8TvuiqLevA0Kq
         IhGTUO7Jk7egOiaBOP9de7TOL3aV6fQPVWMmvh0i44z3pxJRR8IpGFAMxXWMzjsNBYbv
         vGjjQr2SwPN+rMkF2/YDzkjVVTcC0LyTKGceq0SUjggVVaXlOnG71BkEcF0hCgbiwK2+
         7luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241364; x=1761846164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPAtMguVYUjm2bPXdyPdBBsK+GKvEKPYmuqUzpm+2v0=;
        b=wFyCsAtwPI4+goJlOMtMX0KH+wE2mLhczxURoqz2Jk7glEN6uJBNVPpX9oyA3O0TRU
         rHdP9pWk9APpK5FGXM7vuPrlnxZFqoE6Lv3Ik3okx+cz9DLWZqVPsYoRn5nklP+be2H5
         sSKNJD5ucG7N9+g12yIbFFsGub6HfAo1LiXY1/JZ1R23qBJh0NePRBQHQnHz2urKW+UX
         TA5wS8f6pJygrjF/rP/fcqSGVa3gFz3/Pa62lIZ6TcRI8A73q6odz+bYu0MscuDkNmW4
         bSxDoa2O59Q9TAvWVADyKSC1TH97N1jRo8ObUcgsp1LOuwOjGZ1H4FGT9FmpBP8LlhO2
         4i9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQYtkTZvikXCMDioaMZAwNCbaeH+qCERNE/0Nx/cADfFpqIEIEHEvBdiazfMWZtc4+3RFlEuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tb3z9aemVDjfVBL/yX0GNpmq0mHC0aRyRTTcrATUv172wGcU
	0e+zuZPJXa6v6yU8zkhX3qk/He9zxlxQiY+iJHJLjD98P0ZHkLk4g6UmiZqAWTRnVqCNR5q8WSM
	NGX6rWdDM0p93uynvCpGi547dlxbwgCM=
X-Gm-Gg: ASbGncvvMkbe8n9XCEI+sV1jEc74u9VfGYG/V2b7LyuIHMWV2Re+TKXt0Q30/RTU1Hh
	9jeS9VI7SfA/uPf6Ig3wyC51kpT0xoM5n/jAHFKtb3bOJbwrrnGP4E1UUcQs1CmAKM6zf4E2htj
	ivRTMjWUy1Gt8MAguZFC0kAFtCqyFQ2eCQZGBkf0BwO6QMHQHLm5j/5Y7sbP1e+vASsr37Eq2v3
	aw2uKjtaUhGJ7J5KYDtRa0wdkY4LzqlZWvXDsVKjCCjpeZ94/ftTOoftHDI
X-Google-Smtp-Source: AGHT+IGLmB1ebZNebWwSLNxI6zWpEV/Sv/pPIWfLfVFPhnIS1gTRgxcF5G/Ed1LOT26G5vAVRNngplSfykW+Lus7CTI=
X-Received: by 2002:a17:903:94e:b0:27e:dc53:d222 with SMTP id
 d9443c01a7336-290cb278e97mr315093915ad.44.1761241364475; Thu, 23 Oct 2025
 10:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023065913.36925-1-ryncsn@gmail.com> <774c443f-f12f-4d4f-93b1-8913734b62b2@redhat.com>
 <f0715f2c-ee27-4e13-84d0-5df156410527@redhat.com>
In-Reply-To: <f0715f2c-ee27-4e13-84d0-5df156410527@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Oct 2025 01:42:05 +0800
X-Gm-Features: AS18NWCKbpYNUbtlmhqYan2nj3cCPEw88Vfgq-76wvP0ZxptePnkT4EeZPn3IR4
Message-ID: <CAMgjq7Chg6e_xL4wxYJqMzmCRENawQ63KSABrZ9zVbR4ET=YFA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/shmem: fix THP allocation and fallback loop
To: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Hugh Dickins <hughd@google.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:14=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 23.10.25 18:13, David Hildenbrand wrote:
> > On 23.10.25 08:59, Kairui Song wrote:
> >> From: Kairui Song <kasong@tencent.com>
> >>
> >> The order check and fallback loop is updating the index value on every
> >> loop, this will cause the index to be wrongly aligned by a larger valu=
e
> >> while the loop shrinks the order.
> >>
> >> This may result in inserting and returning a folio of the wrong index
> >> and cause data corruption with some userspace workloads [1].
> >>
> >> Cc: stable@vger.kernel.org
> >> Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n=
4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
> >> Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem=
")
> >> Signed-off-by: Kairui Song <kasong@tencent.com>
> >>
> >> ---
> >>
> >> Changes from V2:
> >> - Introduce a temporary variable to improve code,
> >>     no behavior change, generated code is identical.
> >> - Link to V2: https://lore.kernel.org/linux-mm/20251022105719.18321-1-=
ryncsn@gmail.com/
> >>
> >> Changes from V1:
> >> - Remove unnecessary cleanup and simplify the commit message.
> >> - Link to V1: https://lore.kernel.org/linux-mm/20251021190436.81682-1-=
ryncsn@gmail.com/
> >>
> >> ---
> >>    mm/shmem.c | 9 ++++++---
> >>    1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/shmem.c b/mm/shmem.c
> >> index b50ce7dbc84a..e1dc2d8e939c 100644
> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -1882,6 +1882,7 @@ static struct folio *shmem_alloc_and_add_folio(s=
truct vm_fault *vmf,
> >>      struct shmem_inode_info *info =3D SHMEM_I(inode);
> >>      unsigned long suitable_orders =3D 0;
> >>      struct folio *folio =3D NULL;
> >> +    pgoff_t aligned_index;
> >>      long pages;
> >>      int error, order;
> >>
> >> @@ -1895,10 +1896,12 @@ static struct folio *shmem_alloc_and_add_folio=
(struct vm_fault *vmf,
> >>              order =3D highest_order(suitable_orders);
> >>              while (suitable_orders) {
> >>                      pages =3D 1UL << order;
> >> -                    index =3D round_down(index, pages);
> >> -                    folio =3D shmem_alloc_folio(gfp, order, info, ind=
ex);
> >> -                    if (folio)
> >> +                    aligned_index =3D round_down(index, pages);
> >> +                    folio =3D shmem_alloc_folio(gfp, order, info, ali=
gned_index);
> >> +                    if (folio) {
> >> +                            index =3D aligned_index;
> >>                              goto allocated;
> >> +                    }
> >
> > Was the found by code inspection or was there a report about this?
>
> Answering my own question, the "Link:" above should be
>
> Closes:
> https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgott=
edy0S6YYeUw@mail.gmail.com/
>

Thanks for the review. It's reported by and fixed by me, so I didn't
include an extra Report-By & Closes, I thought that's kind of
redundant. Do we need that? Maybe Andrew can help add it :) ?

