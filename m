Return-Path: <stable+bounces-208315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B236D1C1A2
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 03:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E23803016CE2
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 02:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2AA2F25FB;
	Wed, 14 Jan 2026 02:13:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CB1B3925
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356802; cv=none; b=iJXAVQaEHxc3Q1Pu4EfXQWLFXF+AeLDTtYyD0PsgKPYVZ3RZV9DdEA9VM0Js8hp9ODjSFqSxNVnOj1BZ1VHCD6Lu2SyfU8j0fZjlyOksYFZjY/3nfIxzcV11ryNXGFBTo4vi6poXQr677bVYgVR/Z5CJZo6gPdPHHmUKif5QmAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356802; c=relaxed/simple;
	bh=iNDu3jkEg3AO4cOlA44442GADJe7rnNLsvUEhLCwHhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzz85kfnrzUdMmT0KO3NyAtodocB09TmeUL8vs32VrY74z89DnxPcU0QxVk7L3G9TaLP3eAjeWMMVPdK3+D0I+v8+8Iv0hrWPYd5tOvQ7um78qRZ/I4Ka1216SYFcCiEG2UENOl8p6+X4xG1vpBylin7CRMYWPwYiESePcD71SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4drV5F0Wd5zYQtFK
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 10:13:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0C08440575
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 10:13:18 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBXt_e8+2Zprb3oDg--.38246S2;
	Wed, 14 Jan 2026 10:13:17 +0800 (CST)
Message-ID: <bb71a754-ed2e-4535-aa20-c8d0a9ec4be1@huaweicloud.com>
Date: Wed, 14 Jan 2026 10:13:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] cpuset: Fix missing adaptation for
 cpuset_is_populated
To: gregkh@linuxfoundation.org, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org, lujialin4@huawei.com,
 Chen Ridong <chenridong@huaweicloud.com>
References: <2026011258-raving-unlovable-5059@gregkh>
 <20260114015129.1156361-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260114015129.1156361-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXt_e8+2Zprb3oDg--.38246S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4kWw45GrWDKr1kZw1xuFg_yoW8XFWxpF
	WDua43A3yYgF17C3yDWayS9a4F9w1kGF1jqFn8K3s5Xw17JF4jkr1q93Z0qryrZF43C343
	XFnI9r4SganFyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/14 9:51, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Commit b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
> was backported to the long‑term support (LTS) branches. However, because
> commit d5cf4d34a333 ("cgroup/cpuset: Don't track # of local child
> partitions") was not backported, a corresponding adaptation to the
> backported code is still required.
> 
> To ensure correct behavior, replace cgroup_is_populated with
> cpuset_is_populated in the partition_is_populated function.
> 
> Cc: stable@vger.kernel.org	# 6.1+
> Fixes: b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f61dde0497f3..3c466e742751 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -486,7 +486,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
>  	    cs->attach_in_progress)
>  		return true;
>  	if (!excluded_child && !cs->nr_subparts_cpus)
> -		return cgroup_is_populated(cs->css.cgroup);
> +		return cpuset_is_populated(cs);
>  
>  	rcu_read_lock();
>  	cpuset_for_each_descendant_pre(cp, pos_css, cs) {

Hi Greg,

Is this patch suitable for applying?

Note:  Because the corresponding commit varies between LTS branches,, the Fixes tag points to a
mainline commit.

-- 
Best regards,
Ridong


