Return-Path: <stable+bounces-95908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4509DF6FA
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 20:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CF9162B78
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 19:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE91D79B4;
	Sun,  1 Dec 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn6uQ6V/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078A18A6D3;
	Sun,  1 Dec 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733081556; cv=none; b=TLEz7kD+7yV5JlLocSGbFyS9R/7f5EW6ZejOwpwyFZtnFht7PcubceyU5KOUCzBAheizwlvRu0TAL5BhHXgGOT+byniJBP0hSP5RTqwmLSikSBINLxO8A7tYp5OhCjGObtx5BhjNwe4BkXpPXfgcPFfFrzpChtMQPKwvZgaOJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733081556; c=relaxed/simple;
	bh=l9RHBC8wCeeRN8ABmdLHDhuo5vPgGKTTEL9xHeuZUpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0R0HVgixc/JEOwt0Qwy+JVfsmJOWIB7bWEXkQ20KrWNcUndsKDJpZOwPFMSx6jII6yzeM3FoCBc42mYQxJXaBPxUr8LbVrewKj7EwCtw0cR/M0EOptNaJc4M9bcCJN0IVo6T+4/7uppHq0zyPYks931g9j5srbsTEpuB5Fil5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn6uQ6V/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82136C4CECF;
	Sun,  1 Dec 2024 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733081556;
	bh=l9RHBC8wCeeRN8ABmdLHDhuo5vPgGKTTEL9xHeuZUpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gn6uQ6V/gcYn6ztVD25Yi6lDzqQB5XNyZbl4SIOnIHmqH0Gr1i5OsxAHt34jbJRkv
	 8P5gfAOR7+eGggDFr8KKpd5cQiPKl3b0ojVBc1w7c15ejd9GC2MNntbq5TeT/hMlwF
	 83HIpBx695idmM17uxZsjDwT+cNWOrgoyi8iYM9HtizFnrsuV7l9MKIx7zjAyHw75y
	 +D4RZ+6QYVhVdZZMLHdFfK8qQbAFcNWETPkhHBuFhppL2rlLeh6V7BArufXyQK3WMd
	 NdtWkMeKpmnXc7Qud9rl6xDHTRTKfUnGMpFxsjwezXF1DKG8dVBNFb1/Wvy9DyKaNt
	 WHQGJodTbweZg==
Date: Sun, 1 Dec 2024 21:32:22 +0200
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
Message-ID: <Z0y5xsGgtJrSkyBe@kernel.org>
References: <20241201092702.3792845-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201092702.3792845-1-maz@kernel.org>

Hi Marc,

On Sun, Dec 01, 2024 at 09:27:02AM +0000, Marc Zyngier wrote:
> Commit 767507654c22 ("arch_numa: switch over to numa_memblks")
> significantly cleaned up the NUMA registration code, but also
> dropped a significant check that was refusing to accept to
> configure a memblock with an invalid nid.

... 
 
> while previous kernel versions were able to recognise how brain-damaged
> the machine is, and only build a fake node.
> 
> Use the memblock_validate_numa_coverage() helper to restore some sanity
> and a "working" system.
> 
> Fixes: 767507654c22 ("arch_numa: switch over to numa_memblks")
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/base/arch_numa.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index e187016764265..c63a72a1fed64 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -208,6 +208,10 @@ static int __init numa_register_nodes(void)
>  {
>  	int nid;
>  
> +	/* Check the validity of the memblock/node mapping */
> +	if (!memblock_validate_numa_coverage(1))

I've changed this to memblock_validate_numa_coverage(0) and applied along
with my patch that changed memblock_validate_numa_coverage() to work with
0:

https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git/log/?h=thunderx-fix

Can you please verify that it works on your "quality hardware"?

> +		return -EINVAL;
> +
>  	/* Finally register nodes. */
>  	for_each_node_mask(nid, numa_nodes_parsed) {
>  		unsigned long start_pfn, end_pfn;
> -- 
> 2.39.2

-- 
Sincerely yours,
Mike.

