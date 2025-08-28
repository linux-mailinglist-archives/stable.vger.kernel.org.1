Return-Path: <stable+bounces-176657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAC2B3A992
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 20:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7B37ACB26
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E6262FE9;
	Thu, 28 Aug 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OD56xEHR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0223FE5F
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404407; cv=none; b=GRPEyP/KdFEpOcCQvhJHFpxdgM//fg+xWJGUk1Wo7ISKRKVCpxnTMjNRWtvZ3jnfWnAKMbBWhf5EeVllUWqqTNklZTG/snTy8NFn1YfHGA9mjzoulrpzsUpwWheuii3n5OLOuF4E/ENUUtSFyWjRPPvHlTM27hJPC0SKtlvtv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404407; c=relaxed/simple;
	bh=QoiZX/xf3mT6/HRGYhUNNwVMS8EfKuENe7mjXc4N31s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BF7yCP19//e89ColIbY02cp+2mqujEaONHZEOUv9HOnbRmenXn49OGX8b8VpgTthTdLJbq+lzosiAkAOZkYy5RV3GOLc3gr6i8BG3aLdYmwaOLRAmZ32WLd4OqUGOC7IAh1llg9fTm1LEKHsx5Xysn08eMDc9nguJAGoZlHXQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OD56xEHR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756404406; x=1787940406;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QoiZX/xf3mT6/HRGYhUNNwVMS8EfKuENe7mjXc4N31s=;
  b=OD56xEHRc1P+hw9R4SAHqAICB8cIceJ5oWL4y4i2+jXF+p9ccUNXfV29
   5aw2MrJ1KfIDW6MSSTW+fmy4hVLekVFuM25TpNgFYzrxHpjBs3vwx3qVA
   qv1JtL0NLilURmLcpUeWig+jnzU+FToldYjZy2i7KQ2EMlROKfahvf0z+
   CA/Ne0sitmkgL+Ri54ZY5xArqf0n6SULqyzAUgscd/2fF/9M1egsHxQzo
   WIzDbTPudRczVhIDrvAtNwYE8II6CcBh1ciIiwWhOug4k48Fg+ukZLvpA
   wPPcy4W8issTOi5PN2zqYzt00e1v2Pmj7FhEV1DRKMcIx1TTIwk9gkICq
   w==;
X-CSE-ConnectionGUID: pbpEpTPST1eC+1X15U4kfw==
X-CSE-MsgGUID: gGYkgEOvQQWthkOP0WSN0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69781405"
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="69781405"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 11:06:45 -0700
X-CSE-ConnectionGUID: M1clbVyVQ8iuexmAmrd7DQ==
X-CSE-MsgGUID: ojFJAu1eQi+p0OEE7HNrbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="169764895"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.28]) ([10.245.245.28])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 11:06:44 -0700
Message-ID: <5a996647f06988745f62bdb6b510342a3d9e4a8c.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Attempt to bring bos back to VRAM after eviction
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Thu, 28 Aug 2025 20:06:41 +0200
In-Reply-To: <45c42d43-658e-452f-8aeb-e7a32f4838b2@intel.com>
References: <20250828154219.4889-1-thomas.hellstrom@linux.intel.com>
	 <8621165a-68d0-467b-8fe5-c28b500c0d5e@intel.com>
	 <ba4a969ad501922974c796e354292b7d5451dac4.camel@linux.intel.com>
	 <45c42d43-658e-452f-8aeb-e7a32f4838b2@intel.com>
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

On Thu, 2025-08-28 at 17:27 +0100, Matthew Auld wrote:
> On 28/08/2025 17:06, Thomas Hellstr=C3=B6m wrote:
> > Hi,
> >=20
> > On Thu, 2025-08-28 at 16:59 +0100, Matthew Auld wrote:
> > > On 28/08/2025 16:42, Thomas Hellstr=C3=B6m wrote:
> > > > VRAM+TT bos that are evicted from VRAM to TT may remain in
> > > > TT also after a revalidation following eviction or suspend.
> > > >=20
> > > > This manifests itself as applications becoming sluggish
> > > > after buffer objects get evicted or after a resume from
> > > > suspend or hibernation.
> > > >=20
> > > > If the bo supports placement in both VRAM and TT, and
> > > > we are on DGFX, mark the TT placement as fallback. This means
> > > > that it is tried only after VRAM + eviction.
> > > >=20
> > > > This flaw has probably been present since the xe module was
> > > > upstreamed but use a Fixes: commit below where backporting is
> > > > likely to be simple. For earlier versions we need to open-
> > > > code the fallback algorithm in the driver.
> > > >=20
> > > > Closes:
> > > > https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5995
> > > > Fixes: a78a8da51b36 ("drm/ttm: replace busy placement with
> > > > flags
> > > > v6")
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: <stable@vger.kernel.org> # v6.9+
> > > > Signed-off-by: Thomas Hellstr=C3=B6m
> > > > <thomas.hellstrom@linux.intel.com>
> > > > ---
> > > > =C2=A0=C2=A0 drivers/gpu/drm/xe/xe_bo.c | 2 ++
> > > > =C2=A0=C2=A0 1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > > > b/drivers/gpu/drm/xe/xe_bo.c
> > > > index 4faf15d5fa6d..64dea4e478bd 100644
> > > > --- a/drivers/gpu/drm/xe/xe_bo.c
> > > > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > > > @@ -188,6 +188,8 @@ static void try_add_system(struct xe_device
> > > > *xe, struct xe_bo *bo,
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0		bo->placements[*c] =3D (struct ttm_place) {
> > > > =C2=A0=C2=A0=C2=A0			.mem_type =3D XE_PL_TT,
> > > > +			.flags =3D (IS_DGFX(xe) && (bo_flags &
> > > > XE_BO_FLAG_VRAM_MASK)) ?
> > >=20
> > > I suppose we could drop the dgfx check here?
> >=20
> > Thanks for reviewing. From a quick look it looks like the VRAM_MASK
> > bits can be set also on IGFX? And if so, then it's not ideal to
> > mark
> > the primary placement as FALLBACK. But I might have missed a
> > rejection
> > somewhere.
>=20
> I was sweating bullets for a second there, but it looks like it gets=20
> rejected in the ioctl with:
>=20
> if (XE_IOCTL_DBG(xe, (args->placement & ~xe->info.mem_region_mask)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>=20
> The flags get converted from the args->placement, and VRAM should
> never=20
> appear in the mem_region_mask on igpu. If we allowed it I think it
> would=20
> crash in add_vram() since the vram manager does not exist so=20
> ttm_manager_type() would be NULL, AFAICT.

Thanks. Right, I'll spin a v2 and drop the IS_DGFX() test.

/Thomas


>=20
> >=20
> > /Thomas
> >=20
> >=20
> > >=20
> > > Either way,
> > > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> > >=20
> > > > +			TTM_PL_FLAG_FALLBACK : 0,
> > > > =C2=A0=C2=A0=C2=A0		};
> > > > =C2=A0=C2=A0=C2=A0		*c +=3D 1;
> > > > =C2=A0=C2=A0=C2=A0	}
> > >=20
> >=20
>=20


