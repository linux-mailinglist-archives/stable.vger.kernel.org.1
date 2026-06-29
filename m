Return-Path: <stable+bounces-269674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aev2MnIrQmoi1QkAu9opvQ
	(envelope-from <stable+bounces-269674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 10:23:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E06D7773
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 10:23:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ev1aNmXq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269674-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269674-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D9A6300D1FE
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 08:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D033C1099;
	Mon, 29 Jun 2026 08:23:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498233ADAC
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721391; cv=none; b=CsyK3a7XU3gxsYu0W0GFuJ4BXl+Ii0Viun8anGgwyB46UGkBU5eAqB7mEk0q3u6ZyWEqY2AlogmAxfKEz5q5KQ60u1HQclY5k37WQlYCWx3ePZYctoAL1fY9eFCGs6SUOqgH0n4aqpfj5OCdPnhsLF9UMhWdp1gI9fTe8HTbMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721391; c=relaxed/simple;
	bh=YxIPHSNC47f3A+LcnpLMRfV9Z1FvXBtSeeEpllaqegE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciXuHdoUIZ46Ai7Yy9qaF15DzijLANJxDY8V6/HRvrWOVa8jehC/exajKpHshfLz/mvglB3tgGiccbR836A14OR3OdL8LvaNZrxDYjJnhuUl11OLqc3mv3yvg77WhoXBycNnfLkWJnuTZ+71xY07T5jBeuscHQhqJkHSfoJrnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ev1aNmXq; arc=none smtp.client-ip=91.218.175.182
Message-ID: <458f63e2-6ee4-44c7-a230-636e1927f857@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782721385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFxUO7tgIcr0aaRoeEv4WTyZn0JslVlD209KcTGHDqc=;
	b=ev1aNmXq7ogiDIfLA6fwdm8/E4svVMoXrQk1fT8rGFz3UmiKKzsl/hv4jM6VSXvdeRIXSY
	+hGUGRGHVpH/oq+1s7hpJexHb9LmvsPTB68wx+kCIH4MG4qC7Bk/doclxFP0JZyxlaaHbm
	u4aXlpHb3wvosR2bMj24RfY4WpKOuaI=
Date: Mon, 29 Jun 2026 16:22:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
To: "David Hildenbrand (Arm)" <david@kernel.org>, dev.jain@arm.com
Cc: linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
 akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
 riel@surriel.com, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 kas@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rcampbell@nvidia.com, apopple@nvidia.com, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 mel@csn.ul.ie, nao.horiguchi@gmail.com, ak@linux.intel.com,
 j-nomura@ce.jp.nec.com, pfalcato@suse.de, dave.hansen@intel.com,
 tglx@kernel.org, jpoimboe@kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <0fabee2a-edb7-41c8-91ec-8cf0646c9e83@kernel.org>
 <20260629074802.42727-1-lance.yang@linux.dev>
 <a1c6c3dd-8db1-4db6-b032-e350bacc4577@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a1c6c3dd-8db1-4db6-b032-e350bacc4577@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-269674-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:dev.jain@arm.com,m:linmiaohe@huawei.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:liam@infradead.org,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[huawei.com,linux.dev,suse.de,linux-foundation.org,kernel.org,infradead.org,surriel.com,google.com,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E5E06D7773



On 2026/6/29 16:05, David Hildenbrand (Arm) wrote:
> On 6/29/26 09:48, Lance Yang wrote:
>>
>> On Mon, Jun 29, 2026 at 09:25:48AM +0200, David Hildenbrand (Arm) wrote:
>>> On 6/29/26 08:48, Dev Jain wrote:
>>>>
>>>>
>>>>
>>>> Sashiko notes other places:
>>>>
>>>> https://sashiko.dev/#/patchset/20260625112955.3254283-1-dev.jain%40arm.com
>>>
>>> Yeah, that looks shaky. We do seem to have a bunch of these cases, primarily
>> >from pagewalk code (where some users like pagemap need the actual address).
>>
>> Indeed ...
>>
>>> I think we have two options
>>>
>>> 1) To prevent any (further) issues, make huge_ptep_get() always consume the
>>> hstate, and let the arch code deal with aligning it. Invasive.
>>
>> Kinda lean toward option 1, even if it's more invasive. If we pass the
>> hstate down, each arch can figure out the right addr from there.
>>
>>> 2) Make the arch code handle aligning without the hstate.
>>>
>>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>> index 30772a909aea3..303a1b74796c9 100644
>>> --- a/arch/arm64/mm/hugetlbpage.c
>>> +++ b/arch/arm64/mm/hugetlbpage.c
>>> @@ -126,6 +126,9 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>>>                 return orig_pte;
>>>
>>>         ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>>> +       ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * ncontig);
>>> +       orig_pte = __ptep_get(ptep);
>>> +
>>>         for (i = 0; i < ncontig; i++, ptep++) {
>>>                 pte_t pte = __ptep_get(ptep);
>>>
>>> (nshift/order instead of ncontig might avoid a multiplication, but not sure if that matters in practice)
>>>
>>> IIUC, that's similar to what huge_ptep_get() does on ppc.
>>>
>>>
>>> static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>>> {
>>> 	if (ptep_is_8m_pmdp(mm, addr, ptep))
>>> 		ptep = pte_offset_kernel((pmd_t *)ptep, ALIGN_DOWN(addr, SZ_8M));
>>> 	return ptep_get(ptep);
>>> }
>>>
>>> I'd assume we could do the same on riscv. Besides that, I don't think any arch has cont
>>> entries.
>>
>> AFAICT, for huge_ptep_get() the addr users are arm64 and powerpc, riscv
>> doesn't really care about addr there. Looks mostly arm64-specific ...
> powerpc handles it correctly in the weird "span two PMD entries" case by
> aligning the PMD down.
> 
> Risc-v copied from arm64, but can simply derive the #entries from the PTE value.
> it doesn't have to re-walk the table using the address.

Yeah, fair enough, thanks for spelling that out!

> But I think the following is required to fix, no?
> 
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index a6d217112cf46..7e25cc13b3dba 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -5,6 +5,7 @@
>   #ifdef CONFIG_RISCV_ISA_SVNAPOT
>   pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>   {
> -       unsigned long pte_num;
> +       unsigned long pte_num, pte_order;
>          int i;
>          pte_t orig_pte = ptep_get(ptep);
> @@ -12,7 +13,11 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
> pte_t *ptep)
>          if (!pte_present(orig_pte) || !pte_napot(orig_pte))
>                  return orig_pte;
> 
> -       pte_num = napot_pte_num(napot_cont_order(orig_pte));
> +       pte_order = napot_cont_order(orig_pte);
> +       pte_num = napot_pte_num(pte_order);
> +
> +       ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) << pte_order);
> +       orig_pte = ptep_get(ptep);
> 
>          for (i = 0; i < pte_num; i++, ptep++) {
>                  pte_t pte = ptep_get(ptep);
> 
> 
> 
> I'd prefer (2) as a simple stable fix first.

Right. I'm good with (2) as the stable fix first :)

Still pretty new to arch code, but happy to stare at it some more.

> If we do (1) on top, huge_ptep_get() on arm64 could stop walking the page table
> another time.
> 
> If we pass the hstate (or vma) to set_huge_pte_at(), huge_pte_clear(),
> huge_ptep_get_and_clear(), we could likely get rid of the re-walk in
> num_contig_ptes() entirely and possibly just remove it.
> 
> That would probably be cleanest.

Agreed!

