Return-Path: <stable+bounces-176694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DCFB3B982
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 12:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0895DA04E12
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CEA31196B;
	Fri, 29 Aug 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1EoijUg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66992310782
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464942; cv=none; b=es7/HRlxjKjiU1juk9rcA21KhqRfz8jy0KZFIEC7zITXBJqfoya1tG7NQX9KfTlpz0jn267QPBIw6p70UyBLnW7xVOVnEy0yaJOOGLpTRn/67fe3qPp8MaUjRQ1crUuYnBSP9OZT7CT57+U6jLnAOCqYahUsSysM1ZBragK5fAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464942; c=relaxed/simple;
	bh=QAVV+qlxYa6FarCkJYt7ZmOK0iY8jxX+eo476NT3NF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUtb+HqtLrwnAEgwmbHSD3zrzCABcCLLW9eTBOD5GwETk/y2/LA4xzQ3PCgrXisqJbTSe/2mIYvsytMY/183UDWJ5PGCqqHNwC9E+fwrQgyiDPSlPL5MOp1pyBL0mD25ajZpRr+PovhtqX7GI3z5ZN4LGN//ehIiRME6a0JmRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1EoijUg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756464942; x=1788000942;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QAVV+qlxYa6FarCkJYt7ZmOK0iY8jxX+eo476NT3NF4=;
  b=g1EoijUgrbzs2bkSor90Iiosx86CgbOHm4J7kQOypoLRRzsTFzfyhCtk
   0qJuGGwMMsI7dMkt9v1yLvp8pLRbXVFDPUscENrq/cSgtFP98yNH6Eoa2
   xORcrbHeTdsQLCea6eFfMilbdT36jMn1Fxs1b5EUMdh6Kl2jWjWI9MSb5
   r8ZCC/qbpGuweKw9Uu5NjaNu+wDtVXv9eXKhay7BXDfEPDjUJmtFjD4UF
   9A720e7Pk1lAsdRvMSIATfaA4EokNGppLccboDE/oWhpBqvqCp36LZJuX
   lnTkv6TjyeO71hWGc53nld0jF7K5IJK/i3/KwibvLVjTeol92QZkcWAwm
   A==;
X-CSE-ConnectionGUID: snRfzPSkR2id7VzDysRnkA==
X-CSE-MsgGUID: dNgPItWjTfe7QGBoTKRnwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69022813"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69022813"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 03:55:41 -0700
X-CSE-ConnectionGUID: 2yufSrpKTrSE4wBtJVmQ5w==
X-CSE-MsgGUID: cju9cGqWR/WgXB6LXIMdUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169609427"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.245.245.245]) ([10.245.245.245])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 03:55:40 -0700
Message-ID: <692711fadc25a6c85c19ae16e9c04e50f1eaa3a9.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Attempt to bring bos back to VRAM after eviction
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Matthew Auld
	 <matthew.auld@intel.com>, stable@vger.kernel.org
Date: Fri, 29 Aug 2025 12:55:36 +0200
In-Reply-To: <e8a176ab-a24c-4b9d-a046-ae386f08f129@lankhorst.se>
References: <20250828154219.4889-1-thomas.hellstrom@linux.intel.com>
	 <e8a176ab-a24c-4b9d-a046-ae386f08f129@lankhorst.se>
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

On Fri, 2025-08-29 at 09:42 +0200, Maarten Lankhorst wrote:
> Hey,
>=20
> Den 2025-08-28 kl. 17:42, skrev Thomas Hellstr=C3=B6m:
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
> I'd say it this closes a bug in the original driver, although
> effectively v6.8 is no longer supported anyway.
>=20
> Should DESIRED also be set on the add_vram flags?

It looks for me from the TTM code that TTM then *skips* the placement
when doing a second pass with evictions.

So that's not really what we want IMO.

/Thomas

>=20
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.9+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_bo.c | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > b/drivers/gpu/drm/xe/xe_bo.c
> > index 4faf15d5fa6d..64dea4e478bd 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -188,6 +188,8 @@ static void try_add_system(struct xe_device
> > *xe, struct xe_bo *bo,
> > =C2=A0
> > =C2=A0		bo->placements[*c] =3D (struct ttm_place) {
> > =C2=A0			.mem_type =3D XE_PL_TT,
> > +			.flags =3D (IS_DGFX(xe) && (bo_flags &
> > XE_BO_FLAG_VRAM_MASK)) ?
> > +			TTM_PL_FLAG_FALLBACK : 0,
> > =C2=A0		};
> > =C2=A0		*c +=3D 1;
> > =C2=A0	}
>=20
> Kind regards,
> ~Maarten Lankhorst


