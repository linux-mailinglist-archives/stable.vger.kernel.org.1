Return-Path: <stable+bounces-121093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45482A50B1F
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 20:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8C53B10BE
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6717257433;
	Wed,  5 Mar 2025 18:59:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A02257424;
	Wed,  5 Mar 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201188; cv=none; b=bbrrL2gHcDeEedLXObzdg9phWIkOlEXdO1ouEegD8oMgl2Z3P54l7LkGtkJ+BucTPEIPWO0MT1ykR8tDH7j5/qHRpwSgcTc8sEDSEQ7J0rw0Zb2Xi10K6LXPhvSZVtYg8QkTg5eef6jzERChIyYzhuGZb92Vqv3/XXAToHOMD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201188; c=relaxed/simple;
	bh=KOntfY2GF79iwDM2QQoQy22zDcX3Cb1Ne2iCHZjE6+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnUssadkE74NfTaj+dTB858lFyM45hCkVYpowxWmufb9bZ/z2uyp2iAxhCheQLvXNkbUzpCKu9Z+npOVisV4QeZYA8TUDBt7rZEVu/GsMo4HiijtVtcYaHjD9VuEdfN/eGUia7O4VBa/WTi6x3cFNIg2HKDi6CDsH2TGVEz0SO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADD8C4CED1;
	Wed,  5 Mar 2025 18:59:45 +0000 (UTC)
Date: Wed, 5 Mar 2025 18:59:43 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: anshuman.khandual@arm.com, david@redhat.com, will@kernel.org,
	ardb@kernel.org, ryan.roberts@arm.com, mark.rutland@arm.com,
	joey.gouly@arm.com, dave.hansen@linux.intel.com,
	akpm@linux-foundation.org, chenfeiyang@loongson.cn,
	chenhuacai@kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v9] arm64: mm: Populate vmemmap at the page level if not
 section aligned
Message-ID: <Z8ifH6HILN_7sZDk@arm.com>
References: <20250304072700.3405036-1-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304072700.3405036-1-quic_zhenhuah@quicinc.com>

On Tue, Mar 04, 2025 at 03:27:00PM +0800, Zhenhua Huang wrote:
> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
> to 27, making one section 128M. The related page struct which vmemmap
> points to is 2M then.
> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
> vmemmap to populate at the PMD section level which was suitable
> initially since hot plug granule is always one section(128M). However,
> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
> existing arm64 assumptions.
> 
> The first problem is that if start or end is not aligned to a section
> boundary, such as when a subsection is hot added, populating the entire
> section is wasteful.
> 
> The next problem is if we hotplug something that spans part of 128 MiB
> section (subsections, let's call it memblock1), and then hotplug something
> that spans another part of a 128 MiB section(subsections, let's call it
> memblock2), and subsequently unplug memblock1, vmemmap_free() will clear
> the entire PMD entry which also supports memblock2 even though memblock2
> is still active.
> 
> Assuming hotplug/unplug sizes are guaranteed to be symmetric. Do the
> fix similar to x86-64: populate to pages levels if start/end is not aligned
> with section boundary.
> 
> Cc: <stable@vger.kernel.org> # v5.4+
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  arch/arm64/mm/mmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Will, another bug that has been around for ages. Do you want to take it
as a fix?

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b4df5bc5b1b8..1dfe1a8efdbe 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1177,8 +1177,11 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  		struct vmem_altmap *altmap)
>  {
>  	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
> +	/* [start, end] should be within one section */
> +	WARN_ON_ONCE(end - start > PAGES_PER_SECTION * sizeof(struct page));
>  
> -	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
> +	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
> +	    (end - start < PAGES_PER_SECTION * sizeof(struct page)))
>  		return vmemmap_populate_basepages(start, end, node, altmap);
>  	else
>  		return vmemmap_populate_hugepages(start, end, node, altmap);
> -- 
> 2.25.1
> 

-- 
Catalin

