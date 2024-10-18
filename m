Return-Path: <stable+bounces-86867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1529A446D
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 19:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331FB1F22A03
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F25204099;
	Fri, 18 Oct 2024 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmkstWnq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1AE204007
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271721; cv=none; b=R9j6hnBqFtpMOBQsr5Xa3gjU6xDnZZJlxjHKHbFVnxAmCoRaDysjG/VDMenwDftj0tmcT3xpL+xFLdQGqd8qHkrxKluCCGYgN3hdp5K7PoxV8lXIpWg5xBe7+cvPOOVNyL8dMIDgr/b/Oc5jSfX+jCv95OPPxuj7ny63/LLNQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271721; c=relaxed/simple;
	bh=0ALLVjy8iC9H/pCEIRkmJNJyhi+/TN8pkI0KN1fzMhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e78N9awU2MMUiF+tKJWldd3dRmQV4SSUwXbPXRtdIzoe2vNLMVTTQ/jWqtWw7U5qMVPGNPjNKKSfLD4KTFJigxlIJ3e6FmAOfFGj2mK7cph7uYBPE5VAKdaqgsVmS3Sptrz9kizKTHrAOo1mvpREOWcN9x/Ftnv61hoISQPGmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmkstWnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA896C4CEC3
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729271720;
	bh=0ALLVjy8iC9H/pCEIRkmJNJyhi+/TN8pkI0KN1fzMhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PmkstWnqIx0yIDONgr/czYGMwMIP1OrY8sz1OEzGatCoWT72v8J8LxoYNfhUqkG0P
	 w9PfMFU05SZbv38jijWkgq+VdhntWVqos/4+p6eI44eD/erzOMaxAkAH1QSnXm4XJI
	 92J4JUnoy4P0/xjgjXjUfdme5NlTsxOLDSN1M7kz4JgWSbDGxOEzzUpbiUhMQGSU7l
	 rGgEVj5NGbixUv5GiOaHrYJump9JXtVrj0V9O227UmG97WsjUqupLsB33aEDnZNBy4
	 1z3JyAuUiPvQXRe4hYBbh8tyPJsZabG6m4J+tLEPVDhPhQ5CvNq05hAfSEy3UMDyLl
	 3hNmnJpFxkjcg==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e290d5f83bcso2244289276.0
        for <stable@vger.kernel.org>; Fri, 18 Oct 2024 10:15:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YxffksxZmJLRW9jHW4TNhxpfBqGIodzvcZGA71dRfGmLOuqKwwf
	yfPOCWG5gpMsyzWhzm9nPN/S8jjDtZed0wJNRWn8zu8BaFNNuYb17BllkP3CbD+3Oozob2xupl+
	4Hx53Ms+X7w4/65pDIi7xC1EPADHi+1LlAJXqFA==
X-Google-Smtp-Source: AGHT+IHduZkvqyerJwsAMOCT2rb6Erz8X9/RH+zEAGV5BIDhI4cTWY9qe48/tvTEiJWC2yOxD8kQs2LKq8Eb6uFTrMQ=
X-Received: by 2002:a05:690c:2e86:b0:6db:3b2f:a18a with SMTP id
 00721157ae682-6e5bfc8ca98mr25565857b3.11.1729271719995; Fri, 18 Oct 2024
 10:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org>
 <20241017-stable-yuzhao-v1-2-3a4566660d44@kernel.org> <2024101850-dwarf-payday-8d15@gregkh>
In-Reply-To: <2024101850-dwarf-payday-8d15@gregkh>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 18 Oct 2024 10:15:09 -0700
X-Gmail-Original-Message-ID: <CACePvbUXDRBgkU6c1oEsbd_JaZ+ymHN_ecHjirKtHNQ6W2wneA@mail.gmail.com>
Message-ID: <CACePvbUXDRBgkU6c1oEsbd_JaZ+ymHN_ecHjirKtHNQ6W2wneA@mail.gmail.com>
Subject: Re: [PATCH 6.11.y 2/3] mm/codetag: fix pgalloc_tag_split()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, Oct 18, 2024 at 1:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Oct 17, 2024 at 02:58:03PM -0700, chrisl@kernel.org wrote:
> > From: Yu Zhao <yuzhao@google.com>
> >
> > [ Upstream commit 95599ef684d01136a8b77c16a7c853496786e173 ]
> >
> > The current assumption is that a large folio can only be split into
> > order-0 folios.  That is not the case for hugeTLB demotion, nor for THP
> > split: see commit c010d47f107f ("mm: thp: split huge page to any lower
> > order pages").
> >
> > When a large folio is split into ones of a lower non-zero order, only t=
he
> > new head pages should be tagged.  Tagging tail pages can cause imbalanc=
ed
> > "calls" counters, since only head pages are untagged by pgalloc_tag_sub=
()
> > and the "calls" counts on tail pages are leaked, e.g.,
> >
> >   # echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_si=
ze
> >   # echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> >   # time echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote
> >   # echo 0 >/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> >   # grep alloc_gigantic_folio /proc/allocinfo
> >
> > Before this patch:
> >   0  549427200  mm/hugetlb.c:1549 func:alloc_gigantic_folio
> >
> >   real  0m2.057s
> >   user  0m0.000s
> >   sys   0m2.051s
> >
> > After this patch:
> >   0          0  mm/hugetlb.c:1549 func:alloc_gigantic_folio
> >
> >   real  0m1.711s
> >   user  0m0.000s
> >   sys   0m1.704s
> >
> > Not tagging tail pages also improves the splitting time, e.g., by about
> > 15% when demoting 1GB hugeTLB folios to 2MB ones, as shown above.
> >
> > Link: https://lkml.kernel.org/r/20240906042108.1150526-2-yuzhao@google.=
com
> > Fixes: be25d1d4e822 ("mm: create new codetag references during page spl=
itting")
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > Acked-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> You did not sign off on this backport, so even if I wanted to take it, I
> couldn't :(

My bad, sorry my first attempt back port some patches for someone else.

> Please fix this, and patch 3/3 up, and just send those.

I will add sign off to all 3 patches and send out the v2. I haven't
found an easy way to skip the cover letter in b4 yet. It might be
easier just to refresh the whole series.

Chris

