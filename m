Return-Path: <stable+bounces-148067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37862AC7AC6
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 11:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918203B11B1
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D421B9E1;
	Thu, 29 May 2025 09:13:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17414219E93;
	Thu, 29 May 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510011; cv=none; b=ppxEjefzKyBNgYWVbByTwjNZGmdN+sup2D7vxJXfAS9NlANa7BDlpSdEk5Z3BokuQ2JtDhbHMdLZZPYoTQ7I1HmmLRvzzbDTcLdEbY6MXQvZyWp/YhWekJA/9G0RstN7l2XZ7Z2RBMGY06VlD5b9w6qgfk4C0gAJEShdg+0CGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510011; c=relaxed/simple;
	bh=MX+gSHM40F/PurHWrbr1LSM8m2nkB/OI3izyzIeGG5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhU1sSYeOoA771eYX6IoTrDdxdlsEk2GQj9tGEGiBZRG28rAqCCq6OZmpTIsTB8O3MLgIeNIzQQN34DA22tY2qs07RZnej77fxPzecyqiB6MfzgaHWnEza6QUWomrCzI7ulglXcGmZYmm9l5isdOBhOdjJ8cfnDXdYkfyI2fPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDA95176A;
	Thu, 29 May 2025 02:13:12 -0700 (PDT)
Received: from [10.57.95.14] (unknown [10.57.95.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3FD13F5A1;
	Thu, 29 May 2025 02:13:27 -0700 (PDT)
Message-ID: <9a9f18e7-db69-48f2-916f-4565cdb59821@arm.com>
Date: Thu, 29 May 2025 10:13:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: Restrict pagetable teardown to avoid false
 warning
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>, Dev Jain
 <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: david@redhat.com, mark.rutland@arm.com, yang@os.amperecomputing.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20250527082633.61073-1-dev.jain@arm.com>
 <7b9a9ad4-7a7a-4e99-ba72-f5be0f609a21@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <7b9a9ad4-7a7a-4e99-ba72-f5be0f609a21@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2025 10:02, Anshuman Khandual wrote:
> 
> 
> On 5/27/25 13:56, Dev Jain wrote:
>> Commit 9c006972c3fe removes the pxd_present() checks because the caller
>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
>> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
>> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
>> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
>> a pmd_present() check in pud_free_pmd_page().
>>
>> This problem was found by code inspection.
>>
>> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table())
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Ryan Roberts <ryan.roberts@arm.com> 
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

>> ---
>> This patch is based on 6.15-rc6.
>>
>> v2->v3:
>>  - Use pmdp_get()
>>
>> v1->v2:
>>  - Enforce check in caller
>>
>>  arch/arm64/mm/mmu.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index ea6695d53fb9..5a9bf291c649 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>  	next = addr;
>>  	end = addr + PUD_SIZE;
>>  	do {
>> -		pmd_free_pte_page(pmdp, next);
>> +		if (pmd_present(pmdp_get(pmdp)))
> 
> This code path is only called for the kernel mapping. Hence should
> pmd_valid() be used instead of pmd_present() which also checks for
> present invalid scenarios as well ? 

I think a similar question came up in a previous round, where we concluded that
it's better to be consistent with what vmalloc is already doing. So personally
I'd leave it as pmd_present():

	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
		return 0;

> 
>> +			pmd_free_pte_page(pmdp, next);
>>  	} while (pmdp++, next += PMD_SIZE, next != end);
>>  
>>  	pud_clear(pudp);


