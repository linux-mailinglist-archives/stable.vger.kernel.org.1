Return-Path: <stable+bounces-240094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOLUHmU+52no5QEAu9opvQ
	(envelope-from <stable+bounces-240094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:07:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0B5438A2E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B2AA3012D58
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EBF2D6409;
	Tue, 21 Apr 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lWKgmMLr"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887536680E
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762205; cv=none; b=YPQNxImptPGGNUi3lj9YDXg6E5XcaoCgDIIGhyBzg4mVIN5+XWUMzh8I7zyW+xV1i4ixT3YMpH8uVIgZEn5DeN5iDp6/W5aEesFtkMllp39zQCa2YIk9kmNE2EePfLMRUz6WNyACRRmmzTM0ozgERbz9zaUnlf/KstAnKM0nnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762205; c=relaxed/simple;
	bh=93hlzJK2HaXPn8jxrJ5tJ/wNE3Kxg0bzJEIUKHWg5C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVRqEwEgRIuUYBKS7F3UtTefMR0WkKg915JcIPxDtbL2HiY6BlDRFhqpuwY2kwDC/o2UWOBjNJWdffDVC80icsV9ci+wwf5wGNPXvNfwP0/5/pp3oBM/wt68X2AfQ+9CcgO/x/zZkYBP/IqGBMu7ApcvSLY0YKw4tXus4geIWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lWKgmMLr; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776762200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcbno30aQf+arGIaZ+mgE/N2zcPrSQwito+V5BR9IcI=;
	b=lWKgmMLrHixk3NnTk1fk/bAMn/tWOyeai/Bm2e7om76q1rs5NbaK8iSO4fVO19SlWq4Uzm
	aCZNOSh2DkRueIyYOODOao4BqcnjX7hFeJ+Zstht2dzhS5zBjHlAFGo/1t0frnKd2jyUeu
	87YkgtY59xQ0iIuf4au95EFxQBtANZY=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org,
	dev.jain@arm.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix initialization of tags of the huge zero folio with init_on_free
Date: Tue, 21 Apr 2026 17:03:06 +0800
Message-Id: <20260421090306.45979-1-lance.yang@linux.dev>
In-Reply-To: <94fdc376-9c43-4334-b293-20a54acbdc3a@kernel.org>
References: <94fdc376-9c43-4334-b293-20a54acbdc3a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240094-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 7C0B5438A2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, Apr 21, 2026 at 10:06:54AM +0200, David Hildenbrand (Arm) wrote:
>On 4/21/26 09:06, Dev Jain wrote:
>> 
>> 
>> On 21/04/26 2:46 am, David Hildenbrand (Arm) wrote:
>>> __GFP_ZEROTAGS semantics are currently a bit weird, but effectively this
>>> flag is only ever set alongside __GFP_ZERO and __GFP_SKIP_KASAN.
>>>
>>> If we run with init_on_free, we will zero out pages during
>>> __free_pages_prepare(), to skip zeroing on the allocation path.
>>>
>>> However, when allocating with __GFP_ZEROTAG set, post_alloc_hook() will
>>> consequently not only skip clearing page content, but also skip
>>> clearing tag memory.
>>>
>>> Not clearing tags through __GFP_ZEROTAGS is irrelevant for most pages that
>>> will get mapped to user space through set_pte_at() later: set_pte_at() and
>>> friends will detect that the tags have not been initialized yet
>>> (PG_mte_tagged not set), and initialize them.
>>>
>>> However, for the huge zero folio, which will be mapped through a PMD
>>> marked as special, this initialization will not be performed, ending up
>>> exposing whatever tags were still set for the pages.
>>>
>>> The docs (Documentation/arch/arm64/memory-tagging-extension.rst) state
>>> that allocation tags are set to 0 when a page is first mapped to user
>>> space. That no longer holds with the huge zero folio when init_on_free
>>> is enabled.
>>>
>>> Fix it by decoupling __GFP_ZEROTAGS from __GFP_ZERO, passing to
>>> tag_clear_highpages() whether we want to also clear page content.
>>>
>>> As we are touching the interface either way, just clean it up by
>>> only calling it when HW tags are enabled, dropping the return value, and
>>> dropping the common code stub.
>>>
>>> Reproduced with the huge zero folio by modifying the check_buffer_fill
>>> arm64/mte selftest to use a 2 MiB area, after making sure that pages have
>>> a non-0 tag set when freeing (note that, during boot, we will not
>>> actually initialize tags, but only set KASAN_TAG_KERNEL in the page
>>> flags).
>>>
>>> 	$ ./check_buffer_fill
>>> 	1..20
>>> 	...
>>> 	not ok 17 Check initial tags with private mapping, sync error mode and mmap memory
>>> 	not ok 18 Check initial tags with private mapping, sync error mode and mmap/mprotect memory
>>> 	...
>>>
>>> This code needs more cleanups; we'll tackle that next, like
>>> decoupling __GFP_ZEROTAGS from __GFP_SKIP_KASAN, moving all the
>>> KASAN magic into a separate helper, and consolidating HW-tag handling.
>>>
>>> Fixes: adfb6609c680 ("mm/huge_memory: initialise the tags of the huge zero folio")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> ---
>>>  arch/arm64/include/asm/page.h |  3 ---
>>>  arch/arm64/mm/fault.c         | 16 +++++-----------
>>>  include/linux/gfp_types.h     | 10 +++++-----
>>>  include/linux/highmem.h       | 10 +---------
>>>  mm/page_alloc.c               | 12 +++++++-----
>>>  5 files changed, 18 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>>> index e25d0d18f6d7..5c6cbfbbd34c 100644
>>> --- a/arch/arm64/include/asm/page.h
>>> +++ b/arch/arm64/include/asm/page.h
>>> @@ -33,9 +33,6 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>>>  						unsigned long vaddr);
>>>  #define vma_alloc_zeroed_movable_folio vma_alloc_zeroed_movable_folio
>>>  
>>> -bool tag_clear_highpages(struct page *to, int numpages);
>>> -#define __HAVE_ARCH_TAG_CLEAR_HIGHPAGES
>>> -
>>>  #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
>>>  
>>>  typedef struct page *pgtable_t;
>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>> index 0f3c5c7ca054..32a3723f2d34 100644
>>> --- a/arch/arm64/mm/fault.c
>>> +++ b/arch/arm64/mm/fault.c
>>> @@ -1018,21 +1018,15 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>>>  	return vma_alloc_folio(flags, 0, vma, vaddr);
>>>  }
>>>  
>>> -bool tag_clear_highpages(struct page *page, int numpages)
>>> +void tag_clear_highpages(struct page *page, int numpages, bool clear_pages)
>>>  {
>>> -	/*
>>> -	 * Check if MTE is supported and fall back to clear_highpage().
>>> -	 * get_huge_zero_folio() unconditionally passes __GFP_ZEROTAGS and
>>> -	 * post_alloc_hook() will invoke tag_clear_highpages().
>>> -	 */
>>> -	if (!system_supports_mte())
>>> -		return false;
>>> -
>>>  	/* Newly allocated pages, shouldn't have been tagged yet */
>>>  	for (int i = 0; i < numpages; i++, page++) {
>>>  		WARN_ON_ONCE(!try_page_mte_tagging(page));
>>> -		mte_zero_clear_page_tags(page_address(page));
>>> +		if (clear_pages)
>>> +			mte_zero_clear_page_tags(page_address(page));
>>> +		else
>>> +			mte_clear_page_tags(page_address(page));
>>>  		set_page_mte_tagged(page);
>>>  	}
>>> -	return true;
>>>  }
>>> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
>>> index 6c75df30a281..fd53a6fba33f 100644
>>> --- a/include/linux/gfp_types.h
>>> +++ b/include/linux/gfp_types.h
>>> @@ -273,11 +273,11 @@ enum {
>>>   *
>>>   * %__GFP_ZERO returns a zeroed page on success.
>>>   *
>>> - * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
>>> - * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
>>> - * __GFP_SKIP_ZERO is not set). This flag is intended for optimization: setting
>>> - * memory tags at the same time as zeroing memory has minimal additional
>>> - * performance impact.
>>> + * %__GFP_ZEROTAGS zeroes memory tags at allocation time. This flag is intended
>>> + * for optimization: setting memory tags at the same time as zeroing memory
>>> + * (e.g., with __GPF_ZERO) has minimal additional performance impact. However,
>>> + * __GFP_ZEROTAGS also zeroes the tags even if memory is not getting zeroed at
>>> + * allocation time (e.g., with init_on_free).
>>>   *
>>>   * %__GFP_SKIP_KASAN makes KASAN skip unpoisoning on page allocation.
>>>   * Used for userspace and vmalloc pages; the latter are unpoisoned by
>>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>>> index af03db851a1d..62f589baa343 100644
>>> --- a/include/linux/highmem.h
>>> +++ b/include/linux/highmem.h
>>> @@ -345,15 +345,7 @@ static inline void clear_highpage_kasan_tagged(struct page *page)
>>>  	kunmap_local(kaddr);
>>>  }
>>>  
>>> -#ifndef __HAVE_ARCH_TAG_CLEAR_HIGHPAGES
>>> -
>>> -/* Return false to let people know we did not initialize the pages */
>>> -static inline bool tag_clear_highpages(struct page *page, int numpages)
>>> -{
>>> -	return false;
>>> -}
>>> -
>>> -#endif
>>> +void tag_clear_highpages(struct page *to, int numpages, bool clear_pages);
>>>  
>>>  /*
>>>   * If we pass in a base or tail page, we can zero up to PAGE_SIZE.
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 65e205111553..8c6821d25a00 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1808,9 +1808,9 @@ static inline bool should_skip_init(gfp_t flags)
>>>  inline void post_alloc_hook(struct page *page, unsigned int order,
>>>  				gfp_t gfp_flags)
>>>  {
>>> +	const bool zero_tags = kasan_hw_tags_enabled() && (gfp_flags & __GFP_ZEROTAGS);
>> 
>> Sashiko:
>> 
>> https://sashiko.dev/#/patchset/20260420-zerotags-v1-1-3edc93e95bb4%40kernel.org
>> 
>> PROT_MTE works without KASAN_HW_TAGS, so probably just retain the
>> system_supports_mte() check in tag_clear_highpages(), and document
>> that GFP_ZEROTAGS is only for MTE?
>
>Right, we have to clear tags here even without kasan. God, what an ugly
>mess people created here with these GFP flags.

Yeah, with kasan=off, kasan_init_hw_tags() returns early, so
kasan_hw_tags_enabled() stays false and tag_clear_highpages() is still
skipped.

With the small debug change below, it still reproduces reliably:

---8<---
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 970e077019b7..d5b6e2474f47 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -225,8 +225,7 @@ static bool get_huge_zero_folio(void)
        if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
                return true;

-       zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) &
-                                ~__GFP_MOVABLE,
+       zero_folio = folio_alloc(GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS,
                        HPAGE_PMD_ORDER);
        if (!zero_folio) {
                count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
---

Cheers,
Lance

