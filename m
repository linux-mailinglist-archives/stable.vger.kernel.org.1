Return-Path: <stable+bounces-164357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7C7B0E7E0
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 03:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C555653D8
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E21314A8E;
	Wed, 23 Jul 2025 01:01:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8314D19A
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232512; cv=none; b=tm6UgoD5oGZo4G1eYfTRcOIxDUGdEsh8nP9zl9e36OyHHGbsCfWHcluACfx1f3MjqAY/znadUpcCZCEff3fb7tPTzWz1jVT0G97gm31t+b5NdNlZnZDw+C4qjc5t+cYvbF081tqIWpJ9guTcgWpk381gYMoRIOC5DoFuIUxIAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232512; c=relaxed/simple;
	bh=285yY/ngziz6+OaWNmTa89xyEZaDd2YPyc0sfHnmUjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NH7QItP4wjWzw8RDXS4bisDEhRQgTozgfO7OasP0h5RBKbbD2DmFnJ1dEJWMuPDbxoGs9pwKKAtB+DE03XVKCfkEku2eSfyCdZdzKip1zimoh5ObKXpJz1mDxdEu8chmlepivhodWtQV/QyylgCQlMwnnHToQ4E8SioHZSbB/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bmwnm094GzYQvff
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 09:01:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B8BD61A08FF
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 09:01:46 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCHTxB4NIBok1qvBA--.43591S2;
	Wed, 23 Jul 2025 09:01:45 +0800 (CST)
Message-ID: <5c09fe1c-cb0c-46bf-ab6d-fda063a0e812@huaweicloud.com>
Date: Wed, 23 Jul 2025 09:01:43 +0800
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
 <ebec24b9-e65e-4050-a960-d127b7215543@huaweicloud.com>
 <2025072253-gravity-shown-3a37@gregkh>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <2025072253-gravity-shown-3a37@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHTxB4NIBok1qvBA--.43591S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW7ZF4kCr4xGr15KFyxuFg_yoW8WF17p3
	9xCFWYyan5tr17Jw42y3yaqF45trZ3A34jgr1kAr1UtF90qas3XF1xuryS934qvFn7C3W7
	tFyDW34xKrW0v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/22 20:38, Greg KH wrote:
> On Tue, Jul 22, 2025 at 08:25:49PM +0800, Chen Ridong wrote:
>>
>>
>> On 2025/7/22 20:18, Greg KH wrote:
>>> On Tue, Jul 22, 2025 at 09:29:13AM +0800, Chen Ridong wrote:
>>>>
>>>>> This is a note to let you know that I've just added the patch titled
>>>>>
>>>>>     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
>>>>>
>>>>> to the 6.15-stable tree which can be found at:
>>>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>>>
>>>>> The filename of the patch is:
>>>>>      revert-cgroup_freezer-cgroup_freezing-check-if-not-f.patch
>>>>> and it can be found in the queue-6.15 subdirectory.
>>>>>
>>>>> If you, or anyone else, feels it should not be added to the stable tree, please let <stable@vger.kernel.org> know about it.
>>>>>
>>>>
>>>> The patch ("sched,freezer: Remove unnecessary warning in __thaw_task") should also be merged to
>>>> prevent triggering another warning in __thaw_task().
>>>
>>> What is the git commit id of that change in Linus's tree?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> 9beb8c5e77dc10e3889ff5f967eeffba78617a88 ("sched,freezer: Remove unnecessary warning in __thaw_task")
> 
> Thanks, but that didn't apply to 6.1.y or 6.6.y.  Shouldn't it also go
> there as that's what this revert was applied back to.
> 
> greg k-h

Hi Greg,

The commit 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...") should be merged together
with 14a67b42cb6f ("Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"") to avoid the
warning for 6.1.y or 6.6.y.

Best regards,
Ridong


