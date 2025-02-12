Return-Path: <stable+bounces-115074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A394CA32EAC
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 19:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244AE1887B0E
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B41825E47A;
	Wed, 12 Feb 2025 18:28:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC525E446;
	Wed, 12 Feb 2025 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384926; cv=none; b=oETWMoq28JmpP5nDad7+5vY70HgQSNextQn7emqITd6CLFF6Ead3G9VVajY1y/qwXB4TQGG/PWK9sqTDzSF/DYZViDd90xf24As0F8R4n0rfDV8OiLFspKV+6iufs/L/JRaGs8ags6aOxXrAJRS5btIkE0+of6Pk6PmOPJaL08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384926; c=relaxed/simple;
	bh=MEkWB4ja2rW/5DxYBYUfS8Zpe+WMG31MnhY7TpmVYNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAlUqLsRKv19v5rQEzWU0ebjTw471rd6s9+dYfeYTzzDuEtzocyuyWfsiPagsP0EdOheCTUkJzrWSaj0CIAdsCU9Rzyw5QHW7GeYHFyzTJS1fTixvfrhvBzcVFGaFjXRKVJdtn68WKUCPUmn9OlT57mxgTixTGkU+vaRRzQjAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD73C4CEDF;
	Wed, 12 Feb 2025 18:28:42 +0000 (UTC)
Date: Wed, 12 Feb 2025 18:28:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: anshuman.khandual@arm.com, will@kernel.org, ardb@kernel.org,
	ryan.roberts@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	dave.hansen@linux.intel.com, akpm@linux-foundation.org,
	chenfeiyang@loongson.cn, chenhuacai@kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v5] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
Message-ID: <Z6zoWMejCDlN2YF9@arm.com>
References: <20250109093824.452925-1-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109093824.452925-1-quic_zhenhuah@quicinc.com>

On Thu, Jan 09, 2025 at 05:38:24PM +0800, Zhenhua Huang wrote:
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
> Considering the vmemmap_free -> unmap_hotplug_pmd_range path, when
> pmd_sect() is true, the entire PMD section is cleared, even if there is
> other effective subsection. For example page_struct_map1 and
> page_strcut_map2 are part of a single PMD entry and they are hot-added
> sequentially. Then page_struct_map1 is removed, vmemmap_free() will clear
> the entire PMD entry freeing the struct page map for the whole section,
> even though page_struct_map2 is still active. Similar problem exists
> with linear mapping as well, for 16K base page(PMD size = 32M) or 64K
> base page(PMD = 512M), their block mappings exceed SUBSECTION_SIZE.
> Tearing down the entire PMD mapping too will leave other subsections
> unmapped in the linear mapping.
> 
> To address the issue, we need to prevent PMD/PUD/CONT mappings for both
> linear and vmemmap for non-boot sections if corresponding size on the
> given base page exceeds SUBSECTION_SIZE(2MB now).
> 
> Cc: stable@vger.kernel.org # v5.4+
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
> Hi Catalin and Anshuman,
> I have addressed comments so far, please help review.
> One outstanding point which not finalized is in vmemmap_populate(): how to judge hotplug
> section. Currently I am using system_state, discussion:
> https://lore.kernel.org/linux-mm/1515dae4-cb53-4645-8c72-d33b27ede7eb@quicinc.com/

The patch looks fine to me, apart from one nit and a question below:

> @@ -1339,9 +1349,27 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  		    struct mhp_params *params)
>  {
>  	int ret, flags = NO_EXEC_MAPPINGS;
> +	unsigned long start_pfn = PFN_DOWN(start);
> +	struct mem_section *ms = __pfn_to_section(start_pfn);
>  
>  	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>  
> +	/* should not be invoked by early section */
> +	WARN_ON(early_section(ms));

I don't remember the discussion, do we still need this warning here if
the sections are not marked as early? I guess we can keep it if one does
an arch_add_memory() on an early section.

I think I suggested to use a WARN_ON_ONCE(!present_section()) but I
completely forgot the memory hotplug code paths.

> +
> +	/*
> +	 * Disallow BlOCK/CONT mappings if the corresponding size exceeds

Nit: capital L in BlOCK.

Either way,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

