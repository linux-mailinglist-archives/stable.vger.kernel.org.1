Return-Path: <stable+bounces-185840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E2FBDF8AE
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 18:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EF53A4EDE
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066A2C0F8F;
	Wed, 15 Oct 2025 16:05:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693332BE647;
	Wed, 15 Oct 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544331; cv=none; b=bXkClDiMeqBJa/Hkk8PEvv5KVaGy3VAtRhC0MYafx1N9ItlcDabc7E+0aeMxF07QgS3qtGoodrfGOSKsaduMHWIzkcJkXRDLnHHoE/BjwUHO/AqI3QqK+lmWONLKWT1Qa8m7D/DhgRAJKuk4Il2O6ho4xqR9CdYO9/hFTe5dvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544331; c=relaxed/simple;
	bh=OtZArIgGOVFPBOubdpx8vP6JRc8vzh/BwBc+DxxyLUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jjf8sHNy4gujLXfY9YWS0JznKbK8fBt7c8cqCSaSK8quIw7+1+vu8w3hHkua5VmlRVJ90VfLcfjU0hPV6aDPguZYdyn3LEmx+GH7nwAPdaN6CNNFXV9meq3zlbFctYPPadYF8SFTdJC2G/dquGIXffRgV46nWDJD3tlupcvQsoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A1D51655;
	Wed, 15 Oct 2025 09:05:20 -0700 (PDT)
Received: from [10.57.66.88] (unknown [10.57.66.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79CBA3F66E;
	Wed, 15 Oct 2025 09:05:25 -0700 (PDT)
Message-ID: <965b11fd-3e29-4f29-a1bf-b8e98940b322@arm.com>
Date: Wed, 15 Oct 2025 18:05:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64/mm: Allow __create_pgd_mapping() to
 propagate pgtable_alloc() errors
To: Linu Cherian <linu.cherian@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>, stable@vger.kernel.org
References: <20251015112758.2701604-1-linu.cherian@arm.com>
 <20251015112758.2701604-2-linu.cherian@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20251015112758.2701604-2-linu.cherian@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2025 13:27, Linu Cherian wrote:
> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>
> arch_add_memory() is used to hotplug memory into a system but as a part
> of its implementation it calls __create_pgd_mapping(), which uses
> pgtable_alloc() in order to build intermediate page tables. As this path
> was initally only used during early boot pgtable_alloc() is designed to
> BUG_ON() on failure. However, in the event that memory hotplug is
> attempted when the system's memory is extremely tight and the allocation
> were to fail, it would lead to panicking the system, which is not
> desirable. Hence update __create_pgd_mapping and all it's callers to be
> non void and propagate -ENOMEM on allocation failure to allow system to
> fail gracefully.
>
> But during early boot if there is an allocation failure, we want the
> system to panic, hence create a wrapper around __create_pgd_mapping()
> called early_create_pgd_mapping() which is designed to panic, if ret
> is non zero value. All the init calls are updated to use this wrapper
> rather than the modified __create_pgd_mapping() to restore
> functionality.
>
> Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> Signed-off-by: Linu Cherian <linu.cherian@arm.com>

A couple more nits below (sorry I didn't catch them earlier), but otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
> Changelog:
>
> v3:
> * Fixed a maybe-uninitialized case in alloc_init_pud
> * Added Fixes tag and CCed stable
> * Few other trivial cleanups
>
>  arch/arm64/mm/mmu.c | 210 ++++++++++++++++++++++++++++----------------
>  1 file changed, 132 insertions(+), 78 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b8d37eb037fc..638cb4df31a9 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -49,6 +49,8 @@
>  #define NO_CONT_MAPPINGS	BIT(1)
>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>  
> +#define INVALID_PHYS_ADDR	(-1ULL)
> +
>  DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
>  
>  u64 kimage_voffset __ro_after_init;
> @@ -194,11 +196,11 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  	} while (ptep++, addr += PAGE_SIZE, addr != end);
>  }
>  
> -static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> -				unsigned long end, phys_addr_t phys,
> -				pgprot_t prot,
> -				phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> -				int flags)
> +static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> +			       unsigned long end, phys_addr_t phys,
> +			       pgprot_t prot,
> +			       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +			       int flags)
>  {
>  	unsigned long next;
>  	pmd_t pmd = READ_ONCE(*pmdp);
> @@ -213,6 +215,8 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  			pmdval |= PMD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pte_phys = pgtable_alloc(TABLE_PTE);
> +		if (pte_phys == INVALID_PHYS_ADDR)
> +			return -ENOMEM;
>  		ptep = pte_set_fixmap(pte_phys);
>  		init_clear_pgtable(ptep);
>  		ptep += pte_index(addr);
> @@ -244,12 +248,15 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  	 * walker.
>  	 */
>  	pte_clear_fixmap();
> +
> +	return 0;
>  }
>  
> -static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
> -		     phys_addr_t phys, pgprot_t prot,
> -		     phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags)
> +static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
> +		    phys_addr_t phys, pgprot_t prot,
> +		    phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags)
>  {
> +	int ret;

Nit: that could be added to the else block instead (makes it clearer
it's not used for the final return, that got me confused when re-reading
this patch).

>  	unsigned long next;
>  
>  	do {
> @@ -269,22 +276,27 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  			BUG_ON(!pgattr_change_is_safe(pmd_val(old_pmd),
>  						      READ_ONCE(pmd_val(*pmdp))));
>  		} else {
> -			alloc_init_cont_pte(pmdp, addr, next, phys, prot,
> -					    pgtable_alloc, flags);
> +			ret = alloc_init_cont_pte(pmdp, addr, next, phys, prot,
> +						  pgtable_alloc, flags);
> +			if (ret)
> +				return ret;
>  
>  			BUG_ON(pmd_val(old_pmd) != 0 &&
>  			       pmd_val(old_pmd) != READ_ONCE(pmd_val(*pmdp)));
>  		}
>  		phys += next - addr;
>  	} while (pmdp++, addr = next, addr != end);
> +
> +	return 0;
>  }
>  
> [...]
>
> @@ -1178,9 +1226,10 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>  		// covers the PTE[] page itself, the remaining entries are free
>  		// to be used as a ad-hoc fixmap.
>  		//
> -		__create_pgd_mapping_locked(kpti_ng_temp_pgd, __pa(alloc),
> -					    KPTI_NG_TEMP_VA, PAGE_SIZE, PAGE_KERNEL,
> -					    kpti_ng_pgd_alloc, 0);
> +		if (__create_pgd_mapping_locked(kpti_ng_temp_pgd, __pa(alloc),
> +						KPTI_NG_TEMP_VA, PAGE_SIZE, PAGE_KERNEL,
> +						kpti_ng_pgd_alloc, 0))

Nit: it would be slightly more readable to have ret =
__create_pgd_mapping_locked(...); if (ret)

- Kevin

> +			panic("Failed to create page tables\n");
>  	}
>  
>  	cpu_install_idmap();
>
> [...]

