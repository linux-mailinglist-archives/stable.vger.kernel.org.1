Return-Path: <stable+bounces-110950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A43A20826
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 11:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45ECA188AAEA
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0819D880;
	Tue, 28 Jan 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri32FhEO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7919CC24;
	Tue, 28 Jan 2025 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058326; cv=none; b=lbYxTxVtjrKM14983gox/UczWtPhTF7R8HrVHNlIeyzlw4El5nig/+KNY3AZeRrfbKv6SR4AhZmOCdFkR9dUwApxi/uwxScvdcr30GKuVLv1qlWvGeoMliSOKBt3StAoq9ySuJSGb+/SGBVHQlseCHnrsQHYOcyDLhEPjwIBdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058326; c=relaxed/simple;
	bh=ZVMPl5go4nHyEgdEhtN8lbas7N9IHdZse8FWs7d8xOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIpwKsTwqU487KyD1eOlUXzMMytyTFbVO0R8p1hG5qpiSEQ/ZPdkFE66wNW0YD96E8hrjZyUe52UylPez7F3s3nzgRNxTEt/pkhElIrjjllkUytEU3YvZs8pvS46HPMLIp+JGW7bqe2Ofpbji+oA5uJk8VYLAAqDCVh6xvdDciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri32FhEO; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85c4d855fafso955342241.2;
        Tue, 28 Jan 2025 01:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738058323; x=1738663123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSKspFr92rhO19guamMZKYUUwmiEHnEHWbR04twXjdY=;
        b=Ri32FhEOxnC11QZnq+mAEZJoVaM1ukBTW66pb4HVmlihqZmL0Ej1ZInqoWm6a0YOVQ
         3/CemLR0nEGaowESJ/SxB9JgoZqZWFY6WHaQihmrn8KHDDYSXIpn/5EhEFiRVs1/sc+2
         daWmkEicIT+AL17dlHOPo84KEsZGFFhU0Ezh3PH8oZqifGoz0BzE7k3CV3Ly1zqrUcUd
         0zOD3y6fjccmCGPhEySaqZSFC3bMQlPCmxAuAUz0s80j/fLt+cXVVQS7vkzLuIyOhAvh
         wHYN8Bce3d+0IZTCzEztqXBJLE0zhTs3nWUjw6juPdD4WNQrGdc93pO1ZdPDVZSgHNLC
         sFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738058323; x=1738663123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSKspFr92rhO19guamMZKYUUwmiEHnEHWbR04twXjdY=;
        b=Inx8mm5A5mng4Ukk8OSX6TpA5MTBgxPs3ldN+PHmyMIBIfzgOxP8gBDjMz5HLt6JZ3
         MT8/uL0wAb33zCM+bJXrBdSvzt5WbRJp2umo8zDWwsnF/lVvMB4VNU8Y/kxqRkGJEEYk
         LN4O1QbXICa77fWi/akwPKV0YRPrAMG8gcw41W30vC7oSRqILd3du8E3V+uhFzG4GCNX
         1xyKsSD2l+aEFDjyKNyW3Dl6J979jpMOh/GVyV83F+KCdCV9cz+w8l4RnEzN2FaskQl+
         UrFqwJSk9mg8+CXirJqizEPEf4ChkeX2kBTTdlxiu2R/eGxuG6wy3d8sY95l/VCTYm42
         GSpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFGP9Ko8JGa1BDqUgKBkBrGOSxRyNaWT4Q0w7tDaQtdvaEPPO3S5hNvgEV2wXBl0oaN7XFhdnJukqTd/0=@vger.kernel.org, AJvYcCWk7gjw2dtxe/P0lgku/uK80L3xN3eZeNgl129+uY+yJyLuXjdgRg0FPxhkuHenuHHttJpn1mYz@vger.kernel.org
X-Gm-Message-State: AOJu0YxneoslymYy1dIv189mc5DlLbLegnO85gMBxuXdE11HRt5Qnqvf
	LXyvrpKnij4OwWI0wDXhFF2A3/srbIkWvZE2NV134m9HILioB/oTFx1+9IPI9eTr0mZsu98PwAZ
	Dd6xhhUGcSuncyBZ1MGKpPFvKrbgwh1OmWm4=
X-Gm-Gg: ASbGncvQQSTHOMhiZdizmyNRB2EhJ17P8jgei3GDlKFgOG47qSOV3XakO3vVfU+L9tS
	0EWMeoLe39SJzvmPg97EXPiiYUmxsImJzn8yLlwAXiCDlfji0zsnE6jVCYPfsT1tDKsqWbkuvwK
	rwzfhN1gBYkVFhrsrohNOnxYUf0BPtA1g=
X-Google-Smtp-Source: AGHT+IEjvwgB90H/GRLtszWh+qAo95uV5i1wiKXOCfuNgEF3LWvZho13BarZ4v2hnf1Ok1W/0IvWOwKgABnjAO2XKVQ=
X-Received: by 2002:a05:6102:a53:b0:4b2:5c4b:55e7 with SMTP id
 ada2fe7eead31-4b690cde3a2mr35483312137.25.1738058323633; Tue, 28 Jan 2025
 01:58:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1737717687-16744-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1737717687-16744-1-git-send-email-yangge1116@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 28 Jan 2025 22:58:32 +1300
X-Gm-Features: AWEUYZmh8QdF0cjEckRpQuu80pJvsy9bKgNFBHsx6WZM5gmpzBjs_t6EnDkaR4A
Message-ID: <CAGsJ_4y2zjCzRUgxkx2GpspFBD9Yon=R3SLaGezk9drQz+ikrQ@mail.gmail.com>
Subject: Re: [PATCH] mm/cma: add an API to enable/disable concurrent memory
 allocation for the CMA
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, aisheng.dong@nxp.com, liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 12:21=E2=80=AFAM <yangge1116@126.com> wrote:
>
> From: yangge <yangge1116@126.com>
>
> Commit 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock""=
)
> simply reverts to the original method of using the cma_mutex to ensure
> that alloc_contig_range() runs sequentially. This change was made to avoi=
d
> concurrency allocation failures. However, it can negatively impact
> performance when concurrent allocation of CMA memory is required.

Do we have some data?

>
> To address this issue, we could introduce an API for concurrency settings=
,
> allowing users to decide whether their CMA can perform concurrent memory
> allocations or not.

Who is the intended user of cma_set_concurrency? I also feel it is somewhat
unsafe since cma->concurr_alloc is not protected by any locks.

Will a user setting cma->concurr_alloc =3D 1 encounter the original issue t=
hat
commit 60a60e32cf91 was attempting to fix?

>
> Fixes: 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock""=
)
> Signed-off-by: yangge <yangge1116@126.com>
> Cc: <stable@vger.kernel.org>
> ---
>  include/linux/cma.h |  2 ++
>  mm/cma.c            | 22 ++++++++++++++++++++--
>  mm/cma.h            |  1 +
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index d15b64f..2384624 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -53,6 +53,8 @@ extern int cma_for_each_area(int (*it)(struct cma *cma,=
 void *data), void *data)
>
>  extern void cma_reserve_pages_on_error(struct cma *cma);
>
> +extern bool cma_set_concurrency(struct cma *cma, bool concurrency);
> +
>  #ifdef CONFIG_CMA
>  struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
>  bool cma_free_folio(struct cma *cma, const struct folio *folio);
> diff --git a/mm/cma.c b/mm/cma.c
> index de5bc0c..49a7186 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -460,9 +460,17 @@ static struct page *__cma_alloc(struct cma *cma, uns=
igned long count,
>                 spin_unlock_irq(&cma->lock);
>
>                 pfn =3D cma->base_pfn + (bitmap_no << cma->order_per_bit)=
;
> -               mutex_lock(&cma_mutex);
> +
> +               /*
> +                * If the user sets the concurr_alloc of CMA to true, con=
current
> +                * memory allocation is allowed. If the user sets it to f=
alse or
> +                * does not set it, concurrent memory allocation is not a=
llowed.
> +                */
> +               if (!cma->concurr_alloc)
> +                       mutex_lock(&cma_mutex);
>                 ret =3D alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,=
 gfp);
> -               mutex_unlock(&cma_mutex);
> +               if (!cma->concurr_alloc)
> +                       mutex_unlock(&cma_mutex);
>                 if (ret =3D=3D 0) {
>                         page =3D pfn_to_page(pfn);
>                         break;
> @@ -610,3 +618,13 @@ int cma_for_each_area(int (*it)(struct cma *cma, voi=
d *data), void *data)
>
>         return 0;
>  }
> +
> +bool cma_set_concurrency(struct cma *cma, bool concurrency)
> +{
> +       if (!cma)
> +               return false;
> +
> +       cma->concurr_alloc =3D concurrency;
> +
> +       return true;
> +}
> diff --git a/mm/cma.h b/mm/cma.h
> index 8485ef8..30f489d 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -16,6 +16,7 @@ struct cma {
>         unsigned long   *bitmap;
>         unsigned int order_per_bit; /* Order of pages represented by one =
bit */
>         spinlock_t      lock;
> +       bool concurr_alloc;
>  #ifdef CONFIG_CMA_DEBUGFS
>         struct hlist_head mem_head;
>         spinlock_t mem_head_lock;
> --
> 2.7.4
>
>

Thanks
Barry

