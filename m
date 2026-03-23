Return-Path: <stable+bounces-227936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCgtOp0MwWngQAQAu9opvQ
	(envelope-from <stable+bounces-227936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:49:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DF32EF544
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74E76305E152
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6E386C0E;
	Mon, 23 Mar 2026 09:43:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B6386C3D;
	Mon, 23 Mar 2026 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259030; cv=none; b=tyoBLRjjQsJf9NeVAYiyo4fd6/1sFDAWiyogfDCr0oOZZdxHwymgfgQ8V2WW6LqOYHGRSIfIpJt5aop/DOGg8IUNJYgsAviz27g5Xp1zp7YcJTOsxvNDHd1ybg5mTrBm418c5z97riDdAaasod9x+MbPeBMKurLc4UoY2q2Kb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259030; c=relaxed/simple;
	bh=7KYvyCCikdDKG4hHpc4BcGJc8BqrgUaiJZNMZuspKIA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GJQHGjzO9Lm5ftzSf5545Ak4B3+yBRsxEY6jauee+FjL12dgDQyhNHVGLsCiVitS1I5TiQp/9HwCvFVZT15ppeZ+4p+xmm25WcS9XqW99w9wWxEjE5BA9m/KxJ7BgW4Fcu16JNVfykyri+kH3VCq26qcjPLKa9Ynn5fivi/u+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dx_6tQC8Fpl78dAA--.26309S3;
	Mon, 23 Mar 2026 17:43:44 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxGMFEC8FpmUJbAA--.29160S3;
	Mon, 23 Mar 2026 17:43:34 +0800 (CST)
Subject: Re: [PATCH 1/2] LoongArch: KVM: Make kvm_get_vcpu_by_cpuid() more
 robust
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
 Aurelien Jarno <aurel32@debian.org>
References: <20260322135346.3720577-1-chenhuacai@loongson.cn>
 <676198e5-78e4-ab41-e447-4a9d24655890@loongson.cn>
 <CAAhV-H7rFtju3k=NYkAy6-O7f8U=CTNiryu2_Kr57pScjeH-yQ@mail.gmail.com>
 <696c5177-4a89-f0d0-c305-c1581e72aa3d@loongson.cn>
 <CAAhV-H43BrbWseejgrmtsBRbkbsMVOX0FaHvYOXfr-R9Y2g1Fw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <40a172b3-1b8c-3cd6-97dd-64abb7502555@loongson.cn>
Date: Mon, 23 Mar 2026 17:40:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H43BrbWseejgrmtsBRbkbsMVOX0FaHvYOXfr-R9Y2g1Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxGMFEC8FpmUJbAA--.29160S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWrWUtr4fKFWrAFyfur1UXFc_yoWrCFy8p3
	yjyayDArWrKr4IgrW0q3WkXF4aqrnrWr1kZF1Yga4Fyr1qvw1rAr1kAr1DCFyUuw1qkF40
	gF15Jw1avF1UXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU466zUUUUU
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,loongson.cn:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FROM_NEQ_ENVFROM(0.00)[maobibo@loongson.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-227936-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 55DF32EF544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/23 下午4:14, Huacai Chen wrote:
> On Mon, Mar 23, 2026 at 3:59 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/3/23 下午3:08, Huacai Chen wrote:
>>> On Mon, Mar 23, 2026 at 11:16 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2026/3/22 下午9:53, Huacai Chen wrote:
>>>>> kvm_get_vcpu_by_cpuid() takes a cpuid parameter whose type is int, so
>>>>> cpuid can be negative. Let kvm_get_vcpu_by_cpuid() return NULL for this
>>>>> case so as to make it more robust.
>>>>>
>>>>> This fix an out-of-bounds access to kvm_arch::phyid_map::phys_map[].
>>>>>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Fixes: 73516e9da512adc ("LoongArch: KVM: Add vcpu mapping from physical cpuid")
>>>>> Reported-by: Aurelien Jarno <aurel32@debian.org>
>>>>> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1131431
>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>>> ---
>>>>>     arch/loongarch/kvm/vcpu.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>>>>> index 8ffd50a470e6..831f381a8fd1 100644
>>>>> --- a/arch/loongarch/kvm/vcpu.c
>>>>> +++ b/arch/loongarch/kvm/vcpu.c
>>>>> @@ -588,6 +588,9 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm *kvm, int cpuid)
>>>>>     {
>>>>>         struct kvm_phyid_map *map;
>>>>>
>>>>> +     if (cpuid < 0)
>>>>> +             return NULL;
>>>>> +
>>>>>         if (cpuid >= KVM_MAX_PHYID)
>>>>>                 return NULL;
>>>>>
>>>>>
>>>>
>>>> if (cpuid < 0 || cpuid >= KVM_MAX_PHYID)?
>>>> however both are OK for me.
>>> I use a similar style as kvm_get_vcpu_by_id(). :)
>>>
>>> But there is another warning which can't be solved by this series (and
>>> I doubt whether it can be solved unless revert 01a8e68396a6d51f5b).
>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1131431
>>
>> what is the kernel config file with bug
>>      https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1131431
> I don't know exactly, but it needs CONFIG_FORTIFY_SOURCE.
With CONFIG_FORTIFY_SOURCE enabled, this bug can be reproduced. It seems 
that it actually need be converted to void * before arithmetic operation.

Regards
Bibo Mao
> 
> Huacai
> 
>>
>> kvm_eiointc_regs_access() seems has problem, it need convert to void *
>> before arithmetic operation. I do not know whether this patch can solve
>> this bug.
>>
>> diff --git a/arch/loongarch/kvm/intc/eiointc.c
>> b/arch/loongarch/kvm/intc/eiointc.c
>> index d2acb4d09e73..71bd67b57338 100644
>> --- a/arch/loongarch/kvm/intc/eiointc.c
>> +++ b/arch/loongarch/kvm/intc/eiointc.c
>> @@ -472,34 +472,34 @@ static int kvm_eiointc_regs_access(struct
>> kvm_device *dev,
>>           switch (addr) {
>>           case EIOINTC_NODETYPE_START ... EIOINTC_NODETYPE_END:
>>                   offset = (addr - EIOINTC_NODETYPE_START) / 4;
>> -               p = s->nodetype + offset * 4;
>> +               p = (void *)s->nodetype + offset * 4;
>>                   break;
>>           case EIOINTC_IPMAP_START ... EIOINTC_IPMAP_END:
>>                   offset = (addr - EIOINTC_IPMAP_START) / 4;
>> -               p = &s->ipmap + offset * 4;
>> +               p = (void *)&s->ipmap + offset * 4;
>>                   break;
>>           case EIOINTC_ENABLE_START ... EIOINTC_ENABLE_END:
>>                   offset = (addr - EIOINTC_ENABLE_START) / 4;
>> -               p = s->enable + offset * 4;
>> +               p = (void *)s->enable + offset * 4;
>>                   break;
>>           case EIOINTC_BOUNCE_START ... EIOINTC_BOUNCE_END:
>>                   offset = (addr - EIOINTC_BOUNCE_START) / 4;
>> -               p = s->bounce + offset * 4;
>> +               p = (void *)s->bounce + offset * 4;
>>                   break;
>>           case EIOINTC_ISR_START ... EIOINTC_ISR_END:
>>                   offset = (addr - EIOINTC_ISR_START) / 4;
>> -               p = s->isr + offset * 4;
>> +               p = (void *)s->isr + offset * 4;
>>                   break;
>>           case EIOINTC_COREISR_START ... EIOINTC_COREISR_END:
>>                   if (cpu >= s->num_cpu)
>>                           return -EINVAL;
>>
>>                   offset = (addr - EIOINTC_COREISR_START) / 4;
>> -               p = s->coreisr[cpu] + offset * 4;
>> +               p = (void *)s->coreisr[cpu] + offset * 4;
>>                   break;
>>           case EIOINTC_COREMAP_START ... EIOINTC_COREMAP_END:
>>                   offset = (addr - EIOINTC_COREMAP_START) / 4;
>> -               p = s->coremap + offset * 4;
>> +               p = (void *)s->coremap + offset * 4;
>>                   break;
>>           default:
>>                   kvm_err("%s: unknown eiointc register, addr = %d\n",
>> __func__, addr);
>>
>>
>> Regards
>> Bibo Mao
>>>
>>> Huacai
>>>
>>>>
>>>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>>>>
>>
>>


