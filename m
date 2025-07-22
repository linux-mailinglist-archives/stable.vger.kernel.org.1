Return-Path: <stable+bounces-163700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D2B0D992
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8AE170F65
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171032E9730;
	Tue, 22 Jul 2025 12:25:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9B288536
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187157; cv=none; b=oU3h+HO/NkkC+nuVHbEfFibxRB7q6Jt7HCywCw9DUUKwCk7vKUMIGXeTgfevXIhK2CMnoaJ97V3kMnQhIWON82L3obowXsXBq7CEOwO0mHNvc+VuHAAt+kiccmwPWYl1SP3fpAJTB3oNE82hhbcy+miWhn3uWV5DTxEO7x6Pz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187157; c=relaxed/simple;
	bh=D6FDS4tV/qp9T+iWQPVwgr5V1Y5A2r4HIjfCBMAzdws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+r3UMqMeXJDrOw2AdCmQsIRceLi6VUnTkMNJDqVnaeO5cOrJI93/gEdUwaJA6QCi0piGGS0+CFYwlsFNHZ8kwRLcsiTJS77fECKh5OqfmcxnCU4tnG8gGOy42H+EX29ejMDtKxMShWioXEOl18gDqTirVlvEE0Dv32YEOg1KxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmc1Z1DwzzKHMc0
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 20:25:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DA07F1A0BC5
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 20:25:52 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDXlrhNg39otFZlBA--.2363S2;
	Tue, 22 Jul 2025 20:25:50 +0800 (CST)
Message-ID: <ebec24b9-e65e-4050-a960-d127b7215543@huaweicloud.com>
Date: Tue, 22 Jul 2025 20:25:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "Revert "cgroup_freezer: cgroup_freezing: Check if not
 frozen"" has been added to the 6.15-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: chenridong <chenridong@huawei.com>, stable@vger.kernel.org,
 "stable-commits@vger.kernel.org Sasha Levin" <sashal@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20250721125251.814862-1-sashal@kernel.org>
 <1bafc8a024da4a95b28c02430f3d0c9d@huawei.com>
 <3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com>
 <2025072222-effective-jumble-c817@gregkh>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <2025072222-effective-jumble-c817@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDXlrhNg39otFZlBA--.2363S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF47tF13tryDXF4rAF1fZwb_yoWDtFcEg3
	WxuF92k3yDJF1UGFs2gFs0kryDWa12grn5Jr47ArsrA3s8Zay5AF4fXF9agw13Aws2yF1D
	Zw1FqF4kWw1YgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/22 20:18, Greg KH wrote:
> On Tue, Jul 22, 2025 at 09:29:13AM +0800, Chen Ridong wrote:
>>
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
>>>
>>> to the 6.15-stable tree which can be found at:
>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>      revert-cgroup_freezer-cgroup_freezing-check-if-not-f.patch
>>> and it can be found in the queue-6.15 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable tree, please let <stable@vger.kernel.org> know about it.
>>>
>>
>> The patch ("sched,freezer: Remove unnecessary warning in __thaw_task") should also be merged to
>> prevent triggering another warning in __thaw_task().
> 
> What is the git commit id of that change in Linus's tree?
> 
> thanks,
> 
> greg k-h

9beb8c5e77dc10e3889ff5f967eeffba78617a88 ("sched,freezer: Remove unnecessary warning in __thaw_task")

Thanks,
Ridong


