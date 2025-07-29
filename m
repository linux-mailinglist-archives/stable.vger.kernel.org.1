Return-Path: <stable+bounces-165069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC82EB14F33
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1330518A21A0
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D721DE4C9;
	Tue, 29 Jul 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8s7ZIiw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7F1D9663
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799080; cv=none; b=tKslQ7T0DSmKiUzlxOAiTmFgTcBjiRP/7oRBJKLdquVJnYJco1HxGdfiwinXXULikhHO05xWhPuhrjVtiW5wktmaboQZvZqwVIkeOXamJgbAashJMKuDDZpDn6MGGr/D42/vE5EQhjU9rlD/mWqsQ8AsEkI5XZo/Eh7OQHCJ8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799080; c=relaxed/simple;
	bh=WsoMbPKgbLSyP8dfKmStQXe5rHA35edeeQVDATEIyQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEki8wX4JUJqqT1AzGp6+vOwdbCYZpqfFavgCndriW+e8lnrzRTNCJuTAGVPDbuDu1ugjbLqRPmNCf0kc/kMFJYVs/a6pwwyJUj/rsptCCGm2ZU3hsHjWB7X4xgH4QqKaEqwJoEsON7HmYYiOqFDEQU+VYwGwFYOLrhoTWL4UX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8s7ZIiw; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab3855fca3so314861cf.1
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753799076; x=1754403876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVNRcNSlbkisMQ7P3F3haQRx0uZA0/7rOJPK9raObGg=;
        b=l8s7ZIiwguNOMIV2sGKxh1L1IAk4HJ3Hz1ir5o/a66m6c/6XK34wcKhsONSHt7imXo
         RQ5EGA7vaQjlfqC9qjgjjkvRj+gQ3143Sq9wpzcYs8xAumzwETBhps6XOQLGWl9AlIoy
         zr4NpEV6twowy06o2GUwwS8FDYEt0OzW0LjJZP9YmDU9z5a/cFKgyY28YZaW2xOiLLDN
         36ovf9BEFIzlJIaOroh6idPLRlc5f8xeaOQJktrL1pE9BcKimcM69XXW+DcIUGG6JCMN
         Qs7flEYmHIy9H3Wfo8XuXYswmOL4S4xr0I4YIRFvEZwrkN00sjWi3pvW84ul56/nYH3k
         7yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753799076; x=1754403876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVNRcNSlbkisMQ7P3F3haQRx0uZA0/7rOJPK9raObGg=;
        b=OyesF/rU5gvRpTwr/sYFC83g5Rf7rMCNBjSO9cW7qA5xGEGEXOdPtPOVlZNKhes341
         ZL+c535JTbNXoRbbTWc0EjhSnNzWUnkbuPMPIdtqTH0iBkkeUZFx15GPtseHBh4RGSSE
         Ath/6txKH9CkiYpFGy3mXNdWn8vWijdjR31GgZCGX6Um3GdMb0bksc7I99YHzTfuSZIc
         OsLknRLNriOtUibyVm/Sm8zNIgCJTDswEhJlVokBEWPIFEVWdg6gqlEnCKZPv9VzoRzD
         1LUihhW+LrLrD+iBhH72WZPI3LhnrmLCkcrO0j5rVsuP9XTKPSQsvjVi6r7tBkYYmDph
         4ArQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI/+WgxEPcTd6gWxuqoXh0uAGT0fXUy8i9ForGOJa3ARs4VakdI05XrHaNGwMNz+9szCOuSWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUvVa9VNm00OYc9VRv83ik1B0bMm5kvlgMYw/7UdF6aKh3mzd7
	gmse8GiuHPxzukecaDRa9ck6p01rTInAqBLlHaYwDRUgefDOneQIeA5QJJrz1aMrB62m2UAJ0Nd
	s6fHg6+VekXNaYIX3+0kS1GoW2kGEsHgjmD924DtC
X-Gm-Gg: ASbGncs6rfZFT9nrFCTV2d7xcZT5AM+Yq31QlcmXfGVX+shzdMhPBT0t4QHXxRhQrXC
	wQDrGNDR1JGG7nFJIXhLWi5GS0Y+U4UY41MUUCtgid5HPE+uRDhzTqvxtBy3myg/8f6/CqTBqzD
	+WcMtAbzdKqWYMaNblgblA1LrkjYiEH1sGLcGG7WjaqHjCqRSpRzYeIVOkr/duJ4d/PpsF5WoEM
	4juaNxBZfh45qF8nxqwk8grm4OfQc/his/KBg==
X-Google-Smtp-Source: AGHT+IEXo19Mea95cq4eF+yZwTGp8JvbbbpniaHFDfY2wI+smq2JppWdL8kf+LAMrq8yQm/JSqfb/IL1F9mrSpQdTpE=
X-Received: by 2002:a05:622a:a:b0:4aa:cba2:2e67 with SMTP id
 d75a77b69052e-4aecfa456f1mr4144421cf.21.1753799074080; Tue, 29 Jul 2025
 07:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728175355.2282375-1-surenb@google.com> <63d2682f-a24e-4fe2-82d1-fb58a8575c6c@lucifer.local>
In-Reply-To: <63d2682f-a24e-4fe2-82d1-fb58a8575c6c@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Jul 2025 07:24:23 -0700
X-Gm-Features: Ac12FXynCQs1QPHMicNL6A7GQQxpOS8RnWUYjhc0eE8qQpCjkBRUbMLdsSemDCk
Message-ID: <CAJuCfpEHdv5VXrD06SO1WkB4itqNsaWq3YKoXVYtyLPP+Cq4Mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 2:57=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Jul 28, 2025 at 10:53:55AM -0700, Suren Baghdasaryan wrote:
> > By inducing delays in the right places, Jann Horn created a reproducer
> > for a hard to hit UAF issue that became possible after VMAs were allowe=
d
> > to be recycled by adding SLAB_TYPESAFE_BY_RCU to their cache.
> >
> > Race description is borrowed from Jann's discovery report:
> > lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() under
> > rcu_read_lock(). At that point, the VMA may be concurrently freed, and
> > it can be recycled by another process. vma_start_read() then
> > increments the vma->vm_refcnt (if it is in an acceptable range), and
> > if this succeeds, vma_start_read() can return a recycled VMA.
> >
> > In this scenario where the VMA has been recycled, lock_vma_under_rcu()
> > will then detect the mismatching ->vm_mm pointer and drop the VMA
> > through vma_end_read(), which calls vma_refcount_put().
> > vma_refcount_put() drops the refcount and then calls rcuwait_wake_up()
> > using a copy of vma->vm_mm. This is wrong: It implicitly assumes that
> > the caller is keeping the VMA's mm alive, but in this scenario the call=
er
> > has no relation to the VMA's mm, so the rcuwait_wake_up() can cause UAF=
.
> >
> > The diagram depicting the race:
> > T1         T2         T3
> > =3D=3D         =3D=3D         =3D=3D
> > lock_vma_under_rcu
> >   mas_walk
> >           <VMA gets removed from mm>
> >                       mmap
> >                         <the same VMA is reallocated>
> >   vma_start_read
> >     __refcount_inc_not_zero_limited_acquire
> >                       munmap
> >                         __vma_enter_locked
> >                           refcount_add_not_zero
> >   vma_end_read
> >     vma_refcount_put
> >       __refcount_dec_and_test
> >                           rcuwait_wait_event
> >                             <finish operation>
> >       rcuwait_wake_up [UAF]
> >
> > Note that rcuwait_wait_event() in T3 does not block because refcount
> > was already dropped by T1. At this point T3 can exit and free the mm
> > causing UAF in T1.
> > To avoid this we move vma->vm_mm verification into vma_start_read() and
> > grab vma->vm_mm to stabilize it before vma_refcount_put() operation.
> >
> > Fixes: 3104138517fc ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
> > Reported-by: Jann Horn <jannh@google.com>
> > Closes: https://lore.kernel.org/all/CAG48ez0-deFbVH=3DE3jbkWx=3DX3uVbd8=
nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: <stable@vger.kernel.org>
>
> This LGTM AFAICT, so:
>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!
I think I'll respin v3 to add a warning comment to vma_start_read(),
so will address your nits there.

>
> I'll fold a description of this check into the detailed impl notes I'm wr=
iting.
>
> > ---
> > Changes since v1 [1]
> > - Made a copy of vma->mm before using it in vma_start_read(),
> > per Vlastimil Babka
> >
> > Notes:
> > - Applies cleanly over mm-unstable.
> > - Should be applied to 6.15 and 6.16 but these branches do not
> > have lock_next_vma() function, so the change in lock_next_vma() should =
be
> > skipped when applying to those branches.
> >
> > [1] https://lore.kernel.org/all/20250728170950.2216966-1-surenb@google.=
com/
> >
> >  include/linux/mmap_lock.h | 23 +++++++++++++++++++++++
> >  mm/mmap_lock.c            | 10 +++-------
> >  2 files changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 1f4f44951abe..da34afa2f8ef 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -12,6 +12,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
> >  #include <linux/tracepoint-defs.h>
> >  #include <linux/types.h>
> >  #include <linux/cleanup.h>
> > +#include <linux/sched/mm.h>
> >
> >  #define MMAP_LOCK_INITIALIZER(name) \
> >       .mmap_lock =3D __RWSEM_INITIALIZER((name).mmap_lock),
> > @@ -183,6 +184,28 @@ static inline struct vm_area_struct *vma_start_rea=
d(struct mm_struct *mm,
> >       }
> >
> >       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > +
> > +     /*
> > +      * If vma got attached to another mm from under us, that mm is no=
t
> > +      * stable and can be freed in the narrow window after vma->vm_ref=
cnt
> > +      * is dropped and before rcuwait_wake_up(mm) is called. Grab it b=
efore
> > +      * releasing vma->vm_refcnt.
> > +      */
> > +     if (unlikely(vma->vm_mm !=3D mm)) {
> > +             /* Use a copy of vm_mm in case vma is freed after we drop=
 vm_refcnt */
> > +             struct mm_struct *other_mm =3D vma->vm_mm;
>
> NIT: Not sure if we should have a space before the comment below. But it =
doesn't
> matter... :)
>
> > +             /*
> > +              * __mmdrop() is a heavy operation and we don't need RCU
> > +              * protection here. Release RCU lock during these operati=
ons.
> > +              */
>
> NIT: Maybe worth saying 'we reinstate the RCU read lock as the caller exp=
ects it
> to be held when this functino returns even on error' or something like th=
is.
>
> > +             rcu_read_unlock();
> > +             mmgrab(other_mm);
> > +             vma_refcount_put(vma);
> > +             mmdrop(other_mm);
> > +             rcu_read_lock();
> > +             return NULL;
> > +     }
> > +
> >       /*
> >        * Overflow of vm_lock_seq/mm_lock_seq might produce false locked=
 result.
> >        * False unlocked result is impossible because we modify and chec=
k
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 729fb7d0dd59..aa3bc42ecde0 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -164,8 +164,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
> >        */
> >
> >       /* Check if the vma we locked is the right one. */
> > -     if (unlikely(vma->vm_mm !=3D mm ||
> > -                  address < vma->vm_start || address >=3D vma->vm_end)=
)
> > +     if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
> >               goto inval_end_read;
> >
> >       rcu_read_unlock();
> > @@ -236,11 +235,8 @@ struct vm_area_struct *lock_next_vma(struct mm_str=
uct *mm,
> >               goto fallback;
> >       }
> >
> > -     /*
> > -      * Verify the vma we locked belongs to the same address space and=
 it's
> > -      * not behind of the last search position.
> > -      */
> > -     if (unlikely(vma->vm_mm !=3D mm || from_addr >=3D vma->vm_end))
> > +     /* Verify the vma is not behind of the last search position. */
>
> NIT: 'behind of' should be 'behind', 'behind of' is weird sounding here
>
> > +     if (unlikely(from_addr >=3D vma->vm_end))
> >               goto fallback_unlock;
> >
> >       /*
> >
> > base-commit: c617a4dd7102e691fa0fb2bc4f6b369e37d7f509
> > --
> > 2.50.1.487.gc89ff58d15-goog
> >

