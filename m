Return-Path: <stable+bounces-166806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E339B1DDC6
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 22:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394A67A8644
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 20:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688722D4FF;
	Thu,  7 Aug 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdh0qANT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9124438B
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597134; cv=none; b=AN5cmAaY1908im7dEk7ZOX+mXxzkuKFEhN1uEyhFP5sjo21LNSudCY0SKkEBFweoBSHEQajUh+89fGG9uNtemAX0P5g2dw08dxCUqgRcef40NTI5jVrGBIJ3KJSIfQcVA0qTfJJsUPNu457b7SG6wevFYsv8+ggUahPZhZ44gsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597134; c=relaxed/simple;
	bh=MDfSuV67bxy4VCH3RN5kuZpDksbMzRVpCl6KwWYKRqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X99B9fR55oHfwo9TjJXKakUqalO0apRSKAYfhXdwMmazzPOTps8DUPAU36LBht55sLk9S2Cf8Ngz2osvdol/98EpmOb8Fhb5GoKcDbGJyujPMaoEvTkimaeIBY1vBDIilEwU/6qdscbcv6W2w7+0xNU9sQ+hoyVNBGwE4btHKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdh0qANT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b099118fedso16611cf.1
        for <stable@vger.kernel.org>; Thu, 07 Aug 2025 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597130; x=1755201930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C61XKHNGp1+eioPKY889x5RJjYc+RK8QZh4oQMa/B0=;
        b=cdh0qANTacmw0dHP7hndNxDWDX2D/m1vwnUMNz0+MIZI/Hh2FevTUpZXrQ7W/FKJvt
         Dmm5XZHTFXZu1c3yH3nwNYsgGgsFpwBiLstrjTLup5wEm5XBVWsFhYcUpRoVrhaYKvwV
         UbwQxk7gkkceZ1d7OET5Yx8ThgT39nIL1wh4a601a0VSxtYz7mFQ28lYU20vP2TjA7wb
         vOyOj8TabHXXrHink21nGtPbzlXhSrE7vM+T3KDeAA97fYSuVutR4UXhaoJNtdi3czxB
         sCNMZ3/y5xtAmDvp87YVyrjc4ZTdStyFro2rUvue6gwt4B9rsgYn6RiexMXkoNz4Q0Bm
         IpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597130; x=1755201930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C61XKHNGp1+eioPKY889x5RJjYc+RK8QZh4oQMa/B0=;
        b=PvmpVMybpU0cG8pAxUAWDClrsVzhBA3XvGzhb5C2hsPbqnfknLwJJCDhtaIiI6QvbC
         FIYcWATSxrla4dqln/wJrVzeVMvo8LY3TsWok3nK+mVQNuSncWs4coLA1CTP+GXJHn0M
         CNmQ9ECJgEbn68ljkaQrbMlLiS5mP0ygFwXGbdO2o0PThgn9cqZbCqcKStGwdltDSaON
         IbdVgKPqKmiGaay8OUrKqWHtJ/UR4FUzHBguO8o49fhcXjvthyOjSPIOSL6fJ1daqM78
         HnC4rcH7zh52NJ8nilPkH8CCL8zLp81ItQ0vHZwSIK9oEnclXRj0apDKsj/sozFbEsLD
         M3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVw6fEV87NTWUEvC8yv+Xb/5jSwz5+4YJMNwvb7Icklh2hrKYDJ3yekYwEhaQ5jVIJLYeH+Pgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09J+loOb3u+2DZW2tQrtid2G+SbJs0PfgEIdVO5W8PtczkIk0
	GUw7sOysZrv7jmuw24juGa+haYoFfRfOhJ3WvAKwCRuWQs9eC10edyzaEUnztPO8wrQFNZuf5ko
	umSRp3YbaA8feBoOpjxYUB+JtTAzO3DsDqUNJcWVp
X-Gm-Gg: ASbGncutKoeKrrbBonuxjlr2WR+EftDzn+6J9Tr849bEZgg5LS3IqTRUvpfe98O80ij
	ai0Ns8yD7x27fHh30zp5KdWiKA8Qlbu7dNY74w2WPIiNbNtupZz+x6OD2LRkfyxRW8R/xkG9HWA
	sCxPY9mY2OddURkzZ8f7J0VRy7b23zQtWdmcugOOOD98I/AeO8ouJtH7jak4qlDzgsUONc+8zwL
	6daZ0INqi0b+4Bpx/hr42RIPdgPReIhLYQ=
X-Google-Smtp-Source: AGHT+IGQMe/wQvvb3DLWm+i0vcjYFqmqa45BGVHVdA8UQtjXkWXTK/VdaJDL20XcA1/NNzl54vQHgeEojTt03r+bOWo=
X-Received: by 2002:a05:622a:1491:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4b0af2645f8mr894961cf.3.1754597129862; Thu, 07 Aug 2025
 13:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806220022.926763-1-surenb@google.com> <3eba855a-740c-4423-b2ed-24d622af29a5@redhat.com>
 <CAJuCfpExxYOtsWZo6r0FncA0TMeuhpe3SdhLbF+udtbqQ+B_Qg@mail.gmail.com>
 <43f91e3e-84c5-4fd1-9b63-4e2cb28dab36@redhat.com> <CAJuCfpECC9w6RdfbH34Y906uV=egUDct=6H54Xn79okKK80cjw@mail.gmail.com>
In-Reply-To: <CAJuCfpECC9w6RdfbH34Y906uV=egUDct=6H54Xn79okKK80cjw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Aug 2025 20:05:18 +0000
X-Gm-Features: Ac12FXzODY9k8UiGEYg8VNmmjfzF8pjbaTykoNeJX-IcPkHHbmkD8MlKlZ5muOU
Message-ID: <CAJuCfpF+OFZ3RNFaBVBQWmCG_EKxj9Jrb4QGz-Ladw3HJ9AN8A@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD
 is a migration entry
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:48=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Thu, Aug 7, 2025 at 7:42=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 07.08.25 17:27, Suren Baghdasaryan wrote:
> > > On Thu, Aug 7, 2025 at 3:31=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> > >>
> > >> On 07.08.25 00:00, Suren Baghdasaryan wrote:
> > >>> When UFFDIO_MOVE encounters a migration PMD entry, it proceeds with
> > >>> obtaining a folio and accessing it even though the entry is swp_ent=
ry_t.
> > >>> Add the missing check and let split_huge_pmd() handle migration ent=
ries.
> > >>>
> > >>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > >>> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > >>> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GA=
E@google.com/
> > >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >>> Reviewed-by: Peter Xu <peterx@redhat.com>
> > >>> Cc: stable@vger.kernel.org
> > >>> ---
> > >>> Changes since v3 [1]
> > >>> - Updated the title and changelog, per Peter Xu
> > >>> - Added Reviewed-by: per Peter Xu
> > >>>
> > >>> [1] https://lore.kernel.org/all/20250806154015.769024-1-surenb@goog=
le.com/
> > >>>
> > >>>    mm/userfaultfd.c | 17 ++++++++++-------
> > >>>    1 file changed, 10 insertions(+), 7 deletions(-)
> > >>>
> > >>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > >>> index 5431c9dd7fd7..116481606be8 100644
> > >>> --- a/mm/userfaultfd.c
> > >>> +++ b/mm/userfaultfd.c
> > >>> @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *=
ctx, unsigned long dst_start,
> > >>>                        /* Check if we can move the pmd without spli=
tting it. */
> > >>>                        if (move_splits_huge_pmd(dst_addr, src_addr,=
 src_start + len) ||
> > >>>                            !pmd_none(dst_pmdval)) {
> > >>> -                             struct folio *folio =3D pmd_folio(*sr=
c_pmd);
> > >>> -
> > >>> -                             if (!folio || (!is_huge_zero_folio(fo=
lio) &&
> > >>> -                                            !PageAnonExclusive(&fo=
lio->page))) {
> > >>> -                                     spin_unlock(ptl);
> > >>> -                                     err =3D -EBUSY;
> > >>> -                                     break;
> > >>> +                             /* Can be a migration entry */
> > >>> +                             if (pmd_present(*src_pmd)) {
> > >>> +                                     struct folio *folio =3D pmd_f=
olio(*src_pmd);
> > >>> +
> > >>> +                                     if (!folio
> > >>
> > >>
> > >> How could you get !folio here? That only makes sense when calling
> > >> vm_normal_folio_pmd(), no?
> > >
> > > Yes, I think you are right, this check is not needed. I can fold it
> > > into this fix or post a separate cleanup patch. I'm guessing a
> > > separate patch would be better?
> >
> > I think you can just post a fixup inline here and ask Andrew to squash
> > it. He will shout if he wants a completely new version :)
>
> I wouldn't do that to him! :)
> Let me quickly send an updated version instead.

Update posted at
https://lore.kernel.org/all/20250807200418.1963585-1-surenb@google.com/

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

