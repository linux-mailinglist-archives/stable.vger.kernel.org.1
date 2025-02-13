Return-Path: <stable+bounces-116308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CC0A3488E
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953EF164C06
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51719B5A9;
	Thu, 13 Feb 2025 15:49:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAFB26B087;
	Thu, 13 Feb 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461753; cv=none; b=pa0fAgF2uVUInjbHLBFB0cHlqFKOTb5lRo5wRHWXQqGGu1oV9xr2rB0nVjHHz/UmsCSAq7EPAaSgXjZ2MnOheitCk/XQF9+0NVm+CJ93kZaalfG7Y9uilpgNjSsy/EVtFqSwr9VMWWGaui93/NxF4m2ZE5GrRAHeNZPehjJ/8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461753; c=relaxed/simple;
	bh=zNqx96Lg650r5ji9Nv7sUbmpW/ojQ/Y0uItFOwHm02o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vi2eW0HOkF19S/TxPX3AQzACDYuibKGng5zTse68JtqtuMp1DRxCDo8CFGzgKet2b9nWTIQ9Ymz+39j6XWrr0Gg/Xp48Rdc6he8sK6vxXf2PP1S6fATm1BJtKEp8sVTAWMOdK29mgZJZGLfLIG1TEtXK4QJFaXWaMEy+scVM4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BFCC4CED1;
	Thu, 13 Feb 2025 15:49:09 +0000 (UTC)
Date: Thu, 13 Feb 2025 15:49:07 +0000
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
Message-ID: <Z64UcwSGQ53mFmWF@arm.com>
References: <20250213075703.1270713-1-quic_zhenhuah@quicinc.com>
 <9bc91fe3-c590-48e2-b29f-736d0b056c34@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bc91fe3-c590-48e2-b29f-736d0b056c34@redhat.com>

On Thu, Feb 13, 2025 at 01:59:25PM +0100, David Hildenbrand wrote:
> On 13.02.25 08:57, Zhenhua Huang wrote:
> > On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
> > to 27, making one section 128M. The related page struct which vmemmap
> > points to is 2M then.
> > Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
> > vmemmap to populate at the PMD section level which was suitable
> > initially since hot plug granule is always one section(128M). However,
> > commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> > introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
> > existing arm64 assumptions.
> > 
> > Considering the vmemmap_free -> unmap_hotplug_pmd_range path, when
> > pmd_sect() is true, the entire PMD section is cleared, even if there is
> > other effective subsection. For example page_struct_map1 and
> > page_strcut_map2 are part of a single PMD entry and they are hot-added
> > sequentially. Then page_struct_map1 is removed, vmemmap_free() will clear
> > the entire PMD entry freeing the struct page map for the whole section,
> > even though page_struct_map2 is still active. Similar problem exists
> > with linear mapping as well, for 16K base page(PMD size = 32M) or 64K
> > base page(PMD = 512M), their block mappings exceed SUBSECTION_SIZE.
> > Tearing down the entire PMD mapping too will leave other subsections
> > unmapped in the linear mapping.
> > 
> > To address the issue, we need to prevent PMD/PUD/CONT mappings for both
> > linear and vmemmap for non-boot sections if corresponding size on the
> > given base page exceeds SUBSECTION_SIZE(2MB now).
> > 
> > Cc: <stable@vger.kernel.org> # v5.4+
> > Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> 
> Just so I understand correctly: for ordinary memory-sections-size hotplug
> (NVDIMM, virtio-mem), we still get a large mapping where possible?

Up to 2MB blocks only since that's the SUBSECTION_SIZE value. The
vmemmap mapping is also limited to PAGE_SIZE mappings (we could use
contiguous mappings for vmemmap but it's not wired up; I don't think
it's worth the hassle).

-- 
Catalin

