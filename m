Return-Path: <stable+bounces-165070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404FDB14F3B
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673BD18A2217
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430B149C4D;
	Tue, 29 Jul 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwIKaa9Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97491881E
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799485; cv=none; b=pddukpWVW13Oxqanvb7783xw26qauqQToaFjEbuBExXO0lAkxqkmsqzyCIqqCt6Y/QnLoEF6DSsSAj97RH7oHSltoAsw3yzVlZqop4lx3RsvKnAme66vGb5rbbn6IEO1qY1VxceLlipt615KsRNZwJmRl4g5YmdBOPv/JYjkoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799485; c=relaxed/simple;
	bh=FqBa7kotZdks/Xw2F/MJy6jLuFFQ6cH957upyZYhB90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+aBTDWstVgQEDNAiV6brysIu4HZQ2ih9XpkxicwPUs+FkD9V6i4AAs4/tXzfeEw+lauxs99JwRvotKBjelnbc17W6shlwRvLgSzNapij/MjQaQjTUGalnI/JggLXEdML8QOvIH9Tchs/CaW9uiTkyB/yiN2A0CwiLKJFR4+F4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwIKaa9Y; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab3855fca3so318201cf.1
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753799482; x=1754404282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ElbbAul9DmjYMfnPC5TQkAxMKcYjjk3KRBzaYjpxjg=;
        b=cwIKaa9YL0tN40NBriyJTDXP82xqwNpZeQur/Zixf75Spu+ueS97KpmdTHhd4H/Dvr
         9WbJyW3Fs3QCIDHt6AZLYR3e8geqjtu0wn411zKK1ssqzd5NzlKI3eSvzpq+cLF+QoIV
         Py3M0qI54oYhnRdM0zLoZC2Dv/nQsicJKDHokW8NXBHOuEQrXW0dnevcwuUwuGStkH5K
         z0sn2zGau1Pbq/t5TRGjQJtfwnoOWaINbPCzy4VpkfHkyHQ4xQkxX1vQner7E7iwrtI2
         pvBjBZVL/srLCLXjMEaAh/bhTnYMAy6hDpCVMpXNYZPCBqthfZ2q9qlu8VbLg+vywQml
         hZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753799482; x=1754404282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ElbbAul9DmjYMfnPC5TQkAxMKcYjjk3KRBzaYjpxjg=;
        b=uLPHEj3ab6x99sbCHXl6LNVcTTSVV4t+ern+ro0kN6v4nZC19H7oVa9wGJfEAOf/Gp
         hfDJViVCTdgmvzyL4fx9mwgvFRXfDGoGKz4T4us9Bq47oPlOfq9S4zpI8dglazq1shao
         eczzdTd1iomzml40maI6IBmhJl11r9VfrqS2JlndUuAKuw2/G1+b+8qrzdlaUT0+JKYt
         Jzlp7iDyGJuR9Zby9fezWvKeJGVhk+rJJWBW5VNZhsQRSr8yizW5FFdelxT/fTyO7GfK
         X0qKVvnp/3nUtQFhX3Z3rNdPYPOnILs79H+4gDEjV5SlmaArbYOUD0HF07AP7Uc1+HNj
         968Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2jOIP7DOHM3qZbuI6Y4+IM1crgY+2AuvaeEDH8lGD8jdUunz8YiVFeTSZo6jq2V1MQkSqxsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynwv9dw51nlAPTp/wJxCuDam/dmTULZk5HKve85P/EE8Fzhj37
	JBHZaoHFw6X/6ZiNtu/SYMn3fKkv0bpMecSds9cDvirOUTAbdpGf1l7F5PmoQnSB01hWNyktB7/
	7OAZNOOMPpbfk78b0LGkn9/pUKfNfapo64LJHxOB1
X-Gm-Gg: ASbGncvRz8oCW6oaDaL9pF+/iGeuFB3SXl5OKRvbnNthw9R8Ezrqz70NJ7kSQe6klQj
	X8FYCRIsW7C9Saj6G2sDQqVPGnuzA07tIy7S43o/XFt8uw76Mx96pSrgYZJbffTaIFYtYTc5QxI
	HsOX3fAKffmDU5382GaT20c+tZz9YTEPC2enl1ak2bWFoEvfbAPOq5jVHNNfJP/GpZYsGnU1sUs
	FXGjZOuMHkRaaNtXYSY7UIXhtLTZ67u+eenEw==
X-Google-Smtp-Source: AGHT+IGdl6AXgbdWoLsOYvwIWq5+uqEWUkN6UVFuEEGPrB/FwqSld5ISLVkEnPjv1C4r9M89ETi4WKoVgF6yNVc3La0=
X-Received: by 2002:ac8:580b:0:b0:4a8:ea8:67e with SMTP id d75a77b69052e-4aecda096e6mr5199861cf.2.1753799481979;
 Tue, 29 Jul 2025 07:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728175355.2282375-1-surenb@google.com> <197389ce-9f42-4d6a-91c4-fce116e988b4@suse.cz>
 <CAJuCfpFzxCayf083d35dS7Py0AK-CSr3H=_mymP9yXcyWzOqPQ@mail.gmail.com> <717f1f43-3ec0-41a7-b0a9-05383a4325d4@suse.cz>
In-Reply-To: <717f1f43-3ec0-41a7-b0a9-05383a4325d4@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Jul 2025 07:31:10 -0700
X-Gm-Features: Ac12FXz_KOV-YfOYg-xXhwzGmtvp7EhVOk939edJ822ZJfzo6Pfs3_KFmp6ytRc
Message-ID: <CAJuCfpEHCt0pczKG_W8X-e+Mi9yFMRpTeQRRS31Xq4fNfaFQ5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 5:03=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/29/25 00:53, Suren Baghdasaryan wrote:
> > On Mon, Jul 28, 2025 at 10:04=E2=80=AFPM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> >>
> >> As for further steps, considered replying to [1] but maybe it's better=
 here.
> >>
> >> As for a KISS fix including stable, great. Seems a nice improvement to
> >> actually handle "vma->vm_mm !=3D mm" in vma_start_read() like this - g=
ood idea!
> >>
> >> Less great is that there's now a subtle assumption that some (but not =
all!)
> >> cases where vma_start_read() returns NULL imply that we dropped the rc=
u
> >> lock. And it doesn't matter as the callers abort or fallback to mmap s=
em
> >> anyway in that case. Hopefully we can improve that a bit.
> >>
> >> The idea of moving rcu lock and mas walk inside vma_start_read() is in=
deed
> >> busted with lock_next_vma(). The iterator difference could be perhaps =
solved
> >> by having lock_vma_under_rcu() set up its own one (instead of MA_STATE=
) in a
> >> way that vma_next() would do the right thing for it. However there wou=
ld
> >> still be the difference that lock_next_vma() expects we are already un=
der
> >> rcu lock, and lock_vma_under_rcu() doesn't.
> >>
> >> So what we can perhaps do instead is move vma_start_read() to mm/mmap_=
lock.c
> >> (no other users so why expose it in a header for potential misuse). An=
d then
> >> indeed just make it drop rcu lock completely (and not reacquire) any t=
ime
> >> it's returning NULL, document that and adjust callers to that. I think=
 it's
> >> less subtle than dropping and reacquring, and should simplify the erro=
r
> >> handling in the callers a bit.
> >
> > Thanks for the suggestion. That was actually exactly one of the
> > options I was considering but I thought this dropping RCU schema would
> > still be uglier than dropping and reacquiring the RCU lock. If you
> > think otherwise I can make the change as you suggested for mm-unstable
> > and keep this original change for stable only. Should I do that?
>
> If we decide anything, I would do it as a cleanup on top of the fix that
> will now go to mainline and then stable. We don't want to deviate for sta=
ble
> unnecessarily (removing an extraneous hunk in stable backport is fine).

Good point. I'll do the refactoring on top of this fix and that one
does not need to go into stable branch.

>
> As for which case is uglier, I don't know really. Dropping and reacquirin=
g
> rcy lock in very rare cases, leading to even rarer situations where it wo=
uld
> cause an issue, seems more dangerous to me than just dropping everytime w=
e
> return NULL for any of the reasons, which is hopefully less rare and an
> error such as caller trying to drop rcu lock again will blow up immediate=
ly.
> Maybe others have opinions...

Yeah, you are probably right. It would be more explicit that the VMA
can't be used after a failed vma_start_read() if vma_start_read() were
to always drop RCU on exit. Either way I think I should add a big fat
warning to vma_start_read() comment that the VMA passed to
vma_start_read() can't be used if this function fails to lock it. I'll
post a v3 with that comment added and Lorenzo's nits addressed, then
I'll prepare a refactoring patchset for mm-unstable to drop RCU upon
vma_start_read() exit.

>
> >>
> >> [1]
> >> https://lore.kernel.org/all/CAJuCfpEMhGe_eZuFm__4CDstM9%3DOG2kTUTziNL-=
f%3DM3BYQor2A@mail.gmail.com/
> >>
> >> > ---
> >> > Changes since v1 [1]
> >> > - Made a copy of vma->mm before using it in vma_start_read(),
> >> > per Vlastimil Babka
> >> >
> >> > Notes:
> >> > - Applies cleanly over mm-unstable.
> >> > - Should be applied to 6.15 and 6.16 but these branches do not
> >> > have lock_next_vma() function, so the change in lock_next_vma() shou=
ld be
> >> > skipped when applying to those branches.
> >> >
> >> > [1] https://lore.kernel.org/all/20250728170950.2216966-1-surenb@goog=
le.com/
> >> >
> >> >  include/linux/mmap_lock.h | 23 +++++++++++++++++++++++
> >> >  mm/mmap_lock.c            | 10 +++-------
> >> >  2 files changed, 26 insertions(+), 7 deletions(-)
> >> >
> >> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> >> > index 1f4f44951abe..da34afa2f8ef 100644
> >> > --- a/include/linux/mmap_lock.h
> >> > +++ b/include/linux/mmap_lock.h
> >> > @@ -12,6 +12,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
> >> >  #include <linux/tracepoint-defs.h>
> >> >  #include <linux/types.h>
> >> >  #include <linux/cleanup.h>
> >> > +#include <linux/sched/mm.h>
> >> >
> >> >  #define MMAP_LOCK_INITIALIZER(name) \
> >> >       .mmap_lock =3D __RWSEM_INITIALIZER((name).mmap_lock),
> >> > @@ -183,6 +184,28 @@ static inline struct vm_area_struct *vma_start_=
read(struct mm_struct *mm,
> >> >       }
> >> >
> >> >       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> >> > +
> >> > +     /*
> >> > +      * If vma got attached to another mm from under us, that mm is=
 not
> >> > +      * stable and can be freed in the narrow window after vma->vm_=
refcnt
> >> > +      * is dropped and before rcuwait_wake_up(mm) is called. Grab i=
t before
> >> > +      * releasing vma->vm_refcnt.
> >> > +      */
> >> > +     if (unlikely(vma->vm_mm !=3D mm)) {
> >> > +             /* Use a copy of vm_mm in case vma is freed after we d=
rop vm_refcnt */
> >> > +             struct mm_struct *other_mm =3D vma->vm_mm;
> >> > +             /*
> >> > +              * __mmdrop() is a heavy operation and we don't need R=
CU
> >> > +              * protection here. Release RCU lock during these oper=
ations.
> >> > +              */
> >> > +             rcu_read_unlock();
> >> > +             mmgrab(other_mm);
> >> > +             vma_refcount_put(vma);
> >> > +             mmdrop(other_mm);
> >> > +             rcu_read_lock();
> >> > +             return NULL;
> >> > +     }
> >> > +
> >> >       /*
> >> >        * Overflow of vm_lock_seq/mm_lock_seq might produce false loc=
ked result.
> >> >        * False unlocked result is impossible because we modify and c=
heck
> >> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> >> > index 729fb7d0dd59..aa3bc42ecde0 100644
> >> > --- a/mm/mmap_lock.c
> >> > +++ b/mm/mmap_lock.c
> >> > @@ -164,8 +164,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct=
 mm_struct *mm,
> >> >        */
> >> >
> >> >       /* Check if the vma we locked is the right one. */
> >> > -     if (unlikely(vma->vm_mm !=3D mm ||
> >> > -                  address < vma->vm_start || address >=3D vma->vm_e=
nd))
> >> > +     if (unlikely(address < vma->vm_start || address >=3D vma->vm_e=
nd))
> >> >               goto inval_end_read;
> >> >
> >> >       rcu_read_unlock();
> >> > @@ -236,11 +235,8 @@ struct vm_area_struct *lock_next_vma(struct mm_=
struct *mm,
> >> >               goto fallback;
> >> >       }
> >> >
> >> > -     /*
> >> > -      * Verify the vma we locked belongs to the same address space =
and it's
> >> > -      * not behind of the last search position.
> >> > -      */
> >> > -     if (unlikely(vma->vm_mm !=3D mm || from_addr >=3D vma->vm_end)=
)
> >> > +     /* Verify the vma is not behind of the last search position. *=
/
> >> > +     if (unlikely(from_addr >=3D vma->vm_end))
> >> >               goto fallback_unlock;
> >> >
> >> >       /*
> >> >
> >> > base-commit: c617a4dd7102e691fa0fb2bc4f6b369e37d7f509
> >>
>

