Return-Path: <stable+bounces-240076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OqBLS4w52n45AEAu9opvQ
	(envelope-from <stable+bounces-240076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:07:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF57437F70
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9EE83003711
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80829386436;
	Tue, 21 Apr 2026 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkHP9WZM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1CB175A87;
	Tue, 21 Apr 2026 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776758823; cv=none; b=FYdb91jFE8zLCku4tY4ccfkfcrzREoyfnkhNey4JHR82FryUpkrezyi/Hugqol6TNiufc11e/9yolFXlPlErd47aQMVIedbWzIbabL7Gls/IAvxnzjhJGPfp1JxK0wA0T4xT5dMynWmjbfXxgUdJbJcx1ntMrk90rsHr2kxd+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776758823; c=relaxed/simple;
	bh=fdxo8CBTBMGIc3yr4yHUHEx/bRkybwgOmKvLGUkEwuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juDXfb5gxctYsv0+F7UOm0R8umVKK635BT27Kpg0wJDCav4rJUKIveTebEuYzF9pEwrv8ZocRDzKpq+GwthddL9TuSZzn4KwFaD11vw2FkTdT4Hy/E02R13Lj/ogAaQpvlzrCgWkNBxxp141AV9IHereUni3+T/jEJYrwjDh4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkHP9WZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577C1C2BCB0;
	Tue, 21 Apr 2026 08:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776758822;
	bh=fdxo8CBTBMGIc3yr4yHUHEx/bRkybwgOmKvLGUkEwuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fkHP9WZMtMW5sgVsB+YoXCot12XyGdRt1TFMtbL56ucDBBK+s8jiqOmho52rufvSB
	 QHc7oSIGFJkqtFHvqanqKiqBoXAVB7roFy73N4XUBGkhynYpWpVGSSIXzWLklX1Ck8
	 C68pQfk8ae+SKy/vW6MW9gnQqedUeMGWSXi/TlcXtegwXiRhD4rDXqq9n6jHESxGX5
	 2h4i9L6h4Xgj2r/4lQpSd0L/lvHQKrlsS6uP+Un1aTnzD2h+A1h/tGwsWWRNcS2OPT
	 ZYl9QIQVE79v68IRj4cs6nHO9a2vHJeyZOwqncIPqxi/Qc5abvxPa4luVIuREwD0XT
	 6IehlROdf+4Og==
Message-ID: <94fdc376-9c43-4334-b293-20a54acbdc3a@kernel.org>
Date: Tue, 21 Apr 2026 10:06:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: fix initialization of tags of the huge
 zero folio with init_on_free
To: Dev Jain <dev.jain@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Lance Yang <lance.yang@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20260420-zerotags-v1-1-3edc93e95bb4@kernel.org>
 <5463cf34-bd8c-4ecb-b93a-fd8b2bd2976d@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <5463cf34-bd8c-4ecb-b93a-fd8b2bd2976d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240076-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADF57437F70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 09:06, Dev Jain wrote:
> 
> 
> On 21/04/26 2:46 am, David Hildenbrand (Arm) wrote:
>> __GFP_ZEROTAGS semantics are currently a bit weird, but effectively this
>> flag is only ever set alongside __GFP_ZERO and __GFP_SKIP_KASAN.
>>
>> If we run with init_on_free, we will zero out pages during
>> __free_pages_prepare(), to skip zeroing on the allocation path.
>>
>> However, when allocating with __GFP_ZEROTAG set, post_alloc_hook() will
>> consequently not only skip clearing page content, but also skip
>> clearing tag memory.
>>
>> Not clearing tags through __GFP_ZEROTAGS is irrelevant for most pages that
>> will get mapped to user space through set_pte_at() later: set_pte_at() and
>> friends will detect that the tags have not been initialized yet
>> (PG_mte_tagged not set), and initialize them.
>>
>> However, for the huge zero folio, which will be mapped through a PMD
>> marked as special, this initialization will not be performed, ending up
>> exposing whatever tags were still set for the pages.
>>
>> The docs (Documentation/arch/arm64/memory-tagging-extension.rst) state
>> that allocation tags are set to 0 when a page is first mapped to user
>> space. That no longer holds with the huge zero folio when init_on_free
>> is enabled.
>>
>> Fix it by decoupling __GFP_ZEROTAGS from __GFP_ZERO, passing to
>> tag_clear_highpages() whether we want to also clear page content.
>>
>> As we are touching the interface either way, just clean it up by
>> only calling it when HW tags are enabled, dropping the return value, and
>> dropping the common code stub.
>>
>> Reproduced with the huge zero folio by modifying the check_buffer_fill
>> arm64/mte selftest to use a 2 MiB area, after making sure that pages have
>> a non-0 tag set when freeing (note that, during boot, we will not
>> actually initialize tags, but only set KASAN_TAG_KERNEL in the page
>> flags).
>>
>> 	$ ./check_buffer_fill
>> 	1..20
>> 	...
>> 	not ok 17 Check initial tags with private mapping, sync error mode and mmap memory
>> 	not ok 18 Check initial tags with private mapping, sync error mode and mmap/mprotect memory
>> 	...
>>
>> This code needs more cleanups; we'll tackle that next, like
>> decoupling __GFP_ZEROTAGS from __GFP_SKIP_KASAN, moving all the
>> KASAN magic into a separate helper, and consolidating HW-tag handling.
>>
>> Fixes: adfb6609c680 ("mm/huge_memory: initialise the tags of the huge zero folio")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  arch/arm64/include/asm/page.h |  3 ---
>>  arch/arm64/mm/fault.c         | 16 +++++-----------
>>  include/linux/gfp_types.h     | 10 +++++-----
>>  include/linux/highmem.h       | 10 +---------
>>  mm/page_alloc.c               | 12 +++++++-----
>>  5 files changed, 18 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>> index e25d0d18f6d7..5c6cbfbbd34c 100644
>> --- a/arch/arm64/include/asm/page.h
>> +++ b/arch/arm64/include/asm/page.h
>> @@ -33,9 +33,6 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>>  						unsigned long vaddr);
>>  #define vma_alloc_zeroed_movable_folio vma_alloc_zeroed_movable_folio
>>  
>> -bool tag_clear_highpages(struct page *to, int numpages);
>> -#define __HAVE_ARCH_TAG_CLEAR_HIGHPAGES
>> -
>>  #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
>>  
>>  typedef struct page *pgtable_t;
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 0f3c5c7ca054..32a3723f2d34 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -1018,21 +1018,15 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>>  	return vma_alloc_folio(flags, 0, vma, vaddr);
>>  }
>>  
>> -bool tag_clear_highpages(struct page *page, int numpages)
>> +void tag_clear_highpages(struct page *page, int numpages, bool clear_pages)
>>  {
>> -	/*
>> -	 * Check if MTE is supported and fall back to clear_highpage().
>> -	 * get_huge_zero_folio() unconditionally passes __GFP_ZEROTAGS and
>> -	 * post_alloc_hook() will invoke tag_clear_highpages().
>> -	 */
>> -	if (!system_supports_mte())
>> -		return false;
>> -
>>  	/* Newly allocated pages, shouldn't have been tagged yet */
>>  	for (int i = 0; i < numpages; i++, page++) {
>>  		WARN_ON_ONCE(!try_page_mte_tagging(page));
>> -		mte_zero_clear_page_tags(page_address(page));
>> +		if (clear_pages)
>> +			mte_zero_clear_page_tags(page_address(page));
>> +		else
>> +			mte_clear_page_tags(page_address(page));
>>  		set_page_mte_tagged(page);
>>  	}
>> -	return true;
>>  }
>> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
>> index 6c75df30a281..fd53a6fba33f 100644
>> --- a/include/linux/gfp_types.h
>> +++ b/include/linux/gfp_types.h
>> @@ -273,11 +273,11 @@ enum {
>>   *
>>   * %__GFP_ZERO returns a zeroed page on success.
>>   *
>> - * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
>> - * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
>> - * __GFP_SKIP_ZERO is not set). This flag is intended for optimization: setting
>> - * memory tags at the same time as zeroing memory has minimal additional
>> - * performance impact.
>> + * %__GFP_ZEROTAGS zeroes memory tags at allocation time. This flag is intended
>> + * for optimization: setting memory tags at the same time as zeroing memory
>> + * (e.g., with __GPF_ZERO) has minimal additional performance impact. However,
>> + * __GFP_ZEROTAGS also zeroes the tags even if memory is not getting zeroed at
>> + * allocation time (e.g., with init_on_free).
>>   *
>>   * %__GFP_SKIP_KASAN makes KASAN skip unpoisoning on page allocation.
>>   * Used for userspace and vmalloc pages; the latter are unpoisoned by
>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>> index af03db851a1d..62f589baa343 100644
>> --- a/include/linux/highmem.h
>> +++ b/include/linux/highmem.h
>> @@ -345,15 +345,7 @@ static inline void clear_highpage_kasan_tagged(struct page *page)
>>  	kunmap_local(kaddr);
>>  }
>>  
>> -#ifndef __HAVE_ARCH_TAG_CLEAR_HIGHPAGES
>> -
>> -/* Return false to let people know we did not initialize the pages */
>> -static inline bool tag_clear_highpages(struct page *page, int numpages)
>> -{
>> -	return false;
>> -}
>> -
>> -#endif
>> +void tag_clear_highpages(struct page *to, int numpages, bool clear_pages);
>>  
>>  /*
>>   * If we pass in a base or tail page, we can zero up to PAGE_SIZE.
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 65e205111553..8c6821d25a00 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1808,9 +1808,9 @@ static inline bool should_skip_init(gfp_t flags)
>>  inline void post_alloc_hook(struct page *page, unsigned int order,
>>  				gfp_t gfp_flags)
>>  {
>> +	const bool zero_tags = kasan_hw_tags_enabled() && (gfp_flags & __GFP_ZEROTAGS);
> 
> Sashiko:
> 
> https://sashiko.dev/#/patchset/20260420-zerotags-v1-1-3edc93e95bb4%40kernel.org
> 
> PROT_MTE works without KASAN_HW_TAGS, so probably just retain the
> system_supports_mte() check in tag_clear_highpages(), and document
> that GFP_ZEROTAGS is only for MTE?

Right, we have to clear tags here even without kasan. God, what an ugly
mess people created here with these GFP flags.

Let me think about how to do that in the least ugly way.

-- 
Cheers,

David

