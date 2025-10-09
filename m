Return-Path: <stable+bounces-183720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B44DDBC9D0E
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD0FC4FC494
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D672116F6;
	Thu,  9 Oct 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1vDTpIy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC112080C0
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023991; cv=none; b=F6j2bddZ/94aShKFFNqKBiE/Iqs40UaIIkJ+4ttHGLoDaN22qJ17xlTpwVdoNSzC8wBPbpZK50JO1TFDB0A9apx6sjQ4I2TkiU3++dwsSrW+zidzADH4G93jM8cuHTLxeoIoVPxlKKQe9kj2zhLnumgGd8uFRNJyAxKEG+K/51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023991; c=relaxed/simple;
	bh=obt4FnXNkPeovqeHQIlynFUT8U3+17TygeXSVfAyhfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjnT+4qDf+s6Xn7P3FRVQ4JFTXGj5UWtrJPrP/+NuCCLfS0xUVfDbrAcx5iCipx3eErMOtkLZapk0BVT5w2H0spVT2apAqJVELiduhsTTkfUNNkMGYMZVp3y8NjCWhAN7dzbEdRW62ydvlzMgyNt+EwJNMWPoxHh1b8XwP+7GOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1vDTpIy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso187487066b.0
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760023988; x=1760628788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+tq4vS4s3Lq+JCSufOXbf2L061em+hD5hZGExKt/ss=;
        b=l1vDTpIyJYjM4X0HvecdYLrOsXViTIVfbpUTFMsnkvNnf7eAW4blibgkVCh2tU8HdS
         sKuiD8wR75YM73x1MmozDJaBzGxN/o2TQNVoWDOqY4FXQogxePtgg5LawBRiP1pH1sQe
         ogTvZZboyWtZzoAZ3zQ7juEBeu2uBBoxB/VOLESSHGlB53h6Hc7sDRr9DZ8q3/HPEnZi
         84k/9DJKsDQY2V3uyUbZK2pgZugM11DzGsaHJITP1qzlVhSr6cNu/zAuphedK/49LCX8
         QJ2JIYQz7rhR8xk04iBGUyVfpwJgWE6GqqSlAkhFyL0mXkEsOaK5W41073DY/l3QYSMn
         a0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023988; x=1760628788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+tq4vS4s3Lq+JCSufOXbf2L061em+hD5hZGExKt/ss=;
        b=kbcIi0R91FHPeEDl0xOVx7BinatEenUf1LCGD+maiMWTBHcz6F0qnb7ETAWfR40Lxd
         d1H2hUYt504lLQc9oUam0kJl4M1Gjp/7P1SSxvH0T4w3ZVfc2yz9nocow2TMOG4ujYaj
         uvZGFAuJwM3z1hAviKRH+UB/gOs793mJdmdiF//rasSORvLnhULV/eAd+eV4YSJ1+B7S
         SmeIVXtqNxwd1X8Jqn81f5w4k8IOjOwq3d6WGl1fERGtb22Nmx5ayNSasGPz+ChLB7tq
         C1WZspKgNtRS0+NPfT8XJNc3CMGdVuH1CM0j6HS0jObaEWQBmz2rf9bMk90bTHd8rbsK
         SO3A==
X-Forwarded-Encrypted: i=1; AJvYcCVX2hnhy6lu7CubIUB1nzwgf9bgaucK5qAw86tSroHV1Na1P70+WYk/IVnqZivKkkDcy46mf/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6G3pYCGHRRmk5onaNWgy093q7lUj6EQq2OLv0ZJ5y3CpkMkn1
	X5gTq1htALGnxA3OCmtQBj626UUZ5xMCwwRK28qOTlf6QOcfhDFJVX5+K3jhTKwIoisKyeRkyzN
	gW/c5pVvhkYunQ4AXOLTucoF5P6rfHqs=
X-Gm-Gg: ASbGncsJZULUNa8sC/7VYDT3mTB8TSuB90F+2XKY7uKlxYFhEuwe5gZIc3YFHDJMZL9
	xoCDUomIv2c10JJWSSYBPeGVJgxEWA47wRXBn8dgGvC8ieaYWIGPWw4rwDiNdmg6q67lvvNDkmI
	Yiknc0bQq006r/5Pza+fScyXSFp655KH01RgLRmOAtpOb0gT7C+WW5+4yoaasr5nffP9PFzO352
	ek5wfvqjhjScQzz+Nb56WZK1BhI2BFDmQWkuGNK3A==
X-Google-Smtp-Source: AGHT+IGZB3OdGaKCHbOLV1DjRJE8Flzw9YSn53yJb0TkxYagYC0ihlYs/QmM4gJfLp9P7lvCgppolc6V05mnvXvmf2I=
X-Received: by 2002:a17:906:f586:b0:b3d:530:9f07 with SMTP id
 a640c23a62f3a-b50aa792c58mr944665466b.11.1760023987419; Thu, 09 Oct 2025
 08:33:07 -0700 (PDT)
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
Date: Thu, 9 Oct 2025 23:32:31 +0800
X-Gm-Features: AS18NWCz5oAVWaFi3azMcyhuHXSD7tuBuaq6EfLkmRkR7yYb5BRE-j4_8-wITIk
Message-ID: <CAMgjq7BE_TsmykMQvLMAEheCwgepQMb-X__TG-H7+CUVP3ttYg@mail.gmail.com>
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

Thanks for the suggestion. Right, that sounds even better. My initial
though was that maybe we can just remove this discard completely since
it rarely helps, and if the SSD is really that slow, OOM under heavy
pressure might even be an acceptable behaviour. But to make it safer,
I made it do discard only when order 0 is failing so the code is
simpler.

Let me sent a V2 to handle the discard carefully to reduce potential impact=
.

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

Checking `!list_empty(si->discard_clusters)` should be good enough.

