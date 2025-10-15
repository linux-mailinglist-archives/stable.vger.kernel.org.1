Return-Path: <stable+bounces-185843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E1BDFBEA
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108723C8CCD
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE314338F28;
	Wed, 15 Oct 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2ViLkac"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F6347C7
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546793; cv=none; b=iqJdPiBCw8EXCFLBozpKFemEaMJF7k9cNsNFTm9h8EAtwrINVxURwpl6n5jivMM6TljuAQlhFZ5NBOgsvUwngc+fWDOipSniNSRzpaFfUWkDLG/hrhl/aqbAToAxGhSpmIKAuC7fH5IjLOpGATzLSz1xUb6O8zMEReCokZHwRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546793; c=relaxed/simple;
	bh=Z41LuI9tLYiSntSpeFn49bymYZnJnKjlj9AHYgaf+C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P657jkYrU4LswQqcVF7A63SEjCV9c2lwDopR4bt8DIETrBY8STvDzIsY99TFZROLOUoS9edDOzjtbfHxMsaF9SAUpa/0b9BCYollgiYKLLPn9dI0pQXEZzpz/Xt8vhckKYnbM5lhT1aRNenoJTEsIuTy1UaUpnWoeoISx2dLzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2ViLkac; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1401831166b.1
        for <stable@vger.kernel.org>; Wed, 15 Oct 2025 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760546790; x=1761151590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je0F7nfACXJpbmYznXu1sTtkMbdp1GFHRjbs99COgfU=;
        b=P2ViLkacA/Bpvv49Yd0ia6T+cSn2XJBKjv9ZsoqKhFf+Yrd3Mqyn5JoFCGe4wIZN2O
         5k439cg0UarDbzX+PLeG49dLhGaHuYTLuJpO3JQhYWC46KCmDrtCcp60FsnMhsTfZedq
         arxM1R3aE5sMK4kqZCh9xx5ATuXqi38w117u8p6gnl85NuqXsYLdA2ghS+ae453ChO0u
         pDJz4T8oeEHsddKJi0bJdvJS9Q1LJoexuV2QQ7Pc4RJIDfxNpGSpQOkDEG676pylui2J
         Dw6D4EvDrikrEGihNvZDNkP+W5LYRWzn8Z28RY/r5hnTv5M4oGcEQ0Z5LuM1fpPHvQdz
         Jnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546790; x=1761151590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je0F7nfACXJpbmYznXu1sTtkMbdp1GFHRjbs99COgfU=;
        b=GTvBlwaXJR2Hc0YoS+eCvYkfAHQWwB3ihRs2QZzDFTPUc+o0KSrMeREsonyx1fTN6c
         pBAQuUOSYrVEKN4jCj70+/9ru1jghXJ3c7lNMpsZK2KKTe9jCZVG0U6yp/TVp9y92Cqk
         lUzqUydPaThE7/ThB2kvDKN3watYP5CuT9MAY9rhrxOiWh1RNZlVrv7PEw8+QMTIyuh4
         uiZh/mfjcrnfBxH+nSp6W1O63saQJbMbJyCa8EoiGavFTtQvvec3ogE1Go6AUYukxkvb
         ndOD/OhYLxKHMtiyqsuKxaGSzQzlDqkT5JiColUQc2QWrf8OZfnAUe52bHPMUKS7qsIQ
         kYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnQCLyPNn57+582SNn38V3vZlcA4cDTV0r3Rwe9OKq2Z77t2mP7y+12H7iX2hjudw36t+6VE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnujDB15ZuGuZrlHUfzOARnaPvloDWfMVFGqOtJX7HnbmJFFPj
	TZn8yAXewqPpmQMiK65z5o9yxpOBwLp6fDneGeN4eybWJwwBXI++xGDAW0Vdzy9SowBdj+SbE6I
	ijRR5//IcVBB0gos207UDtM0cs472mmc=
X-Gm-Gg: ASbGncvUvfAajyWk6kqo9VM0YtX8c2hlDsX0Xc8VUDeK2xmnwy8THPU5K3JtVqWq95J
	kjjT7Sk0FkFzIaYXgkBwUjNB1mBz0HAovNMyzYV81iLhA+5LMHKIBcL1iwTHJuFsZsnFz3YNZQj
	iZCgkjA/+Kp9hhrX8NHe0G+tdHA04WOY3nSUfn4esIQJ5843oGSb/oM/0tUf9wxjAnKD1AUAzZr
	1/2DeykblmxpKIypR+yWV/D6w==
X-Google-Smtp-Source: AGHT+IG6mst+qVI0JUb5puzOWQMXSlytfQLY39/u3UCs+EtF1W8BL9hwi0uE2sSR4jvdT6ZVos7cZl+TB59DjLKsk2o=
X-Received: by 2002:a17:907:980f:b0:b42:9840:eac5 with SMTP id
 a640c23a62f3a-b50acb0e645mr3174683566b.61.1760546789493; Wed, 15 Oct 2025
 09:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
 <CACePvbWs3hFWt0tZc4jbvFN1OXRR5wvNXiMjBBC4871wQjtqMw@mail.gmail.com>
 <CAMgjq7BD6SOgALj2jv2SVtNjWLJpT=1UhuaL=qxvDCMKUy68Hw@mail.gmail.com>
 <CACePvbVEGgtTqkMPqsf69C7qUD52yVcC56POed8Pdt674Pn68A@mail.gmail.com>
 <CACePvbWu0P+8Sv-sS7AnG+ESdnJdnFE_teC9NF9Rkn1HegQ9_Q@mail.gmail.com> <CAMgjq7BJcxGzrnr+EeO6_ZC7dAn0_WmWn8DX8gSPfyYiY4S3Ug@mail.gmail.com>
In-Reply-To: <CAMgjq7BJcxGzrnr+EeO6_ZC7dAn0_WmWn8DX8gSPfyYiY4S3Ug@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 16 Oct 2025 00:45:52 +0800
X-Gm-Features: AS18NWBxPhombhPrk2cbIiwnOB7SZCpnaOyVcUMkzwhYwQ_vXmWp_OG4dB0nf-M
Message-ID: <CAMgjq7CsYhEjvtN85XGkrONYAJxve7gG593TFeOGV-oax++kWA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during allocation
To: Chris Li <chrisl@kernel.org>, YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 2:24=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Wed, Oct 15, 2025 at 12:00=E2=80=AFPM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > On Tue, Oct 14, 2025 at 2:27=E2=80=AFPM Chris Li <chrisl@kernel.org> wr=
ote:
> > >
> > > On Sun, Oct 12, 2025 at 9:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > > > index cb2392ed8e0e..0d1924f6f495 100644
> > > > > > --- a/mm/swapfile.c
> > > > > > +++ b/mm/swapfile.c
> > > > > > @@ -1101,13 +1101,6 @@ static unsigned long cluster_alloc_swap_=
entry(struct swap_info_struct *si, int o
> > > > > >                         goto done;
> > > > > >         }
> > > > > >
> > > > > > -       /*
> > > > > > -        * We don't have free cluster but have some clusters in=
 discarding,
> > > > > > -        * do discard now and reclaim them.
> > > > > > -        */
> > > > > > -       if ((si->flags & SWP_PAGE_DISCARD) && swap_do_scheduled=
_discard(si))
> > > > > > -               goto new_cluster;
> > > > >
> > > > > Assume you follow my suggestion.
> > > > > Change this to some function to detect if there is a pending disc=
ard
> > > > > on this device. Return to the caller indicating that you need a
> > > > > discard for this device that has a pending discard.
> > > > > Add an output argument to indicate the discard device "discard" i=
f needed.
> > > >
> > > > The problem I just realized is that, if we just bail out here, we a=
re
> > > > forbidding order 0 to steal if there is any discarding cluster. We
> > > > just return here to let the caller handle the discard outside
> > > > the lock.
> > >
> > > Oh, yes, there might be a bit of change in behavior. However I can't
> > > see it is such a bad thing if we wait for the pending discard to
> > > complete before stealing and fragmenting the existing folio list. We
> > > will have less fragments compared to the original result. Again, my
> > > point is not that we always keep 100% the old behavior, then there is
> > > no room for improvement.
> > >
> > > My point is that, are we doing the best we can in that situation,
> > > regardless how unlikely it is.
> > >
> > > >
> > > > It may just discard the cluster just fine, then retry from free clu=
sters.
> > > > Then everything is fine, that's the easy part.
> > >
> > > Ack.
> > >
> > > > But it might also fail, and interestingly, in the failure case we n=
eed
> > >
> > > Can you spell out the failure case you have in mind? Do you mean the
> > > discard did happen but another thread stole "the recently discarded
> > > then became free cluster"?
> > >
> > > Anyway, in such a case, the swap allocator should continue and find
> > > out we don't have things to discard now, it will continue to the
> > > "steal from other order > 0 list".
> > >
> > > > to try again as well. It might fail with a race with another discar=
d,
> > > > in that case order 0 steal is still feasible. Or it fail with
> > > > get_swap_device_info (we have to release the device to return here)=
,
> > > > in that case we should go back to the plist and try other devices.
> > >
> > > When stealing from the other order >0 list failed, we should try
> > > another device in the plist.
> > >
> > > >
> > > > This is doable but seems kind of fragile, we'll have something like
> > > > this in the folio_alloc_swap function:
> > > >
> > > > local_lock(&percpu_swap_cluster.lock);
> > > > if (!swap_alloc_fast(&entry, order))
> > > >     swap_alloc_slow(&entry, order, &discard_si);
> > > > local_unlock(&percpu_swap_cluster.lock);
> > > >
> > > > +if (discard_si) {
> > >
> > > I feel the discard logic should be inside the swap_alloc_slow().
> > > There is a  plist_for_each_entry_safe(), inside that loop to do the
> > > discard and retry().
> > > If I previously suggested it change in here, sorry I have changed my
> > > mind after reasoning the code a bit more.
> >
> > Actually now I have given it a bit more thought, one thing I realized
> > is that you might need to hold the percpu_swap_cluster lock all the
> > time during allocation. That might force you to do the release lock
> > and discard in the current position.
> >
> > If that is the case, then just making the small change in your patch
> > to allow hold waiting to discard before trying the fragmentation list
> > might be good enough.
> >
> > Chris
> >
>
> Thanks, I was composing a reply on this and just saw your new comment.
> I agree with this.

Hmm, it turns out modifying V1 to handle non-order 0 allocation
failure also has some minor issues. Every mTHP SWAP allocation failure
will have a slight higher overhead due to the discard check. V1 is
fine since it only checks discard for order 0, and order 0 alloc
failure is uncommon and usually means OOM already.

I'm not saying V1 is the final solution, but I think maybe we can just
keep V1 as it is? That's easier for a stable backport too, and this is
doing far better than what it was like. The sync discard was added in
2013 and the later added percpu cluster at the same year never treated
it carefully. And the discard during allocation after recent swap
allocator rework has been kind of broken for a while.

To optimize it further in a clean way, we have to reverse the
allocator's handling order of the plist and fast / slow path. Current
order is local_lock -> fast -> slow (plist).

We can walk the plist first, then do the fast / slow path: plist (or
maybe something faster than plist but handles the priority) ->
local_lock -> fast -> slow (bonus: this is more friendly to RT kernels
too I think). That way we don't need to rewalk the plist after
releasing the local_lock and save a lot of trouble. I remember I
discussed with Youngjun on this sometime ago in the mail list, I know
things have changed a lot but some ideas seems are still similar. I
think his series is moving the percpu cluster into each device (si),
we can also move the local_lock there, which is just what I'm talking
about here.

