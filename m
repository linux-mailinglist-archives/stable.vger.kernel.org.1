Return-Path: <stable+bounces-244512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL+tFEYy/GmNMgAAu9opvQ
	(envelope-from <stable+bounces-244512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 08:33:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C33C04E387E
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 08:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 471F3300639F
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 06:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639E33AD85;
	Thu,  7 May 2026 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bShL6kkY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283D30B502
	for <stable@vger.kernel.org>; Thu,  7 May 2026 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135507; cv=none; b=ni5lEBPfMa+RLXwV5nS6vOijTgW2gSkbWiBQVDusQQcAfaoA94FhfjHQvHwj6cb4mwNrud1c8CzS/Y2lF2Lp2iGaxUaNrR/89xVqCuQKiDwZZdm/C4N/ETsyiGWISwkhp29C71so69bxjYkmWG0wMQ/VfOqN8VKvok4bK38WuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135507; c=relaxed/simple;
	bh=RYmcnkXdP8SDw3AKhAxZBvjc1xfPWqzXEdvyvujwoC4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rgI63RO3BsFfVAGqji1CcrEayIXToVJXkRMmQN9FWqunvhwu6e29904cETyJmjKYmLRVj6oJg77cQmvcv2XQ24oyTTXplAUVPxdm3rOtx7jxmre5Lu48wpFv+4KKHFnM45cxK0akMPS7TFN1T16FHHqMBcrppyeWU+uKGXGkMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bShL6kkY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778135506; x=1809671506;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RYmcnkXdP8SDw3AKhAxZBvjc1xfPWqzXEdvyvujwoC4=;
  b=bShL6kkYfe3TV977jeAc1vq27XzBJoHUOGwEGnzqvpPJMgx+J4sTKR6O
   AnxNBvI2Rmpy8hGpQ84wYyzxD2kxcp3/HoAE2a5x1fO4r0OyF66uoRXYG
   29XBPteDK0iilqbHCTpKjK1QFnEFigr7GsBoYGRzK5ZeTU4uKY9Trb8Z4
   6B1n+Xo9NUdhvtWvPsmnv4+kPuqVz7xJjlAyGiaHv61bBB0uBD/Zi9Z28
   3CDlaVHKDTiYI1lbsFkZBp4Te5UDNJfM9QqONgpKPOaH3Ek0n+5ek52+O
   fOxV6zHCi+XE9KXMrtxr8AnBXQYzSE8SWN/zMVzV2U/O4ZY0CYLomk4Dl
   w==;
X-CSE-ConnectionGUID: pW7wjoDZRyqVaTaqVqohEA==
X-CSE-MsgGUID: KoYXdpd5QfS9N7XyPKGc/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="90455074"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="90455074"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 23:31:45 -0700
X-CSE-ConnectionGUID: cp43u5yqQrW/QSpuZn2daw==
X-CSE-MsgGUID: Qk/p/9ZjS/qfmmdTifxozQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="235375465"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.94]) ([10.245.245.94])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 23:31:44 -0700
Message-ID: <7977ff722a61b0e235e3c8007d474ffb2e7b9506.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Add bounds check for num_binds to prevent
 memory exhaustion
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, Ramesh Adhikari
	 <adhikari.resume@gmail.com>
Cc: intel-xe@lists.freedesktop.org, rodrigo.vivi@intel.com, 
	stable@vger.kernel.org
Date: Thu, 07 May 2026 08:31:40 +0200
In-Reply-To: <afuWYH88a4UaABXs@gsse-cloud1.jf.intel.com>
References: <20260506180636.23771-1-adhikari.resume@gmail.com>
	 <afuWYH88a4UaABXs@gsse-cloud1.jf.intel.com>
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
X-Rspamd-Queue-Id: C33C04E387E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244512-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Action: no action

On Wed, 2026-05-06 at 12:28 -0700, Matthew Brost wrote:
> On Wed, May 06, 2026 at 11:36:36PM +0530, Ramesh Adhikari wrote:
> > The xe_vm_bind_ioctl function accepts user-controlled num_binds
> > without
> >=20
> > bounds checking, allowing arbitrarily large memory allocations.
> > This
> >=20
> > follows the same vulnerability pattern that was fixed for num_syncs
> > in
> >=20
> > commit 8e461304009d ("drm/xe: Limit num_syncs to prevent huge
> > allocations").
> >=20
>=20
> The difference here is we issues kvmalloc (2G) vs kmalloc (4M) in the
> sync case. So still possible a user triggers kvmalloc over 2G...
>=20
> > Add DRM_XE_MAX_BINDS (1024) limit and validate num_binds before
> > allocation,
> >=20
> > matching the num_syncs fix pattern.
> >=20
> > Similar unbounded allocations exist for num_mem_ranges and OA
> > n_regs,
> >=20
> > which should be addressed in follow-up patches.
> >=20
> > Cc: stable@vger.kernel.org
> >=20
> > Signed-off-by: Ramesh <adhikari.resume@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_vm.c | 5 +++++
> > =C2=A0include/uapi/drm/xe_drm.h=C2=A0 | 1 +
> > =C2=A02 files changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > b/drivers/gpu/drm/xe/xe_vm.c
> > index a717a2b8dea..1ff66874f43 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -3841,6 +3841,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev,
> > void *data, struct drm_file *file)
> > =C2=A0		return -EINVAL;
> > =C2=A0
> > =C2=A0	err =3D vm_bind_ioctl_check_args(xe, vm, args, &bind_ops);
> > +
> > +	if (XE_IOCTL_DBG(xe, args->num_binds > DRM_XE_MAX_BINDS))
> > {
> > +		err =3D -EINVAL;kvmalloc
> > +		goto put_vm;
> > +	}
>=20
> We had something like this early Xe, IIRC, the max was 512 but we
> found
> for Vk / Mesa they will a huge number in an array of binds. So 1k
> likely
> isn't enough and this patch would be considered uAPI regression, so
> this
> as is a no go. Maybe we can figure out some reasonable upper bound
> (64k,
> 128k), idk.

IIRC we debated this back and forth. The challenging argument was that
if we consume all memory we'd get an error back, which is sort of true
but then we should've really made sure that all memory allocated was
also accounted against the cgroup, with __GFP_ACCOUNT. We only did that
for one large allocation.

But I think we made sure to avoid future regressions (functional, not
performance) by requiring UMD to handle -ENOBUFS, meaning "split the
array bind and retry". So whatever limit we come up with we should not
return -EINVAL but -ENOBUFS.=20

Thanks,
Thomas



>=20
> Matt
>=20
> > =C2=A0	if (err)
> > =C2=A0		goto put_vm;
> > =C2=A0
> > diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> > index ae2fda23ce7..804ccb23b11 100644
> > --- a/include/uapi/drm/xe_drm.h
> > +++ b/include/uapi/drm/xe_drm.h
> > @@ -1606,6 +1606,7 @@ struct drm_xe_exec {
> > =C2=A0	__u32 exec_queue_id;
> > =C2=A0
> > =C2=A0#define DRM_XE_MAX_SYNCS 1024
> > +#define DRM_XE_MAX_BINDS 1024
> > =C2=A0	/** @num_syncs: Amount of struct drm_xe_sync in array. */
> > =C2=A0	__u32 num_syncs;
> > =C2=A0
> > --=20
> > 2.43.0
> >=20

