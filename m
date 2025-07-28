Return-Path: <stable+bounces-164991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA6DB14118
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 19:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892FF168B77
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258A26F47D;
	Mon, 28 Jul 2025 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FiURPs8k"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88FE1B0F1E
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753723034; cv=none; b=eJhI9LSSVWJKTpb/ZzDH72cRG248WxoB7IIgPCNdPYbS/IR0odnXKDDfJ3HdAHCGaknxhseezbWb9ADAcuptaP3Z+ksZhuK3GpvzmsJMr2mm5UqRxvE47PmHRMhLZmPFEUNaX+d60Hc+dMwiKN2tyeitUSTnf3ezV313SgygFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753723034; c=relaxed/simple;
	bh=dCGL9BqXQ+3CzZDvRjNFmap92b/+aEqgRPHbjk3YeS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEHe4oLDmxlaYhE3O8eUoCY5V7xyUGG+NyGoRxNAIuf7cChhMJ3TQkGl0kPUjH64COGhlhXCWttD8IAVZkrXgbkugGKp/PaDWKV2CDHX79jAwWO1yukMVKtW8/rWeFTsUT3KHDz54ugf4KjlajCM5ixZtnteRRSGnd6RWUj1TC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FiURPs8k; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab3855fca3so19411cf.1
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753723031; x=1754327831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vKuqsMcT46hBPIeeydmoWyK22Wv2QkCzgzDxJHhBAg=;
        b=FiURPs8ktf2WhT4S8/DpNal/kWtF1Qbkm+d9DM7yjflLS14v/F44dJQXoJ2u02MLnD
         /iXLO98nQRNVxfrE/lbvZRaUscaQHvOu/riO8L+m/kzBF81d3qF7ZEQeDqrZJ449TRAz
         PsANhdyTabCqRIN9Yp3NNmlbTEiBrtdua7kogwofq7gjlPdPIYZnkDEojj5JbmtsMEfT
         fbJLOK1aKlblQbmZ/zuvRSnQIn7YHv8ghkbnAvpb0qUDJT8atM7hRHLWMP1WHMQxp1vd
         JBBZTCljY7K8enhbWR1dCUuKs9lxxZEIjOXYdMlMFb+aMMA+pCnaPtKzOqBXXvcqq1ZF
         s+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753723031; x=1754327831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vKuqsMcT46hBPIeeydmoWyK22Wv2QkCzgzDxJHhBAg=;
        b=VRiYAgCGZO7PvltKAMHVb1GDO3+peHVCBh4FEDXh8wVAgBI7ZWqa/d6zRv3qxePCma
         CNCl57RsOJaOgGrSY0VG6kPGNKLjXi9m1HLwfVkXwlYOGOactGynTacPJgBdJfhb2BOo
         t+tf3ZvN9zXLWAdFwMOb/RuibmXzgc8b5FqfFuQP0lVGky+t1FaNEwJyEXsUVTBK4uVl
         aPGZDZq8pxWKjDRKWWNYZixXr32vSSEpo+kIHtW+VFYY7T4KdfpKWiXuGdHfEpgOh5nZ
         PNZ/RKRAH9LgR/iejv5SMoiY3j4eUxLOdiGTcx+nEY4hI4vdqVNy1o5OFZ24/zNthNo/
         ayvA==
X-Forwarded-Encrypted: i=1; AJvYcCW/kdDWtJ/AHCUoyK7ABspVxM8/SPiXwplq9JrsasO1IpnpyA2a9Kf3tWhQzSKS5HANxIzzLvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VeBAFCSv6j8wa/uova+JsHUOoSBLWuJMkvI3iIOKQ+L+6VYA
	gG0MA7gf75nz4Jt2YrOkm+jsoPL4DRPiYgekrUmkY++QA2nWYfl8sNVBUAztpV6W0SQvOyCvPkN
	mPQBxGJm6we/bw6DIHKyxObU6XneRwgKWat+0zg+M
X-Gm-Gg: ASbGncsw7viIoeYz1j2ZRJDnz6qHAoFeGEdMZ21mcqyek4zuDx70jfaCsAWqXHzH8WA
	T6ZyqvIaAYJtif77XS4ddlRSYOwbTqV4dPSgH/tWNu3sq+4YJCWH7ZgRyKWWih5cUy1+0bQxIj9
	Guz7gRILXYWoatoxHyQcBSEHkhOI9KGA8Bi97NagfXGYyDhOy/43Vnzqixaxg9+GFXhxedboe9l
	+6v/iQjGjDejYI4Y++QiQRYyH1AJfk0lPC0iYPP+f5qCo0h
X-Google-Smtp-Source: AGHT+IELxZqzgYWAQP9Ngohy4ApnkBo9oFMQtzvoZOAJ7yizj5sLIqWpkPtI4MboAEZl0uq5UgdDsHMj4GTXCTR/jaM=
X-Received: by 2002:a05:622a:148c:b0:4a7:e3b:50be with SMTP id
 d75a77b69052e-4ae9cc0b2f3mr8431311cf.16.1753723030772; Mon, 28 Jul 2025
 10:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728170950.2216966-1-surenb@google.com>
In-Reply-To: <20250728170950.2216966-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Jul 2025 10:16:59 -0700
X-Gm-Features: Ac12FXx5Ajyiy-dotDY0A444StrFRdZUfUHPwsQH_l1PjmWS7zmm2-g_4bnZRTc
Message-ID: <CAJuCfpGDFcz0rTdnJx3UkSCDt3Ri-R55swZcqOoiLBbg8iF2zw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
To: akpm@linux-foundation.org
Cc: jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:09=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> By inducing delays in the right places, Jann Horn created a reproducer
> for a hard to hit UAF issue that became possible after VMAs were allowed
> to be recycled by adding SLAB_TYPESAFE_BY_RCU to their cache.
>
> Race description is borrowed from Jann's discovery report:
> lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() under
> rcu_read_lock(). At that point, the VMA may be concurrently freed, and
> it can be recycled by another process. vma_start_read() then
> increments the vma->vm_refcnt (if it is in an acceptable range), and
> if this succeeds, vma_start_read() can return a recycled VMA.
>
> In this scenario where the VMA has been recycled, lock_vma_under_rcu()
> will then detect the mismatching ->vm_mm pointer and drop the VMA
> through vma_end_read(), which calls vma_refcount_put().
> vma_refcount_put() drops the refcount and then calls rcuwait_wake_up()
> using a copy of vma->vm_mm. This is wrong: It implicitly assumes that
> the caller is keeping the VMA's mm alive, but in this scenario the caller
> has no relation to the VMA's mm, so the rcuwait_wake_up() can cause UAF.
>
> The diagram depicting the race:
> T1         T2         T3
> =3D=3D         =3D=3D         =3D=3D
> lock_vma_under_rcu
>   mas_walk
>           <VMA gets removed from mm>
>                       mmap
>                         <the same VMA is reallocated>
>   vma_start_read
>     __refcount_inc_not_zero_limited_acquire
>                       munmap
>                         __vma_enter_locked
>                           refcount_add_not_zero
>   vma_end_read
>     vma_refcount_put
>       __refcount_dec_and_test
>                           rcuwait_wait_event
>                             <finish operation>
>       rcuwait_wake_up [UAF]
>
> Note that rcuwait_wait_event() in T3 does not block because refcount
> was already dropped by T1. At this point T3 can exit and free the mm
> causing UAF in T1.
> To avoid this we move vma->vm_mm verification into vma_start_read() and
> grab vma->vm_mm to stabilize it before vma_refcount_put() operation.
>
> Fixes: 3104138517fc ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/all/CAG48ez0-deFbVH=3DE3jbkWx=3DX3uVbd8nW=
eo6kbJPQ0KoUD+m2tA@mail.gmail.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: <stable@vger.kernel.org>
> ---
> - Applies cleanly over mm-unstable.
> - Should be applied to 6.15 and 6.16 but these branches do not
> have lock_next_vma() function, so the change in lock_next_vma() should be
> skipped when applying to those branches.

Andrew, if you would like me to post a separate patch for 6.15 and
6.16 please let me know. The merge conflict in those branches should
be trivial: just skip the change in lock_next_vma() which does not
exist in those branches.

>
>  include/linux/mmap_lock.h | 21 +++++++++++++++++++++
>  mm/mmap_lock.c            | 10 +++-------
>  2 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 1f4f44951abe..4ee4ab835c41 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -12,6 +12,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
>  #include <linux/tracepoint-defs.h>
>  #include <linux/types.h>
>  #include <linux/cleanup.h>
> +#include <linux/sched/mm.h>
>
>  #define MMAP_LOCK_INITIALIZER(name) \
>         .mmap_lock =3D __RWSEM_INITIALIZER((name).mmap_lock),
> @@ -183,6 +184,26 @@ static inline struct vm_area_struct *vma_start_read(=
struct mm_struct *mm,
>         }
>
>         rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> +
> +       /*
> +        * If vma got attached to another mm from under us, that mm is no=
t
> +        * stable and can be freed in the narrow window after vma->vm_ref=
cnt
> +        * is dropped and before rcuwait_wake_up(mm) is called. Grab it b=
efore
> +        * releasing vma->vm_refcnt.
> +        */
> +       if (unlikely(vma->vm_mm !=3D mm)) {
> +               /*
> +                * __mmdrop() is a heavy operation and we don't need RCU
> +                * protection here. Release RCU lock during these operati=
ons.
> +                */
> +               rcu_read_unlock();
> +               mmgrab(vma->vm_mm);
> +               vma_refcount_put(vma);
> +               mmdrop(vma->vm_mm);
> +               rcu_read_lock();
> +               return NULL;
> +       }
> +
>         /*
>          * Overflow of vm_lock_seq/mm_lock_seq might produce false locked=
 result.
>          * False unlocked result is impossible because we modify and chec=
k
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 729fb7d0dd59..aa3bc42ecde0 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -164,8 +164,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_s=
truct *mm,
>          */
>
>         /* Check if the vma we locked is the right one. */
> -       if (unlikely(vma->vm_mm !=3D mm ||
> -                    address < vma->vm_start || address >=3D vma->vm_end)=
)
> +       if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
>                 goto inval_end_read;
>
>         rcu_read_unlock();
> @@ -236,11 +235,8 @@ struct vm_area_struct *lock_next_vma(struct mm_struc=
t *mm,
>                 goto fallback;
>         }
>
> -       /*
> -        * Verify the vma we locked belongs to the same address space and=
 it's
> -        * not behind of the last search position.
> -        */
> -       if (unlikely(vma->vm_mm !=3D mm || from_addr >=3D vma->vm_end))
> +       /* Verify the vma is not behind of the last search position. */
> +       if (unlikely(from_addr >=3D vma->vm_end))
>                 goto fallback_unlock;
>
>         /*
>
> base-commit: c617a4dd7102e691fa0fb2bc4f6b369e37d7f509
> --
> 2.50.1.487.gc89ff58d15-goog
>

