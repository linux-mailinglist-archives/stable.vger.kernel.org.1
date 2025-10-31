Return-Path: <stable+bounces-191798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87960C2450C
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 11:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32A7E4E5376
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2333345B;
	Fri, 31 Oct 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/X9S9bo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D21B87EB;
	Fri, 31 Oct 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904763; cv=none; b=DvFZYCeZ271YaKMfQKyqO/PYBvBKO0N03CwRxNx/40JDIfwNhTAwY+wqtXg+/E8JGx7xBBmCW+DEsmGZKghIG7QMrYtVsv3mR8Asc4vHuRyiItTTmWiKiuujPrkoVEveZ1EpuAeQOb6LMIRsRojuPPDM+c+tFqnooRfJcjSci7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904763; c=relaxed/simple;
	bh=fbWfcUSRmmSGBIa7RvGFKILcyx2LFQdk812Ih8G0axY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnLolD1ieruFTgqTCQbn43KqvVXeO4jYKgxNBET3IXrAqN+MiOEimPvYRXR9t7UGkNED9+l2svmjaXrhqzVD8Tz7ybl2MSiPxqurzuRb076hjZ1r00mFuFJL+EUxks6G+VVyLoyBKMsEg3ShZmJywjm+funEz8awwxB5GcWBVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/X9S9bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00199C4CEE7;
	Fri, 31 Oct 2025 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761904763;
	bh=fbWfcUSRmmSGBIa7RvGFKILcyx2LFQdk812Ih8G0axY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/X9S9bovPQF50GHgjwW/vIf0AsSsp64qbJdE19thdNyppfFyHrowADfIzxgilHha
	 A/jpOa69Lv0SgKllffjaNRCbjvkRI+7+1JiP9CJCKDYqqZM6Tjm/7tbvPhObuzx/9R
	 BO7w4YmmWcwxi2Yg6d9QS/dTwBEXtoFACYU+hbBqz4p4LUt7imQtt+5wEKXZClcoUY
	 DkyhTugW2NZiY/Pf8gSGz9ZaHj1mHzJQRPTPEnKgxiE2CFWnQzq9ppapfN+GQeS4Vw
	 DV+f3c1KGZWPnuX/3/NeCVIaatiRrx6mXXSe+YVieVb3GpCdgVdqo+ttN1IEHCm06p
	 7jJojaeQqffYA==
Date: Fri, 31 Oct 2025 11:59:16 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, big-sleep-vuln-reports@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, willy@infradead.org, david@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/secretmem: fix use-after-free race in fault
 handler
Message-ID: <aQSIdCpf-2pJLwAF@kernel.org>
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
 <20251031091818.66843-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031091818.66843-1-lance.yang@linux.dev>

On Fri, Oct 31, 2025 at 05:18:18PM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> The error path in secretmem_fault() frees a folio before restoring its
> direct map status, which is a race leading to a panic.

Let's use the issue description from the report:

When a page fault occurs in a secret memory file created with
`memfd_secret(2)`, the kernel will allocate a new folio for it, mark
the underlying page as not-present in the direct map, and add it to
the file mapping.

If two tasks cause a fault in the same page concurrently, both could
end up allocating a folio and removing the page from the direct map,
but only one would succeed in adding the folio to the file
mapping. The task that failed undoes the effects of its attempt by (a)
freeing the folio again and (b) putting the page back into the direct
map. However, by doing these two operations in this order, the page
becomes available to the allocator again before it is placed back in
the direct mapping.

If another task attempts to allocate the page between (a) and (b), and
the kernel tries to access it via the direct map, it would result in a
supervisor not-present page fault.
 
> Fix the ordering to restore the map before the folio is freed.

... restore the direct map

With these changes

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
> Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>  mm/secretmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index c1bd9a4b663d..37f6d1097853 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  		__folio_mark_uptodate(folio);
>  		err = filemap_add_folio(mapping, folio, offset, gfp);
>  		if (unlikely(err)) {
> -			folio_put(folio);
>  			/*
>  			 * If a split of large page was required, it
>  			 * already happened when we marked the page invalid
>  			 * which guarantees that this call won't fail
>  			 */
>  			set_direct_map_default_noflush(folio_page(folio, 0));
> +			folio_put(folio);
>  			if (err == -EEXIST)
>  				goto retry;
>  
> -- 
> 2.49.0
> 

-- 
Sincerely yours,
Mike.

