Return-Path: <stable+bounces-272878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DCZFHEuCT2qWiQIAu9opvQ
	(envelope-from <stable+bounces-272878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:13:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE9173015D
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:13:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KCY0auSr;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272878-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272878-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 442C3301DEDB
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E01A224AFA;
	Thu,  9 Jul 2026 11:01:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725336F903
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 11:01:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594872; cv=none; b=vEOdDNufhmYyZrlY+q8wbOHflARLnHg2GzBmW6Yq594cLfj8ejT6g6PdzzjBpFEuK7854Pr3sw5GT8LPeuQI+FALlcgDTWOTiMYxuvR4c0Fi43E6Q+tC6rcZEA2croz8hCQSb5KZhvRWLV3bmHAFHi7lA7h+XxL6Qo5cVBXpnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594872; c=relaxed/simple;
	bh=dj24b08LSuULdHCbTX/VMTiC9XDpe+VNx4I8C5xtGBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SImr34nXk0Jc2Mnd36LU5zEWxy035fjSuxmulZuV30XjuAlwrMttEb2QbU42fvUorzztRUlfETL3DuNFmIvbkFdpNdTr0mmm5xC+9FpthurpwSWmKmERIFVOl7XfIIhcQ7gId5MLLl0e+L+BcLsLPH3JG1gorAIrzq29nkJL838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCY0auSr; arc=none smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783594871; x=1815130871;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dj24b08LSuULdHCbTX/VMTiC9XDpe+VNx4I8C5xtGBQ=;
  b=KCY0auSrhlUQLI8dGX+6Nman1ah8s6CT4JPpdnWTf0Qw3m7+2VxWcRDO
   uPgMqTkJsSsC6356mVFEzXp+RsC0ef+Ux23KjDwZisVL829AJMdFvdROC
   SYIhnTFbC/7tS1NyhXIYHhTNq7yMtyHmrXCumwY1f5liUBDJNXAxTHCt+
   WoOvrrFRkxGJfIc+lGkWeb1OvumC/AqNQvnmYY7kkbbcYQLlrd2K8toCx
   9qziAS/NZSMoYNWDOFYz94Nacx0ThrRrGIwgEw7gYPaGamO9I1tHnz5Ec
   LnlV4IRiXpRlCGN8BFPwlD6iAY0SD4UFL6Zma3jHre7k4TDonYyxG9AbE
   g==;
X-CSE-ConnectionGUID: pyzkrMm5Sw+gyI5BQX00eA==
X-CSE-MsgGUID: b1sqwCyTSvuIaiDSUGHJXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88187617"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88187617"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 04:01:11 -0700
X-CSE-ConnectionGUID: 9AYzT13aTJWvDifjVC+/2w==
X-CSE-MsgGUID: 8UvcYIYWRwWlJEf7oA83ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248180803"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.44]) ([10.245.244.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 04:01:09 -0700
Message-ID: <42f4a99a3b572f7141ff1a2d7db2854d457300c4.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Wait on external BO kernel fences in exec IOCTL
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, Matthew Brost
	 <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Date: Thu, 09 Jul 2026 13:01:07 +0200
In-Reply-To: <d5c3258a-04d1-42d6-9d74-cdd9a1172d97@intel.com>
References: <20260702215805.4011228-1-matthew.brost@intel.com>
	 <d5c3258a-04d1-42d6-9d74-cdd9a1172d97@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272878-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matthew.auld@intel.com,m:matthew.brost@intel.com,m:intel-xe@lists.freedesktop.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,linux.intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AE9173015D

On Fri, 2026-07-03 at 09:45 +0100, Matthew Auld wrote:
> On 02/07/2026 22:58, Matthew Brost wrote:
> > Before arming a user job, xe_exec_ioctl() only added the VM's
> > dma-resv KERNEL slot as a dependency. That slot covers rebinds and
> > the kernel operations of the VM's private BOs, but not external BOs
> > (bo->vm =3D=3D NULL), which carry their kernel operations (evictions,
> > moves, ...) in their own dma-resv KERNEL slot.
> >=20
> > The DMA_RESV_USAGE_KERNEL slot is the cross-driver contract for
> > memory management operations that must complete before the BO or
> > its
> > backing store may be used: any accessor is required to wait on the
> > KERNEL fences before touching the resv. By skipping the external
> > BOs'
> > KERNEL slots, the exec path violated that contract and could
> > schedule
> > a user job while a kernel operation on an external BO mapped by the
> > VM
> > was still in flight, racing against it and potentially reading or
> > writing memory that was being moved.
> >=20
> > Replace the VM-only dependency with an iteration over every object
> > locked by the exec, adding each object's KERNEL slot as a job
> > dependency. This covers the VM resv (rebinds and private BOs) as
> > well
> > as every external BO, mirroring the drm_gpuvm_resv_add_fence() call
> > that later publishes the job fence to the same set of objects.
> > Long-running mode continues to skip this, as before.
> >=20
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > GPUs")
> > Cc: stable@vger.kernel.org
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>=20
> Wow, kind of surprised we missed this.

Hm. Does this actually add any additional kernel fences to the exec
dep?

Isn't the safety mechanism we have that no valid GPU PTEs are allowed
to be set up with active kernel fences, and in the cases (rebinds,
munmap split) we generate a VM kernel fence.=C2=A0

So if an exec runs trying to access such a bo with an active clear, for
example, it would typically generate a pagefault?

Thomas





>=20
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>=20
> > ---
> > =C2=A0 drivers/gpu/drm/xe/xe_exec.c | 22 ++++++++++++++++------
> > =C2=A0 1 file changed, 16 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_exec.c
> > b/drivers/gpu/drm/xe/xe_exec.c
> > index e05dabfcd43c..d5293bc33a67 100644
> > --- a/drivers/gpu/drm/xe/xe_exec.c
> > +++ b/drivers/gpu/drm/xe/xe_exec.c
> > @@ -292,13 +292,23 @@ int xe_exec_ioctl(struct drm_device *dev,
> > void *data, struct drm_file *file)
> > =C2=A0=C2=A0		goto err_exec;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	/* Wait behind rebinds */
> > +	/*
> > +	 * Wait behind rebinds and any kernel operations
> > (evictions, defrag
> > +	 * moves, ...) on the VM and all external BOs. The VM's
> > private BOs
> > +	 * carry their kernel ops in the VM dma-resv KERNEL slot,
> > while each
> > +	 * external BO carries them in its own dma-resv KERNEL
> > slot; both are
> > +	 * covered by iterating every object locked by the exec,
> > mirroring the
> > +	 * drm_gpuvm_resv_add_fence() below.
> > +	 */
> > =C2=A0=C2=A0	if (!xe_vm_in_lr_mode(vm)) {
> > -		err =3D xe_sched_job_add_deps(job,
> > -					=C2=A0=C2=A0=C2=A0 xe_vm_resv(vm),
> > -					=C2=A0=C2=A0=C2=A0
> > DMA_RESV_USAGE_KERNEL);
> > -		if (err)
> > -			goto err_put_job;
> > +		struct drm_gem_object *obj;
> > +
> > +		drm_exec_for_each_locked_object(exec, obj) {
> > +			err =3D xe_sched_job_add_deps(job, obj-
> > >resv,
> > +						=C2=A0=C2=A0=C2=A0
> > DMA_RESV_USAGE_KERNEL);
> > +			if (err)
> > +				goto err_put_job;
> > +		}
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > =C2=A0=C2=A0	for (i =3D 0; i < num_syncs && !err; i++)

