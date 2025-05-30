Return-Path: <stable+bounces-148141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485B9AC887B
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 09:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3791E7A578E
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 07:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43CD1FAC42;
	Fri, 30 May 2025 07:05:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FED156F28;
	Fri, 30 May 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748588747; cv=none; b=kaBztZKJ/lxvPp/xtePqVvd2XI6FGXg3zp8KUDRRrIrnjfNuNYKWvkOEBKJEnZTtjHuIJ9wW7LeZQThk/k2ZglcJ0ZzMsekjVFIBYAt/QgJ81zkyX33VRyG02glmrdmgic+zGoIJ3mJPI87KnPrCIBF7oYPgweYXqYcih7Yiils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748588747; c=relaxed/simple;
	bh=3Qva9AYaf1X3Lii8gW2OzKo3rX9mkLIMXrDUaBMBK6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o87Rbc43GPhZi1iRaLYQFBfUn0eV6jR7xJw6cgEtaZt8SxGESiJBwQbp5AcIxiobaXMtIVSGdX76zU9e9jexjbwipB9inMLoOH7oycFjWHxgdmCvnczPSBk0btCN2qwIv6GfxelV+8oyvS9Bbut4/S6uCxllHKr2pAXjq7G0TFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88EE016F8;
	Fri, 30 May 2025 00:05:27 -0700 (PDT)
Received: from [10.57.95.14] (unknown [10.57.95.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6101E3F5A1;
	Fri, 30 May 2025 00:05:42 -0700 (PDT)
Message-ID: <63060234-007e-450b-a4d5-dacb9d2b87d5@arm.com>
Date: Fri, 30 May 2025 08:05:40 +0100
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
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: david@redhat.com, anshuman.khandual@arm.com, mark.rutland@arm.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250527082633.61073-1-dev.jain@arm.com>
 <914071fe-c133-4c9d-bb2d-9b9fca8a1798@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <914071fe-c133-4c9d-bb2d-9b9fca8a1798@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/05/2025 04:55, Dev Jain wrote:
> 
> On 27/05/25 1:56 pm, Dev Jain wrote:
>> Commit 9c006972c3fe removes the pxd_present() checks because the caller

nit: "Commit 9c006972c3fe" should have actually been:

Commit 9c006972c3fe ("arm64: mmu: drop pXd_present() checks from
pXd_free_pYd_table()")

>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
>> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
>> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
>> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
>> a pmd_present() check in pud_free_pmd_page().
>>
>> This problem was found by code inspection.
>>
>> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from
>> pXd_free_pYd_table())
> 
> I missed double quotes around the fixes commit message. Can Will or Catalin fix
> that,
> or shall I resend.

For future, I have the following in my ~/.gitconfig

"""
[pretty]
        fixes = Fixes: %h (\"%s\")
        commit = Commit %h (\"%s\")
"""

Then I can do:

$ git show --pretty=fixes <SHA> | head -n 1

or

$ git show --pretty=commit <SHA> | head -n 1

to get the correct format. Note that "Fixes:" is a tag and should all be on a
single line. "Commit" is just a way to refer to other commits in prose and can
be broken across lines at the usual character limit.

Perhaps there is an even easier way to do it, but this works for me.

Thanks,
Ryan


> 
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> This patch is based on 6.15-rc6.
>>
>> v2->v3:
>>   - Use pmdp_get()
>>
>> v1->v2:
>>   - Enforce check in caller
>>
>>   arch/arm64/mm/mmu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index ea6695d53fb9..5a9bf291c649 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>       next = addr;
>>       end = addr + PUD_SIZE;
>>       do {
>> -        pmd_free_pte_page(pmdp, next);
>> +        if (pmd_present(pmdp_get(pmdp)))
>> +            pmd_free_pte_page(pmdp, next);
>>       } while (pmdp++, next += PMD_SIZE, next != end);
>>         pud_clear(pudp);


