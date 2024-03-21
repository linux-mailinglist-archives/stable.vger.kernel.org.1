Return-Path: <stable+bounces-28580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1C886279
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 22:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74841F238A5
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 21:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237BF135A5F;
	Thu, 21 Mar 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmwGlTEW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719881353EC
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711056072; cv=none; b=gWjvNJPpuW6F4KSnzf+a4MjTWXFas72uoLgFW/PaPW64M2+JSMuIBFHORk9TBGvgUs4ZO0b10bdjmgLXDpCosTMBnGyvFv9RCGNUrnJCwtS0QAh0Q0InWuP6pYcG5Ddiho/adN+Ea6xX50t9tT28/w6XYd24fXCIP2+qJAy1Hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711056072; c=relaxed/simple;
	bh=IIOoL+IpCaeF080glbmy/0i9gzlV5nd1+G2+QP4qGrU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CqNP87FNLhlcSTCS/Xqr1dLqEpiyO6Fx/TSv0Pi+6ejHbAnJ9x4o2pGDZe0ObAAPET7vy1BQs2kAAOWHdgMQ7TpLfYq1AVuxIbs2ZC3fi9j+ONEvrMDLh8YwnxkCVfw51jBBy+EfkesBWyfPS3VOmjuRCpqH8C1q3P9acANF0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmwGlTEW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711056071; x=1742592071;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=IIOoL+IpCaeF080glbmy/0i9gzlV5nd1+G2+QP4qGrU=;
  b=hmwGlTEW7nY1CApfsj5nvEBiV6OFWSi1fBwx8jJrPnt+JDK23U4gb3YD
   RNx/zRLFNNJfty11+42948Rlk9LZ6yArNuFh/tFIAfWjKl/f2Y4GzbZNI
   OMna5w3NOweNti+7w/0izPSTWaoGL/Ls2lbmJA0+JyEAhwvnHIALY6Kyh
   n2v8wZ0hLgp2BXUQKZNjsxGYuL+RKAEYth5RPw6PNeqJiVkBOzz3NL/xQ
   /+gjDcB0rlrDrwreCzpbJicb8T0ktFFoMEQjuMXtZnpsyw2rBrGw55HPy
   itKGIEopWpBZ2LLQeOBQ/DB9gFvUW/3WZGPUU2kmO2g/xedCNq8wHJWpO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9846942"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="9846942"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="14627198"
Received: from sinampud-mobl.amr.corp.intel.com (HELO [10.249.254.176]) ([10.249.254.176])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:21:09 -0700
Message-ID: <4edbc1b5f4aa01f590c28109567dc5d97eeef71f.camel@linux.intel.com>
Subject: Re: [PATCH 1/7] drm/xe: Use ring ops TLB invalidation for rebinds
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Date: Thu, 21 Mar 2024 22:21:07 +0100
In-Reply-To: <f06fb3dcf8e377e064a30e0a62324f952f93cfe5.camel@linux.intel.com>
References: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
	 <20240321113720.120865-3-thomas.hellstrom@linux.intel.com>
	 <ZfyF7kfCE+xcMFa7@DUT025-TGLU.fm.intel.com>
	 <f06fb3dcf8e377e064a30e0a62324f952f93cfe5.camel@linux.intel.com>
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

On Thu, 2024-03-21 at 22:14 +0100, Thomas Hellstr=C3=B6m wrote:
> Hi, Matthew,
>=20
> Thanks for reviewing, please see inline.
>=20
> On Thu, 2024-03-21 at 19:09 +0000, Matthew Brost wrote:
> > On Thu, Mar 21, 2024 at 12:37:11PM +0100, Thomas Hellstr=C3=B6m wrote:
> > > For each rebind we insert a GuC TLB invalidation and add a
> > > corresponding unordered TLB invalidation fence. This might
> > > add a huge number of TLB invalidation fences to wait for so
> > > rather than doing that, defer the TLB invalidation to the
> > > next ring ops for each affected exec queue. Since the TLB
> > > is invalidated on exec_queue switch, we need to invalidate
> > > once for each affected exec_queue.
> > >=20
> > > Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after
> > > rebinds issued from execs")
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.8+
> > > Signed-off-by: Thomas Hellstr=C3=B6m
> > > <thomas.hellstrom@linux.intel.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/xe/xe_exec_queue_types.h |=C2=A0 2 ++
> > > =C2=A0drivers/gpu/drm/xe/xe_pt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> > > =C2=A0drivers/gpu/drm/xe/xe_ring_ops.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 11 ++++-------
> > > =C2=A0drivers/gpu/drm/xe/xe_sched_job.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 11 +++++++++++
> > > =C2=A0drivers/gpu/drm/xe/xe_sched_job_types.h=C2=A0 |=C2=A0 2 ++
> > > =C2=A0drivers/gpu/drm/xe/xe_vm_types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> > > =C2=A06 files changed, 27 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > > b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > > index 62b3d9d1d7cd..891ad30e906f 100644
> > > --- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > > +++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > > @@ -148,6 +148,8 @@ struct xe_exec_queue {
> > > =C2=A0	const struct xe_ring_ops *ring_ops;
> > > =C2=A0	/** @entity: DRM sched entity for this exec queue (1 to
> > > 1
> > > relationship) */
> > > =C2=A0	struct drm_sched_entity *entity;
> > > +	/** @tlb_flush_seqno: The seqno of the last rebind tlb
> > > flush performed */
> > > +	u64 tlb_flush_seqno;
> > > =C2=A0	/** @lrc: logical ring context for this exec queue */
> > > =C2=A0	struct xe_lrc lrc[];
> > > =C2=A0};
> > > diff --git a/drivers/gpu/drm/xe/xe_pt.c
> > > b/drivers/gpu/drm/xe/xe_pt.c
> > > index 8d3922d2206e..21bc0d13fccf 100644
> > > --- a/drivers/gpu/drm/xe/xe_pt.c
> > > +++ b/drivers/gpu/drm/xe/xe_pt.c
> > > @@ -1254,11 +1254,12 @@ __xe_pt_bind_vma(struct xe_tile *tile,
> > > struct xe_vma *vma, struct xe_exec_queue
> > > =C2=A0	 * non-faulting LR, in particular on user-space batch
> > > buffer chaining,
> > > =C2=A0	 * it needs to be done here.
> > > =C2=A0	 */
> > > -	if ((rebind && !xe_vm_in_lr_mode(vm) && !vm-

While I remember it. When looking at your series I noticed that this
line got incorrectly moved there. Looks like you used
xe_vm_in_lr_mode() rather than !xe_vm_in_lr_mode()..

Thomas


