Return-Path: <stable+bounces-154590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEC4ADDF43
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A96B3BED96
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 22:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0512D2957CE;
	Tue, 17 Jun 2025 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IxN6J0bq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1629347C;
	Tue, 17 Jun 2025 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201138; cv=none; b=BRc0EjaBvrAE+OAf2mimKGeuzvBktIdLMjN2kPx/6oWHXdIfPSQBkN0AaJZMLrWFdLEYIz6X59x3djeQTIH/gl7ICU6mjk3F8xXzfebCq9iQbZkNyHnpZ6ZHhyXppZCRajGlisUUXEKQv3/qOlmGt0RIOo+da/vRdSPwT/biDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201138; c=relaxed/simple;
	bh=Om8rU9t5dO6lsVh6MDdI4iXYo/zn/c0NhqCeM4oAPP4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AsXrjqdjKC3VbQlvFZQGOhLW2fYdp0qhyMmBS8jDAKT2TUc13dqvwuw53VaUWzX5yLmvDU4gs7zJoWenTHHhv/XFHrW6Oa5Lu6z6A51KRz7R7/zdnG7lNOydU686cBNqE9840hYjK92s9jNNnLuWpxoIxOoytSBFVA4f4oGRd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IxN6J0bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0424C4CEE3;
	Tue, 17 Jun 2025 22:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750201138;
	bh=Om8rU9t5dO6lsVh6MDdI4iXYo/zn/c0NhqCeM4oAPP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IxN6J0bqVg7BJzBziBGOF397Zd96J+vvx3GuCJn5LqjbbZjt3Gj2osEU4aL/xU2ei
	 8WlruCNvsN48JduOcNc6N7qH95OxfU10NC7WoOBRDqRkiYur+BXwSveUNNy21vlbrt
	 mOhtYMjMTuQOLLZ7So9QyrYFMsqHLQtY4vPT50aE=
Date: Tue, 17 Jun 2025 15:58:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <kasong@tencent.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Matthew
 Wilcox <willy@infradead.org>, Kemeng Shi <shikemeng@huaweicloud.com>, Chris
 Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/shmem, swap: improve cached mTHP handling and
 fix potential hung
Message-Id: <20250617155857.589c3e700b06af7dff085166@linux-foundation.org>
In-Reply-To: <20250617183503.10527-2-ryncsn@gmail.com>
References: <20250617183503.10527-1-ryncsn@gmail.com>
	<20250617183503.10527-2-ryncsn@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 02:35:00 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> From: Kairui Song <kasong@tencent.com>
> 
> The current swap-in code assumes that, when a swap entry in shmem
> mapping is order 0, its cached folios (if present) must be order 0
> too, which turns out not always correct.
> 
> The problem is shmem_split_large_entry is called before verifying the
> folio will eventually be swapped in, one possible race is:
> 
>     CPU1                          CPU2
> shmem_swapin_folio
> /* swap in of order > 0 swap entry S1 */
>   folio = swap_cache_get_folio
>   /* folio = NULL */
>   order = xa_get_order
>   /* order > 0 */
>   folio = shmem_swap_alloc_folio
>   /* mTHP alloc failure, folio = NULL */
>   <... Interrupted ...>
>                                  shmem_swapin_folio
>                                  /* S1 is swapped in */
>                                  shmem_writeout
>                                  /* S1 is swapped out, folio cached */
>   shmem_split_large_entry(..., S1)
>   /* S1 is split, but the folio covering it has order > 0 now */
> 
> Now any following swapin of S1 will hang: `xa_get_order` returns 0,
> and folio lookup will return a folio with order > 0. The
> `xa_get_order(&mapping->i_pages, index) != folio_order(folio)` will
> always return false causing swap-in to return -EEXIST.
> 
> And this looks fragile. So fix this up by allowing seeing a larger folio
> in swap cache, and check the whole shmem mapping range covered by the
> swapin have the right swap value upon inserting the folio. And drop
> the redundant tree walks before the insertion.
> 
> This will actually improve the performance, as it avoided two redundant
> Xarray tree walks in the hot path, and the only side effect is that in
> the failure path, shmem may redundantly reallocate a few folios
> causing temporary slight memory pressure.
> 
> And worth noting, it may seems the order and value check before
> inserting might help reducing the lock contention, which is not true.
> The swap cache layer ensures raced swapin will either see a swap cache
> folio or failed to do a swapin (we have SWAP_HAS_CACHE bit even if
> swap cache is bypassed), so holding the folio lock and checking the
> folio flag is already good enough for avoiding the lock contention.
> The chance that a folio passes the swap entry value check but the
> shmem mapping slot has changed should be very low.
> 
> Cc: stable@vger.kernel.org
> Fixes: 058313515d5a ("mm: shmem: fix potential data corruption during shmem swapin")
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")

The Fixes: tells -stable maintainers (and others) which kernel versions
need the fix.  So having two Fixes: against different kernel versions is
very confusing!  Are we recommending that kernels which contain
809bc86517cc but not 058313515d5a be patched?


