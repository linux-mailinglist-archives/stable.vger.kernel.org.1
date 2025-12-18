Return-Path: <stable+bounces-203026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B19CCD5CF
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 20:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CF093026AB2
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D02D0618;
	Thu, 18 Dec 2025 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5xQrWrK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59E191F98
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766085513; cv=none; b=CEUrPCZYXhLov+v4ZkwGJ/qX1Zs4mdqdZVZMUxmEuqjyClSIY58k2JTQxyxforCyxDIE7qnwxGdIP9qrigIJPM/E9unAx/+aw+cjXqgHfnObcscZND1JkVWPr2GPzF94J4V4lt2J6ra9z/HeMJMom6od+G1jOXjd3OnIsXnqEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766085513; c=relaxed/simple;
	bh=QAGzJAyIPlihyB3mtMWZdIgnTkEprYFa1So1zhdCXvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFhIIejB4OmF2U/mwV7d79zFLgUs1JCynpsbpF4libGl1B6i3Yi0Da1JWYzM/5fn5HQ//AHG3106psCbwnFlRiY94tNYPD2XZlc+Sjxbc4Qj+sNSP7nzIFTw/TLNMPcbtRg6mPV5J+1Y0N/BOKBS9CAm1Fq2P1N8PSB1p1XLttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5xQrWrK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766085510; x=1797621510;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QAGzJAyIPlihyB3mtMWZdIgnTkEprYFa1So1zhdCXvY=;
  b=C5xQrWrKc2RMDS4b7DWUUguW5LGYHI4DY7wuUvyL1OVAK4WcGAXej98k
   ssmCfPNNvAWA6fxI+99TeheyKSpU/WZ1+EgBLdeszCaB4AcReHBuhj6bv
   rGYhXHpIhoLJMV1K0v2r6RS7zqcy7pD0/3Wy8YH57phUme6EjekBlRBWt
   /CuUfJQauJpnp8XLJLB6S97S9Fn+6uBDqB9yUXCLVuZ41F/74/fXTTZrB
   lSqFwHLwd3MYeFLgu8VaPP4qbEL1L6qYznSGR0l6baQNvuOCkTUF7ck8S
   77JqmoMrW9/ydd7ssW1CjVslq0dN0NvFRjwCN+xCBciqjIAgXaU0LvPAj
   w==;
X-CSE-ConnectionGUID: nVoJiusWQmy3h50pOCtdeQ==
X-CSE-MsgGUID: zTOocDjYQgql/cIVPPRvtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="55627897"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="55627897"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 11:18:29 -0800
X-CSE-ConnectionGUID: ThV+FfWDRlul+/IJcYxA2w==
X-CSE-MsgGUID: miONQjiOSMuLfqTbJs/b1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="222076812"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO [10.245.244.93]) ([10.245.244.93])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 11:18:26 -0800
Message-ID: <8ed95ebd4525bbedbf62aa2ca26bcaf8ae1e4526.camel@linux.intel.com>
Subject: Re: [PATCH v5 03/24] drm/pagemap, drm/xe: Ensure that the devmem
 allocation is idle before use
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, himal.prasad.ghimiray@intel.com, 
	apopple@nvidia.com, airlied@gmail.com, Simona Vetter
 <simona.vetter@ffwll.ch>, 	felix.kuehling@amd.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, dakr@kernel.org,
 "Mrozek, Michal"	 <michal.mrozek@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>
Date: Thu, 18 Dec 2025 20:18:24 +0100
In-Reply-To: <aURI/tEMA6GInnCh@lstrano-desk.jf.intel.com>
References: <20251218162101.605379-1-thomas.hellstrom@linux.intel.com>
	 <20251218162101.605379-4-thomas.hellstrom@linux.intel.com>
	 <aURI/tEMA6GInnCh@lstrano-desk.jf.intel.com>
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

On Thu, 2025-12-18 at 10:33 -0800, Matthew Brost wrote:
> On Thu, Dec 18, 2025 at 05:20:40PM +0100, Thomas Hellstr=C3=B6m wrote:
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
> > =C2=A0 pre_migrate_fence.
> > - Update the logic used for determining when to warn for the
> > =C2=A0 pre_migrate_fence since the scheduler fences apparently
> > =C2=A0 can signal out-of-order.
> > v5:
> > - Fix a UAF (CI)
> > - Remove references to source P2P migration (Himal)
> > - Put the pre_migrate_fence after migration.
> >=20
> > Fixes: c5b3eb5a906c ("drm/xe: Add GPUSVM device memory copy vfunc
> > functions")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.15+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/drm_pagemap.c | 17 ++++++---
> > =C2=A0drivers/gpu/drm/xe/xe_svm.c=C2=A0=C2=A0 | 65 ++++++++++++++++++++=
++++++++++-
> > ----
> > =C2=A0include/drm/drm_pagemap.h=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++--
> > =C2=A03 files changed, 83 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_pagemap.c
> > b/drivers/gpu/drm/drm_pagemap.c
> > index 4cf8f54e5a27..ac3832f85190 100644
> > --- a/drivers/gpu/drm/drm_pagemap.c
> > +++ b/drivers/gpu/drm/drm_pagemap.c
> > @@ -3,6 +3,7 @@
> > =C2=A0 * Copyright =C2=A9 2024-2025 Intel Corporation
> > =C2=A0 */
> > =C2=A0
> > +#include <linux/dma-fence.h>
> > =C2=A0#include <linux/dma-mapping.h>
> > =C2=A0#include <linux/migrate.h>
> > =C2=A0#include <linux/pagemap.h>
> > @@ -408,10 +409,14 @@ int drm_pagemap_migrate_to_devmem(struct
> > drm_pagemap_devmem *devmem_allocation,
> > =C2=A0		drm_pagemap_get_devmem_page(page, zdd);
> > =C2=A0	}
> > =C2=A0
> > -	err =3D ops->copy_to_devmem(pages, pagemap_addr, npages);
> > +	err =3D ops->copy_to_devmem(pages, pagemap_addr, npages,
> > +				=C2=A0 devmem_allocation-
> > >pre_migrate_fence);
> > =C2=A0	if (err)
> > =C2=A0		goto err_finalize;
> > =C2=A0
> > +	dma_fence_put(devmem_allocation->pre_migrate_fence);
> > +	devmem_allocation->pre_migrate_fence =3D NULL;
> > +
> > =C2=A0	/* Upon success bind devmem allocation to range and zdd */
> > =C2=A0	devmem_allocation->timeslice_expiration =3D get_jiffies_64()
> > +
> > =C2=A0		msecs_to_jiffies(timeslice_ms);
> > @@ -596,7 +601,7 @@ int drm_pagemap_evict_to_ram(struct
> > drm_pagemap_devmem *devmem_allocation)
> > =C2=A0	for (i =3D 0; i < npages; ++i)
> > =C2=A0		pages[i] =3D migrate_pfn_to_page(src[i]);
> > =C2=A0
> > -	err =3D ops->copy_to_ram(pages, pagemap_addr, npages);
> > +	err =3D ops->copy_to_ram(pages, pagemap_addr, npages, NULL);
> > =C2=A0	if (err)
> > =C2=A0		goto err_finalize;
> > =C2=A0
> > @@ -719,7 +724,7 @@ static int __drm_pagemap_migrate_to_ram(struct
> > vm_area_struct *vas,
> > =C2=A0	for (i =3D 0; i < npages; ++i)
> > =C2=A0		pages[i] =3D migrate_pfn_to_page(migrate.src[i]);
> > =C2=A0
> > -	err =3D ops->copy_to_ram(pages, pagemap_addr, npages);
> > +	err =3D ops->copy_to_ram(pages, pagemap_addr, npages, NULL);
> > =C2=A0	if (err)
> > =C2=A0		goto err_finalize;
> > =C2=A0
> > @@ -800,11 +805,14 @@
> > EXPORT_SYMBOL_GPL(drm_pagemap_pagemap_ops_get);
> > =C2=A0 * @ops: Pointer to the operations structure for GPU SVM device
> > memory
> > =C2=A0 * @dpagemap: The struct drm_pagemap we're allocating from.
> > =C2=A0 * @size: Size of device memory allocation
> > + * @pre_migrate_fence: Fence to wait for or pipeline behind before
> > migration starts.
> > + * (May be NULL).
> > =C2=A0 */
> > =C2=A0void drm_pagemap_devmem_init(struct drm_pagemap_devmem
> > *devmem_allocation,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev, struct mm_struct
> > *mm,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_pagemap_devmem_ops
> > *ops,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap *dpagemap, size_t
> > size)
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap *dpagemap, size_t
> > size,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *pre_migrate_fence)
> > =C2=A0{
> > =C2=A0	init_completion(&devmem_allocation->detached);
> > =C2=A0	devmem_allocation->dev =3D dev;
> > @@ -812,6 +820,7 @@ void drm_pagemap_devmem_init(struct
> > drm_pagemap_devmem *devmem_allocation,
> > =C2=A0	devmem_allocation->ops =3D ops;
> > =C2=A0	devmem_allocation->dpagemap =3D dpagemap;
> > =C2=A0	devmem_allocation->size =3D size;
> > +	devmem_allocation->pre_migrate_fence =3D pre_migrate_fence;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(drm_pagemap_devmem_init);
> > =C2=A0
> > diff --git a/drivers/gpu/drm/xe/xe_svm.c
> > b/drivers/gpu/drm/xe/xe_svm.c
> > index bab8e6cbe53d..b806a1fce188 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.c
> > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > @@ -472,11 +472,12 @@ static void xe_svm_copy_us_stats_incr(struct
> > xe_gt *gt,
> > =C2=A0
> > =C2=A0static int xe_svm_copy(struct page **pages,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_addr *p=
agemap_addr,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages, const enu=
m
> > xe_svm_copy_dir dir)
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages, const enu=
m
> > xe_svm_copy_dir dir,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *pre_migrate_f=
ence)
> > =C2=A0{
> > =C2=A0	struct xe_vram_region *vr =3D NULL;
> > =C2=A0	struct xe_gt *gt =3D NULL;
> > -	struct xe_device *xe;
> > +	struct xe_device *xe =3D NULL;
> > =C2=A0	struct dma_fence *fence =3D NULL;
> > =C2=A0	unsigned long i;
> > =C2=A0#define XE_VRAM_ADDR_INVALID	~0x0ull
> > @@ -485,6 +486,16 @@ static int xe_svm_copy(struct page **pages,
> > =C2=A0	bool sram =3D dir =3D=3D XE_SVM_COPY_TO_SRAM;
> > =C2=A0	ktime_t start =3D xe_gt_stats_ktime_get();
> > =C2=A0
> > +	if (pre_migrate_fence &&
> > dma_fence_is_container(pre_migrate_fence)) {
> > +		/*
> > +		 * This would typically be a composite fence
> > operation on the destination memory.
> > +		 * Ensure that the other GPU operation on the
> > destination is complete.
> > +		 */
> > +		err =3D dma_fence_wait(pre_migrate_fence, true);
> > +		if (err)
> > +			return err;
> > +	}
> > +
>=20
> I'm not fully convienced this code works. Consider the case where we
> allocate memory a device A and we copying from device B. In this case
> device A issues the clear but device B issues the copy. The
> pre_migrate_fence is not going be a container and I believe our
> ordering
> breaks.

So the logic to handle that case was moved to the patch that enables
source migration, as per Himal's review comment. So consider this patch
only for destination migration where the devmem allocation is allocated
on the same gpu that migrates.

>=20
> Would it be simplier to pass in the pre_migrate_fence fence a
> dependency
> to the first copy job issued, then set it to NULL. The drm scheduler
> is
> smart enough to squash the input fence into a NOP if a copy / clear
> are
> from the same devices queues.

I intended to do that as a follow-up if needed but since this is a fix
that fixes an existing problem I wanted it to be lightweight. But let
me take a quick look at that and probably resend only that patch.

/Thomas



