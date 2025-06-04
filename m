Return-Path: <stable+bounces-151304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B417ACD99E
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 10:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1FC188F13B
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC36239561;
	Wed,  4 Jun 2025 08:21:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C72040B6;
	Wed,  4 Jun 2025 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025266; cv=none; b=hnFq070aKbiBlAoeE1t02ZsM6NszD+Szx86M958LCYsm1Y4/HYopPsxlxwrtoc56KpvR9Tpq7J/afPu6onP1tJJ6440qD6aRM1sjTIkdbRJr1t4QHTumTX85y+4Xo19q9EdWQ9aggUGatA/Esh1kKSgRJ+ciFRuS+AWSKsFhyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025266; c=relaxed/simple;
	bh=CAEqzG7Ha8WoSTpkmcaTF8TQ20P1NJVbOgSuJVYZ14Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=negoaOQ1GYLSh647ywciTPiQ89m1H8uKLkoEGTf6QniD1Hq+qvObo3fIxGGD9gQKr5sM05viXOHi6DF21iezW+1mEyDXP/jqR+XAL1wFssoLtPlwfNb9qCfW4/Ms898R5mQ4ILxDyIuOPi0bfJpbuHszOKddWGlHIbJzl3fsZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bC0sB6QDLzYQtHv;
	Wed,  4 Jun 2025 16:21:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E6D111A1956;
	Wed,  4 Jun 2025 16:21:01 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP3 (Coremail) with SMTP id _Ch0CgBnBcDsAUBokXT4OA--.57770S2;
	Wed, 04 Jun 2025 16:21:01 +0800 (CST)
Message-ID: <2b992e24-fe0a-4a20-a0d0-db21851e67d3@huaweicloud.com>
Date: Wed, 4 Jun 2025 16:21:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] selftests/mm: Extract read_sysfs and write_sysfs
 into vm_util
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, mhiramat@kernel.org,
 oleg@redhat.com, peterz@infradead.org, Liam.Howlett@oracle.com,
 vbabka@suse.cz, jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, pulehui@huawei.com
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-4-pulehui@huaweicloud.com>
 <f1dfdffa-23b3-4d4a-8912-3a35e65963e4@lucifer.local>
 <8ea3ec70-dbe7-424f-b07f-add7c1cb1852@huaweicloud.com>
 <20250603193641.f24bf13623565d2b02ae86ce@linux-foundation.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20250603193641.f24bf13623565d2b02ae86ce@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnBcDsAUBokXT4OA--.57770S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/6/4 10:36, Andrew Morton wrote:
> On Tue, 3 Jun 2025 15:17:49 +0800 Pu Lehui <pulehui@huaweicloud.com> wrote:
> 
>>
>>
>>> Not a big deal though, perhaps a bit out of scope here, more of a nice-to-have.
>>
>> ...
>>
>> Yep, we can do it more. But, actually, I am not sure about the merge
>> process of mm module. Do I need to resend the whole series or just the
>> diff below?
>>
> 
> A little diff like this is great, although this one didn't apply for me.
> 
> But if we're to get this series into 6.16-rc1, now is not the time to
> be changing it.  Please send out a formal patch after -rc1?

ok, I will handle this clean after -rc1.


