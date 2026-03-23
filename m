Return-Path: <stable+bounces-229982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPxiIOh6wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:39:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8A2FA24C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07D1E30D31C7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C213CA4A8;
	Mon, 23 Mar 2026 17:25:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B253C9439;
	Mon, 23 Mar 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286749; cv=none; b=TKi53dpqh28H4rVNtyl3KLZHgnrgt5tbN6e9dX1/WqOCzc9h/Xp6Ojq88jrpOMGK5f97jDwHea8DMszGWNZlVkgPMcDD+U88Jc8XZWq/715FzN/d8rECfTbHHt161UqD7CdELAmR9fAfGOQ6pJDi4FHfiBUEB+JThY7u5PVjU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286749; c=relaxed/simple;
	bh=jRTJImNnD4NIltD+wQRde7Q2aOYrggkHC3z4X0Uu+ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmQIWbsQDMGeqZoi2wTrTTlHujtioOvaARMn3lNV3iOQt7u1EAM14TeB5kVqdqV+dWab1vVzIDo2E7WwUR0Vf1qYybDoONlNPgPtYXiJ4gEdWdbEFjBY+MMOyankBsp3mdpzcKhVlZvaYHLYd7mOHqmSrorKG4umrowXlp3xJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B307914BF;
	Mon, 23 Mar 2026 10:25:41 -0700 (PDT)
Received: from [10.57.83.179] (unknown [10.57.83.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40AD63F694;
	Mon, 23 Mar 2026 10:25:46 -0700 (PDT)
Message-ID: <e36d3b17-dc66-466e-9446-692592e5d7f2@arm.com>
Date: Mon, 23 Mar 2026 17:25:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: mm: Handle invalid large leaf mappings
 correctly
Content-Language: en-GB
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-3-ryan.roberts@arm.com>
 <588b2b4f-9cf6-43e5-b0e5-55820c74cbbb@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <588b2b4f-9cf6-43e5-b0e5-55820c74cbbb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229982-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60F8A2FA24C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 16:52, Kevin Brodsky wrote:
> On 23/03/2026 14:03, Ryan Roberts wrote:
>> [...]
>>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 358d1dc9a576f..87dfe4c82fa92 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -25,6 +25,11 @@ static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
>>  {
>>  	struct page_change_data *masks = walk->private;
>>  
>> +	/*
>> +	 * Some users clear and set bits which alias eachother (e.g. PTE_NG and
> 
> Nit: "each other"
> 
>> +	 * PTE_PRESENT_INVALID). It is therefore important that we always clear
>> +	 * first then set.
>> +	 */
>>  	val &= ~(pgprot_val(masks->clear_mask));
>>  	val |= (pgprot_val(masks->set_mask));
>>  
>> @@ -36,7 +41,7 @@ static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
>>  {
>>  	pud_t val = pudp_get(pud);
>>  
>> -	if (pud_sect(val)) {
>> +	if (pud_leaf(val)) {
>>  		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
>>  			return -EINVAL;
>>  		val = __pud(set_pageattr_masks(pud_val(val), walk));
>> @@ -52,7 +57,7 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
>>  {
>>  	pmd_t val = pmdp_get(pmd);
>>  
>> -	if (pmd_sect(val)) {
>> +	if (pmd_leaf(val)) {
>>  		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
>>  			return -EINVAL;
>>  		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
>> @@ -132,11 +137,12 @@ static int __change_memory_common(unsigned long start, unsigned long size,
>>  	ret = update_range_prot(start, size, set_mask, clear_mask);
>>  
>>  	/*
>> -	 * If the memory is being made valid without changing any other bits
>> -	 * then a TLBI isn't required as a non-valid entry cannot be cached in
>> -	 * the TLB.
>> +	 * If the memory is being switched from present-invalid to valid without
>> +	 * changing any other bits then a TLBI isn't required as a non-valid
>> +	 * entry cannot be cached in the TLB.
>>  	 */
>> -	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
>> +	if (pgprot_val(set_mask) != (PTE_MAYBE_NG | PTE_VALID) ||
> 
> It isn't obvious to understand where all those PTE_MAYBE_NG come from if
> one hasn't realised that PTE_PRESENT_INVALID overlays PTE_NG.
> 
> Since for this purpose we always set/clear both PTE_VALID and
> PTE_MAYBE_NG, maybe we could define some macro as PTE_VALID |
> PTE_MAYBE_NG, as a counterpart to PTE_PRESENT_INVALID?

How about:

#define PTE_PRESENT_VALID_KERNEL	(PTE_VALID | PTE_MAYBE_NG)

The user space equivalent has NG clear, so important to clarify that this is the
kernel value, I think.

Thanks,
Ryan

> 
> - Kevin
> 
>> [...]


