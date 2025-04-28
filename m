Return-Path: <stable+bounces-136882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F90A9F050
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830FD17FB9F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE8267F47;
	Mon, 28 Apr 2025 12:10:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935F267F5B
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745842220; cv=none; b=I/vsMCdUGvT+kNW12Fbf5bisnKtYR8HKWTYFFkZzuqSeUBsmXHyZanLi57mv6Yw6l41jmEQtRbRusrEUef7iZer9G64gXqZOlH+q+3QcdzBaz7hoBgTnxo1siPAl4x1Mhm8t4Vciyrfq6vnwbB+IdUSVkR5yblHg6GWE1FunKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745842220; c=relaxed/simple;
	bh=TOtrYvusaWAVpffwZm8MwXSb2c8OdDPpQmJ60PwGEJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hllf2QoDsKtA8leSzaffqYmEtzMkUGINhj2+Ks9aLXGsIHR2tYdD4Ljm+wwuCJbiv6C5Z+Ma7id17rR1jU3ixCs/Tm7EZqukJVKheljZ6Ad+NLF/1ZXn5zBIKSw7JUzCyOAKz5OOqGqbSL73Qe3NPuhd+edY99X6WnYA+gW8KUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.3.9] (unknown [221.200.12.197])
	by APP-05 (Coremail) with SMTP id zQCowABXlAwccA9ojPUpDQ--.17447S2;
	Mon, 28 Apr 2025 20:10:05 +0800 (CST)
Message-ID: <73a1fc16-6af0-4283-87bc-f45e401f3d7a@iscas.ac.cn>
Date: Mon, 28 Apr 2025 20:10:04 +0800
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
 <2095c40a-a5a8-417a-bd0b-47e782e9f42d@iscas.ac.cn>
 <20250425124950.FQzzDETT@linutronix.de>
 <20250425125912.57u73cuH@linutronix.de>
 <c66369fa-4042-4a76-9d1c-9e581f003526@iscas.ac.cn>
 <20250428072248.JgEWTcfe@linutronix.de>
Content-Language: en-US
From: Kai Zhang <zhangkai@iscas.ac.cn>
In-Reply-To: <20250428072248.JgEWTcfe@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowABXlAwccA9ojPUpDQ--.17447S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4DCr4ktr43uryxuFW5trb_yoW5tw4fpF
	18JF4ayF48tr4YyFnFkw18Wry3tw1qqF13Xr1DJr15twn0vFyavF12grWUua4DXr15Cr1a
	yr1jgay7Zr1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07boDGrUUUUU=
X-CM-SenderInfo: x2kd0wxndlqxpvfd2hldfou0/1tbiBgoGBmgPTAuDsQAAse

On 4/28/2025 3:22 PM, Nam Cao wrote:
> On Fri, Apr 25, 2025 at 11:29:17PM +0800, Kai Zhang wrote:
>> On 4/25/2025 8:59 PM, Nam Cao wrote:
>>> On Fri, Apr 25, 2025 at 02:49:52PM +0200, Nam Cao wrote:
>>>> On Fri, Apr 25, 2025 at 08:09:21PM +0800, Kai Zhang wrote:
>>>>> On 4/25/2025 4:07 PM, Greg Kroah-Hartman wrote:
>>>>>> On Fri, Apr 25, 2025 at 04:03:41PM +0800, Kai Zhang wrote:
>>>>>>> On 4/22/2025 4:46 PM, Greg Kroah-Hartman wrote:
>>>>>>>> On Tue, Apr 22, 2025 at 10:58:42AM +0800, Kai Zhang wrote:
>>>>>>>>> In most recent linux-6.6.y tree,
>>>>>>>>> `arch/riscv/kernel/probes/kprobes.c::arch_prepare_ss_slot` still has the
>>>>>>>>> obsolete code:
>>>>>>>>>
>>>>>>>>>         u32 insn = __BUG_INSN_32;
>>>>>>>>>         unsigned long offset = GET_INSN_LENGTH(p->opcode);
>>>>>>>>>         p->ainsn.api.restore = (unsigned long)p->addr + offset;
>>>>>>>>>         patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
>>>>>>>>>         patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
>>>>>>>>>
>>>>>>>>> The last two 1s are wrong size of written instructions , which would lead to
>>>>>>>>> kernel crash, like `insmod kprobe_example.ko` gives:
>>>>>>>>>
>>>>>>>>> [  509.812815][ T2734] kprobe_init: Planted kprobe at 00000000c5c46130
>>>>>>>>> [  509.837606][    C5] handler_pre: <kernel_clone> p->addr =
>>>>>>>>> 0x00000000c5c46130, pc = 0xffffffff80032ee2, status = 0x200000120
>>>>>>>>> [  509.839315][    C5] Oops - illegal instruction [#1]
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I've tried two patchs from torvalds tree and it didn't crash again:
>>>>>>>>>
>>>>>>>>> 51781ce8f448 riscv: Pass patch_text() the length in bytes (rebased)
>>>>>>>>> 13134cc94914 riscv: kprobes: Fix incorrect address calculation
>>>>
>>>> Please don't revert this patch. It fixes another issue.
>>>>
>>>> You are correct that the sizes of the instructions are wrong. It can still
>>>> happen to work if only one instruction is patched.
>>>>
>>>> This bug is not specific to v6.6. It is in mainline as well. Therefore fix
>>>> patch should be sent to mainline, and then backport to v6.6.
>>>
>>> Sorry, I was confused. This is not in mainline. It has already been fixed
>>> by 51781ce8f448 ("riscv: Pass patch_text() the length in bytes")
>>
>> Indeed.
>>
>>> But I wouldn't backport that patch, it is bigger than necessary. The patch
>>> I sent in the previous email should be enough.
>>
>> My suggested fixes are:
>>
>> revert 03753bfacbc6(riscv: kprobes: Fix incorrect address calculation)
>> apply  51781ce8f448(riscv: Pass patch_text() the length in bytes)
>> apply  13134cc94914(riscv: kprobes: Fix incorrect address calculation)
> 
> This is probably fine. But I'm paranoid that as 51781ce8f448 ("riscv:
> Pass patch_text() the length in bytes") does many things, it may break
> something else in v6.6.
> 
> Also, just my preference, but I wouldn't revert a commit then apply it
> again. I would only cherry-pick 51781ce8f448, and resolve conflicts.
> 
>> Because stable-only commit 03753bfacbc6 is actually rebased upstream
>> 13134cc94914, and 13134cc94914 relied on 51781ce8f448. So I gave the above
>> suggestion. But I'm ok with your previous email patch.
> 
> It was just my suggestion. Do as you think best, CC the relevant people
> (RISCV maintainers and authors of those commits), see what they think.
> 
> Or I could send the diff I sent earlier as a proper patch. Up to you.

Great. I'd like you could help fix the problem. Thanks again.

laokz

> Best regards,
> Nam


