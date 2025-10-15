Return-Path: <stable+bounces-185755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E57ABDCB5B
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 08:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE784423583
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8B30FC28;
	Wed, 15 Oct 2025 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbICir2q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91830FF3F
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509486; cv=none; b=EQpriM9+ruNY55XSlSkP/v2uuEYWEPe6z88jvx8m7Xv6NuApMIaoQwOiS2GX727Ap/UreCHNa0UvW5IELCj3v23Ub41paoHmjnO/YvkpnXUzFiwQFxjKzEFABhcuCu6x0G9V47jGxfJXDf6OAi7Ciij/GKuaHiRHfY50T3vyswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509486; c=relaxed/simple;
	bh=XRlToop6GsVJ5YSLnC/XKqBxmoitOUWKRzc2l+sfncI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWhUpO4Yz/s7YrYFi37eMrGtF20GlaKYPiB/Kv8s7U9tUewMMEVp5kx+qYIhJWmR3gO3H7LJ3XYBO9wo3PtaUr77UidwFRJXkqR1JMnArIxo/vJwuCDPmx4lVdJ9trd8AYwSRPAykaQZhapy5wpVM5WdBC1mVZDeFEbKFbxFOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbICir2q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so12775856a12.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760509478; x=1761114278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeB4B0o6ZFZSmSenqU/MXjy9m+7+CBsIYJA6lRQIgVk=;
        b=LbICir2qNbbgJtCsIWHYKQDyYaUd2wAhgp2GdnBGTJ/p1by8cyhZB1rgvS32nEE9o5
         DDqRIFkSKZ87trPSRwecPOPy6xDmqAnGRGL+2E9Sv1LL37Vz9byU1S00xFEWW3Joi5uN
         IP2eDg76VX8hxtkaWb/5+NJKmlNKeU3uj03MU6tQGVeENr0PMbZihWzZt7c1IY5g0/0/
         iSE7NiJAWqPJ+BbrflnzbtDzP17tiq31Ayy0qkccI2MS2Om2D/hz2cO9jyPhUFn/VW8h
         4FWx1qZgd4c0Qoiqp5BU9IertH9xELqofDGfiqJhhNpBQUPJfzN9ExqJF5vcTe7bozZ8
         w8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760509478; x=1761114278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeB4B0o6ZFZSmSenqU/MXjy9m+7+CBsIYJA6lRQIgVk=;
        b=ojbUpPHf4vu0dx/UcPJo03MkgP8FCpZ3G/RpkgYFbIMEs9u1aiL8gRS/zf3fo0r7n9
         X31eawCu9C6LXidhEE+1STpmKX8FwpN5ie4R5kKTnUfRgl/JVuEFtgrokLn2PX9NHsDM
         L/JAnJamA7TE+g3/UJHUDFqFgD57GdrsVRL0lBm5Dtcnmvc+Luz5LuLlvHkTD2Sv1j7/
         H7+uirH8C0i9Vh/J2lyemaPGcrml2jMpTZZiZ+Asj+H5Y9w59vMUeNKMG8vTK5X3Iigj
         i4cZsfx3YC2TWCu9kXkDmzTMNYssuYbD9KItbuv0xP0JavxPtOiKRExGPmlLMmP62A4h
         V3xA==
X-Forwarded-Encrypted: i=1; AJvYcCUWJQbgNmHMPITBpnlnusKTlqIM1v0dbARNnyuRKb0vwnIpeMzyz0MY4s58hN3AXSZ94Rd69qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCDszoE9q48W8j56CorbVLYatdeAL5vV6ZG0X825SWLJhm0uP
	YfYoByLamIb95PHGGGWNJ08j8f8MkORC8kp6WUjbSuzJjvO4qucTGTkXLFZBHiKbHJ5CDnR8GDp
	k+X4Lh0KBIxIPDGlzsVQCxD55igvAwx8=
X-Gm-Gg: ASbGncve70vysEVYFrkD/lJxsj150YIzONGGC05Pw/tFaPCXVGtfhPkeQn5Gdaw9YZw
	beLwwsPi/bVGDyj8VaRUYZTlEWyPptlEmCGaHJ5qyj3FdILZTP7m1unsnmRh7UBAg7O4sm0g2pE
	qcngTX3LrODpvdsuk6UJGhJL1PyMGLMHpxYejMCiYTW6Ww3IBf3RqIHP6qU3SM+S7bKqZAwr6v2
	6yAKB7LgGW3BsKELD0YYj/YRg==
X-Google-Smtp-Source: AGHT+IFGGYslRbnhLBUwy7KAbmiw67Ch2lThxcHUMdPIPl2puDlhXq9qNFXqkvb/itUuPZnYJTygWkNuhYr2Usdbfts=
X-Received: by 2002:a17:907:3d91:b0:b3f:f43d:f81e with SMTP id
 a640c23a62f3a-b50ac0cc027mr3233214166b.40.1760509477753; Tue, 14 Oct 2025
 23:24:37 -0700 (PDT)
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
 <CACePvbVEGgtTqkMPqsf69C7qUD52yVcC56POed8Pdt674Pn68A@mail.gmail.com> <CACePvbWu0P+8Sv-sS7AnG+ESdnJdnFE_teC9NF9Rkn1HegQ9_Q@mail.gmail.com>
In-Reply-To: <CACePvbWu0P+8Sv-sS7AnG+ESdnJdnFE_teC9NF9Rkn1HegQ9_Q@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 15 Oct 2025 14:24:01 +0800
X-Gm-Features: AS18NWA-c-DVGGUWjG-BgLldOVeKrj5tzV3Y865Dq2enhOArH1Y-wIuE0E9YoPg
Message-ID: <CAMgjq7BJcxGzrnr+EeO6_ZC7dAn0_WmWn8DX8gSPfyYiY4S3Ug@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during allocation
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:00=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Tue, Oct 14, 2025 at 2:27=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > On Sun, Oct 12, 2025 at 9:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > > index cb2392ed8e0e..0d1924f6f495 100644
> > > > > --- a/mm/swapfile.c
> > > > > +++ b/mm/swapfile.c
> > > > > @@ -1101,13 +1101,6 @@ static unsigned long cluster_alloc_swap_en=
try(struct swap_info_struct *si, int o
> > > > >                         goto done;
> > > > >         }
> > > > >
> > > > > -       /*
> > > > > -        * We don't have free cluster but have some clusters in d=
iscarding,
> > > > > -        * do discard now and reclaim them.
> > > > > -        */
> > > > > -       if ((si->flags & SWP_PAGE_DISCARD) && swap_do_scheduled_d=
iscard(si))
> > > > > -               goto new_cluster;
> > > >
> > > > Assume you follow my suggestion.
> > > > Change this to some function to detect if there is a pending discar=
d
> > > > on this device. Return to the caller indicating that you need a
> > > > discard for this device that has a pending discard.
> > > > Add an output argument to indicate the discard device "discard" if =
needed.
> > >
> > > The problem I just realized is that, if we just bail out here, we are
> > > forbidding order 0 to steal if there is any discarding cluster. We
> > > just return here to let the caller handle the discard outside
> > > the lock.
> >
> > Oh, yes, there might be a bit of change in behavior. However I can't
> > see it is such a bad thing if we wait for the pending discard to
> > complete before stealing and fragmenting the existing folio list. We
> > will have less fragments compared to the original result. Again, my
> > point is not that we always keep 100% the old behavior, then there is
> > no room for improvement.
> >
> > My point is that, are we doing the best we can in that situation,
> > regardless how unlikely it is.
> >
> > >
> > > It may just discard the cluster just fine, then retry from free clust=
ers.
> > > Then everything is fine, that's the easy part.
> >
> > Ack.
> >
> > > But it might also fail, and interestingly, in the failure case we nee=
d
> >
> > Can you spell out the failure case you have in mind? Do you mean the
> > discard did happen but another thread stole "the recently discarded
> > then became free cluster"?
> >
> > Anyway, in such a case, the swap allocator should continue and find
> > out we don't have things to discard now, it will continue to the
> > "steal from other order > 0 list".
> >
> > > to try again as well. It might fail with a race with another discard,
> > > in that case order 0 steal is still feasible. Or it fail with
> > > get_swap_device_info (we have to release the device to return here),
> > > in that case we should go back to the plist and try other devices.
> >
> > When stealing from the other order >0 list failed, we should try
> > another device in the plist.
> >
> > >
> > > This is doable but seems kind of fragile, we'll have something like
> > > this in the folio_alloc_swap function:
> > >
> > > local_lock(&percpu_swap_cluster.lock);
> > > if (!swap_alloc_fast(&entry, order))
> > >     swap_alloc_slow(&entry, order, &discard_si);
> > > local_unlock(&percpu_swap_cluster.lock);
> > >
> > > +if (discard_si) {
> >
> > I feel the discard logic should be inside the swap_alloc_slow().
> > There is a  plist_for_each_entry_safe(), inside that loop to do the
> > discard and retry().
> > If I previously suggested it change in here, sorry I have changed my
> > mind after reasoning the code a bit more.
>
> Actually now I have given it a bit more thought, one thing I realized
> is that you might need to hold the percpu_swap_cluster lock all the
> time during allocation. That might force you to do the release lock
> and discard in the current position.
>
> If that is the case, then just making the small change in your patch
> to allow hold waiting to discard before trying the fragmentation list
> might be good enough.
>
> Chris
>

Thanks, I was composing a reply on this and just saw your new comment.
I agree with this.

