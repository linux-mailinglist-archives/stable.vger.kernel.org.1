Return-Path: <stable+bounces-95787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4317C9DC163
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 10:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C938FB2249F
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 09:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF94171E7C;
	Fri, 29 Nov 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pznCXRW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13714F135;
	Fri, 29 Nov 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872218; cv=none; b=kxI1VtE1ubLxWKDyoy+GJoPvPErC2lziUxVqxLOyQaRqCwjG7fwMnx2Nj5KwUDgbpT6Xk8txdeIWpg77Hv3WQD21FzflgY7lvg/EnJ6JcOOncslh9yOZOhMaRpV2S/j/n7p0HQvFl/ZOCUQPebfyai/vhLHuauHf6QRTr2pz6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872218; c=relaxed/simple;
	bh=U7SnWYNG5aseGqVDBZQRYjC0oqz+X5HcHgFpn1GDLNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVy15hBjjjKWm87N1Kv6UCuHrF9BNHCxKlgSxlR+gXiwmgJaN/DfQfwCZTfAREApYFNCkpokhuRE7rwb4Ib4Bz8w3Cd8iX9pdxlQqcuGqq7VRv1ERRrqqrsjaJTnTsSJo0mWChg+MXGlNkTQ3dUHos8aVLFrmpP12t3ILRE6oYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pznCXRW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AB0C4CECF;
	Fri, 29 Nov 2024 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732872218;
	bh=U7SnWYNG5aseGqVDBZQRYjC0oqz+X5HcHgFpn1GDLNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pznCXRW2tZpLBh+VwvXQ7WwJezCk6QmC77dABI64Et9uQaIICuScdtVpLmUukNVG4
	 GDhutLyfl/afUkQ3DtLsGD+4SA6+AZO7QL+hVSs+t8AzMsRLyrw9ioGq3kNGGN5RRl
	 i7Gn4ceCeC0qTy3wbN9EWMLemStK6lzANyn/Kx9xO1sImX+sVlXhgN1AKyQ1OWFTCS
	 zTOaVMAr+pGF4Uc3+46Jaaj8GkbgdBKVWbwZ9I2In6EQshOlZXG57XAtWNGm1diE7l
	 uPO59QKZ/8/wjwV+awom/hW6lLY3SngBAdF7yjSM5ijglrfuv4ckjvXWVRKAmJ/jMh
	 XaKioSwRGgCeg==
Date: Fri, 29 Nov 2024 11:23:24 +0200
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
Message-ID: <Z0mIDBD4KLyxyOCm@kernel.org>
References: <20241127193000.3702637-1-maz@kernel.org>
 <Z0gVxWstZdKvhY6m@kernel.org>
 <87y113s3lt.wl-maz@kernel.org>
 <Z0l6MPWQ66GjAyOC@kernel.org>
 <87v7w6sa5s.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7w6sa5s.wl-maz@kernel.org>

On Fri, Nov 29, 2024 at 08:42:55AM +0000, Marc Zyngier wrote:
> On Fri, 29 Nov 2024 08:24:16 +0000,
> Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > On Thu, Nov 28, 2024 at 04:52:14PM +0000, Marc Zyngier wrote:
> > > Hi Mike,
> > > 
> > > On Thu, 28 Nov 2024 07:03:33 +0000,
> > > Mike Rapoport <rppt@kernel.org> wrote:
> > > > 
> > > > Hi Marc,
> > > > 
> > > > > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > > > > index e187016764265..5457248eb0811 100644
> > > > > --- a/drivers/base/arch_numa.c
> > > > > +++ b/drivers/base/arch_numa.c
> > > > > @@ -207,7 +207,21 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
> > > > >  static int __init numa_register_nodes(void)
> > > > >  {
> > > > >  	int nid;
> > > > > -
> > > > > +	struct memblock_region *mblk;
> > > > > +
> > > > > +	/* Check that valid nid is set to memblks */
> > > > > +	for_each_mem_region(mblk) {
> > > > > +		int mblk_nid = memblock_get_region_node(mblk);
> > > > > +		phys_addr_t start = mblk->base;
> > > > > +		phys_addr_t end = mblk->base + mblk->size - 1;
> > > > > +
> > > > > +		if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
> > > > > +			pr_warn("Warning: invalid memblk node %d [mem %pap-%pap]\n",
> > > > > +				mblk_nid, &start, &end);
> > > > > +			return -EINVAL;
> > > > > +		}
> > > > 
> > > > We have memblock_validate_numa_coverage() that checks that amount of memory
> > > > with unset node id is less than a threshold. The loop here can be replaced
> > > > with something like
> > > > 
> > > > 	if (!memblock_validate_numa_coverage(0))
> > > > 		return -EINVAL;
> > > 
> > > Unfortunately, that doesn't seem to result in something that works
> > > (relevant extract only):
> > > 
> > > [    0.000000] NUMA: no nodes coverage for 9MB of 65516MB RAM
> > > [    0.000000] NUMA: Faking a node at [mem 0x0000000000500000-0x0000000fff0fffff]
> > > [    0.000000] NUMA: no nodes coverage for 0MB of 65516MB RAM
> > > [    0.000000] Unable to handle kernel paging request at virtual address 0000000000001d40
> > > 
> > > Any idea?
> > 
> > With 0 as the threshold the validation fails for the fake node, but it
> > should be fine with memblock_validate_numa_coverage(1)
> 
> Huh, subtle. This indeed seems to work. I'll respin the patch next week.

With the patch below memblock_validate_numa_coverage(0) should also work
and it makes more sense.

@Andrew, I can take both this and Marc's new patch via memblock tree if you
prefer.

From de55af44c02bc9aa43f05a785ac66a5aafa43354 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Fri, 29 Nov 2024 11:13:47 +0200
Subject: [PATCH] memblock: allow zero threshold in validate_numa_converage()

Currently memblock validate_numa_converage() returns false negative when
threshold set to zero.

Make the check if the memory size with invalid node ID is greater than
the threshold exclusive to fix that.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/memblock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 0389ce5cd281..095c18b5c430 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -735,7 +735,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 /**
  * memblock_validate_numa_coverage - check if amount of memory with
  * no node ID assigned is less than a threshold
- * @threshold_bytes: maximal number of pages that can have unassigned node
+ * @threshold_bytes: maximal memory size that can have unassigned node
  * ID (in bytes).
  *
  * A buggy firmware may report memory that does not belong to any node.
@@ -755,7 +755,7 @@ bool __init_memblock memblock_validate_numa_coverage(unsigned long threshold_byt
 			nr_pages += end_pfn - start_pfn;
 	}
 
-	if ((nr_pages << PAGE_SHIFT) >= threshold_bytes) {
+	if ((nr_pages << PAGE_SHIFT) > threshold_bytes) {
 		mem_size_mb = memblock_phys_mem_size() >> 20;
 		pr_err("NUMA: no nodes coverage for %luMB of %luMB RAM\n",
 		       (nr_pages << PAGE_SHIFT) >> 20, mem_size_mb);
-- 
2.45.2

 
> Thanks for your help,
> 
> 	M.

-- 
Sincerely yours,
Mike.

