Return-Path: <stable+bounces-40287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5378AAE7E
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 14:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E21A1F22249
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4461CBE66;
	Fri, 19 Apr 2024 12:32:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF662A1C6
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529932; cv=none; b=SantXGCVX+sBEymRJo0L9nuQgR5/gJI/JNOrI0W3unBQ0lYad29m6Es9TEOFmSXbexKjWbizqr5IwiyDx8ZNOZ+6a9iXDLAq8xjFaMIsrImLuhRbllX3yVTHY4h4UnAWS1UOSlQACTsT2Un5wNsnesC74GZKqYYWyEcEHeK2eBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529932; c=relaxed/simple;
	bh=r9shOnyslFdPRcyMv+NSa8Edn1Dfedz/KSpUNYD8RAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6BuKtQujCHS7aEWHGhG6QODDU1ixCt3Qz8/gqWD3QG1Gh/jmb/qsrMw1xz8HEJb5S65iqB+H5dp1PHPnRc4Qt1yZd8q2yUa8sHhe89CjM6RNdw75BFrw/cgrGg66qkjGDobmmzgH+zweYPlVgYwJ+lZGGEecNkRulqMFyjfR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.1.103] (unknown [120.221.12.99])
	by APP-03 (Coremail) with SMTP id rQCowAC32izgYiJm2FyJBA--.38600S2;
	Fri, 19 Apr 2024 20:26:09 +0800 (CST)
Message-ID: <3d6784be-f6ba-48eb-ae0e-b8a20fe90f58@iscas.ac.cn>
Date: Fri, 19 Apr 2024 20:26:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "riscv: kdump: fix crashkernel reserving problem
 on RISC-V"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Chen Jiahao <chenjiahao16@huawei.com>,
 Baoquan He <bhe@redhat.com>
References: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
 <2024041927-remedial-choking-c548@gregkh>
From: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <2024041927-remedial-choking-c548@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowAC32izgYiJm2FyJBA--.38600S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyrCF4kAF17GF43tF4ruFg_yoW5XF48pa
	yUCa1Dtr4DGFn5Gws7Ar4xua48ZayayFW3ur1kJw18Xr1DJFySgrZIgF1a9Fyjkr4Fkw4Y
	qw4rWryq934rZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUy0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
	YxBIdaVFxhVjvjDU0xZFpf9x07bOoGdUUUUU=
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiBgoMCmYiOAx88gABs1

On 4/19/24 18:44, Greg Kroah-Hartman wrote:
> On Tue, Apr 16, 2024 at 04:56:47PM +0800, Mingzheng Xing wrote:
>> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which has been
>> merged into the mainline commit 39365395046f ("riscv: kdump: use generic
>> interface to simplify crashkernel reservation"), but the latter's series of
>> patches are not included in the 6.6 branch.
>>
>> This will result in the loss of Crash kernel data in /proc/iomem, and kdump
>> loading the kernel will also cause an error:
>>
>> ```
>> Memory for crashkernel is not reserved
>> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
>> Then try to loading kdump kernel
>> ```
>>
>> After revert this patch, verify that it works properly on QEMU riscv.
>>
>> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv
>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
>> ---
> 
> I do not understand, what branch is this for?  Why have you not cc:ed
> any of the original developers here?  Why does Linus's tree not have the
> same problem?  And the first sentence above does not make much sense as
> a 6.6 change is merged into 6.7?

Sorry, I'll try to explain it more clearly.

This commit 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem
on RISC-V") should not have existed because this patch has been merged into
another larger patch [1]. Here is that complete series:

c37e56cac3d62 crash_core.c: remove unneeded functions
39365395046fe riscv: kdump: use generic interface to simplify crashkernel reservation [1]
fdc268232dbba arm64: kdump: use generic interface to simplify crashkernel reservation
9c08a2a139fe8 x86: kdump: use generic interface to simplify crashkernel reservation code
b631b95dded5e crash_core: move crashk_*res definition into crash_core.c
0ab97169aa051 crash_core: add generic function to do reservation
70916e9c8d9f1 crash_core: change parse_crashkernel() to support crashkernel=,high|low parsing
a9e1a3d84e4a0 crash_core: change the prototype of function parse_crashkernel()
a6304272b03ec crash_core.c: remove unnecessary parameter of function

I checked and that series above is not present in 6.6.y. It is only present
in 6.7+. So this commit is causing an error. Crash kernel information
cannot be read from /proc/iomem when using the 6.6.y kernel.

I tested two ways to fix this error, the first one is to revert this
commit. the second one is to backport the complete series above to 6.6.y,
but according to stable-kernel-rules, it seems that the most appropriate
method is the first one.

This revert is only for 6.6.y branch.


Thanks,
Mingzheng

> 
> confused,
> 
> greg k-h


