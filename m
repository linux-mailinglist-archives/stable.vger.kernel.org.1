Return-Path: <stable+bounces-136700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE83A9C893
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824BA4A758A
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4852472AA;
	Fri, 25 Apr 2025 12:09:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C2922126C
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582982; cv=none; b=oJv3UIVae9mFp9d404U8qzYzOHIsiV2bdXqdS+12e8zhYrYMRNzVvhhHtv5pcmanq43T2Ete//QkAz0xVuCOvvxEAcTO2H7iD55Pbq5HKajZya2/G5mx65e2uqjCekVD7C+xfVwfq785EmAzBSaAqZpJXrejdrSgAHMUCunPCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582982; c=relaxed/simple;
	bh=2Lye6I09UjQ2Ll914mTstGjOi0Og1+hrL9gMzx56bsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCoqq7GZ9uYj0e9/pi4kupHL6qo5uMBZB0c6tP4El2m0p+6m0XHqv60E/EqCteeFSuQ7RRvyftRS4erck9xRVhJROaL4LvTXINyk17UkVM7t+PUiTOBpWhrshPe7jDcdmq7YSaWZ7OWi6qfYF0Ka+Za0H4464FOvLdqK7dS7oN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.3.9] (unknown [221.200.12.197])
	by APP-05 (Coremail) with SMTP id zQCowACHuwNwewto+MMBDA--.60615S2;
	Fri, 25 Apr 2025 20:09:22 +0800 (CST)
Message-ID: <2095c40a-a5a8-417a-bd0b-47e782e9f42d@iscas.ac.cn>
Date: Fri, 25 Apr 2025 20:09:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-6.6.y bugreport] riscv: kprobe crash as some patchs lost
To: Nam Cao <namcao@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 stable@vger.kernel.org
References: <c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn>
 <2025042250-backlash-shifting-89cf@gregkh>
 <72896429-e966-4f7a-b2f2-ebc33368eb12@iscas.ac.cn>
 <2025042518-craftily-coronary-b63a@gregkh>
Content-Language: en-US
From: Kai Zhang <zhangkai@iscas.ac.cn>
In-Reply-To: <2025042518-craftily-coronary-b63a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowACHuwNwewto+MMBDA--.60615S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1DKryDKryxAF4xZF18Zrb_yoW8ZFy5pF
	95Ja1Yyr40qr4FyFZ2vw4rWr1rtw1vy3yagr4DJay5Krn09F1aqF1Ig3yUC3ZrWr1ruF1a
	vFnY9a9F93y5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUyv38DUUUU
X-CM-SenderInfo: x2kd0wxndlqxpvfd2hldfou0/1tbiDAgDBmgLT8ibeQABsG

Hi Nam,

I reported a riscv kprobe bug of linux-6.6.y. It seems that 
03753bfacbc6(riscv: kprobes: Fix incorrect address calculation) should 
be reverted. There are a lot of changes of riscv kprobe in upstream. I'm 
not all in sure of my suggested fix. Will you kind to help?

Thanks,
laokz

On 4/25/2025 4:07 PM, Greg Kroah-Hartman wrote:
> On Fri, Apr 25, 2025 at 04:03:41PM +0800, Kai Zhang wrote:
>> On 4/22/2025 4:46 PM, Greg Kroah-Hartman wrote:
>>> On Tue, Apr 22, 2025 at 10:58:42AM +0800, Kai Zhang wrote:
>>>> In most recent linux-6.6.y tree,
>>>> `arch/riscv/kernel/probes/kprobes.c::arch_prepare_ss_slot` still has the
>>>> obsolete code:
>>>>
>>>>       u32 insn = __BUG_INSN_32;
>>>>       unsigned long offset = GET_INSN_LENGTH(p->opcode);
>>>>       p->ainsn.api.restore = (unsigned long)p->addr + offset;
>>>>       patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
>>>>       patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
>>>>
>>>> The last two 1s are wrong size of written instructions , which would lead to
>>>> kernel crash, like `insmod kprobe_example.ko` gives:
>>>>
>>>> [  509.812815][ T2734] kprobe_init: Planted kprobe at 00000000c5c46130
>>>> [  509.837606][    C5] handler_pre: <kernel_clone> p->addr =
>>>> 0x00000000c5c46130, pc = 0xffffffff80032ee2, status = 0x200000120
>>>> [  509.839315][    C5] Oops - illegal instruction [#1]
>>>>
>>>>
>>>> I've tried two patchs from torvalds tree and it didn't crash again:
>>>>
>>>> 51781ce8f448 riscv: Pass patch_text() the length in bytes (rebased)
>>>> 13134cc94914 riscv: kprobes: Fix incorrect address calculation
>>>
>>> Neither of these apply cleanly.  Please provide working backports if you
>>> wish to see them added to the tree.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> revert 03753bfacbc6
>> apply  51781ce8f448
>> apply  13134cc94914
> 
> Thanks, but that's not how we take patches for the stable tree.  Please
> submit these all in a tested patch series and we will be glad to queue
> them up.
> 
> greg k-h


