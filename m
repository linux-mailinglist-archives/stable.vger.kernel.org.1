Return-Path: <stable+bounces-176637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1AB3A59C
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AFB3BC697
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A6426B973;
	Thu, 28 Aug 2025 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRJ6xhBd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE926A0B3
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397208; cv=none; b=VeW/4WeejifftNWGuKquenlU6wyy/92SepbQB06FkkbKcAg+9oZ/uz+ISUmBpQ15oMrfWj+U3RULP/T4ezrXUDU7cAvRWFl9r4wxHc6HGfskcn1WAUBr3nKhmetZkcoljirIt9OaJVXFib5/fp0wmWJliCXK61Ns36I/5+MuzX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397208; c=relaxed/simple;
	bh=dveMrBkd/Q3I42a/7cYhPeRQELrk/izizBc0HDZ0d5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZSGlI2slZef/eFFV+/segiLxQcMrzzFjs0PrhK0hghtGqfgnlp4idP+jy3izDiPKWvrSCK+x9Yu9TZZXIfBzOPrdf7wvloVcMSeR0C57aOQ/xyn2L9Jf5byVAeAmYORydJCCYGIYc/k4Ropk9PagFT1cxiWm4eNYMvyRTMWmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRJ6xhBd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756397206; x=1787933206;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dveMrBkd/Q3I42a/7cYhPeRQELrk/izizBc0HDZ0d5E=;
  b=PRJ6xhBd6KymB+hQecuyTPMEWhT0iNOWMUV4pR0mcrfOIeMq9kOSnI4X
   Lf6eLTkeSIJk9PPwtLRjTg9Zeanxl+gEj+DnFoKPhjZ/CqmSAcUOsH9QO
   pGrq8SZEoLyv6/cWlEpfDNfCYE95DQPAtp8AQ0YPAXEBXBt5MvqQrbHXt
   XO0TH+yQ6qYIGD36Gdgd0KG+VgSZBG3r4oIZYSuUvZd4YpEZCojJ34ZJw
   1SQ48i8szTfThhlqda66LWoGeYUMr4fhrEcGWdQ2Dh3zy8rhOIz3EgKRd
   c2jG3QZSlwTJbUWesir+hKF8lpS97/q+7QBPGR9CFOKhMzWavlHC8w2OM
   Q==;
X-CSE-ConnectionGUID: 6J8hKkjwRIKzdrAIbijU9A==
X-CSE-MsgGUID: InYBBFLWQ9SBb8d13BM45Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="57701959"
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="57701959"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:06:46 -0700
X-CSE-ConnectionGUID: NCKwXRPDQo6m3IEvxNfeUg==
X-CSE-MsgGUID: BzbfepCJTNGmQyKNbnUQYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="193814018"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.28]) ([10.245.245.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:06:44 -0700
Message-ID: <ba4a969ad501922974c796e354292b7d5451dac4.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Attempt to bring bos back to VRAM after eviction
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Thu, 28 Aug 2025 18:06:42 +0200
In-Reply-To: <8621165a-68d0-467b-8fe5-c28b500c0d5e@intel.com>
References: <20250828154219.4889-1-thomas.hellstrom@linux.intel.com>
	 <8621165a-68d0-467b-8fe5-c28b500c0d5e@intel.com>
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

Hi,

On Thu, 2025-08-28 at 16:59 +0100, Matthew Auld wrote:
> On 28/08/2025 16:42, Thomas Hellstr=C3=B6m wrote:
> > VRAM+TT bos that are evicted from VRAM to TT may remain in
> > TT also after a revalidation following eviction or suspend.
> >=20
> > This manifests itself as applications becoming sluggish
> > after buffer objects get evicted or after a resume from
> > suspend or hibernation.
> >=20
> > If the bo supports placement in both VRAM and TT, and
> > we are on DGFX, mark the TT placement as fallback. This means
> > that it is tried only after VRAM + eviction.
> >=20
> > This flaw has probably been present since the xe module was
> > upstreamed but use a Fixes: commit below where backporting is
> > likely to be simple. For earlier versions we need to open-
> > code the fallback algorithm in the driver.
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5995
> > Fixes: a78a8da51b36 ("drm/ttm: replace busy placement with flags
> > v6")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.9+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0 drivers/gpu/drm/xe/xe_bo.c | 2 ++
> > =C2=A0 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > b/drivers/gpu/drm/xe/xe_bo.c
> > index 4faf15d5fa6d..64dea4e478bd 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -188,6 +188,8 @@ static void try_add_system(struct xe_device
> > *xe, struct xe_bo *bo,
> > =C2=A0=20
> > =C2=A0=C2=A0		bo->placements[*c] =3D (struct ttm_place) {
> > =C2=A0=C2=A0			.mem_type =3D XE_PL_TT,
> > +			.flags =3D (IS_DGFX(xe) && (bo_flags &
> > XE_BO_FLAG_VRAM_MASK)) ?
>=20
> I suppose we could drop the dgfx check here?

Thanks for reviewing. From a quick look it looks like the VRAM_MASK
bits can be set also on IGFX? And if so, then it's not ideal to mark
the primary placement as FALLBACK. But I might have missed a rejection
somewhere.

/Thomas


>=20
> Either way,
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>=20
> > +			TTM_PL_FLAG_FALLBACK : 0,
> > =C2=A0=C2=A0		};
> > =C2=A0=C2=A0		*c +=3D 1;
> > =C2=A0=C2=A0	}
>=20


