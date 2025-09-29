Return-Path: <stable+bounces-181973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85C6BAA3E6
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 19:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0693B18BD
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7221DDC2C;
	Mon, 29 Sep 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DzGkY3cJ"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510633086
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168687; cv=none; b=hrd/gn1ZIQ+T6g836mgju0xdrgBN4LpGlmHKpBl0sSO446kdSqDsVXGrHL4zrPFvMB2W94RGIjY7ksUc5T0okC15VXryaqnfHjVJqvFnOuNpxjtWummxHhIZyLaMo3MsgmOFIUD1CPMVk1XJUAYUkv4gZ0Tr88U5FqFWR9a4cSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168687; c=relaxed/simple;
	bh=BWBVhy9j4S04ote3/4wMjKIoFPKinyrGeIej5nlKDB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbtJOi7AmrnMWDAtKiCIxyDmP2v4peq7zy1xEtAq9r3Su2mOnBRJns0pukywm6EiW38em7Zw2PderjLBYaLpQOskOrlgriOoYuRM8op7HyGXDbK6sjl4AX7Z/Hid3OoM7yjRetgYOwX5gIV3P7IdRhnWL4cbPNGVAh9iQp32sok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DzGkY3cJ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f47441af-4147-40df-b79a-2fff4a745eac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759168672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GZKFLy9XWOuRtc8U05w5BMDhPtB8QTqHkZSF6161YE=;
	b=DzGkY3cJf2ZcmAqFPy3f2FwWHqGV+X5JXyiFGD6ymJAsFAPrUOJwThh5Gg/joWnAsFivVs
	HqWBuu6B2T5t/wGx/PBYJGZv8fMKgmsMZQuC6ER9qebUs0XlEIkNIsPPkU2C7lCEV7VZC4
	FzllfwmVBYdH1cuCe9QW6xOolvXMGcc=
Date: Tue, 30 Sep 2025 01:57:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1] arch_topology: Build cacheinfo from primary CPU
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Pierre Gondois <pierre.gondois@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 stable@vger.kernel.org
References: <20250926174658.6546-1-wen.yang@linux.dev>
 <2025092924-anemia-antidote-dad1@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <2025092924-anemia-antidote-dad1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/29/25 21:21, Greg Kroah-Hartman wrote:
> On Sat, Sep 27, 2025 at 01:46:58AM +0800, Wen Yang wrote:
>> From: Pierre Gondois <pierre.gondois@arm.com>
>>
>> commit 5944ce092b97caed5d86d961e963b883b5c44ee2 upstream.
>>

>> adds a call to detect_cache_attributes() to populate the cacheinfo
>> before updating the siblings mask. detect_cache_attributes() allocates
>> memory and can take the PPTT mutex (on ACPI platforms). On PREEMPT_RT
>> kernels, on secondary CPUs, this triggers a:
>>    'BUG: sleeping function called from invalid context' [1]
>> as the code is executed with preemption and interrupts disabled.
>>
>> The primary CPU was previously storing the cache information using
>> the now removed (struct cpu_topology).llc_id:
>> commit 5b8dc787ce4a ("arch_topology: Drop LLC identifier stash from
>> the CPU topology")
>>
>> allocate_cache_info() tries to build the cacheinfo from the primary
>> CPU prior secondary CPUs boot, if the DT/ACPI description
>> contains cache information.
>> If allocate_cache_info() fails, then fallback to the current state
>> for the cacheinfo allocation. [1] will be triggered in such case.
>>
>> When unplugging a CPU, the cacheinfo memory cannot be freed. If it
>> was, then the memory would be allocated early by the re-plugged
>> CPU and would trigger [1].
>>
>> Note that populate_cache_leaves() might be called multiple times
>> due to populate_leaves being moved up. This is required since
>> detect_cache_attributes() might be called with per_cpu_cacheinfo(cpu)
>> being allocated but not populated.
>>
>> [1]:
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
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Link: https://lore.kernel.org/r/20230104183033.755668-7-pierre.gondois@arm.com
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: <stable@vger.kernel.org> # 6.1.x: c3719bd:cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation
>> Cc: <stable@vger.kernel.org> # 6.1.x: 8844c3d:cacheinfo: Return error code in init_of_cache_level(
>> Cc: <stable@vger.kernel.org> # 6.1.x: de0df44:cacheinfo: Check 'cache-unified' property to count cache leaves
>> Cc: <stable@vger.kernel.org> # 6.1.x: fa4d566:ACPI: PPTT: Remove acpi_find_cache_levels()
>> Cc: <stable@vger.kernel.org> # 6.1.x: bd50036:ACPI: PPTT: Update acpi_find_last_cache_level() to acpi_get_cache_info(
>> Cc: <stable@vger.kernel.org> # 6.1.x
> 
> I do not understand, why do you want all of these applied as well?  Can
> you just send the full series of commits?
> 
Thanks for your comments, here is the original series:
https://lore.kernel.org/all/167404285593.885445.6219705651301997538.b4-ty@arm.com/

commit 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection in 
the CPU hotplug path") introduced a bug, and this series fixed it.

>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> 
> Also, you have changed this commit a lot from the original one, please
> document what you did here.
> 
Thanks for the reminder. We just hope to cherry-pick them onto the 6.1 
stable branch, without modifying the original commit.
Also checked again, as follows:

$ git cherry-pick c3719bd
$ git cherry-pick 8844c3d
$ git cherry-pick de0df44
$ git cherry-pick fa4d566
$ git cherry-pick bd50036
$ git cherry-pick 5944ce0

$ git format-patch HEAD -1

$ diff 0001-arch_topology-Build-cacheinfo-from-primary-CPU.patch 
20250927_wen_yang_arch_topology_build_cacheinfo_from_primary_cpu.mbx

Consistent with the original commit.

> Also, why not just use 6.6.y instead?  What is forcing you to use 6.1.y
> for this platform?  What caused this issue to just show up now?
> 

Thank you for your suggestion. But our production environment has been 
using 6.1.y-rt for quite some time now, so we can only gradually migrate 
to 6.6.y.
Perhaps some recently added loads related to power on/off have made it 
easier for this bug to be exposed.
Also hope that the upstream 6.1.y branch could fix it.

--
Best wishes,
Wen





