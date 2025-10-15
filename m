Return-Path: <stable+bounces-185846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADC5BDFD60
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 19:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB7B48320E
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A22338F2C;
	Wed, 15 Oct 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LGLmBhLc"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7121B9F5
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549038; cv=none; b=Ca+YFFB/6KhvfGor/wejHty89bUgwWdOV1yTGiEmv+J2Wwh2R2H9bwro7dPOvI19YoHE+WRpVYdKXZ90bGXtvaNPdQ5uzT4yBAJa+qh6CdGnA9RfUS92Jzd764LhCAlqmqkyOKk/gRs5TDOd+EfbU+rHcAt0JAzyj9K3eRwN5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549038; c=relaxed/simple;
	bh=kfrhw/u3a1k3S4QwLhulWsjxn5BLxbZb/aFjwKek2l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Do7KhyNQHasB7BuKfQhvVdtM8MGlV1HXV8vRysfxLlLzhaeUecDaaxt9Wj7vKfpDjCje9rzyflWoaghyzMxdUmch8lAkX28h69Ncx0Z0LCMF8gi90dg5ESgg9Uc1Dt2+VndwG/aWz6BT8vkm46qs3q/8gv8Qd9kbrJf3arQUBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LGLmBhLc; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f2bac92d-53ea-4db3-a96b-460eb64d7863@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760549024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wupYv6V09Im+EcynNunwUTgjS1xSgd5MLbHN6/dYi9k=;
	b=LGLmBhLcTjtRx9K/Unhu+m7ftR8/FVRtS2vgP5W9OYuEncOYPSEX+GZ2prmWD4lM5vgDQc
	f+csHaDPMWI8M5agCF761U7XZx3cagppdYW1qYzhjsE+tA4zyM2QIkjAbcp2BfmT0JXX59
	/Rbvy3TLFNJjeWOWE+E0mpWs2d4nTfo=
Date: Thu, 16 Oct 2025 01:23:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1 0/6] fix invalid sleeping in detect_cache_attributes()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1759251543.git.wen.yang@linux.dev>
 <2025101509-bucktooth-reawake-5176@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <2025101509-bucktooth-reawake-5176@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/15/25 16:43, Greg Kroah-Hartman wrote:
> On Wed, Oct 01, 2025 at 01:27:25AM +0800, Wen Yang wrote:
>> commit 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection
>> in the CPU hotplug path")
>> adds a call to detect_cache_attributes() to populate the cacheinfo
>> before updating the siblings mask. detect_cache_attributes() allocates
>> memory and can take the PPTT mutex (on ACPI platforms). On PREEMPT_RT
>> kernels, on secondary CPUs, this triggers a:
>>    'BUG: sleeping function called from invalid context'
>> as the code is executed with preemption and interrupts disabled:
>>
>>   | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
>>   | in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/111
>>   | preempt_count: 1, expected: 0
>>   | RCU nest depth: 1, expected: 1
>>   | 3 locks held by swapper/111/0:
>>   |  #0:  (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x218/0x12c8
>>   |  #1:  (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x48/0xf0
>>   |  #2:  (&zone->lock){+.+.}-{3:3}, at: rmqueue_bulk+0x64/0xa80
>>   | irq event stamp: 0
>>   | hardirqs last  enabled at (0):  0x0
>>   | hardirqs last disabled at (0):  copy_process+0x5dc/0x1ab8
>>   | softirqs last  enabled at (0):  copy_process+0x5dc/0x1ab8
>>   | softirqs last disabled at (0):  0x0
>>   | Preemption disabled at:
>>   |  migrate_enable+0x30/0x130
>>   | CPU: 111 PID: 0 Comm: swapper/111 Tainted: G        W          6.0.0-rc4-rt6-[...]
>>   | Call trace:
>>   |  __kmalloc+0xbc/0x1e8
>>   |  detect_cache_attributes+0x2d4/0x5f0
>>   |  update_siblings_masks+0x30/0x368
>>   |  store_cpu_topology+0x78/0xb8
>>   |  secondary_start_kernel+0xd0/0x198
>>   |  __secondary_switched+0xb0/0xb4
>>
>>
>> Pierre fixed this issue in the upstream 6.3 and the original series is follows:
>> https://lore.kernel.org/all/167404285593.885445.6219705651301997538.b4-ty@arm.com/
>>
>> We also encountered the same issue on 6.1 stable branch,  and need to backport this series.
>>
>> Pierre Gondois (6):
>>    cacheinfo: Use RISC-V's init_cache_level() as generic OF
>>      implementation
>>    cacheinfo: Return error code in init_of_cache_level()
>>    cacheinfo: Check 'cache-unified' property to count cache leaves
>>    ACPI: PPTT: Remove acpi_find_cache_levels()
>>    ACPI: PPTT: Update acpi_find_last_cache_level() to
>>      acpi_get_cache_info()
>>    arch_topology: Build cacheinfo from primary CPU
> 
> This series seems to have broken existing systems, as reported here:
> 	https://lore.kernel.org/r/046f08cb-0610-48c9-af24-4804367df177@nvidia.com
> 
> so I'm going to drop it from the queue at this point in time.  Please
> work to resolve this before resubmitting it.
> 

Hi Jon,

Thank you for testing. The root cause here is that this series has 
exposed previously hidden bugs (such as those in 
arch/arm64/boot/dts/nvidia/tgra194.dtsi).

We may need to further backport the following patches:

ommit 27f1568b1d5fe35014074f92717b250afbe67031
Author: Pierre Gondois <pierre.gondois@arm.com>
Date:   Mon Nov 7 16:57:08 2022 +0100

     arm64: tegra: Update cache properties

     The DeviceTree Specification v0.3 specifies that the cache node
     'compatible' and 'cache-level' properties are 'required'. Cf.
     s3.8 Multi-level and Shared Cache Nodes
     The 'cache-unified' property should be present if one of the
     properties for unified cache is present ('cache-size', ...).


But I don't have a Tegra device right now. Could you please apply the 
patch above and verify it again?

--
Best wishes,
Wen




