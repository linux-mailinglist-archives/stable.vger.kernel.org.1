Return-Path: <stable+bounces-28578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C464A886264
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 22:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A905283D92
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 21:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B8135A58;
	Thu, 21 Mar 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2ofrrUJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9A13443D
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055696; cv=none; b=gZ8Q9OSTM3j4hO6Ty1+gXDlm3YyBPrzISsY6d54M3bchra2qWaC9MCy2io0sm83NrE4LBV6LFPD0ORR+ZQb6BmSpXRX5EwdvZC4jc5EXMSRnKtNjz+gNYK2vVZJHjpVmHdwt+wVHvFo988rSaYZAMr6sK3XfLR7ptBwPbaQpyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055696; c=relaxed/simple;
	bh=ZVRnbWVi33fNT14Q49OQJEeKHTkdO8BtG8uB2EtQWvE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NqBjUBVJq00oQsS7zV2dTmAwfVktUFn/LLM49RXrjVFzHoEIkRNm65900rsVpWdiO45IHvnN0LUyA4wGr9ArKqc839UtA6OoWkbbKasXxKJiv8tGKCJHT61vM7jPjyGRNl4V8xoE4O2zU1ih/hEvCUjSKFaVSyHpMb7IANN72zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2ofrrUJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711055695; x=1742591695;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZVRnbWVi33fNT14Q49OQJEeKHTkdO8BtG8uB2EtQWvE=;
  b=P2ofrrUJv1Qy3MdrVeT+LKBeWsYdnu9u817xPf6khweI02nvrNc9q0OX
   vTJRjp+5F51u0loTLSPdtnHHXUKaczvp6K57XuW5u/72VY40Yf8o51kDb
   a0/HLaF580TTLNHxhARrzlDpEz2ww9diOWXcKmNMHr6/CRWeIkvvIf+a/
   35uRpm3mQDM+7oTbgOw2co5JDW5iNvmUgS2c6Wl7yzud+iv+SN7K6+4pu
   LbCs12cpb5dSCUvdL6t76SYTz+1zBo9lrAazevsp75or0QkxEiDu1GTFW
   wclcv02JkaxEpipxJyBwkgdVr7g5UjMnb8Wir7Wjbx2bcROflcBLakGCm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17229379"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="17229379"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="14702257"
Received: from sinampud-mobl.amr.corp.intel.com (HELO [10.249.254.176]) ([10.249.254.176])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:14:53 -0700
Message-ID: <f06fb3dcf8e377e064a30e0a62324f952f93cfe5.camel@linux.intel.com>
Subject: Re: [PATCH 1/7] drm/xe: Use ring ops TLB invalidation for rebinds
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Date: Thu, 21 Mar 2024 22:14:50 +0100
In-Reply-To: <ZfyF7kfCE+xcMFa7@DUT025-TGLU.fm.intel.com>
References: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
	 <20240321113720.120865-3-thomas.hellstrom@linux.intel.com>
	 <ZfyF7kfCE+xcMFa7@DUT025-TGLU.fm.intel.com>
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

Hi, Matthew,

Thanks for reviewing, please see inline.

On Thu, 2024-03-21 at 19:09 +0000, Matthew Brost wrote:
> On Thu, Mar 21, 2024 at 12:37:11PM +0100, Thomas Hellstr=C3=B6m wrote:
> > For each rebind we insert a GuC TLB invalidation and add a
> > corresponding unordered TLB invalidation fence. This might
> > add a huge number of TLB invalidation fences to wait for so
> > rather than doing that, defer the TLB invalidation to the
> > next ring ops for each affected exec queue. Since the TLB
> > is invalidated on exec_queue switch, we need to invalidate
> > once for each affected exec_queue.
> >=20
> > Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after
> > rebinds issued from execs")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.8+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_exec_queue_types.h |=C2=A0 2 ++
> > =C2=A0drivers/gpu/drm/xe/xe_pt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> > =C2=A0drivers/gpu/drm/xe/xe_ring_ops.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 11 ++++-------
> > =C2=A0drivers/gpu/drm/xe/xe_sched_job.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 11 +++++++++++
> > =C2=A0drivers/gpu/drm/xe/xe_sched_job_types.h=C2=A0 |=C2=A0 2 ++
> > =C2=A0drivers/gpu/drm/xe/xe_vm_types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> > =C2=A06 files changed, 27 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > index 62b3d9d1d7cd..891ad30e906f 100644
> > --- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > +++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > @@ -148,6 +148,8 @@ struct xe_exec_queue {
> > =C2=A0	const struct xe_ring_ops *ring_ops;
> > =C2=A0	/** @entity: DRM sched entity for this exec queue (1 to 1
> > relationship) */
> > =C2=A0	struct drm_sched_entity *entity;
> > +	/** @tlb_flush_seqno: The seqno of the last rebind tlb
> > flush performed */
> > +	u64 tlb_flush_seqno;
> > =C2=A0	/** @lrc: logical ring context for this exec queue */
> > =C2=A0	struct xe_lrc lrc[];
> > =C2=A0};
> > diff --git a/drivers/gpu/drm/xe/xe_pt.c
> > b/drivers/gpu/drm/xe/xe_pt.c
> > index 8d3922d2206e..21bc0d13fccf 100644
> > --- a/drivers/gpu/drm/xe/xe_pt.c
> > +++ b/drivers/gpu/drm/xe/xe_pt.c
> > @@ -1254,11 +1254,12 @@ __xe_pt_bind_vma(struct xe_tile *tile,
> > struct xe_vma *vma, struct xe_exec_queue
> > =C2=A0	 * non-faulting LR, in particular on user-space batch
> > buffer chaining,
> > =C2=A0	 * it needs to be done here.
> > =C2=A0	 */
> > -	if ((rebind && !xe_vm_in_lr_mode(vm) && !vm-
> > >batch_invalidate_tlb) ||
> > -	=C2=A0=C2=A0=C2=A0 (!rebind && xe_vm_has_scratch(vm) &&
> > xe_vm_in_preempt_fence_mode(vm))) {
> > +	if ((!rebind && xe_vm_has_scratch(vm) &&
> > xe_vm_in_preempt_fence_mode(vm))) {
>=20
> Looked why this works in fault mode, we disallow scratch page in
> fault
> mode. I thought at one point we had implementation for that [1] but
> it
> looks like it never got merged. Some to keep an eye on.
>=20
> [1] https://patchwork.freedesktop.org/series/120480/
>=20
> > =C2=A0		ifence =3D kzalloc(sizeof(*ifence), GFP_KERNEL);
> > =C2=A0		if (!ifence)
> > =C2=A0			return ERR_PTR(-ENOMEM);
> > +	} else if (rebind && !xe_vm_in_lr_mode(vm) && !vm-
> > >batch_invalidate_tlb) {
> > +		vm->tlb_flush_seqno++;
>=20
> Can we unwind this if / else clause a bit?
>=20
> I think batch_invalidate_tlb can only be true if
> !xe_vm_in_lr_mode(vm).
>=20
> So else if 'rebind && !xe_vm_in_lr_mode(vm)' should work. Also if
> batch_invalidate_tlb is we true we always issue TLB invalidate
> anyways
> and incrementing the seqno is harmles too.

Yes, although I don't really like making assumptions in the code what
it does with a certain variable elsewhere. At some point in the future
people might change that, or say "Hey, they unnecessarily increment the
seqno here or forget a branch. I could add asserts about
batch_invalidate_tlb, though to avoid such future mishaps.


>=20
> Side note, I'd be remiss if I didn't mention that I really do not
> like
> updating these functions (__xe_pt_bind_vma / __xe_pt_unbind_vma) as
> they
> are going away / being reworked here [2] in order to implement 1 job
> per
> IOCTL / proper error handling.
>=20
> [2] https://patchwork.freedesktop.org/series/125608/

Fully understandible. That's why I asked whether you thought it
clashed. However I want this backported to 6.8 so I don't see any other
way of doing it.

/Thomas


>=20
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	rfence =3D kzalloc(sizeof(*rfence), GFP_KERNEL);
> > diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c
> > b/drivers/gpu/drm/xe/xe_ring_ops.c
> > index c4edffcd4a32..5b2b37b59813 100644
> > --- a/drivers/gpu/drm/xe/xe_ring_ops.c
> > +++ b/drivers/gpu/drm/xe/xe_ring_ops.c
> > @@ -219,10 +219,9 @@ static void __emit_job_gen12_simple(struct
> > xe_sched_job *job, struct xe_lrc *lrc
> > =C2=A0{
> > =C2=A0	u32 dw[MAX_JOB_SIZE_DW], i =3D 0;
> > =C2=A0	u32 ppgtt_flag =3D get_ppgtt_flag(job);
> > -	struct xe_vm *vm =3D job->q->vm;
> > =C2=A0	struct xe_gt *gt =3D job->q->gt;
> > =C2=A0
> > -	if (vm && vm->batch_invalidate_tlb) {
> > +	if (job->ring_ops_flush_tlb) {
> > =C2=A0		dw[i++] =3D preparser_disable(true);
> > =C2=A0		i =3D
> > emit_flush_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
> > =C2=A0					seqno, true, dw, i);
> > @@ -270,7 +269,6 @@ static void __emit_job_gen12_video(struct
> > xe_sched_job *job, struct xe_lrc *lrc,
> > =C2=A0	struct xe_gt *gt =3D job->q->gt;
> > =C2=A0	struct xe_device *xe =3D gt_to_xe(gt);
> > =C2=A0	bool decode =3D job->q->class =3D=3D
> > XE_ENGINE_CLASS_VIDEO_DECODE;
> > -	struct xe_vm *vm =3D job->q->vm;
> > =C2=A0
> > =C2=A0	dw[i++] =3D preparser_disable(true);
> > =C2=A0
> > @@ -282,13 +280,13 @@ static void __emit_job_gen12_video(struct
> > xe_sched_job *job, struct xe_lrc *lrc,
> > =C2=A0			i =3D emit_aux_table_inv(gt, VE0_AUX_INV,
> > dw, i);
> > =C2=A0	}
> > =C2=A0
> > -	if (vm && vm->batch_invalidate_tlb)
> > +	if (job->ring_ops_flush_tlb)
> > =C2=A0		i =3D
> > emit_flush_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
> > =C2=A0					seqno, true, dw, i);
> > =C2=A0
> > =C2=A0	dw[i++] =3D preparser_disable(false);
> > =C2=A0
> > -	if (!vm || !vm->batch_invalidate_tlb)
> > +	if (!job->ring_ops_flush_tlb)
> > =C2=A0		i =3D
> > emit_store_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
> > =C2=A0					seqno, dw, i);
> > =C2=A0
> > @@ -317,7 +315,6 @@ static void
> > __emit_job_gen12_render_compute(struct xe_sched_job *job,
> > =C2=A0	struct xe_gt *gt =3D job->q->gt;
> > =C2=A0	struct xe_device *xe =3D gt_to_xe(gt);
> > =C2=A0	bool lacks_render =3D !(gt->info.engine_mask &
> > XE_HW_ENGINE_RCS_MASK);
> > -	struct xe_vm *vm =3D job->q->vm;
> > =C2=A0	u32 mask_flags =3D 0;
> > =C2=A0
> > =C2=A0	dw[i++] =3D preparser_disable(true);
> > @@ -327,7 +324,7 @@ static void
> > __emit_job_gen12_render_compute(struct xe_sched_job *job,
> > =C2=A0		mask_flags =3D PIPE_CONTROL_3D_ENGINE_FLAGS;
> > =C2=A0
> > =C2=A0	/* See __xe_pt_bind_vma() for a discussion on TLB
> > invalidations. */
> > -	i =3D emit_pipe_invalidate(mask_flags, vm && vm-
> > >batch_invalidate_tlb, dw, i);
> > +	i =3D emit_pipe_invalidate(mask_flags, job-
> > >ring_ops_flush_tlb, dw, i);
> > =C2=A0
> > =C2=A0	/* hsdes: 1809175790 */
> > =C2=A0	if (has_aux_ccs(xe))
> > diff --git a/drivers/gpu/drm/xe/xe_sched_job.c
> > b/drivers/gpu/drm/xe/xe_sched_job.c
> > index 8151ddafb940..d55458d915a9 100644
> > --- a/drivers/gpu/drm/xe/xe_sched_job.c
> > +++ b/drivers/gpu/drm/xe/xe_sched_job.c
> > @@ -250,6 +250,17 @@ bool xe_sched_job_completed(struct
> > xe_sched_job *job)
> > =C2=A0
> > =C2=A0void xe_sched_job_arm(struct xe_sched_job *job)
> > =C2=A0{
> > +	struct xe_exec_queue *q =3D job->q;
> > +	struct xe_vm *vm =3D q->vm;
> > +
> > +	if (vm && !xe_sched_job_is_migration(q) &&
> > !xe_vm_in_lr_mode(vm) &&
> > +	=C2=A0=C2=A0=C2=A0 vm->tlb_flush_seqno !=3D q->tlb_flush_seqno) {
> > +		q->tlb_flush_seqno =3D vm->tlb_flush_seqno;
> > +		job->ring_ops_flush_tlb =3D true;
> > +	} else if (vm && vm->batch_invalidate_tlb) {
> > +		job->ring_ops_flush_tlb =3D true;
> > +	}
> > +
>=20
> Can we simplify this too?
>=20
> 	if (vm && (vm->batch_invalidate_tlb || (vm->tlb_flush_seqno
> !=3D q->tlb_flush_seqno))) {
> 		q->tlb_flush_seqno =3D vm->tlb_flush_seqno;
> 		job->ring_ops_flush_tlb =3D true;
> 	}
>=20
> I think this works as xe_sched_job_is_migration has
> emit_migration_job_gen12 which doesn't look at job-
> >ring_ops_flush_tlb,
> so no need to xe_sched_job_is_migration.
>=20
> Also no need to check xe_vm_in_lr_mode as we wouldn'y increment the
> seqno above if that true.
>=20
> Lastly, harmless to increment q->tlb_flush_seqno in the case of
> batch_invalidate_tlb being true.
>=20
> > =C2=A0	drm_sched_job_arm(&job->drm);
> > =C2=A0}
> > =C2=A0
> > diff --git a/drivers/gpu/drm/xe/xe_sched_job_types.h
> > b/drivers/gpu/drm/xe/xe_sched_job_types.h
> > index b1d83da50a53..5e12724219fd 100644
> > --- a/drivers/gpu/drm/xe/xe_sched_job_types.h
> > +++ b/drivers/gpu/drm/xe/xe_sched_job_types.h
> > @@ -39,6 +39,8 @@ struct xe_sched_job {
> > =C2=A0	} user_fence;
> > =C2=A0	/** @migrate_flush_flags: Additional flush flags for
> > migration jobs */
> > =C2=A0	u32 migrate_flush_flags;
> > +	/** @ring_ops_flush_tlb: The ring ops need to flush TLB
> > before payload. */
> > +	bool ring_ops_flush_tlb;
>=20
> How about JOB_FLAG_FLUSH_TLB rather than a new field? See
> JOB_FLAG_SUBMIT flag usage.
>=20
> Matt
>=20
> > =C2=A0	/** @batch_addr: batch buffer address of job */
> > =C2=A0	u64 batch_addr[];
> > =C2=A0};
> > diff --git a/drivers/gpu/drm/xe/xe_vm_types.h
> > b/drivers/gpu/drm/xe/xe_vm_types.h
> > index ae5fb565f6bf..5747f136d24d 100644
> > --- a/drivers/gpu/drm/xe/xe_vm_types.h
> > +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> > @@ -264,6 +264,11 @@ struct xe_vm {
> > =C2=A0		bool capture_once;
> > =C2=A0	} error_capture;
> > =C2=A0
> > +	/**
> > +	 * @tlb_flush_seqno: Required TLB flush seqno for the next
> > exec.
> > +	 * protected by the vm resv.
> > +	 */
> > +	u64 tlb_flush_seqno;
> > =C2=A0	/** @batch_invalidate_tlb: Always invalidate TLB before
> > batch start */
> > =C2=A0	bool batch_invalidate_tlb;
> > =C2=A0	/** @xef: XE file handle for tracking this VM's drm client
> > */
> > --=20
> > 2.44.0
> >=20


