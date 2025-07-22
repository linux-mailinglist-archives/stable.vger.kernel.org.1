Return-Path: <stable+bounces-163632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69044B0CF0E
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 03:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D006C4993
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 01:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA37080C;
	Tue, 22 Jul 2025 01:29:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F72E370E
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753147768; cv=none; b=CWTWf4OtP4PXIR1HDC7McaudHJ9/vRVhmZREFC+GaXFclmsNdMZ2XdkeTywiEOG+8xAR2Pw6RR/CLYb7s3lWlM/N/phyNAgbgu2OBA4J51+zERRtIIx5m1LUBl4r9E3AWIgZ+xuTyaYhpl9p1MA/0QgmRO9NeONTWCmHqVMK9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753147768; c=relaxed/simple;
	bh=tomMNbZHYjI56VxIrLHGVQFC0MWNzXRSli35ZOAIs7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=F3s02i7pnVJAoAFdNoT61Dai+ONhObTDGWg3nRq9kZ1ZYPGuZS3uhqihBnCD+MTXlulVbRAWF+NaNaYDI/VXB2c+B5d8+Mfcc4MQjhfbh5LyKZpWzxhBRaXjcuE0NxBGpGS//0pY0V4v914SkAoIv/YXvUpbF7PG7twFUpLBs8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmKRy2ZVCzKHMtv
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 09:29:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 15E641A1349
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 09:29:17 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgBHubRp6X5oFhEuBA--.6159S2;
	Tue, 22 Jul 2025 09:29:14 +0800 (CST)
Message-ID: <3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com>
Date: Tue, 22 Jul 2025 09:29:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "Revert "cgroup_freezer: cgroup_freezing: Check if not
 frozen"" has been added to the 6.15-stable tree
To: chenridong <chenridong@huawei.com>, stable@vger.kernel.org,
 "stable-commits@vger.kernel.org Sasha Levin" <sashal@kernel.org>
References: <20250721125251.814862-1-sashal@kernel.org>
 <1bafc8a024da4a95b28c02430f3d0c9d@huawei.com>
Content-Language: en-US
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <1bafc8a024da4a95b28c02430f3d0c9d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHubRp6X5oFhEuBA--.6159S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DWF45Ww18GFWrCFyDJrb_yoW5KFWxpw
	s3Cayjkan5tF17Ar42y3yvqF95trZ7Jw4UGrykJ3W8XF43Xas3XFn7Cr15W34UZFykKry7
	tF90gr40k3ykZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/


> This is a note to let you know that I've just added the patch titled
> 
>     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
> 
> to the 6.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      revert-cgroup_freezer-cgroup_freezing-check-if-not-f.patch
> and it can be found in the queue-6.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree, please let <stable@vger.kernel.org> know about it.
> 

The patch ("sched,freezer: Remove unnecessary warning in __thaw_task") should also be merged to
prevent triggering another warning in __thaw_task().

Best regards,
Ridong

> 
> 
> commit ee09694849a570cbc32015b5329b7c2f3f778748
> Author: Chen Ridong <chenridong@huawei.com>
> Date:   Thu Jul 17 08:55:50 2025 +0000
> 
>     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
>     
>     [ Upstream commit 14a67b42cb6f3ab66f41603c062c5056d32ea7dd ]
>     
>     This reverts commit cff5f49d433fcd0063c8be7dd08fa5bf190c6c37.
>     
>     Commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not
>     frozen") modified the cgroup_freezing() logic to verify that the FROZEN
>     flag is not set, affecting the return value of the freezing() function,
>     in order to address a warning in __thaw_task.
>     
>     A race condition exists that may allow tasks to escape being frozen. The
>     following scenario demonstrates this issue:
>     
>     CPU 0 (get_signal path)         CPU 1 (freezer.state reader)
>     try_to_freeze                   read freezer.state
>     __refrigerator                  freezer_read
>                                     update_if_frozen
>     WRITE_ONCE(current->__state, TASK_FROZEN);
>                                     ...
>                                     /* Task is now marked frozen */
>                                     /* frozen(task) == true */
>                                     /* Assuming other tasks are frozen */
>                                     freezer->state |= CGROUP_FROZEN;
>     /* freezing(current) returns false */
>     /* because cgroup is frozen (not freezing) */
>     break out
>     __set_current_state(TASK_RUNNING);
>     /* Bug: Task resumes running when it should remain frozen */
>     
>     The existing !frozen(p) check in __thaw_task makes the
>     WARN_ON_ONCE(freezing(p)) warning redundant. Removing this warning enables
>     reverting the commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check
>     if not frozen") to resolve the issue.
>     
>     The warning has been removed in the previous patch. This patch revert the
>     commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not
>     frozen") to complete the fix.
>     
>     Fixes: cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not frozen")
>     Reported-by: Zhong Jiawei<zhongjiawei1@huawei.com>
>     Signed-off-by: Chen Ridong <chenridong@huawei.com>
>     Signed-off-by: Tejun Heo <tj@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c index 507b8f19a262e..dd9417425d929 100644
> --- a/kernel/cgroup/legacy_freezer.c
> +++ b/kernel/cgroup/legacy_freezer.c
> @@ -66,15 +66,9 @@ static struct freezer *parent_freezer(struct freezer *freezer)  bool cgroup_freezing(struct task_struct *task)  {
>  	bool ret;
> -	unsigned int state;
>  
>  	rcu_read_lock();
> -	/* Check if the cgroup is still FREEZING, but not FROZEN. The extra
> -	 * !FROZEN check is required, because the FREEZING bit is not cleared
> -	 * when the state FROZEN is reached.
> -	 */
> -	state = task_freezer(task)->state;
> -	ret = (state & CGROUP_FREEZING) && !(state & CGROUP_FROZEN);
> +	ret = task_freezer(task)->state & CGROUP_FREEZING;
>  	rcu_read_unlock();
>  
>  	return ret;
> 


