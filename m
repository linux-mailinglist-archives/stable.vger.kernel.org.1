Return-Path: <stable+bounces-195160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2FC6D89C
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 09:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5A0822A6CD
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E6C32E730;
	Wed, 19 Nov 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3SKLotS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3465132ED44
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542685; cv=none; b=BvgbNPf7G3FTUlq09YtqxY3KY8UweZJi6g+shHY6d89pXRO7VPi3oPg8g+TM7rNr1lgXQ49DQDaQf672aoekIekD6bIQRll/oY1feoVxDMiA2QUWLRV/p0D29k1FLlKXO3nKHjw5xXCg+fTm3dIXLPRtAEeJivbvEjSyu5q4WRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542685; c=relaxed/simple;
	bh=SEyrQRN6vxWoOkBDR/9CmO79XgbuxRdUsBZ9vRIt9XQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGGEheV5MKF7/DzOi/00BlKYf/b11y40q+F7f6xLJQXtO9LUBm4En4l2kY5Ckexg5hRPeCgc4cSp2C7nxNBa6s4iAGU4fkHRNEyeZ2eWHloLFqYYiYnY/aYHrcLFbu2g+iy5+lvpgK5Z1h/AzOa95vW7bJdTVU8U5m/Z4s389cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3SKLotS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F14C19421;
	Wed, 19 Nov 2025 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763542684;
	bh=SEyrQRN6vxWoOkBDR/9CmO79XgbuxRdUsBZ9vRIt9XQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P3SKLotSQD/ek/OairstDSQ9az94gG0MpogyOM85oXkDwzdCT9p7R5Ytq6xzjlsPB
	 WYUHTFBPWFMIxosKwStrZl8m++04ArWKDevNP0/fFWu+uZEcPbYZwQRsilaPmZsxqM
	 WzL1iO9XjczlkSXxW+Q9iwqUXrxBCzlKoCDqstz1IcqV2J353BGLKM+XwBmVLHDQ9u
	 AYK9IjbHcqx1q0cB7AhB/6ZMOUeaCp0kR4EyBO9DdCcLMC2uk/AP8x9gcuq8HzNqbd
	 uCMw1yyUp+cmjztWQBpcT8OJn07t4DVJRxTmYk5JjGB53GaIGeOTgIrhvQs7S73jhS
	 ojEZbG5T29FNg==
Message-ID: <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
Date: Wed, 19 Nov 2025 09:57:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when splitting
 shmem folio in swap cache
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251119012630.14701-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.25 02:26, Wei Yang wrote:
> Commit c010d47f107f ("mm: thp: split huge page to any lower order
> pages") introduced an early check on the folio's order via
> mapping->flags before proceeding with the split work.
> 
> This check introduced a bug: for shmem folios in the swap cache, the
> mapping pointer can be NULL. Accessing mapping->flags in this state
> leads directly to a NULL pointer dereference.

Under which circumstances would that be the case? Only for large shmem 
folios in the swapcache or also for truncated folios? So I'd assume this
would also affect truncated folios and we should spell that out here?

> 
> This commit fixes the issue by moving the check for mapping != NULL
> before any attempt to access mapping->flags.
> 
> This fix necessarily changes the return value from -EBUSY to -EINVAL
> when mapping is NULL. After reviewing current callers, they do not
> differentiate between these two error codes, making this change safe.

The doc of __split_huge_page_to_list_to_order() would now be outdated 
and has to be updated.

Also, take a look at s390_wiggle_split_folio(): returning -EINVAL 
instead of -EBUSY will make a difference on concurrent truncation. 
-EINVAL will be propagated and make the operation fail, while -EBUSY 
will be translated to -EAGAIN and the caller will simply lookup the 
folio again and retry.

So I think we should try to keep truncation return -EBUSY. For the shmem 
case, I think it's ok to return -EINVAL. I guess we can identify such 
folios by checking for folio_test_swapcache().


Probably worth mentioning that this was identified by code inspection?

> 
> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: <stable@vger.kernel.org>

Hmm, what would this patch look like when based on current upstream? 
We'd likely want to get that upstream asap.

> 
> ---
> 
> This patch is based on current mm-new, latest commit:
> 
>      056b93566a35 mm/vmalloc: warn only once when vmalloc detect invalid gfp flags
> 
> Backport note:
> 
> Current code evolved from original commit with following four changes.
> We should do proper adjustment respectively on backporting.
> 
> commit c010d47f107f609b9f4d6a103b6dfc53889049e9
> Author: Zi Yan <ziy@nvidia.com>
> Date:   Mon Feb 26 15:55:33 2024 -0500
> 
>      mm: thp: split huge page to any lower order pages
> 
> commit 6a50c9b512f7734bc356f4bd47885a6f7c98491a
> Author: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Date:   Fri Jun 7 17:40:48 2024 +0800
> 
>      mm: huge_memory: fix misused mapping_large_folio_support() for anon folios
> 
> commit 9b2f764933eb5e3ac9ebba26e3341529219c4401
> Author: Zi Yan <ziy@nvidia.com>
> Date:   Wed Jan 22 11:19:27 2025 -0500
> 
>      mm/huge_memory: allow split shmem large folio to any lower order
> 
> commit 58729c04cf1092b87aeef0bf0998c9e2e4771133
> Author: Zi Yan <ziy@nvidia.com>
> Date:   Fri Mar 7 12:39:57 2025 -0500
> 
>      mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
> ---
>   mm/huge_memory.c | 68 +++++++++++++++++++++++++-----------------------
>   1 file changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7c69572b6c3f..8701c3eef05f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3696,29 +3696,42 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>   				"Cannot split to order-1 folio");
>   		if (new_order == 1)
>   			return false;
> -	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
> -		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> -		    !mapping_large_folio_support(folio->mapping)) {
> -			/*
> -			 * We can always split a folio down to a single page
> -			 * (new_order == 0) uniformly.
> -			 *
> -			 * For any other scenario
> -			 *   a) uniform split targeting a large folio
> -			 *      (new_order > 0)
> -			 *   b) any non-uniform split
> -			 * we must confirm that the file system supports large
> -			 * folios.
> -			 *
> -			 * Note that we might still have THPs in such
> -			 * mappings, which is created from khugepaged when
> -			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
> -			 * case, the mapping does not actually support large
> -			 * folios properly.
> -			 */
> -			VM_WARN_ONCE(warns,
> -				"Cannot split file folio to non-0 order");
> +	} else {


Why not simply

} else if (!folio->mapping) {
	/*
	 * Truncated?
	...
	return false;
} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
...

> +		const struct address_space *mapping = folio->mapping;
> +
> +		/* Truncated ? */
> +		/*
> +		 * TODO: add support for large shmem folio in swap cache.
> +		 * When shmem is in swap cache, mapping is NULL and
> +		 * folio_test_swapcache() is true.
> +		 */

While at it, can we merge the two comments into something, like:

/*
  * If there is no mapping that the folio was truncated and we cannot
  * split.
  *
  * TODO: large shmem folio in the swap cache also don't currently have a
  * mapping but folio_test_swapcache() is true for them.
  */

-- 
Cheers

David

