Return-Path: <stable+bounces-139716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A04AA9760
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D5A1888EC7
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A7C1714C6;
	Mon,  5 May 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvKgfAzJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E041F78E0
	for <stable@vger.kernel.org>; Mon,  5 May 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458408; cv=none; b=nhAv/9owlCqHdPHjh+LFoY+I6WGmnHqWAsz+WJFXYmBisfp5IhbJdHd9bRbQMtdWdk9JvuJfUZmx+7V2X/7eRkdowh7gVOgf2Dl9p50WidkmGzqRgbXX15Q9I8LqbDVq3nllQc5jriwVAWM0MXTGHVqjfCuroCBCv2KnnlGdsk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458408; c=relaxed/simple;
	bh=3xmEwxHDFPVeDqJKr5jRcY5w330Zg4ng6C51OYjE5Hc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aq2xZIRwdpuYh1NaUZze+RKy0/adlVmlYigwd1mDMu0BRDWAHB3VIy/zy5rwKD3z7uTi/+FMKJ0Gz3XP0eBFSYU6bRd6hBe1BDdPIrawLAE5c1ESEQKLjeNRG2wVAy8PrzQ2IGPr51TWl8P6+i1yOdHByRIwDZXO0zFDtDm47DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvKgfAzJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746458406; x=1777994406;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3xmEwxHDFPVeDqJKr5jRcY5w330Zg4ng6C51OYjE5Hc=;
  b=ZvKgfAzJCkxwoImSn9lT0St8E7TerR6CptTuQl/vSjtZOKtyJSmyeTTz
   FGzrOrFrpxvVPlf2lOna9z0ssbcnqyJVgSeQWRdmyScjNd1TwqF5Q7Xjd
   cF8SMMBw560mN94v0x5daGXhfWE5juCHPrDs2xclSE+kwiuFWWpTkjMhc
   a/Nyw/zmZ3n5HKFo6K4IxCeq/Yvp+YnVEwjDMQZ3XU3v6K/a2uFEDtwdo
   1gxipPMXxnjVz7e+EXI7eXnBUm2b3ub1X4bNZayi06S8mQZ1xQbKhCpiE
   JBZByylmaUnk6gQnFm1y+kw1ZnlzAjIt9v1EUg5t4jJ6cOZBZQg5g5zJm
   w==;
X-CSE-ConnectionGUID: ZUgRy8BnTYu48ghtzg2PUA==
X-CSE-MsgGUID: PxRR4VBiTuWhh1Bs5tTWjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47974043"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="47974043"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 08:20:05 -0700
X-CSE-ConnectionGUID: m6niOiYHQiG0TQu8aGDp5g==
X-CSE-MsgGUID: Q2oKz1tiRTicM88SczfFxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="139297753"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.246.221]) ([10.245.246.221])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 08:20:04 -0700
Message-ID: <0e60fc015731a15c9cc9b3eac2959c693a52f2d3.camel@linux.intel.com>
Subject: Re: [PATCH v6 02/20] drm/xe: Strict migration policy for atomic SVM
 faults
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>, 
	intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, stable@vger.kernel.org
Date: Mon, 05 May 2025 17:20:00 +0200
In-Reply-To: <20250430121912.337601-3-himal.prasad.ghimiray@intel.com>
References: <20250430121912.337601-1-himal.prasad.ghimiray@intel.com>
	 <20250430121912.337601-3-himal.prasad.ghimiray@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, Himal,

On Wed, 2025-04-30 at 17:48 +0530, Himal Prasad Ghimiray wrote:
> From: Matthew Brost <matthew.brost@intel.com>
>=20
> Mixing GPU and CPU atomics does not work unless a strict migration
> policy of GPU atomics must be device memory. Enforce a policy of must
> be
> in VRAM with a retry loop of 3 attempts, if retry loop fails abort
> fault.
>=20
> Removing always_migrate_to_vram modparam as we now have real
> migration
> policy.
>=20
> v2:
> =C2=A0- Only retry migration on atomics
> =C2=A0- Drop alway migrate modparam
> v3:
> =C2=A0- Only set vram_only on DGFX (Himal)
> =C2=A0- Bail on get_pages failure if vram_only and retry count exceeded
> (Himal)
> =C2=A0- s/vram_only/devmem_only
> =C2=A0- Update xe_svm_range_is_valid to accept devmem_only argument
> v4:
> =C2=A0- Fix logic bug get_pages failure
> v5:
> =C2=A0- Fix commit message (Himal)
> =C2=A0- Mention removing always_migrate_to_vram in commit message (Lucas)
> =C2=A0- Fix xe_svm_range_is_valid to check for devmem pages
> =C2=A0- Bail on devmem_only && !migrate_devmem (Thomas)
> v6:
> =C2=A0- Add READ_ONCE barriers for opportunistic checks (Thomas)
>=20
> Fixes: 2f118c949160 ("drm/xe: Add SVM VRAM migration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Himal Prasad Ghimiray
> <himal.prasad.ghimiray@intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Acked-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> ---
> =C2=A0drivers/gpu/drm/xe/xe_module.c |=C2=A0=C2=A0 3 -
> =C2=A0drivers/gpu/drm/xe/xe_module.h |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/xe/xe_svm.c=C2=A0=C2=A0=C2=A0 | 103 +++++++++++++++=
+++++++++-------
> --
> =C2=A0drivers/gpu/drm/xe/xe_svm.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 --
> =C2=A0include/drm/drm_gpusvm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 40 ++++++++-----
> =C2=A05 files changed, 103 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_module.c
> b/drivers/gpu/drm/xe/xe_module.c
> index 64bf46646544..e4742e27e2cd 100644
> --- a/drivers/gpu/drm/xe/xe_module.c
> +++ b/drivers/gpu/drm/xe/xe_module.c
> @@ -30,9 +30,6 @@ struct xe_modparam xe_modparam =3D {
> =C2=A0module_param_named(svm_notifier_size, xe_modparam.svm_notifier_size=
,
> uint, 0600);
> =C2=A0MODULE_PARM_DESC(svm_notifier_size, "Set the svm notifier size(in
> MiB), must be power of 2");
> =C2=A0
> -module_param_named(always_migrate_to_vram,
> xe_modparam.always_migrate_to_vram, bool, 0444);
> -MODULE_PARM_DESC(always_migrate_to_vram, "Always migrate to VRAM on
> GPU fault");
> -
> =C2=A0module_param_named_unsafe(force_execlist,
> xe_modparam.force_execlist, bool, 0444);
> =C2=A0MODULE_PARM_DESC(force_execlist, "Force Execlist submission");
> =C2=A0
> diff --git a/drivers/gpu/drm/xe/xe_module.h
> b/drivers/gpu/drm/xe/xe_module.h
> index 84339e509c80..5a3bfea8b7b4 100644
> --- a/drivers/gpu/drm/xe/xe_module.h
> +++ b/drivers/gpu/drm/xe/xe_module.h
> @@ -12,7 +12,6 @@
> =C2=A0struct xe_modparam {
> =C2=A0	bool force_execlist;
> =C2=A0	bool probe_display;
> -	bool always_migrate_to_vram;
> =C2=A0	u32 force_vram_bar_size;
> =C2=A0	int guc_log_level;
> =C2=A0	char *guc_firmware_path;
> diff --git a/drivers/gpu/drm/xe/xe_svm.c
> b/drivers/gpu/drm/xe/xe_svm.c
> index 890f6b2f40e9..dcc84e65ca96 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -16,8 +16,12 @@
> =C2=A0
> =C2=A0static bool xe_svm_range_in_vram(struct xe_svm_range *range)
> =C2=A0{
> -	/* Not reliable without notifier lock */
> -	return range->base.flags.has_devmem_pages;
> +	/* Not reliable without notifier lock, opportunistic only */
> +	struct drm_gpusvm_range_flags flags =3D {
> +		.__flags =3D READ_ONCE(range->base.flags.__flags),
> +	};
> +
> +	return flags.has_devmem_pages;
> =C2=A0}
> =C2=A0
> =C2=A0static bool xe_svm_range_has_vram_binding(struct xe_svm_range
> *range)
> @@ -650,9 +654,13 @@ void xe_svm_fini(struct xe_vm *vm)
> =C2=A0}
> =C2=A0
> =C2=A0static bool xe_svm_range_is_valid(struct xe_svm_range *range,
> -				=C2=A0 struct xe_tile *tile)
> +				=C2=A0 struct xe_tile *tile,
> +				=C2=A0 bool devmem_only)
> =C2=A0{
> -	return (range->tile_present & ~range->tile_invalidated) &
> BIT(tile->id);
> +	/* Not reliable without notifier lock, opportunistic only */
> +	return ((READ_ONCE(range->tile_present) &
> +		 ~READ_ONCE(range->tile_invalidated)) & BIT(tile-
> >id)) &&
> +		(!devmem_only || xe_svm_range_in_vram(range));
> =C2=A0}

Hmm, TBH I had something more elaborate in mind:

https://lore.kernel.org/intel-xe/b5569de8cc036e23b976f21a51c4eb5ca104d4bb.c=
amel@linux.intel.com/

(Separate function for lockless access and a lockdep assert for locked
access + similar documentation as the functions I mentioned there + a
"Pairs with" comment.

Thanks,
Thomas



> =C2=A0
> =C2=A0#if IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR)
> @@ -726,6 +734,36 @@ static int xe_svm_alloc_vram(struct xe_vm *vm,
> struct xe_tile *tile,
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> +static bool supports_4K_migration(struct xe_device *xe)
> +{
> +	if (xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range
> *range,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xe_vma *vma)
> +{
> +	struct xe_vm *vm =3D range_to_vm(&range->base);
> +	u64 range_size =3D xe_svm_range_size(range);
> +
> +	if (!range->base.flags.migrate_devmem)
> +		return false;
> +
> +	/* Not reliable without notifier lock, opportunistic only */
> +	if (xe_svm_range_in_vram(range)) {
> +		drm_dbg(&vm->xe->drm, "Range is already in VRAM\n");
> +		return false;
> +	}
> +
> +	if (range_size <=3D SZ_64K && !supports_4K_migration(vm->xe))
> {
> +		drm_dbg(&vm->xe->drm, "Platform doesn't support
> SZ_4K range migration\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> =C2=A0
> =C2=A0/**
> =C2=A0 * xe_svm_handle_pagefault() - SVM handle page fault
> @@ -750,12 +788,15 @@ int xe_svm_handle_pagefault(struct xe_vm *vm,
> struct xe_vma *vma,
> =C2=A0			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR),
> =C2=A0		.check_pages_threshold =3D IS_DGFX(vm->xe) &&
> =C2=A0			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR) ?
> SZ_64K : 0,
> +		.devmem_only =3D atomic && IS_DGFX(vm->xe) &&
> +			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR),
> =C2=A0	};
> =C2=A0	struct xe_svm_range *range;
> =C2=A0	struct drm_gpusvm_range *r;
> =C2=A0	struct drm_exec exec;
> =C2=A0	struct dma_fence *fence;
> =C2=A0	struct xe_tile *tile =3D gt_to_tile(gt);
> +	int migrate_try_count =3D ctx.devmem_only ? 3 : 1;
> =C2=A0	ktime_t end =3D 0;
> =C2=A0	int err;
> =C2=A0
> @@ -776,24 +817,30 @@ int xe_svm_handle_pagefault(struct xe_vm *vm,
> struct xe_vma *vma,
> =C2=A0	if (IS_ERR(r))
> =C2=A0		return PTR_ERR(r);
> =C2=A0
> +	if (ctx.devmem_only && !r->flags.migrate_devmem)
> +		return -EACCES;
> +
> =C2=A0	range =3D to_xe_range(r);
> -	if (xe_svm_range_is_valid(range, tile))
> +	if (xe_svm_range_is_valid(range, tile, ctx.devmem_only))
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	range_debug(range, "PAGE FAULT");
> =C2=A0
> -	/* XXX: Add migration policy, for now migrate range once */
> -	if (!range->skip_migrate && range->base.flags.migrate_devmem
> &&
> -	=C2=A0=C2=A0=C2=A0 xe_svm_range_size(range) >=3D SZ_64K) {
> -		range->skip_migrate =3D true;
> -
> +	if (--migrate_try_count >=3D 0 &&
> +	=C2=A0=C2=A0=C2=A0 xe_svm_range_needs_migrate_to_vram(range, vma)) {
> =C2=A0		err =3D xe_svm_alloc_vram(vm, tile, range, &ctx);
> =C2=A0		if (err) {
> -			drm_dbg(&vm->xe->drm,
> -				"VRAM allocation failed, falling
> back to "
> -				"retrying fault, asid=3D%u,
> errno=3D%pe\n",
> -				vm->usm.asid, ERR_PTR(err));
> -			goto retry;
> +			if (migrate_try_count || !ctx.devmem_only) {
> +				drm_dbg(&vm->xe->drm,
> +					"VRAM allocation failed,
> falling back to retrying fault, asid=3D%u, errno=3D%pe\n",
> +					vm->usm.asid, ERR_PTR(err));
> +				goto retry;
> +			} else {
> +				drm_err(&vm->xe->drm,
> +					"VRAM allocation failed,
> retry count exceeded, asid=3D%u, errno=3D%pe\n",
> +					vm->usm.asid, ERR_PTR(err));
> +				return err;
> +			}
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> @@ -801,15 +848,22 @@ int xe_svm_handle_pagefault(struct xe_vm *vm,
> struct xe_vma *vma,
> =C2=A0	err =3D drm_gpusvm_range_get_pages(&vm->svm.gpusvm, r, &ctx);
> =C2=A0	/* Corner where CPU mappings have changed */
> =C2=A0	if (err =3D=3D -EOPNOTSUPP || err =3D=3D -EFAULT || err =3D=3D -EP=
ERM) {
> -		if (err =3D=3D -EOPNOTSUPP) {
> -			range_debug(range, "PAGE FAULT - EVICT
> PAGES");
> -			drm_gpusvm_range_evict(&vm->svm.gpusvm,
> &range->base);
> +		if (migrate_try_count > 0 || !ctx.devmem_only) {
> +			if (err =3D=3D -EOPNOTSUPP) {
> +				range_debug(range, "PAGE FAULT -
> EVICT PAGES");
> +				drm_gpusvm_range_evict(&vm-
> >svm.gpusvm,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &range-
> >base);
> +			}
> +			drm_dbg(&vm->xe->drm,
> +				"Get pages failed, falling back to
> retrying, asid=3D%u, gpusvm=3D%p, errno=3D%pe\n",
> +				vm->usm.asid, &vm->svm.gpusvm,
> ERR_PTR(err));
> +			range_debug(range, "PAGE FAULT - RETRY
> PAGES");
> +			goto retry;
> +		} else {
> +			drm_err(&vm->xe->drm,
> +				"Get pages failed, retry count
> exceeded, asid=3D%u, gpusvm=3D%p, errno=3D%pe\n",
> +				vm->usm.asid, &vm->svm.gpusvm,
> ERR_PTR(err));
> =C2=A0		}
> -		drm_dbg(&vm->xe->drm,
> -			"Get pages failed, falling back to retrying,
> asid=3D%u, gpusvm=3D%p, errno=3D%pe\n",
> -			vm->usm.asid, &vm->svm.gpusvm,
> ERR_PTR(err));
> -		range_debug(range, "PAGE FAULT - RETRY PAGES");
> -		goto retry;
> =C2=A0	}
> =C2=A0	if (err) {
> =C2=A0		range_debug(range, "PAGE FAULT - FAIL PAGE
> COLLECT");
> @@ -843,9 +897,6 @@ int xe_svm_handle_pagefault(struct xe_vm *vm,
> struct xe_vma *vma,
> =C2=A0	}
> =C2=A0	drm_exec_fini(&exec);
> =C2=A0
> -	if (xe_modparam.always_migrate_to_vram)
> -		range->skip_migrate =3D false;
> -
> =C2=A0	dma_fence_wait(fence, false);
> =C2=A0	dma_fence_put(fence);
> =C2=A0
> diff --git a/drivers/gpu/drm/xe/xe_svm.h
> b/drivers/gpu/drm/xe/xe_svm.h
> index 3d441eb1f7ea..0e1f376a7471 100644
> --- a/drivers/gpu/drm/xe/xe_svm.h
> +++ b/drivers/gpu/drm/xe/xe_svm.h
> @@ -39,11 +39,6 @@ struct xe_svm_range {
> =C2=A0	 * range. Protected by GPU SVM notifier lock.
> =C2=A0	 */
> =C2=A0	u8 tile_invalidated;
> -	/**
> -	 * @skip_migrate: Skip migration to VRAM, protected by GPU
> fault handler
> -	 * locking.
> -	 */
> -	u8 skip_migrate	:1;
> =C2=A0};
> =C2=A0
> =C2=A0/**
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 9fd25fc880a4..653d48dbe1c1 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -185,6 +185,31 @@ struct drm_gpusvm_notifier {
> =C2=A0	} flags;
> =C2=A0};
> =C2=A0
> +/**
> + * struct drm_gpusvm_range_flags - Structure representing a GPU SVM
> range flags
> + *
> + * @migrate_devmem: Flag indicating whether the range can be
> migrated to device memory
> + * @unmapped: Flag indicating if the range has been unmapped
> + * @partial_unmap: Flag indicating if the range has been partially
> unmapped
> + * @has_devmem_pages: Flag indicating if the range has devmem pages
> + * @has_dma_mapping: Flag indicating if the range has a DMA mapping
> + * @__flags: Flags for range in u16 form (used for READ_ONCE)
> + */
> +struct drm_gpusvm_range_flags {
> +	union {
> +		struct {
> +			/* All flags below must be set upon creation
> */
> +			u16 migrate_devmem : 1;
> +			/* All flags below must be set / cleared
> under notifier lock */
> +			u16 unmapped : 1;
> +			u16 partial_unmap : 1;
> +			u16 has_devmem_pages : 1;
> +			u16 has_dma_mapping : 1;
> +		};
> +		u16 __flags;
> +	};
> +};
> +
> =C2=A0/**
> =C2=A0 * struct drm_gpusvm_range - Structure representing a GPU SVM range
> =C2=A0 *
> @@ -198,11 +223,6 @@ struct drm_gpusvm_notifier {
> =C2=A0 * @dpagemap: The struct drm_pagemap of the device pages we're dma-
> mapping.
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Note this is assuming only one drm_pagemap per range
> is allowed.
> =C2=A0 * @flags: Flags for range
> - * @flags.migrate_devmem: Flag indicating whether the range can be
> migrated to device memory
> - * @flags.unmapped: Flag indicating if the range has been unmapped
> - * @flags.partial_unmap: Flag indicating if the range has been
> partially unmapped
> - * @flags.has_devmem_pages: Flag indicating if the range has devmem
> pages
> - * @flags.has_dma_mapping: Flag indicating if the range has a DMA
> mapping
> =C2=A0 *
> =C2=A0 * This structure represents a GPU SVM range used for tracking
> memory ranges
> =C2=A0 * mapped in a DRM device.
> @@ -216,15 +236,7 @@ struct drm_gpusvm_range {
> =C2=A0	unsigned long notifier_seq;
> =C2=A0	struct drm_pagemap_device_addr *dma_addr;
> =C2=A0	struct drm_pagemap *dpagemap;
> -	struct {
> -		/* All flags below must be set upon creation */
> -		u16 migrate_devmem : 1;
> -		/* All flags below must be set / cleared under
> notifier lock */
> -		u16 unmapped : 1;
> -		u16 partial_unmap : 1;
> -		u16 has_devmem_pages : 1;
> -		u16 has_dma_mapping : 1;
> -	} flags;
> +	struct drm_gpusvm_range_flags flags;
> =C2=A0};
> =C2=A0
> =C2=A0/**


