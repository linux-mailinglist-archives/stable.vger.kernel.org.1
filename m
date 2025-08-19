Return-Path: <stable+bounces-171696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB0BB2B5B5
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2335231D8
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002C719E7F9;
	Tue, 19 Aug 2025 01:06:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2812F32;
	Tue, 19 Aug 2025 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565595; cv=none; b=V7CNAlKw7mItyyPWyFJWc2R37RIPN38NMIARLhIb7TjlNJubjByHciFzgTz5i0/n1tlsH/CSj8P7pZLQXTWzmc9NzOet7ZNHZtcF6kle/lD+RWpJC0z00yClLNuawottYHE3agRnJwCL8f0aXWHl/aUHsS4IHHhPBSufCFgD2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565595; c=relaxed/simple;
	bh=ctHAvGRmbWGO61rQAzhK4Bfk4Xsk3Cii9HXQUkttTXQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R12D42/5X7YebEzS1ZHz4uUqigiNKfLAL5rxl7chiJ02ORE9iSuiWfRCCUtj1wPuHp9LhMJUGwh8iT2vlldSd6pLcyV4BGNTGsrOf5fIMKpGUOIGJx//e2E9Z7ySqzC8f3A/mbtfBdfFCHwWKPBYJWHoS4wUFQN86P6ftRFfaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c5Wcc0gjQzKHMTK;
	Tue, 19 Aug 2025 09:06:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7D7211A0E9F;
	Tue, 19 Aug 2025 09:06:23 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3chMKzqNoUkekEA--.30277S3;
	Tue, 19 Aug 2025 09:06:20 +0800 (CST)
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
 <e0fef2d7-9c72-495e-4c62-7c4fd766c84d@huaweicloud.com>
 <2025081812-stalemate-hug-a179@gregkh>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aa4ca148-2d15-a10b-84d5-8232da12ebf0@huaweicloud.com>
Date: Tue, 19 Aug 2025 09:06:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2025081812-stalemate-hug-a179@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3chMKzqNoUkekEA--.30277S3
X-Coremail-Antispam: 1UD129KBjvJXoWxurWfXFy5ZF45Kr43Xw4UCFg_yoW5ur4Dpa
	4xAFWSkrs8Jr1xAwnIvw40vFy0gw17Jry5Ww1DGr18ZryqvF1xZr4xXrZI9F9FkwnFgr17
	tF4jqasFqr4UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/18 17:39, Greg KH 写道:
> On Mon, Aug 18, 2025 at 03:13:11PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/18 14:38, Greg KH 写道:
>>> On Mon, Aug 18, 2025 at 02:26:23PM +0800, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2025/08/18 13:55, Greg KH 写道:
>>>>> On Mon, Aug 18, 2025 at 09:03:39AM +0800, Yu Kuai wrote:
>>>>>> Hi,
>>>>>>
>>>>>> 在 2025/08/17 22:18, Sasha Levin 写道:
>>>>>>> This is a note to let you know that I've just added the patch titled
>>>>>>>
>>>>>>>         md: call del_gendisk in control path
>>>>>>>
>>>>>>> to the 6.6-stable tree which can be found at:
>>>>>>>         http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>>>>>
>>>>>>> The filename of the patch is:
>>>>>>>          md-call-del_gendisk-in-control-path.patch
>>>>>>> and it can be found in the queue-6.6 subdirectory.
>>>>>>>
>>>>>>> If you, or anyone else, feels it should not be added to the stable tree,
>>>>>>> please let <stable@vger.kernel.org> know about it.
>>>>>>>
>>>>>>>
>>>>>> This patch should be be backported to any stable kernel, this change
>>>>>> will break user tools mdadm:
>>>>>>
>>>>>> https://lore.kernel.org/all/f654db67-a5a5-114b-09b8-00db303daab7@redhat.com/
>>>>>
>>>>> Is it reverted in Linus's tree?
>>>>>
>>>>
>>>> No, we'll not revert it, this is an improvement. In order to keep user
>>>> tools compatibility, we added a switch in the kernel. As discussed in
>>>> the thread, for old tools + new kernel, functionality is the same,
>>>> however, there will be kernel warning about deprecated behaviour to
>>>> inform user upgrading user tools.
>>>>
>>>> However, I feel this new warning messages is not acceptable for
>>>> stable kernels.
>>>
>>> Why?  What is so special about stable kernels that taking the same
>>> functionality in newer kernels is not ok?
>>>
>>> Why not just "warn" the same here if you want to fix an issue where
>>> userspace should be also updating some tools.  As long as you aren't
>>> breaking anything, it should be fine, right?
>>
>> Yes, it's fine, just in downstream kernels, people won't be happy about
>> new warnings.
> 
> People are NEVER happy about new warnings.  So why are you warning them
> at all in newer kernels?

Again, only old user tools + new kernels will warn, and behave like old
tools + old kernels. We'll need both kernel and user tool to be updated
to fix this problem.

> 
>>> Or are you breaking existing workflows?  You should be able to take a
>>> new kernel without any userspace changes and all should work the same.
>>> Why make new kernel users change userspace tools at all?
>>
>> There is a pending fix in mdraid that will be pushed soon, with this
>> nothing will be broken.
> 
> Great, what is the git id?

It's just pushed to Jen's tree:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-6.17&id=25db5f284fb8f30222146ca15b3ab8265789da38
> 
>> And because user tools have problems in this case as well, both kernel
>> and user tools have to be fixed to make things better.
> 
> So Linus's tree right now doesn't work without the pending fix as well?

Sadly, yes, this is indeed a regression from rc1. We're using latest
user tools for test and didn't realize this problem in time.

Thanks,
Kuai

> 
> thanks,
> 
> greg k-h
> 
> .
> 


