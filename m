Return-Path: <stable+bounces-28579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F70188626E
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 22:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5C51C226E6
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 21:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7955A135A5F;
	Thu, 21 Mar 2024 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pe4EAeFs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC51353EC
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055775; cv=none; b=ZKJ76SPhlVZYlA+qnR/oYkAdNq3RuFeQa0GBKx0wpXabn3yOL6w6V7KD7jT7QfdcPlHLLuaqnQpzlFmfWOVWSlcDiGWCmSJbJpvMZPy+V+diwGopucTtkIiQAQNfDkDoEtAKpw00D0MVgNjsMqBBGXyoxhyRTyjeGoUxIWiigG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055775; c=relaxed/simple;
	bh=w9/3jNHeCzMYxvMU5Dsvfdl94dM7OFDuedB3s6bP9NU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CjT8Wxh+zJLlUlsfQwdSX7gsmo8W2jCutPsg+Z4LiV/b5dDES+xA/lu49djodNiCC5+2r0kaaNOCh+xOW8UhhWComudoHkTfFmtmZqGtylSmbpeLNUY1r1Ipkw6ovFTEfpZ1BZGykYhvjTAxJDR+sXqozuMAllZ1Tr3+AXKNoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pe4EAeFs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711055774; x=1742591774;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=w9/3jNHeCzMYxvMU5Dsvfdl94dM7OFDuedB3s6bP9NU=;
  b=Pe4EAeFs6JQeFWUMAmecD+u0OD+I4SnS9rrQNZlXji85r3Cld70JWw89
   rp3hZbK1+XgCeq0jjdNLDH48OX4auWdjcJH7aV6WQLOazFntDRHqwBFG4
   V3OdZzGG7002oXOYY2M4jEytbyYg9ElBmBJc78iry3irHNWlTvOKb2KeX
   ncMAjESD3EwtFHsYQydCOPbnh0W6mM7PjokqC202A+/0xZSFAfcTsn8Zi
   NlQQlDN52CfmWq1SP5Fgio5EHdHDkrj+BAECidUvhh76D+quUYQVyympF
   dZ4B6/wekOVkXhb/TV+VNTshMXHCvWIIRY0RHsw7SM1a96KDViAw8HKFN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16814671"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="16814671"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="19223170"
Received: from sinampud-mobl.amr.corp.intel.com (HELO [10.249.254.176]) ([10.249.254.176])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:16:11 -0700
Message-ID: <a20fb42c340caea1b22ee0a7784e5a9ffb3c08af.camel@linux.intel.com>
Subject: Re: [PATCH 2/7] drm/xe: Rework rebinding
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	stable@vger.kernel.org
Date: Thu, 21 Mar 2024 22:16:09 +0100
In-Reply-To: <ZfyHMmxStlECaGs3@DUT025-TGLU.fm.intel.com>
References: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
	 <20240321113720.120865-4-thomas.hellstrom@linux.intel.com>
	 <ZfyHMmxStlECaGs3@DUT025-TGLU.fm.intel.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-21 at 19:14 +0000, Matthew Brost wrote:
> On Thu, Mar 21, 2024 at 12:37:12PM +0100, Thomas Hellstr=C3=B6m wrote:
> > Instead of handling the vm's rebind fence separately,
> > which is error prone if they are not strictly ordered,
> > attach rebind fences as kernel fences to the vm's resv.
> >=20
>=20
> See comment from previous, do not like updates to __xe_pt_bind_vma
> but I
> guess I can live with it. Otherwise LGTM.

Thanks, yeah same reason there, unfortunately.

/Thomas


>=20
> With that:
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>=20
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > GPUs")
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.8+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_exec.c=C2=A0=C2=A0=C2=A0=C2=A0 | 31 +++----=
---------------------
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_pt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
> > =C2=A0drivers/gpu/drm/xe/xe_vm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
27 +++++++++------------------
> > =C2=A0drivers/gpu/drm/xe/xe_vm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
> > =C2=A0drivers/gpu/drm/xe/xe_vm_types.h |=C2=A0 3 ---
> > =C2=A05 files changed, 14 insertions(+), 51 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_exec.c
> > b/drivers/gpu/drm/xe/xe_exec.c
> > index 7692ebfe7d47..759497d4a102 100644
> > --- a/drivers/gpu/drm/xe/xe_exec.c
> > +++ b/drivers/gpu/drm/xe/xe_exec.c
> > @@ -152,7 +152,6 @@ int xe_exec_ioctl(struct drm_device *dev, void
> > *data, struct drm_file *file)
> > =C2=A0	struct drm_exec *exec =3D &vm_exec.exec;
> > =C2=A0	u32 i, num_syncs =3D 0, num_ufence =3D 0;
> > =C2=A0	struct xe_sched_job *job;
> > -	struct dma_fence *rebind_fence;
> > =C2=A0	struct xe_vm *vm;
> > =C2=A0	bool write_locked, skip_retry =3D false;
> > =C2=A0	ktime_t end =3D 0;
> > @@ -294,35 +293,11 @@ int xe_exec_ioctl(struct drm_device *dev,
> > void *data, struct drm_file *file)
> > =C2=A0	 * Rebind any invalidated userptr or evicted BOs in the
> > VM, non-compute
> > =C2=A0	 * VM mode only.
> > =C2=A0	 */
> > -	rebind_fence =3D xe_vm_rebind(vm, false);
> > -	if (IS_ERR(rebind_fence)) {
> > -		err =3D PTR_ERR(rebind_fence);
> > +	err =3D xe_vm_rebind(vm, false);
> > +	if (err)
> > =C2=A0		goto err_put_job;
> > -	}
> > -
> > -	/*
> > -	 * We store the rebind_fence in the VM so subsequent execs
> > don't get
> > -	 * scheduled before the rebinds of userptrs / evicted BOs
> > is complete.
> > -	 */
> > -	if (rebind_fence) {
> > -		dma_fence_put(vm->rebind_fence);
> > -		vm->rebind_fence =3D rebind_fence;
> > -	}
> > -	if (vm->rebind_fence) {
> > -		if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 &vm->rebind_fence->flags)) {
> > -			dma_fence_put(vm->rebind_fence);
> > -			vm->rebind_fence =3D NULL;
> > -		} else {
> > -			dma_fence_get(vm->rebind_fence);
> > -			err =3D drm_sched_job_add_dependency(&job-
> > >drm,
> > -							=C2=A0=C2=A0 vm-
> > >rebind_fence);
> > -			if (err)
> > -				goto err_put_job;
> > -		}
> > -	}
> > =C2=A0
> > -	/* Wait behind munmap style rebinds */
> > +	/* Wait behind rebinds */
> > =C2=A0	if (!xe_vm_in_lr_mode(vm)) {
> > =C2=A0		err =3D drm_sched_job_add_resv_dependencies(&job-
> > >drm,
> > =C2=A0							=C2=A0
> > xe_vm_resv(vm),
> > diff --git a/drivers/gpu/drm/xe/xe_pt.c
> > b/drivers/gpu/drm/xe/xe_pt.c
> > index 21bc0d13fccf..0484ed5b495f 100644
> > --- a/drivers/gpu/drm/xe/xe_pt.c
> > +++ b/drivers/gpu/drm/xe/xe_pt.c
> > @@ -1298,7 +1298,7 @@ __xe_pt_bind_vma(struct xe_tile *tile, struct
> > xe_vma *vma, struct xe_exec_queue
> > =C2=A0		}
> > =C2=A0
> > =C2=A0		/* add shared fence now for pagetable delayed
> > destroy */
> > -		dma_resv_add_fence(xe_vm_resv(vm), fence, !rebind
> > &&
> > +		dma_resv_add_fence(xe_vm_resv(vm), fence, rebind
> > ||
> > =C2=A0				=C2=A0=C2=A0 last_munmap_rebind ?
> > =C2=A0				=C2=A0=C2=A0 DMA_RESV_USAGE_KERNEL :
> > =C2=A0				=C2=A0=C2=A0 DMA_RESV_USAGE_BOOKKEEP);
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > b/drivers/gpu/drm/xe/xe_vm.c
> > index 80d43d75b1da..35fba6e3f889 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -522,7 +522,6 @@ static void preempt_rebind_work_func(struct
> > work_struct *w)
> > =C2=A0{
> > =C2=A0	struct xe_vm *vm =3D container_of(w, struct xe_vm,
> > preempt.rebind_work);
> > =C2=A0	struct drm_exec exec;
> > -	struct dma_fence *rebind_fence;
> > =C2=A0	unsigned int fence_count =3D 0;
> > =C2=A0	LIST_HEAD(preempt_fences);
> > =C2=A0	ktime_t end =3D 0;
> > @@ -568,18 +567,11 @@ static void preempt_rebind_work_func(struct
> > work_struct *w)
> > =C2=A0	if (err)
> > =C2=A0		goto out_unlock;
> > =C2=A0
> > -	rebind_fence =3D xe_vm_rebind(vm, true);
> > -	if (IS_ERR(rebind_fence)) {
> > -		err =3D PTR_ERR(rebind_fence);
> > +	err =3D xe_vm_rebind(vm, true);
> > +	if (err)
> > =C2=A0		goto out_unlock;
> > -	}
> > -
> > -	if (rebind_fence) {
> > -		dma_fence_wait(rebind_fence, false);
> > -		dma_fence_put(rebind_fence);
> > -	}
> > =C2=A0
> > -	/* Wait on munmap style VM unbinds */
> > +	/* Wait on rebinds and munmap style VM unbinds */
> > =C2=A0	wait =3D dma_resv_wait_timeout(xe_vm_resv(vm),
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 DMA_RESV_USAGE_KERNEL,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 false, MAX_SCHEDULE_TIMEOUT);
> > @@ -773,14 +765,14 @@ xe_vm_bind_vma(struct xe_vma *vma, struct
> > xe_exec_queue *q,
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xe_sync_entry *syncs=
, u32 num_syncs,
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool first_op, bool last_op=
);
> > =C2=A0
> > -struct dma_fence *xe_vm_rebind(struct xe_vm *vm, bool
> > rebind_worker)
> > +int xe_vm_rebind(struct xe_vm *vm, bool rebind_worker)
> > =C2=A0{
> > -	struct dma_fence *fence =3D NULL;
> > +	struct dma_fence *fence;
> > =C2=A0	struct xe_vma *vma, *next;
> > =C2=A0
> > =C2=A0	lockdep_assert_held(&vm->lock);
> > =C2=A0	if (xe_vm_in_lr_mode(vm) && !rebind_worker)
> > -		return NULL;
> > +		return 0;
> > =C2=A0
> > =C2=A0	xe_vm_assert_held(vm);
> > =C2=A0	list_for_each_entry_safe(vma, next, &vm->rebind_list,
> > @@ -788,17 +780,17 @@ struct dma_fence *xe_vm_rebind(struct xe_vm
> > *vm, bool rebind_worker)
> > =C2=A0		xe_assert(vm->xe, vma->tile_present);
> > =C2=A0
> > =C2=A0		list_del_init(&vma->combined_links.rebind);
> > -		dma_fence_put(fence);
> > =C2=A0		if (rebind_worker)
> > =C2=A0			trace_xe_vma_rebind_worker(vma);
> > =C2=A0		else
> > =C2=A0			trace_xe_vma_rebind_exec(vma);
> > =C2=A0		fence =3D xe_vm_bind_vma(vma, NULL, NULL, 0, false,
> > false);
> > =C2=A0		if (IS_ERR(fence))
> > -			return fence;
> > +			return PTR_ERR(fence);
> > +		dma_fence_put(fence);
> > =C2=A0	}
> > =C2=A0
> > -	return fence;
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void xe_vma_free(struct xe_vma *vma)
> > @@ -1588,7 +1580,6 @@ static void vm_destroy_work_func(struct
> > work_struct *w)
> > =C2=A0		XE_WARN_ON(vm->pt_root[id]);
> > =C2=A0
> > =C2=A0	trace_xe_vm_free(vm);
> > -	dma_fence_put(vm->rebind_fence);
> > =C2=A0	kfree(vm);
> > =C2=A0}
> > =C2=A0
> > diff --git a/drivers/gpu/drm/xe/xe_vm.h
> > b/drivers/gpu/drm/xe/xe_vm.h
> > index 6df1f1c7f85d..4853354336f2 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.h
> > +++ b/drivers/gpu/drm/xe/xe_vm.h
> > @@ -207,7 +207,7 @@ int __xe_vm_userptr_needs_repin(struct xe_vm
> > *vm);
> > =C2=A0
> > =C2=A0int xe_vm_userptr_check_repin(struct xe_vm *vm);
> > =C2=A0
> > -struct dma_fence *xe_vm_rebind(struct xe_vm *vm, bool
> > rebind_worker);
> > +int xe_vm_rebind(struct xe_vm *vm, bool rebind_worker);
> > =C2=A0
> > =C2=A0int xe_vm_invalidate_vma(struct xe_vma *vma);
> > =C2=A0
> > diff --git a/drivers/gpu/drm/xe/xe_vm_types.h
> > b/drivers/gpu/drm/xe/xe_vm_types.h
> > index 5747f136d24d..badf3945083d 100644
> > --- a/drivers/gpu/drm/xe/xe_vm_types.h
> > +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> > @@ -177,9 +177,6 @@ struct xe_vm {
> > =C2=A0	 */
> > =C2=A0	struct list_head rebind_list;
> > =C2=A0
> > -	/** @rebind_fence: rebind fence from execbuf */
> > -	struct dma_fence *rebind_fence;
> > -
> > =C2=A0	/**
> > =C2=A0	 * @destroy_work: worker to destroy VM, needed as a
> > dma_fence signaling
> > =C2=A0	 * from an irq context can be last put and the destroy
> > needs to be able
> > --=20
> > 2.44.0
> >=20


