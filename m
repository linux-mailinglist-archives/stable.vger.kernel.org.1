Return-Path: <stable+bounces-180825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF181B8E15D
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 19:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFB71794DC
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A172571B3;
	Sun, 21 Sep 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/7/AZu6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BFD341AA
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758474777; cv=none; b=AsZBStYFIG4m/O7aaLqqtNLszfHi2lXJbj8IVBOhQy7brnLFr95hEf3HEkzw4RbiwvlHwYWkW8m0JpfFEm2tAfAaXQ70kFbzTLsWPx0tJY+UJN4uvtzismDw7SyMkydiHJTBpkfC3DW171sVBcvTtnYT0DGPIrHxHgQvpL/c9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758474777; c=relaxed/simple;
	bh=ajTEE/WYt5sHNyiqFsPcOuDWIf6LbNVJRiQMIj/UE+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICd4AZLGILFzx3AzKuxSmvP/xy3vSxrlNH4h8w1gFvQcbrOkmIsVrt1Peu04Rhu7/q5X6l8Tvj1Qpk3NCfhaA3HNA7A49PoEB113tkvlOvZ6ACquR6snkU69MY9pzHXRBm5J1ZnEQZVs/QSxHG6HnzE3GQIEZ8y07ZVXCBg+n28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/7/AZu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115DDC4CEE7;
	Sun, 21 Sep 2025 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758474776;
	bh=ajTEE/WYt5sHNyiqFsPcOuDWIf6LbNVJRiQMIj/UE+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/7/AZu6WncO2H6c0LZjINnaasnxfwzr9hkOWV88qkx4cUFWOxNQGtPBIZx0NJZpM
	 Vnh8btgpfRy8EztfoUZEcFsXX/apQJiu6kL5Uh9s1vw5u55Jl5xzReQ30mf5gu+J7b
	 nZJBrJgoOl/n+oCeapluD4vpx4mUzIB8fnY6Jo6M=
Date: Sun, 21 Sep 2025 19:12:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
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
	Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>,
	yangge <yangge1116@126.com>, Yuanchu Xie <yuanchu@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm: folio_may_be_lru_cached() unless
 folio_test_large()
Message-ID: <2025092135-collie-parched-1244@gregkh>
References: <2025092142-easiness-blatancy-23af@gregkh>
 <20250921154134.2945191-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921154134.2945191-1-sashal@kernel.org>

On Sun, Sep 21, 2025 at 11:41:34AM -0400, Sasha Levin wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> [ Upstream commit 2da6de30e60dd9bb14600eff1cc99df2fa2ddae3 ]
> 
> mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as a
> large folio is added: so collect_longterm_unpinnable_folios() just wastes
> effort when calling lru_add_drain[_all]() on a large folio.
> 
> But although there is good reason not to batch up PMD-sized folios, we
> might well benefit from batching a small number of low-order mTHPs (though
> unclear how that "small number" limitation will be implemented).
> 
> So ask if folio_may_be_lru_cached() rather than !folio_test_large(), to
> insulate those particular checks from future change.  Name preferred to
> "folio_is_batchable" because large folios can well be put on a batch: it's
> just the per-CPU LRU caches, drained much later, which need care.
> 
> Marked for stable, to counter the increase in lru_add_drain_all()s from
> "mm/gup: check ref_count instead of lru before migration".
> 
> Link: https://lkml.kernel.org/r/57d2eaf8-3607-f318-e0c5-be02dce61ad0@google.com
> Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Keir Fraser <keirf@google.com>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Li Zhe <lizhe.67@bytedance.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Shivank Garg <shivankg@amd.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: yangge <yangge1116@126.com>
> Cc: Yuanchu Xie <yuanchu@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [ adapted to drain_allow instead of drained ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Does not apply as it conflicts with the other mm changes you sent right
before this one :(



