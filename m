Return-Path: <stable+bounces-95785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB159DC070
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 09:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C41646C8
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 08:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5BB15CD55;
	Fri, 29 Nov 2024 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEUjcVn2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B2E158862;
	Fri, 29 Nov 2024 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732868670; cv=none; b=dKU1zx8qZHvZEVFPf/rodBJYFu8/H6xYdEdRjn+AUpZnx1tK5+KU+d4TmSZfnmgL23yV1/apv3tOg4awRs12HIw4vBQJFaZH77wt1YMDK1YVflY7UyOT/E6BTV+QkXPrlzNff19MN6w8GDCrv9r9KMWf9d2x+BJxrJALoQVs56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732868670; c=relaxed/simple;
	bh=TyO2QLua9PMQVGzO0KGbVnq2AiGW+Rw7plyMIVS9Zc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF404cvKr8oFj7ocbf9C3sbhAfmKTf930862r5orij7Rt1m0JpSIUj5q2TyoomInYxx4ER4hhCnulcWH2dz7057TbzQ+o5nkDUhnlbrhxX8sf9DIinAzKMrs8AeDnVnuZcoX2m0Y46Ca9DWOxaszUCclJXqqGutgSk6focERKgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEUjcVn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C78C4CECF;
	Fri, 29 Nov 2024 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732868669;
	bh=TyO2QLua9PMQVGzO0KGbVnq2AiGW+Rw7plyMIVS9Zc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEUjcVn2rSuMOTb8e39fWrckwFPWTb+56QmvjPUEpyNHm7iuOdCLMol9w+NAc+KMK
	 FIgm/sZVRFGmbxcrIVObeE/Gi+uEvNYLBfSwjICLI776wtvsL3CeLZ0xTC+p1QKyV+
	 ejc+720/GwWj/HNgAxjNyTeU91lMD0iAHxEfupjYY14dqaQqD8rwVZxgjzfnRlanIv
	 +nFnTk7eHghd5DADKRQGspLPpMXaNEIbntMMfTCmKPUGCEZgxFULXzusQHAhMi+L8S
	 9c98jHW3OOcGD2Jnvb232/FeNzbmse1JpxBUg4rjWDd5JDZfTwohDXsqBsj2De2Pmq
	 /sYQZsK7e8KhQ==
Date: Fri, 29 Nov 2024 10:24:16 +0200
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
Message-ID: <Z0l6MPWQ66GjAyOC@kernel.org>
References: <20241127193000.3702637-1-maz@kernel.org>
 <Z0gVxWstZdKvhY6m@kernel.org>
 <87y113s3lt.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y113s3lt.wl-maz@kernel.org>

On Thu, Nov 28, 2024 at 04:52:14PM +0000, Marc Zyngier wrote:
> Hi Mike,
> 
> On Thu, 28 Nov 2024 07:03:33 +0000,
> Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > Hi Marc,
> > 
> > > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > > index e187016764265..5457248eb0811 100644
> > > --- a/drivers/base/arch_numa.c
> > > +++ b/drivers/base/arch_numa.c
> > > @@ -207,7 +207,21 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
> > >  static int __init numa_register_nodes(void)
> > >  {
> > >  	int nid;
> > > -
> > > +	struct memblock_region *mblk;
> > > +
> > > +	/* Check that valid nid is set to memblks */
> > > +	for_each_mem_region(mblk) {
> > > +		int mblk_nid = memblock_get_region_node(mblk);
> > > +		phys_addr_t start = mblk->base;
> > > +		phys_addr_t end = mblk->base + mblk->size - 1;
> > > +
> > > +		if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
> > > +			pr_warn("Warning: invalid memblk node %d [mem %pap-%pap]\n",
> > > +				mblk_nid, &start, &end);
> > > +			return -EINVAL;
> > > +		}
> > 
> > We have memblock_validate_numa_coverage() that checks that amount of memory
> > with unset node id is less than a threshold. The loop here can be replaced
> > with something like
> > 
> > 	if (!memblock_validate_numa_coverage(0))
> > 		return -EINVAL;
> 
> Unfortunately, that doesn't seem to result in something that works
> (relevant extract only):
> 
> [    0.000000] NUMA: no nodes coverage for 9MB of 65516MB RAM
> [    0.000000] NUMA: Faking a node at [mem 0x0000000000500000-0x0000000fff0fffff]
> [    0.000000] NUMA: no nodes coverage for 0MB of 65516MB RAM
> [    0.000000] Unable to handle kernel paging request at virtual address 0000000000001d40
> 
> Any idea?

With 0 as the threshold the validation fails for the fake node, but it
should be fine with memblock_validate_numa_coverage(1)
 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

-- 
Sincerely yours,
Mike.

