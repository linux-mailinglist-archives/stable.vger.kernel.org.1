Return-Path: <stable+bounces-95685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05439DB2F9
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 08:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D85B210DC
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 07:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769B13BC18;
	Thu, 28 Nov 2024 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfNQMgle"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2158B17C7C;
	Thu, 28 Nov 2024 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732777427; cv=none; b=NVBmqcz33H8YRfNz048WQ2ja89Q0t1A5cXfDOhfH0Pvv4mMWHvex6EP42HVVdQPeBCnizMraeyloamRYqEGTN7FVUnv9BDFoUOluXHXlWR1c53ZJM2UHlKFz22Z/JJMsAmsafbXZmMztSl8KYUNWvMk8NOjv9RUybVjPrLOGtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732777427; c=relaxed/simple;
	bh=zVt3J6zsdz9u4onm7Y0ur1KhRVayLOMICGxc6ZRc/5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvhnnYr4zb/E7w3fnMwmhunmcHvtBQPBf/tvRwYean0cQvaJlzsUMnHGjp7+mgqm78zWctZSABPQ2Jm4oFv/Ca2uLY3WuRdmBpvnfVd6TKRANkEYGxpfpBO5ozLRMDwGN8u9Wj+seNSWz4ciUs9os52vc94y5aSyi2RsE9FMBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfNQMgle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FFFC4CECE;
	Thu, 28 Nov 2024 07:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732777426;
	bh=zVt3J6zsdz9u4onm7Y0ur1KhRVayLOMICGxc6ZRc/5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfNQMgle/VKYacFO73pq1YdLajptRi+SkZ+GCF/RA00LveHNOcZKfMQapq/pyNKx3
	 skN+Smt4i4qoGOD7HTDzJT/QKkDea/RBr5YV75eFyYbcUQKflWW7OFfoy7o3vH6qYO
	 DwQWFn2+23h0PEooA2LjfsDsutRH8Xfmzf62RRUWysa0WCKlW8oCrS0mbZhqsthVsG
	 QrO9rLFifYERUW6/lwuQzycumvB8k8NBJMQu/pbRztwZ8EeOSdH1wFbVkUZHDFJQFF
	 0Waq+JUT05PVW08xeeEpJ9yWu29tJw31gOETw4dPVh+XeUKMDNjNHGipRdL3TlF0iB
	 uHeF1ZpuxMbMw==
Date: Thu, 28 Nov 2024 09:03:33 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH] arch_numa: Restore nid checks before registering a
 memblock with a node
Message-ID: <Z0gVxWstZdKvhY6m@kernel.org>
References: <20241127193000.3702637-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127193000.3702637-1-maz@kernel.org>

Hi Marc,

On Wed, Nov 27, 2024 at 07:30:00PM +0000, Marc Zyngier wrote:
> Commit 767507654c22 ("arch_numa: switch over to numa_memblks")
> significantly cleaned up the NUMA registration code, but also
> dropped a significant check that was refusing to accept to
> configure a memblock with an invalid nid.
> 
> On "quality hardware" such as my ThunderX machine, this results
> in a kernel that dies immediately:
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x431f0a10]
> [    0.000000] Linux version 6.12.0-00013-g8920d74cf8db (maz@valley-girl) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #3872 SMP PREEMPT Wed Nov 27 15:25:49 GMT 2024
> [    0.000000] KASLR disabled due to lack of seed
> [    0.000000] Machine model: Cavium ThunderX CN88XX board
> [    0.000000] efi: EFI v2.4 by American Megatrends
> [    0.000000] efi: ESRT=0xffce0ff18 SMBIOS 3.0=0xfffb0000 ACPI 2.0=0xffec60000 MEMRESERVE=0xffc905d98
> [    0.000000] esrt: Reserving ESRT space from 0x0000000ffce0ff18 to 0x0000000ffce0ff50.
> [    0.000000] earlycon: pl11 at MMIO 0x000087e024000000 (options '115200n8')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] NODE_DATA(0) allocated [mem 0xff6754580-0xff67566bf]
> [    0.000000] Unable to handle kernel paging request at virtual address 0000000000001d40
> [    0.000000] Mem abort info:
> [    0.000000]   ESR = 0x0000000096000004
> [    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.000000]   SET = 0, FnV = 0
> [    0.000000]   EA = 0, S1PTW = 0
> [    0.000000]   FSC = 0x04: level 0 translation fault
> [    0.000000] Data abort info:
> [    0.000000]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    0.000000] [0000000000001d40] user address but active_mm is swapper
> [    0.000000] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.0-00013-g8920d74cf8db #3872
> [    0.000000] Hardware name: Cavium ThunderX CN88XX board (DT)
> [    0.000000] pstate: a00000c5 (NzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.000000] pc : sparse_init_nid+0x54/0x428
> [    0.000000] lr : sparse_init+0x118/0x240
> [    0.000000] sp : ffff800081da3cb0
> [    0.000000] x29: ffff800081da3cb0 x28: 0000000fedbab10c x27: 0000000000000001
> [    0.000000] x26: 0000000ffee250f8 x25: 0000000000000001 x24: ffff800082102cd0
> [    0.000000] x23: 0000000000000001 x22: 0000000000000000 x21: 00000000001fffff
> [    0.000000] x20: 0000000000000001 x19: 0000000000000000 x18: ffffffffffffffff
> [    0.000000] x17: 0000000001b00000 x16: 0000000ffd130000 x15: 0000000000000000
> [    0.000000] x14: 00000000003e0000 x13: 00000000000001c8 x12: 0000000000000014
> [    0.000000] x11: ffff800081e82860 x10: ffff8000820fb2c8 x9 : ffff8000820fb490
> [    0.000000] x8 : 0000000000ffed20 x7 : 0000000000000014 x6 : 00000000001fffff
> [    0.000000] x5 : 00000000ffffffff x4 : 0000000000000000 x3 : 0000000000000000
> [    0.000000] x2 : 0000000000000000 x1 : 0000000000000040 x0 : 0000000000000007
> [    0.000000] Call trace:
> [    0.000000]  sparse_init_nid+0x54/0x428
> [    0.000000]  sparse_init+0x118/0x240
> [    0.000000]  bootmem_init+0x70/0x1c8
> [    0.000000]  setup_arch+0x184/0x270
> [    0.000000]  start_kernel+0x74/0x670
> [    0.000000]  __primary_switched+0x80/0x90
> [    0.000000] Code: f865d804 d37df060 cb030000 d2800003 (b95d4084)
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> 
> while previous kernel versions were able to recognise how brain-damaged
> the machine is, and only build a fake node.
> 
> Restoring the check brings back some sanity and a "working" system.
> 
> Fixes: 767507654c22 ("arch_numa: switch over to numa_memblks")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/base/arch_numa.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index e187016764265..5457248eb0811 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -207,7 +207,21 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>  static int __init numa_register_nodes(void)
>  {
>  	int nid;
> -
> +	struct memblock_region *mblk;
> +
> +	/* Check that valid nid is set to memblks */
> +	for_each_mem_region(mblk) {
> +		int mblk_nid = memblock_get_region_node(mblk);
> +		phys_addr_t start = mblk->base;
> +		phys_addr_t end = mblk->base + mblk->size - 1;
> +
> +		if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
> +			pr_warn("Warning: invalid memblk node %d [mem %pap-%pap]\n",
> +				mblk_nid, &start, &end);
> +			return -EINVAL;
> +		}

We have memblock_validate_numa_coverage() that checks that amount of memory
with unset node id is less than a threshold. The loop here can be replaced
with something like

	if (!memblock_validate_numa_coverage(0))
		return -EINVAL;

> +	}
> + 
>  	/* Finally register nodes. */
>  	for_each_node_mask(nid, numa_nodes_parsed) {
>  		unsigned long start_pfn, end_pfn;
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.

