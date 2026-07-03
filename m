Return-Path: <stable+bounces-271629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Me5IKvVIR2qRVQAAu9opvQ
	(envelope-from <stable+bounces-271629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 07:30:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C6D6FEB99
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 07:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=YtDDG9+n;
	dmarc=pass (policy=none) header.from=arm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271629-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271629-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 307473000A47
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 05:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA98359A91;
	Fri,  3 Jul 2026 05:30:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0014A33F58D;
	Fri,  3 Jul 2026 05:30:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056622; cv=none; b=Mr1zp6D+jzZMKz6j4ciR6xzXnRVjwJL1tt0hcP9qo0iuQj6V09g+kcTWsoyU0Rmg/mlaNJoCtjn1FCBsIq00J3UzE/OrRUYTLFqaQUEDp8zvqjU8yYd+dN/J/AiwOiFvCupM2DFs8zKq5XwJAKsGwHfLBGu5kxtPq7nwIdRX+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056622; c=relaxed/simple;
	bh=UFr9Wdq1njDGvt6poz4+T8rHJby7UnZmUIqtj/UdkVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNOAMwYTUzxebshMMi7qKrIomBpEwNj84XX0yQHH3AbSYS7FHkM2lBNg+qq0NbYEmq7zJmV0LPxstwOWsxLUmdeDqu3HwYRL1wu8xB09r/PidWKZ46IeQCtkMsM1TpkE95aMat/T7XBkYevWW56HSG4milpCk+SAthe+a9PdZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YtDDG9+n; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22BD51D14;
	Thu,  2 Jul 2026 22:30:09 -0700 (PDT)
Received: from [10.164.19.15] (unknown [10.164.19.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C07E3F673;
	Thu,  2 Jul 2026 22:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783056613; bh=UFr9Wdq1njDGvt6poz4+T8rHJby7UnZmUIqtj/UdkVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YtDDG9+n6E2IK/NpzkunB8X0k+Xu7zlG2Mf5SenOvVidxgMMYHZg26V+CGrvrecH6
	 Phd+lP85qg5BeenR7AD3hjvJsYiHZNu7FLsqlY3Hi9oaCyU7BotAHiGSuPCbr1ubOC
	 BlLtVt9t0QMmj5jX0Bv5+rJ7pk5lVZwwL53kf6vU=
Message-ID: <1b1f6281-2a46-4811-bbea-24a666c0a772@arm.com>
Date: Fri, 3 Jul 2026 11:00:01 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
To: "David Hildenbrand (Arm)" <david@kernel.org>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, ljs@kernel.org,
 liam@infradead.org
Cc: riel@surriel.com, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, kas@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcampbell@nvidia.com, apopple@nvidia.com,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, j-nomura@ce.jp.nec.com,
 nao.horiguchi@gmail.com, ak@linux.intel.com, mel@csn.ul.ie,
 pfalcato@suse.de, jpoimboe@kernel.org, dave.hansen@intel.com,
 tglx@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20260702051341.126509-1-dev.jain@arm.com>
 <20260702051341.126509-3-dev.jain@arm.com>
 <00d6e0fb-dcba-45d5-98c0-f5ed81604ca0@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <00d6e0fb-dcba-45d5-98c0-f5ed81604ca0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	TAGGED_FROM(0.00)[bounces-271629-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:muchun.song@linux.dev,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:liam@infradead.org,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:lance.yang@linux.dev,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:j-nomura@ce.jp.nec.com,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:mel@csn.ul.ie,m:pfalcato@suse.de,m:jpoimboe@kernel.org,m:dave.hansen@intel.com,m:tglx@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[surriel.com,kernel.org,google.com,linux.dev,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,ce.jp.nec.com,linux.intel.com,csn.ul.ie,suse.de,arm.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,arm.com:from_mime,arm.com:email,arm.com:mid,arm.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02C6D6FEB99



On 02/07/26 9:02 pm, David Hildenbrand (Arm) wrote:
> On 7/2/26 07:13, Dev Jain wrote:
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
>> Reported-by: David Hildenbrand <david@kernel.org>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>  include/linux/hugetlb.h |  3 +++
>>  mm/rmap.c               | 16 ++++++++++------
>>  2 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 2abaf99321e90..fdb7bdf7645c5 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -1261,6 +1261,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
>>  {
>>  }
>>  
>> +pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
>> +		    pte_t *ptep);
> 
> Two tabs, or just in a single line.
> 
> If others prefer a stub, I don't care. This here is shortest to let the linker
> bail out.
> 
>> +
>>  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>  					  unsigned long addr, pte_t *ptep)
>>  {
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 1c77d5dc06e9f..aa8a254efaecc 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2095,11 +2095,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>  		/* Unexpected PMD-mapped THP? */
>>  		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>  
>> -		/*
>> -		 * Handle PFN swap PTEs, such as device-exclusive ones, that
>> -		 * actually map pages.
>> -		 */
> 
> That comment now actually belongs above the pte_present() check below.

Oops I mindlessly just copied the comment.

I will then rather put it in the else block which gets the pfn from the softleaf,
that is the most appropriate.

> 
> 


