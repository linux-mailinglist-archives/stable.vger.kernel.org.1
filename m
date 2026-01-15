Return-Path: <stable+bounces-209944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E8D28041
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFB46300CA24
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6825B2EC0A7;
	Thu, 15 Jan 2026 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EZpMaRLc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116E2D97AB;
	Thu, 15 Jan 2026 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768504788; cv=none; b=owj4vIFFaMscNssq06x608SX2NhESYqPc/XQr++0Wf23PFl/alKV9FSRNYdCBFzcrgdpjPFXtto+4ONrLUklBDbyK+Fl4SVhRc5tPHTFQwLZ88FaWT7xL2iK4wH6lU/Xef9CQBZ/CVt7AhAUYprj3rMCki3y4LDUSvwMoPY+2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768504788; c=relaxed/simple;
	bh=4IqFlSgd50KOXhq32VEtfl/4QDI6mWXEtIVrRCZB74k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tkLcuVGcqlLaM6df6AXK3ZvDiwWigPz3DKe4FxHfbCvJF+qo7zrejUd0oOkBHE+A5kulkaA1PAHYLBiQu6ccEbHji5sERmC2D9AR0oTgc5eEuGiTyWIjiQgMUFFWok/VYc14+aEVQsIi1WtabwfC3W0at03X3Bw9WOsSkij+17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EZpMaRLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47885C116D0;
	Thu, 15 Jan 2026 19:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768504787;
	bh=4IqFlSgd50KOXhq32VEtfl/4QDI6mWXEtIVrRCZB74k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZpMaRLcj6fcjYWJwT1eFKHu1o9k0+GiTV/xZtcAsCVZtvAXL6mg0KN1e33qbC9JM
	 YVh6ORLZqfcmx8dCnplNSwfgftwbHiwas//xD4BlxyUXlLz828/H2LKzYH1mBUReGX
	 dLWAaMoLVj2x+aphE6GwOmUX6sqO9jzAtIwmxWyY=
Date: Thu, 15 Jan 2026 11:19:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Wupeng Ma
 <mawupeng1@huawei.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/hugetlb: Restore failed global reservations to
 subpool
Message-Id: <20260115111946.4b50c5dbe6c6bd01638e4b16@linux-foundation.org>
In-Reply-To: <20260115181438.223620-2-joshua.hahnjy@gmail.com>
References: <20260115181438.223620-1-joshua.hahnjy@gmail.com>
	<20260115181438.223620-2-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 13:14:35 -0500 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Commit a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> fixed an underflow error for hstate->resv_huge_pages caused by
> incorrectly attributing globally requested pages to the subpool's
> reservation.
> 
> Unfortunately, this fix also introduced the opposite problem, which would
> leave spool->used_hpages elevated if the globally requested pages could
> not be acquired. This is because while a subpool's reserve pages only
> accounts for what is requested and allocated from the subpool, its
> "used" counter keeps track of what is consumed in total, both from the
> subpool and globally. Thus, we need to adjust spool->used_hpages in the
> other direction, and make sure that globally requested pages are
> uncharged from the subpool's used counter.
> 
> Each failed allocation attempt increments the used_hpages counter by
> how many pages were requested from the global pool. Ultimately, this
> renders the subpool unusable, as used_hpages approaches the max limit.
> 
> The issue can be reproduced as follows:
> 1. Allocate 4 hugetlb pages
> 2. Create a hugetlb mount with max=4, min=2
> 3. Consume 2 pages globally
> 4. Request 3 pages from the subpool (2 from subpool + 1 from global)
> 	4.1 hugepage_subpool_get_pages(spool, 3) succeeds.
> 		used_hpages += 3
> 	4.2 hugetlb_acct_memory(h, 1) fails: no global pages left
> 		used_hpages -= 2
> 5. Subpool now has used_hpages = 1, despite not being able to
>    successfully allocate any hugepages. It believes it can now only
>    allocate 3 more hugepages, not 4.
> 
> Repeating this process will ultimately render the subpool unable to
> allocate any hugepages, since it believes that it is using the maximum
> number of hugepages that the subpool has been allotted.
> 
> The underflow issue that commit a833a693a490 fixes still remains fixed
> as well.

Thanks, I submitted the above to the Changelog Of The Year judging
committee.

> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: stable@vger.kernel.org

I'll add this to mm.git's mm-hotfixes queue, for testing and review
input.

> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6560,6 +6560,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	struct resv_map *resv_map;
>  	struct hugetlb_cgroup *h_cg = NULL;
>  	long gbl_reserve, regions_needed = 0;
> +	unsigned long flags;

This could have been local to the {block} which uses it, which would be
nicer, no?

>  	int err;
>  
>  	/* This should never happen */
> @@ -6704,6 +6705,13 @@ long hugetlb_reserve_pages(struct inode *inode,
>  		 */
>  		hugetlb_acct_memory(h, -gbl_resv);
>  	}
> +	/* Restore used_hpages for pages that failed global reservation */
> +	if (gbl_reserve && spool) {
> +		spin_lock_irqsave(&spool->lock, flags);
> +		if (spool->max_hpages != -1)
> +			spool->used_hpages -= gbl_reserve;
> +		unlock_or_release_subpool(spool, flags);
> +	}

I'll add [2/3] and [3/3] to the mm-new queue while discarding your
perfectly good [0/N] :(

Please, let's try not to mix backportable patches with the
non-backportable ones?


