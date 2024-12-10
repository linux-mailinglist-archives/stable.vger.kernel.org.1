Return-Path: <stable+bounces-100464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA519EB730
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703511886A90
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C49E233123;
	Tue, 10 Dec 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+yruYJ6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10166231CB1
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849589; cv=none; b=fd6+9VQRRYPxDJeJNAMRKECEeBjH/gFUCG2NxMr3lRCe6it4ric1mpPCXZCs90tqTvUsGogm0ZLYdS5BQ75PYzQxXOelZs8WlbNW9zp+XseT9yiHCfovfyCAVUi2tVvf+LtXN7HHcaaNxro47NZepOL+CXklB13CSoVC7r5qi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849589; c=relaxed/simple;
	bh=WIk4Iro2tyildXYSSYnU/2XCwrn6D/eLNO1HQsq+75E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUPX2qQqTn36x2bHLqRxAFDJreHvlUB7FQ+cXAPVBv60imQSAwxdfJP1tRpmrE122SNSF7jvood3aeIYSZmzqpv2CGDnGXS4FeUU2zbN6Eoy7QsQ5XiCf/In54ZElHeEDkfMAFRA1Lwr9Y9CnPz20Fl1daxMCXnzU4LLBY7dVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+yruYJ6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733849587; x=1765385587;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WIk4Iro2tyildXYSSYnU/2XCwrn6D/eLNO1HQsq+75E=;
  b=U+yruYJ6zo5gByarnbar1TRO8im69RhJiGdmkEQnp7rHO+Dj5gtb1OnQ
   3pLvBi+jiisxxnZLLz1M32eJES+0uAMSVeIHGbNVNODx2/py5N/JhllkE
   pF/AvT+7pVPNi7AIisE0O8QpuZZLWTIiPbvb3ssnk1j66n5zJxMhuqMgE
   /UPH6TqGwtiSXFlYj4OgLDTWdo7RoAeDrJ3+wozVk67M6XzhMc+X4b2fr
   JQJXuBaf1rf2jSkYLCY1V6R3BWQPHenpWPXqO1HGv4H/56DiZYeOwKnFl
   wIjd/MPgAPr1Ch/tHdLUvhjlDb4J8wN5C8PCisWuKCMYbCp//ZQWM+mfT
   g==;
X-CSE-ConnectionGUID: Arnnv2K4SlGmLrf6jVz82w==
X-CSE-MsgGUID: cOytpWjFRaq5rV4daZzbCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45585210"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45585210"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 08:52:24 -0800
X-CSE-ConnectionGUID: vmCkeOXRRJK7XhJp+lwmDA==
X-CSE-MsgGUID: GL3S32auQJm6NkTA0Loa4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="95331898"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO [10.245.246.4]) ([10.245.246.4])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 08:52:22 -0800
Message-ID: <c8353a675abd12bbb71c08b208b62b1882eb4c11.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] drm/xe: Wait for migration job before unmapping
 pages
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, Nirmoy Das
 <nirmoy.das@intel.com>, 	intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Lucas De Marchi
	 <lucas.demarchi@intel.com>, stable@vger.kernel.org
Date: Tue, 10 Dec 2024 17:52:18 +0100
In-Reply-To: <5eb91aa3-6d84-47a9-9f07-1742fe723c41@intel.com>
References: <20241205120253.2015537-1-nirmoy.das@intel.com>
	 <20241205120253.2015537-2-nirmoy.das@intel.com>
	 <5eb91aa3-6d84-47a9-9f07-1742fe723c41@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-05 at 12:40 +0000, Matthew Auld wrote:
> On 05/12/2024 12:02, Nirmoy Das wrote:
> > There could be still migration job going on while doing
> > xe_tt_unmap_sg() which could trigger GPU page faults. Fix this by
> > waiting for the migration job to finish.
> >=20
> > v2: Use intr=3Dfalse(Matt A)
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3466
> > Fixes: 75521e8b56e8 ("drm/xe: Perform dma_map when moving system
> > buffer objects to TT")
> > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.11+
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>=20
> Ok, so this is something like ttm_bo_move_to_ghost() doing a pipeline
> move for tt -> system, but we then do xe_tt_unmap_sg() too early
> which=20
> tears down the IOMMU (if enabled) mappings whilst the job is in
> progress?
>=20
> Maybe add some more info to the commit message? I think this for sure
> fixes it. Just wondering if it's somehow possible to keep the mapping
> until the job is done, since all tt -> sys moves are now synced here?
>=20
> Unless Thomas has a better idea here,

Not at the moment. Ideally we should somehow attach the dma-map to the
ghost object. Perhaps moving forward we could look at attaching it to
the XE_PL_TT resource. Then I believe it will get freed with the ghost
object.

/Thomas


> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>=20
> > ---
> > =C2=A0 drivers/gpu/drm/xe/xe_bo.c | 10 +++++++++-
> > =C2=A0 1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > b/drivers/gpu/drm/xe/xe_bo.c
> > index b2aa368a23f8..c906a5529db0 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -857,8 +857,16 @@ static int xe_bo_move(struct ttm_buffer_object
> > *ttm_bo, bool evict,
> > =C2=A0=20
> > =C2=A0 out:
> > =C2=A0=C2=A0	if ((!ttm_bo->resource || ttm_bo->resource->mem_type =3D=
=3D
> > XE_PL_SYSTEM) &&
> > -	=C2=A0=C2=A0=C2=A0 ttm_bo->ttm)
> > +	=C2=A0=C2=A0=C2=A0 ttm_bo->ttm) {
> > +		long timeout =3D dma_resv_wait_timeout(ttm_bo-
> > >base.resv,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0
> > DMA_RESV_USAGE_BOOKKEEP,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0 false,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0
> > MAX_SCHEDULE_TIMEOUT);
> > +		if (timeout < 0)
> > +			ret =3D timeout;
> > +
> > =C2=A0=C2=A0		xe_tt_unmap_sg(ttm_bo->ttm);
> > +	}
> > =C2=A0=20
> > =C2=A0=C2=A0	return ret;
> > =C2=A0 }
>=20


