Return-Path: <stable+bounces-180514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E0B84659
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 13:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B636D1895AC6
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 11:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAB527AC57;
	Thu, 18 Sep 2025 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4RrmCo3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2A288C3B
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195925; cv=none; b=hEWbC2TboshUu6MmgUHhSBmQ8JNbxyfqk0X693aGyR0e4qP9KQIpT63c1BhB/UOTnVp4F9bKB+Gro7L3x7M/PbcmLfWK0TBYIFCBr8tyUC6NLSemd8DOvk6JCVWRvpNSAWzD+e8WV6DWAuad5Km4eyX6ZAo4+pnXAaxMdNk7cGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195925; c=relaxed/simple;
	bh=A6VSV03jrEtv8DOPEpYnWvS/Cy6NLLBWQXB7I6UuUdU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RlpaM6qEuTvj1tAoV15VB/rg3FMNVUA2mpW1mc0qULx9ztfk/gFIamNIqpiB5Fp3Cq4gzK3kBLwFo/3bE4NU3fc0A5jQC4SccuucGDRFFN/EUI8bXZBsiEkWf90Wblr+TV4QHo8LUlEGXfZOlofrhtce91/YgE+7t7MP7+SiW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4RrmCo3; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758195924; x=1789731924;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A6VSV03jrEtv8DOPEpYnWvS/Cy6NLLBWQXB7I6UuUdU=;
  b=g4RrmCo3DjsYUvradkBTukL14Lif13uh9JlpsEIOdAeHJC7GTrd4l97r
   laiskaCgw8PcmXkhmwIvFI3Iz2Ena59N1Q/32wobaVjaS6QtAn3Vd9im+
   BF08SRnnDkxH0TUmLMuWZXyyb4nIcNeY43+Z/lvy9aGNTRjOT5mjfdP6G
   CVDZOak0bVbr0y4gRevPIzGzniiMH+y4Aj9mWxqtnfhxwd/ngNx2w/IHC
   /aolR/TB1ABm98ps9Pi2GtPsdxK8yBnSehK6FxQRiaLmKGIjv5up5zfdR
   e6UWzkVJl0S9OdvFF8dU8tJYNYlUpmpgg0HWcXZHPoCLFArPTzrhrLlS1
   Q==;
X-CSE-ConnectionGUID: G2y7q6rSQLGwWHRcKkdIHQ==
X-CSE-MsgGUID: ybR2PxgXRKC0N6rxUo+06w==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="59740679"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="59740679"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 04:45:23 -0700
X-CSE-ConnectionGUID: iG8WT1yZRwe0ILVsPVRjTA==
X-CSE-MsgGUID: 3J435FVeQD+GErm57gx4cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="179932014"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.224])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 04:45:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Sep 2025 14:45:17 +0300 (EEST)
To: Lucas De Marchi <lucas.demarchi@intel.com>
cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Release BAR0 of an integrated bridge to allow
 GPU BAR resize
In-Reply-To: <20250917-xe-pci-rebar-2-v1-1-005daa7c19be@intel.com>
Message-ID: <b460e7bd-4496-14c0-87ad-6b14639bff0a@linux.intel.com>
References: <20250917-xe-pci-rebar-2-v1-0-005daa7c19be@intel.com> <20250917-xe-pci-rebar-2-v1-1-005daa7c19be@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-567907475-1758195917=:949"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-567907475-1758195917=:949
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Sep 2025, Lucas De Marchi wrote:

> From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Resizing BAR to a larger size has to release upstream bridge windows in
> order make the bridge windows larger as well (and to potential relocate
> them into a larger free block within iomem space). Some GPUs have an
> integrated PCI switch that has BAR0. The resource allocation assigns
> space for that BAR0 as it does for any resource.
>=20
> An extra resource on a bridge will pin its upstream bridge window in
> place which prevents BAR resize for anything beneath that bridge.
>=20
> Nothing in the pcieport driver provided by PCI core, which typically is
> the driver bound to these bridges, requires that BAR0. Because of that,
> releasing the extra BAR does not seem to have notable downsides but
> comes with a clear upside.
>=20
> Therefore, release BAR0 of such switches using a quirk and clear its
> flags to prevent any new invocation of the resource assignment
> algorithm from assigning the resource again.
>=20
> Due to other siblings within the PCI hierarchy of all the devices
> integrated into the GPU, some other devices may still have to be
> manually removed before the resize is free of any bridge window pins.
> Such siblings can be released through sysfs to unpin windows while
> leaving access to GPU's sysfs entries required for initiating the
> resize operation, whereas removing the topmost bridge this quirk
> targets would result in removing the GPU device as well so no manual
> workaround for this problem exists.
>=20
> Reported-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # 6.12+
> Link: https://lore.kernel.org/linux-pci/fl6tx5ztvttg7txmz2ps7oyd745wg3lwc=
p3h7esmvnyg26n44y@owo2ojiu2mov/
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/pci/quirks.c | 20 ++++++++++++++++++++

Please include all relevant people into submissions. You've left all PCI=20
receipients out (except me).

I also recommend you leave that part I put under --- line into the=20
submission as it explain my position on why I think it's reasonable=20
interim solution as we don't expect it more complicated solution to be=20
something we wnat to push into older kernels (perhaps mark it as=20
"Remarks from Ilpo:" or something along those lines so it doesn't get=20
misattributed to you).

--=20
 i.

>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d97335a401930..98a4f0a1285be 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6338,3 +6338,23 @@ static void pci_mask_replay_timer_timeout(struct p=
ci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer=
_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer=
_timeout);
>  #endif
> +
> +/*
> + * PCI switches integrated into some GPUs have BAR0 that prevents resizi=
ng
> + * the BARs of the GPU device due to that bridge BAR0 pinning the bridge
> + * window it's under in place. Nothing in pcieport requires that BAR0.
> + *
> + * Release and disable BAR0 permanently by clearing its flags to prevent
> + * anything from assigning it again.
> + */
> +static void pci_release_bar0(struct pci_dev *pdev)
> +{
> +=09struct resource *res =3D pci_resource_n(pdev, 0);
> +
> +=09if (!res->parent)
> +=09=09return;
> +
> +=09pci_release_resource(pdev, 0);
> +=09res->flags =3D 0;
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL, 0xe2ff, pci_release_bar0);
>=20
>=20
--8323328-567907475-1758195917=:949--

