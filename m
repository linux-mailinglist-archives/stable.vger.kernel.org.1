Return-Path: <stable+bounces-121112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A653A50C92
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 21:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720351883A96
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 20:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC321D88B4;
	Wed,  5 Mar 2025 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kOrGQWMP"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E21917E4;
	Wed,  5 Mar 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206694; cv=none; b=bg3YEsmMjFNRyqCXgLMdilYylgmsZ0056z3MR72IHaNNaojiEugSWZUmbRTtFVgSmgco/rT03Btp9TfehBbuhWcSD1d27DYkOm2x2XaUqqH1tz0H7f3DN4GtYNxjyK5lkmk6xdM1NTSvmTE4d32+vbOKAYZtXR3SvnjRA2Ix1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206694; c=relaxed/simple;
	bh=WBNDtdCWGQh9oPEY49ejtX299nQF0XieKRNkEJJ79/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgP3hfF9wRw0lzsD2sMVxH4Dwg9D6/EWuNJYKpPgj3NE4cSJ3U9CAhendonb0bYsh/3i68rpCX0psRky/Ii6sJfU2TxHIOijOaYar1swq25pJDqRSk19s4MLCpx8vW4k4HuNqj8vOnxaEk7tSbwONcIJ1uYJWvsiWds8vApp6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kOrGQWMP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5N69iuSZpEP3m1sQZOVuMhRR/phcnv3Nm9ASp7xyfVE=; b=kOrGQWMPRD/iroQXeR6iOyX+Md
	dbgAFsc4t/jIFa9ZM8NoLIbQsKZ+dtf3Ij7mnzbq36sVOtO4vHIV+tpJYXN+HqzGCWB85f4OQ4CtU
	8InbhiB+XTG2vIqws1nkEbSwXzsIXXpDLu8X1/AZvSAD/iutOU1iEmRb7QQ6EYeoZtkX8drblW3s1
	1QDV4bd9tCdaff5Nbq6CQWFy5paBSEpPEt3hLVsXCU4sONMHDcVoQcM4HCB2BZBgz6Tmkkj9NSfx0
	+Tq+zt0qNZf5ys2CHT81hyPUVOij7RJ6AFbrO0VG4DRbok4roLlyAPY8luYiGUI8C0xbO4skAZX53
	G/XUnQyw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpvOh-00000006AwN-1uRx;
	Wed, 05 Mar 2025 20:31:19 +0000
Date: Wed, 5 Mar 2025 20:31:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Liu Shixin <liushixin2@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/migrate: fix shmem xarray update during migration
Message-ID: <Z8i0l8apxDsThD9s@casper.infradead.org>
References: <20250305200403.2822855-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305200403.2822855-1-ziy@nvidia.com>

On Wed, Mar 05, 2025 at 03:04:03PM -0500, Zi Yan wrote:
> A shmem folio can be either in page cache or in swap cache, but not at the
> same time. Namely, once it is in swap cache, folio->mapping should be NULL,
> and the folio is no longer in a shmem mapping.
> 
> In __folio_migrate_mapping(), to determine the number of xarray entries
> to update, folio_test_swapbacked() is used, but that conflates shmem in
> page cache case and shmem in swap cache case. It leads to xarray
> multi-index entry corruption, since it turns a sibling entry to a
> normal entry during xas_store() (see [1] for a userspace reproduction).
> Fix it by only using folio_test_swapcache() to determine whether xarray
> is storing swap cache entries or not to choose the right number of xarray
> entries to update.
> 
> [1] https://lore.kernel.org/linux-mm/Z8idPCkaJW1IChjT@casper.infradead.org/
> 
> Note:
> In __split_huge_page(), folio_test_anon() && folio_test_swapcache() is used
> to get swap_cache address space, but that ignores the shmem folio in swap
> cache case. It could lead to NULL pointer dereferencing when a
> in-swap-cache shmem folio is split at __xa_store(), since
> !folio_test_anon() is true and folio->mapping is NULL. But fortunately,
> its caller split_huge_page_to_list_to_order() bails out early with EBUSY
> when folio->mapping is NULL. So no need to take care of it here.
> 
> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
> Reported-by: Liu Shixin <liushixin2@huawei.com>
> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

