Return-Path: <stable+bounces-200895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D786CCB899B
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 11:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01A0C301B837
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CBF31691A;
	Fri, 12 Dec 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4zyYpBp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A45A298CDC
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534553; cv=none; b=WEFi3/NvXhEMRq2AaXCG/ulbdcRvNTbkXaKUGf04NIQ0BPj/fULGMcUFRahZMgiKZ1ucUGRNheIpT8YlVDnyNnXXxYQnTNvPksEfNP1NZG26nCWvW21IEIneF1SX8VA/SmkWk6Bsr3YyDTJ2TSv2vgpfGJMEadRTIlMa6vcd9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534553; c=relaxed/simple;
	bh=4bS+4fjFBpMrEtDLjKP6iHaOb3NAEQzPpg13VVG2xqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L2jqrGekXOsj1kwCHVn99xivz1DblHmi7YhWtE38wEh6s1TWwYewIqAlM62IllyWr0EOX1bOuyqVMniZs3XU/NOIiGWenlKDd7zChBPQ1loM/oU4HGKg2sxGpuLNNQRiIhBcZFDI9hsQLC3dzWgwiozPTmg2lJgE0a9R1wPB3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4zyYpBp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765534550; x=1797070550;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4bS+4fjFBpMrEtDLjKP6iHaOb3NAEQzPpg13VVG2xqo=;
  b=f4zyYpBpTN685Sp7hkVV8XoyCAk60ki6s3YntQiybpgYWKxO+gi0taLI
   QK7fR93JRz7N/yaSOsOCDJLpSPW5fao8EemjNC6STOyhKBcfoEavetRbA
   hqYa76gIGyEKhCpaphwWIelI+qvJEQ9cZ0IUbaQZiYm2lTEIkF1BMnxlp
   sMFg/dA+1IQYMkxV9k+iv2oC+UDbRdZueeS8FjfeReJ/1lUEnpdxtWZwk
   N7ahIlbPMMlN889JNIuT3Zeqb8G23zOu+ID6VcMLcO1KdMuI+4wmMResL
   iYtI2bDXovZB4tMMCexG3Y43XEG3q2oPKnB7nFE/jZmiigL8vgBflvvoD
   A==;
X-CSE-ConnectionGUID: +wgkiQ8CR7qtzVR5UdrLEQ==
X-CSE-MsgGUID: JL304XdaSmKrSFJRDEnPjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67600589"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="67600589"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 02:15:49 -0800
X-CSE-ConnectionGUID: QfkjyAR3QdqomBKnYtgobw==
X-CSE-MsgGUID: GZ8LYhktRYO8/QnXCfzj8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="201467898"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.245.106]) ([10.245.245.106])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 02:15:47 -0800
Message-ID: <f4fc9e25d47079f66b5c68502d7c1b46ee19b0cf.camel@linux.intel.com>
Subject: Re: [PATCH v4 02/22] drm/pagemap, drm/xe: Ensure that the devmem
 allocation is idle before use
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>, 
	intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, apopple@nvidia.com, airlied@gmail.com,
 Simona Vetter <simona.vetter@ffwll.ch>, felix.kuehling@amd.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, dakr@kernel.org,
 "Mrozek, Michal"	 <michal.mrozek@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>
Date: Fri, 12 Dec 2025 11:15:43 +0100
In-Reply-To: <a20bfe73-3713-46cf-b357-d5d49cf9ba5a@intel.com>
References: <20251211165909.219710-1-thomas.hellstrom@linux.intel.com>
	 <20251211165909.219710-3-thomas.hellstrom@linux.intel.com>
	 <a20bfe73-3713-46cf-b357-d5d49cf9ba5a@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, Himal,


On Fri, 2025-12-12 at 14:54 +0530, Ghimiray, Himal Prasad wrote:
>=20
>=20
> On 11-12-2025 22:28, Thomas Hellstr=C3=B6m wrote:
> > In situations where no system memory is migrated to devmem, and in
> > upcoming patches where another GPU is performing the migration to
> > the newly allocated devmem buffer, there is nothing to ensure any
> > ongoing clear to the devmem allocation or async eviction from the
> > devmem allocation is complete.
> >=20
> > Address that by passing a struct dma_fence down to the copy
> > functions, and ensure it is waited for before migration is marked
> > complete.
> >=20
> > v3:
> > - New patch.
> > v4:
> > - Update the logic used for determining when to wait for the
> > =C2=A0=C2=A0 pre_migrate_fence.
> > - Update the logic used for determining when to warn for the
> > =C2=A0=C2=A0 pre_migrate_fence since the scheduler fences apparently
> > =C2=A0=C2=A0 can signal out-of-order.
> >=20
> > Fixes: c5b3eb5a906c ("drm/xe: Add GPUSVM device memory copy vfunc
> > functions")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.15+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0 drivers/gpu/drm/drm_pagemap.c | 13 ++++---
> > =C2=A0 drivers/gpu/drm/xe/xe_svm.c=C2=A0=C2=A0 | 67
> > ++++++++++++++++++++++++++++++-----
> > =C2=A0 include/drm/drm_pagemap.h=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++--
> > =C2=A0 3 files changed, 81 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_pagemap.c
> > b/drivers/gpu/drm/drm_pagemap.c
> > index 22c44807e3fe..864a73d019ed 100644
> > --- a/drivers/gpu/drm/drm_pagemap.c
> > +++ b/drivers/gpu/drm/drm_pagemap.c
> > @@ -408,7 +408,8 @@ int drm_pagemap_migrate_to_devmem(struct
> > drm_pagemap_devmem *devmem_allocation,
> > =C2=A0=C2=A0		drm_pagemap_get_devmem_page(page, zdd);
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	err =3D ops->copy_to_devmem(pages, pagemap_addr, npages);
> > +	err =3D ops->copy_to_devmem(pages, pagemap_addr, npages,
> > +				=C2=A0 devmem_allocation-
> > >pre_migrate_fence);
> > =C2=A0=C2=A0	if (err)
> > =C2=A0=C2=A0		goto err_finalize;
> > =C2=A0=20
> > @@ -596,7 +597,7 @@ int drm_pagemap_evict_to_ram(struct
> > drm_pagemap_devmem *devmem_allocation)
> > =C2=A0=C2=A0	for (i =3D 0; i < npages; ++i)
> > =C2=A0=C2=A0		pages[i] =3D migrate_pfn_to_page(src[i]);
> > =C2=A0=20
> > -	err =3D ops->copy_to_ram(pages, pagemap_addr, npages);
> > +	err =3D ops->copy_to_ram(pages, pagemap_addr, npages, NULL);
> > =C2=A0=C2=A0	if (err)
> > =C2=A0=C2=A0		goto err_finalize;
> > =C2=A0=20
> > @@ -732,7 +733,7 @@ static int __drm_pagemap_migrate_to_ram(struct
> > vm_area_struct *vas,
> > =C2=A0=C2=A0	for (i =3D 0; i < npages; ++i)
> > =C2=A0=C2=A0		pages[i] =3D migrate_pfn_to_page(migrate.src[i]);
> > =C2=A0=20
> > -	err =3D ops->copy_to_ram(pages, pagemap_addr, npages);
> > +	err =3D ops->copy_to_ram(pages, pagemap_addr, npages, NULL);
> > =C2=A0=C2=A0	if (err)
> > =C2=A0=C2=A0		goto err_finalize;
> > =C2=A0=20
> > @@ -813,11 +814,14 @@
> > EXPORT_SYMBOL_GPL(drm_pagemap_pagemap_ops_get);
> > =C2=A0=C2=A0 * @ops: Pointer to the operations structure for GPU SVM de=
vice
> > memory
> > =C2=A0=C2=A0 * @dpagemap: The struct drm_pagemap we're allocating from.
> > =C2=A0=C2=A0 * @size: Size of device memory allocation
> > + * @pre_migrate_fence: Fence to wait for or pipeline behind before
> > migration starts.
> > + * (May be NULL).
> > =C2=A0=C2=A0 */
> > =C2=A0 void drm_pagemap_devmem_init(struct drm_pagemap_devmem
> > *devmem_allocation,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev, struct mm_s=
truct
> > *mm,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_pagemap_devmem=
_ops
> > *ops,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap *dpagemap, size_t
> > size)
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap *dpagemap, size_t
> > size,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *pre_migrate_fence)
> > =C2=A0 {
> > =C2=A0=C2=A0	init_completion(&devmem_allocation->detached);
> > =C2=A0=C2=A0	devmem_allocation->dev =3D dev;
> > @@ -825,6 +829,7 @@ void drm_pagemap_devmem_init(struct
> > drm_pagemap_devmem *devmem_allocation,
> > =C2=A0=C2=A0	devmem_allocation->ops =3D ops;
> > =C2=A0=C2=A0	devmem_allocation->dpagemap =3D dpagemap;
> > =C2=A0=C2=A0	devmem_allocation->size =3D size;
> > +	devmem_allocation->pre_migrate_fence =3D pre_migrate_fence;
> > =C2=A0 }
> > =C2=A0 EXPORT_SYMBOL_GPL(drm_pagemap_devmem_init);
> > =C2=A0=20
> > diff --git a/drivers/gpu/drm/xe/xe_svm.c
> > b/drivers/gpu/drm/xe/xe_svm.c
> > index 36634c84d148..2152d20049e4 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.c
> > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > @@ -483,11 +483,12 @@ static void xe_svm_copy_us_stats_incr(struct
> > xe_gt *gt,
> > =C2=A0=20
> > =C2=A0 static int xe_svm_copy(struct page **pages,
> > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_a=
ddr *pagemap_addr,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages, const enu=
m
> > xe_svm_copy_dir dir)
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages, const enu=
m
> > xe_svm_copy_dir dir,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *pre_migrate_f=
ence)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct xe_vram_region *vr =3D NULL;
> > =C2=A0=C2=A0	struct xe_gt *gt =3D NULL;
> > -	struct xe_device *xe;
> > +	struct xe_device *xe =3D NULL;
> > =C2=A0=C2=A0	struct dma_fence *fence =3D NULL;
> > =C2=A0=C2=A0	unsigned long i;
> > =C2=A0 #define XE_VRAM_ADDR_INVALID	~0x0ull
> > @@ -496,6 +497,18 @@ static int xe_svm_copy(struct page **pages,
> > =C2=A0=C2=A0	bool sram =3D dir =3D=3D XE_SVM_COPY_TO_SRAM;
> > =C2=A0=C2=A0	ktime_t start =3D xe_svm_stats_ktime_get();
> > =C2=A0=20
> > +	if (pre_migrate_fence && (sram ||
> > dma_fence_is_container(pre_migrate_fence))) {
>=20
> Patch LGTM. Nit, Moving sram check for p2p migration from source here
> makes better sense with [Patch 22] drm/pagemap: Support source
> migration=20
> over interconnect

Just to make sure I get this right, You're suggesting moving the sram
check above and the comment below about source migration to the source
migration patch (22), right? If so, Yeah that makes sense.

Thomas


>=20
>=20
> > +		/*
> > +		 * This would typically be a p2p migration from
> > source, or
> > +		 * a composite fence operation on the destination
> > memory.
> > +		 * Ensure that any other GPU operation on the
> > destination
> > +		 * is complete.
> > +		 */
> > +		err =3D dma_fence_wait(pre_migrate_fence, true);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > =C2=A0=C2=A0	/*
> > =C2=A0=C2=A0	 * This flow is complex: it locates physically contiguous
> > device pages,
> > =C2=A0=C2=A0	 * derives the starting physical address, and performs a
> > single GPU copy
> > @@ -632,10 +645,28 @@ static int xe_svm_copy(struct page **pages,
> > =C2=A0=20
> > =C2=A0 err_out:
> > =C2=A0=C2=A0	/* Wait for all copies to complete */
> > -	if (fence) {
> > +	if (fence)
> > =C2=A0=C2=A0		dma_fence_wait(fence, false);
> > -		dma_fence_put(fence);
> > +
> > +	/*
> > +	 * If migrating to devmem, we should have pipelined the
> > migration behind
> > +	 * the pre_migrate_fence. Verify that this is indeed
> > likely. If we
> > +	 * didn't perform any copying, just wait for the
> > pre_migrate_fence.
> > +	 */
> > +	if (!sram && pre_migrate_fence &&
> > !dma_fence_is_signaled(pre_migrate_fence)) {
> > +		if (xe && fence &&
> > +		=C2=A0=C2=A0=C2=A0 (pre_migrate_fence->context !=3D fence->context
> > ||
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_is_later(pre_migrate_fence,
> > fence))) {
> > +			drm_WARN(&xe->drm, true, "Unsignaled pre-
> > migrate fence");
> > +			drm_warn(&xe->drm, "fence contexts: %llu
> > %llu. container %d\n",
> > +				 (unsigned long long)fence-
> > >context,
> > +				 (unsigned long
> > long)pre_migrate_fence->context,
> > +			=09
> > dma_fence_is_container(pre_migrate_fence));
> > +		}
> > +
> > +		dma_fence_wait(pre_migrate_fence, false);
> > =C2=A0=C2=A0	}
> > +	dma_fence_put(fence);
> > =C2=A0=20
> > =C2=A0=C2=A0	/*
> > =C2=A0=C2=A0	 * XXX: We can't derive the GT here (or anywhere in this
> > functions, but
> > @@ -652,16 +683,20 @@ static int xe_svm_copy(struct page **pages,
> > =C2=A0=20
> > =C2=A0 static int xe_svm_copy_to_devmem(struct page **pages,
> > =C2=A0=C2=A0				 struct drm_pagemap_addr
> > *pagemap_addr,
> > -				 unsigned long npages)
> > +				 unsigned long npages,
> > +				 struct dma_fence
> > *pre_migrate_fence)
> > =C2=A0 {
> > -	return xe_svm_copy(pages, pagemap_addr, npages,
> > XE_SVM_COPY_TO_VRAM);
> > +	return xe_svm_copy(pages, pagemap_addr, npages,
> > XE_SVM_COPY_TO_VRAM,
> > +			=C2=A0=C2=A0 pre_migrate_fence);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static int xe_svm_copy_to_ram(struct page **pages,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_addr
> > *pagemap_addr,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages)
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *pre_migrate_fence)
> > =C2=A0 {
> > -	return xe_svm_copy(pages, pagemap_addr, npages,
> > XE_SVM_COPY_TO_SRAM);
> > +	return xe_svm_copy(pages, pagemap_addr, npages,
> > XE_SVM_COPY_TO_SRAM,
> > +			=C2=A0=C2=A0 pre_migrate_fence);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static struct xe_bo *to_xe_bo(struct drm_pagemap_devmem
> > *devmem_allocation)
> > @@ -676,6 +711,7 @@ static void xe_svm_devmem_release(struct
> > drm_pagemap_devmem *devmem_allocation)
> > =C2=A0=20
> > =C2=A0=C2=A0	xe_bo_put_async(bo);
> > =C2=A0=C2=A0	xe_pm_runtime_put(xe);
> > +	dma_fence_put(devmem_allocation->pre_migrate_fence);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static u64 block_offset_to_pfn(struct xe_vram_region *vr, u64
> > offset)
> > @@ -868,6 +904,7 @@ static int xe_drm_pagemap_populate_mm(struct
> > drm_pagemap *dpagemap,
> > =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long timeslice_=
ms)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct xe_vram_region *vr =3D container_of(dpagemap,
> > typeof(*vr), dpagemap);
> > +	struct dma_fence *pre_migrate_fence =3D NULL;
> > =C2=A0=C2=A0	struct xe_device *xe =3D vr->xe;
> > =C2=A0=C2=A0	struct device *dev =3D xe->drm.dev;
> > =C2=A0=C2=A0	struct drm_buddy_block *block;
> > @@ -894,8 +931,20 @@ static int xe_drm_pagemap_populate_mm(struct
> > drm_pagemap *dpagemap,
> > =C2=A0=C2=A0			break;
> > =C2=A0=C2=A0		}
> > =C2=A0=20
> > +		/* Ensure that any clearing or async eviction will
> > complete before migration. */
> > +		if (!dma_resv_test_signaled(bo->ttm.base.resv,
> > DMA_RESV_USAGE_KERNEL)) {
> > +			err =3D dma_resv_get_singleton(bo-
> > >ttm.base.resv, DMA_RESV_USAGE_KERNEL,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0
> > &pre_migrate_fence);
> > +			if (err)
> > +				dma_resv_wait_timeout(bo-
> > >ttm.base.resv, DMA_RESV_USAGE_KERNEL,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false,
> > MAX_SCHEDULE_TIMEOUT);
> > +			else if (pre_migrate_fence)
> > +				dma_fence_enable_sw_signaling(pre_
> > migrate_fence);
> > +		}
> > +
> > =C2=A0=C2=A0		drm_pagemap_devmem_init(&bo->devmem_allocation,
> > dev, mm,
> > -					&dpagemap_devmem_ops,
> > dpagemap, end - start);
> > +					&dpagemap_devmem_ops,
> > dpagemap, end - start,
> > +					pre_migrate_fence);
> > =C2=A0=20
> > =C2=A0=C2=A0		blocks =3D &to_xe_ttm_vram_mgr_resource(bo-
> > >ttm.resource)->blocks;
> > =C2=A0=C2=A0		list_for_each_entry(block, blocks, link)
> > diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> > index f6e7e234c089..70a7991f784f 100644
> > --- a/include/drm/drm_pagemap.h
> > +++ b/include/drm/drm_pagemap.h
> > @@ -8,6 +8,7 @@
> > =C2=A0=20
> > =C2=A0 #define NR_PAGES(order) (1U << (order))
> > =C2=A0=20
> > +struct dma_fence;
> > =C2=A0 struct drm_pagemap;
> > =C2=A0 struct drm_pagemap_zdd;
> > =C2=A0 struct device;
> > @@ -174,6 +175,8 @@ struct drm_pagemap_devmem_ops {
> > =C2=A0=C2=A0	 * @pages: Pointer to array of device memory pages
> > (destination)
> > =C2=A0=C2=A0	 * @pagemap_addr: Pointer to array of DMA information
> > (source)
> > =C2=A0=C2=A0	 * @npages: Number of pages to copy
> > +	 * @pre_migrate_fence: dma-fence to wait for before
> > migration start.
> > +	 * May be NULL.
> > =C2=A0=C2=A0	 *
> > =C2=A0=C2=A0	 * Copy pages to device memory. If the order of a
> > @pagemap_addr entry
> > =C2=A0=C2=A0	 * is greater than 0, the entry is populated but
> > subsequent entries
> > @@ -183,13 +186,16 @@ struct drm_pagemap_devmem_ops {
> > =C2=A0=C2=A0	 */
> > =C2=A0=C2=A0	int (*copy_to_devmem)(struct page **pages,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_addr
> > *pagemap_addr,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages);
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence
> > *pre_migrate_fence);
> > =C2=A0=20
> > =C2=A0=C2=A0	/**
> > =C2=A0=C2=A0	 * @copy_to_ram: Copy to system RAM (required for
> > migration)
> > =C2=A0=C2=A0	 * @pages: Pointer to array of device memory pages
> > (source)
> > =C2=A0=C2=A0	 * @pagemap_addr: Pointer to array of DMA information
> > (destination)
> > =C2=A0=C2=A0	 * @npages: Number of pages to copy
> > +	 * @pre_migrate_fence: dma-fence to wait for before
> > migration start.
> > +	 * May be NULL.
> > =C2=A0=C2=A0	 *
> > =C2=A0=C2=A0	 * Copy pages to system RAM. If the order of a
> > @pagemap_addr entry
> > =C2=A0=C2=A0	 * is greater than 0, the entry is populated but
> > subsequent entries
> > @@ -199,7 +205,8 @@ struct drm_pagemap_devmem_ops {
> > =C2=A0=C2=A0	 */
> > =C2=A0=C2=A0	int (*copy_to_ram)(struct page **pages,
> > =C2=A0=C2=A0			=C2=A0=C2=A0 struct drm_pagemap_addr *pagemap_addr,
> > -			=C2=A0=C2=A0 unsigned long npages);
> > +			=C2=A0=C2=A0 unsigned long npages,
> > +			=C2=A0=C2=A0 struct dma_fence *pre_migrate_fence);
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 /**
> > @@ -212,6 +219,8 @@ struct drm_pagemap_devmem_ops {
> > =C2=A0=C2=A0 * @dpagemap: The struct drm_pagemap of the pages this allo=
cation
> > belongs to.
> > =C2=A0=C2=A0 * @size: Size of device memory allocation
> > =C2=A0=C2=A0 * @timeslice_expiration: Timeslice expiration in jiffies
> > + * @pre_migrate_fence: Fence to wait for or pipeline behind before
> > migration starts.
> > + * (May be NULL).
> > =C2=A0=C2=A0 */
> > =C2=A0 struct drm_pagemap_devmem {
> > =C2=A0=C2=A0	struct device *dev;
> > @@ -221,6 +230,7 @@ struct drm_pagemap_devmem {
> > =C2=A0=C2=A0	struct drm_pagemap *dpagemap;
> > =C2=A0=C2=A0	size_t size;
> > =C2=A0=C2=A0	u64 timeslice_expiration;
> > +	struct dma_fence *pre_migrate_fence;
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem
> > *devmem_allocation,
> > @@ -238,7 +248,8 @@ struct drm_pagemap
> > *drm_pagemap_page_to_dpagemap(struct page *page);
> > =C2=A0 void drm_pagemap_devmem_init(struct drm_pagemap_devmem
> > *devmem_allocation,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev, struct mm_s=
truct
> > *mm,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_pagemap_devmem=
_ops
> > *ops,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap *dpagemap, size_t
> > size);
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap *dpagemap, size_t
> > size,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *pre_migrate_fence);
> > =C2=A0=20
> > =C2=A0 int drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0 unsigned long start, unsigned long
> > end,
>=20


