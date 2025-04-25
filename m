Return-Path: <stable+bounces-136663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB6A9C05C
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108BD166538
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD442232395;
	Fri, 25 Apr 2025 08:03:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6117736
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568238; cv=none; b=h8182QXXI40+37Pl3lZGwYoZF0+KsFci7C4wFuFXwCsrrUfclvS6hjjdjdikI3YnBRn3RBYY+WEUfqdASWPmS/PAu9l19/qHIepFM1IxHsfphuM1Y6lum7bKOopoBCy4HIDbYQSjO6Q2HsF61jY71SeUkAlZ+ba/xJ4bHG4So4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568238; c=relaxed/simple;
	bh=v7mAo//a5ic0+0xUKkpyHGBSUSjEhOCEfxNfXAo262Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+M8dd8mvSjNs7kMJA/VmzTLifaG9BH+baZZI3vBTQNLKFtIsgu2CWPCr82IsEUG83ABG6HSwOUGi9Jmazj8fa+3FnDFSJmnJ8v2VTgJX4/sjehxTVg4Zjrm3dQFHNxoUOUEhJhQa9tKKgPUiSOzs6n7l/q4Z5HopLinifiB1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.3.9] (unknown [123.191.43.139])
	by APP-03 (Coremail) with SMTP id rQCowAAXwj7cQQtoLkjbCw--.8S3;
	Fri, 25 Apr 2025 16:03:40 +0800 (CST)
Message-ID: <72896429-e966-4f7a-b2f2-ebc33368eb12@iscas.ac.cn>
Date: Fri, 25 Apr 2025 16:03:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-6.6.y bugreport] riscv: kprobe crash as some patchs lost
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 stable@vger.kernel.org
References: <c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn>
 <2025042250-backlash-shifting-89cf@gregkh>
Content-Language: en-US
From: Kai Zhang <zhangkai@iscas.ac.cn>
In-Reply-To: <2025042250-backlash-shifting-89cf@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowAAXwj7cQQtoLkjbCw--.8S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4kWw1DWw1kJr1xZw1xuFg_yoW8GF15pF
	9Yya1ftFW0qFWFkFs2yws5Wryrtw4vyay3Kr4DJaySkw1Y9r1SqF1IgayUC3ZrGr1F9F1a
	vr1DZ3sFgw45XaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_3UUUUU==
X-CM-SenderInfo: x2kd0wxndlqxpvfd2hldfou0/

On 4/22/2025 4:46 PM, Greg Kroah-Hartman wrote:
> On Tue, Apr 22, 2025 at 10:58:42AM +0800, Kai Zhang wrote:
>> In most recent linux-6.6.y tree,
>> `arch/riscv/kernel/probes/kprobes.c::arch_prepare_ss_slot` still has the
>> obsolete code:
>>
>>      u32 insn = __BUG_INSN_32;
>>      unsigned long offset = GET_INSN_LENGTH(p->opcode);
>>      p->ainsn.api.restore = (unsigned long)p->addr + offset;
>>      patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
>>      patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
>>
>> The last two 1s are wrong size of written instructions , which would lead to
>> kernel crash, like `insmod kprobe_example.ko` gives:
>>
>> [  509.812815][ T2734] kprobe_init: Planted kprobe at 00000000c5c46130
>> [  509.837606][    C5] handler_pre: <kernel_clone> p->addr =
>> 0x00000000c5c46130, pc = 0xffffffff80032ee2, status = 0x200000120
>> [  509.839315][    C5] Oops - illegal instruction [#1]
>>
>>
>> I've tried two patchs from torvalds tree and it didn't crash again:
>>
>> 51781ce8f448 riscv: Pass patch_text() the length in bytes (rebased)
>> 13134cc94914 riscv: kprobes: Fix incorrect address calculation
> 
> Neither of these apply cleanly.  Please provide working backports if you
> wish to see them added to the tree.
> 
> thanks,
> 
> greg k-h

revert 03753bfacbc6
apply  51781ce8f448
apply  13134cc94914

Regards,
laokz


