Return-Path: <stable+bounces-41325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01058B00EE
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 07:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9CEB229B2
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 05:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A892A15445E;
	Wed, 24 Apr 2024 05:19:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCE1E868
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935947; cv=none; b=AIX5kS+1/D4pgEYKHN4wqQoVu1BYTniMJHJV5AmqQT4mIXnPRUv1FuJrSx8jr5XU9Q/FERf1USMQSLqoeaLLSUPN/lf/5BQc/e0RtSeNJWku6RzIXFya0faM4PTBVLk71UGdUmAMMAv1I2Pv3wukv3a/S4ubW+4JewSaaT/z794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935947; c=relaxed/simple;
	bh=8QbkARLx3LfqvMmm25nA9BNgxzhy58laXkfRYbO8Txk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2txKAdZPncfqIIqarczeEDSJVSYnIfuepMOh2E48n5fSWhpPfyWx1jZ3IA4R38BchuUqx2H7epuwvgc2RwSiaggRy6Uo6RQRQFKJf7VIcKyc3xJTqSC8X7CO2qu6KbTs8hblyG6BTEyW8vK4WxEzupeP88jDz3d6Ogj8efzlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [30.199.224.162] (unknown [42.120.103.66])
	by APP-01 (Coremail) with SMTP id qwCowACHzc02lihmD1SzBQ--.4404S2;
	Wed, 24 Apr 2024 13:18:48 +0800 (CST)
Message-ID: <1d3687a3-0a48-434f-95f5-df1e10333341@iscas.ac.cn>
Date: Wed, 24 Apr 2024 13:18:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "riscv: kdump: fix crashkernel reserving problem
 on RISC-V"
To: Baoquan He <bhe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Chen Jiahao <chenjiahao16@huawei.com>
References: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
 <2024041927-remedial-choking-c548@gregkh>
 <3d6784be-f6ba-48eb-ae0e-b8a20fe90f58@iscas.ac.cn>
 <2024041939-isotope-client-3d75@gregkh>
 <a5493f44-2aac-4005-992b-f2ac90cd1835@iscas.ac.cn>
 <ZihbAYMOI4ylazpt@MiWiFi-R3L-srv>
Content-Language: en-US
From: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
In-Reply-To: <ZihbAYMOI4ylazpt@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowACHzc02lihmD1SzBQ--.4404S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFykKr13CF4Dur1UKryxAFb_yoW5ur17pF
	W8Ga1UtF4DJF1rt3yvyr48uFy0qr4ayry5XrWkJr97JF1qvFyFgr4agr45uasrWw45K3y2
	vF4Yg3429w15Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxUgg_TUUUUU
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiBwwRCmYoTFfmFwAAs0

On 4/24/24 09:06, Baoquan He wrote:
> On 04/19/24 at 10:55pm, Mingzheng Xing wrote:
>> On 4/19/24 21:58, Greg Kroah-Hartman wrote:
>>> On Fri, Apr 19, 2024 at 08:26:07PM +0800, Mingzheng Xing wrote:
>>>> On 4/19/24 18:44, Greg Kroah-Hartman wrote:
>>>>> On Tue, Apr 16, 2024 at 04:56:47PM +0800, Mingzheng Xing wrote:
>>>>>> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which has been
>>>>>> merged into the mainline commit 39365395046f ("riscv: kdump: use generic
>>>>>> interface to simplify crashkernel reservation"), but the latter's series of
>>>>>> patches are not included in the 6.6 branch.
>>>>>>
>>>>>> This will result in the loss of Crash kernel data in /proc/iomem, and kdump
>>>>>> loading the kernel will also cause an error:
>>>>>>
>>>>>> ```
>>>>>> Memory for crashkernel is not reserved
>>>>>> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
>>>>>> Then try to loading kdump kernel
>>>>>> ```
>>>>>>
>>>>>> After revert this patch, verify that it works properly on QEMU riscv.
>>>>>>
>>>>>> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv
>>>>>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
>>>>>> ---
>>>>>
>>>>> I do not understand, what branch is this for?  Why have you not cc:ed
>>>>> any of the original developers here?  Why does Linus's tree not have the
>>>>> same problem?  And the first sentence above does not make much sense as
>>>>> a 6.6 change is merged into 6.7?
>>>>
>>>> Sorry, I'll try to explain it more clearly.
>>>>
>>>> This commit 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem
>>>> on RISC-V") should not have existed because this patch has been merged into
>>>> another larger patch [1]. Here is that complete series:
>>>
>>> What "larger patch"?  It is in Linus's tree, so it's not part of
>>> something different, right?  I'm confused.
>>>
>>
>> Hi, Greg
>>
>> The email Cc:ed to author Chen Jiahao was bounced by the system, so maybe
>> we can wait for Baoquan He to confirm.
>>
>> This is indeed a bit confusing. The Fixes: tag in 1d6cd2146c2b58 is a false
>> reference. If I understand correctly, this is similar to the following
>> scenario:
>>
>> A Fixes B, B doesn't go into linus mainline. C contains A, C goes into linus
>> mainline 6.7, and C has more reconstruction code. but A goes into 6.6, so
>> it doesn't make sense for A to be in the mainline, and there's no C in 6.6
>> but there's an A, thus resulting in an incomplete code that creates an error.
> 
> Do you mean commit 1d6cd2146c2b58 ("iscv: kdump: fix crashkernel reserving
> problem on RISC-V") was mistakenly added into v6.6, but the commit which
> it fixed is not existing in v6.6?
> 

Yeah, you're right, and it was merged into 6.7 by another commit
39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation")

> I checked code, it does look like what you said, and it's truly
> confusing. If so, we should revert commit 1d6cd2146c2b58 ("iscv: kdump: fix
> crashkernel reserving problem on RISC-V") in v6.6.y to make kdump work
> on risc-v.

I agree. I built the 6.6.y branch kernel, tested it on qemu, and there is
no 'Crash kernel' entry in /proc/iomem. After revert, it's back to normal.


Thanks,
Mingzheng


