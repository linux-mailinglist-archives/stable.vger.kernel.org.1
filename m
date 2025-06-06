Return-Path: <stable+bounces-151731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC46DAD07D4
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 19:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591CF188A12C
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ABC28A3E1;
	Fri,  6 Jun 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkCutnaz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A62CA6;
	Fri,  6 Jun 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749232474; cv=none; b=oaEcAhSskzWy6m+7uRTmCOWQE+Bbm8Hq4pAS81iFNyP+KoXYQH0+ApVnGsSqFRP4Qcek8NP3G238F5yY7MvzKi8S1yRbsfXp6sCuNmnszmMfL62f776dkQP0E/S0igZSgQS3u2iRv9eosDBTRNMrSmbJMT/q3AqUlq4u4ZPp5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749232474; c=relaxed/simple;
	bh=iWVg2UkE7GEeDwf//hXY79U1/ziokq9zrrCgE+EgR1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GnoUPz87mLSJBDzwwKjERC/nmabwaD9JEnLq8fplRRnQOPG0wDilpp2mG1IP9Lk76IYlU4TTHPTGVvm0dy1RdcI9pj15PF4xrXx8f905q00besnQ+WHs6PGLFr9/wB3x34yJlzkuJaJ7KZUs8oyV7logtsAMqS4JfQuIXdOAgVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkCutnaz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749232472; x=1780768472;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=iWVg2UkE7GEeDwf//hXY79U1/ziokq9zrrCgE+EgR1g=;
  b=ZkCutnazRUpA0iHjiZZ1lkO4bPTMMWQPQZRa8bAv57HhiSGeMrHB7au4
   ZF60humigT7VbAXBrH9NaHD+AOtCjManppc4TYPCowkyKptS41S1Taygr
   dTRw01YHlyobiLee9QvtUeZZNnLcqBHfmUQEq5R203n0laNiYRwRKWVRw
   yTC70M3em/14M1CbUf1/Z8jt0GDZsiQF9f0XIQa6xk6s2aXfTOM2sEJ+3
   JzXxiBmvpNu+dwNXvAp6b8Z7YahL18Y+hPvsjNLr6G7GkvSPvrzufYss4
   OSjv/vrDj7BH2kDyVmN9LETGR5CLxJfZ4/hHOEHPdhylhnQv1lPam3ZTP
   w==;
X-CSE-ConnectionGUID: elcGMWezRyynjR8InbXygg==
X-CSE-MsgGUID: +8GJU36qTAGI6rd9Gm0Cqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51269194"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="51269194"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 10:54:31 -0700
X-CSE-ConnectionGUID: UGRi7QNiSo2fsIkqJUjTTg==
X-CSE-MsgGUID: RXwz95PnSVePc+KIujJ9Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="151143254"
Received: from aschofie-mobl2.amr.corp.intel.com ([10.124.222.251])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 10:54:31 -0700
Message-ID: <d5d9b7cc5768c7715e8ac020e4a098d51fce69da.camel@linux.intel.com>
Subject: Re: [PATCH v3 01/11] platform/x86/intel: refactor endpoint usage
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>, 
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org, 
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 lucas.demarchi@intel.com,  rodrigo.vivi@intel.com,
 thomas.hellstrom@linux.intel.com, airlied@gmail.com,  simona@ffwll.ch
Cc: stable@vger.kernel.org
Date: Fri, 06 Jun 2025 10:54:30 -0700
In-Reply-To: <20250605184444.515556-2-michael.j.ruhl@intel.com>
References: <20250605184444.515556-1-michael.j.ruhl@intel.com>
	 <20250605184444.515556-2-michael.j.ruhl@intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mike,

On Thu, 2025-06-05 at 14:44 -0400, Michael J. Ruhl wrote:
> The use of an endpoint has introduced a dependency in all class/pmt
> drivers to have an endpoint allocated.
>=20
> The telemetry driver has this allocation, the crashlog does not.
>=20
> The current usage is very telemetry focused, but should be common code.

The endpoint exists specifically to support the exported APIs in the teleme=
try
driver. It's reference-counted via kref to ensure safe cleanup once all API
consumers are done. Unless the kernel needs to invoke a crashlog API throug=
h
this mechanism, I=E2=80=99m not sure this change is necessary. I=E2=80=99ll=
 go through the rest
of the patches to understand how the endpoint is being used, but my initial
reaction is that is not be needed.

>=20
> With this in mind:
> =C2=A0 rename the struct telemetry_endpoint to struct class_endpoint,
> =C2=A0 refactor the common endpoint code to be in the class.c module
>=20
> Fixes: 416eeb2e1fc7 ("platform/x86/intel/pmt: telemetry: Export API to re=
ad
> telemetry")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> ---
> =C2=A0drivers/platform/x86/intel/pmc/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 +-
> =C2=A0drivers/platform/x86/intel/pmc/core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 +-
> =C2=A0drivers/platform/x86/intel/pmc/core_ssram.c |=C2=A0 2 +-
> =C2=A0drivers/platform/x86/intel/pmt/class.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 45 ++++++++++++++++++
> =C2=A0drivers/platform/x86/intel/pmt/class.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 21 +++++++--
> =C2=A0drivers/platform/x86/intel/pmt/telemetry.c=C2=A0 | 51 ++++---------=
--------
> =C2=A0drivers/platform/x86/intel/pmt/telemetry.h=C2=A0 | 23 ++++------
> =C2=A07 files changed, 84 insertions(+), 65 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.c
> b/drivers/platform/x86/intel/pmc/core.c
> index 7a1d11f2914f..805f56665d1d 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -29,6 +29,7 @@
> =C2=A0#include <asm/tsc.h>
> =C2=A0
> =C2=A0#include "core.h"
> +#include "../pmt/class.h"
> =C2=A0#include "../pmt/telemetry.h"
> =C2=A0
> =C2=A0/* Maximum number of modes supported by platfoms that has low power=
 mode
> capability */
> @@ -1198,7 +1199,7 @@ int get_primary_reg_base(struct pmc *pmc)
> =C2=A0
> =C2=A0void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid)
> =C2=A0{
> -	struct telem_endpoint *ep;
> +	struct class_endpoint *ep;

I'd name it pmt_endpoint instead of class_endpoint.

> =C2=A0	struct pci_dev *pcidev;
> =C2=A0
> =C2=A0	pcidev =3D pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(10, 0));
> diff --git a/drivers/platform/x86/intel/pmc/core.h
> b/drivers/platform/x86/intel/pmc/core.h
> index 945a1c440cca..1c12ea7c3ce3 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -16,7 +16,7 @@
> =C2=A0#include <linux/bits.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0
> -struct telem_endpoint;
> +struct class_endpoint;
> =C2=A0
> =C2=A0#define SLP_S0_RES_COUNTER_MASK			GENMASK(31, 0)
> =C2=A0
> @@ -432,7 +432,7 @@ struct pmc_dev {
> =C2=A0
> =C2=A0	bool has_die_c6;
> =C2=A0	u32 die_c6_offset;
> -	struct telem_endpoint *punit_ep;
> +	struct class_endpoint *punit_ep;
> =C2=A0	struct pmc_info *regmap_list;
> =C2=A0};
> =C2=A0
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c
> b/drivers/platform/x86/intel/pmc/core_ssram.c
> index 739569803017..3e670fc380a5 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -42,7 +42,7 @@ static u32 pmc_core_find_guid(struct pmc_info *list, co=
nst
> struct pmc_reg_map *m
> =C2=A0
> =C2=A0static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc =
*pmc)
> =C2=A0{
> -	struct telem_endpoint *ep;
> +	struct class_endpoint *ep;
> =C2=A0	const u8 *lpm_indices;
> =C2=A0	int num_maps, mode_offset =3D 0;
> =C2=A0	int ret, mode;
> diff --git a/drivers/platform/x86/intel/pmt/class.c
> b/drivers/platform/x86/intel/pmt/class.c
> index 7233b654bbad..bba552131bc2 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -76,6 +76,47 @@ int pmt_telem_read_mmio(struct pci_dev *pdev, struct
> pmt_callbacks *cb, u32 guid
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_read_mmio, "INTEL_PMT");
> =C2=A0
> +/* Called when all users unregister and the device is removed */
> +static void pmt_class_ep_release(struct kref *kref)
> +{
> +	struct class_endpoint *ep;
> +
> +	ep =3D container_of(kref, struct class_endpoint, kref);
> +	kfree(ep);
> +}
> +
> +void intel_pmt_release_endpoint(struct class_endpoint *ep)
> +{
> +	kref_put(&ep->kref, pmt_class_ep_release);
> +}
> +EXPORT_SYMBOL_NS_GPL(intel_pmt_release_endpoint, "INTEL_PMT");
> +
> +int intel_pmt_add_endpoint(struct intel_vsec_device *ivdev,
> +			=C2=A0=C2=A0 struct intel_pmt_entry *entry)
> +{
> +	struct class_endpoint *ep;
> +
> +	ep =3D kzalloc(sizeof(*ep), GFP_KERNEL);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->pcidev =3D ivdev->pcidev;
> +	ep->header.access_type =3D entry->header.access_type;
> +	ep->header.guid =3D entry->header.guid;
> +	ep->header.base_offset =3D entry->header.base_offset;
> +	ep->header.size =3D entry->header.size;
> +	ep->base =3D entry->base;
> +	ep->present =3D true;
> +	ep->cb =3D ivdev->priv_data;
> +
> +	/* Endpoint lifetimes are managed by kref, not devres */
> +	kref_init(&ep->kref);
> +
> +	entry->ep =3D ep;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(intel_pmt_add_endpoint, "INTEL_PMT");
> =C2=A0/*
> =C2=A0 * sysfs
> =C2=A0 */
> @@ -97,6 +138,10 @@ intel_pmt_read(struct file *filp, struct kobject *kob=
j,
> =C2=A0	if (count > entry->size - off)
> =C2=A0		count =3D entry->size - off;
> =C2=A0
> +	/* verify endpoint is available */
> +	if (!entry->ep)
> +		return -ENODEV;
> +

Hmm ...

> =C2=A0	count =3D pmt_telem_read_mmio(entry->ep->pcidev, entry->cb, entry-
> >header.guid, buf,
> =C2=A0				=C2=A0=C2=A0=C2=A0 entry->base, off, count);

... intel_pmt_read() is only intended to handle sysfs reads, not to access
driver endpoints. But entry->ep is a handle registered by a driver via
pmt_telem_find_and_register_endpoint() which won=E2=80=99t be called unless=
 another
driver explicitly does so. If no driver registers the endpoint, entry->ep w=
ill
be NULL, and this read path will dereference it, leading to a NULL pointer =
bug.

This call to entry->ep->pcidev shouldn't be here. It mistakenly mixes the s=
ysfs
path with the driver API path. Actual use of entry->ep belongs only in the
exported read calls in telemetry.c.

David=20

> =C2=A0
> diff --git a/drivers/platform/x86/intel/pmt/class.h
> b/drivers/platform/x86/intel/pmt/class.h
> index b2006d57779d..d2d8f9e31c9d 100644
> --- a/drivers/platform/x86/intel/pmt/class.h
> +++ b/drivers/platform/x86/intel/pmt/class.h
> @@ -9,8 +9,6 @@
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/io.h>
> =C2=A0
> -#include "telemetry.h"
> -
> =C2=A0/* PMT access types */
> =C2=A0#define ACCESS_BARID		2
> =C2=A0#define ACCESS_LOCAL		3
> @@ -19,11 +17,19 @@
> =C2=A0#define GET_BIR(v)		((v) & GENMASK(2, 0))
> =C2=A0#define GET_ADDRESS(v)		((v) & GENMASK(31, 3))
> =C2=A0
> +struct kref;
> =C2=A0struct pci_dev;
> =C2=A0
> -struct telem_endpoint {
> +struct class_header {
> +	u8	access_type;
> +	u16	size;
> +	u32	guid;
> +	u32	base_offset;
> +};
> +
> +struct class_endpoint {
> =C2=A0	struct pci_dev		*pcidev;
> -	struct telem_header	header;
> +	struct class_header	header;
> =C2=A0	struct pmt_callbacks	*cb;
> =C2=A0	void __iomem		*base;
> =C2=A0	bool			present;
> @@ -38,7 +44,7 @@ struct intel_pmt_header {
> =C2=A0};
> =C2=A0
> =C2=A0struct intel_pmt_entry {
> -	struct telem_endpoint	*ep;
> +	struct class_endpoint	*ep;
> =C2=A0	struct intel_pmt_header	header;
> =C2=A0	struct bin_attribute	pmt_bin_attr;
> =C2=A0	struct kobject		*kobj;
> @@ -69,4 +75,9 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry,
> =C2=A0			 struct intel_vsec_device *dev, int idx);
> =C2=A0void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
> =C2=A0			=C2=A0=C2=A0 struct intel_pmt_namespace *ns);
> +
> +int intel_pmt_add_endpoint(struct intel_vsec_device *ivdev,
> +			=C2=A0=C2=A0 struct intel_pmt_entry *entry);
> +void intel_pmt_release_endpoint(struct class_endpoint *ep);
> +
> =C2=A0#endif
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c
> b/drivers/platform/x86/intel/pmt/telemetry.c
> index ac3a9bdf5601..27d09867e6a3 100644
> --- a/drivers/platform/x86/intel/pmt/telemetry.c
> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/overflow.h>
> =C2=A0
> =C2=A0#include "class.h"
> +#include "telemetry.h"
> =C2=A0
> =C2=A0#define TELEM_SIZE_OFFSET	0x0
> =C2=A0#define TELEM_GUID_OFFSET	0x4
> @@ -93,48 +94,14 @@ static int pmt_telem_header_decode(struct intel_pmt_e=
ntry
> *entry,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static int pmt_telem_add_endpoint(struct intel_vsec_device *ivdev,
> -				=C2=A0 struct intel_pmt_entry *entry)
> -{
> -	struct telem_endpoint *ep;
> -
> -	/* Endpoint lifetimes are managed by kref, not devres */
> -	entry->ep =3D kzalloc(sizeof(*(entry->ep)), GFP_KERNEL);
> -	if (!entry->ep)
> -		return -ENOMEM;
> -
> -	ep =3D entry->ep;
> -	ep->pcidev =3D ivdev->pcidev;
> -	ep->header.access_type =3D entry->header.access_type;
> -	ep->header.guid =3D entry->header.guid;
> -	ep->header.base_offset =3D entry->header.base_offset;
> -	ep->header.size =3D entry->header.size;
> -	ep->base =3D entry->base;
> -	ep->present =3D true;
> -	ep->cb =3D ivdev->priv_data;
> -
> -	kref_init(&ep->kref);
> -
> -	return 0;
> -}
> -
> =C2=A0static DEFINE_XARRAY_ALLOC(telem_array);
> =C2=A0static struct intel_pmt_namespace pmt_telem_ns =3D {
> =C2=A0	.name =3D "telem",
> =C2=A0	.xa =3D &telem_array,
> =C2=A0	.pmt_header_decode =3D pmt_telem_header_decode,
> -	.pmt_add_endpoint =3D pmt_telem_add_endpoint,
> +	.pmt_add_endpoint =3D intel_pmt_add_endpoint,
> =C2=A0};
> =C2=A0
> -/* Called when all users unregister and the device is removed */
> -static void pmt_telem_ep_release(struct kref *kref)
> -{
> -	struct telem_endpoint *ep;
> -
> -	ep =3D container_of(kref, struct telem_endpoint, kref);
> -	kfree(ep);
> -}
> -
> =C2=A0unsigned long pmt_telem_get_next_endpoint(unsigned long start)
> =C2=A0{
> =C2=A0	struct intel_pmt_entry *entry;
> @@ -155,7 +122,7 @@ unsigned long pmt_telem_get_next_endpoint(unsigned lo=
ng
> start)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_get_next_endpoint, "INTEL_PMT_TELEME=
TRY");
> =C2=A0
> -struct telem_endpoint *pmt_telem_register_endpoint(int devid)
> +struct class_endpoint *pmt_telem_register_endpoint(int devid)
> =C2=A0{
> =C2=A0	struct intel_pmt_entry *entry;
> =C2=A0	unsigned long index =3D devid;
> @@ -174,9 +141,9 @@ struct telem_endpoint *pmt_telem_register_endpoint(in=
t
> devid)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_register_endpoint, "INTEL_PMT_TELEME=
TRY");
> =C2=A0
> -void pmt_telem_unregister_endpoint(struct telem_endpoint *ep)
> +void pmt_telem_unregister_endpoint(struct class_endpoint *ep)
> =C2=A0{
> -	kref_put(&ep->kref, pmt_telem_ep_release);
> +	intel_pmt_release_endpoint(ep);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_unregister_endpoint, "INTEL_PMT_TELE=
METRY");
> =C2=A0
> @@ -206,7 +173,7 @@ int pmt_telem_get_endpoint_info(int devid, struct
> telem_endpoint_info *info)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_get_endpoint_info, "INTEL_PMT_TELEME=
TRY");
> =C2=A0
> -int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32 cou=
nt)
> +int pmt_telem_read(struct class_endpoint *ep, u32 id, u64 *data, u32 cou=
nt)
> =C2=A0{
> =C2=A0	u32 offset, size;
> =C2=A0
> @@ -226,7 +193,7 @@ int pmt_telem_read(struct telem_endpoint *ep, u32 id,=
 u64
> *data, u32 count)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_read, "INTEL_PMT_TELEMETRY");
> =C2=A0
> -int pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data, u32 c=
ount)
> +int pmt_telem_read32(struct class_endpoint *ep, u32 id, u32 *data, u32 c=
ount)
> =C2=A0{
> =C2=A0	u32 offset, size;
> =C2=A0
> @@ -245,7 +212,7 @@ int pmt_telem_read32(struct telem_endpoint *ep, u32 i=
d,
> u32 *data, u32 count)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_read32, "INTEL_PMT_TELEMETRY");
> =C2=A0
> -struct telem_endpoint *
> +struct class_endpoint *
> =C2=A0pmt_telem_find_and_register_endpoint(struct pci_dev *pcidev, u32 gu=
id, u16
> pos)
> =C2=A0{
> =C2=A0	int devid =3D 0;
> @@ -279,7 +246,7 @@ static void pmt_telem_remove(struct auxiliary_device
> *auxdev)
> =C2=A0	for (i =3D 0; i < priv->num_entries; i++) {
> =C2=A0		struct intel_pmt_entry *entry =3D &priv->entry[i];
> =C2=A0
> -		kref_put(&entry->ep->kref, pmt_telem_ep_release);
> +		pmt_telem_unregister_endpoint(entry->ep);
> =C2=A0		intel_pmt_dev_destroy(entry, &pmt_telem_ns);
> =C2=A0	}
> =C2=A0	mutex_unlock(&ep_lock);
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.h
> b/drivers/platform/x86/intel/pmt/telemetry.h
> index d45af5512b4e..e987dd32a58a 100644
> --- a/drivers/platform/x86/intel/pmt/telemetry.h
> +++ b/drivers/platform/x86/intel/pmt/telemetry.h
> @@ -2,6 +2,8 @@
> =C2=A0#ifndef _TELEMETRY_H
> =C2=A0#define _TELEMETRY_H
> =C2=A0
> +#include "class.h"
> +
> =C2=A0/* Telemetry types */
> =C2=A0#define PMT_TELEM_TELEMETRY	0
> =C2=A0#define PMT_TELEM_CRASHLOG	1
> @@ -9,16 +11,9 @@
> =C2=A0struct telem_endpoint;
> =C2=A0struct pci_dev;
> =C2=A0
> -struct telem_header {
> -	u8	access_type;
> -	u16	size;
> -	u32	guid;
> -	u32	base_offset;
> -};
> -
> =C2=A0struct telem_endpoint_info {
> =C2=A0	struct pci_dev		*pdev;
> -	struct telem_header	header;
> +	struct class_header	header;
> =C2=A0};
> =C2=A0
> =C2=A0/**
> @@ -47,7 +42,7 @@ unsigned long pmt_telem_get_next_endpoint(unsigned long
> start);
> =C2=A0 * * endpoint=C2=A0=C2=A0=C2=A0 - On success returns pointer to the=
 telemetry endpoint
> =C2=A0 * * -ENXIO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - telemetry endpoint not =
found
> =C2=A0 */
> -struct telem_endpoint *pmt_telem_register_endpoint(int devid);
> +struct class_endpoint *pmt_telem_register_endpoint(int devid);
> =C2=A0
> =C2=A0/**
> =C2=A0 * pmt_telem_unregister_endpoint() - Unregister a telemetry endpoin=
t
> @@ -55,7 +50,7 @@ struct telem_endpoint *pmt_telem_register_endpoint(int
> devid);
> =C2=A0 *
> =C2=A0 * Decrements the kref usage counter for the endpoint.
> =C2=A0 */
> -void pmt_telem_unregister_endpoint(struct telem_endpoint *ep);
> +void pmt_telem_unregister_endpoint(struct class_endpoint *ep);
> =C2=A0
> =C2=A0/**
> =C2=A0 * pmt_telem_get_endpoint_info() - Get info for an endpoint from it=
s devid
> @@ -80,8 +75,8 @@ int pmt_telem_get_endpoint_info(int devid, struct
> telem_endpoint_info *info);
> =C2=A0 * * endpoint=C2=A0=C2=A0=C2=A0 - On success returns pointer to the=
 telemetry endpoint
> =C2=A0 * * -ENXIO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - telemetry endpoint not =
found
> =C2=A0 */
> -struct telem_endpoint *pmt_telem_find_and_register_endpoint(struct pci_d=
ev
> *pcidev,
> -				u32 guid, u16 pos);
> +struct class_endpoint *pmt_telem_find_and_register_endpoint(struct pci_d=
ev
> *pcidev,
> +							=C2=A0=C2=A0=C2=A0 u32 guid, u16
> pos);
> =C2=A0
> =C2=A0/**
> =C2=A0 * pmt_telem_read() - Read qwords from counter sram using sample id
> @@ -101,7 +96,7 @@ struct telem_endpoint
> *pmt_telem_find_and_register_endpoint(struct pci_dev *pcid
> =C2=A0 * * -EPIPE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The device was removed =
during the read. Data written
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but should be considered invalid.
> =C2=A0 */
> -int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32 cou=
nt);
> +int pmt_telem_read(struct class_endpoint *ep, u32 id, u64 *data, u32 cou=
nt);
> =C2=A0
> =C2=A0/**
> =C2=A0 * pmt_telem_read32() - Read qwords from counter sram using sample =
id
> @@ -121,6 +116,6 @@ int pmt_telem_read(struct telem_endpoint *ep, u32 id,=
 u64
> *data, u32 count);
> =C2=A0 * * -EPIPE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The device was removed =
during the read. Data written
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but should be considered invalid.
> =C2=A0 */
> -int pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data, u32
> count);
> +int pmt_telem_read32(struct class_endpoint *ep, u32 id, u32 *data, u32
> count);
> =C2=A0
> =C2=A0#endif


