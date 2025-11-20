Return-Path: <stable+bounces-195412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8893C761D1
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 844EF28E91
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB65F217736;
	Thu, 20 Nov 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvHM/3xN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07938DEC
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667923; cv=none; b=Slhmg1FwHuSBV+k6B0zBwXuWUND2W1z4Sag8aA6QuYi81uQPNnFT9OPQaJKqfP/a1AMJ0b02AtBcHdkwVVvm51DIcFvPS4HVFLJjaBoyLNgO9R+ZZSI50SKD1wHvRHJd5U9RzGnqnIczOAolpPKLlKrV9mdlkmAVimfDbP/z6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667923; c=relaxed/simple;
	bh=FhpWcUQw16q2dFQUtIxPk6Hi9u6Q8vedPINekoE4iDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl278QKSe7omyDLMEEf7J+SCLyWNcovrtz6Erq4oUy2D/2RsTD1jzs33IkAe6I82hYFUSdQBtTu6eaqAzq5qNrsD4aycpoLpZ6I+BYB51YKM37X/rSomWSUTX8dYN2RY2ExDjLs7d5r22zbPU4g4E9sv+puhuU2fhg7Om9Vw5OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvHM/3xN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85002C4CEF1;
	Thu, 20 Nov 2025 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763667923;
	bh=FhpWcUQw16q2dFQUtIxPk6Hi9u6Q8vedPINekoE4iDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvHM/3xNg9+/Mr5kGqVPSamk/96Fmts/YQfKGfxGd3IYdxf9TYM98TQRbXXbOIWTk
	 TcnJo+Jgc3xJbH9JC8kZBoVHVITf9pHMR74jgkEdhj9lcp0SiBVl7KpqsDmHs2UcTc
	 3CSLfbl6Rr4c4OhLAQnUdx7qKrneFsSc6Q4dMYFAIENJ7iGhHgFoQMuFNHXnVH3YsA
	 Jp40Nhgxd3GNr1EyhSUw0bT2NZfgmSiFZ9/OKuBuPVv7pek3uyf1jLYpocAa40NBpe
	 xAb/zTWkyrXpP7qAAwKyRsyNAy+p7GkOy7TGrCx0gaeE8Ur/Tj+A1yI8LFThryDXTx
	 9mPVaHi7SYUPA==
Date: Thu, 20 Nov 2025 21:45:17 +0200
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: Lance Yang <lance.yang@linux.dev>,
	Google Big Sleep <big-sleep-vuln-reports@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/secretmem: fix use-after-free race in fault
 handler
Message-ID: <aR9vzeI5Tso6g7PO@kernel.org>
References: <2025112032-parted-progeny-cd9e@gregkh>
 <20251120191547.2344004-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120191547.2344004-1-rppt@kernel.org>

Oops, copied the wrong git send-email command, sorry for the noise

On Thu, Nov 20, 2025 at 09:15:47PM +0200, Mike Rapoport wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When a page fault occurs in a secret memory file created with
> `memfd_secret(2)`, the kernel will allocate a new page for it, mark the
> underlying page as not-present in the direct map, and add it to the file
> mapping.
> 
> If two tasks cause a fault in the same page concurrently, both could end
> up allocating a page and removing the page from the direct map, but only
> one would succeed in adding the page to the file mapping.  The task that
> failed undoes the effects of its attempt by (a) freeing the page again
> and (b) putting the page back into the direct map.  However, by doing
> these two operations in this order, the page becomes available to the
> allocator again before it is placed back in the direct mapping.
> 
> If another task attempts to allocate the page between (a) and (b), and the
> kernel tries to access it via the direct map, it would result in a
> supervisor not-present page fault.
> 
> Fix the ordering to restore the direct map before the page is freed.
> 
> Link: https://lkml.kernel.org/r/20251031120955.92116-1-lance.yang@linux.dev
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
> Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 6f86d0534fddfbd08687fa0f01479d4226bc3c3d)
> [rppt: replaced folio with page in the patch and in the changelog]
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/secretmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 624663a94808..0c86133ad33f 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  		__SetPageUptodate(page);
>  		err = add_to_page_cache_lru(page, mapping, offset, gfp);
>  		if (unlikely(err)) {
> -			put_page(page);
>  			/*
>  			 * If a split of large page was required, it
>  			 * already happened when we marked the page invalid
>  			 * which guarantees that this call won't fail
>  			 */
>  			set_direct_map_default_noflush(page);
> +			put_page(page);
>  			if (err == -EEXIST)
>  				goto retry;
>  
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

