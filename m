Return-Path: <stable+bounces-76747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE597C71D
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 11:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCFE1F21131
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9648198E76;
	Thu, 19 Sep 2024 09:27:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD93C0C
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738035; cv=none; b=RBOncnBQ5A8YPmPS0CoVjnJfESQrF2CLs/a7dMYk1oDdI+1saMGPdtHJ+BG6oOPhzf+TfqDLHv/GwP16Vsnnk76z9YYKZjK5fgxXwDvq7UvOeVLknS4iItI5cTq6zG4tFhQieAzkYK4gf5lMt6xLTeQbsfXKtzbqgex+hrufGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738035; c=relaxed/simple;
	bh=QEAp5VV/GX6bRFhkZi7cLdZA5FpUC12kk4qckztFdvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZDTpcTRd1y7uqcEmoppjEUlVjkFvVwGEpkQuKIHu08a7QDooefqDmeFvvRFnwhBEz8amo7mo4d27qGPnqr3uIyGFAI6rVS/uMYhToBzpJYQ56OyMB4/CIGspT6Hh8rm9c74Zi/bJ2Kppfo2S++1lzdQlq5yOd6SrJN1v5kfG7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X8VWP1bkVzyRt2;
	Thu, 19 Sep 2024 17:26:09 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id A07A7180064;
	Thu, 19 Sep 2024 17:27:03 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 19 Sep
 2024 17:27:03 +0800
Message-ID: <951d1526-e4b1-49d4-b5d2-74e1695f3902@huawei.com>
Date: Thu, 19 Sep 2024 17:26:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
To: Fedor Pchelkin <pchelkin@ispras.ru>, Greg Thelen <gthelen@google.com>
CC: Tejun Heo <tj@kernel.org>, Shivani Agarwal <shivani.agarwal@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>
References: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/9/19 16:47, Fedor Pchelkin wrote:
> Greg Thelen wrote:
>> Linux stable v5.10.226 suffers a lockdep warning when accessing
>> /proc/PID/cpuset. cset_cgroup_from_root() is called without cgroup_mutex
>> is held, which causes assertion failure.
>>
>> Bisect blames 5.10.225 commit 688325078a8b ("cgroup/cpuset: Prevent UAF
>> in proc_cpuset_show()"). I've have not easily reproduced the problem
>> that this change fixes, so I'm not sure if it's best to revert the fix
>> or adapt it to meet the 5.10 locking expectations.
>>
>> The lockdep complaint:
>>
>> $ cat /proc/1/cpuset
>> $ dmesg
>> [  198.744891] ------------[ cut here ]------------
>> [  198.744918] WARNING: CPU: 4 PID: 9301 at kernel/cgroup/cgroup.c:1395
>> cset_cgroup_from_root+0xb2/0xd0
>> [  198.744957] RIP: 0010:cset_cgroup_from_root+0xb2/0xd0
>> [  198.744960] Code: 02 00 00 74 11 48 8b 09 48 39 cb 75 eb eb 19 49 83 c6
>> 10 4c 89 f0 48 85 c0 74 0d 5b 41 5e c3 48 8b 43 60 48 85 c0 75 f3 0f 0b
>> <0f> 0b 83 3d 69 01 ee 01 00 0f 85 78 ff ff ff eb 8b 0f 0b eb 87 66
>> [  198.744962] RSP: 0018:ffffb492608a7ce8 EFLAGS: 00010046
>> [  198.744977] RAX: 0000000000000000 RBX: ffffffff8f4171b8 RCX:
>> cc949de848c33e00
>> [  198.744979] RDX: 0000000000001000 RSI: ffffffff8f415450 RDI:
>> ffff92e5417c4dc0
>> [  198.744981] RBP: ffff9303467e3f00 R08: 0000000000000008 R09:
>> ffffffff9122d568
>> [  198.744983] R10: ffff92e5417c4380 R11: 0000000000000000 R12:
>> ffff92e3d9506000
>> [  198.744984] R13: 0000000000000000 R14: ffff92e443a96000 R15:
>> ffff92e3d9506000
>> [  198.744987] FS:  00007f15d94ed740(0000) GS:ffff9302bf500000(0000)
>> knlGS:0000000000000000
>> [  198.744988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  198.744990] CR2: 00007f15d94ca000 CR3: 00000002816ca003 CR4:
>> 00000000001706e0
>> [  198.744992] Call Trace:
>> [  198.744996]  ? __warn+0xcd/0x1c0
>> [  198.745000]  ? cset_cgroup_from_root+0xb2/0xd0
>> [  198.745008]  ? report_bug+0x87/0xf0
>> [  198.745015]  ? handle_bug+0x42/0x80
>> [  198.745017]  ? exc_invalid_op+0x16/0x70
>> [  198.745021]  ? asm_exc_invalid_op+0x12/0x20
>> [  198.745030]  ? cset_cgroup_from_root+0xb2/0xd0
>> [  198.745034]  ? cset_cgroup_from_root+0x28/0xd0
>> [  198.745038]  cgroup_path_ns_locked+0x23/0x50
>> [  198.745044]  proc_cpuset_show+0x115/0x210
>> [  198.745049]  proc_single_show+0x4a/0xa0
>> [  198.745056]  seq_read_iter+0x14d/0x400
>> [  198.745063]  seq_read+0x103/0x130
>> [  198.745074]  vfs_read+0xea/0x320
>> [  198.745078]  ? do_user_addr_fault+0x25b/0x390
>> [  198.745085]  ? do_user_addr_fault+0x25b/0x390
>> [  198.745090]  ksys_read+0x70/0xe0
>> [  198.745096]  do_syscall_64+0x2d/0x40
>> [  198.745099]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> 
> Hello,
> 
> we've also encountered this problem. The thing is that commit 688325078a8b
> ("cgroup/cpuset: Prevent UAF in proc_cpuset_show()") relies on the RCU
> synchronization changes introduced by commit d23b5c577715 ("cgroup: Make
> operations on the cgroup root_list RCU safe") which wasn't backported to
> 5.10 as it couldn't be cleanly applied there. That commit converted access
> to the root_list synchronization from depending on cgroup mutex to be
> RCU-safe.
> 
> 5.15 also has this problem, while 6.1 and later stables have the backport
> of this RCU-changing commit so they are not affected. As mentioned by
> Michal here:
> https://lore.kernel.org/stable/xrc6s5oyf3b5hflsffklogluuvd75h2khanrke2laes3en5js2@6kvpkcxs7ufj/
> 
Yes, I think commit d23b5c577715 ("cgroup: Make operations on the cgroup 
root_list RCU safe") is needed.
> In the next email I'll send the adapted to 5.10/5.15 commit along with its
> upstream-fix to avoid build failure in some situations. Would be nice if
> you give them a try. Thanks!

