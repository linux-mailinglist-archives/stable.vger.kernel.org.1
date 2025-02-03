Return-Path: <stable+bounces-111994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6D2A255A4
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 10:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E17B1885533
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984AE1FF1C8;
	Mon,  3 Feb 2025 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOoTZBfx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F13D1FF1B8;
	Mon,  3 Feb 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574294; cv=none; b=KxkyEqyRafEfe5tDeqXXi11X1lvXR0bmGhrvYXSgfCEKpvg4+m8yJiqniA82HA8v+/QUvChHaknlcf9GtuMruftUqNi9WDv4Y6WXzNrd3CnP/QFPYC21VAKLPdZLIhHaaJPOyBTey0zCxtwL1s3WkrQ7B/dag4riHYf5hWhvASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574294; c=relaxed/simple;
	bh=LeDxk3GdElx0h1hmNE3mkx//OoXEKB3JfAMARmAPesA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7aMsrK9OsOuVe/ImjN+kf3qnDQts+ZfVQm6R5EyK05fLo0sA++nDwmJvDFAGxkOD/HypaABucUzZ/+1M8S+UUCSvQ6RLZL3WPb6gwFYjes3oaxa+suxThI99lQ93vytkY1gsoljRPvVsAseZCBu6gaLKEqJCU67YvvynDsb1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOoTZBfx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738574293; x=1770110293;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LeDxk3GdElx0h1hmNE3mkx//OoXEKB3JfAMARmAPesA=;
  b=MOoTZBfx+ogRLr6saAZ51wCDMw1rYodrN5C/H5ck485IqNgq13/hSrPP
   qXdD/plrkn0kFQSUwBczFAPRxf75Wp/7/eX1vfGW6NwWWz0bF7NtevGnU
   tPxjXWzkDYVPly+6B2ByiEzIkx/iZuCWFNsDmOIsL4aguM2SYQ/MP06jW
   AuCNv47wOSRHIUhdSmBQq3YVDoTQNY3IWJ9ZSfIPId9zr7mXp9BveCDdh
   wFm6G7/ONlPjl0lKHGc9XGsuYwYPvbZTknwiN/m2NDcgB6Va582QDN+DU
   Tg5KAMmQYB27gatcqQmBiGxfUFCXIGc3tLxTRIGSp6ZBTuxPMhPnLNVJL
   Q==;
X-CSE-ConnectionGUID: yIQs0RH7TVi0vsk/Ru6LaQ==
X-CSE-MsgGUID: ZZWpFV50QV6Kt58gt0TOiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="39322917"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="39322917"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:18:12 -0800
X-CSE-ConnectionGUID: 7EFFvEnoT22ax7aPNxgaeQ==
X-CSE-MsgGUID: MiyUg1wmTZSvkm/+VciwTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147436913"
Received: from dprybysh-mobl.ger.corp.intel.com (HELO [10.245.246.61]) ([10.245.246.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:18:09 -0800
Message-ID: <d6905f85cbd89ad0499d4ea3d856cb95977c88c4.camel@linux.intel.com>
Subject: Re: Patch "drm/xe: Use ttm_bo_access in
 xe_vm_snapshot_capture_delayed" has been added to the 6.12-stable tree
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	matthew.brost@intel.com
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Rodrigo Vivi	
 <rodrigo.vivi@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Date: Mon, 03 Feb 2025 10:18:06 +0100
In-Reply-To: <20250202043335.1912989-1-sashal@kernel.org>
References: <20250202043335.1912989-1-sashal@kernel.org>
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

Hi

On Sat, 2025-02-01 at 23:33 -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
> =C2=A0=C2=A0=C2=A0 drm/xe: Use ttm_bo_access in xe_vm_snapshot_capture_de=
layed
>=20
> to the 6.12-stable tree which can be found at:
> =C2=A0=C2=A0=C2=A0
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.git;a=
=3Dsummary
>=20
> The filename of the patch is:
> =C2=A0=C2=A0=C2=A0=C2=A0 drm-xe-use-ttm_bo_access-in-xe_vm_snapshot_captu=
re_d.patch
> and it can be found in the queue-6.12 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable
> tree,
> please let <stable@vger.kernel.org> know about it.

Please avoid including this patch for now. It turned out it needs more
dependencies and we will attempt a manual backport later.

Thanks,
Thomas


>=20
>=20
>=20
> commit 7aad4e92ca3782686571792d117b3ffcfe05c65c
> Author: Matthew Brost <matthew.brost@intel.com>
> Date:=C2=A0=C2=A0 Tue Nov 26 09:46:13 2024 -0800
>=20
> =C2=A0=C2=A0=C2=A0 drm/xe: Use ttm_bo_access in xe_vm_snapshot_capture_de=
layed
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 [ Upstream commit 5f7bec831f1f17c354e4307a12cf79b01829=
6975 ]
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Non-contiguous mapping of BO in VRAM doesn't work, use
> ttm_bo_access
> =C2=A0=C2=A0=C2=A0 instead.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 v2:
> =C2=A0=C2=A0=C2=A0=C2=A0 - Fix error handling
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Fixes: 0eb2a18a8fad ("drm/xe: Implement VM snapshot su=
pport for
> BO's and userptr")
> =C2=A0=C2=A0=C2=A0 Suggested-by: Matthew Auld <matthew.auld@intel.com>
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> =C2=A0=C2=A0=C2=A0 Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> =C2=A0=C2=A0=C2=A0 Link:
> https://patchwork.freedesktop.org/patch/msgid/20241126174615.2665852-7-ma=
tthew.brost@intel.com
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index c99380271de62..c8782da3a5c38 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3303,7 +3303,6 @@ void xe_vm_snapshot_capture_delayed(struct
> xe_vm_snapshot *snap)
> =C2=A0
> =C2=A0	for (int i =3D 0; i < snap->num_snaps; i++) {
> =C2=A0		struct xe_bo *bo =3D snap->snap[i].bo;
> -		struct iosys_map src;
> =C2=A0		int err;
> =C2=A0
> =C2=A0		if (IS_ERR(snap->snap[i].data))
> @@ -3316,16 +3315,12 @@ void xe_vm_snapshot_capture_delayed(struct
> xe_vm_snapshot *snap)
> =C2=A0		}
> =C2=A0
> =C2=A0		if (bo) {
> -			xe_bo_lock(bo, false);
> -			err =3D ttm_bo_vmap(&bo->ttm, &src);
> -			if (!err) {
> -				xe_map_memcpy_from(xe_bo_device(bo),
> -						=C2=A0=C2=A0 snap-
> >snap[i].data,
> -						=C2=A0=C2=A0 &src, snap-
> >snap[i].bo_ofs,
> -						=C2=A0=C2=A0 snap-
> >snap[i].len);
> -				ttm_bo_vunmap(&bo->ttm, &src);
> -			}
> -			xe_bo_unlock(bo);
> +			err =3D ttm_bo_access(&bo->ttm, snap-
> >snap[i].bo_ofs,
> +					=C2=A0=C2=A0=C2=A0 snap->snap[i].data,
> snap->snap[i].len, 0);
> +			if (!(err < 0) && err !=3D snap->snap[i].len)
> +				err =3D -EIO;
> +			else if (!(err < 0))
> +				err =3D 0;
> =C2=A0		} else {
> =C2=A0			void __user *userptr =3D (void __user
> *)(size_t)snap->snap[i].bo_ofs;
> =C2=A0


