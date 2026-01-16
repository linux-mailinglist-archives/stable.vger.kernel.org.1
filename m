Return-Path: <stable+bounces-209977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D1D29789
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 01:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 810F230101C4
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 00:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68630FC20;
	Fri, 16 Jan 2026 00:57:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EFC305976
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525068; cv=none; b=bLqjq2x+myJkahNP2XKeOi2sc4xqpfEUuI3dJxdAlvgNq9qqin5a3TQz8ouBBOfCaT/9JN59apXIyvmHWWVF7Xr//TTLrDYzv732pVlrc/EV8mw5WInNPchydta07Dy6C2ugsG9915E0W7ZMRAkni7n7lzHMyZCEOC3m9pblxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525068; c=relaxed/simple;
	bh=CYIzBzA7YcsDmxuPnO86plE0WUYV+YhL90uub8NSlSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTBClW3WXDZF9WzmHlac8xJkeyqNDwQ6ODdtxFHylHP+p1iBdcYlX41fWyfRNu12bYgfvPOJAN7ubQ7b5eIcLzbFoSC+Bo8RQDFcTycYSBfUEnryCYq9CfeOF+bF5UJr+oLo4M4FDWGI2eOYctGf6glG0HfMkGqo/NKS2L0Ir2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dshJJ0X1gzKHMbS
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 08:56:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 73BA84058F
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 08:57:42 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAniPgFjWlpSm7SDw--.8246S2;
	Fri, 16 Jan 2026 08:57:42 +0800 (CST)
Message-ID: <24d50280-3cbc-473a-90e9-d749d25f40f6@huaweicloud.com>
Date: Fri, 16 Jan 2026 08:57:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] cpuset: Fix missing adaptation for
 cpuset_is_populated
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 stable@vger.kernel.org, lujialin4@huawei.com
References: <2026011258-raving-unlovable-5059@gregkh>
 <20260114015129.1156361-1-chenridong@huaweicloud.com>
 <bb71a754-ed2e-4535-aa20-c8d0a9ec4be1@huaweicloud.com>
 <2026011510-untouched-widen-8f33@gregkh>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <2026011510-untouched-widen-8f33@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAniPgFjWlpSm7SDw--.8246S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFykJF4fCryxWFWktry5Jwb_yoW8Kr1fpF
	WUWF1aya90gFy3C3yqga1Fga4Fyw4xGF1jqF1DKryrZw17JF12krW0gws0gry8WF4xC345
	ZFsI9rZaga1qyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/15 22:54, Greg KH wrote:
> On Wed, Jan 14, 2026 at 10:13:16AM +0800, Chen Ridong wrote:
>>
>>
>> On 2026/1/14 9:51, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> Commit b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
>>> was backported to the long‑term support (LTS) branches. However, because
>>> commit d5cf4d34a333 ("cgroup/cpuset: Don't track # of local child
>>> partitions") was not backported, a corresponding adaptation to the
>>> backported code is still required.
>>>
>>> To ensure correct behavior, replace cgroup_is_populated with
>>> cpuset_is_populated in the partition_is_populated function.
>>>
>>> Cc: stable@vger.kernel.org	# 6.1+
>>> Fixes: b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>  kernel/cgroup/cpuset.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index f61dde0497f3..3c466e742751 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -486,7 +486,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
>>>  	    cs->attach_in_progress)
>>>  		return true;
>>>  	if (!excluded_child && !cs->nr_subparts_cpus)
>>> -		return cgroup_is_populated(cs->css.cgroup);
>>> +		return cpuset_is_populated(cs);
>>>  
>>>  	rcu_read_lock();
>>>  	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
>>
>> Hi Greg,
>>
>> Is this patch suitable for applying?
>> It needs approval from the maintainers of this file.
> 

Hi, Longman,

I appreciate you could have a review.

>> Note:  Because the corresponding commit varies between LTS branches,, the Fixes tag points to a
>> mainline commit.
> 
> As this is only for 6.1.y, why not point it at the commit there?
> 

This fix (commit b1bcaed1e39a "cpuset: Treat cpusets in attaching as populated") was backported to
the stable branches v6.1 and later. The latest LTS(v6.18) has this issue, so it should be v6.1+.

Cc: stable@vger.kernel.org # v6.1+

> Or is this for other branches?  If so, which ones?  It might be best to
> provide a backport for all of the relevant ones so that we get it right.
> 
> thanks,
> 
> greg k-h

-- 
Best regards,
Ridong


