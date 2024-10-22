Return-Path: <stable+bounces-87701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1942F9A9E56
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB71280FC8
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5B193427;
	Tue, 22 Oct 2024 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7q5I0iX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674212D75C;
	Tue, 22 Oct 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588888; cv=none; b=OnyX1SfCp6xsjoCalM4vvxJ+vY/pf0yahDm9pTONdTSAo6hfcsCUohbS/LZDoEWHwtLRCLUUbqha8MbtA5Pum9eITwp1uwz7pBNmzZVj0TFqlhimBJoxAsHldYVgKLB8pfmxKOsRgCzXOCgay7sme9cI8f5BuiAkpptn8gi7Sck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588888; c=relaxed/simple;
	bh=BDpZ/RdCY6Cv1FhdXCDoj5Fqvl2hcsJf2HPMstMIOEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoLvVwCf4JkHqQyZIqiYL7geESRa6uCWok5r4xI1jilnGG1gkjl3E6oTNVlUgp9CflbQYRXX8nQuNSWzwa7pEGLwOoB9G3K1dF/R5JNkfafo320V25Ntre76Zsbk0Zb/FLnoBs6KF1MSfUGwL6DxcUpdIZRzfVUmakBgSTSW/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7q5I0iX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso83507321fa.3;
        Tue, 22 Oct 2024 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729588885; x=1730193685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MnIFIX+6xraPlAS1iyzSKgBzODyPlZ10mxzOTitsig=;
        b=A7q5I0iXc9M9k8EtuwAus9lNyMyaJ2slzLH7W29FEr9xUpKxxCcGo+A7cAXKPspzIy
         b1C1fBtj/bSwgn5jQgMkGebeKb0iq+ng6xbziWnEyFUIzyQHoG4nhnC4XtlIlSuR7eZU
         Birg7i/w1ez0DSfou/M0odDetxKGWCUKke1g+A5noSpb8P1yoxmky5ozR3t+WO0+YJK6
         SELIqCtFVP1iHxaVEUKy2KSV8BBW3flfnGdsT4il9RUaULnM//F5k6NEC3wBezi/0jES
         yEQghr7YYOLx78+hkVXzS6FXf6EYR5vg4HPnSkfEVlWw5R2T7llQ2ZruYtj3PmuXmsDm
         bt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588885; x=1730193685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MnIFIX+6xraPlAS1iyzSKgBzODyPlZ10mxzOTitsig=;
        b=tmEdXwQOEtlFSSXUP57h/r5LsO9Lzz7jknPy6/HjoKN8C0uh3yfytXuGYUHaoMUkf/
         sJo1xKK47cwpXjsQOIl8qARFUql8a7AAxQL5nicENFPwoGyQyWUN7QHgqJ+a4LHveeiB
         TKZI0vzNZ+m9T2y7IUYLgSh+rvf0/6XRFiAe1JsiRqHGlBTLDRXudhRpY9i/8BuM9bel
         emBdrk0VJzk5I+h7/2aCZ3J6q2y2y07YM/K0LZDck3bZcaR4W8fqIuo1f6yjJ1oyJ1Ox
         /Jg/rZta2+fDsjTufomSWlQ1ot+B3wwYIW8ac4pC2iFu6hUtrDOM3PZaah6WJZzEzKZu
         soUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu7wr1u8keqtSUFRWPZ/9KbdWKeYgf9ieo1lL29HcgGbjbSv0sz+tEOG2c6l0vglpgtOAbXaPQqsywNE8=@vger.kernel.org, AJvYcCX2CpTtHOJf8mTDLo4BhMC8JzHVn4JWFhpDI/pp6natg/g5e6cvbAlHO340uzAJktciuEtGYxPh@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRGkn+ix8Ym7/7r+N9aGsxl3L9u/OXkm94uktlUxLOoeRv1e3
	CYAH2mtCWixi83EsLNepHiBvQKMmYJBAqNefyLC3IfYU6YtnoH6A1WjWOxN2Jq7Nt0nrNEM4xNl
	OjIrKivzILL3bcXL0EBFGrS/R/t4=
X-Google-Smtp-Source: AGHT+IEpRJOnGVCrLd3D1lgbc5zQRynFC+x2WBiNT3XYfjMNbJXyJtpREncJbqfP/fAYIk1eF9Tmxp1CFLlb149Ah50=
X-Received: by 2002:a05:651c:2124:b0:2fa:d7ea:a219 with SMTP id
 38308e7fff4ca-2fb8320f101mr106955081fa.37.1729588884388; Tue, 22 Oct 2024
 02:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ikuani1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20241008130807.40833-1-21cnbao@gmail.com> <87set6m73u.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87set6m73u.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 22 Oct 2024 17:21:07 +0800
Message-ID: <CAMgjq7D6Ku4-0mfJUexB9ARxY5eHwJjMS_M9qqXrvR=ScW0jtA@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, liyangouwen1@oppo.com, 
	mhocko@suse.com, minchan@kernel.org, sj@kernel.org, stable@vger.kernel.org, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	yosryahmed@google.com, yuzhao@google.com, Barry Song <21cnbao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:55=E2=80=AFAM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Thu, Oct 3, 2024 at 8:35=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@intel=
.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@in=
tel.com> wrote:
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >>
> >> >> >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huan=
g@intel.com> wrote:
> >> >> >> >>
> >> >> >> >> Hi, Barry,
> >> >> >> >>
> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >> >>
> >> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >> >
> >> >> >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapc=
ache")
> >> >> >> >> > introduced an unconditional one-tick sleep when `swapcache_=
prepare()`
> >> >> >> >> > fails, which has led to reports of UI stuttering on latency=
-sensitive
> >> >> >> >> > Android devices. To address this, we can use a waitqueue to=
 wake up
> >> >> >> >> > tasks that fail `swapcache_prepare()` sooner, instead of al=
ways
> >> >> >> >> > sleeping for a full tick. While tasks may occasionally be w=
oken by an
> >> >> >> >> > unrelated `do_swap_page()`, this method is preferable to tw=
o scenarios:
> >> >> >> >> > rapid re-entry into page faults, which can cause livelocks,=
 and
> >> >> >> >> > multiple millisecond sleeps, which visibly degrade user exp=
erience.
> >> >> >> >>
> >> >> >> >> In general, I think that this works.  Why not extend the solu=
tion to
> >> >> >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache=
_async()
> >> >> >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To=
 avoid
> >> >> >> >
> >> >> >> > Hi Ying,
> >> >> >> > Thanks for your comments.
> >> >> >> > I feel extending the solution to __read_swap_cache_async() sho=
uld be done
> >> >> >> > in a separate patch. On phones, I've never encountered any iss=
ues reported
> >> >> >> > on that path, so it might be better suited for an optimization=
 rather than a
> >> >> >> > hotfix?
> >> >> >>
> >> >> >> Yes.  It's fine to do that in another patch as optimization.
> >> >> >
> >> >> > Ok. I'll prepare a separate patch for optimizing that path.
> >> >>
> >> >> Thanks!
> >> >>
> >> >> >>
> >> >> >> >> overhead to call wake_up() when there's no task waiting, we c=
an use an
> >> >> >> >> atomic to count waiting tasks.
> >> >> >> >
> >> >> >> > I'm not sure it's worth adding the complexity, as wake_up() on=
 an empty
> >> >> >> > waitqueue should have a very low cost on its own?
> >> >> >>
> >> >> >> wake_up() needs to call spin_lock_irqsave() unconditionally on a=
 global
> >> >> >> shared lock.  On systems with many CPUs (such servers), this may=
 cause
> >> >> >> severe lock contention.  Even the cache ping-pong may hurt perfo=
rmance
> >> >> >> much.
> >> >> >
> >> >> > I understand that cache synchronization was a significant issue b=
efore
> >> >> > qspinlock, but it seems to be less of a concern after its impleme=
ntation.
> >> >>
> >> >> Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
> >> >> discussed in the following thread.
> >> >>
> >> >> https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.program=
ming.kicks-ass.net/
> >> >>
> >> >> > However, using a global atomic variable would still trigger cache=
 broadcasts,
> >> >> > correct?
> >> >>
> >> >> We can only change the atomic variable to non-zero when
> >> >> swapcache_prepare() returns non-zero, and call wake_up() when the a=
tomic
> >> >> variable is non-zero.  Because swapcache_prepare() returns 0 most t=
imes,
> >> >> the atomic variable is 0 most times.  If we don't change the value =
of
> >> >> atomic variable, cache ping-pong will not be triggered.
> >> >
> >> > yes. this can be implemented by adding another atomic variable.
> >>
> >> Just realized that we don't need another atomic variable for this, jus=
t
> >> use waitqueue_active() before wake_up() should be enough.
> >>
> >> >>
> >> >> Hi, Kairui,
> >> >>
> >> >> Do you have some test cases to test parallel zram swap-in?  If so, =
that
> >> >> can be used to verify whether cache ping-pong is an issue and wheth=
er it
> >> >> can be fixed via a global atomic variable.
> >> >>
> >> >
> >> > Yes, Kairui please run a test on your machine with lots of cores bef=
ore
> >> > and after adding a global atomic variable as suggested by Ying. I am
> >> > sorry I don't have a server machine.
> >> >
> >> > if it turns out you find cache ping-pong can be an issue, another
> >> > approach would be a waitqueue hash:
> >>
> >> Yes.  waitqueue hash may help reduce lock contention.  And, we can hav=
e
> >> both waitqueue_active() and waitqueue hash if necessary.  As the first
> >> step, waitqueue_active() appears simpler.
> >
> > Hi Andrew,
> > If there are no objections, can you please squash the below change? Ove=
n
> > has already tested the change and the original issue was still fixed wi=
th
> > it. If you want me to send v2 instead, please let me know.
> >
> > From a5ca401da89f3b628c3a0147e54541d0968654b2 Mon Sep 17 00:00:00 2001
> > From: Barry Song <v-songbaohua@oppo.com>
> > Date: Tue, 8 Oct 2024 20:18:27 +0800
> > Subject: [PATCH] mm: wake_up only when swapcache_wq waitqueue is active
> >
> > wake_up() will acquire spinlock even waitqueue is empty. This might
> > involve cache sync overhead. Let's only call wake_up() when waitqueue
> > is active.
> >
> > Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/memory.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index fe21bd3beff5..4adb2d0bcc7a 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4623,7 +4623,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       /* Clear the swap cache pin for direct swapin after PTL unlock */
> >       if (need_clear_cache) {
> >               swapcache_clear(si, entry, nr_pages);
> > -             wake_up(&swapcache_wq);
> > +             if (waitqueue_active(&swapcache_wq))
> > +                     wake_up(&swapcache_wq);
> >       }
> >       if (si)
> >               put_swap_device(si);
> > @@ -4641,7 +4642,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       }
> >       if (need_clear_cache) {
> >               swapcache_clear(si, entry, nr_pages);
> > -             wake_up(&swapcache_wq);
> > +             if (waitqueue_active(&swapcache_wq))
> > +                     wake_up(&swapcache_wq);
> >       }
> >       if (si)
> >               put_swap_device(si);
>
> Hi, Kairui,
>
> Do you have time to give this patch (combined with the previous patch
> from Barry) a test to check whether the overhead introduced in the
> previous patch has been eliminated?

Hi Ying, Barry

I did a rebase on mm tree and run more tests with the latest patch:

Before the two patches:
make -j96 (64k): 33814.45 35061.25 35667.54 36618.30 37381.60 37678.75
make -j96: 20456.03 20460.36 20511.55 20584.76 20751.07 20780.79
make -j64:7490.83 7515.55 7535.30 7544.81 7564.77 7583.41

After adding workqueue:
make -j96 (64k): 33190.60 35049.57 35732.01 36263.81 37154.05 37815.50
make -j96: 20373.27 20382.96 20428.78 20459.73 20534.59 20548.48
make -j64: 7469.18 7522.57 7527.38 7532.69 7543.36 7546.28

After adding workqueue with workqueue_active() check:
make -j96 (64k): 33321.03 35039.68 35552.86 36474.95 37502.76 37549.04
make -j96: 20601.39 20639.08 20692.81 20693.91 20701.35 20740.71
make -j64: 7538.63 7542.27 7564.86 7567.36 7594.14 7600.96

So I think it's just noise level performance change, it should be OK
in either way.

>
> --
> Best Regards,
> Huang, Ying
>

