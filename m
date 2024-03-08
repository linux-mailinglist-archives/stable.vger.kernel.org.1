Return-Path: <stable+bounces-27138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D49876070
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 09:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966612833EC
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E252F90;
	Fri,  8 Mar 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb5XH+of"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D502D056
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888267; cv=none; b=Rrtvse3tGg9soq1RwQrasy+SE39MYl6LgBZCgJKN6cCABqmTlZ5y+xGWFBx1EzXCHSxjDnY7TmeuWO5qy3XQJTLVK2rqvQPcr3Oj2XTLUPaysA+ZvwAJQx0lgA4PVjo3+RkKcrugEh7nFaSYopJ8utbeK+y3WCBAt9NGr30haqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888267; c=relaxed/simple;
	bh=s/B/lI37MmVIK+eCD5q2S/+KQd67T07rkaNUMjkXjd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3v8B9KTH8N7aXVIgkqtc4wpSaZGYQvVodrRCPPql1Me4CkC28VS1l/Ku94xj1SgmeFwF65B2wJz+tcmHvJG6XTDOiRZkDPyk9ykZaVU1DFqxY0jSv+IVaDfX7X3QpGLG+3K1Lvzmwr0lI1H3YekkroFLQdkQ+PSJYWFXRZZqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb5XH+of; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68fb3a3f1c5so10149576d6.3
        for <stable@vger.kernel.org>; Fri, 08 Mar 2024 00:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709888265; x=1710493065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkJjoKDdSZiJb0nnseQFMkR3M153lSP9yMaCF3TNUdg=;
        b=jb5XH+of76EgFAB4nU7Kc4pUbDyYst1z+4HzOYXquZICDnuDQJJHw7sN7spTuaX232
         oZEBktdwH5VYiIMJLGEXedvY1bp8/N7ztajLNYObD4eMIXamV9QaAZZGEOro+TsUbtZs
         +ks+9Uj0JzqINVYkbKi2Ku7mm2ti9mEQE9yPsieeNsJieEesKpQRRyXUjVx+vsGRA43O
         Dcrvrcm9ihMRnCJMfu+ShIWasSx9S7DqO+NxRQp3V2Qfw9dSkJRIMUG6yZh0P2MEj8su
         uejO0Sftar6LHuIdF/tcvRmHaaxvgKZugTuk54UinAdGNydeAGXkmYPiM9fHdlcjc4+T
         j4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888265; x=1710493065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkJjoKDdSZiJb0nnseQFMkR3M153lSP9yMaCF3TNUdg=;
        b=El6MCwDFV+tUsW+sma+tIvnznHegvcnA9D4QaIOvCDvVWJ5R+qcIf31neFJIlCAp+r
         nhiESlUzOgjdXAXNXiSKD/OGpz/H1TTV0s/L5dJINnqYJLQv+TwwbTefG94urhbbkrPQ
         od+8bHpx4HaGTSPAW2oqqqeJrdkmLsg5/pMYSTTZPly3VvdS3zWTiliwB0wkva9va44R
         cMUSs0q9uxFA06lztJDm+LApATcHqNtAiq1uJX76CvrOL5c1JqRIbv+6ECGDF4SIY1rS
         PFg84LOIATGJynOqrrhyWowMnlYeeKdeD+SaGl9xsbVcq5fSqM+ySLoIiVADyYaKv3Yf
         kf6g==
X-Forwarded-Encrypted: i=1; AJvYcCWuSJhiCAuwYUMGwXM/j/78zELYRip1kjy6iMy3L631Kxow5KPUExf0uwfyjXHCIOH9wjgh8ezmkHujnKB7OP6+/ZOXfmwQ
X-Gm-Message-State: AOJu0YwLwCeJaJW5EmodkvPMZEi+fHS9zWyhiKAu1OJkPhqUj5cQK98H
	XHwr3sf2miz7eGMSE9/ve2Q3UtcNtmgLcnFqEgMCcSxzk1k41rXgiVA9WMGqTpWa6cD00la4wdc
	6y+Aa9VgCZ/E9/Ibt9GW2nsCM5aU=
X-Google-Smtp-Source: AGHT+IG4NixuhtB4eeA8srzLlmP0hTjQOgMWIcgjgTzndP5KGqJwcev3c8JBOK7Yu5SDvuTvecfDgMwcsPrT/Sc8blU=
X-Received: by 2002:a0c:cdc6:0:b0:68f:5926:59ea with SMTP id
 a6-20020a0ccdc6000000b0068f592659eamr11097670qvn.28.1709888264842; Fri, 08
 Mar 2024 00:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307031952.2123-1-laoar.shao@gmail.com> <20240307090618.50da28040e1263f8af39046f@linux-foundation.org>
In-Reply-To: <20240307090618.50da28040e1263f8af39046f@linux-foundation.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 8 Mar 2024 16:57:08 +0800
Message-ID: <CALOAHbAsyT9ms739DLZeAf88XsrxjJgm1D8wr+dKNFxROOQFFw@mail.gmail.com>
Subject: Re: [PATCH] mm: mglru: Fix soft lockup attributed to scanning folios
To: Andrew Morton <akpm@linux-foundation.org>
Cc: yuzhao@google.com, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 1:06=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu,  7 Mar 2024 11:19:52 +0800 Yafang Shao <laoar.shao@gmail.com> wro=
te:
>
> > After we enabled mglru on our 384C1536GB production servers, we
> > encountered frequent soft lockups attributed to scanning folios.
> >
> > The soft lockup as follows,
> >
> > ...
> >
> > There were a total of 22 tasks waiting for this spinlock
> > (RDI: ffff99d2b6ff9050):
> >
> >  crash> foreach RU bt | grep -B 8  queued_spin_lock_slowpath |  grep "R=
DI: ffff99d2b6ff9050" | wc -l
> >  22
>
> If we're holding the lock for this long then there's a possibility of
> getting hit by the NMI watchdog also.

The NMI watchdog is disabled as these servers are KVM guest.

    kernel.nmi_watchdog =3D 0
    kernel.soft_watchdog =3D 1

>
> > Additionally, two other threads were also engaged in scanning folios, o=
ne
> > with 19 waiters and the other with 15 waiters.
> >
> > To address this issue under heavy reclaim conditions, we introduced a
> > hotfix version of the fix, incorporating cond_resched() in scan_folios(=
).
> > Following the application of this hotfix to our servers, the soft locku=
p
> > issue ceased.
> >
> > ...
> >
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4367,6 +4367,10 @@ static int scan_folios(struct lruvec *lruvec, st=
ruct scan_control *sc,
> >
> >                       if (!--remaining || max(isolated, skipped_zone) >=
=3D MIN_LRU_BATCH)
> >                               break;
> > +
> > +                     spin_unlock_irq(&lruvec->lru_lock);
> > +                     cond_resched();
> > +                     spin_lock_irq(&lruvec->lru_lock);
> >               }
>
> Presumably wrapping this with `if (need_resched())' will save some work.

good suggestion.

>
> This lock is held for a reason.  I'd like to see an analysis of why
> this change is safe.

I believe the key point here is whether we can reduce the scope of
this lock from:

  evict_folios
      spin_lock_irq(&lruvec->lru_lock);
      scanned =3D isolate_folios(lruvec, sc, swappiness, &type, &list);
      scanned +=3D try_to_inc_min_seq(lruvec, swappiness);
      if (get_nr_gens(lruvec, !swappiness) =3D=3D MIN_NR_GENS)
          scanned =3D 0;
      spin_unlock_irq(&lruvec->lru_lock);

to:

  evict_folios
      spin_lock_irq(&lruvec->lru_lock);
      scanned =3D isolate_folios(lruvec, sc, swappiness, &type, &list);
      spin_unlock_irq(&lruvec->lru_lock);

      spin_lock_irq(&lruvec->lru_lock);
      scanned +=3D try_to_inc_min_seq(lruvec, swappiness);
      if (get_nr_gens(lruvec, !swappiness) =3D=3D MIN_NR_GENS)
          scanned =3D 0;
      spin_unlock_irq(&lruvec->lru_lock);

In isolate_folios(), it merely utilizes the min_seq to retrieve the
generation without modifying it. If multiple tasks are running
evict_folios() concurrently, it seems inconsequential whether min_seq
is incremented by one task or another. I'd appreciate Yu's
confirmation on this matter.

--=20
Regards
Yafang

