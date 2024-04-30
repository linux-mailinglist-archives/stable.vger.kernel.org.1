Return-Path: <stable+bounces-41791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C318B692C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 05:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E7F1C21A92
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 03:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3902010799;
	Tue, 30 Apr 2024 03:42:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E25511737
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448538; cv=none; b=peuPXk6ze5QANqAEnmnqi/zk9JhV9ci7BE1RwhkEC9Nha/VkfsaR65dfuk4LKErrp2g+FE/YKrHU3I+UlBfs950tcOR+BjkVZ0YOgq+4lR0YyYn4nO/JDo9YA1gL/7Fqko9c30fFWFsbKmAqSFmcxtLmmCv4RgrkGB/O1uv0s/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448538; c=relaxed/simple;
	bh=brIpXaaa1HeDCJJrRqnmpqEEactkF/axtb7k4YoLe6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6igwi8JIQfGQEdYzwd2ayFLQur3UmGjuU2oYcCevbL55WYMdQD+QuqJgcZOmxEld3v++asueOnE3bMltCVF8Vw2G8Lwbms99dQxsmJQcsNsGPMaWE9o/Ii6QCant/IBIC5qBsKql2GsRL3fLdeLpCSq1qmwjeu5rp253BPoUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.1.103] (unknown [120.221.12.99])
	by APP-05 (Coremail) with SMTP id zQCowABXXgKMaDBmqmdxBw--.35639S2;
	Tue, 30 Apr 2024 11:42:05 +0800 (CST)
Message-ID: <cf921110-4df5-40bb-a197-03c660b51f4a@iscas.ac.cn>
Date: Tue, 30 Apr 2024 11:42:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "riscv: kdump: fix crashkernel reserving problem
 on RISC-V"
To: Baoquan He <bhe@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Chen Jiahao <chenjiahao16@huawei.com>,
 linux-riscv@lists.infradead.org
References: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
 <2024041927-remedial-choking-c548@gregkh>
 <3d6784be-f6ba-48eb-ae0e-b8a20fe90f58@iscas.ac.cn>
 <2024041939-isotope-client-3d75@gregkh>
 <a5493f44-2aac-4005-992b-f2ac90cd1835@iscas.ac.cn>
 <2024042318-muppet-snippet-617c@gregkh>
 <5d49f626-a66f-4969-a03f-fcf83e2d2bab@iscas.ac.cn>
 <2024042944-wriggle-countable-627c@gregkh> <ZjA1Hbik7NiTkZOw@MiWiFi-R3L-srv>
From: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <ZjA1Hbik7NiTkZOw@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowABXXgKMaDBmqmdxBw--.35639S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw15tF18KFW8uw4kZr4rAFb_yoWrZry7pF
	W8GF4Utr4DJr1rKws7tr18KFy8tw13Jry5WrykJw18JFyqvFyrKr43Wr15ua4DWrn8Kw42
	qr4jq342vw18A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JV
	WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
	6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jzHq7UUUUU=
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiCREDCmYwMTLCKgAAss

On 4/30/24 08:02, Baoquan He wrote:
> On 04/29/24 at 12:52pm, Greg Kroah-Hartman wrote:
>> On Wed, Apr 24, 2024 at 11:40:16AM +0800, Mingzheng Xing wrote:
>>> On 4/23/24 21:12, Greg Kroah-Hartman wrote:
>>>> On Fri, Apr 19, 2024 at 10:55:44PM +0800, Mingzheng Xing wrote:
>>>>> On 4/19/24 21:58, Greg Kroah-Hartman wrote:
>>>>>> On Fri, Apr 19, 2024 at 08:26:07PM +0800, Mingzheng Xing wrote:
>>>>>>> On 4/19/24 18:44, Greg Kroah-Hartman wrote:
>>>>>>>> On Tue, Apr 16, 2024 at 04:56:47PM +0800, Mingzheng Xing wrote:
>>>>>>>>> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which has been
>>>>>>>>> merged into the mainline commit 39365395046f ("riscv: kdump: use generic
>>>>>>>>> interface to simplify crashkernel reservation"), but the latter's series of
>>>>>>>>> patches are not included in the 6.6 branch.
>>>>>>>>>
>>>>>>>>> This will result in the loss of Crash kernel data in /proc/iomem, and kdump
>>>>>>>>> loading the kernel will also cause an error:
>>>>>>>>>
>>>>>>>>> ```
>>>>>>>>> Memory for crashkernel is not reserved
>>>>>>>>> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
>>>>>>>>> Then try to loading kdump kernel
>>>>>>>>> ```
>>>>>>>>>
>>>>>>>>> After revert this patch, verify that it works properly on QEMU riscv.
>>>>>>>>>
>>>>>>>>> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv
>>>>>>>>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
>>>>>>>>> ---
>>>>>>>>
>>>>>>>> I do not understand, what branch is this for?  Why have you not cc:ed
>>>>>>>> any of the original developers here?  Why does Linus's tree not have the
>>>>>>>> same problem?  And the first sentence above does not make much sense as
>>>>>>>> a 6.6 change is merged into 6.7?
>>>>>>>
>>>>>>> Sorry, I'll try to explain it more clearly.
>>>>>>>
>>>>>>> This commit 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem
>>>>>>> on RISC-V") should not have existed because this patch has been merged into
>>>>>>> another larger patch [1]. Here is that complete series:
>>>>>>
>>>>>> What "larger patch"?  It is in Linus's tree, so it's not part of
>>>>>> something different, right?  I'm confused.
>>>>>>
>>>>>
>>>>> Hi, Greg
>>>>>
>>>>> The email Cc:ed to author Chen Jiahao was bounced by the system, so maybe
>>>>> we can wait for Baoquan He to confirm.
>>>>>
>>>>> This is indeed a bit confusing. The Fixes: tag in 1d6cd2146c2b58 is a false
>>>>> reference. If I understand correctly, this is similar to the following
>>>>> scenario:
>>>>>
>>>>> A Fixes B, B doesn't go into linus mainline. C contains A, C goes into linus
>>>>> mainline 6.7, and C has more reconstruction code. but A goes into 6.6, so
>>>>> it doesn't make sense for A to be in the mainline, and there's no C in 6.6
>>>>> but there's an A, thus resulting in an incomplete code that creates an error.
>>>>>
>>>>> The link I quoted [1] shows that Baoquan had expressed an opinion on this
>>>>> at the time.
>>>>>
>>>>> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv [1]
>>>>
>>>> I'm sorry, but I still do not understand what I need to do here for a
>>>> stable branch.  Do I need to apply something?  Revert something?
>>>> Something else?
>>>
>>> Hi, Greg
>>>
>>> I saw Baoquan's reply in thread[1], thanks Baoquan for confirming.
>>>
>>> So I think the right thing to do would be just to REVERT the commit
>>> 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem on RISC-V")
>>> in the 6.6.y branch, which is exactly the patch I submitted. If I need to
>>> make changes to my commit message, feel free to let me know and I'll post
>>> the second version.
>>>
>>> Link: https://lore.kernel.org/stable/ZihbAYMOI4ylazpt@MiWiFi-R3L-srv [1]
>>
>> Can someone just send me a patch series showing EXACTLY what needs to be
>> done here, as I am _still_ confused.
> 
> I think Mingzheng's patch is good to apply in the 6.6.y stable branch.
> 
> Hi Mingzheng,
> 
> Can you resend this patch to Greg and stable@vger.kernel.org and CC me?
> I would like to Ack your patch, but can't find the original patch since
> you didn't cc me.

Hi, Greg, Baoquan,

I sent the second version [1]. Thank you for taking the time.

Link: https://lore.kernel.org/stable/20240430032403.19562-1-xingmingzheng@iscas.ac.cn [1]



Best wishes
Mingzheng

> 
> Thanks
> Baoquan


