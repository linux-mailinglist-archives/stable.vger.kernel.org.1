Return-Path: <stable+bounces-180598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25173B87D8A
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 06:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31E352337A
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 04:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B56621FF28;
	Fri, 19 Sep 2025 04:02:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B41F12E0;
	Fri, 19 Sep 2025 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758254523; cv=none; b=vDmAfdOyEBFA24ygT094QFTFJdLb9NQJd8U/0+cuzfOIceKaMYnMtBx7/EX0H/En5EiLYM6bD4VTF9A2qVk7e2tY5EKGjW37Z0aqB3yEbIEQGSupYNW/WhWYjz2n87cw/aVUZDWq4hJhoPCw5peqqlM/GO2pzRGGnoT4ewPZZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758254523; c=relaxed/simple;
	bh=J0X3/qOcIhQPImwvFRyFoOTpMSuDc7j7KO334CJhEDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o130Nnx9ngVJ2SPO37ZBTWcwUSXJhMEPGoVF3nkrroqbW5BBJHGkRoWCcL1tPELj4q3wN/prHPbr62WUesqXp3/ZDQ6UtxITcjV1/AqBH87Efp0G+/9ZIMAexWmbn06k7eIsA9vSXdII0xQryCo4ZyV/7eyBhJRyfLhnBZPdLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F98C1758;
	Thu, 18 Sep 2025 21:01:51 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700843F673;
	Thu, 18 Sep 2025 21:01:57 -0700 (PDT)
Message-ID: <70958792-2d11-4fab-be78-e35434f2e524@arm.com>
Date: Fri, 19 Sep 2025 09:31:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arm64: kprobes: call set_memory_rox() for kprobe page
To: Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, ryan.roberts@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250918162349.4031286-1-yang@os.amperecomputing.com>
 <aMxAwDr11M2VG5XV@willie-the-truck>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aMxAwDr11M2VG5XV@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 18/09/25 10:56 pm, Will Deacon wrote:
> On Thu, Sep 18, 2025 at 09:23:49AM -0700, Yang Shi wrote:
>> The kprobe page is allocated by execmem allocator with ROX permission.
>> It needs to call set_memory_rox() to set proper permission for the
>> direct map too. It was missed.
>>
>> Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>> v2: Separated the patch from BBML2 series since it is an orthogonal bug
>>      fix per Ryan.
>>      Fixed the variable name nit per Catalin.
>>      Collected R-bs from Catalin.
>>
>>   arch/arm64/kernel/probes/kprobes.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> index 0c5d408afd95..8ab6104a4883 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -10,6 +10,7 @@
>>   
>>   #define pr_fmt(fmt) "kprobes: " fmt
>>   
>> +#include <linux/execmem.h>
>>   #include <linux/extable.h>
>>   #include <linux/kasan.h>
>>   #include <linux/kernel.h>
>> @@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>   static void __kprobes
>>   post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>>   
>> +void *alloc_insn_page(void)
>> +{
>> +	void *addr;
>> +
>> +	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>> +	if (!addr)
>> +		return NULL;
>> +	set_memory_rox((unsigned long)addr, 1);
>> +	return addr;
>> +}
> Why isn't execmem taking care of this? It looks to me like the
> execmem_cache_alloc() path calls set_memory_rox() but the
> execmem_vmalloc() path doesn't?

Ryan has raised this issue here -
https://lore.kernel.org/all/d4019be7-e24c-4715-a42a-4f1fc39a9bd4@arm.com/

>
> It feels a bit bizarre to me that we have to provide our own wrapper
> (which is identical to what s390 does). Also, how does alloc_insn_page()
> handle the direct map alias on x86?
>
> Will
>

