Return-Path: <stable+bounces-192159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E2C2A953
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 09:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52A0A347CCE
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF62E03EC;
	Mon,  3 Nov 2025 08:34:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787E42DF6F8;
	Mon,  3 Nov 2025 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158886; cv=none; b=BQ8Zek7ZmT2qYW7OBTfXqrLaF6vxptXKnmdnm5fIJic5yDLZmUWigUi0zHDfvSW82Ok6eA+lcnx9ab/6PR1tHt+soAhffFzoGYJWXGVB385xS+aYzkQSrtCb+NB49QKg5RZM2bsKoJbCZ0HQaojiIIIw17sdmM7OQNxg3gTyswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158886; c=relaxed/simple;
	bh=oP4ibuM1PgBLzzzczRC4883JfTg9PU0LoAur1X+lNx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wolvnoda1cnokhWwRxws6RCnw4HIKHUo4jdPhs5FU/OC0leWj7yfibWaMdRhfb1mnuyXuBy1B3J+vgVOhk10q3YnPCRoXt+9/NFS9ZonnkIw5M5uDNPLQRqB+wejzI+P67yeqP3sHJwEW7nXwKbl8ZTEqiXgcrZyeI+ypI6Dqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B07A21D13;
	Mon,  3 Nov 2025 00:34:35 -0800 (PST)
Received: from [10.164.136.41] (unknown [10.164.136.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56F673F694;
	Mon,  3 Nov 2025 00:34:39 -0800 (PST)
Message-ID: <9fdb8448-7635-46a9-8e81-a738eaa098ef@arm.com>
Date: Mon, 3 Nov 2025 14:04:37 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Anshuman Khandual <anshuman.khandual@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: ryan.roberts@arm.com, rppt@kernel.org, shijie@os.amperecomputing.com,
 yang@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251103061306.82034-1-dev.jain@arm.com>
 <7d4d0d6a-390d-48d6-ba2a-7adfac2e30ca@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <7d4d0d6a-390d-48d6-ba2a-7adfac2e30ca@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 03/11/25 1:18 pm, Anshuman Khandual wrote:
> On 03/11/25 11:43 AM, Dev Jain wrote:
>> Post a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full"),
>> __change_memory_common has a real chance of failing due to split failure.
>> Before that commit, this line was introduced in c55191e96caa, still having
> A small nit:
>
> Commit description needs to follow after the SHA ID ^^^^^^^^^^

Didn't do that for brevity's sake, it is there in the fixes tag.

>> a chance of failing if it needs to allocate pagetable memory in
>> apply_to_page_range, although that has never been observed to be true.
>> In general, we should always propagate the return value to the caller.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM areas to its linear alias as well")
> Does is really need a Fixes: ? There is no problem which is being fixed.

If an error happens in the linear map alias permission change, it will be
suppressed due to the return value not being checked.

>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> Based on Linux 6.18-rc4.
>>
>>   arch/arm64/mm/pageattr.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 5135f2d66958..b4ea86cd3a71 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	unsigned long size = PAGE_SIZE * numpages;
>>   	unsigned long end = start + size;
>>   	struct vm_struct *area;
>> +	int ret;
>>   	int i;
>>   
>>   	if (!PAGE_ALIGNED(addr)) {
>> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>   			    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>   		for (i = 0; i < area->nr_pages; i++) {
>> -			__change_memory_common((u64)page_address(area->pages[i]),
>> +			ret = __change_memory_common((u64)page_address(area->pages[i]),
>>   					       PAGE_SIZE, set_mask, clear_mask);
>> +			if (ret)
>> +				return ret;
>>   		}
>>   	}
> Although the change does make sense.

