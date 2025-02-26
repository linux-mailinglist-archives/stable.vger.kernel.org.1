Return-Path: <stable+bounces-119720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7971A466E0
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 17:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1260A1694A6
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FF522069A;
	Wed, 26 Feb 2025 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdjW4nbX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C021D59E
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587127; cv=none; b=OAdnxkuOa3kS7lEv8dR0EOdUZJuXQ5eG08i4xQbM4Jl0KdtC8Z8cRsLwCllPbZxHOOg3nGStH+khx1FL6BJ7o0YfR9jnaKdBEnYPEuYv6PkpSvmOuWy9p+LYERcn+AUKJrs50IHmOEbqH5w7Jcj8f06YvK3nbaBX+I9mXQZz5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587127; c=relaxed/simple;
	bh=x9r4c5FsYLoWMIzofasS8UtkjfM6X7MLp8Q96Vgmtjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tgjebDs5vx6olmCev/qNvZ7dB6NnwybzL2nU7D+oxVQxcpSxi/0OhTB+H5ViQonV6uoK8WFM/zCfCCLdHpbzcYyMHOzLX/3kwTKP82i0c6GU5omT0HoD4zG9iWtQtbTerTUhoEYMzILgFgq22IEokgTO8IpFg6a9zc5cTvalyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdjW4nbX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740587125; x=1772123125;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=x9r4c5FsYLoWMIzofasS8UtkjfM6X7MLp8Q96Vgmtjs=;
  b=EdjW4nbX4Exe1rZRle2rqzw20zCK5tNxfLxlyx8z44uJNpUnPq3cNMaG
   0J/vk5G4UBPEpS+Eapv3bACGvqGaZJMITMZlJMSGb+ezU56+1Vcme4OsM
   nSyr/xwDYTSdMewU2LJ6Jfl36vCeWgjNwWgaGVlL7OInCSPbZqCZmj8A1
   YUli/i7nCslv5F9MEc7FRib6gGRViNIDfE8UcG7r/JsuBjn0IBY8abJlC
   UR1lpgvloGRG/R+825vMGdw6DdHzPsQJNgcsM70Uyda2A7ftjv66v9I9C
   V3IIHu51NJuRky5lf3VwzgRLWQmLw8ROENnxNrpSqVIE/Pcr/y5IiW+cC
   Q==;
X-CSE-ConnectionGUID: l3G3b4w9QV+LBD8aoSkEfQ==
X-CSE-MsgGUID: ttjo+uq/Rjq4ehiBhIRJgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41573746"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="41573746"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:25:24 -0800
X-CSE-ConnectionGUID: JgKxwJkASdevKPBdo6FFww==
X-CSE-MsgGUID: gAEJ0pNwTuGuR14C+aTNiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116938135"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.246.81]) ([10.245.246.81])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:25:22 -0800
Message-ID: <29b5372ab2c03f501ba4af31bbf1ce709020961c.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] drm/xe: Add staging tree for VM binds
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Wed, 26 Feb 2025 17:25:20 +0100
In-Reply-To: <20250226153344.58175-5-thomas.hellstrom@linux.intel.com>
References: <20250226153344.58175-1-thomas.hellstrom@linux.intel.com>
	 <20250226153344.58175-5-thomas.hellstrom@linux.intel.com>
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

On Wed, 2025-02-26 at 16:33 +0100, Thomas Hellstr=C3=B6m wrote:
> From: Matthew Brost <matthew.brost@intel.com>
>=20
> Concurrent VM bind staging and zapping of PTEs from a userptr
> notifier
> do not work because the view of PTEs is not stable. VM binds cannot
> acquire the notifier lock during staging, as memory allocations are
> required. To resolve this race condition, use a staging tree for VM
> binds that is committed only under the userptr notifier lock during
> the
> final step of the bind. This ensures a consistent view of the PTEs in
> the userptr notifier.
>=20
> A follow up may only use staging for VM in fault mode as this is the
> only mode in which the above race exists.
>=20
> v3:
> =C2=A0- Drop zap PTE change (Thomas)
> =C2=A0- s/xe_pt_entry/xe_pt_entry_staging (Thomas)
>=20
> Suggested-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single
> job")
> Fixes: a708f6501c69 ("drm/xe: Update PT layer with better error
> handling")
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/xe/xe_pt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 58 +++++=
++++++++++++++++++--------
> --
> =C2=A0drivers/gpu/drm/xe/xe_pt_walk.c |=C2=A0 3 +-
> =C2=A0drivers/gpu/drm/xe/xe_pt_walk.h |=C2=A0 4 +++
> =C2=A03 files changed, 46 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 12a627a23eb4..dc24baa84092 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -28,6 +28,8 @@ struct xe_pt_dir {
> =C2=A0	struct xe_pt pt;
> =C2=A0	/** @children: Array of page-table child nodes */
> =C2=A0	struct xe_ptw *children[XE_PDES];
> +	/** @staging: Array of page-table staging nodes */
> +	struct xe_ptw *staging[XE_PDES];
> =C2=A0};
> =C2=A0
> =C2=A0#if IS_ENABLED(CONFIG_DRM_XE_DEBUG_VM)
> @@ -48,9 +50,10 @@ static struct xe_pt_dir *as_xe_pt_dir(struct xe_pt
> *pt)
> =C2=A0	return container_of(pt, struct xe_pt_dir, pt);
> =C2=A0}
> =C2=A0
> -static struct xe_pt *xe_pt_entry(struct xe_pt_dir *pt_dir, unsigned
> int index)
> +static struct xe_pt *
> +xe_pt_entry_staging(struct xe_pt_dir *pt_dir, unsigned int index)
> =C2=A0{
> -	return container_of(pt_dir->children[index], struct xe_pt,
> base);
> +	return container_of(pt_dir->staging[index], struct xe_pt,
> base);
> =C2=A0}
> =C2=A0
> =C2=A0static u64 __xe_pt_empty_pte(struct xe_tile *tile, struct xe_vm *vm=
,
> @@ -125,6 +128,7 @@ struct xe_pt *xe_pt_create(struct xe_vm *vm,
> struct xe_tile *tile,
> =C2=A0	}
> =C2=A0	pt->bo =3D bo;
> =C2=A0	pt->base.children =3D level ? as_xe_pt_dir(pt)->children :
> NULL;
> +	pt->base.staging =3D level ? as_xe_pt_dir(pt)->staging : NULL;
> =C2=A0
> =C2=A0	if (vm->xef)
> =C2=A0		xe_drm_client_add_bo(vm->xef->client, pt->bo);
> @@ -206,8 +210,8 @@ void xe_pt_destroy(struct xe_pt *pt, u32 flags,
> struct llist_head *deferred)
> =C2=A0		struct xe_pt_dir *pt_dir =3D as_xe_pt_dir(pt);
> =C2=A0
> =C2=A0		for (i =3D 0; i < XE_PDES; i++) {
> -			if (xe_pt_entry(pt_dir, i))
> -				xe_pt_destroy(xe_pt_entry(pt_dir,
> i), flags,
> +			if (xe_pt_entry_staging(pt_dir, i))
> +				xe_pt_destroy(xe_pt_entry_staging(pt
> _dir, i), flags,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deferred);
> =C2=A0		}
> =C2=A0	}
> @@ -376,8 +380,10 @@ xe_pt_insert_entry(struct xe_pt_stage_bind_walk
> *xe_walk, struct xe_pt *parent,
> =C2=A0		/* Continue building a non-connected subtree. */
> =C2=A0		struct iosys_map *map =3D &parent->bo->vmap;
> =C2=A0
> -		if (unlikely(xe_child))
> +		if (unlikely(xe_child)) {
> =C2=A0			parent->base.children[offset] =3D &xe_child-
> >base;
> +			parent->base.staging[offset] =3D &xe_child-
> >base;
> +		}
> =C2=A0
> =C2=A0		xe_pt_write(xe_walk->vm->xe, map, offset, pte);
> =C2=A0		parent->num_live++;
> @@ -614,6 +620,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct
> xe_vma *vma,
> =C2=A0			.ops =3D &xe_pt_stage_bind_ops,
> =C2=A0			.shifts =3D xe_normal_pt_shifts,
> =C2=A0			.max_level =3D XE_PT_HIGHEST_LEVEL,
> +			.staging =3D true,
> =C2=A0		},
> =C2=A0		.vm =3D xe_vma_vm(vma),
> =C2=A0		.tile =3D tile,
> @@ -873,7 +880,7 @@ static void xe_pt_cancel_bind(struct xe_vma *vma,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static void xe_pt_commit_locks_assert(struct xe_vma *vma)
> +static void xe_pt_commit_prepare_locks_assert(struct xe_vma *vma)
> =C2=A0{
> =C2=A0	struct xe_vm *vm =3D xe_vma_vm(vma);
> =C2=A0
> @@ -885,6 +892,16 @@ static void xe_pt_commit_locks_assert(struct
> xe_vma *vma)
> =C2=A0	xe_vm_assert_held(vm);
> =C2=A0}
> =C2=A0
> +static void xe_pt_commit_locks_assert(struct xe_vma *vma)
> +{
> +	struct xe_vm *vm =3D xe_vma_vm(vma);
> +
> +	xe_pt_commit_prepare_locks_assert(vma);
> +
> +	if (xe_vma_is_userptr(vma))
> +		lockdep_assert_held_read(&vm-
> >userptr.notifier_lock);
> +}
> +
> =C2=A0static void xe_pt_commit(struct xe_vma *vma,
> =C2=A0			 struct xe_vm_pgtable_update *entries,
> =C2=A0			 u32 num_entries, struct llist_head
> *deferred)
> @@ -895,13 +912,17 @@ static void xe_pt_commit(struct xe_vma *vma,
> =C2=A0
> =C2=A0	for (i =3D 0; i < num_entries; i++) {
> =C2=A0		struct xe_pt *pt =3D entries[i].pt;
> +		struct xe_pt_dir *pt_dir;
> =C2=A0
> =C2=A0		if (!pt->level)
> =C2=A0			continue;
> =C2=A0
> +		pt_dir =3D as_xe_pt_dir(pt);
> =C2=A0		for (j =3D 0; j < entries[i].qwords; j++) {
> =C2=A0			struct xe_pt *oldpte =3D
> entries[i].pt_entries[j].pt;
> +			int j_ =3D j + entries[i].ofs;
> =C2=A0
> +			pt_dir->children[j_] =3D pt_dir->staging[j_];
> =C2=A0			xe_pt_destroy(oldpte, xe_vma_vm(vma)->flags,
> deferred);
> =C2=A0		}
> =C2=A0	}
> @@ -913,7 +934,7 @@ static void xe_pt_abort_bind(struct xe_vma *vma,
> =C2=A0{
> =C2=A0	int i, j;
> =C2=A0
> -	xe_pt_commit_locks_assert(vma);
> +	xe_pt_commit_prepare_locks_assert(vma);
> =C2=A0
> =C2=A0	for (i =3D num_entries - 1; i >=3D 0; --i) {
> =C2=A0		struct xe_pt *pt =3D entries[i].pt;
> @@ -928,10 +949,10 @@ static void xe_pt_abort_bind(struct xe_vma
> *vma,
> =C2=A0		pt_dir =3D as_xe_pt_dir(pt);
> =C2=A0		for (j =3D 0; j < entries[i].qwords; j++) {
> =C2=A0			u32 j_ =3D j + entries[i].ofs;
> -			struct xe_pt *newpte =3D xe_pt_entry(pt_dir,
> j_);
> +			struct xe_pt *newpte =3D
> xe_pt_entry_staging(pt_dir, j_);
> =C2=A0			struct xe_pt *oldpte =3D
> entries[i].pt_entries[j].pt;
> =C2=A0
> -			pt_dir->children[j_] =3D oldpte ? &oldpte-
> >base : 0;
> +			pt_dir->staging[j_] =3D oldpte ? &oldpte->base
> : 0;
> =C2=A0			xe_pt_destroy(newpte, xe_vma_vm(vma)->flags,
> NULL);
> =C2=A0		}
> =C2=A0	}
> @@ -943,7 +964,7 @@ static void xe_pt_commit_prepare_bind(struct
> xe_vma *vma,
> =C2=A0{
> =C2=A0	u32 i, j;
> =C2=A0
> -	xe_pt_commit_locks_assert(vma);
> +	xe_pt_commit_prepare_locks_assert(vma);
> =C2=A0
> =C2=A0	for (i =3D 0; i < num_entries; i++) {
> =C2=A0		struct xe_pt *pt =3D entries[i].pt;
> @@ -961,10 +982,10 @@ static void xe_pt_commit_prepare_bind(struct
> xe_vma *vma,
> =C2=A0			struct xe_pt *newpte =3D
> entries[i].pt_entries[j].pt;
> =C2=A0			struct xe_pt *oldpte =3D NULL;
> =C2=A0
> -			if (xe_pt_entry(pt_dir, j_))
> -				oldpte =3D xe_pt_entry(pt_dir, j_);
> +			if (xe_pt_entry_staging(pt_dir, j_))
> +				oldpte =3D xe_pt_entry_staging(pt_dir,
> j_);
> =C2=A0
> -			pt_dir->children[j_] =3D &newpte->base;
> +			pt_dir->staging[j_] =3D &newpte->base;
> =C2=A0			entries[i].pt_entries[j].pt =3D oldpte;
> =C2=A0		}
> =C2=A0	}
> @@ -1494,6 +1515,7 @@ static unsigned int xe_pt_stage_unbind(struct
> xe_tile *tile, struct xe_vma *vma,
> =C2=A0			.ops =3D &xe_pt_stage_unbind_ops,
> =C2=A0			.shifts =3D xe_normal_pt_shifts,
> =C2=A0			.max_level =3D XE_PT_HIGHEST_LEVEL,
> +			.staging =3D true,
> =C2=A0		},
> =C2=A0		.tile =3D tile,
> =C2=A0		.modified_start =3D xe_vma_start(vma),
> @@ -1535,7 +1557,7 @@ static void xe_pt_abort_unbind(struct xe_vma
> *vma,
> =C2=A0{
> =C2=A0	int i, j;
> =C2=A0
> -	xe_pt_commit_locks_assert(vma);
> +	xe_pt_commit_prepare_locks_assert(vma);
> =C2=A0
> =C2=A0	for (i =3D num_entries - 1; i >=3D 0; --i) {
> =C2=A0		struct xe_vm_pgtable_update *entry =3D &entries[i];
> @@ -1548,7 +1570,7 @@ static void xe_pt_abort_unbind(struct xe_vma
> *vma,
> =C2=A0			continue;
> =C2=A0
> =C2=A0		for (j =3D entry->ofs; j < entry->ofs + entry->qwords;
> j++)
> -			pt_dir->children[j] =3D
> +			pt_dir->staging[j] =3D
> =C2=A0				entries[i].pt_entries[j - entry-
> >ofs].pt ?
> =C2=A0				&entries[i].pt_entries[j - entry-
> >ofs].pt->base : NULL;
> =C2=A0	}
> @@ -1561,7 +1583,7 @@ xe_pt_commit_prepare_unbind(struct xe_vma *vma,
> =C2=A0{
> =C2=A0	int i, j;
> =C2=A0
> -	xe_pt_commit_locks_assert(vma);
> +	xe_pt_commit_prepare_locks_assert(vma);
> =C2=A0
> =C2=A0	for (i =3D 0; i < num_entries; ++i) {
> =C2=A0		struct xe_vm_pgtable_update *entry =3D &entries[i];
> @@ -1575,8 +1597,8 @@ xe_pt_commit_prepare_unbind(struct xe_vma *vma,
> =C2=A0		pt_dir =3D as_xe_pt_dir(pt);
> =C2=A0		for (j =3D entry->ofs; j < entry->ofs + entry->qwords;
> j++) {
> =C2=A0			entry->pt_entries[j - entry->ofs].pt =3D
> -				xe_pt_entry(pt_dir, j);
> -			pt_dir->children[j] =3D NULL;
> +				xe_pt_entry_staging(pt_dir, j);
> +			pt_dir->staging[j] =3D NULL;
> =C2=A0		}
> =C2=A0	}
> =C2=A0}
> diff --git a/drivers/gpu/drm/xe/xe_pt_walk.c
> b/drivers/gpu/drm/xe/xe_pt_walk.c
> index b8b3d2aea492..be602a763ff3 100644
> --- a/drivers/gpu/drm/xe/xe_pt_walk.c
> +++ b/drivers/gpu/drm/xe/xe_pt_walk.c
> @@ -74,7 +74,8 @@ int xe_pt_walk_range(struct xe_ptw *parent,
> unsigned int level,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 u64 addr, u64 end, struct xe_pt_walk *wa=
lk)
> =C2=A0{
> =C2=A0	pgoff_t offset =3D xe_pt_offset(addr, level, walk);
> -	struct xe_ptw **entries =3D parent->children ? parent-
> >children : NULL;
> +	struct xe_ptw **entries =3D walk->staging ? (parent->staging
> ?: NULL) :
> +		(parent->children ?: NULL);
> =C2=A0	const struct xe_pt_walk_ops *ops =3D walk->ops;
> =C2=A0	enum page_walk_action action;
> =C2=A0	struct xe_ptw *child;
> diff --git a/drivers/gpu/drm/xe/xe_pt_walk.h
> b/drivers/gpu/drm/xe/xe_pt_walk.h
> index 5ecc4d2f0f65..5c02c244f7de 100644
> --- a/drivers/gpu/drm/xe/xe_pt_walk.h
> +++ b/drivers/gpu/drm/xe/xe_pt_walk.h
> @@ -11,12 +11,14 @@
> =C2=A0/**
> =C2=A0 * struct xe_ptw - base class for driver pagetable subclassing.
> =C2=A0 * @children: Pointer to an array of children if any.
> + * @staging: Pointer to an array of staging if any.
> =C2=A0 *
> =C2=A0 * Drivers could subclass this, and if it's a page-directory,
> typically
> =C2=A0 * embed an array of xe_ptw pointers.
> =C2=A0 */
> =C2=A0struct xe_ptw {
> =C2=A0	struct xe_ptw **children;
> +	struct xe_ptw **staging;
> =C2=A0};
> =C2=A0
> =C2=A0/**
> @@ -41,6 +43,8 @@ struct xe_pt_walk {
> =C2=A0	 * as shared pagetables.
> =C2=A0	 */
> =C2=A0	bool shared_pt_mode;
> +	/** @staging: Walk staging PT structure */
> +	bool staging;
> =C2=A0};
> =C2=A0
> =C2=A0/**


