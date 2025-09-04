Return-Path: <stable+bounces-177759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13658B440A6
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D1A1BC35EA
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBFF233152;
	Thu,  4 Sep 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bn+3Yjgm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A121D018
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999847; cv=none; b=FhzR6UuTEQuxAokoFIBhnjtS3I+woesnA9fzDaaTlq+sIXytPo59iU7R5BS2W5dgSEERsmBW8pLZlAJLtaYGZwYcBuzVMU/YavLMWTj34rUBJbxipZF6PlzbwnaasuOWhzXm1/EoGSbeBF3yekKLrhx2H6D8iyNj9rdgut5wGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999847; c=relaxed/simple;
	bh=mQ2cTSQzAcOLZtYBStV3V+GR2QNX0BiDGddNoNO6fUA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MfNsJ7+orSR76OCwJ5XmSYHGMrggA38JMCkQwS5xO7qtvmrvkqBYPqX4fkTgBathgA5LkzQRn/V/FRR3H2jeKiC3DGQvvYAbI1NWiOI/xvzIOWRKeuXdTkQFYiPmTHxTIGb47cqfR/XpLszh/9Nvj2kxW8VYMMXWafXlNliut78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bn+3Yjgm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756999845; x=1788535845;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mQ2cTSQzAcOLZtYBStV3V+GR2QNX0BiDGddNoNO6fUA=;
  b=Bn+3Yjgm0QDZgq12wV4FD4S5mRYDKWS3iYIOYQQnXM43D9EZ+uLuqWxI
   M9MIg3nxZbUacdaMmUV9N1SXte6xIVNFyB6fwZJjsZj4lnxj7qYnYvXbY
   9+xUHIq8ZjwT8fSBVTYzB1ECRu351RXy7JMGZCjfzhM9074gQvYaHQu9R
   bTjSzKDIx59ntF85qlIp+QOb1pF5pxdJg9Yl08ol3pIOm2Oo85M9zXgVj
   TaqEGhYON2cL7SwkHC4HROZNb2s2Ux0Uf98dv2+6+gvc1slw/hq9LFtdl
   D7g5g+3/SotFHX6yDX6XlGK+bVV7c5UpdKgyQhmOby7XoTH91PHXGTbuB
   A==;
X-CSE-ConnectionGUID: 9VT55TfGTOOqH6jaX0THlg==
X-CSE-MsgGUID: WVR6rv0aTyi9gOgehjbRiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59412010"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="59412010"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 08:30:44 -0700
X-CSE-ConnectionGUID: OZoAHZ/nR7qW87+69sBviQ==
X-CSE-MsgGUID: YlrA10qiSJiSuKd2Gxmt0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="176263322"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.98]) ([10.245.244.98])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 08:30:42 -0700
Message-ID: <053d1e397ffc03736f4a1012216f9cdc0bb53f4e.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] drm/xe: Block exec and rebind worker while
 evicting for suspend / hibernate
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org, Matthew
 Brost <matthew.brost@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>
Date: Thu, 04 Sep 2025 17:30:36 +0200
In-Reply-To: <723f3c49-45e5-494e-b06a-977f37e5dfb9@intel.com>
References: <20250904130614.3212-1-thomas.hellstrom@linux.intel.com>
	 <20250904130614.3212-4-thomas.hellstrom@linux.intel.com>
	 <723f3c49-45e5-494e-b06a-977f37e5dfb9@intel.com>
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

On Thu, 2025-09-04 at 16:22 +0100, Matthew Auld wrote:
> On 04/09/2025 14:06, Thomas Hellstr=C3=B6m wrote:
> > When the xe pm_notifier evicts for suspend / hibernate, there might
> > be
> > racing tasks trying to re-validate again. This can lead to suspend
> > taking
> > excessive time or get stuck in a live-lock. This behaviour becomes
> > much worse with the fix that actually makes re-validation bring
> > back
> > bos to VRAM rather than letting them remain in TT.
> >=20
> > Prevent that by having exec and the rebind worker waiting for a
> > completion
> > that is set to block by the pm_notifier before suspend and is
> > signaled
> > by the pm_notifier after resume / wakeup.
> >=20
> > It's probably still possible to craft malicious applications that
> > block
> > suspending. More work is pending to fix that.
> >=20
> > v3:
> > - Avoid wait_for_completion() in the kernel worker since it could
> > =C2=A0=C2=A0 potentially cause work item flushes from freezable process=
es to
> > =C2=A0=C2=A0 wait forever. Instead terminate the rebind workers if need=
ed and
> > =C2=A0=C2=A0 re-launch at resume. (Matt Auld)
> >=20
> > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4288
> > Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.16+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0 drivers/gpu/drm/xe/xe_device_types.h |=C2=A0 6 ++++
> > =C2=A0 drivers/gpu/drm/xe/xe_exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 9 ++++++
> > =C2=A0 drivers/gpu/drm/xe/xe_pm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++
> > =C2=A0 drivers/gpu/drm/xe/xe_vm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 46
> > +++++++++++++++++++++++++++-
> > =C2=A0 drivers/gpu/drm/xe/xe_vm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0 drivers/gpu/drm/xe/xe_vm_types.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 5 +++
> > =C2=A0 6 files changed, 87 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_device_types.h
> > b/drivers/gpu/drm/xe/xe_device_types.h
> > index 092004d14db2..1e780f8a2a8c 100644
> > --- a/drivers/gpu/drm/xe/xe_device_types.h
> > +++ b/drivers/gpu/drm/xe/xe_device_types.h
> > @@ -507,6 +507,12 @@ struct xe_device {
> > =C2=A0=20
> > =C2=A0=C2=A0	/** @pm_notifier: Our PM notifier to perform actions in
> > response to various PM events. */
> > =C2=A0=C2=A0	struct notifier_block pm_notifier;
> > +	/** @pm_block: Completion to block validating tasks on
> > suspend / hibernate prepare */
> > +	struct completion pm_block;
> > +	/** @rebind_resume_list: List of wq items to kick on
> > resume. */
> > +	struct list_head rebind_resume_list;
> > +	/** @rebind_resume_lock: Lock to protect the
> > rebind_resume_list */
> > +	struct mutex rebind_resume_lock;
> > =C2=A0=20
> > =C2=A0=C2=A0	/** @pmt: Support the PMT driver callback interface */
> > =C2=A0=C2=A0	struct {
> > diff --git a/drivers/gpu/drm/xe/xe_exec.c
> > b/drivers/gpu/drm/xe/xe_exec.c
> > index 44364c042ad7..374c831e691b 100644
> > --- a/drivers/gpu/drm/xe/xe_exec.c
> > +++ b/drivers/gpu/drm/xe/xe_exec.c
> > @@ -237,6 +237,15 @@ int xe_exec_ioctl(struct drm_device *dev, void
> > *data, struct drm_file *file)
> > =C2=A0=C2=A0		goto err_unlock_list;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > +	/*
> > +	 * It's OK to block interruptible here with the vm lock
> > held, since
> > +	 * on task freezing during suspend / hibernate, the call
> > will
> > +	 * return -ERESTARTSYS and the IOCTL will be rerun.
> > +	 */
> > +	err =3D wait_for_completion_interruptible(&xe->pm_block);
> > +	if (err)
> > +		goto err_unlock_list;
> > +
> > =C2=A0=C2=A0	vm_exec.vm =3D &vm->gpuvm;
> > =C2=A0=C2=A0	vm_exec.flags =3D DRM_EXEC_INTERRUPTIBLE_WAIT;
> > =C2=A0=C2=A0	if (xe_vm_in_lr_mode(vm)) {
> > diff --git a/drivers/gpu/drm/xe/xe_pm.c
> > b/drivers/gpu/drm/xe/xe_pm.c
> > index bee9aacd82e7..6d59990ff6ba 100644
> > --- a/drivers/gpu/drm/xe/xe_pm.c
> > +++ b/drivers/gpu/drm/xe/xe_pm.c
> > @@ -297,6 +297,18 @@ static u32 vram_threshold_value(struct
> > xe_device *xe)
> > =C2=A0=C2=A0	return DEFAULT_VRAM_THRESHOLD;
> > =C2=A0 }
> > =C2=A0=20
> > +static void xe_pm_wake_preempt_workers(struct xe_device *xe)
> > +{
> > +	struct list_head *link, *next;
> > +
> > +	mutex_lock(&xe->rebind_resume_lock);
> > +	list_for_each_safe(link, next, &xe->rebind_resume_list) {
> > +		list_del_init(link);
> > +		xe_vm_resume_preempt_worker(link);
> > +	}
> > +	mutex_unlock(&xe->rebind_resume_lock);
> > +}
> > +
> > =C2=A0 static int xe_pm_notifier_callback(struct notifier_block *nb,
> > =C2=A0=C2=A0				=C2=A0=C2=A0 unsigned long action, void
> > *data)
> > =C2=A0 {
> > @@ -306,6 +318,7 @@ static int xe_pm_notifier_callback(struct
> > notifier_block *nb,
> > =C2=A0=C2=A0	switch (action) {
> > =C2=A0=C2=A0	case PM_HIBERNATION_PREPARE:
> > =C2=A0=C2=A0	case PM_SUSPEND_PREPARE:
> > +		reinit_completion(&xe->pm_block);
> > =C2=A0=C2=A0		xe_pm_runtime_get(xe);
> > =C2=A0=C2=A0		err =3D xe_bo_evict_all_user(xe);
> > =C2=A0=C2=A0		if (err)
> > @@ -322,6 +335,8 @@ static int xe_pm_notifier_callback(struct
> > notifier_block *nb,
> > =C2=A0=C2=A0		break;
> > =C2=A0=C2=A0	case PM_POST_HIBERNATION:
> > =C2=A0=C2=A0	case PM_POST_SUSPEND:
> > +		complete_all(&xe->pm_block);
> > +		xe_pm_wake_preempt_workers(xe);
> > =C2=A0=C2=A0		xe_bo_notifier_unprepare_all_pinned(xe);
> > =C2=A0=C2=A0		xe_pm_runtime_put(xe);
> > =C2=A0=C2=A0		break;
> > @@ -348,6 +363,11 @@ int xe_pm_init(struct xe_device *xe)
> > =C2=A0=C2=A0	if (err)
> > =C2=A0=C2=A0		return err;
> > =C2=A0=20
> > +	init_completion(&xe->pm_block);
> > +	complete_all(&xe->pm_block);
> > +	mutex_init(&xe->rebind_resume_lock);
>=20
> err =3D drmm_mutex_init(&xe->rebind_resume_lock);

Sure.

>=20
> ?
>=20
> > +	INIT_LIST_HEAD(&xe->rebind_resume_list);
> > +
> > =C2=A0=C2=A0	/* For now suspend/resume is only allowed with GuC */
> > =C2=A0=C2=A0	if (!xe_device_uc_enabled(xe))
> > =C2=A0=C2=A0		return 0;
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > b/drivers/gpu/drm/xe/xe_vm.c
> > index f55f96bb240a..97aad1d53a8c 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -394,6 +394,9 @@ static int xe_gpuvm_validate(struct
> > drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
> > =C2=A0=C2=A0		list_move_tail(&gpuva_to_vma(gpuva)-
> > >combined_links.rebind,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &vm->rebind_list);
> > =C2=A0=20
> > +	if (!try_wait_for_completion(&vm->xe->pm_block))
> > +		return -EAGAIN;
> > +
> > =C2=A0=C2=A0	ret =3D xe_bo_validate(gem_to_xe_bo(vm_bo->obj), vm, false=
);
> > =C2=A0=C2=A0	if (ret)
> > =C2=A0=C2=A0		return ret;
> > @@ -480,6 +483,37 @@ static int xe_preempt_work_begin(struct
> > drm_exec *exec, struct xe_vm *vm,
> > =C2=A0=C2=A0	return xe_vm_validate_rebind(vm, exec, vm-
> > >preempt.num_exec_queues);
> > =C2=A0 }
> > =C2=A0=20
> > +static bool vm_suspend_preempt_worker(struct xe_vm *vm)
> > +{
> > +	struct xe_device *xe =3D vm->xe;
> > +	bool ret =3D false;
> > +
> > +	mutex_lock(&xe->rebind_resume_lock);
> > +	if (!try_wait_for_completion(&vm->xe->pm_block)) {
> > +		ret =3D true;
> > +		list_move_tail(&vm->preempt.pm_activate_link, &xe-
> > >rebind_resume_list);
> > +	}
> > +	pr_info("Suspending %p\n", vm);
> > +	mutex_unlock(&xe->rebind_resume_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * xe_vm_resume_preempt_worker() - Resume the preempt worker.
> > + * @vm: The vm whose preempt worker to resume.
> > + *
> > + * Resume a preempt worker that was previously suspended by
> > + * vm_suspend_preempt_worker().
> > + */
> > +void xe_vm_resume_preempt_worker(struct list_head *link)
>=20
> I guess should use vm arg here?

Yes I tried to avoid downcasting from within xe_pm.c but since we need
to include xe_vm.h anyway, I might as well do that.

Thanks for reviewing!

/Thomas




>=20
> > +{
> > +	struct xe_vm *vm =3D container_of(link, typeof(*vm),
> > preempt.pm_activate_link);
> > +
> > +	pr_info("Resuming %p\n", vm);
> > +	queue_work(vm->xe->ordered_wq, &vm->preempt.rebind_work);
> > +}
> > +
> > =C2=A0 static void preempt_rebind_work_func(struct work_struct *w)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct xe_vm *vm =3D container_of(w, struct xe_vm,
> > preempt.rebind_work);
> > @@ -503,6 +537,11 @@ static void preempt_rebind_work_func(struct
> > work_struct *w)
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > =C2=A0 retry:
> > +	if (!try_wait_for_completion(&vm->xe->)) &&
> > vm_suspend_preempt_worker(vm)) {
> > +		up_write(&vm->lock);
> > +		return;
> > +	}
> > +
> > =C2=A0=C2=A0	if (xe_vm_userptr_check_repin(vm)) {
> > =C2=A0=C2=A0		err =3D xe_vm_userptr_pin(vm);
> > =C2=A0=C2=A0		if (err)
> > @@ -1741,6 +1780,7 @@ struct xe_vm *xe_vm_create(struct xe_device
> > *xe, u32 flags, struct xe_file *xef)
> > =C2=A0=C2=A0	if (flags & XE_VM_FLAG_LR_MODE) {
> > =C2=A0=C2=A0		INIT_WORK(&vm->preempt.rebind_work,
> > preempt_rebind_work_func);
> > =C2=A0=C2=A0		xe_pm_runtime_get_noresume(xe);
> > +		INIT_LIST_HEAD(&vm->preempt.pm_activate_link);
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > =C2=A0=C2=A0	if (flags & XE_VM_FLAG_FAULT_MODE) {
> > @@ -1922,8 +1962,12 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> > =C2=A0=C2=A0	xe_assert(xe, !vm->preempt.num_exec_queues);
> > =C2=A0=20
> > =C2=A0=C2=A0	xe_vm_close(vm);
> > -	if (xe_vm_in_preempt_fence_mode(vm))
> > +	if (xe_vm_in_preempt_fence_mode(vm)) {
> > +		mutex_lock(&xe->rebind_resume_lock);
> > +		list_del_init(&vm->preempt.pm_activate_link);
> > +		mutex_unlock(&xe->rebind_resume_lock);
> > =C2=A0=C2=A0		flush_work(&vm->preempt.rebind_work);
> > +	}
> > =C2=A0=C2=A0	if (xe_vm_in_fault_mode(vm))
> > =C2=A0=C2=A0		xe_svm_close(vm);
> > =C2=A0=20
> > diff --git a/drivers/gpu/drm/xe/xe_vm.h
> > b/drivers/gpu/drm/xe/xe_vm.h
> > index b3e5bec0fa58..f2639794278b 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.h
> > +++ b/drivers/gpu/drm/xe/xe_vm.h
> > @@ -281,6 +281,8 @@ struct dma_fence *xe_vm_bind_kernel_bo(struct
> > xe_vm *vm, struct xe_bo *bo,
> > =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xe_exec_que=
ue *q,
> > u64 addr,
> > =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum xe_cache_leve=
l
> > cache_lvl);
> > =C2=A0=20
> > +void xe_vm_resume_preempt_worker(struct list_head *link);
> > +
> > =C2=A0 /**
> > =C2=A0=C2=A0 * xe_vm_resv() - Return's the vm's reservation object
> > =C2=A0=C2=A0 * @vm: The vm
> > diff --git a/drivers/gpu/drm/xe/xe_vm_types.h
> > b/drivers/gpu/drm/xe/xe_vm_types.h
> > index b5108d010786..e1a786db5f89 100644
> > --- a/drivers/gpu/drm/xe/xe_vm_types.h
> > +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> > @@ -338,6 +338,11 @@ struct xe_vm {
> > =C2=A0=C2=A0		 * BOs
> > =C2=A0=C2=A0		 */
> > =C2=A0=C2=A0		struct work_struct rebind_work;
> > +		/**
> > +		 * @preempt.pm_activate_link: Link to list of
> > rebind workers to be
> > +		 * kicked on resume.
> > +		 */
> > +		struct list_head pm_activate_link;
> > =C2=A0=C2=A0	} preempt;
> > =C2=A0=20
> > =C2=A0=C2=A0	/** @um: unified memory state */
>=20


