Return-Path: <stable+bounces-185883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E11BE1A29
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC00B19C2A20
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46D724C66F;
	Thu, 16 Oct 2025 06:05:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C227A25392C;
	Thu, 16 Oct 2025 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594732; cv=none; b=eL6KvvQY7CLzN2FsyMGKGPkcft8eCKcqtoZcarjgylfGnjRLSF5P1oW01Npa2MSw3xOIlcbjy3tIuzxKDFDc++wAkZCpfydAcC07qUTmvXho61zzjfXoiLn4bOs/WYxgHQlE1RNTRyG38y8tg8FsOGR8UokPEVResNqbBExMEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594732; c=relaxed/simple;
	bh=qWhH4wMS21CVPkgqTUV4Kp0RMZecsrnfixUJFpZsiGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDGdWj0Tb7Bs1ZOr++PZoZVC5gUSRRyjDOsyehZXm2/SGMNHtgBjdXJrP916/DMble6VWk0F9ozgwPVWPpLbRLsPByIoHjpd3GlRUvYaTd1qohxLmKrzgxBxZRsAvKeDAsbLPXoxk1D26m/dem1kZOEXs0gdn6IN53PI1Z5h2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9F8B1688;
	Wed, 15 Oct 2025 23:05:21 -0700 (PDT)
Received: from [10.163.68.150] (unknown [10.163.68.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95DB03F738;
	Wed, 15 Oct 2025 23:05:24 -0700 (PDT)
Message-ID: <5280450d-e18e-4362-b48c-0f759c8d37e5@arm.com>
Date: Thu, 16 Oct 2025 11:35:20 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64/mm: Allow __create_pgd_mapping() to
 propagate pgtable_alloc() errors
To: Kevin Brodsky <kevin.brodsky@arm.com>, Linu Cherian
 <linu.cherian@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>, stable@vger.kernel.org
References: <20251015112758.2701604-1-linu.cherian@arm.com>
 <20251015112758.2701604-2-linu.cherian@arm.com>
 <965b11fd-3e29-4f29-a1bf-b8e98940b322@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <965b11fd-3e29-4f29-a1bf-b8e98940b322@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 15/10/25 9:35 pm, Kevin Brodsky wrote:
> On 15/10/2025 13:27, Linu Cherian wrote:
>> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>>
>> arch_add_memory() is used to hotplug memory into a system but as a part
>> of its implementation it calls __create_pgd_mapping(), which uses
>> pgtable_alloc() in order to build intermediate page tables. As this path
>> was initally only used during early boot pgtable_alloc() is designed to
>> BUG_ON() on failure. However, in the event that memory hotplug is
>> attempted when the system's memory is extremely tight and the allocation
>> were to fail, it would lead to panicking the system, which is not
>> desirable. Hence update __create_pgd_mapping and all it's callers to be
>> non void and propagate -ENOMEM on allocation failure to allow system to
>> fail gracefully.
>>
>> But during early boot if there is an allocation failure, we want the
>> system to panic, hence create a wrapper around __create_pgd_mapping()
>> called early_create_pgd_mapping() which is designed to panic, if ret
>> is non zero value. All the init calls are updated to use this wrapper
>> rather than the modified __create_pgd_mapping() to restore
>> functionality.
>>
>> Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>> Signed-off-by: Linu Cherian <linu.cherian@arm.com>
> A couple more nits below (sorry I didn't catch them earlier), but otherwise:
>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>
>> ---
>> Changelog:
>>
>> v3:
>> * Fixed a maybe-uninitialized case in alloc_init_pud
>> * Added Fixes tag and CCed stable
>> * Few other trivial cleanups
>>
>>   arch/arm64/mm/mmu.c | 210 ++++++++++++++++++++++++++++----------------
>>   1 file changed, 132 insertions(+), 78 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index b8d37eb037fc..638cb4df31a9 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -49,6 +49,8 @@
>>   #define NO_CONT_MAPPINGS	BIT(1)
>>   #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>>   
>> +#define INVALID_PHYS_ADDR	(-1ULL)
>> +
>>   DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
>>   
>>   u64 kimage_voffset __ro_after_init;
>> @@ -194,11 +196,11 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>>   	} while (ptep++, addr += PAGE_SIZE, addr != end);
>>   }
>>   
>> -static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>> -				unsigned long end, phys_addr_t phys,
>> -				pgprot_t prot,
>> -				phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>> -				int flags)
>> +static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>> +			       unsigned long end, phys_addr_t phys,
>> +			       pgprot_t prot,
>> +			       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>> +			       int flags)
>>   {
>>   	unsigned long next;
>>   	pmd_t pmd = READ_ONCE(*pmdp);
>> @@ -213,6 +215,8 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>   			pmdval |= PMD_TABLE_PXN;
>>   		BUG_ON(!pgtable_alloc);
>>   		pte_phys = pgtable_alloc(TABLE_PTE);
>> +		if (pte_phys == INVALID_PHYS_ADDR)
>> +			return -ENOMEM;
>>   		ptep = pte_set_fixmap(pte_phys);
>>   		init_clear_pgtable(ptep);
>>   		ptep += pte_index(addr);
>> @@ -244,12 +248,15 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>   	 * walker.
>>   	 */
>>   	pte_clear_fixmap();
>> +
>> +	return 0;
>>   }
>>   
>> -static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>> -		     phys_addr_t phys, pgprot_t prot,
>> -		     phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags)
>> +static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>> +		    phys_addr_t phys, pgprot_t prot,
>> +		    phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags)
>>   {
>> +	int ret;
> Nit: that could be added to the else block instead (makes it clearer
> it's not used for the final return, that got me confused when re-reading
> this patch).

+1.

Reviewed-by: Dev Jain <dev.jain@arm.com>

>
>
> [...]

