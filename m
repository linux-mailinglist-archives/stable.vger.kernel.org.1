Return-Path: <stable+bounces-116322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0855FA34C8E
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 18:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978EA188CC30
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92F923A9BE;
	Thu, 13 Feb 2025 17:56:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A823A9BA;
	Thu, 13 Feb 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469419; cv=none; b=ORWWxP+Uh330omxq5KitABzOF/kQESzz/lrfwS9BuCvxFxykQ6/sdtkoZfkxGJDCmsOt4fr10V6mmi/bh6PfAXTqIvlB/FjunSqyHLE+ND5akkspmiahMcAgYfHXx7OTAZWL2QpbaUTFyrNBHH0LGzUNJ2/LdsYFs8cMnYISC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469419; c=relaxed/simple;
	bh=0WV2CmcTZUiH+zQk/eImcSLFCn6EHvq25FoHekBJf6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha6eaXpPiA+MVWaYPHynquYne2hrTGsL2/5eb8ZxObU5uCfas3uwsuL4/JYn1oj1SLkUShR8dK1iVeHmtvI7xnCzyBfK8arDtTf+mpSZ+g7ELjXus6MsahgubF1pEwF3LeysjKrjaPOiSZSWjZVceFIIe7eyVnn3IhppqVbdWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220B4C4CED1;
	Thu, 13 Feb 2025 17:56:55 +0000 (UTC)
Date: Thu, 13 Feb 2025 17:56:53 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, anshuman.khandual@arm.com,
	will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
	mark.rutland@arm.com, joey.gouly@arm.com,
	dave.hansen@linux.intel.com, akpm@linux-foundation.org,
	chenfeiyang@loongson.cn, chenhuacai@kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v6] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
Message-ID: <Z64yZRPpyR9A_BiR@arm.com>
References: <20250213075703.1270713-1-quic_zhenhuah@quicinc.com>
 <9bc91fe3-c590-48e2-b29f-736d0b056c34@redhat.com>
 <Z64UcwSGQ53mFmWF@arm.com>
 <b2964ea1-a22c-4b66-89ef-3082b6d00d21@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2964ea1-a22c-4b66-89ef-3082b6d00d21@redhat.com>

On Thu, Feb 13, 2025 at 05:16:37PM +0100, David Hildenbrand wrote:
> On 13.02.25 16:49, Catalin Marinas wrote:
> > On Thu, Feb 13, 2025 at 01:59:25PM +0100, David Hildenbrand wrote:
> > > On 13.02.25 08:57, Zhenhua Huang wrote:
> > > > On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
> > > > to 27, making one section 128M. The related page struct which vmemmap
> > > > points to is 2M then.
> > > > Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
> > > > vmemmap to populate at the PMD section level which was suitable
> > > > initially since hot plug granule is always one section(128M). However,
> > > > commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> > > > introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
> > > > existing arm64 assumptions.
> > > > 
> > > > Considering the vmemmap_free -> unmap_hotplug_pmd_range path, when
> > > > pmd_sect() is true, the entire PMD section is cleared, even if there is
> > > > other effective subsection. For example page_struct_map1 and
> > > > page_strcut_map2 are part of a single PMD entry and they are hot-added
> > > > sequentially. Then page_struct_map1 is removed, vmemmap_free() will clear
> > > > the entire PMD entry freeing the struct page map for the whole section,
> > > > even though page_struct_map2 is still active. Similar problem exists
> > > > with linear mapping as well, for 16K base page(PMD size = 32M) or 64K
> > > > base page(PMD = 512M), their block mappings exceed SUBSECTION_SIZE.
> > > > Tearing down the entire PMD mapping too will leave other subsections
> > > > unmapped in the linear mapping.
> > > > 
> > > > To address the issue, we need to prevent PMD/PUD/CONT mappings for both
> > > > linear and vmemmap for non-boot sections if corresponding size on the
> > > > given base page exceeds SUBSECTION_SIZE(2MB now).
> > > > 
> > > > Cc: <stable@vger.kernel.org> # v5.4+
> > > > Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> > > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > > 
> > > Just so I understand correctly: for ordinary memory-sections-size hotplug
> > > (NVDIMM, virtio-mem), we still get a large mapping where possible?
> > 
> > Up to 2MB blocks only since that's the SUBSECTION_SIZE value. The
> > vmemmap mapping is also limited to PAGE_SIZE mappings (we could use
> > contiguous mappings for vmemmap but it's not wired up; I don't think
> > it's worth the hassle).
> 
> But that's messed up, no?
> 
> If someone hotplugs a memory section, they have to hotunplug a memory
> section, not parts of it.
> 
> That's why x86 does in vmemmap_populate():
> 
> if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> 	err = vmemmap_populate_basepages(start, end, node, NULL);
> else if (boot_cpu_has(X86_FEATURE_PSE))
> 	err = vmemmap_populate_hugepages(start, end, node, altmap);
> ...
> 
> Maybe I'm missing something. Most importantly, why the weird subsection
> stuff is supposed to degrade ordinary hotplug of dimms/virtio-mem etc.

I think that's based on the discussion for a previous version assuming
that the hotplug/unplug sizes are not guaranteed to be symmetric:

https://lore.kernel.org/lkml/a720aaa5-a75e-481e-b396-a5f2b50ed362@quicinc.com/

If that's not the case, we can indeed ignore the SUBSECTION_SIZE
altogether and just rely on the start/end of the hotplugged region.

-- 
Catalin

