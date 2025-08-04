Return-Path: <stable+bounces-166490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02002B1A54F
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 16:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D838165462
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25D2046BA;
	Mon,  4 Aug 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmPup1XK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5511FDE31
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319358; cv=none; b=jlWjyXdnMbIqGKy3rLzuyAvn2wi0pioAXpID2dwSoqvizYAgiqDljS3Ol2uR9EYcbUdKsVqAu0zE1zXnz+T6jyohOMkomOHFBc5q0zWhObN1OpMEAvxfz3owZxUYo4U+4f6nCpqfFfRmGtaNj7h6o718l/W3/PNVQ5XZ+330HlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319358; c=relaxed/simple;
	bh=MU/At4DK4O7Eqe4Gm1IsBTZyC0dP2FL8wFYwMfsruUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl3UH8nQlu1lLJOm/16A/nS1LDFIeRMdJIIgiKPKjmdYQV6FfxTrKr9AVQjE3RJ4evESu/x5tBA5XVwwlTm/aKf1hc9CqU2HH33iYmcYNcuZQB3s2Nk7jxR5zUUMiZGmzls69R0/t1NJhQI/VvwNYpIyf7xw7WVdAcwOC/qHNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmPup1XK; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0673b0a7cso496041cf.0
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754319354; x=1754924154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+o4Ch4o9Xv3jFhugflhfWPbhl3HCtAtjAIB2DUrZ25A=;
        b=OmPup1XKdVlKWkxJmxdBzGMYn1JenVou6VIE5e+ZTO1ab/ItmGUuj1G5dwR9TWkMrn
         zBczfGNMl6Eo+n2j5XW1UZI/t1/RKKmnz/ro212cI0PtfsHoaHNE5C+I63Bqx5KL07gB
         o639XXevauEqKowRaBO3mAC2L8Ed14MEN4MwNEXvF2i+EeDAAWSiAcJ80yViH1Ew8NT7
         2X4iTFaTgf2mT4tFBIsX9Pzqp3I5t69zBynBAl9TFgXnNPJHBba9e2YY8/Ov+AJGtOy5
         /y4pAzMcByto50YEQkXdNjWmwxgrq6/Kgw5va8IIEvfu7LUJTic3YpT7nkDOZ3BsncQ3
         sOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319354; x=1754924154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+o4Ch4o9Xv3jFhugflhfWPbhl3HCtAtjAIB2DUrZ25A=;
        b=gg7K4UBYxI4YtVTyvIEzb+v5uw1rvXY/+9Qr/TBo4xZaU22jv3HQdE3R7n4icVAgI2
         aUWgSe2c+G0duliHFBHEJIpCReyutjJBTMbTftS8piIW1l7x8pf5nncYVZNaNqeb+Hik
         U++0BaN0onOIByk/6JUB1wuVAv9gPzBBTwdaMpHm0WE9KxkEqcoJyPJ8wzcZjkikt1B7
         UVdNlvUm8BNzRyETdnMpQBNgxpxMC4lBrlXyRyi9nfDQ9VEhw8ORbhvwbXinABuNNQ5g
         zDLuh6x9jS0G3fvpaL6xBnC9zgIYZRibGOZKt0gN0PtaWlbFoD+85RFGl2Hm2ZVv4PLi
         /4vg==
X-Forwarded-Encrypted: i=1; AJvYcCW5FC3Dnm9F1mfK/Kd3RaOxzU17aK7Y2VjGC5eceSgJd05ziGsJZ9PK2SjWGenjqJKifAapONA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEix3hJCNEzbPbR/lVS/+DEvp2kvOpNQrRz8grsgLksWsQ/6sn
	wNFUQ1Yhy5nupuhzplYNXpxIL0ORaE3moyQ5/viX4jHn9YSgaxVOPdCkoEQXzaJNJsrUNU46i5C
	EJIoDaE0/agRNnQHhzwNHIpbGhD5zaxhtp4DhOU1xDKc7pyx6bM488E/mtgI=
X-Gm-Gg: ASbGncs/IQ3RAsieOAe/sz+3l//H7Ny6Ne2mxCAkchtHQw2mnP0J981U/9/0+NJAF4I
	BM/cGpxl57xmLKOVlSwQAb2Kr5BOavesA45dncpX29HVPgPTBZ7wVIjB9RQuWARgkuE9pa6L89+
	PnOI7/dUSBTfjnFAGxPwIN1AQLXsxLklvGagAMRl8MW5Ey5GOdyYUZLfFS6PcYRSxrXn3x0UmcR
	v1nuw==
X-Google-Smtp-Source: AGHT+IFKQssWn3qgvBXRZt7wMF56KFZCHc+HFV9s6XYM81Jbizj7eogrXqsiKY3AhtiRnWHFCi1n05HdZ058bfjQ8PU=
X-Received: by 2002:ac8:5d49:0:b0:4a9:e17a:6288 with SMTP id
 d75a77b69052e-4af164545a3mr11164561cf.13.1754319353286; Mon, 04 Aug 2025
 07:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154442.319568-1-surenb@google.com> <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local> <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local> <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
 <aIz1xrzBc2Spa2OH@x1.local> <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
 <aI0Ffc9WXeU2X71O@x1.local> <CAJuCfpFSY3fDH36dabS=nGzasZJ6FtQ_jv79eFWVZrEWRMMTiQ@mail.gmail.com>
 <aI1ckD3KhNvoMtlv@x1.local>
In-Reply-To: <aI1ckD3KhNvoMtlv@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 4 Aug 2025 07:55:42 -0700
X-Gm-Features: Ac12FXwkRUWkV-jJnrAxc_KCFlt2tCP7J8Se807K09k1g_kAOLYNYQ8rg9aNU7I
Message-ID: <CAJuCfpHcScutgGi3imYTJVXBqs=jcqZ5CkKKe=sfVHjUg0Y6RQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 5:32=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Aug 01, 2025 at 07:30:02PM +0000, Suren Baghdasaryan wrote:
> > On Fri, Aug 1, 2025 at 6:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Fri, Aug 01, 2025 at 05:45:10PM +0000, Suren Baghdasaryan wrote:
> > > > On Fri, Aug 1, 2025 at 5:13=E2=80=AFPM Peter Xu <peterx@redhat.com>=
 wrote:
> > > > >
> > > > > On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > On Fri, Aug 1, 2025 at 9:23=E2=80=AFAM Peter Xu <peterx@redhat.=
com> wrote:
> > > > > > >
> > > > > > > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan =
wrote:
> > > > > > > > On Fri, Aug 1, 2025 at 7:16=E2=80=AFAM Peter Xu <peterx@red=
hat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbra=
nd wrote:
> > > > > > > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > > > > > > >
> > > > > > > > > > Hi!
> > > > > > > > > >
> > > > > > > > > > Did you mean in you patch description:
> > > > > > > > > >
> > > > > > > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-=
present PMDs"
> > > > > > > > > >
> > > > > > > > > > Talking about THP holes is very very confusing.
> > > > > > > > > >
> > > > > > > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_=
SRC_HOLES and it
> > > > > > > > > > > encounters a non-present THP, it fails to properly re=
cognize an unmapped
> > > > > > > > > >
> > > > > > > > > > You mean a "non-present PMD that is not a migration ent=
ry".
> > > > > > > > > >
> > > > > > > > > > > hole and tries to access a non-existent folio, result=
ing in
> > > > > > > > > > > a crash. Add a check to skip non-present THPs.
> > > > > > > > > >
> > > > > > > > > > That makes sense. The code we have after this patch is =
rather complicated
> > > > > > > > > > and hard to read.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.ap=
pspotmail.com
> > > > > > > > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220=
.693ce.0050.GAE@google.com/
> > > > > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > > ---
> > > > > > > > > > > Changes since v1 [1]
> > > > > > > > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > > > > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_=
HOLES, per Lokesh Gidra
> > > > > > > > > > >
> > > > > > > > > > > [1] https://lore.kernel.org/all/20250730170733.382926=
7-1-surenb@google.com/
> > > > > > > > > > >
> > > > > > > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++=
----------------
> > > > > > > > > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > > > > > > --- a/mm/userfaultfd.c
> > > > > > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct use=
rfaultfd_ctx *ctx, unsigned long dst_start,
> > > > > > > > > > >             ptl =3D pmd_trans_huge_lock(src_pmd, src_=
vma);
> > > > > > > > > > >             if (ptl) {
> > > > > > > > > > > -                   /* Check if we can move the pmd w=
ithout splitting it. */
> > > > > > > > > > > -                   if (move_splits_huge_pmd(dst_addr=
, src_addr, src_start + len) ||
> > > > > > > > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > > > > > > > -                           struct folio *folio =3D p=
md_folio(*src_pmd);
> > > > > > > > > > > +                   if (pmd_present(*src_pmd) || is_p=
md_migration_entry(*src_pmd)) {
> > > > > > > > >
> > > > > > > > > [1]
> > > > > > > > >
> > > > > > > > > > > +                           /* Check if we can move t=
he pmd without splitting it. */
> > > > > > > > > > > +                           if (move_splits_huge_pmd(=
dst_addr, src_addr, src_start + len) ||
> > > > > > > > > > > +                               !pmd_none(dst_pmdval)=
) {
> > > > > > > > > > > +                                   if (pmd_present(*=
src_pmd)) {
> > > > > > >
> > > > > > > [2]
> > > > > > >
> > > > > > > > > > > +                                           struct fo=
lio *folio =3D pmd_folio(*src_pmd);
> > > > > > >
> > > > > > > [3]
> > > > > > >
> > > > > > > > > > > +
> > > > > > > > > > > +                                           if (!foli=
o || (!is_huge_zero_folio(folio) &&
> > > > > > > > > > > +                                                    =
      !PageAnonExclusive(&folio->page))) {
> > > > > > > > > > > +                                                   s=
pin_unlock(ptl);
> > > > > > > > > > > +                                                   e=
rr =3D -EBUSY;
> > > > > > > > > > > +                                                   b=
reak;
> > > > > > > > > > > +                                           }
> > > > > > > > > > > +                                   }
> > > > > > > > > >
> > > > > > > > > > ... in particular that. Is there some way to make this =
code simpler / easier
> > > > > > > > > > to read? Like moving that whole last folio-check thingy=
 into a helper?
> > > > > > > > >
> > > > > > > > > One question might be relevant is, whether the check abov=
e [1] can be
> > > > > > > > > dropped.
> > > > > > > > >
> > > > > > > > > The thing is __pmd_trans_huge_lock() does double check th=
e pmd to be !none
> > > > > > > > > before returning the ptl.  I didn't follow closely on the=
 recent changes on
> > > > > > > > > mm side on possible new pmd swap entries, if migration is=
 the only possible
> > > > > > > > > one then it looks like [1] can be avoided.
> > > > > > > >
> > > > > > > > Hi Peter,
> > > > > > > > is_swap_pmd() check in __pmd_trans_huge_lock() allows for (=
!pmd_none()
> > > > > > > > && !pmd_present()) PMD to pass and that's when this crash i=
s hit.
> > > > > > >
> > > > > > > First for all, thanks for looking into the issue with Lokesh;=
 I am still
> > > > > > > catching up with emails after taking weeks off.
> > > > > > >
> > > > > > > I didn't yet read into the syzbot report, but I thought the b=
ug was about
> > > > > > > referencing the folio on top of a swap entry after reading yo=
ur current
> > > > > > > patch, which has:
> > > > > > >
> > > > > > >         if (move_splits_huge_pmd(dst_addr, src_addr, src_star=
t + len) ||
> > > > > > >             !pmd_none(dst_pmdval)) {
> > > > > > >                 struct folio *folio =3D pmd_folio(*src_pmd); =
<----
> > > > > > >
> > > > > > > Here looks like *src_pmd can be a migration entry. Is my unde=
rstanding
> > > > > > > correct?
> > > > > >
> > > > > > Correct.
> > > > > >
> > > > > > >
> > > > > > > > If we drop the check at [1] then the path that takes us to
> > > > > > >
> > > > > > > If my above understanding is correct, IMHO it should be [2] a=
bove that
> > > > > > > makes sure the reference won't happen on a swap entry, not ne=
cessarily [1]?
> > > > > >
> > > > > > Yes, in case of migration entry this is what protects us.
> > > > > >
> > > > > > >
> > > > > > > > split_huge_pmd() will bail out inside split_huge_pmd_locked=
() with no
> > > > > > > > indication that split did not happen. Afterwards we will re=
try
> > > > > > >
> > > > > > > So we're talking about the case where it's a swap pmd entry, =
right?
> > > > > >
> > > > > > Hmm, my understanding is that it's being treated as a swap entr=
y but
> > > > > > in reality is not. I thought THPs are always split before they =
get
> > > > > > swapped, no?
> > > > >
> > > > > Yes they should be split, afaiu.
> > > > >
> > > > > >
> > > > > > > Could you elaborate why the split would fail?
> > > > > >
> > > > > > Just looking at the code, split_huge_pmd_locked() checks for
> > > > > > (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> > > > > > pmd_trans_huge() is false if !pmd_present() and it's not a migr=
ation
> > > > > > entry, so __split_huge_pmd_locked() will be skipped.
> > > > >
> > > > > Here might be the major part of where confusion came from: I thou=
ght it
> > > > > must be a migration pmd entry to hit the issue, so it's not?
> > > > >
> > > > > I checked the code just now:
> > > > >
> > > > > __handle_mm_fault:
> > > > >                 if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> > > > >                         VM_BUG_ON(thp_migration_supported() &&
> > > > >                                           !is_pmd_migration_entry=
(vmf.orig_pmd));
> > > > >
> > > > > So IIUC pmd migration entry is still the only possible way to hav=
e a swap
> > > > > entry.  It doesn't look like we have "real" swap entries for PMD =
(which can
> > > > > further points to some swapfiles)?
> > > >
> > > > Correct. AFAIU here we stumble on a pmd entry which was allocated b=
ut
> > > > never populated.
> > >
> > > Do you mean a pmd_none()?
> >
> > Yes.
> >
> > >
> > > If so, that goes back to my original question, on why
> > > __pmd_trans_huge_lock() returns non-NULL if it's a pmd_none()?  IMHO =
it
> > > really should have returned NULL for pmd_none().
> >
> > That was exactly the answer I gave Lokesh when he theorized about the
> > cause of this crash but after reproducing it I saw that
> > pmd_trans_huge_lock() happily returns the PTL as long as PMD is not
> > pmd_none(). And that's because it passes as is_swap_pmd(). But even if
> > we change that we still need to implement the code to skip the entire
> > PMD.
>
> The thing is I thought if pmd_trans_huge_lock() can return non-NULL, it
> must be either a migration entry or a present THP. So are you describing =
a
> THP but with present bit cleared?  Do you know what is that entry, and wh=
y
> it has present bit cleared?

In this case it's because earlier we allocated that PMD here:
https://elixir.bootlin.com/linux/v6.16/source/mm/userfaultfd.c#L1797
but wouldn't that be the same if the PMD was mapped and then got
unmapped later? My understanding is that we allocate the PMD at the
line I pointed to make UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES case the same
as this unmapped PMD case. If my assumption is incorrect then we could
skip the hole earlier instead of allocating the PMD for it.

>
> I think my attention got attracted to pmd migration entry too much, so I
> didn't really notice such possibility, as I believe migration pmd is brok=
en
> already in this path.
>
> The original code:
>
>                 ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
>                 if (ptl) {
>                         /* Check if we can move the pmd without splitting=
 it. */
>                         if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
>                             !pmd_none(dst_pmdval)) {
>                                 struct folio *folio =3D pmd_folio(*src_pm=
d);
>
>                                 if (!folio || (!is_huge_zero_folio(folio)=
 &&
>                                                !PageAnonExclusive(&folio-=
>page))) {
>                                         spin_unlock(ptl);
>                                         err =3D -EBUSY;
>                                         break;
>                                 }
>
>                                 spin_unlock(ptl);
>                                 split_huge_pmd(src_vma, src_pmd, src_addr=
);
>                                 /* The folio will be split by move_pages_=
pte() */
>                                 continue;
>                         }
>
>                         err =3D move_pages_huge_pmd(mm, dst_pmd, src_pmd,
>                                                   dst_pmdval, dst_vma, sr=
c_vma,
>                                                   dst_addr, src_addr);
>                         step_size =3D HPAGE_PMD_SIZE;
>                 } else {
>
> It'll get ptl for a migration pmd, then pmd_folio is risky without checki=
ng
> present bit.  That's what my previous smaller patch wanted to fix.
>
> But besides that, IIUC it's all fine at least for a pmd migration entry,
> because when with the smaller patch applied, either we'll try to split th=
e
> pmd migration entry, or we'll do move_pages_huge_pmd(), which internally
> handles the pmd migration entry too by waiting on it:
>
>         if (!pmd_trans_huge(src_pmdval)) {
>                 spin_unlock(src_ptl);
>                 if (is_pmd_migration_entry(src_pmdval)) {
>                         pmd_migration_entry_wait(mm, &src_pmdval);
>                         return -EAGAIN;
>                 }
>                 return -ENOENT;
>         }
>
> Then logically after the migration entry got recovered, we'll either see =
a
> real THP or pmd none next time.

Yes, for migration entries adding the "if (pmd_present(*src_pmd))"
before getting the folio is enough. The problematic case is
(!pmd_none(*src_pmd) && !pmd_present(*src_pmd)) and not a migration
entry.

>
> Some explanation on the problematic non-present THP entry would be helpfu=
l.
>
> Thanks,
>
> --
> Peter Xu
>

