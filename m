Return-Path: <stable+bounces-180509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229C4B843AD
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 12:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFC8189C855
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A827F16A;
	Thu, 18 Sep 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKlwOYJG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867D18A6DB
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192692; cv=none; b=mwdForIKEJOsp82d00fPOxEeaLUOcJooZKWnyBHejx4L4p66CmJyeOj1Magrko+h+cIglNZTUvaA7ttYCGk4oFWPuWjjVcRBhYvGEQYNRwv3cxCJCgoOhVXj+7QasWxkBQCjqt5WacaUvCvWoOJG8QvF42+lfDSULzppLa+5xgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192692; c=relaxed/simple;
	bh=WzD1ScO87HQCp5B0da+mgHc20ETzwZ1jaMtuiJ0aVjE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B+yq1jKV34/2xgRFjoeFV0f5wOXW9y+R//SnWy1ur/KQlqSLZK8lg37t7g4z8dKTk8gFmSSHD3f3FBqV3ipQ1ZvZ8yQA8TmdHxAX4Qcb0uQktyFF0DHqnxGrFG+lLylXFri0gMwHhyc0W8IRsfo5lFTQrssf1QZmvggCygoQx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKlwOYJG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758192689; x=1789728689;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WzD1ScO87HQCp5B0da+mgHc20ETzwZ1jaMtuiJ0aVjE=;
  b=OKlwOYJGXXh3kpLEub06PHNVe6CWbiGunu8Lpj/CVhzrdvzDsWf+ytiZ
   4GhAGGovZbDePu3MTwdQeueLbbs85BQ1bb7Ng5+hRht7n6YhftLsoa6Lu
   EHgd0u7c77pwOoGeTUZf+6BgP38Kr6EY+NFtiF8p5mwKCBWsoJCcAH1zx
   V6PIJZ5bW7V5Jc8FLgpeJBjgCreCwFhMphqJQXgsrCGumM7E0WxQI+BIG
   2ESUvYoylZ9NSfxNgim0CA2xMO40IOALnSh/MA8Z9mcIEUMU3TWc5ewnx
   xdSwi0VxKlLgseAifcO6b4sHHxGRJscB6Hqkp4iXSvPJXsjqkR+ohIFqD
   g==;
X-CSE-ConnectionGUID: pnKHYChQRaGKd8zUnoCZpw==
X-CSE-MsgGUID: M8Yj+Q2ATPKmmy92/4Nr4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64321957"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64321957"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 03:51:28 -0700
X-CSE-ConnectionGUID: nKw6eNYoTJamaj8n24LdFw==
X-CSE-MsgGUID: Z1002ZToTBSSl62jRZ0OaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175917131"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.224])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 03:51:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Sep 2025 13:51:23 +0300 (EEST)
To: Lucas De Marchi <lucas.demarchi@intel.com>
cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/xe: Move rebar to be done earlier
In-Reply-To: <20250917-xe-pci-rebar-2-v1-2-005daa7c19be@intel.com>
Message-ID: <e8d38f75-f141-25e2-f174-78ea33b83fb0@linux.intel.com>
References: <20250917-xe-pci-rebar-2-v1-0-005daa7c19be@intel.com> <20250917-xe-pci-rebar-2-v1-2-005daa7c19be@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-321119205-1758189809=:949"
Content-ID: <1e2ee6a5-19f0-d302-c362-77b4a39d9695@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-321119205-1758189809=:949
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <110f7f44-c7be-f497-58da-56c2d49adcf2@linux.intel.com>

On Wed, 17 Sep 2025, Lucas De Marchi wrote:

> There may be cases in which the BAR0 also needs to move to accommodate
> the bigger BAR2. However if it's not released, the BAR2 resize fails.
> During the vram probe it can't be released as it's already in use by
> xe_mmio for early register access.
>=20
> Add a new function in xe_vram and let xe_pci call it directly before
> even early device probe. This allows the BAR2 to resize in cases BAR0
> also needs to move:
>=20
> =09[] xe 0000:03:00.0: vgaarb: deactivate vga console
> =09[] xe 0000:03:00.0: [drm] Attempting to resize bar from 8192MiB -> 163=
84MiB
> =09[] xe 0000:03:00.0: BAR 0 [mem 0x83000000-0x83ffffff 64bit]: releasing
> =09[] xe 0000:03:00.0: BAR 2 [mem 0x4000000000-0x41ffffffff 64bit pref]: =
releasing
> =09[] pcieport 0000:02:01.0: bridge window [mem 0x4000000000-0x41ffffffff=
 64bit pref]: releasing
> =09[] pcieport 0000:01:00.0: bridge window [mem 0x4000000000-0x41ffffffff=
 64bit pref]: releasing
> =09[] pcieport 0000:01:00.0: bridge window [mem 0x4000000000-0x43ffffffff=
 64bit pref]: assigned
> =09[] pcieport 0000:02:01.0: bridge window [mem 0x4000000000-0x43ffffffff=
 64bit pref]: assigned
> =09[] xe 0000:03:00.0: BAR 2 [mem 0x4000000000-0x43ffffffff 64bit pref]: =
assigned
> =09[] xe 0000:03:00.0: BAR 0 [mem 0x83000000-0x83ffffff 64bit]: assigned
> =09[] pcieport 0000:00:01.0: PCI bridge to [bus 01-04]
> =09[] pcieport 0000:00:01.0:   bridge window [mem 0x83000000-0x840fffff]
> =09[] pcieport 0000:00:01.0:   bridge window [mem 0x4000000000-0x44007fff=
ff 64bit pref]
> =09[] pcieport 0000:01:00.0: PCI bridge to [bus 02-04]
> =09[] pcieport 0000:01:00.0:   bridge window [mem 0x83000000-0x840fffff]
> =09[] pcieport 0000:01:00.0:   bridge window [mem 0x4000000000-0x43ffffff=
ff 64bit pref]
> =09[] pcieport 0000:02:01.0: PCI bridge to [bus 03]
> =09[] pcieport 0000:02:01.0:   bridge window [mem 0x83000000-0x83ffffff]
> =09[] pcieport 0000:02:01.0:   bridge window [mem 0x4000000000-0x43ffffff=
ff 64bit pref]
> =09[] xe 0000:03:00.0: [drm] BAR2 resized to 16384M
> =09[] xe 0000:03:00.0: [drm:xe_pci_probe [xe]] BATTLEMAGE  e221:0000 dgfx=
:1 gfx:Xe2_HPG (20.02) ...
>=20
> As shown above, it happens even before we try to read any register for
> platform identification.
>=20
> All the rebar logic is more pci-specific than xe-specific and can be
> done very early in the probe sequence. In future it would be good to
> move it out of xe_vram.c, but this refactor is left for later.
>=20
> Cc: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org> # 6.12+
> Link: https://lore.kernel.org/intel-xe/fafda2a3-fc63-ce97-d22b-803f771a4d=
19@linux.intel.com
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_pci.c  |  2 ++
>  drivers/gpu/drm/xe/xe_vram.c | 22 ++++++++++++++--------
>  drivers/gpu/drm/xe/xe_vram.h |  1 +
>  3 files changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> index 701ba9baa9d7e..1f4120b535137 100644
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
> @@ -866,6 +866,8 @@ static int xe_pci_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
>  =09if (err)
>  =09=09return err;
> =20
> +=09xe_vram_resize_bar(xe);
> +
>  =09err =3D xe_device_probe_early(xe);
>  =09/*
>  =09 * In Boot Survivability mode, no drm card is exposed and driver
> diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
> index b44ebf50fedbb..4fb5a8426531a 100644
> --- a/drivers/gpu/drm/xe/xe_vram.c
> +++ b/drivers/gpu/drm/xe/xe_vram.c
> @@ -26,15 +26,23 @@
> =20
>  #define BAR_SIZE_SHIFT 20
> =20
> -static void
> -_resize_bar(struct xe_device *xe, int resno, resource_size_t size)
> +static void release_bars(struct pci_dev *pdev)
> +{
> +=09int resno;
> +
> +=09for (resno =3D PCI_STD_RESOURCES; resno < PCI_STD_RESOURCE_END; resno=
++) {
> +=09=09if (pci_resource_len(pdev, resno))

Please test res->parent instead to find out if the resource is assigned=20
or not.

While pci_resource_len() works currently, I've plans to change that.=20
Thanks to drivers making the assumption that unassigned resources are=20
reset that change is very scary and breaks all over the place. :-(

It's important to not reset the resources as once reset resource is=20
effectively gone until remove/rescan cycle as BARs are not read from the=20
device ever again after the initial probing. So if a BAR won't fit once,=20
shrinking another BAR will not allow the previously non-fitting one to=20
reappear even if it would then fit.

(The resource reset has already been removed in the case of bridge window=
=20
resources by my very recent changes so that the window resource is just=20
DISABLED instead.)

> +=09=09=09pci_release_resource(pdev, resno);

Also, CONFIG_PCI_IOV=3Dy will result in more BARs. I suggest you just use
pci_dev_for_each_resource() which can be used in 3 args version to get=20
resno need for pci_release_resource() call. But you'll then need to decide=
=20
what to do with the Expansion ROM resource, filter it out I guess. Maybe
use IORESOURCE_MEM_64 to release only relevant resource as those resources=
=20
should share the same bridge window with the BAR we're resizing here.


(Unrelated to this patch, but in case you end up noticing the same problem
when enabling IOV config. Testing with my card, it seems PCI core's SR-IOV=
=20
code is broken when it comes to initializing IOV resources, resulting in=20
bogus conflicts:

pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overlaps 0000:0=
3:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]

=2E..yet another patch needed it seems.)


--=20
 i.

> +=09}
> +}
> +
> +static void resize_bar(struct xe_device *xe, int resno, resource_size_t =
size)
>  {
>  =09struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
>  =09int bar_size =3D pci_rebar_bytes_to_size(size);
>  =09int ret;
> =20
> -=09if (pci_resource_len(pdev, resno))
> -=09=09pci_release_resource(pdev, resno);
> +=09release_bars(pdev);
> =20
>  =09ret =3D pci_resize_resource(pdev, resno, bar_size);
>  =09if (ret) {
> @@ -50,7 +58,7 @@ _resize_bar(struct xe_device *xe, int resno, resource_s=
ize_t size)
>   * if force_vram_bar_size is set, attempt to set to the requested size
>   * else set to maximum possible size
>   */
> -static void resize_vram_bar(struct xe_device *xe)
> +void xe_vram_resize_bar(struct xe_device *xe)
>  {
>  =09int force_vram_bar_size =3D xe_modparam.force_vram_bar_size;
>  =09struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
> @@ -119,7 +127,7 @@ static void resize_vram_bar(struct xe_device *xe)
>  =09pci_read_config_dword(pdev, PCI_COMMAND, &pci_cmd);
>  =09pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd & ~PCI_COMMAND_MEMO=
RY);
> =20
> -=09_resize_bar(xe, LMEM_BAR, rebar_size);
> +=09resize_bar(xe, LMEM_BAR, rebar_size);
> =20
>  =09pci_assign_unassigned_bus_resources(pdev->bus);
>  =09pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
> @@ -148,8 +156,6 @@ static int determine_lmem_bar_size(struct xe_device *=
xe, struct xe_vram_region *
>  =09=09return -ENXIO;
>  =09}
> =20
> -=09resize_vram_bar(xe);
> -
>  =09lmem_bar->io_start =3D pci_resource_start(pdev, LMEM_BAR);
>  =09lmem_bar->io_size =3D pci_resource_len(pdev, LMEM_BAR);
>  =09if (!lmem_bar->io_size)
> diff --git a/drivers/gpu/drm/xe/xe_vram.h b/drivers/gpu/drm/xe/xe_vram.h
> index 72860f714fc66..13505cfb184dc 100644
> --- a/drivers/gpu/drm/xe/xe_vram.h
> +++ b/drivers/gpu/drm/xe/xe_vram.h
> @@ -11,6 +11,7 @@
>  struct xe_device;
>  struct xe_vram_region;
> =20
> +void xe_vram_resize_bar(struct xe_device *xe);
>  int xe_vram_probe(struct xe_device *xe);
> =20
>  struct xe_vram_region *xe_vram_region_alloc(struct xe_device *xe, u8 id,=
 u32 placement);
>=20
>=20
--8323328-321119205-1758189809=:949--

