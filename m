Return-Path: <stable+bounces-41316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E8B8AFFDC
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 05:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CE01C21641
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 03:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF4513340B;
	Wed, 24 Apr 2024 03:40:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB27101F2
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930044; cv=none; b=OvC/hjvsXuRvxUs4CYMQnP2ZumGowzUq55cG45p3HIOBMu0ym2Ltp/eNyOwYmja6wCWkikJnIeMYXH85KCVAcmp/DM/7dUTaduDX5Fo7jFUHQLOsYPwhCRZpSBnp/z1OZB2O6zBqImtihu/C+9hZ5q+X1qgPCV1HYZzDmNsh4z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930044; c=relaxed/simple;
	bh=uV2L2/CAZAX7umDO9+gYSrzZvlumpFP8wNjelvuoPLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cA8mNgTKuttX1zXo5l8+A8g5XfbtXNbZT+82wdcyK4K9Rr4ojwNXXUn3Uww9gYuzW9w1ADe69JzPQbu6TzU7oiMyvWPV1h+TV/X8L+vGYek+siFn5ZRwbndQ+zpJvO/3gF0cSILK1eG2IEpxH8/ixJxeMAHQGL17ev0MNWGX95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [30.199.224.162] (unknown [42.120.103.66])
	by APP-03 (Coremail) with SMTP id rQCowAAXOCUgfyhmrcikBQ--.8558S2;
	Wed, 24 Apr 2024 11:40:17 +0800 (CST)
Message-ID: <5d49f626-a66f-4969-a03f-fcf83e2d2bab@iscas.ac.cn>
Date: Wed, 24 Apr 2024 11:40:16 +0800
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
 Baoquan He <bhe@redhat.com>, linux-riscv@lists.infradead.org
References: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
 <2024041927-remedial-choking-c548@gregkh>
 <3d6784be-f6ba-48eb-ae0e-b8a20fe90f58@iscas.ac.cn>
 <2024041939-isotope-client-3d75@gregkh>
 <a5493f44-2aac-4005-992b-f2ac90cd1835@iscas.ac.cn>
 <2024042318-muppet-snippet-617c@gregkh>
From: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <2024042318-muppet-snippet-617c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowAAXOCUgfyhmrcikBQ--.8558S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFykKr13CF4Dur1UKryxAFb_yoW5tr4rpF
	Wxuan8tF4Dtr1fK392yw40gFy0qrW3Ary5XrykJwn7JF1qvFyrKrWag3W5ua4DGws8K3y2
	vF4Ygw12vw1rAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
	GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5PpnJUUUUU==
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiBwwRCmYoTFevOgAAsQ

On 4/23/24 21:12, Greg Kroah-Hartman wrote:
> On Fri, Apr 19, 2024 at 10:55:44PM +0800, Mingzheng Xing wrote:
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
>>
>> The link I quoted [1] shows that Baoquan had expressed an opinion on this
>> at the time.
>>
>> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv [1]
> 
> I'm sorry, but I still do not understand what I need to do here for a
> stable branch.  Do I need to apply something?  Revert something?
> Something else?

Hi, Greg

I saw Baoquan's reply in thread[1], thanks Baoquan for confirming.

So I think the right thing to do would be just to REVERT the commit
1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem on RISC-V")
in the 6.6.y branch, which is exactly the patch I submitted. If I need to
make changes to my commit message, feel free to let me know and I'll post
the second version.

Link: https://lore.kernel.org/stable/ZihbAYMOI4ylazpt@MiWiFi-R3L-srv [1]

Thanks,
Mingzheng

> 
> confused,
> 
> greg k-h


