Return-Path: <stable+bounces-185733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C94CBDB697
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 23:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1071B5466B3
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677AE2BCF75;
	Tue, 14 Oct 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSh+7bFd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24646270553
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477287; cv=none; b=BuzsZCYHFlcJFk6EWf/KkWS4TTWyX58yoVYXq7w3cu6X8W+MLKOVhoVYDdNP/NeFmLF3OSlXLbIIlARzqzKYAZCSCSWEbvwEkCZ01KrK1HeNOGjJdtpWEolsIgr+BmpmzUSOGiHoLXX/hB7vBTml0PAzSnQXNUEeILdtsIZyTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477287; c=relaxed/simple;
	bh=HJU6jgpBrRoqSzifdhRbrpu2Q8okQ4lMGIwnns7OY6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBvfPcE83h+aIHs8P1GT/FyfjCZGSTzCtMDctoKAs6pEvlKn5Cw7EhX7excKOij7SXahZKe0MLinpfaTUDnbepST2+wig1hgI7I3UxeMVPX50N9uM+Dhui4iNlYPPxE7Syo8+HS4eha0BW6x/D39qBuGiXwjtp0TgsDNJUvIJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSh+7bFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39A0C4CEF1
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 21:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760477287;
	bh=HJU6jgpBrRoqSzifdhRbrpu2Q8okQ4lMGIwnns7OY6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bSh+7bFdWzzYFYIZ3oKTnK+fj7yrSJwMv++f7XKVl2/ZWEMXGrxxcQc8NBs8IBrQj
	 4oPRenwdMdeKmkzOPSNOoyrdWoM8QoZHHyGXjGfM6ePPesrWhkpA3R3OYkd/eLJCYa
	 SssL61XGzXSXa3UyCXrEGhzcH3b8A/GJ2eoHiR10Tj1xK9W1prUkQBGFCc2E6TqADB
	 ViJpZTBpcqM4nFvZBmRPZC+fVycmpH4JLOlMd8LRwWPM9wkz7f1rHb/7yhozCGa5Lq
	 9YLeM/z6FH0JE97DYq1n2qCoM61yUHI1W2lWWJOPaYBmMXd/q2Izd0gT6oPa1lGcJ7
	 akqY03sJRr4Dw==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcab69so54637077b3.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 14:28:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkTjps0f1GvbrOseXkMEDiiz77cvW584bn7WE1Z1Tr0gwAY+iin+u7/N9XhAzYe/SZZx2ukW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMcN48KZNO+enDdqjgFUHWdt9OexKIzCEjSJTXYluEmaFxKb0
	QwKLftg3eQE9JSbP9+fwoSn+Fd3PVrIEcfH79LqW7LuUZJN1Jxe+DzP92QSJyr/pp/W4eBoUCXS
	9m+fosfB+t5KkpXIuG8FluHkl9bLvKp9qu/mhMXc6Cw==
X-Google-Smtp-Source: AGHT+IFOUU5zbvnC4T3HBlIJDpVoyBG6TeJ0obJkgVwC4t9L9fvNLxrqazU71ZDp5ynPn0I89zzGlKBhQUOm4+MYA8k=
X-Received: by 2002:a05:690c:4a04:b0:75c:92ef:5765 with SMTP id
 00721157ae682-780e143ba60mr277912207b3.15.1760477286221; Tue, 14 Oct 2025
 14:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
 <CACePvbWs3hFWt0tZc4jbvFN1OXRR5wvNXiMjBBC4871wQjtqMw@mail.gmail.com> <CAMgjq7BD6SOgALj2jv2SVtNjWLJpT=1UhuaL=qxvDCMKUy68Hw@mail.gmail.com>
In-Reply-To: <CAMgjq7BD6SOgALj2jv2SVtNjWLJpT=1UhuaL=qxvDCMKUy68Hw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 14 Oct 2025 14:27:54 -0700
X-Gmail-Original-Message-ID: <CACePvbVEGgtTqkMPqsf69C7qUD52yVcC56POed8Pdt674Pn68A@mail.gmail.com>
X-Gm-Features: AS18NWAGs720dZZMfrF-iNxN9KXaSbIoVIoPrDyY4weThVB7DBKVGI86lQkeKUQ
Message-ID: <CACePvbVEGgtTqkMPqsf69C7qUD52yVcC56POed8Pdt674Pn68A@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during allocation
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 9:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index cb2392ed8e0e..0d1924f6f495 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -1101,13 +1101,6 @@ static unsigned long cluster_alloc_swap_entry(=
struct swap_info_struct *si, int o
> > >                         goto done;
> > >         }
> > >
> > > -       /*
> > > -        * We don't have free cluster but have some clusters in disca=
rding,
> > > -        * do discard now and reclaim them.
> > > -        */
> > > -       if ((si->flags & SWP_PAGE_DISCARD) && swap_do_scheduled_disca=
rd(si))
> > > -               goto new_cluster;
> >
> > Assume you follow my suggestion.
> > Change this to some function to detect if there is a pending discard
> > on this device. Return to the caller indicating that you need a
> > discard for this device that has a pending discard.
> > Add an output argument to indicate the discard device "discard" if need=
ed.
>
> The problem I just realized is that, if we just bail out here, we are
> forbidding order 0 to steal if there is any discarding cluster. We
> just return here to let the caller handle the discard outside
> the lock.

Oh, yes, there might be a bit of change in behavior. However I can't
see it is such a bad thing if we wait for the pending discard to
complete before stealing and fragmenting the existing folio list. We
will have less fragments compared to the original result. Again, my
point is not that we always keep 100% the old behavior, then there is
no room for improvement.

My point is that, are we doing the best we can in that situation,
regardless how unlikely it is.

>
> It may just discard the cluster just fine, then retry from free clusters.
> Then everything is fine, that's the easy part.

Ack.

> But it might also fail, and interestingly, in the failure case we need

Can you spell out the failure case you have in mind? Do you mean the
discard did happen but another thread stole "the recently discarded
then became free cluster"?

Anyway, in such a case, the swap allocator should continue and find
out we don't have things to discard now, it will continue to the
"steal from other order > 0 list".

> to try again as well. It might fail with a race with another discard,
> in that case order 0 steal is still feasible. Or it fail with
> get_swap_device_info (we have to release the device to return here),
> in that case we should go back to the plist and try other devices.

When stealing from the other order >0 list failed, we should try
another device in the plist.

>
> This is doable but seems kind of fragile, we'll have something like
> this in the folio_alloc_swap function:
>
> local_lock(&percpu_swap_cluster.lock);
> if (!swap_alloc_fast(&entry, order))
>     swap_alloc_slow(&entry, order, &discard_si);
> local_unlock(&percpu_swap_cluster.lock);
>
> +if (discard_si) {

I feel the discard logic should be inside the swap_alloc_slow().
There is a  plist_for_each_entry_safe(), inside that loop to do the
discard and retry().
If I previously suggested it change in here, sorry I have changed my
mind after reasoning the code a bit more.

The fast path layer should not know about the discard() and also
should not retry the fast path if after waiting for the discard to
complete.

The discard should be on the slow path for sure.

> +    if (get_swap_device_info(discard_si)) {

Inside the slow path there is get_swap_device_info(si), you should be
able to reuse those?

> +        swap_do_scheduled_discard(discard_si);
> +        put_swap_device(discard_si);
> +        /*
> +         * Ignoring the return value, since we need to try
> +         * again even if the discard failed. If failed due to
> +         * race with another discard, we should still try
> +         * order 0 steal.
> +         */
> +    } else {

Shouldn't need the "else", the swap_alloc_slow() can always set
dicard_si =3D NULL internally if no device to discard or just set
discard =3D NULL regardless.

> +        discard_si =3D NULL;
> +        /*
> +         * If raced with swapoff, we should try again too but
> +         * not using the discard device anymore.
> +         */
> +    }
> +    goto again;
> +}
>
> And the `again` retry we'll have to always start from free_clusters again=
,

That is fine, because discard causes clusters to move into free_clusters no=
w.

> unless we have another parameter just to indicate that we want to skip
> everything and jump to stealing, or pass and reuse the discard_si
> pointer as return argument to cluster_alloc_swap_entry as well,
> as the indicator to jump to stealing directly.

It is a rare case, we don't have to jump directly to stealing. If the
discard happens and that discarded cluster gets stolen by other
threads, I think it is fine going through the fragment list before
going to the order 0 stealing from another order fragment list.

> It looks kind of strange. So far swap_do_scheduled_discard can only
> fail due to a race with another successful discard, so retrying is
> safe and won't run into an endless loop. But it seems easy to break,
> e.g. if we may handle bio alloc failure of discard request in the
> future. And trying again if get_swap_device_info failed makes no sense
> if there is only one device, but has to be done here to cover
> multi-device usage, or we have to add more special checks.

Well, you can have sync wait check check for discard if there is >0
number of clusters successfully discarded.

>
> swap_alloc_slow will be a bit longer too if we want to prevent
> touching plist again:
> +/*
> + * Resuming after trying to discard cluster on a swap device,
> + * try the discarded device first.
> + */
> +si =3D *discard_si;
> +if (unlikely(si)) {
> +    *discard_si =3D NULL;
> +    if (get_swap_device_info(si)) {
> +        offset =3D cluster_alloc_swap_entry(si, order, SWAP_HAS_CACHE,
> &need_discard);
> +        put_swap_device(si);
> +        if (offset) {
> +            *entry =3D swp_entry(si->type, offset);
> +            return true;
> +        }
> +        if (need_discard) {
> +            *discard_si =3D si;

> +            return false;

I haven't tried it myself. but I feel we should move the sync wait for
discard here but with the lock released then re-acquire the lock.
That might simplify the logic. The discard should belong to the slow
path behavior, definitely not part of the fast path.

> +        }
> +    }
> +}
>
> The logic of the workflow jumping between several functions might also
> be kind of hard to follow. Some cleanup can be done later though.
>
> Considering the discard issue is really rare, I'm not sure if this is
> the right way to go? How do you think?

Let's try moving the discard and retry inside the slow path but
release the lock and see how it feels.
If you want, I can also give it a try, I just don't want to step on your to=
es.

> BTW: The logic of V1 can be optimized a little bit to let discards also
> happen with order > 0 cases too. That seems closer to what the current
> upstream kernel was doing except: Allocator prefers to try another
> device instead of waiting for discard, which seems OK?

I think we should wait for the discard. Having discard means the
device can have maybe (many?) free clusters soon. We can wait. It is a
rare case anyway. From the swap.tiers point of view, it would be
better to exhaust the current high priority device before consuming
the low priority device. Otherwise you will have very minor swap
device priority inversion for a few swap entries, those swap entries
otherwise can be allocated on the discarded free cluster from high
priority swapdevice.

> And order 0 steal can happen without waiting for discard.

I am OK to change the behavior to let order 0 wait for the discard as
well. It happens so rarely and we have less fragmented clusters
compared to the alternatives of stealing from higher order clusters
now. I think that is OK. We end up having less fragmented clusters,
which is a
good thing.

> Fragmentation under extreme pressure might not be that
> serious an issue if we are having really slow SSDs, and
> might even be no longer an issue if we have a generic
> solution for frags?

Chris

