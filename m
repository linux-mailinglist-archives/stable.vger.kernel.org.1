Return-Path: <stable+bounces-188312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5A6BF5550
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 10:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 378C04F0434
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0288131DD82;
	Tue, 21 Oct 2025 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z53CMqdG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D497483
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036315; cv=none; b=F+4gqv8OsxhfvfUFprC9KqjDI9rOLox4Z6EbmqJOqIgwB4Eh/WN77NvvRwjFXN8Fk0Ig4xjm/K/W4hq6n/r5zlX8HHF6kIQ+MkFwMeUxlvaJcbUxheEQKKzlRoxMU3Ng3LN4mAr0vVkBW+lYxrknaLbNH/EuVkYm2IuAg32fI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036315; c=relaxed/simple;
	bh=4rVRFs9FmimwX4eazcUDzQwtDTvW9JW6nYc7nuhXJEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+LZ1rFSOb6Qvo4jYPNjWF/E550WeHoBP2/+f60YdmpX5sWpMALlURh87Kknvw3QhYKnWc4H3/5Evnul7mWsWw9XY9wPQuCfLxV+63xQRNJXIVkI26tfodQSWBurCw298NjpvqlTsQ87s48GxBloCxYCsiLCMwntrSWc3SJ6GkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z53CMqdG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso7952577a12.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761036312; x=1761641112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEc/XUPAfFsPjKe3axuLcNBbK/tw4kRowPq6sCBVSU0=;
        b=Z53CMqdGKJd1nnZuySYNFXiUbQZxr62BP5MQdi/iVWfxLa86GIJy3CecUGd5FgD5Bl
         T5hgrg3Oxje2cROFCxZYNnC3vYE1Eu+x9T9owLZH03xuJPZvPPD1dtfwIhoq1tnFT7Dr
         5KQe/+OdP3MdYGoQucUvO6L766WHxAvRgSlaMKUhq5cfSE3tPXTygbOT8fkAe6hyF3x0
         MH2PUCIp97Ik7vElBszNSUVoK4/AbiB+mojPTYCYIg3y6jPWff0nUwbE1OcpDrIE0kCo
         digvg34a0XvS6KuT1VGplvqPc2/qBs4XgVD+hfm/VebxRW8+Kl7ANQUTnbia7kwbH6rE
         57Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036312; x=1761641112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEc/XUPAfFsPjKe3axuLcNBbK/tw4kRowPq6sCBVSU0=;
        b=NW9DAxnGu4In58mtQZyyQklaRd9sXrsfWGJYEQ9SmL3mMx4qzzXBp+MijgKpqzZgpZ
         q5Fv9K0QEzB5Oyoi+Z4sDTibuBgm7S+vBcOlB3/5FnVrAw4avaKeLTUaEdJ25/r/RWaJ
         Pq7ZWZg3uHm5JDOLzDIepHQmreQuocj7u8+nqswCyt2iFRR56Gyszyq0NUcZoVK/8Z6/
         TOhvmeLhYJrq8leUTxf3TA6mKuVxD9zaRT3mOpnXXrWH/R880HUzrhF03oMm123HKSM7
         xxtBVGqAwilhaleHuwov3o3wBENCMgqqpUVZ+OD3hWRoSoFm5gbROpR6H/k0JMv5w33s
         i4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/dmZ6OETGRbvlRmI/VIPbilI6e+TAFQfZQxVb+tCsk3EsYJi6JIO95OGLwcRpO4DvUlYMlP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIoXYlW2Wi3qHLQ/S0MuXDKPxJQHSOC+R3pqi7IbtDbi9XS/M
	nHqI5P2xACIrZiRSFIaen8xFkJM+YOOmc14P5Es2BIvoFcfg1/k9X5NFv6w4YaBKMO6/qO9NnWr
	+SD3yrWZiekwTf6UQzW8IMBcrSKDbse8=
X-Gm-Gg: ASbGncvEObb29TeCzrAOfC1nokAcKpn/705cS6WC9DV/H/PbaLeh0NA/LTijCET7M0c
	7QCBTUjUASNy8oEesP5UKNiYXx4uwJv6yhoW0o8U/FtML8Nu2Snhk6He+ty2UVJ/jt7SZNVs2Un
	2E3kxq/d31hEeaOqLOxQyeHFbuq1IEw26UUiJ7nR22ZcWT8WaJalFsgVtIfD1MvLPP3r/y7dAoK
	OqGdxCn+hBiqbC1AyiPlyU4qJ+A9SvWvzrW2BIUlCnBcx8BgNob9PqNrKVR
X-Google-Smtp-Source: AGHT+IGpNO2ZXaI/t+BJlY5E7XeayvBSN+u9HLM7rBt8OJlH05DE1Vd2yvSxHyFby5fD4qXdINnUHIZKxtpDi5wteKw=
X-Received: by 2002:a05:6402:2552:b0:63b:f59b:e607 with SMTP id
 4fb4d7f45d1cf-63c1f6364demr15217927a12.2.1761036311803; Tue, 21 Oct 2025
 01:45:11 -0700 (PDT)
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
 <CAMgjq7BJcxGzrnr+EeO6_ZC7dAn0_WmWn8DX8gSPfyYiY4S3Ug@mail.gmail.com>
 <CAMgjq7CsYhEjvtN85XGkrONYAJxve7gG593TFeOGV-oax++kWA@mail.gmail.com> <CACePvbWn1pAJg8xGfJFrWxpkJDakJA0GfgJc0W80EUYS6YhBAg@mail.gmail.com>
In-Reply-To: <CACePvbWn1pAJg8xGfJFrWxpkJDakJA0GfgJc0W80EUYS6YhBAg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 21 Oct 2025 16:44:35 +0800
X-Gm-Features: AS18NWDkIvCbn6oryOwYrnXEjtMybnk1XdF-2GkljB37F_uuXBAS4pUVPyIhdOE
Message-ID: <CAMgjq7DT13YwgFvGHPAn7ibb5E6XQDRf0P1XoFjz24ekF11C4g@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during allocation
To: Chris Li <chrisl@kernel.org>
Cc: YoungJun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:05=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Wed, Oct 15, 2025 at 9:46=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Wed, Oct 15, 2025 at 2:24=E2=80=AFPM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Wed, Oct 15, 2025 at 12:00=E2=80=AFPM Chris Li <chrisl@kernel.org>=
 wrote:
> > > >
> > > > On Tue, Oct 14, 2025 at 2:27=E2=80=AFPM Chris Li <chrisl@kernel.org=
> wrote:
> > > > >
> > > > > On Sun, Oct 12, 2025 at 9:49=E2=80=AFAM Kairui Song <ryncsn@gmail=
.com> wrote:
> > > > > > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > > > > > index cb2392ed8e0e..0d1924f6f495 100644
> > > > > > > > --- a/mm/swapfile.c
> > > > > > > > +++ b/mm/swapfile.c
> > > > > > > > @@ -1101,13 +1101,6 @@ static unsigned long cluster_alloc_s=
wap_entry(struct swap_info_struct *si, int o
> > > > > > > >                         goto done;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -       /*
> > > > > > > > -        * We don't have free cluster but have some cluster=
s in discarding,
> > > > > > > > -        * do discard now and reclaim them.
> > > > > > > > -        */
> > > > > > > > -       if ((si->flags & SWP_PAGE_DISCARD) && swap_do_sched=
uled_discard(si))
> > > > > > > > -               goto new_cluster;
> > > > > > >
> > > > > > > Assume you follow my suggestion.
> > > > > > > Change this to some function to detect if there is a pending =
discard
> > > > > > > on this device. Return to the caller indicating that you need=
 a
> > > > > > > discard for this device that has a pending discard.
> > > > > > > Add an output argument to indicate the discard device "discar=
d" if needed.
> > > > > >
> > > > > > The problem I just realized is that, if we just bail out here, =
we are
> > > > > > forbidding order 0 to steal if there is any discarding cluster.=
 We
> > > > > > just return here to let the caller handle the discard outside
> > > > > > the lock.
> > > > >
> > > > > Oh, yes, there might be a bit of change in behavior. However I ca=
n't
> > > > > see it is such a bad thing if we wait for the pending discard to
> > > > > complete before stealing and fragmenting the existing folio list.=
 We
> > > > > will have less fragments compared to the original result. Again, =
my
> > > > > point is not that we always keep 100% the old behavior, then ther=
e is
> > > > > no room for improvement.
> > > > >
> > > > > My point is that, are we doing the best we can in that situation,
> > > > > regardless how unlikely it is.
> > > > >
> > > > > >
> > > > > > It may just discard the cluster just fine, then retry from free=
 clusters.
> > > > > > Then everything is fine, that's the easy part.
> > > > >
> > > > > Ack.
> > > > >
> > > > > > But it might also fail, and interestingly, in the failure case =
we need
> > > > >
> > > > > Can you spell out the failure case you have in mind? Do you mean =
the
> > > > > discard did happen but another thread stole "the recently discard=
ed
> > > > > then became free cluster"?
> > > > >
> > > > > Anyway, in such a case, the swap allocator should continue and fi=
nd
> > > > > out we don't have things to discard now, it will continue to the
> > > > > "steal from other order > 0 list".
> > > > >
> > > > > > to try again as well. It might fail with a race with another di=
scard,
> > > > > > in that case order 0 steal is still feasible. Or it fail with
> > > > > > get_swap_device_info (we have to release the device to return h=
ere),
> > > > > > in that case we should go back to the plist and try other devic=
es.
> > > > >
> > > > > When stealing from the other order >0 list failed, we should try
> > > > > another device in the plist.
> > > > >
> > > > > >
> > > > > > This is doable but seems kind of fragile, we'll have something =
like
> > > > > > this in the folio_alloc_swap function:
> > > > > >
> > > > > > local_lock(&percpu_swap_cluster.lock);
> > > > > > if (!swap_alloc_fast(&entry, order))
> > > > > >     swap_alloc_slow(&entry, order, &discard_si);
> > > > > > local_unlock(&percpu_swap_cluster.lock);
> > > > > >
> > > > > > +if (discard_si) {
> > > > >
> > > > > I feel the discard logic should be inside the swap_alloc_slow().
> > > > > There is a  plist_for_each_entry_safe(), inside that loop to do t=
he
> > > > > discard and retry().
> > > > > If I previously suggested it change in here, sorry I have changed=
 my
> > > > > mind after reasoning the code a bit more.
> > > >
> > > > Actually now I have given it a bit more thought, one thing I realiz=
ed
> > > > is that you might need to hold the percpu_swap_cluster lock all the
> > > > time during allocation. That might force you to do the release lock
> > > > and discard in the current position.
> > > >
> > > > If that is the case, then just making the small change in your patc=
h
> > > > to allow hold waiting to discard before trying the fragmentation li=
st
> > > > might be good enough.
> > > >
> > > > Chris
> > > >
> > >
> > > Thanks, I was composing a reply on this and just saw your new comment=
.
> > > I agree with this.
> >
> > Hmm, it turns out modifying V1 to handle non-order 0 allocation
> > failure also has some minor issues. Every mTHP SWAP allocation failure
> > will have a slight higher overhead due to the discard check. V1 is
> > fine since it only checks discard for order 0, and order 0 alloc
> > failure is uncommon and usually means OOM already.
> >
> > I'm not saying V1 is the final solution, but I think maybe we can just
> > keep V1 as it is? That's easier for a stable backport too, and this is
>
> I am fine with that, assuming you need to adjust the presentation to
> push V1 as hotfix. I can ack your newer  patch to adjust the
> presentation.

Thanks, I'll update it then.

> > doing far better than what it was like. The sync discard was added in
> > 2013 and the later added percpu cluster at the same year never treated
> > it carefully. And the discard during allocation after recent swap
> > allocator rework has been kind of broken for a while.
> >
> > To optimize it further in a clean way, we have to reverse the
> > allocator's handling order of the plist and fast / slow path. Current
> > order is local_lock -> fast -> slow (plist).
>
> I like that. I think that is the eventual way to go. I want to see how
> it integrates with the swap.tiers patches. If you let me pick, I would
> go straight with this one for 6.19.
>
> >
> > We can walk the plist first, then do the fast / slow path: plist (or
> > maybe something faster than plist but handles the priority) ->
> > local_lock -> fast -> slow (bonus: this is more friendly to RT kernels
> > too I think). That way we don't need to rewalk the plist after
> > releasing the local_lock and save a lot of trouble. I remember I
> > discussed with Youngjun on this sometime ago in the mail list, I know
> > things have changed a lot but some ideas seems are still similar. I
> > think his series is moving the percpu cluster into each device (si),
> > we can also move the local_lock there, which is just what I'm talking
> > about here.
>
> Ack. We will need to see both patches to figure out how to integrate
> them together. Right now we have two moving parts. More to the point
> that we get the eventual patch sooner.

BTW I found there are some minor cleanups needed, mostly trivial, I'll
include them in the next update I think.

