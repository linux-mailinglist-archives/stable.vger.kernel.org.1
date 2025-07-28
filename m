Return-Path: <stable+bounces-165021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8060B14483
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 00:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9A8164E80
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 22:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6F238C2B;
	Mon, 28 Jul 2025 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpwvguH5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887F2E3708
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753743237; cv=none; b=LYK4QiyNfFEW3HknvjPP6vLgaL2CUHj0VthA5/R+3bV3tUfy+xgPr9MWSlRqyXaprcpodx/vl33eubbNly5luaqdfgYywJTNT22IwmO7Y2Xm/qTJrOAMcDsbPVyvdWM7+XwU6Re4CGuOrQse/qG3kLqIZReUYZokifV70YY09sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753743237; c=relaxed/simple;
	bh=YhCqEiOEnvrAEeYIVHZlET6clIv1cNi6eIqYJBi9dMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kp0/XTo3xnHnOQqnef8/O/FONyZoSloYm79EHKqH4cDfr7vH92Xau8vUMASveWxDo75WmYF4Y2KOcNdDMp3S1RTO+93ctQ+tCGZWPZxOAKNRL7ktYBkhoNjOnrta82SrZaYCzaDEHtPuk+SYv0kic+uZ/JzF0ln7I1+HsqlgfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PpwvguH5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab3855fca3so68751cf.1
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753743234; x=1754348034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4Qt12vqG6j3Vgncu41uP3H99WwAJYr2jwWzpmpk2jg=;
        b=PpwvguH5zfVpWeWJCh6/TE6xKp5LOYye00elYbUVInlq9ciQK8f56c0NYxIStgtbVE
         PgDzOJS1kVbxpMuCSyauQpeNGeFobDzMhrnN1zrM4MttXDLspv/IWxHyZ98LQM0YG0xF
         eXNVdGqS+iZWCvu8kQ6aDOTuVfNbIhankBYbjZP/E/CuqM1N10fZITwdYiVXwrwmzBNB
         t/ZRpbE0PuL5rkEfpUIW2cG14s/7Re54soHTF2mR8rfSdp2+Df4uItw8pnCucRW3jOsm
         bjEKTiLeQkq/JVSAG735iThx0c10kvfzkh1ywZKeHJ3KPWeDnh6tn2HsHfFTgsd7QP8W
         4x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753743234; x=1754348034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4Qt12vqG6j3Vgncu41uP3H99WwAJYr2jwWzpmpk2jg=;
        b=EFNc3QxO1eKo1nJU9VyT/hTZrBTfyzsAXGJ5nAQ+lh6LV9xDoZ21CDN1QLJ2jwfB61
         8DxCXgOLwbAj5RRFDdOo95AfqMIIgEgZLXRQxgVgHTGZIOL4FllHpIC0zJNndzVp1OXS
         G9IGpQVD8n25afqI/N0MwwqEQ7Xq8UNYW17UUIuAki6ru6hd1ArTe5cFhKi0RO6ObDKR
         3aowuOtHGN0ZZsozCHKLRi7TFtzvhRoRNkGAogLv74716SabvNe8IL1geGjOPwbwO64S
         njGEMsa/O+Cq7mLyPQ9esEKmITJY0tNMpVccvviy6w8YZNp50ArJNzYGilUBy2v+v/cw
         F/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQsY+Z+0BuX7NBb+mx6tUvXkk7D2QiYnP4DG38vmHCxkd4OFbCnoPihmKccWfmaqByM0z8S6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3cbz0BvpdDrV7GyOKjTD3/sygD+dYJF+jBsIIlf1C9RpdzzF0
	m74/xGHavbxEJKr6hXjwBjxysQESD1DRNL6ynE1WeD3EmuA6bO4EpzF2ZjL0XyP2B24k7iD5nu6
	j+MQUnimE5Kp1cdF0a+YuPhWg9GYIBqMlxn0ddLHc
X-Gm-Gg: ASbGncvAtTsH5eW4jK+k52j4M97OSAZE9DH3L3gTh9j7XGT0XkWvMuDdSWEE66nJoWx
	4kvEtLu+9kio/VFTMhWLK1jhs+OKbTg8w29plwU+bnn096lftQMbbW5trKyVZGuhYmlUANkM9h0
	dlgBJTMIBkEicOZU9glilg6V9SPebKoKCbDe+yYzh4hvPwM1TF60xHKr5WlGTrUUxCIWeTIvQ9e
	SdgdtPthxS8QlzaSxvHgdh987tRq8rGzIbRu/8elQITmg==
X-Google-Smtp-Source: AGHT+IGATSooD8GgEjASGSXd3OgOeRWrGHiPgkXjO2g/J75z5wCxzzWlwo3yh3PbhmnWOhAg0GHBVwvm9kJx3eRxq08=
X-Received: by 2002:ac8:580b:0:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4aecda09537mr1715651cf.6.1753743232125; Mon, 28 Jul 2025
 15:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728175355.2282375-1-surenb@google.com> <197389ce-9f42-4d6a-91c4-fce116e988b4@suse.cz>
In-Reply-To: <197389ce-9f42-4d6a-91c4-fce116e988b4@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Jul 2025 22:53:41 +0000
X-Gm-Features: Ac12FXzf7uyrUFgvW6_WolevPBj5eXWmthBTkEGcLn2Bxpz2kQtaKNbJdU9mnS4
Message-ID: <CAJuCfpFzxCayf083d35dS7Py0AK-CSr3H=_mymP9yXcyWzOqPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:04=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/28/25 19:53, Suren Baghdasaryan wrote:
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
> As for further steps, considered replying to [1] but maybe it's better he=
re.
>
> As for a KISS fix including stable, great. Seems a nice improvement to
> actually handle "vma->vm_mm !=3D mm" in vma_start_read() like this - good=
 idea!
>
> Less great is that there's now a subtle assumption that some (but not all=
!)
> cases where vma_start_read() returns NULL imply that we dropped the rcu
> lock. And it doesn't matter as the callers abort or fallback to mmap sem
> anyway in that case. Hopefully we can improve that a bit.
>
> The idea of moving rcu lock and mas walk inside vma_start_read() is indee=
d
> busted with lock_next_vma(). The iterator difference could be perhaps sol=
ved
> by having lock_vma_under_rcu() set up its own one (instead of MA_STATE) i=
n a
> way that vma_next() would do the right thing for it. However there would
> still be the difference that lock_next_vma() expects we are already under
> rcu lock, and lock_vma_under_rcu() doesn't.
>
> So what we can perhaps do instead is move vma_start_read() to mm/mmap_loc=
k.c
> (no other users so why expose it in a header for potential misuse). And t=
hen
> indeed just make it drop rcu lock completely (and not reacquire) any time
> it's returning NULL, document that and adjust callers to that. I think it=
's
> less subtle than dropping and reacquring, and should simplify the error
> handling in the callers a bit.

Thanks for the suggestion. That was actually exactly one of the
options I was considering but I thought this dropping RCU schema would
still be uglier than dropping and reacquiring the RCU lock. If you
think otherwise I can make the change as you suggested for mm-unstable
and keep this original change for stable only. Should I do that?

>
> [1]
> https://lore.kernel.org/all/CAJuCfpEMhGe_eZuFm__4CDstM9%3DOG2kTUTziNL-f%3=
DM3BYQor2A@mail.gmail.com/
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
> > +             /*
> > +              * __mmdrop() is a heavy operation and we don't need RCU
> > +              * protection here. Release RCU lock during these operati=
ons.
> > +              */
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
> > +     if (unlikely(from_addr >=3D vma->vm_end))
> >               goto fallback_unlock;
> >
> >       /*
> >
> > base-commit: c617a4dd7102e691fa0fb2bc4f6b369e37d7f509
>

