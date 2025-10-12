Return-Path: <stable+bounces-184117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C07BD07EE
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 18:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87C43B462F
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51A2EC547;
	Sun, 12 Oct 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg32WJQJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95F139D0A
	for <stable@vger.kernel.org>; Sun, 12 Oct 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760287782; cv=none; b=K9LJ82/ctKQXvnsvgGZit+Vbr2d7tcKLw9lBgEfh97iUHEu9Tz6SV0zrwjHdPX5P2tjjkqe5mM4iksyNn2rT5fHSkaI+N+Fgx67gxBDKGrJC0VlSAtGrUWiBpE2wKK0LcF/JCAwd+NvvSn9fwWKrAo68cxWulHiSJJynegI/AoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760287782; c=relaxed/simple;
	bh=tiWfYworwbCzMlDp45VXYsASaB3UQxOBPjunH6YFFPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rW2rKvMJmNE1v0rkCfMNcOyWSsSPGd35d5Ea4k3vB690rSVj7OgOb4reJaW50B8olOGU9nwneHgzZglQYHx7dSkmkLQnINdBFQ1y8CTlIzHn+rlDvHuA18EfPcFZd/jeffdwEcoY48nuXxWoWXcKu0Os+tk9HV9Oac/pxXkYQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg32WJQJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso549767966b.0
        for <stable@vger.kernel.org>; Sun, 12 Oct 2025 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760287777; x=1760892577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XOt9pYTGZkZSu2ppNvovLspExBwSC4+Ysww8r0Eiy4=;
        b=Cg32WJQJVNciVdgVVJsRyx3LnNWO7Ik6GRhlCS0qsXRra1jqIiN6LX6NtTve7kNZQv
         EsdawzzSfoLljXrEN6lJlSoXpk52tTfKBphW+cy/SY1JuB++mV+R7Zy5MKq8/2QfULRV
         X98IcaydM3OcWgvN+wCTiA0IDoIwM0SFo0jPQbg8UcggFUWjVzFBoMF4RTg6TS9Z3gs4
         oK0RZi1YCNbJFAvbzNuupfWfCy8GI1NOrx1PHXoDR/dLPOPRHYSWuPrcZ3sxxDVDpbvm
         aEQkq5q5M9lvBgoAdTJuBlPiMP2Mrc4Yg/rkv8K79mLiXaP47K8La5rx1AB9EogvG8ml
         zoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760287777; x=1760892577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XOt9pYTGZkZSu2ppNvovLspExBwSC4+Ysww8r0Eiy4=;
        b=lb/aiGNO8Y3T1CSF+KnwxD2+BiPHV6GaedhtA7EkWW6HHE+ALGjcUuDkS5s1DGycRh
         1/mifVm1vjn7I9AM3lwhy62k61CRfAnHrdqdIFy0EvJ6bWh2vlOvLJT8h4RciBiZ8Qqy
         rHJWDFvq41YHEimXzGcLWtWUh7D+2E8kaCnc89Mn5Gx65/ultSks873k7hZdv/9+nCZi
         k4gRZXvrtgsxugx5W8BDDJMV67BGFPOo3rRRFT4M1zM3+tRxnh/cyM+S9f/8hstHPoEm
         pg+NKZ2QgXLq14IIv/tj339e8O3cFQDEfLw5+8e4LnjWaj0YWVSThgfmbpcYSKi5Vol2
         XAkg==
X-Forwarded-Encrypted: i=1; AJvYcCV3JlU7COF0wVVrGBUQfq3Czsbmg7CxqYO1BW4Xxj+edBhajUbEB9freZgiwWLPZI5EfHHBsGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnQR5hdOBEwXPNCvIUbxWwNVufHHs8TKr5BqT+aOmY1Cs2SK5
	sEv87QYqL6Kb+b0m2FpGf6sQaTgGoTyuMTchS/xEFqmtshp1cq2HIexsuimR4MlawIBjBPVaUVJ
	XbFNl7KCSul+w2s39AC+ymPmSYyZyyupV3tXAa5k=
X-Gm-Gg: ASbGnctObeLJ5w9iEGdbdXW0eZNbZxCdrqigHO/s23nxd2+0wZXIIFcnHyQ1AEcJQdN
	0FZva3c0pBBG5ymLUSyqYoKKvWkEC5wTTAZvcfl0IZgYh5JZrBtZ5csoE5lfxP+okxedX9ww/Fi
	jtxwSrnTcJ1D9zA2GEkgFMfomXa/n124qdtDUc7l2dEgui/X7abUY+oK7EDv+V47vmXhBPwQJvR
	xdxAST9iEiR0Os0IJ4aFizRfIECshZkkQ2+d256w1l4VMQ=
X-Google-Smtp-Source: AGHT+IFTBvuUZZbE9a7cb6P3kpA3ULFLR99Myk3ietqEoRXe6pHxUxt7cTci1SYV2hJKjY+FPJBIPxKpPjiWn+9LOME=
X-Received: by 2002:a17:907:3daa:b0:b45:60ad:daf9 with SMTP id
 a640c23a62f3a-b50a9a6cb4fmr2086829166b.3.1760287776995; Sun, 12 Oct 2025
 09:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com> <CACePvbWs3hFWt0tZc4jbvFN1OXRR5wvNXiMjBBC4871wQjtqMw@mail.gmail.com>
In-Reply-To: <CACePvbWs3hFWt0tZc4jbvFN1OXRR5wvNXiMjBBC4871wQjtqMw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 13 Oct 2025 00:49:00 +0800
X-Gm-Features: AS18NWCVRaNfz5cs2rL1M42T2Yq0PAar6obsHH9qXEUUMhQYTgqXJVDIsOQCkgM
Message-ID: <CAMgjq7BD6SOgALj2jv2SVtNjWLJpT=1UhuaL=qxvDCMKUy68Hw@mail.gmail.com>
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

On Thu, Oct 9, 2025 at 5:10=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Kairui,
>
> First of all, your title is a bit misleading:
> "do not perform synchronous discard during allocation"
>
> You still do the synchronous discard, just limited to order 0 failing.
>
> Also your commit did not describe the behavior change of this patch.
> The behavior change is that, it now prefers to allocate from the
> fragment list before waiting for the discard. Which I feel is not
> justified.
>
> After reading your patch, I feel that you still do the synchronous
> discard, just now you do it with less lock held.
> I suggest you just fix the lock held issue without changing the
> discard ordering behavior.
>
> On Mon, Oct 6, 2025 at 1:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Since commit 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation
> > fast path"), swap allocation is protected by a local lock, which means
> > we can't do any sleeping calls during allocation.
> >
> > However, the discard routine is not taken well care of. When the swap
> > allocator failed to find any usable cluster, it would look at the
> > pending discard cluster and try to issue some blocking discards. It may
> > not necessarily sleep, but the cond_resched at the bio layer indicates
> > this is wrong when combined with a local lock. And the bio GFP flag use=
d
> > for discard bio is also wrong (not atomic).
>
> If lock is the issue, let's fix the lock issue.
>
> > It's arguable whether this synchronous discard is helpful at all. In
> > most cases, the async discard is good enough. And the swap allocator is
> > doing very differently at organizing the clusters since the recent
> > change, so it is very rare to see discard clusters piling up.
>
> Very rare does not mean this never happens. If you have a cluster on
> the discarding queue, I think it is better to wait for the discard to
> complete before using the fragmented list, to reduce the
> fragmentation. So it seems the real issue is holding a lock while
> doing the block discard?
>
> > So far, no issues have been observed or reported with typical SSD setup=
s
> > under months of high pressure. This issue was found during my code
> > review. But by hacking the kernel a bit: adding a mdelay(100) in the
> > async discard path, this issue will be observable with WARNING triggere=
d
> > by the wrong GFP and cond_resched in the bio layer.
>
> I think that makes an assumption on how slow the SSD discard is. Some
> SSD can be really slow. We want our kernel to work for those slow
> discard SSD cases as well.
>
> > So let's fix this issue in a safe way: remove the synchronous discard i=
n
> > the swap allocation path. And when order 0 is failing with all cluster
> > list drained on all swap devices, try to do a discard following the swa=
p
>
> I don't feel that changing the discard behavior is justified here, the
> real fix is discarding with less lock held. Am I missing something?
> If I understand correctly, we should be able to keep the current
> discard ordering behavior, discard before the fragment list. But with
> less lock held as your current patch does.
>
> I suggest the allocation here detects there is a discard pending and
> running out of free blocks. Return there and indicate the need to
> discard. The caller performs the discard without holding the lock,
> similar to what you do with the order =3D=3D 0 case.
>
> > device priority list. If any discards released some cluster, try the
> > allocation again. This way, we can still avoid OOM due to swap failure
> > if the hardware is very slow and memory pressure is extremely high.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation fast =
path")
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swapfile.c | 40 +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 33 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index cb2392ed8e0e..0d1924f6f495 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1101,13 +1101,6 @@ static unsigned long cluster_alloc_swap_entry(st=
ruct swap_info_struct *si, int o
> >                         goto done;
> >         }
> >
> > -       /*
> > -        * We don't have free cluster but have some clusters in discard=
ing,
> > -        * do discard now and reclaim them.
> > -        */
> > -       if ((si->flags & SWP_PAGE_DISCARD) && swap_do_scheduled_discard=
(si))
> > -               goto new_cluster;
>
> Assume you follow my suggestion.
> Change this to some function to detect if there is a pending discard
> on this device. Return to the caller indicating that you need a
> discard for this device that has a pending discard.
> Add an output argument to indicate the discard device "discard" if needed=
.

The problem I just realized is that, if we just bail out here, we are
forbidding order 0 to steal if there is any discarding cluster. We
just return here to let the caller handle the discard outside
the lock.

It may just discard the cluster just fine, then retry from free clusters.
Then everything is fine, that's the easy part.

But it might also fail, and interestingly, in the failure case we need
to try again as well. It might fail with a race with another discard,
in that case order 0 steal is still feasible. Or it fail with
get_swap_device_info (we have to release the device to return here),
in that case we should go back to the plist and try other devices.

This is doable but seems kind of fragile, we'll have something like
this in the folio_alloc_swap function:

local_lock(&percpu_swap_cluster.lock);
if (!swap_alloc_fast(&entry, order))
    swap_alloc_slow(&entry, order, &discard_si);
local_unlock(&percpu_swap_cluster.lock);

+if (discard_si) {
+    if (get_swap_device_info(discard_si)) {
+        swap_do_scheduled_discard(discard_si);
+        put_swap_device(discard_si);
+        /*
+         * Ignoring the return value, since we need to try
+         * again even if the discard failed. If failed due to
+         * race with another discard, we should still try
+         * order 0 steal.
+         */
+    } else {
+        discard_si =3D NULL;
+        /*
+         * If raced with swapoff, we should try again too but
+         * not using the discard device anymore.
+         */
+    }
+    goto again;
+}

And the `again` retry we'll have to always start from free_clusters again,
unless we have another parameter just to indicate that we want to skip
everything and jump to stealing, or pass and reuse the discard_si
pointer as return argument to cluster_alloc_swap_entry as well,
as the indicator to jump to stealing directly.

It looks kind of strange. So far swap_do_scheduled_discard can only
fail due to a race with another successful discard, so retrying is
safe and won't run into an endless loop. But it seems easy to break,
e.g. if we may handle bio alloc failure of discard request in the
future. And trying again if get_swap_device_info failed makes no sense
if there is only one device, but has to be done here to cover
multi-device usage, or we have to add more special checks.

swap_alloc_slow will be a bit longer too if we want to prevent
touching plist again:
+/*
+ * Resuming after trying to discard cluster on a swap device,
+ * try the discarded device first.
+ */
+si =3D *discard_si;
+if (unlikely(si)) {
+    *discard_si =3D NULL;
+    if (get_swap_device_info(si)) {
+        offset =3D cluster_alloc_swap_entry(si, order, SWAP_HAS_CACHE,
&need_discard);
+        put_swap_device(si);
+        if (offset) {
+            *entry =3D swp_entry(si->type, offset);
+            return true;
+        }
+        if (need_discard) {
+            *discard_si =3D si;
+            return false;
+        }
+    }
+}

The logic of the workflow jumping between several functions might also
be kind of hard to follow. Some cleanup can be done later though.

Considering the discard issue is really rare, I'm not sure if this is
the right way to go? How do you think?

BTW: The logic of V1 can be optimized a little bit to let discards also
happen with order > 0 cases too. That seems closer to what the current
upstream kernel was doing except: Allocator prefers to try another
device instead of waiting for discard, which seems OK?
And order 0 steal can happen without waiting for discard.
Fragmentation under extreme pressure might not be that
serious an issue if we are having really slow SSDs, and
might even be no longer an issue if we have a generic
solution for frags?

