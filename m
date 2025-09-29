Return-Path: <stable+bounces-181911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E4BA950F
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1744B1920BF4
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E73074AD;
	Mon, 29 Sep 2025 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H7TTTQC0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBF306D48;
	Mon, 29 Sep 2025 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152084; cv=none; b=VuL45jAw3H6xXgDrdzY2QDmI6MJpNMkU9t1XdamGDeyXID1+ekwXKiegV6jSL/is79Fgl30jkQXKKhNBkRW6zzkrOrHRgLgLZ33uveEKUVhq/53tW9CGLJFk4U9ERJddoKqh4Lbn1zI4OAIzbshJSSqtW1uvSY2MjVAqQ0+oVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152084; c=relaxed/simple;
	bh=8qUCEJKJ8ReQkogmLBZaPBurrEIKP6BOYmOK3NXnyJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys1s6TSKesTTQzjA1tATIEOuc0Q+LXFNaL3JGveUk5Banh+h+bVpQx7Z5mAhCFL8LPp+G/8R6csZ9SuKxAClsEwPeS2wFBm51Rya61D+MCNytNdlNk/VWWXicNa1k/xtXGjK5VnKZ68mrSHunL+RSSnDC1lI/daG/cTScMYXDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H7TTTQC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71FAC4CEF4;
	Mon, 29 Sep 2025 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759152084;
	bh=8qUCEJKJ8ReQkogmLBZaPBurrEIKP6BOYmOK3NXnyJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7TTTQC087ZOiDtrqTnJI5wBhUgD5cPONGy+EIoDBrtD+VoCCOh7TtZIjU7evM62I
	 s6PLKG4xI+SN/kynvTc/wUVNkYTNlVgVrdwetr7CvmxvVq1vae6dabchtx6Qkxbb/k
	 HnLeo3ZZokxURH65MlCgaNHUkxFKLIs6C1GTcI7o=
Date: Mon, 29 Sep 2025 15:21:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, Pierre Gondois <pierre.gondois@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.1] arch_topology: Build cacheinfo from primary CPU
Message-ID: <2025092924-anemia-antidote-dad1@gregkh>
References: <20250926174658.6546-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926174658.6546-1-wen.yang@linux.dev>

On Sat, Sep 27, 2025 at 01:46:58AM +0800, Wen Yang wrote:
> From: Pierre Gondois <pierre.gondois@arm.com>
> 
> commit 5944ce092b97caed5d86d961e963b883b5c44ee2 upstream.
> 
> commit 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection
> in the CPU hotplug path")
> adds a call to detect_cache_attributes() to populate the cacheinfo
> before updating the siblings mask. detect_cache_attributes() allocates
> memory and can take the PPTT mutex (on ACPI platforms). On PREEMPT_RT
> kernels, on secondary CPUs, this triggers a:
>   'BUG: sleeping function called from invalid context' [1]
> as the code is executed with preemption and interrupts disabled.
> 
> The primary CPU was previously storing the cache information using
> the now removed (struct cpu_topology).llc_id:
> commit 5b8dc787ce4a ("arch_topology: Drop LLC identifier stash from
> the CPU topology")
> 
> allocate_cache_info() tries to build the cacheinfo from the primary
> CPU prior secondary CPUs boot, if the DT/ACPI description
> contains cache information.
> If allocate_cache_info() fails, then fallback to the current state
> for the cacheinfo allocation. [1] will be triggered in such case.
> 
> When unplugging a CPU, the cacheinfo memory cannot be freed. If it
> was, then the memory would be allocated early by the re-plugged
> CPU and would trigger [1].
> 
> Note that populate_cache_leaves() might be called multiple times
> due to populate_leaves being moved up. This is required since
> detect_cache_attributes() might be called with per_cpu_cacheinfo(cpu)
> being allocated but not populated.
> 
> [1]:
>  | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
>  | in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/111
>  | preempt_count: 1, expected: 0
>  | RCU nest depth: 1, expected: 1
>  | 3 locks held by swapper/111/0:
>  |  #0:  (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x218/0x12c8
>  |  #1:  (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x48/0xf0
>  |  #2:  (&zone->lock){+.+.}-{3:3}, at: rmqueue_bulk+0x64/0xa80
>  | irq event stamp: 0
>  | hardirqs last  enabled at (0):  0x0
>  | hardirqs last disabled at (0):  copy_process+0x5dc/0x1ab8
>  | softirqs last  enabled at (0):  copy_process+0x5dc/0x1ab8
>  | softirqs last disabled at (0):  0x0
>  | Preemption disabled at:
>  |  migrate_enable+0x30/0x130
>  | CPU: 111 PID: 0 Comm: swapper/111 Tainted: G        W          6.0.0-rc4-rt6-[...]
>  | Call trace:
>  |  __kmalloc+0xbc/0x1e8
>  |  detect_cache_attributes+0x2d4/0x5f0
>  |  update_siblings_masks+0x30/0x368
>  |  store_cpu_topology+0x78/0xb8
>  |  secondary_start_kernel+0xd0/0x198
>  |  __secondary_switched+0xb0/0xb4
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Link: https://lore.kernel.org/r/20230104183033.755668-7-pierre.gondois@arm.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: <stable@vger.kernel.org> # 6.1.x: c3719bd:cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation
> Cc: <stable@vger.kernel.org> # 6.1.x: 8844c3d:cacheinfo: Return error code in init_of_cache_level(
> Cc: <stable@vger.kernel.org> # 6.1.x: de0df44:cacheinfo: Check 'cache-unified' property to count cache leaves
> Cc: <stable@vger.kernel.org> # 6.1.x: fa4d566:ACPI: PPTT: Remove acpi_find_cache_levels()
> Cc: <stable@vger.kernel.org> # 6.1.x: bd50036:ACPI: PPTT: Update acpi_find_last_cache_level() to acpi_get_cache_info(
> Cc: <stable@vger.kernel.org> # 6.1.x

I do not understand, why do you want all of these applied as well?  Can
you just send the full series of commits?

> Signed-off-by: Wen Yang <wen.yang@linux.dev>

Also, you have changed this commit a lot from the original one, please
document what you did here.

Also, why not just use 6.6.y instead?  What is forcing you to use 6.1.y
for this platform?  What caused this issue to just show up now?

thanks,

greg k-h

