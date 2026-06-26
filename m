Return-Path: <stable+bounces-268720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sySKKwD7PWp99wgAu9opvQ
	(envelope-from <stable+bounces-268720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:07:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B43C96CA0A9
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:07:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=Fj8zaU+K;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268720-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268720-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4903D3015620
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD983A1E81;
	Fri, 26 Jun 2026 04:06:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6A93A16A0;
	Fri, 26 Jun 2026 04:06:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782446797; cv=none; b=Qlp3+q59WkXRIthitheP0nDie/j/k3HVMPodithNkZg4MOrZrBVVi0+C37VXEjjJFyIES7lk3DwHsc44puNbq9iXK1IsrEqGEWtLns4GdTI2EZoesXiILfCAlqoCl9m7V+//mAXOKhGImaTHeCXod2k8Iua73liOuErvxTZYZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782446797; c=relaxed/simple;
	bh=rEMshQHon41Sg38Z8NXkpcWJh3M8Bi896t94h433fu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ig6SHCleYlEWtqIFm6QZT911UMpt1XykWYt90M6d2ZRu1GBF899xNO8tozzafWwhKmdz6IwbciK0rU4GS+2SBlmHoMMy0XhubqblW9K3lf4qNUCwLRD3RUCmxgkvBauVzFl6W6uaUpUuoXmYT44VVf/4dodi0Rpd0DaN9YPYr6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fj8zaU+K; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B59C2309;
	Thu, 25 Jun 2026 21:06:30 -0700 (PDT)
Received: from [10.164.148.34] (MacBook-Pro.blr.arm.com [10.164.148.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFB573F905;
	Thu, 25 Jun 2026 21:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782446794; bh=rEMshQHon41Sg38Z8NXkpcWJh3M8Bi896t94h433fu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fj8zaU+KPHJaPRvKjc/hx7/6ra0teS9xSYnQ+26ogUvddNXmmNlv7QhKU25xMSAlN
	 Wq2zLYewpTt7pliGi/d2ekpdihLOYB0/51RInxgvGHjGx+Vzf7VubYlS9fDgcfpi4B
	 nV2D7k10xIHvTUErKhQKj/rkOvgkEaAxZJPyvZTg=
Message-ID: <117fed1e-971d-4e31-a358-7a03f3db8338@arm.com>
Date: Fri, 26 Jun 2026 09:36:21 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
To: Lance Yang <lance.yang@linux.dev>
Cc: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
 ljs@kernel.org, david@kernel.org, liam@infradead.org, riel@surriel.com,
 vbabka@kernel.org, harry@kernel.org, jannh@google.com, kas@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcampbell@nvidia.com,
 apopple@nvidia.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, mel@csn.ul.ie,
 nao.horiguchi@gmail.com, ak@linux.intel.com, j-nomura@ce.jp.nec.com,
 pfalcato@suse.de, dave.hansen@intel.com, tglx@kernel.org,
 jpoimboe@kernel.org, ryan.roberts@arm.com, anshuman.khandual@arm.com,
 stable@vger.kernel.org
References: <20260625112955.3254283-5-dev.jain@arm.com>
 <20260626023127.60788-1-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260626023127.60788-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-268720-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,suse.de,linux-foundation.org,kernel.org,infradead.org,surriel.com,google.com,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,arm.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B43C96CA0A9



On 26/06/26 8:01 am, Lance Yang wrote:
> 
> On Thu, Jun 25, 2026 at 11:29:53AM +0000, Dev Jain wrote:
>> check_pte() is the final validation step in page_vma_mapped_walk().
>> It reads pvmw->pte with ptep_get() to decide whether the entry maps
>> the PFN range being walked. For hugetlb VMAs, that pointer refers
>> to a hugetlb entry.
>>
>> On arches which provide their own huge_ptep_get() to dereference a huge
>> pte pointer, accessing via ptep_get() would cause pte_pfn(),
>> pte_present() etc to misbehave.
>>
>> It is not clear whether this has a trivially visible effect to userspace.
>>
>> Use huge_ptep_get() to dereference a huge pte pointer.
>>
>> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> mm/page_vma_mapped.c | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 2ccbabfb2cc17..18e1d341f463c 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -107,7 +107,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>> static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
> 
> Just one ordering thing: should this patch come first?
> 
> Patches #01-#03 only reach the new huge_ptep_get() after
> page_vma_mapped_walk() succeeds. But before this patch, hugetlb sill
> goes through check_pte() (still using ptep_get()).

You are right, but do we care? This is not a series meant for adding functionality.
I just sent it as a series because they are similar fixes - the patches are to
be applied individually with no dependency.
> 
>> {
>> 	unsigned long pfn;
>> -	pte_t ptent = ptep_get(pvmw->pte);
>> +	pte_t ptent;
>> +
>> +	if (is_vm_hugetlb_page(pvmw->vma))
>> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>> +				      pvmw->pte);
>> +	else
>> +		ptent = ptep_get(pvmw->pte);
>>
>> 	if (pvmw->flags & PVMW_MIGRATION) {
>> 		const softleaf_t entry = softleaf_from_pte(ptent);
>> -- 
>> 2.43.0
>>
>>
> 


