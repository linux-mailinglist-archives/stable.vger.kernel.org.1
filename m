Return-Path: <stable+bounces-184190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556FDBD2363
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22B83B6080
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33252FBE0B;
	Mon, 13 Oct 2025 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkMFu4Gb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47862FB995;
	Mon, 13 Oct 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346672; cv=none; b=rVXVzdfaUGMkuMS5YzQEuzErMadw8YtBIRu/oNk/i6mP/avhGEjvtRuA+67lwLkGsbZNVwB/bWLQwtGRmnGpB2BY/z2QfATHN9KPpIYvOihHMmVohkJliaVtUe4EhssTjngzSigBAd9PLzc/9L4vGd9kxadJ/0R+utWhhQe5BIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346672; c=relaxed/simple;
	bh=rnfrFXyWGRegDbxl4yvu3On+gc8CaqaHc/cZCaaMNIY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s6pYuYu3lpSXsEoFwxPcz61/SgnkJ6GPDG9LROwbqR78/XPsJIq0p/U4HHAM+B4EWh+rDg0US2De3Y8sG8HVR0J6pRrnFGuXhTR1pAW5m+XWJtQDdrbvWrzrBExSEDO8wq8Z5FoZWDaQK/uG02Sw8UjIZN00azIDPcfjI2X9YNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkMFu4Gb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760346669; x=1791882669;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=rnfrFXyWGRegDbxl4yvu3On+gc8CaqaHc/cZCaaMNIY=;
  b=lkMFu4Gbb38AfP03mwpy1FiKmIRsHlTJ+CFa9YJAVlBbLEp1K9nZERVV
   XoY/cHq1zc+LSem+3inhFexK5/DafGFlZtAoLkqo9lH4td3J7QSE39sZA
   TMSphQ/maXEvcSb6ass8lzYGtExiis389M/epuQjsHQmiT3urHt1sxE2P
   h2Bkxq0u0yy0sN8rnOKOTWNfTBNbRfNBMQo+MXGaGoVXjdRvkqWQwY/JX
   1JSf3eBsgi8RivhorPrrh/IrxGVdn1owiBe9CQ2+MD7j7t5r+RmIGYxVq
   W0ZgUhbzeudyll+dTp6uGHjJuY1uAVsixErlT4lZTELZQFq7IieKhfITa
   Q==;
X-CSE-ConnectionGUID: vYdTn3uqR+StsGhQxHNBDA==
X-CSE-MsgGUID: eIDhtY2aTTOBgAqZoAEKOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="72738577"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="72738577"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 02:11:06 -0700
X-CSE-ConnectionGUID: bl5ucgP4SEi9nUxs9QFyhQ==
X-CSE-MsgGUID: a9nJ/4LvSXKTQhl9nQecCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="185563833"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.77])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 02:11:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Oct 2025 12:11:01 +0300 (EEST)
To: stable@vger.kernel.org
cc: stable-commits@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Patch "PCI: Preserve bridge window resource type flags" has been
 added to the 6.17-stable tree
In-Reply-To: <20251012141317.2894025-1-sashal@kernel.org>
Message-ID: <78ea57b6-5bc8-b357-c37c-bd327785e825@linux.intel.com>
References: <20251012141317.2894025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1931853947-1760346011=:933"
Content-ID: <8ff74130-58b5-64d0-a0bb-86fb84395247@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1931853947-1760346011=:933
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b5107a2d-9562-52ea-48cd-8cb377a06906@linux.intel.com>

On Sun, 12 Oct 2025, Sasha Levin wrote:

> This is a note to let you know that I've just added the patch titled
>=20
>     PCI: Preserve bridge window resource type flags
>=20
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      pci-preserve-bridge-window-resource-type-flags.patch
> and it can be found in the queue-6.17 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi Sasha and other stable maintainers,

While I agree the assessment that this is stable material, could we=20
postpone queueing to stable a bit more? This change has relatively high=20
regression potential and high impact for individual system that regresses,=
=20
and is complicated change no matter what already given the diffstat alone.

So try e.g. after 6.18 is released would seem more prudent for me as it=20
would give more time to iron out problems in the rc-phase before any=20
stable sees this change.

I'm also very worried this change is queued without the=20
commit 1cdffa51ecc4 ("PCI: Enable bridge even if bridge window fails to=20
assign"), that's pretty much straight into territory I've personally=20
charted to contain ways to break things which is why I added 1cdffa51ecc4.=
=20
There are also the supporting arch cleanups to the same functionality as=20
1cdffa51ecc4 (done through weak magic) that are related to 1cdffa51ecc4.

--=20
 i.

> commit b871817e3ba3e462dbc10491a2786cd3fb9dc064
> Author: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Date:   Fri Aug 29 16:10:59 2025 +0300
>=20
>     PCI: Preserve bridge window resource type flags
>    =20
>     [ Upstream commit 8278c6914306f35f32d73bdf2a918950919a0051 ]
>    =20
>     When a bridge window is found unused or fails to assign, the flags of=
 the
>     associated resource are cleared. Clearing flags is problematic as it =
also
>     removes the type information of the resource which is needed later.
>    =20
>     Thus, always preserve the bridge window type flags and use IORESOURCE=
_UNSET
>     and IORESOURCE_DISABLED to indicate the status of the bridge window. =
Also,
>     when initializing resources, make sure all valid bridge windows do ge=
t
>     their type flags set.
>    =20
>     Change various places that relied on resource flags being cleared to =
check
>     for IORESOURCE_UNSET and IORESOURCE_DISABLED to allow bridge window
>     resource to retain their type flags. Add pdev_resource_assignable() a=
nd
>     pdev_resource_should_fit() helpers to filter out disabled bridge wind=
ows
>     during resource fitting; the latter combines more common checks into =
the
>     helper.
>    =20
>     When reading the bridge windows from the registers, instead of leavin=
g the
>     resource flags cleared for bridge windows that are not enabled, alway=
s
>     set up the flags and set IORESOURCE_UNSET | IORESOURCE_DISABLED as ne=
eded.
>    =20
>     When resource fitting or assignment fails for a bridge window resourc=
e, or
>     the bridge window is not needed, mark the resource with IORESOURCE_UN=
SET or
>     IORESOURCE_DISABLED, respectively.
>    =20
>     Use dummy zero resource in resource_show() for backwards compatibilit=
y as
>     lspci will otherwise misrepresent disabled bridge windows.
>    =20
>     This change fixes an issue which highlights the importance of keeping=
 the
>     resource type flags intact:
>    =20
>       At the end of __assign_resources_sorted(), reset_resource() is call=
ed,
>       previously clearing the flags. Later, pci_prepare_next_assign_round=
()
>       attempted to release bridge resources using
>       pci_bus_release_bridge_resources() that calls into
>       pci_bridge_release_resources() that assumes type flags are still pr=
esent.
>       As type flags were cleared, IORESOURCE_MEM_64 was not set leading t=
o
>       resources under an incorrect bridge window to be released (idx =3D =
1
>       instead of idx =3D 2). While the assignments performed later covere=
d this
>       problem so that the wrongly released resources got assigned in the =
end,
>       it was still causing extra release+assign pairs.
>    =20
>     There are other reasons why the resource flags should be retained in
>     upcoming changes too.
>    =20
>     Removing the flag reset for non-bridge window resource is left as fut=
ure
>     work, in part because it has a much higher regression potential due t=
o
>     pci_enable_resources() that will start to work also for those resourc=
es
>     then and due to what endpoint drivers might assume about resources.
>    =20
>     Despite the Fixes tag, backporting this (at least any time soon) is h=
ighly
>     discouraged. The issue fixed is borderline cosmetic as the later
>     assignments normally cover the problem entirely. Also there might be
>     non-obvious dependencies.
>    =20
>     Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge window=
s to 64-bit resources")
>     Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Link: https://patch.msgid.link/20250829131113.36754-11-ilpo.jarvinen@=
linux.intel.com
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index b77fd30bbfd9d..58b5388423ee3 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -204,6 +204,9 @@ static int pci_bus_alloc_from_region(struct pci_bus *=
bus, struct resource *res,
>  =09=09if (!r)
>  =09=09=09continue;
> =20
> +=09=09if (r->flags & (IORESOURCE_UNSET|IORESOURCE_DISABLED))
> +=09=09=09continue;
> +
>  =09=09/* type_mask must match */
>  =09=09if ((res->flags ^ r->flags) & type_mask)
>  =09=09=09continue;
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5eea14c1f7f5f..162a5241c7f70 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -177,6 +177,13 @@ static ssize_t resource_show(struct device *dev, str=
uct device_attribute *attr,
> =20
>  =09for (i =3D 0; i < max; i++) {
>  =09=09struct resource *res =3D  &pci_dev->resource[i];
> +=09=09struct resource zerores =3D {};
> +
> +=09=09/* For backwards compatibility */
> +=09=09if (i >=3D PCI_BRIDGE_RESOURCES && i <=3D PCI_BRIDGE_RESOURCE_END =
&&
> +=09=09    res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
> +=09=09=09res =3D &zerores;
> +
>  =09=09pci_resource_to_user(pci_dev, i, res, &start, &end);
>  =09=09len +=3D sysfs_emit_at(buf, len, "0x%016llx 0x%016llx 0x%016llx\n"=
,
>  =09=09=09=09     (unsigned long long)start,
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f41128f91ca76..f31d27c7708a6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -419,13 +419,17 @@ static void pci_read_bridge_io(struct pci_dev *dev,=
 struct resource *res,
>  =09=09limit |=3D ((unsigned long) io_limit_hi << 16);
>  =09}
> =20
> +=09res->flags =3D (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
> +
>  =09if (base <=3D limit) {
> -=09=09res->flags =3D (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_=
IO;
>  =09=09region.start =3D base;
>  =09=09region.end =3D limit + io_granularity - 1;
>  =09=09pcibios_bus_to_resource(dev->bus, res, &region);
>  =09=09if (log)
>  =09=09=09pci_info(dev, "  bridge window %pR\n", res);
> +=09} else {
> +=09=09resource_set_range(res, 0, 0);
> +=09=09res->flags |=3D IORESOURCE_UNSET | IORESOURCE_DISABLED;
>  =09}
>  }
> =20
> @@ -440,13 +444,18 @@ static void pci_read_bridge_mmio(struct pci_dev *de=
v, struct resource *res,
>  =09pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
>  =09base =3D ((unsigned long) mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
>  =09limit =3D ((unsigned long) mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 1=
6;
> +
> +=09res->flags =3D (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURC=
E_MEM;
> +
>  =09if (base <=3D limit) {
> -=09=09res->flags =3D (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESO=
URCE_MEM;
>  =09=09region.start =3D base;
>  =09=09region.end =3D limit + 0xfffff;
>  =09=09pcibios_bus_to_resource(dev->bus, res, &region);
>  =09=09if (log)
>  =09=09=09pci_info(dev, "  bridge window %pR\n", res);
> +=09} else {
> +=09=09resource_set_range(res, 0, 0);
> +=09=09res->flags |=3D IORESOURCE_UNSET | IORESOURCE_DISABLED;
>  =09}
>  }
> =20
> @@ -489,16 +498,20 @@ static void pci_read_bridge_mmio_pref(struct pci_de=
v *dev, struct resource *res,
>  =09=09return;
>  =09}
> =20
> +=09res->flags =3D (mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) | IORESOURCE_=
MEM |
> +=09=09     IORESOURCE_PREFETCH;
> +=09if (res->flags & PCI_PREF_RANGE_TYPE_64)
> +=09=09res->flags |=3D IORESOURCE_MEM_64;
> +
>  =09if (base <=3D limit) {
> -=09=09res->flags =3D (mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) |
> -=09=09=09=09=09 IORESOURCE_MEM | IORESOURCE_PREFETCH;
> -=09=09if (res->flags & PCI_PREF_RANGE_TYPE_64)
> -=09=09=09res->flags |=3D IORESOURCE_MEM_64;
>  =09=09region.start =3D base;
>  =09=09region.end =3D limit + 0xfffff;
>  =09=09pcibios_bus_to_resource(dev->bus, res, &region);
>  =09=09if (log)
>  =09=09=09pci_info(dev, "  bridge window %pR\n", res);
> +=09} else {
> +=09=09resource_set_range(res, 0, 0);
> +=09=09res->flags |=3D IORESOURCE_UNSET | IORESOURCE_DISABLED;
>  =09}
>  }
> =20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 203c8ebef7029..8078ee30e675f 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -154,6 +154,31 @@ static bool pdev_resources_assignable(struct pci_dev=
 *dev)
>  =09return true;
>  }
> =20
> +static bool pdev_resource_assignable(struct pci_dev *dev, struct resourc=
e *res)
> +{
> +=09int idx =3D pci_resource_num(dev, res);
> +
> +=09if (!res->flags)
> +=09=09return false;
> +
> +=09if (idx >=3D PCI_BRIDGE_RESOURCES && idx <=3D PCI_BRIDGE_RESOURCE_END=
 &&
> +=09    res->flags & IORESOURCE_DISABLED)
> +=09=09return false;
> +
> +=09return true;
> +}
> +
> +static bool pdev_resource_should_fit(struct pci_dev *dev, struct resourc=
e *res)
> +{
> +=09if (res->parent)
> +=09=09return false;
> +
> +=09if (res->flags & IORESOURCE_PCI_FIXED)
> +=09=09return false;
> +
> +=09return pdev_resource_assignable(dev, res);
> +}
> +
>  /* Sort resources by alignment */
>  static void pdev_sort_resources(struct pci_dev *dev, struct list_head *h=
ead)
>  {
> @@ -169,10 +194,7 @@ static void pdev_sort_resources(struct pci_dev *dev,=
 struct list_head *head)
>  =09=09resource_size_t r_align;
>  =09=09struct list_head *n;
> =20
> -=09=09if (r->flags & IORESOURCE_PCI_FIXED)
> -=09=09=09continue;
> -
> -=09=09if (!(r->flags) || r->parent)
> +=09=09if (!pdev_resource_should_fit(dev, r))
>  =09=09=09continue;
> =20
>  =09=09r_align =3D pci_resource_alignment(dev, r);
> @@ -221,8 +243,15 @@ bool pci_resource_is_optional(const struct pci_dev *=
dev, int resno)
>  =09return false;
>  }
> =20
> -static inline void reset_resource(struct resource *res)
> +static inline void reset_resource(struct pci_dev *dev, struct resource *=
res)
>  {
> +=09int idx =3D pci_resource_num(dev, res);
> +
> +=09if (idx >=3D PCI_BRIDGE_RESOURCES && idx <=3D PCI_BRIDGE_RESOURCE_END=
) {
> +=09=09res->flags |=3D IORESOURCE_UNSET;
> +=09=09return;
> +=09}
> +
>  =09res->start =3D 0;
>  =09res->end =3D 0;
>  =09res->flags =3D 0;
> @@ -568,7 +597,7 @@ static void __assign_resources_sorted(struct list_hea=
d *head,
>  =09=09=09=09    0 /* don't care */);
>  =09=09}
> =20
> -=09=09reset_resource(res);
> +=09=09reset_resource(dev, res);
>  =09}
> =20
>  =09free_list(head);
> @@ -997,8 +1026,11 @@ static void pbus_size_io(struct pci_bus *bus, resou=
rce_size_t min_size,
> =20
>  =09=09=09if (r->parent || !(r->flags & IORESOURCE_IO))
>  =09=09=09=09continue;
> -=09=09=09r_size =3D resource_size(r);
> =20
> +=09=09=09if (!pdev_resource_assignable(dev, r))
> +=09=09=09=09continue;
> +
> +=09=09=09r_size =3D resource_size(r);
>  =09=09=09if (r_size < SZ_1K)
>  =09=09=09=09/* Might be re-aligned for ISA */
>  =09=09=09=09size +=3D r_size;
> @@ -1017,6 +1049,9 @@ static void pbus_size_io(struct pci_bus *bus, resou=
rce_size_t min_size,
>  =09size0 =3D calculate_iosize(size, min_size, size1, 0, 0,
>  =09=09=09resource_size(b_res), min_align);
> =20
> +=09if (size0)
> +=09=09b_res->flags &=3D ~IORESOURCE_DISABLED;
> +
>  =09size1 =3D size0;
>  =09if (realloc_head && (add_size > 0 || children_add_size > 0)) {
>  =09=09size1 =3D calculate_iosize(size, min_size, size1, add_size,
> @@ -1028,13 +1063,14 @@ static void pbus_size_io(struct pci_bus *bus, res=
ource_size_t min_size,
>  =09=09if (bus->self && (b_res->start || b_res->end))
>  =09=09=09pci_info(bus->self, "disabling bridge window %pR to %pR (unused=
)\n",
>  =09=09=09=09 b_res, &bus->busn_res);
> -=09=09b_res->flags =3D 0;
> +=09=09b_res->flags |=3D IORESOURCE_DISABLED;
>  =09=09return;
>  =09}
> =20
>  =09resource_set_range(b_res, min_align, size0);
>  =09b_res->flags |=3D IORESOURCE_STARTALIGN;
>  =09if (bus->self && size1 > size0 && realloc_head) {
> +=09=09b_res->flags &=3D ~IORESOURCE_DISABLED;
>  =09=09add_to_list(realloc_head, bus->self, b_res, size1-size0,
>  =09=09=09    min_align);
>  =09=09pci_info(bus->self, "bridge window %pR to %pR add_size %llx\n",
> @@ -1180,11 +1216,13 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
>  =09=09=09const char *r_name =3D pci_resource_name(dev, i);
>  =09=09=09resource_size_t r_size;
> =20
> -=09=09=09if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
> -=09=09=09    !pdev_resources_assignable(dev) ||
> -=09=09=09    ((r->flags & mask) !=3D type &&
> -=09=09=09     (r->flags & mask) !=3D type2 &&
> -=09=09=09     (r->flags & mask) !=3D type3))
> +=09=09=09if (!pdev_resources_assignable(dev) ||
> +=09=09=09    !pdev_resource_should_fit(dev, r))
> +=09=09=09=09continue;
> +
> +=09=09=09if ((r->flags & mask) !=3D type &&
> +=09=09=09    (r->flags & mask) !=3D type2 &&
> +=09=09=09    (r->flags & mask) !=3D type3)
>  =09=09=09=09continue;
>  =09=09=09r_size =3D resource_size(r);
> =20
> @@ -1235,6 +1273,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsig=
ned long mask,
>  =09min_align =3D max(min_align, win_align);
>  =09size0 =3D calculate_memsize(size, min_size, 0, 0, resource_size(b_res=
), min_align);
> =20
> +=09if (size0)
> +=09=09b_res->flags &=3D ~IORESOURCE_DISABLED;
> +
>  =09if (bus->self && size0 &&
>  =09    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, t=
ype,
>  =09=09=09=09=09   size0, min_align)) {
> @@ -1267,13 +1308,14 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
>  =09=09if (bus->self && (b_res->start || b_res->end))
>  =09=09=09pci_info(bus->self, "disabling bridge window %pR to %pR (unused=
)\n",
>  =09=09=09=09 b_res, &bus->busn_res);
> -=09=09b_res->flags =3D 0;
> +=09=09b_res->flags |=3D IORESOURCE_DISABLED;
>  =09=09return 0;
>  =09}
> =20
>  =09resource_set_range(b_res, min_align, size0);
>  =09b_res->flags |=3D IORESOURCE_STARTALIGN;
>  =09if (bus->self && size1 > size0 && realloc_head) {
> +=09=09b_res->flags &=3D ~IORESOURCE_DISABLED;
>  =09=09add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align=
);
>  =09=09pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_al=
ign %llx\n",
>  =09=09=09   b_res, &bus->busn_res,
> @@ -1705,7 +1747,6 @@ static void pci_bridge_release_resources(struct pci=
_bus *bus,
>  {
>  =09struct pci_dev *dev =3D bus->self;
>  =09struct resource *r;
> -=09unsigned int old_flags;
>  =09struct resource *b_res;
>  =09int idx, ret;
> =20
> @@ -1742,17 +1783,15 @@ static void pci_bridge_release_resources(struct p=
ci_bus *bus,
>  =09/* If there are children, release them all */
>  =09release_child_resources(r);
> =20
> -=09type =3D old_flags =3D r->flags & PCI_RES_TYPE_MASK;
>  =09ret =3D pci_release_resource(dev, PCI_BRIDGE_RESOURCES + idx);
>  =09if (ret)
>  =09=09return;
> =20
> +=09type =3D r->flags & PCI_RES_TYPE_MASK;
>  =09/* Avoiding touch the one without PREF */
>  =09if (type & IORESOURCE_PREFETCH)
>  =09=09type =3D IORESOURCE_PREFETCH;
>  =09__pci_setup_bridge(bus, type);
> -=09/* For next child res under same bridge */
> -=09r->flags =3D old_flags;
>  }
> =20
>  enum release_type {
> @@ -2230,21 +2269,9 @@ static void pci_prepare_next_assign_round(struct l=
ist_head *fail_head,
>  =09}
> =20
>  =09/* Restore size and flags */
> -=09list_for_each_entry(fail_res, fail_head, list) {
> -=09=09struct resource *res =3D fail_res->res;
> -=09=09struct pci_dev *dev =3D fail_res->dev;
> -=09=09int idx =3D pci_resource_num(dev, res);
> -
> +=09list_for_each_entry(fail_res, fail_head, list)
>  =09=09restore_dev_resource(fail_res);
> =20
> -=09=09if (!pci_is_bridge(dev))
> -=09=09=09continue;
> -
> -=09=09if (idx >=3D PCI_BRIDGE_RESOURCES &&
> -=09=09    idx <=3D PCI_BRIDGE_RESOURCE_END)
> -=09=09=09res->flags =3D 0;
> -=09}
> -
>  =09free_list(fail_head);
>  }
> =20
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 0468c058b5987..c5ef8ef54d3ce 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -359,6 +359,9 @@ int pci_assign_resource(struct pci_dev *dev, int resn=
o)
> =20
>  =09res->flags &=3D ~IORESOURCE_UNSET;
>  =09res->flags &=3D ~IORESOURCE_STARTALIGN;
> +=09if (resno >=3D PCI_BRIDGE_RESOURCES && resno <=3D PCI_BRIDGE_RESOURCE=
_END)
> +=09=09res->flags &=3D ~IORESOURCE_DISABLED;
> +
>  =09pci_info(dev, "%s %pR: assigned\n", res_name, res);
>  =09if (resno < PCI_BRIDGE_RESOURCES)
>  =09=09pci_update_resource(dev, resno);
>=20
--8323328-1931853947-1760346011=:933--

