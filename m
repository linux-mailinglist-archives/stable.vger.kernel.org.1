Return-Path: <stable+bounces-184202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AEEBD23E9
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9A544ED60B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443472FD1B6;
	Mon, 13 Oct 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K65XPh+h"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2602FD1C6;
	Mon, 13 Oct 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347214; cv=none; b=p/TJYvVQZD1i7e5UMk5skURKbddr+vN+1Kf5YHsFNBe+2srQ9I6CkyKyF8xzZIpgWmYCFCTi/lgar207nm83f5vew5bwHd6Zq6/zW69aKKshLOOpD/tIO7Pmht+UXBNCRLEbrbcj5Hl6cL7cLEumHSNAcmYSmE1SsRvYhv0X+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347214; c=relaxed/simple;
	bh=qufV1ak7Ac6cqs3TDj89cLPI+3iYZKiJj/u328+T1w4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HZqKfouf68Yh0i84k/XeKU8qq5vZ/FI1jlkOyQUviaMOf61PvxlHzKLa8jQLn0/umBNG/M2skTKNk1MupgoHG7d160Tvmz/7ysmlmISsdA0I+vRFBxSjzJTpVqezj3fZW5zjwEhhudIhRlYtadY5M1db8NNgOTAmjdl/atwEcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K65XPh+h; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760347211; x=1791883211;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=qufV1ak7Ac6cqs3TDj89cLPI+3iYZKiJj/u328+T1w4=;
  b=K65XPh+hjKDRSlFk1HFkB+okzjrSAZ5bMiHi6seInuisTeoKBBkqNWsT
   +aY3OqEk5cGu812eeWjNMsLcjMq/3CLJhH4UxK2tU4Jqv38CzvrglRdv+
   zOkfZ04kcL9LRagQ/5rzgZ6tTXygAdR7KVCj5aFWUwp1+/g8ZB+i7B7HX
   MrplOLBhmzWzjU3cAgePDr0VaemlCvAW/DUAd1f1QT4KMi7tw2plgf0FK
   nWesLvExwIz0CqYYJAm9K9nDzJ6/RjHyJ4142EJoYaDe64iD9qZ1zOUFI
   os7cxhUBnSENQ8I1vtuJchULoRF6IgJx2KxofHt6PBjBbb+AKoJIucNXY
   A==;
X-CSE-ConnectionGUID: c2RRb45YQnqVOD49zOeVaA==
X-CSE-MsgGUID: XC430+xGT1+bu0bVkivssg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66306766"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66306766"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 02:20:10 -0700
X-CSE-ConnectionGUID: GAyhtfPuRQmfuSxh7B/RjQ==
X-CSE-MsgGUID: DPJ4e2SiSP+B2OH0x3iocQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="181119998"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.77])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 02:20:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Oct 2025 12:20:05 +0300 (EEST)
To: stable@vger.kernel.org
cc: stable-commits@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Patch "PCI: Use pci_release_resource() instead of release_resource()"
 has been added to the 6.17-stable tree
In-Reply-To: <20251012141313.2893909-1-sashal@kernel.org>
Message-ID: <516c2797-6602-17b3-244c-10c0ae03be62@linux.intel.com>
References: <20251012141313.2893909-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-853112803-1760346900=:933"
Content-ID: <dbf46e11-85db-e2d7-4709-6ead0b85612f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-853112803-1760346900=:933
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d171ef7f-74ad-e154-b2c5-9db0a1f0127c@linux.intel.com>

On Sun, 12 Oct 2025, Sasha Levin wrote:

> This is a note to let you know that I've just added the patch titled
>=20
>     PCI: Use pci_release_resource() instead of release_resource()
>=20
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      pci-use-pci_release_resource-instead-of-release_reso.patch
> and it can be found in the queue-6.17 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi Sasha and other stable maintainers,

I'm not sure why this is being selected for stable. AFAIK, it doesn't=20
"fix" something but is just a cleanup / consistency improvement.

It also makes a subtle change into flags behavior which has some=20
regression potential (although I estimate the likelihoods of problems is=20
low for this change).

--=20
 i.


> commit a5c01cacc40950fb11cd299334cfbaf0542be443
> Author: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Date:   Fri Aug 29 16:10:57 2025 +0300
>=20
>     PCI: Use pci_release_resource() instead of release_resource()
>    =20
>     [ Upstream commit 3baeae36039afc233d4a42d6ff4aa7019892619f ]
>    =20
>     A few places in setup-bus.c call release_resource() directly and end =
up
>     duplicating functionality from pci_release_resource() such as parent =
check,
>     logging, and clearing the resource. Worse yet, the way the resource i=
s
>     cleared is inconsistent between different sites.
>    =20
>     Convert release_resource() calls into pci_release_resource() to remov=
e code
>     duplication. This will also make the resource start, end, and flags
>     behavior consistent, i.e., start address is cleared, and only
>     IORESOURCE_UNSET is asserted for the resource.
>    =20
>     While at it, eliminate the unnecessary initialization of idx variable=
 in
>     pci_bridge_release_resources().
>    =20
>     Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Link: https://patch.msgid.link/20250829131113.36754-9-ilpo.jarvinen@l=
inux.intel.com
>     Stable-dep-of: 8278c6914306 ("PCI: Preserve bridge window resource ty=
pe flags")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c992707a8ebd6..203c8ebef7029 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -431,8 +431,6 @@ static void __assign_resources_sorted(struct list_hea=
d *head,
>  =09struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
>  =09struct resource *res;
>  =09struct pci_dev *dev;
> -=09const char *res_name;
> -=09int idx;
>  =09unsigned long fail_type;
>  =09resource_size_t add_align, align;
> =20
> @@ -540,14 +538,7 @@ static void __assign_resources_sorted(struct list_he=
ad *head,
>  =09=09res =3D dev_res->res;
>  =09=09dev =3D dev_res->dev;
> =20
> -=09=09if (!res->parent)
> -=09=09=09continue;
> -
> -=09=09idx =3D pci_resource_num(dev, res);
> -=09=09res_name =3D pci_resource_name(dev, idx);
> -=09=09pci_dbg(dev, "%s %pR: releasing\n", res_name, res);
> -
> -=09=09release_resource(res);
> +=09=09pci_release_resource(dev, pci_resource_num(dev, res));
>  =09=09restore_dev_resource(dev_res);
>  =09}
>  =09/* Restore start/end/flags from saved list */
> @@ -1716,7 +1707,7 @@ static void pci_bridge_release_resources(struct pci=
_bus *bus,
>  =09struct resource *r;
>  =09unsigned int old_flags;
>  =09struct resource *b_res;
> -=09int idx =3D 1;
> +=09int idx, ret;
> =20
>  =09b_res =3D &dev->resource[PCI_BRIDGE_RESOURCES];
> =20
> @@ -1750,21 +1741,18 @@ static void pci_bridge_release_resources(struct p=
ci_bus *bus,
> =20
>  =09/* If there are children, release them all */
>  =09release_child_resources(r);
> -=09if (!release_resource(r)) {
> -=09=09type =3D old_flags =3D r->flags & PCI_RES_TYPE_MASK;
> -=09=09pci_info(dev, "resource %d %pR released\n",
> -=09=09=09 PCI_BRIDGE_RESOURCES + idx, r);
> -=09=09/* Keep the old size */
> -=09=09resource_set_range(r, 0, resource_size(r));
> -=09=09r->flags =3D 0;
> =20
> -=09=09/* Avoiding touch the one without PREF */
> -=09=09if (type & IORESOURCE_PREFETCH)
> -=09=09=09type =3D IORESOURCE_PREFETCH;
> -=09=09__pci_setup_bridge(bus, type);
> -=09=09/* For next child res under same bridge */
> -=09=09r->flags =3D old_flags;
> -=09}
> +=09type =3D old_flags =3D r->flags & PCI_RES_TYPE_MASK;
> +=09ret =3D pci_release_resource(dev, PCI_BRIDGE_RESOURCES + idx);
> +=09if (ret)
> +=09=09return;
> +
> +=09/* Avoiding touch the one without PREF */
> +=09if (type & IORESOURCE_PREFETCH)
> +=09=09type =3D IORESOURCE_PREFETCH;
> +=09__pci_setup_bridge(bus, type);
> +=09/* For next child res under same bridge */
> +=09r->flags =3D old_flags;
>  }
> =20
>  enum release_type {
> @@ -2409,7 +2397,6 @@ int pci_reassign_bridge_resources(struct pci_dev *b=
ridge, unsigned long type)
>  =09=09for (i =3D PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
>  =09=09     i++) {
>  =09=09=09struct resource *res =3D &bridge->resource[i];
> -=09=09=09const char *res_name =3D pci_resource_name(bridge, i);
> =20
>  =09=09=09if ((res->flags ^ type) & PCI_RES_TYPE_MASK)
>  =09=09=09=09continue;
> @@ -2422,12 +2409,7 @@ int pci_reassign_bridge_resources(struct pci_dev *=
bridge, unsigned long type)
>  =09=09=09if (ret)
>  =09=09=09=09goto cleanup;
> =20
> -=09=09=09pci_info(bridge, "%s %pR: releasing\n", res_name, res);
> -
> -=09=09=09if (res->parent)
> -=09=09=09=09release_resource(res);
> -=09=09=09res->start =3D 0;
> -=09=09=09res->end =3D 0;
> +=09=09=09pci_release_resource(bridge, i);
>  =09=09=09break;
>  =09=09}
>  =09=09if (i =3D=3D PCI_BRIDGE_RESOURCE_END)
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index d2b3ed51e8804..0468c058b5987 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -406,20 +406,25 @@ int pci_reassign_resource(struct pci_dev *dev, int =
resno,
>  =09return 0;
>  }
> =20
> -void pci_release_resource(struct pci_dev *dev, int resno)
> +int pci_release_resource(struct pci_dev *dev, int resno)
>  {
>  =09struct resource *res =3D pci_resource_n(dev, resno);
>  =09const char *res_name =3D pci_resource_name(dev, resno);
> +=09int ret;
> =20
>  =09if (!res->parent)
> -=09=09return;
> +=09=09return 0;
> =20
>  =09pci_info(dev, "%s %pR: releasing\n", res_name, res);
> =20
> -=09release_resource(res);
> +=09ret =3D release_resource(res);
> +=09if (ret)
> +=09=09return ret;
>  =09res->end =3D resource_size(res) - 1;
>  =09res->start =3D 0;
>  =09res->flags |=3D IORESOURCE_UNSET;
> +
> +=09return 0;
>  }
>  EXPORT_SYMBOL(pci_release_resource);
> =20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 59876de13860d..275df40587672 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1417,7 +1417,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev);
>  void pcibios_reset_secondary_bus(struct pci_dev *dev);
>  void pci_update_resource(struct pci_dev *dev, int resno);
>  int __must_check pci_assign_resource(struct pci_dev *dev, int i);
> -void pci_release_resource(struct pci_dev *dev, int resno);
> +int pci_release_resource(struct pci_dev *dev, int resno);
>  static inline int pci_rebar_bytes_to_size(u64 bytes)
>  {
>  =09bytes =3D roundup_pow_of_two(bytes);
>=20
--8323328-853112803-1760346900=:933--

