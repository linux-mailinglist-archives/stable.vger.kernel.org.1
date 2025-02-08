Return-Path: <stable+bounces-114418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD870A2D8F5
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 22:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7313A6410
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 21:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6BA33DB;
	Sat,  8 Feb 2025 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI3VbOY6"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66092244E8E;
	Sat,  8 Feb 2025 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739050462; cv=none; b=GWM6yBK1bbua6zx5tYCfYfROvELtLI7WEj01zEgUVH7ycaCvxZRC22fjkPCITDbIwLhdL6porYZ5QOxLZ9yL2ubqaZr45hWwExbBZfoAPjEyuKylkUl7HZab5KoTkyoOrG0z4w7FJeMXWf/A6kE/9FTbBF5jsU0QOvUes+ZM1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739050462; c=relaxed/simple;
	bh=hNv+x7+fBJfBx6HgcTPkHn07XwlL1WEdrFEoAyAaDMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbLYOH5PhgzA5C90N8QDvSG6wFTmO1fClsJGwTeQDLsxNFFfn9QCk7br8edKKW4Md0xwb4KWGXGCVOBUACqwuzFu+xqWGY+R6aZpv/LTSQRcYv2udhFgPEmAnD2RRYiIKu9XKZp3XWaMJq/TAKUKcFYrOinFiO7PLBmc1iDF/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI3VbOY6; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4ba72ccc283so2010423137.2;
        Sat, 08 Feb 2025 13:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739050459; x=1739655259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr1A4JBrm8DZqdxvHg/4VfN3wYIha/zlu4oSdgbrsgY=;
        b=CI3VbOY6Nn5aS4sYsb66Yaubl0zGDg3CdDRGIGSkzMuUXDMFOzLJcU63jlUq3L9gkW
         FKtBk8qctppt0WU1UaLSkoO4f6+i30K1MvZglG/zkFebimXbdbPfLbkodbWau4LIkvBh
         ZVTga+6wvRyzhpYYxBXk9x07rmufTbJc3QbhVlRTkQx7KPXBSuD99btRNFRFGdlLO4Vk
         wI2cz9kcpZn+yv6xyzgX27G69kWr5rE5a9uAnYAOrHnVxc2Xyxy22PM6DQvG39+2hAXL
         y1P5wE2e5ZWLg9IPyTAeKCrY2QFs1cl69dj9IhtBnxiyl8Bk8V6vq2/+pPngVoN57KFe
         j4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739050459; x=1739655259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr1A4JBrm8DZqdxvHg/4VfN3wYIha/zlu4oSdgbrsgY=;
        b=vbePZGTg/15Wb7I3KF1NQvZZx8To9GUAN/XFx4tF1TyNafCZt3EjyfmfMGo4A1+9t3
         SVAP5o4JnMam+22ybefQwJSCuc2w/ZgHCpckaeqWvkjtTLYgJdcXBwbsYVI6jKoAa+Mq
         v26VmSGQGNyi7yiiJ1/SLT3Ni+KKJE6XvFNUy/PaVG7JClKMEwmiApnw8U6kaRsICbwI
         6T9LPbQJF+AXWL2AZwRTwpHt6c7Y8WTlAof+OW9hbzQmxvEkeA0TJ876BW7ZOMeoJOTp
         lOo63yC4+zBLBXvZo/2/FMx6z+2/8jFM2BkzsNbhqwX0szsJeD6XvBxHMSLGOYgWeFuS
         B9nw==
X-Forwarded-Encrypted: i=1; AJvYcCVY2me7blVvCjF2lQ/UBSSgToIfoi/wrudrUMQEoWLONNXO8pUCLRmtCUeBAwcjI3PiCQ08UqaA@vger.kernel.org, AJvYcCXdWwWDQMb3ADCGg2o3Z9Fl6eRHISFKCn+i/JMm29DcN9NKMFJlLYT7Bn20XKxAd8CuuPvonUH3beCgSoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvPAPizl6rSMXBuVQF7KaDRmCyb6lw/ZnDY5AUoQ6y/tDKnPjV
	Otb5vrhXi/zvSY77Uupj4dYWhg6UGWK/TbzUSydrbyaq3OdOFPBTtD6VG6ZUYTAwJK9w6VssSx7
	hcsfsPGpQI7GM9WuX3syG/s+fO/E=
X-Gm-Gg: ASbGnctDy1dcilBM66jzcuR+cKN4G+oPl5voxKejzGv7sqW2485vtKemvZQkNuRoBhG
	fAdvVtuRlNlOIuZ5pXwk4ePzthyr8DkzFXIYlHm9xlRPEwdWBVc/t3fNCmHA/FHei+00HpK8KTc
	43WQQHWZwARvXRKOrmtJwByAI/Vdf6xg==
X-Google-Smtp-Source: AGHT+IGCMVvzBkTONyCiGLzGRx+BYTIKnuFp2mhSuxrcG5tm0TfmfKRTUXaNMu0nFAC/FmnQ5jzwqcE+MIxDGGSNRQM=
X-Received: by 2002:a05:6102:6a98:b0:4bb:9b46:3f6f with SMTP id
 ada2fe7eead31-4bb9b467825mr1105069137.1.1739050459210; Sat, 08 Feb 2025
 13:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1737717687-16744-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4y2zjCzRUgxkx2GpspFBD9Yon=R3SLaGezk9drQz+ikrQ@mail.gmail.com> <28edc5df-eed5-45b8-ab6d-76e63ef635a9@126.com>
In-Reply-To: <28edc5df-eed5-45b8-ab6d-76e63ef635a9@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 9 Feb 2025 10:34:08 +1300
X-Gm-Features: AWEUYZmHeEniBO1KvmZ5SsYHPj_w-1AYYlBIQu74Tt0dYgU0dn8Jppk0fRFDeAs
Message-ID: <CAGsJ_4yC=950MCeLDc-8inT52zH6GSEGBBfk+A0dwWEDE5_CMg@mail.gmail.com>
Subject: Re: [PATCH] mm/cma: add an API to enable/disable concurrent memory
 allocation for the CMA
To: Ge Yang <yangge1116@126.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, aisheng.dong@nxp.com, liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 9:50=E2=80=AFPM Ge Yang <yangge1116@126.com> wrote:
>
>
>
> =E5=9C=A8 2025/1/28 17:58, Barry Song =E5=86=99=E9=81=93:
> > On Sat, Jan 25, 2025 at 12:21=E2=80=AFAM <yangge1116@126.com> wrote:
> >>
> >> From: yangge <yangge1116@126.com>
> >>
> >> Commit 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex loc=
k"")
> >> simply reverts to the original method of using the cma_mutex to ensure
> >> that alloc_contig_range() runs sequentially. This change was made to a=
void
> >> concurrency allocation failures. However, it can negatively impact
> >> performance when concurrent allocation of CMA memory is required.
> >
> > Do we have some data?
> Yes, I will add it in the next version, thanks.
> >
> >>
> >> To address this issue, we could introduce an API for concurrency setti=
ngs,
> >> allowing users to decide whether their CMA can perform concurrent memo=
ry
> >> allocations or not.
> >
> > Who is the intended user of cma_set_concurrency?
> We have some drivers that use cma_set_concurrency(), but they have not
> yet been merged into the mainline. The cma_alloc_mem() function in the
> mainline also supports concurrent allocation of CMA memory. By applying
> this patch, we can also achieve significant performance improvements in
> certain scenarios. I will provide performance data in the next version.
> I also feel it is somewhat
> > unsafe since cma->concurr_alloc is not protected by any locks.
> Ok, thanks.
> >
> > Will a user setting cma->concurr_alloc =3D 1 encounter the original iss=
ue that
> > commit 60a60e32cf91 was attempting to fix?
> >
> Yes, if a user encounters the issue described in commit 60a60e32cf91,
> they will not be able to set cma->concurr_alloc to 1.

A user who hasn't encountered a problem yet doesn't mean they won't
encounter it; it most likely just means the testing time hasn't been long
enough.

Is it possible to implement a per-CMA lock or range lock that simultaneousl=
y
improves performance and prevents the original issue that commit
60a60e32cf91 aimed to fix?

I strongly believe that cma->concurr_alloc is not the right approach. Let's
not waste our time on this kind of hack or workaround.  Instead, we should
find a proper fix that remains transparent to users.

> >>
> >> Fixes: 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex loc=
k"")
> >> Signed-off-by: yangge <yangge1116@126.com>
> >> Cc: <stable@vger.kernel.org>
> >> ---
> >>   include/linux/cma.h |  2 ++
> >>   mm/cma.c            | 22 ++++++++++++++++++++--
> >>   mm/cma.h            |  1 +
> >>   3 files changed, 23 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/cma.h b/include/linux/cma.h
> >> index d15b64f..2384624 100644
> >> --- a/include/linux/cma.h
> >> +++ b/include/linux/cma.h
> >> @@ -53,6 +53,8 @@ extern int cma_for_each_area(int (*it)(struct cma *c=
ma, void *data), void *data)
> >>
> >>   extern void cma_reserve_pages_on_error(struct cma *cma);
> >>
> >> +extern bool cma_set_concurrency(struct cma *cma, bool concurrency);
> >> +
> >>   #ifdef CONFIG_CMA
> >>   struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)=
;
> >>   bool cma_free_folio(struct cma *cma, const struct folio *folio);
> >> diff --git a/mm/cma.c b/mm/cma.c
> >> index de5bc0c..49a7186 100644
> >> --- a/mm/cma.c
> >> +++ b/mm/cma.c
> >> @@ -460,9 +460,17 @@ static struct page *__cma_alloc(struct cma *cma, =
unsigned long count,
> >>                  spin_unlock_irq(&cma->lock);
> >>
> >>                  pfn =3D cma->base_pfn + (bitmap_no << cma->order_per_=
bit);
> >> -               mutex_lock(&cma_mutex);
> >> +
> >> +               /*
> >> +                * If the user sets the concurr_alloc of CMA to true, =
concurrent
> >> +                * memory allocation is allowed. If the user sets it t=
o false or
> >> +                * does not set it, concurrent memory allocation is no=
t allowed.
> >> +                */
> >> +               if (!cma->concurr_alloc)
> >> +                       mutex_lock(&cma_mutex);
> >>                  ret =3D alloc_contig_range(pfn, pfn + count, MIGRATE_=
CMA, gfp);
> >> -               mutex_unlock(&cma_mutex);
> >> +               if (!cma->concurr_alloc)
> >> +                       mutex_unlock(&cma_mutex);
> >>                  if (ret =3D=3D 0) {
> >>                          page =3D pfn_to_page(pfn);
> >>                          break;
> >> @@ -610,3 +618,13 @@ int cma_for_each_area(int (*it)(struct cma *cma, =
void *data), void *data)
> >>
> >>          return 0;
> >>   }
> >> +
> >> +bool cma_set_concurrency(struct cma *cma, bool concurrency)
> >> +{
> >> +       if (!cma)
> >> +               return false;
> >> +
> >> +       cma->concurr_alloc =3D concurrency;
> >> +
> >> +       return true;
> >> +}
> >> diff --git a/mm/cma.h b/mm/cma.h
> >> index 8485ef8..30f489d 100644
> >> --- a/mm/cma.h
> >> +++ b/mm/cma.h
> >> @@ -16,6 +16,7 @@ struct cma {
> >>          unsigned long   *bitmap;
> >>          unsigned int order_per_bit; /* Order of pages represented by =
one bit */
> >>          spinlock_t      lock;
> >> +       bool concurr_alloc;
> >>   #ifdef CONFIG_CMA_DEBUGFS
> >>          struct hlist_head mem_head;
> >>          spinlock_t mem_head_lock;
> >> --
> >> 2.7.4
> >>
> >>
> >

Thanks
Barry

