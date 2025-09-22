Return-Path: <stable+bounces-180913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D96B8FD7D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 11:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37512A0782
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D8B23B616;
	Mon, 22 Sep 2025 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTAD4nd1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6311185
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534579; cv=none; b=Zd4oNE46U5uebAG6Q1cyxbO46WCq9ANUVS2x8Z8QFHs51iQdhbkPldn+UwMOUKnxNSTIZDnlSIB2GLbeP9oNSJfM9x8mSO3yact1WlqGhyeT+klnC+JTRSizLfLUkBXCqbgwL3wUb93VcfM+3Zm0sE8RdUiS3WjkKxVB52ix7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534579; c=relaxed/simple;
	bh=TcINg7e3YxayTXNkATaRf4Q21Kv4tIx877hTtw5EkF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYFrB+tB91XEgYPLmiQCGATZiyUj8uX+hhJ7QeHTeLaQUwe2zySJF7weFApnPjGF+KWksNCr6FfJuAV8d+M2gULNf6ISkRWIg3FnXrw59x+PQU5dmtJ5mBVn7FsxZGemNKKbWnQy/bkDzhMoraLCa/7Urt9sy9j4SCnfHOgZJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTAD4nd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE71C4CEF0;
	Mon, 22 Sep 2025 09:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758534578;
	bh=TcINg7e3YxayTXNkATaRf4Q21Kv4tIx877hTtw5EkF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTAD4nd17egJqEbGpfbac09dqGeu0GwSs0WnOXa66Hm3BGQrpo2Kfxt+bKJB5iD1K
	 6iw7b30tuAvCCFELhKM6UVkn0DjDKYfHRf4WfKcsr/Pp6yYhc6AWr6BJrn0XB32APZ
	 lyUzFQ0e+mbRPCWFypXKQO8FBzg/JVWanaFlGj5vChWTUmWmUL7UqK3prkXTK231tM
	 sHa/kCZkGzC2KZODTiZbOYvwXpzQYORlISM7IVtQxIxu5Ojq+/VmmTFsTraAYW6wob
	 j9YB2ZFO0WKzA+f6sx3zSsDCNrhWb8iUg6nS1s6By+Mj4i7bJBLFz3y87kq0wMKVbb
	 V2mx9JJvReHog==
Date: Mon, 22 Sep 2025 10:49:31 +0100
From: Will Deacon <will@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Chris Li <chrisl@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>, Keir Fraser <keirf@google.com>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
	Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>,
	Wei Xu <weixugc@google.com>, yangge <yangge1116@126.com>,
	Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm: folio_may_be_lru_cached() unless
 folio_test_large()
Message-ID: <aNEbqzso0rloTd-V@willie-the-truck>
References: <2025092142-easiness-blatancy-23af@gregkh>
 <20250921154134.2945191-1-sashal@kernel.org>
 <2025092135-collie-parched-1244@gregkh>
 <b7e6758f-9942-81ca-c5fd-1753ce49aa32@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e6758f-9942-81ca-c5fd-1753ce49aa32@google.com>

On Sun, Sep 21, 2025 at 09:05:35PM -0700, Hugh Dickins wrote:
> On Sun, 21 Sep 2025, Greg KH wrote:
> > On Sun, Sep 21, 2025 at 11:41:34AM -0400, Sasha Levin wrote:
> > > From: Hugh Dickins <hughd@google.com>
> > > 
> > > [ Upstream commit 2da6de30e60dd9bb14600eff1cc99df2fa2ddae3 ]
> > > 
> > > mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as a
> > > large folio is added: so collect_longterm_unpinnable_folios() just wastes
> > > effort when calling lru_add_drain[_all]() on a large folio.
> > > 
> > > But although there is good reason not to batch up PMD-sized folios, we
> > > might well benefit from batching a small number of low-order mTHPs (though
> > > unclear how that "small number" limitation will be implemented).
> > > 
> > > So ask if folio_may_be_lru_cached() rather than !folio_test_large(), to
> > > insulate those particular checks from future change.  Name preferred to
> > > "folio_is_batchable" because large folios can well be put on a batch: it's
> > > just the per-CPU LRU caches, drained much later, which need care.
> > > 
> > > Marked for stable, to counter the increase in lru_add_drain_all()s from
> > > "mm/gup: check ref_count instead of lru before migration".
> > > 
> > > Link: https://lkml.kernel.org/r/57d2eaf8-3607-f318-e0c5-be02dce61ad0@google.com
> > > Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > > Cc: Axel Rasmussen <axelrasmussen@google.com>
> > > Cc: Chris Li <chrisl@kernel.org>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > Cc: Keir Fraser <keirf@google.com>
> > > Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> > > Cc: Li Zhe <lizhe.67@bytedance.com>
> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Cc: Shivank Garg <shivankg@amd.com>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Wei Xu <weixugc@google.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: yangge <yangge1116@126.com>
> > > Cc: Yuanchu Xie <yuanchu@google.com>
> > > Cc: Yu Zhao <yuzhao@google.com>
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > [ adapted to drain_allow instead of drained ]
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > 
> > Does not apply as it conflicts with the other mm changes you sent right
> > before this one :(
> 
> Thanks for grabbing all these, I'm sorry they are troublesome.
> 
> Though I'm usually able to work out what to do from the FAILED mails,
> in this case I'd just be guessing without the full contexts.
> So I'll wait until I see what goes into the various branches of
> linux-stable-rc.git before checking and adjusting where necessary.
> 
> (As usual, I'll tend towards minimal change, where Sasha tends
> towards maximal backporting of encroaching mods: we may disagree.)
> 
> The main commits contributing to the pinning failures that Will Deacon
> reported were commits going into 5.18 and 6.11.  So although I stand
> by my Fixes tag, I'm likely to conclude that 5.15 and 5.10 and 5.4
> are better left stable without any of it.

That suits me. 6.1, 6.6 and 6.12 are the main ones that I'm concerned
with from the Android side.

Will

