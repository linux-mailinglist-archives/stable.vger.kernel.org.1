Return-Path: <stable+bounces-188293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E534BF4BC9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 08:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 710C74E239D
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 06:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207D267F58;
	Tue, 21 Oct 2025 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbzpM9sn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5C264F99
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029313; cv=none; b=koe6IyY9AYU72Zkj+L92ntYEslMPx/D1x4D0p3Clj+0zVbYCxBQm83aT7I2XyZ3dgHmWoFReuYui6OWtdDz2adGU1kCTyjMdtuW0jhbkwXlww6aDosHtlTXlojSpHHnU5p33ilMsRc3MkOQGvN0bCDMW9njD/VrYhDpNmXlfmVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029313; c=relaxed/simple;
	bh=Yao5CLBIZBpqI8yZPYhEq0pLUsEI2cplrdc+D5Sg0x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlYJaOPkrO9KpmVM7YjzeAWiqTt5oNNjK8+rFwUizEiPMwDyyiPA4/9gQ+R1zBJ7vRS/sUqUUicajabXVZZ6BwuCfsRPYELYk87SsWL9s2r1ghbrjYx/LVs7SkxY1XGUxb+nUnY8rVDUKzzLo0ETsPd64GG4q6NGeiaNhhHvEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbzpM9sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099EDC4CEFF
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 06:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761029313;
	bh=Yao5CLBIZBpqI8yZPYhEq0pLUsEI2cplrdc+D5Sg0x0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nbzpM9snHIvTmCdgk9XL9kWjWJCsQb5xGylqoOW8ntqO3t7FM4ISonMrkKV4dld3A
	 VIFDVegKvs7CJSY4P6rtkaSvsDGhzenf/UdAz+ArtErG7IhGAYNI2zKs3VZbP/YiOO
	 VYjH1vdzNB6vb9K2xbNgDu1m77iYes8SuLsdcwfUCKAK6OX2XdJOtbXeO1/Qjt/kPC
	 pNKOXERX1gBxKcEDKqDkO9xEqFURZnPtlEQpmEpY84uzMiBHTkVXv9HR0LBzQiEQKe
	 T89qy9borWV5ZpPJu+lw7bTzYhjhw03Wo5HONjcSgG+hSzN7pK29D+vbqWgE5OeiJ3
	 5xdnVXjYocYnQ==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7847f4265e3so29138697b3.3
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 23:48:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLsKvhzyTzK5ymrVJKHzjVcg1hRHjsYjnkQhmEyMdA+IQ/Kmk3AgWpe7G0ByjUU6DgV3rINsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5HeB/JYj+xH5zQVz8dWTOaqoljuMd2r8bscdjVLnso9v4RQaa
	PfGyom2xdV8jdPej01DqOZQGjvApBKVdDqSgBEZW4lykOq+pHyeFBE++REHYPvibrhZ83ZkNRxC
	L81ApusMrqu6pAlvd9/g3JmY37u8dC5EdOO0QWEEc1w==
X-Google-Smtp-Source: AGHT+IEKwgU/k6+a6m9j5wLqPHqWi37Ymmn/fXH4mZwMQ6tpYpjsC1ZwqJENF/v+P8dGntZXlSsHbAcNq1qNWQU/s6E=
X-Received: by 2002:a53:edc2:0:b0:63c:f5a6:f2de with SMTP id
 956f58d0204a3-63e1626c69amr9740357d50.64.1761029312099; Mon, 20 Oct 2025
 23:48:32 -0700 (PDT)
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
 <CACePvbWu0P+8Sv-sS7AnG+ESdnJdnFE_teC9NF9Rkn1HegQ9_Q@mail.gmail.com>
 <CAMgjq7BJcxGzrnr+EeO6_ZC7dAn0_WmWn8DX8gSPfyYiY4S3Ug@mail.gmail.com> <CAMgjq7CsYhEjvtN85XGkrONYAJxve7gG593TFeOGV-oax++kWA@mail.gmail.com>
In-Reply-To: <CAMgjq7CsYhEjvtN85XGkrONYAJxve7gG593TFeOGV-oax++kWA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 20 Oct 2025 23:48:20 -0700
X-Gmail-Original-Message-ID: <CACePvbWn1pAJg8xGfJFrWxpkJDakJA0GfgJc0W80EUYS6YhBAg@mail.gmail.com>
X-Gm-Features: AS18NWDK_5ydoR83ck7SoROtH9BUHSuIRVHk1u1H4KWAOIdgu6-tq2E-NYuReAE
Message-ID: <CACePvbWn1pAJg8xGfJFrWxpkJDakJA0GfgJc0W80EUYS6YhBAg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during allocation
To: Kairui Song <ryncsn@gmail.com>
Cc: YoungJun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:46=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Wed, Oct 15, 2025 at 2:24=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Wed, Oct 15, 2025 at 12:00=E2=80=AFPM Chris Li <chrisl@kernel.org> w=
rote:
> > >
> > > On Tue, Oct 14, 2025 at 2:27=E2=80=AFPM Chris Li <chrisl@kernel.org> =
wrote:
> > > >
> > > > On Sun, Oct 12, 2025 at 9:49=E2=80=AFAM Kairui Song <ryncsn@gmail.c=
om> wrote:
> > > > > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > > > > index cb2392ed8e0e..0d1924f6f495 100644
> > > > > > > --- a/mm/swapfile.c
> > > > > > > +++ b/mm/swapfile.c
> > > > > > > @@ -1101,13 +1101,6 @@ static unsigned long cluster_alloc_swa=
p_entry(struct swap_info_struct *si, int o
> > > > > > >                         goto done;
> > > > > > >         }
> > > > > > >
> > > > > > > -       /*
> > > > > > > -        * We don't have free cluster but have some clusters =
in discarding,
> > > > > > > -        * do discard now and reclaim them.
> > > > > > > -        */
> > > > > > > -       if ((si->flags & SWP_PAGE_DISCARD) && swap_do_schedul=
ed_discard(si))
> > > > > > > -               goto new_cluster;
> > > > > >
> > > > > > Assume you follow my suggestion.
> > > > > > Change this to some function to detect if there is a pending di=
scard
> > > > > > on this device. Return to the caller indicating that you need a
> > > > > > discard for this device that has a pending discard.
> > > > > > Add an output argument to indicate the discard device "discard"=
 if needed.
> > > > >
> > > > > The problem I just realized is that, if we just bail out here, we=
 are
> > > > > forbidding order 0 to steal if there is any discarding cluster. W=
e
> > > > > just return here to let the caller handle the discard outside
> > > > > the lock.
> > > >
> > > > Oh, yes, there might be a bit of change in behavior. However I can'=
t
> > > > see it is such a bad thing if we wait for the pending discard to
> > > > complete before stealing and fragmenting the existing folio list. W=
e
> > > > will have less fragments compared to the original result. Again, my
> > > > point is not that we always keep 100% the old behavior, then there =
is
> > > > no room for improvement.
> > > >
> > > > My point is that, are we doing the best we can in that situation,
> > > > regardless how unlikely it is.
> > > >
> > > > >
> > > > > It may just discard the cluster just fine, then retry from free c=
lusters.
> > > > > Then everything is fine, that's the easy part.
> > > >
> > > > Ack.
> > > >
> > > > > But it might also fail, and interestingly, in the failure case we=
 need
> > > >
> > > > Can you spell out the failure case you have in mind? Do you mean th=
e
> > > > discard did happen but another thread stole "the recently discarded
> > > > then became free cluster"?
> > > >
> > > > Anyway, in such a case, the swap allocator should continue and find
> > > > out we don't have things to discard now, it will continue to the
> > > > "steal from other order > 0 list".
> > > >
> > > > > to try again as well. It might fail with a race with another disc=
ard,
> > > > > in that case order 0 steal is still feasible. Or it fail with
> > > > > get_swap_device_info (we have to release the device to return her=
e),
> > > > > in that case we should go back to the plist and try other devices=
.
> > > >
> > > > When stealing from the other order >0 list failed, we should try
> > > > another device in the plist.
> > > >
> > > > >
> > > > > This is doable but seems kind of fragile, we'll have something li=
ke
> > > > > this in the folio_alloc_swap function:
> > > > >
> > > > > local_lock(&percpu_swap_cluster.lock);
> > > > > if (!swap_alloc_fast(&entry, order))
> > > > >     swap_alloc_slow(&entry, order, &discard_si);
> > > > > local_unlock(&percpu_swap_cluster.lock);
> > > > >
> > > > > +if (discard_si) {
> > > >
> > > > I feel the discard logic should be inside the swap_alloc_slow().
> > > > There is a  plist_for_each_entry_safe(), inside that loop to do the
> > > > discard and retry().
> > > > If I previously suggested it change in here, sorry I have changed m=
y
> > > > mind after reasoning the code a bit more.
> > >
> > > Actually now I have given it a bit more thought, one thing I realized
> > > is that you might need to hold the percpu_swap_cluster lock all the
> > > time during allocation. That might force you to do the release lock
> > > and discard in the current position.
> > >
> > > If that is the case, then just making the small change in your patch
> > > to allow hold waiting to discard before trying the fragmentation list
> > > might be good enough.
> > >
> > > Chris
> > >
> >
> > Thanks, I was composing a reply on this and just saw your new comment.
> > I agree with this.
>
> Hmm, it turns out modifying V1 to handle non-order 0 allocation
> failure also has some minor issues. Every mTHP SWAP allocation failure
> will have a slight higher overhead due to the discard check. V1 is
> fine since it only checks discard for order 0, and order 0 alloc
> failure is uncommon and usually means OOM already.
>
> I'm not saying V1 is the final solution, but I think maybe we can just
> keep V1 as it is? That's easier for a stable backport too, and this is

I am fine with that, assuming you need to adjust the presentation to
push V1 as hotfix. I can ack your newer  patch to adjust the
presentation.

> doing far better than what it was like. The sync discard was added in
> 2013 and the later added percpu cluster at the same year never treated
> it carefully. And the discard during allocation after recent swap
> allocator rework has been kind of broken for a while.
>
> To optimize it further in a clean way, we have to reverse the
> allocator's handling order of the plist and fast / slow path. Current
> order is local_lock -> fast -> slow (plist).

I like that. I think that is the eventual way to go. I want to see how
it integrates with the swap.tiers patches. If you let me pick, I would
go straight with this one for 6.19.

>
> We can walk the plist first, then do the fast / slow path: plist (or
> maybe something faster than plist but handles the priority) ->
> local_lock -> fast -> slow (bonus: this is more friendly to RT kernels
> too I think). That way we don't need to rewalk the plist after
> releasing the local_lock and save a lot of trouble. I remember I
> discussed with Youngjun on this sometime ago in the mail list, I know
> things have changed a lot but some ideas seems are still similar. I
> think his series is moving the percpu cluster into each device (si),
> we can also move the local_lock there, which is just what I'm talking
> about here.

Ack. We will need to see both patches to figure out how to integrate
them together. Right now we have two moving parts. More to the point
that we get the eventual patch sooner.

Chris

