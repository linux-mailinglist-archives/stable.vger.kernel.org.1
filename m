Return-Path: <stable+bounces-160377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEACAFB7A2
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 17:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1FB1AA0030
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE931E1E1C;
	Mon,  7 Jul 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTcEFwCJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396A136672;
	Mon,  7 Jul 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902871; cv=none; b=eL85FGAub/KEPPDc1iS9DWVzIO2dhayvOagoYx8rsOM9yrOctq1gsyXRqjAg9W1oEH1ASFOTr5MhNwxcIElz3aWlFXe0NR+MTxLrII3UFZ7Y1Z0VKKry0svuGaHSv731nikuMr5SmkGwG3iXwWCnCCk2oLhoM0fvgu5Sk4I+J9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902871; c=relaxed/simple;
	bh=gO8pDrbYSpp44o5cYXM8N/JCbwz9CdCfmJH52gAOY4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2+GUrHTlMoEGd/Lc+JJpAR2juAJ1foxb6Abap5TNxWqg+7TCPjuZZVI2vivciqJlVkVQmXFIx/hVp1O0Ckksn6TFdpMX2WhpG3vJUWKW9Krvj3e+9BlvKsao0LLiPXEVXkf7Qfytib0IiKvfQ4npEBLNwI+Zv9DeHjac9g5Yrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTcEFwCJ; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-87f74a28a86so2494767241.2;
        Mon, 07 Jul 2025 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751902869; x=1752507669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOso/rpbJ/NgC8eSTkPXsXfGalwkSd1v9wHI3jcpdtU=;
        b=UTcEFwCJ74aNgkxgP+tisbg7YWgs5EQXET+YG59a4kM9X+XSbeylHl8pKJS0cQZTJG
         WpO0pOyFk7vzZjI2ECL6O8TITYYZbmUGHf7h2f0qEKA3tLXP5GbxOQePVTn3vAx8Y47C
         EORu6p0o+g/vOzgANNIK7BLWPWLD0VQTZIfIEi+3xU2md9OyUcrBrEWLeB848j/4R2uW
         Lo+PxOngbXX3n+TtCTQsKt5lIoe5vMiRAen4btgI+KpeRQWEU9rDv8JeeTEt7Yv5lDQL
         DGj6uEhqC9qMC/hag0K7g4yxvtae8M6k0vnWKeT6aKPTQGd0qPZDITLepdzo3FKeWF3D
         Wr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902869; x=1752507669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOso/rpbJ/NgC8eSTkPXsXfGalwkSd1v9wHI3jcpdtU=;
        b=VfR7tskBCpm5mF/NTu0521Agd6VJFeRLpXZOLAtK2qlxlcYr0cPyVl4ulLeakmNo46
         N572jFsTrCa87LDi1J/JUUBXPUo2QFcXoTlfHUnlPIF/Lb8XAMvsC/tUuzbcALczC0AT
         S3V+L9WYimdBvsORAkZTvi9ZquRnMgjj1ks0ybc6U29Q6Z5VDvu3rTKH8kBtbq4pfwFu
         oJoPLSlxbF930vnJIb6UEwVPK6QH63fJuS8FijJPti16MCSruKOjfgnyHISp1GuSLNdQ
         ELczhVN75JdPDAcHTh7QUG4Aqe2LUKbK14ocVOB14id/aSFlaH5tvsd8yL7a+6LGQIlx
         sHoA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4aiskyb6hIQkI52Ojad245YwKzEqt7kXVxqfq3gjvjCWi7B9lUFmeQlAA4Xt8WK8mnRBBbv/34IMHcA=@vger.kernel.org, AJvYcCXnqAHJwaY71p6YItngVMVLQGqOrRncLRpelycKPXwmc6nrLsDrHTSAxe4Fzo+foNbW3GYeRQgz@vger.kernel.org
X-Gm-Message-State: AOJu0YxyhRMHtrBxmfaDiwSolAWGf5OGWyA4Vq94yi7QB/v/e+xpkLl2
	KSRbp7bQQnFOpR6FGKmP+Q8Sa2yScqGbpIF7BlfXqjwKI1mYP+IA6+k5lM0w0asNKpVy3M1QKku
	6sfj/jY06wKO5MKhEu7kw0u1S5RxaVa0=
X-Gm-Gg: ASbGncuRgQK3vNrByijNagAi9NzY3QCN/Xb0vwh2i9S06XikLEGztJ8c5BphbmyTyqg
	LX85ZSlWFsCZvAuSbEUd6sNW3g+x+LrEeJZA6xyqF77EXW2/W+f3EGp7s9RugBTUYNFN4AoEwWq
	nT/bmiIB2I7Q3XvyJcBfGy9BrLT+X63Ov0OYYAvXKSpRGH
X-Google-Smtp-Source: AGHT+IGSN1O8lQpDTPtqxgti1UrH4RQigSLZXKTO63RCc9Ii3DWxoJb0zhIToaSJqmxiqFJzc6TxB9dgjkrGQ0NAAJA=
X-Received: by 2002:a05:6102:5813:b0:4e7:dbd2:4605 with SMTP id
 ada2fe7eead31-4f305bbfb6bmr5513792137.24.1751902868878; Mon, 07 Jul 2025
 08:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701143100.6970-1-lance.yang@linux.dev> <aGtdwn0bLlO2FzZ6@harry>
In-Reply-To: <aGtdwn0bLlO2FzZ6@harry>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 7 Jul 2025 23:40:55 +0800
X-Gm-Features: Ac12FXzNubUaYli6QAPDLGtouYMN2VMWCTFnQ5iaenP8VAQuo6CN289JAgNG3X4
Message-ID: <CAGsJ_4yk5FPfieyRyzLwrgHu2CYADOtZRZKa0ORo=y4nYd-KrQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	x86@kernel.org, huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, 
	riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	mingzhe.yang@ly.com, stable@vger.kernel.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 1:40=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> On Tue, Jul 01, 2025 at 10:31:00PM +0800, Lance Yang wrote:
> > From: Lance Yang <lance.yang@linux.dev>
> >
> > As pointed out by David[1], the batched unmap logic in try_to_unmap_one=
()
> > may read past the end of a PTE table when a large folio's PTE mappings
> > are not fully contained within a single page table.
> >
> > While this scenario might be rare, an issue triggerable from userspace =
must
> > be fixed regardless of its likelihood. This patch fixes the out-of-boun=
ds
> > access by refactoring the logic into a new helper, folio_unmap_pte_batc=
h().
> >
> > The new helper correctly calculates the safe batch size by capping the =
scan
> > at both the VMA and PMD boundaries. To simplify the code, it also suppo=
rts
> > partial batching (i.e., any number of pages from 1 up to the calculated
> > safe maximum), as there is no strong reason to special-case for fully
> > mapped folios.
> >
> > [1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fc=
be@redhat.com
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: David Hildenbrand <david@redhat.com>
> > Closes: https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c8=
57fcbe@redhat.com
> > Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large foli=
os during reclamation")
> > Suggested-by: Barry Song <baohua@kernel.org>
> > Acked-by: Barry Song <baohua@kernel.org>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <lance.yang@linux.dev>
> > ---
>
> LGTM,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>
> With a minor comment below.
>
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index fb63d9256f09..1320b88fab74 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -2206,13 +2213,16 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >                       hugetlb_remove_rmap(folio);
> >               } else {
> >                       folio_remove_rmap_ptes(folio, subpage, nr_pages, =
vma);
> > -                     folio_ref_sub(folio, nr_pages - 1);
> >               }
> >               if (vma->vm_flags & VM_LOCKED)
> >                       mlock_drain_local();
> > -             folio_put(folio);
> > -             /* We have already batched the entire folio */
> > -             if (nr_pages > 1)
> > +             folio_put_refs(folio, nr_pages);
> > +
> > +             /*
> > +              * If we are sure that we batched the entire folio and cl=
eared
> > +              * all PTEs, we can just optimize and stop right here.
> > +              */
> > +             if (nr_pages =3D=3D folio_nr_pages(folio))
> >                       goto walk_done;
>
> Just a minor comment.
>
> We should probably teachhttps://lore.kernel.org/linux-mm/5db6fb4c-079d-42=
37-80b3-637565457f39@redhat.com/() to skip nr_pages pages,
> or just rely on next_pte: do { ... } while (pte_none(ptep_get(pvmw->pte))=
)
> loop in page_vma_mapped_walk() to skip those ptes?
>
> Taking different paths depending on (nr_pages =3D=3D folio_nr_pages(folio=
))
> doesn't seem sensible.

Hi Harry,

I believe we've already had this discussion here:
https://lore.kernel.org/linux-mm/5db6fb4c-079d-4237-80b3-637565457f39@redha=
t.com/

My main point is that nr_pages =3D folio_nr_pages(folio) is the
typical/common case.
Also, modifying page_vma_mapped_walk() feels like a layering violation.

>
> >               continue;
>
> --
> Cheers,
> Harry / Hyeonggon

Thanks
Barry

