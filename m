Return-Path: <stable+bounces-121174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A90EAA542C1
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 07:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E8B16A96D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 06:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB411A238A;
	Thu,  6 Mar 2025 06:26:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805C199FB0;
	Thu,  6 Mar 2025 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242384; cv=none; b=cSMa1qf9IJv5uQeClCb3KF1ltOebliv+q2/f3561G7JQ4KoHkF4LY/ToBBQ2pfw6/7IRm8PnNmB1cYNqjs+iXSG4qpi2XusdkmhQeSDEi2LOLlcaV18cQCvj1VvR2s1KC9QHsbDd+nsrm6tWOhzZy7cBCrWBUARS0bvPuajLOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242384; c=relaxed/simple;
	bh=zXTwBxHNlR7kli2CChDZ8XPBeiUUU0Nacd4/B7dZ++M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bAQD926oHbNbTh1Net/RfgqzMCYmfaPq5CzSDXNQdPC8SixFL+h08IWVqLIThkEAjXNJLVL+7wVKCZ59MsFuHpsfP6+DKT03AJp8BR1XOqhnVpUPe8J6XDg4bOM7pPYlrXQThJZaVo238zkLMRmw/1A6xp4YtRpouDs+YfUGHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxWXEKQMln+f2LAA--.42935S3;
	Thu, 06 Mar 2025 14:26:18 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMCxbsUGQMlnuPk4AA--.15820S3;
	Thu, 06 Mar 2025 14:26:16 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: mm: Set max_pfn with the PFN of the last
 page
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
References: <20250306035314.2131976-1-maobibo@loongson.cn>
 <CAAhV-H45DobYbBFBatJtHPF22VAX=QWH8i=jzpWNvN-ELgWr4Q@mail.gmail.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <b1fde3cf-f4ed-68cc-fd4d-8b8b089870f1@loongson.cn>
Date: Thu, 6 Mar 2025 14:25:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H45DobYbBFBatJtHPF22VAX=QWH8i=jzpWNvN-ELgWr4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxbsUGQMlnuPk4AA--.15820S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1UWr1xXr1xXr1fXr4xGrX_yoW5GF1Dpw
	4fAF17Wr4UGr1xAw18Xw1fuFyfX39YkaySgF4UtF1Iyrs8Grn3Kw4jqw13urn2gr10ya1F
	qrW2gF9IvayjyagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
	U



On 2025/3/6 下午12:06, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Mar 6, 2025 at 11:53 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> The current max_pfn equals to zero. In this case, it caused users cannot
>> get some page information through /proc such as kpagecount. The following
>> message is displayed by stress-ng test suite with the command
>> "stress-ng --verbose --physpage 1 -t 1".
>>
>>   # stress-ng --verbose --physpage 1 -t 1
>>   stress-ng: error: [1691] physpage: cannot read page count for address 0x134ac000 in /proc/kpagecount, errno=22 (Invalid argument)
>>   stress-ng: error: [1691] physpage: cannot read page count for address 0x7ffff207c3a8 in /proc/kpagecount, errno=22 (Invalid argument)
>>   stress-ng: error: [1691] physpage: cannot read page count for address 0x134b0000 in /proc/kpagecount, errno=22 (Invalid argument)
>>   ...
>>
>> After applying this patch, the kernel can pass the test.
>>   # stress-ng --verbose --physpage 1 -t 1
>>   stress-ng: debug: [1701] physpage: [1701] started (instance 0 on CPU 3)
>>   stress-ng: debug: [1701] physpage: [1701] exited (instance 0 on CPU 3)
>>   stress-ng: debug: [1700] physpage: [1701] terminated (success)
>>
>> Cc: stable@vger.kernel.org
>> Fixes: ff6c3d81f2e8 ("NUMA: optimize detection of memory with no node id assigned by firmware")
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/kernel/setup.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
>> index edcfdfcad7d2..a9c1184ab893 100644
>> --- a/arch/loongarch/kernel/setup.c
>> +++ b/arch/loongarch/kernel/setup.c
>> @@ -390,6 +390,7 @@ static void __init arch_mem_init(char **cmdline_p)
>>          if (usermem)
>>                  pr_info("User-defined physical RAM map overwrite\n");
>>
>> +       max_low_pfn = max_pfn = PHYS_PFN(memblock_end_of_DRAM());
> max_low_pfn is already calculated for all three cases, so here just
> need "max_pfn = max_low_pfn".
In theory it should be.

However there are potential problems, it should be recalculated in 
function early_parse_mem() also if commandline "mem=" is added.

The other thing is that calculation init_numa_memory() is unnecessary 
since it is already calculated in memblock_init(). Memory block 
information comes from UEFI table or FDT table, and ACPI srat 
information only adds node information.

Regards
Bibo Mao
> 
> Huacai
> 
>>          check_kernel_sections_mem();
>>
>>          /*
>>
>> base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
>> --
>> 2.39.3
>>


