Return-Path: <stable+bounces-270378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZuSyEoAtRmqgLAsAu9opvQ
	(envelope-from <stable+bounces-270378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 11:21:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CF86F52CA
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 11:21:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=CeY7Yl2Q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270378-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270378-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 146B33115D7A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB0142E8FF;
	Thu,  2 Jul 2026 08:47:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A7D2D1907
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:47:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982053; cv=none; b=EY4l17ZE7ncE25FCcVfF/wFPr5esuSkGoMSVBhcJEHYPbAh8jfu5Z2INacy2WYFYn1/JuAa0LtkxzbrAPBegl5Mq+6zOUJNpOeNuKlBShSK1P2+YmUz4/V9taUo4GHn34bDXOZK++msWTaVmhyeeBr3x9yhfJfW0zCBKPL24RpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982053; c=relaxed/simple;
	bh=c0d8lIGwWhqUE/QJk4uCY/3fttioh0Q0bV69uMJ9tyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc6Fe0HW/uDg7UeF10sGZUw2y6o7twtpDfQuNkbNqECD/fM4aeZ6nqyi8ISKIe8Cv4FSQQ1z8AQZu5vuKa37Tz2MoT6vfKCwJ5YTIFRXgfKXXqx6MqImioV4Wddhzl+1u5WGY4YGW201uLjfR7A2VaJa8qF8DMY6Mq/eBCjIGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CeY7Yl2Q; arc=none smtp.client-ip=95.215.58.177
Message-ID: <97a43d82-28c2-4f98-ad74-fe05ed9f0297@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782982049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0OA6sDR9xVrofWsz20wyHhFk3GqcE2ce4sWlpq82E8=;
	b=CeY7Yl2QeKZhrbQj/DcuVaDk/ScIJ/I13EQpZ8mQWaTSWVTAnJI6dr9QSnz88wDdAg8sKv
	Xt0Xi5Hd5b9ixMNZeCeiv8WObh/juzMGC6+hdTsDG80pj5Ut11tptk+UKPF6hyl/40jjAo
	Se6oTrt1q3oy4yS28IgmbRN4YnIsWTU=
Date: Thu, 2 Jul 2026 16:47:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/6] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
To: Dev Jain <dev.jain@arm.com>
Cc: riel@surriel.com, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, kas@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcampbell@nvidia.com, apopple@nvidia.com,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, nao.horiguchi@gmail.com, ak@linux.intel.com,
 mel@csn.ul.ie, pfalcato@suse.de, jpoimboe@kernel.org, dave.hansen@intel.com,
 tglx@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org, osalvador@suse.de,
 akpm@linux-foundation.org, ljs@kernel.org, david@kernel.org,
 liam@infradead.org
References: <20260702051341.126509-1-dev.jain@arm.com>
 <20260702051341.126509-3-dev.jain@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260702051341.126509-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270378-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_RECIPIENTS(0.00)[m:dev.jain@arm.com,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:lance.yang@linux.dev,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:mel@csn.ul.ie,m:pfalcato@suse.de,m:jpoimboe@kernel.org,m:dave.hansen@intel.com,m:tglx@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[surriel.com,kernel.org,google.com,linux.dev,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,linux.intel.com,csn.ul.ie,suse.de,arm.com,lists.infradead.org,linux-foundation.org,infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2CF86F52CA



On 2026/7/2 13:13, Dev Jain wrote:
> try_to_unmap_one() handles hugetlb folios when memory failure needs
> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
> case page_vma_mapped_walk() returns the pte pointer to the hugetlb folio
> in pvmw.pte, but the code reads it with ptep_get().
>
> On arches which provide their own huge_ptep_get() to dereference a huge
> pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
> etc to misbehave.
>
> It is not clear whether this has a trivially visible effect to userspace.
>
> Just use huge_ptep_get() for dereferencing a huge pte pointer.
>
> Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
> Cc: stable@vger.kernel.org
> Reported-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   include/linux/hugetlb.h |  3 +++
>   mm/rmap.c               | 16 ++++++++++------
>   2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 2abaf99321e90..fdb7bdf7645c5 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1261,6 +1261,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
>   {
>   }
>   
> +pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
> +		    pte_t *ptep);
> +

Maybe I didn't express my thoughts clearly in the first version, let me
explain in more detail.

We should define this stub as a no-op for !CONFIG_HUGETLB_PAGE (like
set_huge_pte_at, that is why I mentioned 5d4af6195c87c6 for your reference
in your previous version). Currently, you've added a declaration, but the
function itself doesn't actually exist, which seems quite strange to me.

Muchun,
Thanks.
>   static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					  unsigned long addr, pte_t *ptep)
>   {
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1c77d5dc06e9f..aa8a254efaecc 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2095,11 +2095,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   		/* Unexpected PMD-mapped THP? */
>   		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>   
> -		/*
> -		 * Handle PFN swap PTEs, such as device-exclusive ones, that
> -		 * actually map pages.
> -		 */
> -		pteval = ptep_get(pvmw.pte);
> +		address = pvmw.address;
> +		if (folio_test_hugetlb(folio)) {
> +			pteval = huge_ptep_get(mm, address, pvmw.pte);
> +		} else {
> +			/*
> +			 * Handle PFN swap PTEs, such as device-exclusive ones,
> +			 * that actually map pages.
> +			 */
> +			pteval = ptep_get(pvmw.pte);
> +		}
>   		if (likely(pte_present(pteval))) {
>   			pfn = pte_pfn(pteval);
>   		} else {
> @@ -2110,7 +2115,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   		}
>   
>   		subpage = folio_page(folio, pfn - folio_pfn(folio));
> -		address = pvmw.address;
>   		anon_exclusive = folio_test_anon(folio) &&
>   				 PageAnonExclusive(subpage);
>   


