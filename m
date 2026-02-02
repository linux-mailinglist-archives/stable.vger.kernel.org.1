Return-Path: <stable+bounces-213057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GsHKKqFgGnE8wIAu9opvQ
	(envelope-from <stable+bounces-213057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 12:08:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E422CB7BF
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 12:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBB82300E618
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8235BDD5;
	Mon,  2 Feb 2026 11:06:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93723D7FC;
	Mon,  2 Feb 2026 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030400; cv=none; b=UenHPTpj6UJoxrG+uhQvCGGCWXawevz94w2RCAdSfQER2Dvs35lLRj+1/LOZvKIlC4bnXWlSRgsdkcwCFDatx74qrRRc+8vUALhsx3x7Nd7F6BYndLkA4FRfkPLXLRSrb9rRS9sp2goXvFnk3daZixVBH05AhJt6uDdtuXXwoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030400; c=relaxed/simple;
	bh=RH7KX9BxYYBXoGaI5AhYVydWoCwzALRpKIV1S40XV+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOEXZ/CM1FnfdOa6+zUKBnhjEB5PkJaLxLg/xHRI43+A7pY9kuvhz1YF8p6KMgsJEVtHOqd7zQJatu7ZRzfdy6FSRbfgmW85zWuRipEocVQ0YyFO1MF7212KQWPCEa8B84O8fYlhKNfuzJzKDCnI+QHkm9WzygkngzBq0JyByO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F112339;
	Mon,  2 Feb 2026 03:06:31 -0800 (PST)
Received: from [10.163.168.36] (unknown [10.163.168.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0530E3F7A6;
	Mon,  2 Feb 2026 03:06:34 -0800 (PST)
Message-ID: <7790afb1-df77-4c14-90f1-1499f4e68f94@arm.com>
Date: Mon, 2 Feb 2026 16:36:31 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64/mm: Reject memory removal that splits a kernel
 leaf mapping
To: Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260202042617.504183-1-anshuman.khandual@arm.com>
 <20260202042617.504183-3-anshuman.khandual@arm.com>
 <10088a12-332f-490e-9726-3015f99e264a@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <10088a12-332f-490e-9726-3015f99e264a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anshuman.khandual@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-213057-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 1E422CB7BF
X-Rspamd-Action: no action

On 02/02/26 3:12 PM, Ryan Roberts wrote:
> On 02/02/2026 04:26, Anshuman Khandual wrote:
>> Linear and vmemmap mapings that get teared down during a memory hot remove
>> operation might contain leaf level entries on any page table level. If the
>> requested memory range's linear or vmemmap mappings falls within such leaf
>> entries, new mappings need to be created for the remaning memory mapped on
>> the leaf entry earlier, following standard break before make aka BBM rules.
> 
> I think it would be good to mention that the kernel cannot tolerate BBM so
> remapping to fine grained leaves would not be possible on systems without
> BBML2_NOABORT.

Sure will add that.

> 
>>
>> Currently memory hot remove operation does not perform such restructuring,
>> and so removing memory ranges that could split a kernel leaf level mapping
>> need to be rejected.
> 
> Perhaps it is useful to mention that while memory_hotplug.c does appear to
> permit hot-unplugging arbitrary ranges of memory, the higher layers that drive
> memory_hotplug (e.g. ACPI, virtio, ...) all appear to treat memory as fixed size
> devices so it is impossible to hotunplug a different amount than was previously
> hotplugged, and so we should never see a rejection in practice, but adding the
> check makes us robust against a future change.

Agreed, will update the commit message.

> 
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Closes: https://lore.kernel.org/all/aWZYXhrT6D2M-7-N@willie-the-truck/
>> Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 126 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 126 insertions(+)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 8ec8a287aaa1..9d59e10fb3de 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -2063,6 +2063,129 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
>>  	__remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
>>  }
>>  
>> +
>> +static bool split_kernel_leaf_boundary(unsigned long addr)
> 
> The name currently makes it sound like we are asking for the mapping to be split
> (we have existing functions to do this that are named similarly). Perhaps a
> better name would be addr_splits_leaf()?

Agreed that name sounds bit confusing and ambiguous as there is already
a similarly named function. Will rename it as addr_splits_kernel_leaf()
instead.

> 
>> +{
>> +	pgd_t *pgdp, pgd;
>> +	p4d_t *p4dp, p4d;
>> +	pud_t *pudp, pud;
>> +	pmd_t *pmdp, pmd;
>> +	pte_t *ptep, pte;
>> +
>> +	/*
>> +	 * PGD: If addr is PGD aligned then addr already
>> +	 * describes a leaf boundary.
>> +	 */
>> +	if (ALIGN_DOWN(addr, PGDIR_SIZE) == addr)
>> +		return false;
>> +
>> +	pgdp = pgd_offset_k(addr);
>> +	pgd = pgdp_get(pgdp);
>> +	if (!pgd_present(pgd))
>> +		return false;
>> +
>> +	/*
>> +	 * P4D: If addr is P4D aligned then addr already
>> +	 * describes a leaf boundary.
>> +	 */
>> +	if (ALIGN_DOWN(addr, P4D_SIZE) == addr)
>> +		return false;
>> +
>> +	p4dp = p4d_offset(pgdp, addr);
>> +	p4d = p4dp_get(p4dp);
>> +	if (!p4d_present(p4d))
>> +		return false;
>> +
>> +	/*
>> +	 * PUD: If addr is PUD aligned then addr already
>> +	 * describes a leaf boundary.
>> +	 */
>> +	if (ALIGN_DOWN(addr, PUD_SIZE) == addr)
>> +		return false;
>> +
>> +	pudp = pud_offset(p4dp, addr);
>> +	pud = pudp_get(pudp);
>> +	if (!pud_present(pud))
>> +		return false;
>> +
>> +	if (pud_leaf(pud))
>> +		return true;
>> +
>> +	/*
>> +	 * CONT_PMD: If addr is CONT_PMD aligned then
>> +	 * addr already describes a leaf boundary.
>> +	 */
>> +	if (ALIGN_DOWN(addr, CONT_PMD_SIZE) == addr)
>> +		return false;
>> +
>> +	pmdp = pmd_offset(pudp, addr);
>> +	pmd = pmdp_get(pmdp);
>> +	if (!pmd_present(pmd))
>> +		return false;
>> +
>> +	if (pmd_leaf(pmd) && pmd_cont(pmd))
>> +		return true;
>> +
>> +	/*
>> +	 * PMD: If addr is PMD aligned then addr already
>> +	 * describes a leaf boundary.
>> +	 */
>> +	if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>> +		return false;
>> +
>> +	if (pmd_leaf(pmd))
>> +		return true;
>> +
>> +	/*
>> +	 * CONT_PTE: If addr is CONT_PTE aligned then addr
>> +	 * already describes a leaf boundary.
>> +	 */
>> +	if (ALIGN_DOWN(addr, CONT_PTE_SIZE) == addr)
>> +		return false;
>> +
>> +	ptep = pte_offset_kernel(pmdp, addr);
>> +	pte = __ptep_get(ptep);
>> +	if (!pte_present(pte))
>> +		return false;
>> +
>> +	if (pte_valid(pte) && pte_cont(pte))
> 
> Why do you need pte_valid() here? You have already checked !pte_present(). Are
> you expecting a case of present but not valid (PTE_PRESENT_INVALID)? If so, do
> you need to consider that for the other levels too? (pmd_leaf() only checks
> pmd_present()).
> > Personally I think you can just drop the pte_valid() check here.

Added pte_valid() for abundance of caution but it is not really
necessary though. Sure will drop it off.

> 
>> +		return true;
>> +
>> +	if (ALIGN_DOWN(addr, PAGE_SIZE) == addr)
>> +		return false;
>> +	return true;
>> +}
>> +
>> +static bool can_unmap_without_split(unsigned long pfn, unsigned long nr_pages)
>> +{
>> +	unsigned long linear_start, linear_end, phys_start, phys_end;
>> +	unsigned long vmemmap_size, vmemmap_start, vmemmap_end;
> 
> nit: do we need all these variables. Perhaps just:
> 
> unsigned long sz, start, end, phys_start, phys_end;
> 
> are sufficient?

Alright. I guess start and end can be re-used both for linear and
vmemmap mapping.

> 
>> +
>> +	/* Assert linear map edges do not split a leaf entry */
>> +	phys_start = PFN_PHYS(pfn);
>> +	phys_end = phys_start + nr_pages * PAGE_SIZE;
>> +	linear_start = __phys_to_virt(phys_start);
>> +	linear_end =  __phys_to_virt(phys_end);
>> +	if (split_kernel_leaf_boundary(linear_start) ||
>> +	    split_kernel_leaf_boundary(linear_end)) {
>> +		pr_warn("[%lx %lx] splits a leaf entry in linear map\n",
>> +			phys_start, phys_end);
>> +		return false;
>> +	}
>> +
>> +	/* Assert vmemmap edges do not split a leaf entry */
>> +	vmemmap_size = nr_pages * sizeof(struct page);
>> +	vmemmap_start = (unsigned long) pfn_to_page(pfn);
> 
> nit:                                   ^
> 
> I don't think we would normally have that space?

Sure will drop that.

> 
>> +	vmemmap_end = vmemmap_start + vmemmap_size;
>> +	if (split_kernel_leaf_boundary(vmemmap_start) ||
>> +	    split_kernel_leaf_boundary(vmemmap_end)) {
>> +		pr_warn("[%lx %lx] splits a leaf entry in vmemmap\n",
>> +			phys_start, phys_end);
>> +		return false;
>> +	}
>> +	return true;
>> +}
>> +
>>  /*
>>   * This memory hotplug notifier helps prevent boot memory from being
>>   * inadvertently removed as it blocks pfn range offlining process in
>> @@ -2083,6 +2206,9 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
>>  	if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
>>  		return NOTIFY_OK;
>>  
>> +	if (!can_unmap_without_split(pfn, arg->nr_pages))
>> +		return NOTIFY_BAD;
>> +
> 
> Personally, I'd keep the bootmem check first and do this check after. That means
> an existing warning will not change.

Makes sense, will move it after existing bootmem check. BTW the function
still named as prevent_bootmem_remove_notifier() although now it's going
to check leaf boundaries as well. Should the function be renamed as well
to something more generic e.g prevent_memory_remove_notifier() ?

> 
> Thanks,
> Ryan
> 
>>  	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>>  		unsigned long start = PFN_PHYS(pfn);
>>  		unsigned long end = start + (1UL << PA_SECTION_SHIFT);
> 


