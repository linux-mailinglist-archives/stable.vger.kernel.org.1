Return-Path: <stable+bounces-27555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE62287A197
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 03:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD3A1F22598
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 02:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC13BA27;
	Wed, 13 Mar 2024 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxtLE6bO"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD298125C0
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710296548; cv=none; b=oBWwfHdLmi0SDaaCu+lffDyA0BDYpaJ6RzvEf67ysL4H8CnR4CnZGkDm49t0alKYqaVV+DgT+ST/cZ/xFzuMswd7sF8mKoQE+oaz2RFbEbKETbU3ul0Ie6Vhwpb88b/kTWwIj7+kl3WnBlcrgdwbr309qbSCu2JQY5z4t9SygVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710296548; c=relaxed/simple;
	bh=AkrU4EC8QiNo1TmQWVI75Brne6zt86jU7dwMw3KnUak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLOA8kLW+PGozl/5oSAU18Jd7A/6AzUejJDhjVoCFwXKZAI0rzSd0hH5OyzxHs+lgPTzYOeX9Jagxk3GcjFkXPWn7ArlVHJODFLLqmWnEzCrTq9oWNb29PFwqdycZ6LW46iXz1yczD4oqru6aCCkbWbmGQkPVYEdT6+sLqnkVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxtLE6bO; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690c821e088so3782436d6.0
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 19:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710296545; x=1710901345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zm7KTlg2XztzGKUYwxOz8ydvaIZ+iWJFSeIhbfCjRA=;
        b=JxtLE6bOQT7j24LwMijzX4IOGw6BpVwmNVc1NHvDX3PIJa+z7crgrbglkuhw1F63YM
         rpPei51Wo+3cJq5a9EkppdoddZgeVjayE/7iACS4UjwoYmtegpSCdhbokhzXvYQ8VMM6
         MWciKKqIFtlDNuRNiegrHhwRG290ySDTp11QPOnv+R3Vnb6WOtCdYgLLM8LJopFQ/7Rd
         rcK0QBme++H6is5pfy3xXFf8Spe+IN0yH3CTRN6MyuclBlaHuW7VqUV0Oz0adBYLTpgR
         MTaZ8HZekmsx13YWNprLsGPFpRcEjJEqYApG26aKnAZEUWNFi/7nJ8QXXnSbDmvZsAKK
         CXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710296545; x=1710901345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zm7KTlg2XztzGKUYwxOz8ydvaIZ+iWJFSeIhbfCjRA=;
        b=Wio83i3jSKZ8e/aoFP/iDqx1TvunzBI2fByh0+JuwTQVQ/rvW5qh0rys62C3Ab6dM6
         PAb+yI+RQfiGWX0b9kkt/zBZ8xJZFnvExpmK0hQJl/AUKMq6WYNG7KH31rKtQtl5dTCv
         /hyW6fzRDy3/B7RbJX9L9MWrv5Xlc4ldIjvZDhOlF7fQ9Y7GfFeocLScloJh064TASK/
         mO+LAsrxiGMN31VCOsP5bBRBDoEpdrBQSvdy9mgPPIzP1EltlaClovjzal8pU7TLN+/n
         ILXKhA3CI82dkK8p9Q4inq+je97/VEn+KXtXOi4VbewfpmN2ib9iiqHdB5hqpj8cyeLd
         x6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVrxYxtXLQAkWxysdDnQ/fhWVNJmOte/NvsC/y6ayCSnaTxIal/zjVdV7zeDusan+sGYUDoEwv5R641ZCKuI/zLMfApxGx2
X-Gm-Message-State: AOJu0Yy0m4Ln58Q/eS4FUyGkre6YxjNXruN9aisT8RQ4ihNj5rk9I0j/
	n09v6L7kUeyZhDbXDK3BAQPCXybwsYWYKKrFzPgVA3SsdCvQo2M6npN126yuiqE3QR5G9YGJ/FV
	sTNqJLf4u7zNRRSPBHCid4a2sYWw=
X-Google-Smtp-Source: AGHT+IGRwvfE1LQv/A5aE8860oiNVgY2jYqJZ6xX8ndl3d0ba0sI87aq2RQhhti4cdMl8ibjUrlozIWSUN4tLfj9hjI=
X-Received: by 2002:a0c:e84c:0:b0:690:f92e:79c9 with SMTP id
 l12-20020a0ce84c000000b00690f92e79c9mr2531410qvo.9.1710296545480; Tue, 12 Mar
 2024 19:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307031952.2123-1-laoar.shao@gmail.com> <20240307090618.50da28040e1263f8af39046f@linux-foundation.org>
 <CALOAHbAsyT9ms739DLZeAf88XsrxjJgm1D8wr+dKNFxROOQFFw@mail.gmail.com>
 <ZfC7PO0-3Kg88Wj3@google.com> <ZfDTK79iQNlax-h6@google.com>
In-Reply-To: <ZfDTK79iQNlax-h6@google.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 13 Mar 2024 10:21:49 +0800
Message-ID: <CALOAHbAMPEikjt2vxpWqsifKfYwcEMoF0BSXqpLPgtoJMHDmxQ@mail.gmail.com>
Subject: Re: [PATCH] mm: mglru: Fix soft lockup attributed to scanning folios
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 6:12=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Mar 12, 2024 at 02:29:48PM -0600, Yu Zhao wrote:
> > On Fri, Mar 08, 2024 at 04:57:08PM +0800, Yafang Shao wrote:
> > > On Fri, Mar 8, 2024 at 1:06=E2=80=AFAM Andrew Morton <akpm@linux-foun=
dation.org> wrote:
> > > >
> > > > On Thu,  7 Mar 2024 11:19:52 +0800 Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > > >
> > > > > After we enabled mglru on our 384C1536GB production servers, we
> > > > > encountered frequent soft lockups attributed to scanning folios.
> > > > >
> > > > > The soft lockup as follows,
> > > > >
> > > > > ...
> > > > >
> > > > > There were a total of 22 tasks waiting for this spinlock
> > > > > (RDI: ffff99d2b6ff9050):
> > > > >
> > > > >  crash> foreach RU bt | grep -B 8  queued_spin_lock_slowpath |  g=
rep "RDI: ffff99d2b6ff9050" | wc -l
> > > > >  22
> > > >
> > > > If we're holding the lock for this long then there's a possibility =
of
> > > > getting hit by the NMI watchdog also.
> > >
> > > The NMI watchdog is disabled as these servers are KVM guest.
> > >
> > >     kernel.nmi_watchdog =3D 0
> > >     kernel.soft_watchdog =3D 1
> > >
> > > >
> > > > > Additionally, two other threads were also engaged in scanning fol=
ios, one
> > > > > with 19 waiters and the other with 15 waiters.
> > > > >
> > > > > To address this issue under heavy reclaim conditions, we introduc=
ed a
> > > > > hotfix version of the fix, incorporating cond_resched() in scan_f=
olios().
> > > > > Following the application of this hotfix to our servers, the soft=
 lockup
> > > > > issue ceased.
> > > > >
> > > > > ...
> > > > >
> > > > > --- a/mm/vmscan.c
> > > > > +++ b/mm/vmscan.c
> > > > > @@ -4367,6 +4367,10 @@ static int scan_folios(struct lruvec *lruv=
ec, struct scan_control *sc,
> > > > >
> > > > >                       if (!--remaining || max(isolated, skipped_z=
one) >=3D MIN_LRU_BATCH)
> > > > >                               break;
> > > > > +
> > > > > +                     spin_unlock_irq(&lruvec->lru_lock);
> > > > > +                     cond_resched();
> > > > > +                     spin_lock_irq(&lruvec->lru_lock);
> > > > >               }
> > > >
> > > > Presumably wrapping this with `if (need_resched())' will save some =
work.
> > >
> > > good suggestion.
> > >
> > > >
> > > > This lock is held for a reason.  I'd like to see an analysis of why
> > > > this change is safe.
> > >
> > > I believe the key point here is whether we can reduce the scope of
> > > this lock from:
> > >
> > >   evict_folios
> > >       spin_lock_irq(&lruvec->lru_lock);
> > >       scanned =3D isolate_folios(lruvec, sc, swappiness, &type, &list=
);
> > >       scanned +=3D try_to_inc_min_seq(lruvec, swappiness);
> > >       if (get_nr_gens(lruvec, !swappiness) =3D=3D MIN_NR_GENS)
> > >           scanned =3D 0;
> > >       spin_unlock_irq(&lruvec->lru_lock);
> > >
> > > to:
> > >
> > >   evict_folios
> > >       spin_lock_irq(&lruvec->lru_lock);
> > >       scanned =3D isolate_folios(lruvec, sc, swappiness, &type, &list=
);
> > >       spin_unlock_irq(&lruvec->lru_lock);
> > >
> > >       spin_lock_irq(&lruvec->lru_lock);
> > >       scanned +=3D try_to_inc_min_seq(lruvec, swappiness);
> > >       if (get_nr_gens(lruvec, !swappiness) =3D=3D MIN_NR_GENS)
> > >           scanned =3D 0;
> > >       spin_unlock_irq(&lruvec->lru_lock);
> > >
> > > In isolate_folios(), it merely utilizes the min_seq to retrieve the
> > > generation without modifying it. If multiple tasks are running
> > > evict_folios() concurrently, it seems inconsequential whether min_seq
> > > is incremented by one task or another. I'd appreciate Yu's
> > > confirmation on this matter.
> >
> > Hi Yafang,
> >
> > Thanks for the patch!
> >
> > Yes, your second analysis is correct -- we can't just drop the lock
> > as the original patch does because min_seq can be updated in the mean
> > time. If this happens, the gen value becomes invalid, since it's based
> > on the expired min_seq:
> >
> >   sort_folio()
> >   {
> >     ..
> >     gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
> >     ..
> >   }
> >
> > The following might be a better approach (untested):
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 4255619a1a31..6fe53cfa8ef8 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4365,7 +4365,8 @@ static int scan_folios(struct lruvec *lruvec, str=
uct scan_control *sc,
> >                               skipped_zone +=3D delta;
> >                       }
> >
> > -                     if (!--remaining || max(isolated, skipped_zone) >=
=3D MIN_LRU_BATCH)
> > +                     if (!--remaining || max(isolated, skipped_zone) >=
=3D MIN_LRU_BATCH ||
> > +                         spin_is_contended(&lruvec->lru_lock))
> >                               break;
> >               }
> >
> > @@ -4375,7 +4376,8 @@ static int scan_folios(struct lruvec *lruvec, str=
uct scan_control *sc,
> >                       skipped +=3D skipped_zone;
> >               }
> >
> > -             if (!remaining || isolated >=3D MIN_LRU_BATCH)
> > +             if (!remaining || isolated >=3D MIN_LRU_BATCH ||
> > +                 (scanned && spin_is_contended(&lruvec->lru_lock)))
> >                       break;
> >       }
>
> A better way might be:
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4255619a1a31..ac59f064c4e1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4367,6 +4367,11 @@ static int scan_folios(struct lruvec *lruvec, stru=
ct scan_control *sc,
>
>                         if (!--remaining || max(isolated, skipped_zone) >=
=3D MIN_LRU_BATCH)
>                                 break;
> +
> +                       if (need_resched() || spin_is_contended(&lruvec->=
lru_lock)) {
> +                               remaining =3D 0;
> +                               break;
> +                       }
>                 }
>
>                 if (skipped_zone) {

It is better. Thanks for your suggestion.
I will verify it on our production servers, which may take several days.

--=20
Regards
Yafang

