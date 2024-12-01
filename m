Return-Path: <stable+bounces-95910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C5F9DF70C
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 21:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7861EB213F6
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 20:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4621D86EC;
	Sun,  1 Dec 2024 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBe2hnb4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F51D79B1;
	Sun,  1 Dec 2024 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733083592; cv=none; b=B9EZj7Y7ao/gwP6Jt1OMumH0WwlmxxlSpm9s9wYWnTzGf3p3glUNQ2D3YClNXu5N1FeY5dROfAennq2I6pzvixF4QQra8oNUv5pCd+/RZ0VX5NIw76L8kxemApcoiifsq1qyM/mNElVZ/6VKvZ0sWnmWq25BiqEXRm0uFY1vTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733083592; c=relaxed/simple;
	bh=aaWvKY5SeUb7dYQQStqcqIh1BRTGwRjbSCfwJgwB3qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCSv8GZV5xWWA+7tcLbPfXGxEaa+Logi5Iq/BOGzH+D6+hS5rHOgYYo5vpNkYx2r92d4RPweluOg0CYtUeZ1U0a3FzKCc0WIRaVnX/94KURdoGPVYXb9SMr10Sie4bI1i8Pux4eIElHRvCgqoSnrJCeAz4PTl0yCaCrtHMFL10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBe2hnb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CEEC4CECF;
	Sun,  1 Dec 2024 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733083591;
	bh=aaWvKY5SeUb7dYQQStqcqIh1BRTGwRjbSCfwJgwB3qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBe2hnb4NN7Q9wzlwg6cWgwIJvs6UvM7imwibQYw9DZE26X+tDU9jTLI14lwsWZBr
	 K4aK6k1/T5F9EmezWiBFbW0sBpbjfFP/v4J/hlNwqn2k2pAsC/Cg3HJqokcGRtLxxV
	 1IVArLFgNnXXedF9Z9QBudVNgAfoJG1yE0fqptqercA39/hpCHTIxuA3oR1BJfETSW
	 PpTGgYfhcq3nRgZlGv2Yxd6H8LyF4PMfg7Vws88BMiIYkZMpqwuMrtg/9EULLvIOjT
	 1Id38cq2dvrUivonSKbAPwIOju71HAfMAkXG2cAmPaWd7ZAQQa+S9yQ0d3nKQ2na5M
	 1KxtzgAL2A2hA==
Date: Sun, 1 Dec 2024 22:06:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] arch_numa: Restore nid checks before registering a
 memblock with a node
Message-ID: <Z0zBu1NhzRMfgIIt@kernel.org>
References: <20241201092702.3792845-1-maz@kernel.org>
 <Z0y5xsGgtJrSkyBe@kernel.org>
 <86zflftc87.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86zflftc87.wl-maz@kernel.org>

On Sun, Dec 01, 2024 at 07:49:44PM +0000, Marc Zyngier wrote:
> Hi Mike,
> 
> On Sun, 01 Dec 2024 19:32:22 +0000,
> Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > Hi Marc,
> > 
> > On Sun, Dec 01, 2024 at 09:27:02AM +0000, Marc Zyngier wrote:
> > > Commit 767507654c22 ("arch_numa: switch over to numa_memblks")
> > > significantly cleaned up the NUMA registration code, but also
> > > dropped a significant check that was refusing to accept to
> > > configure a memblock with an invalid nid.
> > 
> > ... 
> >  
> > > while previous kernel versions were able to recognise how brain-damaged
> > > the machine is, and only build a fake node.
> > > 
> > > Use the memblock_validate_numa_coverage() helper to restore some sanity
> > > and a "working" system.
> > > 
> > > Fixes: 767507654c22 ("arch_numa: switch over to numa_memblks")
> > > Suggested-by: Mike Rapoport <rppt@kernel.org>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Zi Yan <ziy@nvidia.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/base/arch_numa.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > > index e187016764265..c63a72a1fed64 100644
> > > --- a/drivers/base/arch_numa.c
> > > +++ b/drivers/base/arch_numa.c
> > > @@ -208,6 +208,10 @@ static int __init numa_register_nodes(void)
> > >  {
> > >  	int nid;
> > >  
> > > +	/* Check the validity of the memblock/node mapping */
> > > +	if (!memblock_validate_numa_coverage(1))
> > 
> > I've changed this to memblock_validate_numa_coverage(0) and applied along
> > with my patch that changed memblock_validate_numa_coverage() to work with
> > 0:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git/log/?h=thunderx-fix
> > 
> > Can you please verify that it works on your "quality hardware"?
> 
> Commit 427c6179e159b in your tree still has memblock_validate_numa_coverage(1).
> Forgot to push out the updated version?

Argh, indeed. 
 
> Flipping this to 0 locally, I have verified that this still allows the
> old thing to trudge along:
> 
> root@duodenum:~# uname -a
> Linux duodenum 6.12.0-12115-g427c6179e159-dirty #3896 SMP PREEMPT Sun Dec  1 19:43:13 GMT 2024 aarch64

Thanks for testing!
 
> Thanks again,
> 
> 	M.

-- 
Sincerely yours,
Mike.

