Return-Path: <stable+bounces-119708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C356A465CE
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769521892D4B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A0921CC5A;
	Wed, 26 Feb 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYE/fuy3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CC21CC60
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584850; cv=none; b=A1HA64zsP23HKOZd5UNtBw4UzODQwwUIuJyopdvBIFUWsfOH6S1RkDxxdY0gAZHhU9BL5TZC2CV0VCP1SMlVZfpZrCrVHC67uLOvMm2f1gMXziJSoWjMxerZoGp6LQYTgnRW7anarrahdCSMRcL5blDfoTXaUzPrBymTjNSCbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584850; c=relaxed/simple;
	bh=Uyak8CwF5o+Wm3VRot5O9DshDiDdqoqUWu7L4+3kXJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrsWI00sMKVkqiJ0rQZHxomLtPdRMEM4aLtnocKpA7bHdAi34Kv3NIYMCLcd5mzZyuQ3MlMEEoEVL1ELNaZRfYR5DuCq3+Bnpkth4Z0tXa8I/Dc0bHm7n/b52TCFLjeGfX/dKKlSdobSZGLYJurXwdLYVU97AmIK+ns07pmPy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYE/fuy3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22117c396baso180335ad.1
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 07:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740584848; x=1741189648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRFGoHIIJY53xiHgJ59l5ZxWV0vzgi3deLFH8/jvNhQ=;
        b=iYE/fuy3wBeKy+1P6SIj9CuUFgRb333QTIcMGREQCrGgk40Zj2uIM1fFjB0jXsiKMz
         fQjvuK28YbQfvzMiOvow3GvjoUeQ6FnGe0jBh1ZhHkrgXsMg5udgfyww7BIzy0Dqsnze
         gwMoSpp/Or/Zu6OrIqvYH1eYuMXK35oA6behSxESkwEDZ28pg4zYbXXVXmGHD+W3QOSq
         cQLB8r7D814yu/AXzEZT0eix4XVyTTinlp3H+c2XXL9bjHdRhyGtpz6Rj3a4cA/qMy+C
         ym4/53OkYfGC+Yz3Q3V1W+H7YgF1asdubuov3fnE/A69I3cd7gULsTilwEbGw6Bp3I/4
         SdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584848; x=1741189648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRFGoHIIJY53xiHgJ59l5ZxWV0vzgi3deLFH8/jvNhQ=;
        b=Zaf3hqvdwb29ptwylbhg5I+Vj7lV49gf4OX/pmIX30tQ0s6HV7VqkcdPPi/h0xTgb8
         5xqTqwyz3JiHP/GBCjbAjN75YOmdHuLDYEo0B/bu7yEFk3a3syGiPgWE2O9MEXwkEtCI
         3TZVTJoplq7tPgVNAok2hR7P2DU5AswZc+jxEMAOHRZcoXvZWe749YAnUnyk7v1EKtNJ
         hF9e4pWMIdWexGInjN4msr6QoSpGsVEFMhFjyWwmn4pwNnBmjEtjn1ElHA+EXr1wM/7K
         ckiChd52b7w/0QUzcpgWkv8hxBTHrksB3+LIywcvPtB8drgad6HmNa0ClWNWJGiTzG5w
         qpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKzqq/TLl9EiuMfPbjsxqfX7EpbY11LQJRLohDlu52OqqKNKpCculBzgkI+ILdjeN2MxDZFUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOnfwB9/wfqvY7XtEm5nGc3wns273A1RljnyYDKcMoXSnxLyV
	xW0a7UkDLGc1BFOkaWwtGtPJ7wxwW8YzsnRN5i4PvtSozQ6cvRY3oTFUygEbCbssb0qlEG5KX8A
	VJwwyRavdRHrCThcuuChoYx1me/76I2xmHEzH
X-Gm-Gg: ASbGncvLHEP4ZrLyxSpfHfAmzYzSgoiwL+FY3otnO/WqgrX+GJeFYa5mwg8zk+sHIf6
	zPYCrwaobpgFCHdWv4aGcB8F5veEp6ddDb+SNBGhrf1zLWpXu/R+sT9X8U0V+6GwI+sH9h+jCD5
	GDrbp7SQ==
X-Google-Smtp-Source: AGHT+IGa4GKhNRite0U511EGpJ4xAwmZaDXCSyRe/gPzU0KU9x+OG68QRbqV2kiShWpG5u1DMO9BpBxEWRtYqDzKvh8=
X-Received: by 2002:a17:903:234c:b0:21f:2ded:bfc5 with SMTP id
 d9443c01a7336-22307aab886mr6925645ad.28.1740584847732; Wed, 26 Feb 2025
 07:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226114815.758217-1-bgeffon@google.com> <1a1bd8ed-1204-4ca4-82ed-cdba689c06c5@linux.alibaba.com>
In-Reply-To: <1a1bd8ed-1204-4ca4-82ed-cdba689c06c5@linux.alibaba.com>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 26 Feb 2025 10:46:51 -0500
X-Gm-Features: AQ5f1Jos1pitl_qWm7lZ3Z5Q3y2wE_MYIVSPPUPRGZylhggjBB0aW6j39ECj-wM
Message-ID: <CADyq12zO8ZSHREdKu4fgqOUE81doZuQW8L2ZXvXOa29a2JeyMQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix finish_fault() handling for large folios
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, Marek Maslanka <mmaslanka@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:17=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/2/26 19:48, Brian Geffon wrote:
> > When handling faults for anon shmem finish_fault() will attempt to inst=
all
> > ptes for the entire folio. Unfortunately if it encounters a single
> > non-pte_none entry in that range it will bail, even if the pte that
> > triggered the fault is still pte_none. When this situation happens the
> > fault will be retried endlessly never making forward progress.
> >
> > This patch fixes this behavior and if it detects that a pte in the rang=
e
> > is not pte_none it will fall back to setting just the pte for the
> > address that triggered the fault.
>
> Could you describe in detail how this situation occurs? How is the none
> pte inserted within the range of the large folio? Because we have checks
> in shmem to determine if a large folio is suitable.

We're seeing it because of racing shmem_undo_range() calls, basically
we have a portion of the folio is zapped and that prevents
finish_fault() from ever completing because it has an assumption that
the entire range must be pte_none.

>
> Anyway, if we find the pte_range_none() is false, we can fallback to
> per-page fault as the following code shows (untested), which seems more
> simple?

Yah, I like this approach. I'll send a v2 with you as a Suggested-by.

>
> diff --git a/mm/memory.c b/mm/memory.c
> index a8196ae72e9a..8a2a9fda5410 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5219,7 +5219,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>          bool is_cow =3D (vmf->flags & FAULT_FLAG_WRITE) &&
>                        !(vma->vm_flags & VM_SHARED);
>          int type, nr_pages;
> -       unsigned long addr =3D vmf->address;
> +       unsigned long addr;
> +       bool fallback_per_page =3D false;
> +
> +
> +fallback:
> +       addr =3D vmf->address;
>
>          /* Did we COW the page? */
>          if (is_cow)
> @@ -5258,7 +5263,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>           * approach also applies to non-anonymous-shmem faults to avoid
>           * inflating the RSS of the process.
>           */
> -       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) =
{
> +       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))
> +           || unlikely(fallback_per_page)) {
>                  nr_pages =3D 1;
>          } else if (nr_pages > 1) {
>                  pgoff_t idx =3D folio_page_idx(folio, page);
> @@ -5294,9 +5300,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>                  ret =3D VM_FAULT_NOPAGE;
>                  goto unlock;
>          } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) =
{
> -               update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
> -               ret =3D VM_FAULT_NOPAGE;
> -               goto unlock;
> +               fallback_per_page =3D true;
> +               pte_unmap_unlock(vmf->pte, vmf->ptl);
> +               goto fallback;
>          }
>
>          folio_ref_add(folio, nr_pages - 1);
>
> >
> > Cc: stable@vger.kernel.org
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support larg=
e folio")
> > Reported-by: Marek Maslanka <mmaslanka@google.com>
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >   mm/memory.c | 19 ++++++++++++++++---
> >   1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index b4d3d4893267..32de626ec1da 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5258,9 +5258,22 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >               ret =3D VM_FAULT_NOPAGE;
> >               goto unlock;
> >       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> > -             update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
> > -             ret =3D VM_FAULT_NOPAGE;
> > -             goto unlock;
> > +             /*
> > +              * We encountered a set pte, let's just try to install th=
e
> > +              * pte for the original fault if that pte is still pte no=
ne.
> > +              */
> > +             pgoff_t idx =3D (vmf->address - addr) / PAGE_SIZE;
> > +
> > +             if (!pte_none(ptep_get_lockless(vmf->pte + idx))) {
> > +                     update_mmu_tlb_range(vma, addr, vmf->pte, nr_page=
s);
> > +                     ret =3D VM_FAULT_NOPAGE;
> > +                     goto unlock;
> > +             }
> > +
> > +             vmf->pte =3D vmf->pte + idx;
> > +             page =3D folio_page(folio, idx);
> > +             addr =3D vmf->address;
> > +             nr_pages =3D 1;
> >       }
> >
> >       folio_ref_add(folio, nr_pages - 1);

