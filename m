Return-Path: <stable+bounces-67502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7278C95084C
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB3C1C22609
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D613019F495;
	Tue, 13 Aug 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="funkKdZy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1F19B3D3
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561110; cv=none; b=P9yWdIS8fFdMETrUKa29zNv3umNX8N55hXf4zMuIuIAJs0aAFB/c80sCZDlq4he3YxV3x4xdejKUo8j0TAvG/6M1RxigNPz0Zhz3Ngl2DbnyA419q4PTbm5T/BzsKSsM1hAPMLBYI2PcZgaictA3u0UYsqAm5op2FvneGsqEPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561110; c=relaxed/simple;
	bh=L6Olp5UP8QBsMWyJGhbECCr3P6Sz1Ya5nM3gbCxFOdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUSoVgVlRQucr9Ug3f7ZdFbC7VqjeXiTxyOf8DLEe7RYvQmaF2IlsEl4KqFjbRVJvr0dDkUxQ9d5CjKQGSbnP11ZDyu+6I6QdWFIHfiY1ag7R9dH1dOi66wXb8yYBBmBbg7ELvHNo41RQNhOzv25GFO9cU3Mxz0sZoJYWg1ejRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=funkKdZy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so7334a12.1
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723561107; x=1724165907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px8iqdxxWIK7rvwP9ZrwWvLe40dNsz+A9PyUAYGuJmc=;
        b=funkKdZyW/axRM7uP+DiSJ+A67uEWKicojhZSaudI54RaxHvT8YrYuxN3ZAlzUjp/B
         CUzFixTyWlUmy//wOvdYsHe+VYtSdP/p5rmgaYLf/hXYyab2kcUTO1CdSO64jH95Cajw
         ZO9aQaYZUVc93bYYrkTYeLjsD0Ty0gCOmngqGtmcnXAwx502wcKvWFTLMcMDbfWx6BhO
         upnOQlJZm2w3iyxr8Z+yLQzaU8rLCKnUyDUsPi5NwCSTEAERGuf+MbuSPZ+e2ejQiIDc
         8cH+67ZIVX0A54f1fhlRiUJcQ24YVULEXV7AlnpOtqKw+v9w6LJIy8xcaQlvnVOJCQnv
         41pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561107; x=1724165907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px8iqdxxWIK7rvwP9ZrwWvLe40dNsz+A9PyUAYGuJmc=;
        b=IzV1IINl/bE9VXGeOC4b6hfW9jgT3tgKoMH26T704vVpfZB8LYvrEHxVg/6bNp95YX
         i6ooaUys5tR42pG+86qbK9a7Uw9U7v9Z0atVhz/S4P8jWpYnpu0zHnZDldnaYXGcb+oB
         U9ndAJ6rd/S1vN5Dg61+pliOALnc3+kxFQznYVqn/QivzDovVbVXT9KjLO4Jd2dQUcV+
         +M7F1dsRGPn/cAduRRtIzyg/1NSm+/cKAXIqDfuiuQiuKjPlUb7cAPL394iyb5kRybtC
         24jttI0zrwp43BFsL+MJQti78Fp0W2/Zpe2TZeE+QVyfW4BzJKzdJteSdhdm7C3SAaIz
         tzvw==
X-Forwarded-Encrypted: i=1; AJvYcCVouzG/0RB3z2Sv7tmRatTkBJswuqsNhrvo929XtdClBiADYvjpcJdZvcXROE4XzDKRIUcNK8jXN2/NY0zXKp7anm4p7g4J
X-Gm-Message-State: AOJu0YyepMl5jEVbkiytcM9cUUPA+avzTph09AqboiButB2muCDhW2BW
	35RcfGPYand9wqm2re8LoT0php1OpmKm+kehvVPN6Hs23IEjCiXapn9qo3obbmV/2+hf3AZXHpr
	OQXA9SeOZ1iNcA7T7cjlqDi68BWKLjZooTJVz
X-Google-Smtp-Source: AGHT+IGOsd8SzOXCFhPWeyAenAK6WO3rwmgPcyiNCHk3I9lmR9JbamLzSgDR2g8gJ9VBCKK9WwmsBSAZFt+lugxKjpI=
X-Received: by 2002:a05:6402:3493:b0:5b4:df4a:48bb with SMTP id
 4fb4d7f45d1cf-5bd471c09a5mr98555a12.0.1723561106621; Tue, 13 Aug 2024
 07:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
 <20240812-uffd-thp-flip-fix-v1-1-4fc1db7ccdd0@google.com> <59bf3c2e-d58b-41af-ab10-3e631d802229@bytedance.com>
In-Reply-To: <59bf3c2e-d58b-41af-ab10-3e631d802229@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Aug 2024 16:57:48 +0200
Message-ID: <CAG48ez3u4tCaP6MSjxwqZQ70teFJHag7z9wRmd8LJXXee3tTTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] userfaultfd: Fix pmd_trans_huge() recheck race
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pavel Emelianov <xemul@virtuozzo.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
> Hi Jann,
>
> On 2024/8/13 00:42, Jann Horn wrote:
> > The following race can occur:
> >
> >    mfill_atomic                other thread
> >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >                                <zap PMD>
> >    pmdp_get_lockless() [reads none pmd]
> >    <bail if trans_huge>
> >    <if none:>
> >                                <pagefault creates transhuge zeropage>
> >      __pte_alloc [no-op]
> >                                <zap PMD>
> >    <bail if pmd_trans_huge(*dst_pmd)>
> >    BUG_ON(pmd_none(*dst_pmd))
> >
> > I have experimentally verified this in a kernel with extra mdelay() cal=
ls;
> > the BUG_ON(pmd_none(*dst_pmd)) triggers.
> >
> > On kernels newer than commit 0d940a9b270b ("mm/pgtable: allow
> > pte_offset_map[_lock]() to fail"), this can't lead to anything worse th=
an
> > a BUG_ON(), since the page table access helpers are actually designed t=
o
> > deal with page tables concurrently disappearing; but on older kernels
> > (<=3D6.4), I think we could probably theoretically race past the two BU=
G_ON()
> > checks and end up treating a hugepage as a page table.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_=
COPY|UFFDIO_ZEROPAGE preparation")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >   mm/userfaultfd.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index e54e5c8907fa..ec3750467aa5 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -801,7 +801,8 @@ static __always_inline ssize_t mfill_atomic(struct =
userfaultfd_ctx *ctx,
> >                       break;
> >               }
> >               /* If an huge pmd materialized from under us fail */
> > -             if (unlikely(pmd_trans_huge(*dst_pmd))) {
> > +             dst_pmdval =3D pmdp_get_lockless(dst_pmd);
> > +             if (unlikely(pmd_none(dst_pmdval) || pmd_trans_huge(dst_p=
mdval))) {
>
> Before commit 0d940a9b270b, should we also check for
> is_pmd_migration_entry(), pmd_devmap() and pmd_bad() here?

Oooh. I think you're right that this check is insufficient, thanks for
spotting that.

I think I should probably change the check to something like this?

if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
pmd_devmap(dst_pmdval) || pmd_bad(dst_pmdval))) {

!pmd_present() implies !is_pmd_migration_entry(). And the pmd_bad() at
the end shouldn't be necessary if everything is working right, I'm
just tacking it on to be safe.

I'll send a v2 with this change soon.

(Alternatively, pmd_leaf() might be useful here, but then we'd have to
figure an alternate way of doing this for the backport.)

