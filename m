Return-Path: <stable+bounces-268719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AM30IP/6PWp89wgAu9opvQ
	(envelope-from <stable+bounces-268719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:07:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3802F6CA0A1
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:07:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=o+AR3peA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268719-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268719-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7322304E96D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB83A380A;
	Fri, 26 Jun 2026 04:04:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC33A2572;
	Fri, 26 Jun 2026 04:04:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782446648; cv=none; b=luQXKUkrY4d2Ber5X8vksAgR5oE50GBuqTn1Vi3+D5yyqChHIEpVA/cbtiuTmEPKcJ9Q3ZBLev+PuxHqpY9Ol1UK4wm8NgIin94JHNdBoeN2I8bdsIMCYdH199LNP2qUDYbW4UyUP4wfsi1CL9m35Kqip2sub2m65yrR1sJ7tTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782446648; c=relaxed/simple;
	bh=qyp2lulHzizESS3VvJ7MUIf08zH9IfJSzEnsUhYQo1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjiSww8f4XNr2r39bqHBvWXRcavFrBN9fFGa+8+2G38ob1Kc+rMF2YiQcVWhms16F9xmPAx1Ond0B+fP7HHciW9hvouLtN7sdv/AuyaQ+gcLDjWGD79DQh3qAHzP+28JH+TtTcxVSE55crpVTIDk8VBTsEHTegsVZZkjh4FLzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=o+AR3peA; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F4E522F8;
	Thu, 25 Jun 2026 21:04:00 -0700 (PDT)
Received: from [10.164.148.34] (MacBook-Pro.blr.arm.com [10.164.148.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EEBB3F905;
	Thu, 25 Jun 2026 21:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782446644; bh=qyp2lulHzizESS3VvJ7MUIf08zH9IfJSzEnsUhYQo1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o+AR3peAt7q1C40S6W9MFppuxdb25CQLrAWrtR13P67RSWbzktHKG5lZr8q7a84lq
	 wXTAJUGfJaxcfotOWBWHCI3yYbLBuaBROgfdM4EpzGrwrqycBu5myzKUrHNm74dPhl
	 OdlvlXwuj66UdCC8fFH6txyGOC040Gj+OZQvifGI=
Message-ID: <4619650f-28b5-4fb4-91be-50daa0b4d84b@arm.com>
Date: Fri, 26 Jun 2026 09:33:45 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
To: Muchun Song <muchun.song@linux.dev>
Cc: riel@surriel.com, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, kas@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcampbell@nvidia.com, apopple@nvidia.com,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, mel@csn.ul.ie, nao.horiguchi@gmail.com,
 ak@linux.intel.com, j-nomura@ce.jp.nec.com, pfalcato@suse.de,
 dave.hansen@intel.com, tglx@kernel.org, jpoimboe@kernel.org,
 ryan.roberts@arm.com, anshuman.khandual@arm.com, stable@vger.kernel.org,
 osalvador@suse.de, akpm@linux-foundation.org, ljs@kernel.org,
 david@kernel.org, liam@infradead.org
References: <20260625112955.3254283-1-dev.jain@arm.com>
 <20260625112955.3254283-2-dev.jain@arm.com>
 <f8516534-3b18-4988-b384-251225755285@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <f8516534-3b18-4988-b384-251225755285@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-268719-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muchun.song@linux.dev,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:lance.yang@linux.dev,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[surriel.com,kernel.org,google.com,linux.dev,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,suse.de,arm.com,linux-foundation.org,infradead.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3802F6CA0A1



On 26/06/26 8:47 am, Muchun Song wrote:
> 
> 
> On 2026/6/25 19:29, Dev Jain wrote:
>> try_to_unmap_one() handles hugetlb folios when memory failure needs
>> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
>> case page_vma_mapped_walk() returns the pte pointer to the hugetlb folio
>> in pvmw.pte, but the code reads it with ptep_get().
>>
>> On arches which provide their own huge_ptep_get() to dereference a huge
>> pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
>> etc to misbehave.
>>
>> It is not clear whether this has a trivially visible effect to userspace.
>>
>> Just use huge_ptep_get() for dereferencing a huge pte pointer.
>>
>> Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   include/linux/hugetlb.h |  3 +++
>>   mm/rmap.c               | 16 ++++++++++------
>>   2 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 2abaf99321e90..fdb7bdf7645c5 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -1261,6 +1261,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
>>   {
>>   }
>>   +pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
>> +            pte_t *ptep);
> 
> Thanks so much for the fix! I'm curious, though: why do we
> need to add a separate declaration for this function here?

For !CONFIG_HUGETLB_PAGE, compiler complains that there is no huge_ptep_get.
So this is to make compiler happy.

> 
> Thanks,
> Muchun
> 
>> +
>>   static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>                         unsigned long addr, pte_t *ptep)
>>   {
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 1c77d5dc06e9f..aa8a254efaecc 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2095,11 +2095,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>           /* Unexpected PMD-mapped THP? */
>>           VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>   -        /*
>> -         * Handle PFN swap PTEs, such as device-exclusive ones, that
>> -         * actually map pages.
>> -         */
>> -        pteval = ptep_get(pvmw.pte);
>> +        address = pvmw.address;
>> +        if (folio_test_hugetlb(folio)) {
>> +            pteval = huge_ptep_get(mm, address, pvmw.pte);
>> +        } else {
>> +            /*
>> +             * Handle PFN swap PTEs, such as device-exclusive ones,
>> +             * that actually map pages.
>> +             */
>> +            pteval = ptep_get(pvmw.pte);
>> +        }
>>           if (likely(pte_present(pteval))) {
>>               pfn = pte_pfn(pteval);
>>           } else {
>> @@ -2110,7 +2115,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>           }
>>             subpage = folio_page(folio, pfn - folio_pfn(folio));
>> -        address = pvmw.address;
>>           anon_exclusive = folio_test_anon(folio) &&
>>                    PageAnonExclusive(subpage);
>>   
> 


