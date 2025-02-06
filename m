Return-Path: <stable+bounces-114082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8DCA2A834
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 13:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393907A2C9C
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 12:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B1622A7FA;
	Thu,  6 Feb 2025 12:15:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1D2288F5;
	Thu,  6 Feb 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738844158; cv=none; b=ZdLtUI5iFOSEq8nNFhFyM9vjF0w3Fhs9AoWKN39d5/LSQtUK5uw9EZ1cAmiChOxuK+F+RQ92vUgKkWF0tDi4sjZR9SVB4j1o8NG1CaOliX0ry+38MDHXHv//BU7ucnGKWTteR04RukVu8I/BamQEE5bnHYeiYunkVxNoiftBhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738844158; c=relaxed/simple;
	bh=biMuNNUnivOyJHCNz5R+9p74VtDFagjLNpn2KojOK94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVJ6n7/XfjXYXqEd7/RjL3ghkleRPDisaIRhpSI1SzXM7uSpHYOZ/JiiAa58DNkWGJc9aF0nz/yfVJVjLIErERZDkriHmOOhNLYa1IpRML5vnKg91+YeCwNpJu/nzRjuNRFYWCJxs1iMpVk2/FRqdJ4waFPwWpYFNaTapcdgM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1943912FC;
	Thu,  6 Feb 2025 04:16:18 -0800 (PST)
Received: from [10.57.80.166] (unknown [10.57.80.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98B683F63F;
	Thu,  6 Feb 2025 04:15:49 -0800 (PST)
Message-ID: <ed3f2549-cacc-4eaa-80c3-3f220835c9e6@arm.com>
Date: Thu, 6 Feb 2025 12:15:47 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/16] mm: hugetlb: Add huge page size param to
 huge_ptep_get_and_clear()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Steve Capper <steve.capper@linaro.org>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
References: <20250205151003.88959-1-ryan.roberts@arm.com>
 <20250205151003.88959-2-ryan.roberts@arm.com>
 <d8ef8240-e202-464c-ad16-1a34953cc872@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d8ef8240-e202-464c-ad16-1a34953cc872@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the review!

On 06/02/2025 05:03, Anshuman Khandual wrote:
> 
> 
> On 2/5/25 20:39, Ryan Roberts wrote:
>> In order to fix a bug, arm64 needs to be told the size of the huge page
>> for which the huge_pte is being set in huge_ptep_get_and_clear().
>> Provide for this by adding an `unsigned long sz` parameter to the
>> function. This follows the same pattern as huge_pte_clear() and
>> set_huge_pte_at().
>>
>> This commit makes the required interface modifications to the core mm as
>> well as all arches that implement this function (arm64, loongarch, mips,
>> parisc, powerpc, riscv, s390, sparc). The actual arm64 bug will be fixed
>> in a separate commit.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  arch/arm64/include/asm/hugetlb.h     |  4 ++--
>>  arch/arm64/mm/hugetlbpage.c          |  8 +++++---
>>  arch/loongarch/include/asm/hugetlb.h |  6 ++++--
>>  arch/mips/include/asm/hugetlb.h      |  6 ++++--
>>  arch/parisc/include/asm/hugetlb.h    |  2 +-
>>  arch/parisc/mm/hugetlbpage.c         |  2 +-
>>  arch/powerpc/include/asm/hugetlb.h   |  6 ++++--
>>  arch/riscv/include/asm/hugetlb.h     |  3 ++-
>>  arch/riscv/mm/hugetlbpage.c          |  2 +-
>>  arch/s390/include/asm/hugetlb.h      | 12 ++++++++----
>>  arch/s390/mm/hugetlbpage.c           | 10 ++++++++--
>>  arch/sparc/include/asm/hugetlb.h     |  2 +-
>>  arch/sparc/mm/hugetlbpage.c          |  2 +-
>>  include/asm-generic/hugetlb.h        |  2 +-
>>  include/linux/hugetlb.h              |  4 +++-
>>  mm/hugetlb.c                         |  4 ++--
>>  16 files changed, 48 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>> index c6dff3e69539..03db9cb21ace 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -42,8 +42,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>  				      unsigned long addr, pte_t *ptep,
>>  				      pte_t pte, int dirty);
>>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>> -extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>> -				     unsigned long addr, pte_t *ptep);
>> +extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>> +				     pte_t *ptep, unsigned long sz);
> 
> If VMA could be passed instead of MM, the size of the huge page can
> be derived via huge_page_size(hstate_vma(vma)) and another argument
> here need not be added. Also MM can be derived from VMA if required.

I considered this approach; infact that's what I first implemented when fixing
an equivalent bug on set_huge_pte_at() in the past. But that was problematic
because there are some cases where the helper is used for kernel mappings (see
vmalloc) and there is no VMA to pass in that case. See [1].

To fix this bug, usage of this helper for kernel mappings is not an issue (yet)
so I guess technically it could be fixed by passing VMA. But later in this
series I start using huge_ptep_get_and_clear() for the vmap (see patch 11) so it
would break at that point.

Another approach I considered was to allocate a spare swap-pte bit (we have a
few) to indicate PTE_CONT for non-present PTEs. Then no API change is required
at all. But given set_huge_pte_at() and huge_pte_clear() already pass "sz", it
seemed best just to keep things simple and follow that pattern.

[1] https://lore.kernel.org/all/20230922115804.2043771-1-ryan.roberts@arm.com/

Thanks,
Ryan


