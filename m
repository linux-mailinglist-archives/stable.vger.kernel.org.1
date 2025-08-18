Return-Path: <stable+bounces-169930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CA7B29A92
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2839D7A6E7A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F180B279780;
	Mon, 18 Aug 2025 07:13:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385821A8412;
	Mon, 18 Aug 2025 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501201; cv=none; b=qtkxgPB4iBq0+LrVXLlbCicvAJomzx0wsRvwXKCCbhV72ehIshXPBx1gGx9FuBrK7dK7DOOCMWSgqT6pN6T7k2uEneiugzBuM/jGkKacVjZB9pMMVpbaKyJAl84Xj6SScAdOmux67RcDbj/ApNKPxVncBFai/izjRkL6naOm2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501201; c=relaxed/simple;
	bh=gXzjd7SHO90hAluAn6bigXV6r8bbeDuxs3pUSBeslsk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RFzVsaJ+gkiNDjS3rsoJXNXfz2YQeaEEiXbHVk7kSVUAWsvnszWr+hwlPY+XCD2jih8QqD1ka1kDieBPnxaAOIQmDXfVQi1DDYdSlGDdfoHB3tS6mHGnkBsSBM65o+bm/SDt0FUPWu9QSWzWjdC33gbsnsS/+rYfU0MdPBWVgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c53pN73p0zYQvcC;
	Mon, 18 Aug 2025 15:13:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 90EC01A0BA3;
	Mon, 18 Aug 2025 15:13:15 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXUxSH0qJozDNQEA--.20983S3;
	Mon, 18 Aug 2025 15:13:13 +0800 (CST)
Subject: Re: Patch "md: call del_gendisk in control path" has been added to
 the 6.6-stable tree
To: Greg KH <gregkh@linuxfoundation.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, xni@redhat.com,
 Song Liu <song@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250817141818.2370452-1-sashal@kernel.org>
 <7748b907-8279-c222-d4e4-b94c3216408b@huaweicloud.com>
 <2025081846-veneering-radish-498d@gregkh>
 <0c083639-eb30-2830-0938-20684db3914a@huaweicloud.com>
 <2025081804-gloater-brought-c097@gregkh>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e0fef2d7-9c72-495e-4c62-7c4fd766c84d@huaweicloud.com>
Date: Mon, 18 Aug 2025 15:13:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2025081804-gloater-brought-c097@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXUxSH0qJozDNQEA--.20983S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4kKF4UCFW5Ar1xAr48tFb_yoW8KF4Upa
	4IyFsayrs5Jr1IkwnIvw40vryIqw47J345Wwn8Jr1rA3s0vF1xZr4IgrZI9F9Fgw1qgr17
	tFW2q3s7trWUZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUf8nOUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/18 14:38, Greg KH 写道:
> On Mon, Aug 18, 2025 at 02:26:23PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/18 13:55, Greg KH 写道:
>>> On Mon, Aug 18, 2025 at 09:03:39AM +0800, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2025/08/17 22:18, Sasha Levin 写道:
>>>>> This is a note to let you know that I've just added the patch titled
>>>>>
>>>>>        md: call del_gendisk in control path
>>>>>
>>>>> to the 6.6-stable tree which can be found at:
>>>>>        http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>>>
>>>>> The filename of the patch is:
>>>>>         md-call-del_gendisk-in-control-path.patch
>>>>> and it can be found in the queue-6.6 subdirectory.
>>>>>
>>>>> If you, or anyone else, feels it should not be added to the stable tree,
>>>>> please let <stable@vger.kernel.org> know about it.
>>>>>
>>>>>
>>>> This patch should be be backported to any stable kernel, this change
>>>> will break user tools mdadm:
>>>>
>>>> https://lore.kernel.org/all/f654db67-a5a5-114b-09b8-00db303daab7@redhat.com/
>>>
>>> Is it reverted in Linus's tree?
>>>
>>
>> No, we'll not revert it, this is an improvement. In order to keep user
>> tools compatibility, we added a switch in the kernel. As discussed in
>> the thread, for old tools + new kernel, functionality is the same,
>> however, there will be kernel warning about deprecated behaviour to
>> inform user upgrading user tools.
>>
>> However, I feel this new warning messages is not acceptable for
>> stable kernels.
> 
> Why?  What is so special about stable kernels that taking the same
> functionality in newer kernels is not ok?
> 
> Why not just "warn" the same here if you want to fix an issue where
> userspace should be also updating some tools.  As long as you aren't
> breaking anything, it should be fine, right?

Yes, it's fine, just in downstream kernels, people won't be happy about
new warnings.

> 
> Or are you breaking existing workflows?  You should be able to take a
> new kernel without any userspace changes and all should work the same.
> Why make new kernel users change userspace tools at all?

There is a pending fix in mdraid that will be pushed soon, with this
nothing will be broken.

And because user tools have problems in this case as well, both kernel
and user tools have to be fixed to make things better.

Thanks,
Kuai
> 
> thanks,
> 
> greg k-h
> 
> .
> 


