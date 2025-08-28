Return-Path: <stable+bounces-176635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B69B3A4C6
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E1C188B7C7
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818482405EC;
	Thu, 28 Aug 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNBLN1bw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8EB1C5499
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395878; cv=none; b=Yymz5/Ue49kxGmkqENxTY6IihfG0Nj4doVdi53p9VInWSDn4XWQFPWBrkVc20lAtwTEyQYFRbuVKz7vQxEVkMFQjCq2JksPS1spqgDCeoxT2VlzdqG6/2zDuSReUG+/HAf7guUX3TLcMlno1mmyHidNp1SYcn/bTthkXUXkAhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395878; c=relaxed/simple;
	bh=O+yydBuKm1Fd0N3P6BjNhLeGzacYgQVX9NdpaShooEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sx3/yLfiyy6bFGwGXryALgznGvOCb6jt5HDOAilCg1YdGR6/3NtWzgIdYq2AP+O9u2CbhdHYyVlOzbWBfa10gp5SUHZs/nkh+i7z00kOWrvoqLZAk4ZzC9Y+Jm30RhxegHNOttbRNZKVxwGXtLEEnVnThdq0ycweVKoSxjdtUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNBLN1bw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756395877; x=1787931877;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=O+yydBuKm1Fd0N3P6BjNhLeGzacYgQVX9NdpaShooEU=;
  b=JNBLN1bwDv76qJVSsDqWiG9LgDFB/M15NJxVBJ7Ycw02vxMcLyl1HbQg
   NOtQO/nt8MAcfnCd7joCrFJE4A7NbsG8xYUKQ/vFsWKJAvQORgvmM98ZG
   2fAXlvj2E5OGvjXijRFcecWQkZHHkR5qjgKycpqmRuUMgusYQl092g7Eo
   l6K69aJgCeoT1Q2hjrmnAsLwwmClvpGz/c2OWBR48gMekAauKOiLMifcv
   o3M68+nMeS3D/RoO2wTHuW89l/kkmiC7WFA8ar86/eDe0+j2RL8K8K43V
   h5zO/aJ+NhshbZtYtXiQDaZitBpOrrR24LGfXYX8ZlwIk2f0KxX4G7LG/
   A==;
X-CSE-ConnectionGUID: JIHDmAUsR9iFJvLMCvVQtw==
X-CSE-MsgGUID: q/B3iXGBTm6CEQtLuB5I3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="57697632"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="57697632"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:44:29 -0700
X-CSE-ConnectionGUID: W+gkkQpqRiaadBs/xqX28w==
X-CSE-MsgGUID: l73EgjrdQCGrEjoZaY0BOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="193803732"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.28]) ([10.245.245.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:44:27 -0700
Message-ID: <5fbba50f6513bb24636b0adc72317104ba92c96b.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Fix incorrect migration of backed-up object to
 VRAM
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Thu, 28 Aug 2025 17:44:25 +0200
In-Reply-To: <5d0e5447-f264-4574-a368-0891aa93ae15@intel.com>
References: <20250828134837.5709-1-thomas.hellstrom@linux.intel.com>
	 <5d0e5447-f264-4574-a368-0891aa93ae15@intel.com>
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

Hi, Matthew

On Thu, 2025-08-28 at 15:00 +0100, Matthew Auld wrote:
> On 28/08/2025 14:48, Thomas Hellstr=C3=B6m wrote:
> > If an object is backed up to shmem it is incorrectly identified
> > as not having valid data by the move code. This means moving
> > to VRAM skips the -EMULTIHOP step and the bo is cleared. This
> > causes all sorts of weird behaviour on DGFX if an already evicted
> > object is targeted by the shrinker.
> >=20
> > Fix this by using ttm_tt_is_swapped() to identify backed-up
> > objects.
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5996
> > Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.15+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>=20
> I guess we are missing some test coverage here?

Indeed. A bit embarrassing this has gone unnoticed for so long.

>=20
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Thanks for reviewing!
/Thomas

>=20
> > ---
> > =C2=A0 drivers/gpu/drm/xe/xe_bo.c | 3 +--
> > =C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > b/drivers/gpu/drm/xe/xe_bo.c
> > index 7d1ff642b02a..4faf15d5fa6d 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -823,8 +823,7 @@ static int xe_bo_move(struct ttm_buffer_object
> > *ttm_bo, bool evict,
> > =C2=A0=C2=A0		return ret;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	tt_has_data =3D ttm && (ttm_tt_is_populated(ttm) ||
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ttm->page_flags &
> > TTM_TT_FLAG_SWAPPED));
> > +	tt_has_data =3D ttm && (ttm_tt_is_populated(ttm) ||
> > ttm_tt_is_swapped(ttm));
> > =C2=A0=20
> > =C2=A0=C2=A0	move_lacks_source =3D !old_mem || (handle_system_ccs ? (!b=
o-
> > >ccs_cleared) :
> > =C2=A0=C2=A0				=09
> > (!mem_type_is_vram(old_mem_type) && !tt_has_data));
>=20


