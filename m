Return-Path: <stable+bounces-152180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB1BAD249B
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 19:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6132165FB2
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CCF21ADBA;
	Mon,  9 Jun 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7VGvOF6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5F217654;
	Mon,  9 Jun 2025 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488679; cv=none; b=Ifg8h4YjU4C5x/FKLECgtnawIGp3Za/cm9nh9ygBt4w2vZ0xm1h4ly/EnYFG0+GywBQ4+krZoO+qQF0+h3tM0DJtlFJ2MRYqMEs0TpAOwvxBQaN4uEZ8i1pf3F/7rE8EjWNdWNiREDdQMhKPX/Zz3YflZNBPKMlTDYreFHeLc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488679; c=relaxed/simple;
	bh=ckVkn/Yrc+uXGBRpLyshPDogbBrNhrcJL5YQP1M2j0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nn+vGbKAWsp+zMbAWsshgA6e88jQMFUHUUQtpHmUnMPs5ofcUYO5efS7V+Ng/TfMqhlFYJ9KcZ/EGZFZudd3xrRYLOWump5Ur9qsSdX753na98WcvVdACXccVFVjxvkWCNS5W0H96Nljzur8PokZVB+Hfcysw/VJnZeVy3Gc21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7VGvOF6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749488677; x=1781024677;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ckVkn/Yrc+uXGBRpLyshPDogbBrNhrcJL5YQP1M2j0I=;
  b=Y7VGvOF6UGv2vNqemFRwknhnYTq9nb0A27LbKLLwYoysVSQRHczfLSkx
   SeiOCHZjV7+UGf74gePiivHcsjwxTXOyoa68qXr2Usj6tff+/Uo9HweNh
   ThNJk6EPoWez+n7kbY+q5VrAecJQIPJUMi+dULq6XrStRjGoxnXpX+gvx
   gLTQIZGTJCVIwNIMPxWCfmKh3DI4y+MtDSZ1oTaVhMR0NyETGZppywi0y
   UXaWddGd18nqOGCxzKnzklzTcm+epQXiSNgv019R8mkZycHcwEeyxYiwq
   bacYnr5mYzOfOJTie6KsO1/2p6rv5QLbzS0CBfznA5MI4eszpXUzoRzfZ
   w==;
X-CSE-ConnectionGUID: iRBrMzgfTgOa7ymgv+f4WA==
X-CSE-MsgGUID: k4BXJwqbT1GlWE0Ck8ppfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62192204"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="62192204"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 10:04:36 -0700
X-CSE-ConnectionGUID: u3gRKOn0QMmncX0Ikgr6HA==
X-CSE-MsgGUID: 42NHCEatQ9eo1T3vKT2zZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="151563820"
Received: from msatwood-mobl.amr.corp.intel.com ([10.124.223.153])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 10:04:34 -0700
Message-ID: <fca30e40636e83ef014026c233a71947fe8eecbd.camel@linux.intel.com>
Subject: Re: [PATCH v3 01/11] platform/x86/intel: refactor endpoint usage
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: "Ruhl, Michael J" <michael.j.ruhl@intel.com>, 
 "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "hdegoede@redhat.com"
 <hdegoede@redhat.com>,  "ilpo.jarvinen@linux.intel.com"
 <ilpo.jarvinen@linux.intel.com>, "De Marchi, Lucas"
 <lucas.demarchi@intel.com>,  "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Mon, 09 Jun 2025 10:04:33 -0700
In-Reply-To: <IA1PR11MB6418974C933BEDBF6EB62498C16EA@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20250605184444.515556-1-michael.j.ruhl@intel.com>
	 <20250605184444.515556-2-michael.j.ruhl@intel.com>
	 <d5d9b7cc5768c7715e8ac020e4a098d51fce69da.camel@linux.intel.com>
	 <IA1PR11MB6418974C933BEDBF6EB62498C16EA@IA1PR11MB6418.namprd11.prod.outlook.com>
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

On Fri, 2025-06-06 at 19:20 +0000, Ruhl, Michael J wrote:
> > -----Original Message-----
> > From: David E. Box <david.e.box@linux.intel.com>
> > Sent: Friday, June 6, 2025 1:55 PM
> > To: Ruhl, Michael J <michael.j.ruhl@intel.com>; platform-driver-
> > x86@vger.kernel.org; intel-xe@lists.freedesktop.org; hdegoede@redhat.co=
m;
> > ilpo.jarvinen@linux.intel.com; De Marchi, Lucas <lucas.demarchi@intel.c=
om>;
> > Vivi, Rodrigo <rodrigo.vivi@intel.com>; thomas.hellstrom@linux.intel.co=
m;
> > airlied@gmail.com; simona@ffwll.ch
> > Cc: stable@vger.kernel.org
> > Subject: Re: [PATCH v3 01/11] platform/x86/intel: refactor endpoint usa=
ge
> >=20
> > Hi Mike,
> >=20
> > On Thu, 2025-06-05 at 14:44 -0400, Michael J. Ruhl wrote:
> > > The use of an endpoint has introduced a dependency in all class/pmt
> > > drivers to have an endpoint allocated.
> > >=20
> > > The telemetry driver has this allocation, the crashlog does not.
> > >=20
> > > The current usage is very telemetry focused, but should be common cod=
e.
> >=20
> > The endpoint exists specifically to support the exported APIs in the
> > telemetry
> > driver. It's reference-counted via kref to ensure safe cleanup once all=
 API
> > consumers are done. Unless the kernel needs to invoke a crashlog API th=
rough
> > this mechanism, I=E2=80=99m not sure this change is necessary. I=E2=80=
=99ll go through the
> > rest
> > of the patches to understand how the endpoint is being used, but my ini=
tial
> > reaction is that is not be needed.
> >=20
> >=20
> > >=20
> > > With this in mind:
> > > =C2=A0 rename the struct telemetry_endpoint to struct class_endpoint,
> > > =C2=A0 refactor the common endpoint code to be in the class.c module
> > >=20
> > > Fixes: 416eeb2e1fc7 ("platform/x86/intel/pmt: telemetry: Export API t=
o
> > > read
> > > telemetry")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> > > ---
> > > =C2=A0drivers/platform/x86/intel/pmc/core.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 3 +-
> > > =C2=A0drivers/platform/x86/intel/pmc/core.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 +-
> > > =C2=A0drivers/platform/x86/intel/pmc/core_ssram.c |=C2=A0 2 +-
> > > =C2=A0drivers/platform/x86/intel/pmt/class.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 45 ++++++++++++++++++
> > > =C2=A0drivers/platform/x86/intel/pmt/class.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 21 +++++++--
> > > =C2=A0drivers/platform/x86/intel/pmt/telemetry.c=C2=A0 | 51 ++++-----=
------------
> > > =C2=A0drivers/platform/x86/intel/pmt/telemetry.h=C2=A0 | 23 ++++-----=
-
> > > =C2=A07 files changed, 84 insertions(+), 65 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/pmc/core.c
> > > b/drivers/platform/x86/intel/pmc/core.c
> > > index 7a1d11f2914f..805f56665d1d 100644
> > > --- a/drivers/platform/x86/intel/pmc/core.c
> > > +++ b/drivers/platform/x86/intel/pmc/core.c
> > > @@ -29,6 +29,7 @@
> > > =C2=A0#include <asm/tsc.h>
> > >=20
> > > =C2=A0#include "core.h"
> > > +#include "../pmt/class.h"
> > > =C2=A0#include "../pmt/telemetry.h"
> > >=20
> > > =C2=A0/* Maximum number of modes supported by platfoms that has low p=
ower
> > mode
> > > capability */
> > > @@ -1198,7 +1199,7 @@ int get_primary_reg_base(struct pmc *pmc)
> > >=20
> > > =C2=A0void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid)
> > > =C2=A0{
> > > -	struct telem_endpoint *ep;
> > > +	struct class_endpoint *ep;
> >=20
> > I'd name it pmt_endpoint instead of class_endpoint.
>=20
> Wil do.
>=20
> > > =C2=A0	struct pci_dev *pcidev;
> > >=20
> > > =C2=A0	pcidev =3D pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(10, 0))=
;
> > > diff --git a/drivers/platform/x86/intel/pmc/core.h
> > > b/drivers/platform/x86/intel/pmc/core.h
> > > index 945a1c440cca..1c12ea7c3ce3 100644
> > > --- a/drivers/platform/x86/intel/pmc/core.h
> > > +++ b/drivers/platform/x86/intel/pmc/core.h
> > > @@ -16,7 +16,7 @@
> > > =C2=A0#include <linux/bits.h>
> > > =C2=A0#include <linux/platform_device.h>
> > >=20
> > > -struct telem_endpoint;
> > > +struct class_endpoint;
> > >=20
> > > =C2=A0#define SLP_S0_RES_COUNTER_MASK			GENMASK(31,
> > 0)
> > >=20
> > > @@ -432,7 +432,7 @@ struct pmc_dev {
> > >=20
> > > =C2=A0	bool has_die_c6;
> > > =C2=A0	u32 die_c6_offset;
> > > -	struct telem_endpoint *punit_ep;
> > > +	struct class_endpoint *punit_ep;
> > > =C2=A0	struct pmc_info *regmap_list;
> > > =C2=A0};
> > >=20
> > > diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c
> > > b/drivers/platform/x86/intel/pmc/core_ssram.c
> > > index 739569803017..3e670fc380a5 100644
> > > --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> > > +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> > > @@ -42,7 +42,7 @@ static u32 pmc_core_find_guid(struct pmc_info *list=
,
> > const
> > > struct pmc_reg_map *m
> > >=20
> > > =C2=A0static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct =
pmc *pmc)
> > > =C2=A0{
> > > -	struct telem_endpoint *ep;
> > > +	struct class_endpoint *ep;
> > > =C2=A0	const u8 *lpm_indices;
> > > =C2=A0	int num_maps, mode_offset =3D 0;
> > > =C2=A0	int ret, mode;
> > > diff --git a/drivers/platform/x86/intel/pmt/class.c
> > > b/drivers/platform/x86/intel/pmt/class.c
> > > index 7233b654bbad..bba552131bc2 100644
> > > --- a/drivers/platform/x86/intel/pmt/class.c
> > > +++ b/drivers/platform/x86/intel/pmt/class.c
> > > @@ -76,6 +76,47 @@ int pmt_telem_read_mmio(struct pci_dev *pdev,
> > struct
> > > pmt_callbacks *cb, u32 guid
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_read_mmio, "INTEL_PMT");
> > >=20
> > > +/* Called when all users unregister and the device is removed */
> > > +static void pmt_class_ep_release(struct kref *kref)
> > > +{
> > > +	struct class_endpoint *ep;
> > > +
> > > +	ep =3D container_of(kref, struct class_endpoint, kref);
> > > +	kfree(ep);
> > > +}
> > > +
> > > +void intel_pmt_release_endpoint(struct class_endpoint *ep)
> > > +{
> > > +	kref_put(&ep->kref, pmt_class_ep_release);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(intel_pmt_release_endpoint, "INTEL_PMT");
> > > +
> > > +int intel_pmt_add_endpoint(struct intel_vsec_device *ivdev,
> > > +			=C2=A0=C2=A0 struct intel_pmt_entry *entry)
> > > +{
> > > +	struct class_endpoint *ep;
> > > +
> > > +	ep =3D kzalloc(sizeof(*ep), GFP_KERNEL);
> > > +	if (!ep)
> > > +		return -ENOMEM;
> > > +
> > > +	ep->pcidev =3D ivdev->pcidev;
> > > +	ep->header.access_type =3D entry->header.access_type;
> > > +	ep->header.guid =3D entry->header.guid;
> > > +	ep->header.base_offset =3D entry->header.base_offset;
> > > +	ep->header.size =3D entry->header.size;
> > > +	ep->base =3D entry->base;
> > > +	ep->present =3D true;
> > > +	ep->cb =3D ivdev->priv_data;
> > > +
> > > +	/* Endpoint lifetimes are managed by kref, not devres */
> > > +	kref_init(&ep->kref);
> > > +
> > > +	entry->ep =3D ep;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(intel_pmt_add_endpoint, "INTEL_PMT");
> > > =C2=A0/*
> > > =C2=A0 * sysfs
> > > =C2=A0 */
> > > @@ -97,6 +138,10 @@ intel_pmt_read(struct file *filp, struct kobject
> > > *kobj,
> > > =C2=A0	if (count > entry->size - off)
> > > =C2=A0		count =3D entry->size - off;
> > >=20
> > > +	/* verify endpoint is available */
> > > +	if (!entry->ep)
> > > +		return -ENODEV;
> > > +
> >=20
> > Hmm ...
> >=20
> > > =C2=A0	count =3D pmt_telem_read_mmio(entry->ep->pcidev, entry->cb, en=
try-
> > > > header.guid, buf,
> > > =C2=A0				=C2=A0=C2=A0=C2=A0 entry->base, off, count);
> >=20
> > ... intel_pmt_read() is only intended to handle sysfs reads, not to acc=
ess
> > driver endpoints. But entry->ep is a handle registered by a driver via
> > pmt_telem_find_and_register_endpoint() which won=E2=80=99t be called un=
less another
> > driver explicitly does so. If no driver registers the endpoint, entry->=
ep
> > will
> > be NULL, and this read path will dereference it, leading to a NULL poin=
ter
> > bug.
> >=20
> > This call to entry->ep->pcidev shouldn't be here. It mistakenly mixes t=
he
> > sysfs
> > path with the driver API path. Actual use of entry->ep belongs only in =
the
> > exported read calls in telemetry.c.
>=20
> An additional issue here is that the callback interface requires the pcid=
ev.
>=20
> Is the pcidev available form a different location? (I am not seeing it...=
)
>=20
> Maybe the pcidev * should be moved to the intel_pmt_entry struct?

Yes. After looking through this series, I don't see a need for this patch t=
o
extend telem_enpoint for general use. Let's just place a copy of the pdev i=
n
entry. Then you can drop the first two patches.

David


>=20
> Thanks,
>=20
> Mike
>=20
> > David
> >=20
> > >=20
> > > diff --git a/drivers/platform/x86/intel/pmt/class.h
> > > b/drivers/platform/x86/intel/pmt/class.h
> > > index b2006d57779d..d2d8f9e31c9d 100644
> > > --- a/drivers/platform/x86/intel/pmt/class.h
> > > +++ b/drivers/platform/x86/intel/pmt/class.h
> > > @@ -9,8 +9,6 @@
> > > =C2=A0#include <linux/err.h>
> > > =C2=A0#include <linux/io.h>
> > >=20
> > > -#include "telemetry.h"
> > > -
> > > =C2=A0/* PMT access types */
> > > =C2=A0#define ACCESS_BARID		2
> > > =C2=A0#define ACCESS_LOCAL		3
> > > @@ -19,11 +17,19 @@
> > > =C2=A0#define GET_BIR(v)		((v) & GENMASK(2, 0))
> > > =C2=A0#define GET_ADDRESS(v)		((v) & GENMASK(31, 3))
> > >=20
> > > +struct kref;
> > > =C2=A0struct pci_dev;
> > >=20
> > > -struct telem_endpoint {
> > > +struct class_header {
> > > +	u8	access_type;
> > > +	u16	size;
> > > +	u32	guid;
> > > +	u32	base_offset;
> > > +};
> > > +
> > > +struct class_endpoint {
> > > =C2=A0	struct pci_dev		*pcidev;
> > > -	struct telem_header	header;
> > > +	struct class_header	header;
> > > =C2=A0	struct pmt_callbacks	*cb;
> > > =C2=A0	void __iomem		*base;
> > > =C2=A0	bool			present;
> > > @@ -38,7 +44,7 @@ struct intel_pmt_header {
> > > =C2=A0};
> > >=20
> > > =C2=A0struct intel_pmt_entry {
> > > -	struct telem_endpoint	*ep;
> > > +	struct class_endpoint	*ep;
> > > =C2=A0	struct intel_pmt_header	header;
> > > =C2=A0	struct bin_attribute	pmt_bin_attr;
> > > =C2=A0	struct kobject		*kobj;
> > > @@ -69,4 +75,9 @@ int intel_pmt_dev_create(struct intel_pmt_entry
> > *entry,
> > > =C2=A0			 struct intel_vsec_device *dev, int idx);
> > > =C2=A0void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
> > > =C2=A0			=C2=A0=C2=A0 struct intel_pmt_namespace *ns);
> > > +
> > > +int intel_pmt_add_endpoint(struct intel_vsec_device *ivdev,
> > > +			=C2=A0=C2=A0 struct intel_pmt_entry *entry);
> > > +void intel_pmt_release_endpoint(struct class_endpoint *ep);
> > > +
> > > =C2=A0#endif
> > > diff --git a/drivers/platform/x86/intel/pmt/telemetry.c
> > > b/drivers/platform/x86/intel/pmt/telemetry.c
> > > index ac3a9bdf5601..27d09867e6a3 100644
> > > --- a/drivers/platform/x86/intel/pmt/telemetry.c
> > > +++ b/drivers/platform/x86/intel/pmt/telemetry.c
> > > @@ -18,6 +18,7 @@
> > > =C2=A0#include <linux/overflow.h>
> > >=20
> > > =C2=A0#include "class.h"
> > > +#include "telemetry.h"
> > >=20
> > > =C2=A0#define TELEM_SIZE_OFFSET	0x0
> > > =C2=A0#define TELEM_GUID_OFFSET	0x4
> > > @@ -93,48 +94,14 @@ static int pmt_telem_header_decode(struct
> > intel_pmt_entry
> > > *entry,
> > > =C2=A0	return 0;
> > > =C2=A0}
> > >=20
> > > -static int pmt_telem_add_endpoint(struct intel_vsec_device *ivdev,
> > > -				=C2=A0 struct intel_pmt_entry *entry)
> > > -{
> > > -	struct telem_endpoint *ep;
> > > -
> > > -	/* Endpoint lifetimes are managed by kref, not devres */
> > > -	entry->ep =3D kzalloc(sizeof(*(entry->ep)), GFP_KERNEL);
> > > -	if (!entry->ep)
> > > -		return -ENOMEM;
> > > -
> > > -	ep =3D entry->ep;
> > > -	ep->pcidev =3D ivdev->pcidev;
> > > -	ep->header.access_type =3D entry->header.access_type;
> > > -	ep->header.guid =3D entry->header.guid;
> > > -	ep->header.base_offset =3D entry->header.base_offset;
> > > -	ep->header.size =3D entry->header.size;
> > > -	ep->base =3D entry->base;
> > > -	ep->present =3D true;
> > > -	ep->cb =3D ivdev->priv_data;
> > > -
> > > -	kref_init(&ep->kref);
> > > -
> > > -	return 0;
> > > -}
> > > -
> > > =C2=A0static DEFINE_XARRAY_ALLOC(telem_array);
> > > =C2=A0static struct intel_pmt_namespace pmt_telem_ns =3D {
> > > =C2=A0	.name =3D "telem",
> > > =C2=A0	.xa =3D &telem_array,
> > > =C2=A0	.pmt_header_decode =3D pmt_telem_header_decode,
> > > -	.pmt_add_endpoint =3D pmt_telem_add_endpoint,
> > > +	.pmt_add_endpoint =3D intel_pmt_add_endpoint,
> > > =C2=A0};
> > >=20
> > > -/* Called when all users unregister and the device is removed */
> > > -static void pmt_telem_ep_release(struct kref *kref)
> > > -{
> > > -	struct telem_endpoint *ep;
> > > -
> > > -	ep =3D container_of(kref, struct telem_endpoint, kref);
> > > -	kfree(ep);
> > > -}
> > > -
> > > =C2=A0unsigned long pmt_telem_get_next_endpoint(unsigned long start)
> > > =C2=A0{
> > > =C2=A0	struct intel_pmt_entry *entry;
> > > @@ -155,7 +122,7 @@ unsigned long
> > pmt_telem_get_next_endpoint(unsigned long
> > > start)
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_get_next_endpoint,
> > "INTEL_PMT_TELEMETRY");
> > >=20
> > > -struct telem_endpoint *pmt_telem_register_endpoint(int devid)
> > > +struct class_endpoint *pmt_telem_register_endpoint(int devid)
> > > =C2=A0{
> > > =C2=A0	struct intel_pmt_entry *entry;
> > > =C2=A0	unsigned long index =3D devid;
> > > @@ -174,9 +141,9 @@ struct telem_endpoint
> > *pmt_telem_register_endpoint(int
> > > devid)
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_register_endpoint,
> > "INTEL_PMT_TELEMETRY");
> > >=20
> > > -void pmt_telem_unregister_endpoint(struct telem_endpoint *ep)
> > > +void pmt_telem_unregister_endpoint(struct class_endpoint *ep)
> > > =C2=A0{
> > > -	kref_put(&ep->kref, pmt_telem_ep_release);
> > > +	intel_pmt_release_endpoint(ep);
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_unregister_endpoint,
> > "INTEL_PMT_TELEMETRY");
> > >=20
> > > @@ -206,7 +173,7 @@ int pmt_telem_get_endpoint_info(int devid, struct
> > > telem_endpoint_info *info)
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_get_endpoint_info,
> > "INTEL_PMT_TELEMETRY");
> > >=20
> > > -int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32
> > count)
> > > +int pmt_telem_read(struct class_endpoint *ep, u32 id, u64 *data, u32
> > count)
> > > =C2=A0{
> > > =C2=A0	u32 offset, size;
> > >=20
> > > @@ -226,7 +193,7 @@ int pmt_telem_read(struct telem_endpoint *ep, u32
> > id, u64
> > > *data, u32 count)
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_read, "INTEL_PMT_TELEMETRY");
> > >=20
> > > -int pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data, u=
32
> > count)
> > > +int pmt_telem_read32(struct class_endpoint *ep, u32 id, u32 *data, u=
32
> > count)
> > > =C2=A0{
> > > =C2=A0	u32 offset, size;
> > >=20
> > > @@ -245,7 +212,7 @@ int pmt_telem_read32(struct telem_endpoint *ep,
> > u32 id,
> > > u32 *data, u32 count)
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(pmt_telem_read32, "INTEL_PMT_TELEMETRY");
> > >=20
> > > -struct telem_endpoint *
> > > +struct class_endpoint *
> > > =C2=A0pmt_telem_find_and_register_endpoint(struct pci_dev *pcidev, u3=
2 guid,
> > u16
> > > pos)
> > > =C2=A0{
> > > =C2=A0	int devid =3D 0;
> > > @@ -279,7 +246,7 @@ static void pmt_telem_remove(struct
> > auxiliary_device
> > > *auxdev)
> > > =C2=A0	for (i =3D 0; i < priv->num_entries; i++) {
> > > =C2=A0		struct intel_pmt_entry *entry =3D &priv->entry[i];
> > >=20
> > > -		kref_put(&entry->ep->kref, pmt_telem_ep_release);
> > > +		pmt_telem_unregister_endpoint(entry->ep);
> > > =C2=A0		intel_pmt_dev_destroy(entry, &pmt_telem_ns);
> > > =C2=A0	}
> > > =C2=A0	mutex_unlock(&ep_lock);
> > > diff --git a/drivers/platform/x86/intel/pmt/telemetry.h
> > > b/drivers/platform/x86/intel/pmt/telemetry.h
> > > index d45af5512b4e..e987dd32a58a 100644
> > > --- a/drivers/platform/x86/intel/pmt/telemetry.h
> > > +++ b/drivers/platform/x86/intel/pmt/telemetry.h
> > > @@ -2,6 +2,8 @@
> > > =C2=A0#ifndef _TELEMETRY_H
> > > =C2=A0#define _TELEMETRY_H
> > >=20
> > > +#include "class.h"
> > > +
> > > =C2=A0/* Telemetry types */
> > > =C2=A0#define PMT_TELEM_TELEMETRY	0
> > > =C2=A0#define PMT_TELEM_CRASHLOG	1
> > > @@ -9,16 +11,9 @@
> > > =C2=A0struct telem_endpoint;
> > > =C2=A0struct pci_dev;
> > >=20
> > > -struct telem_header {
> > > -	u8	access_type;
> > > -	u16	size;
> > > -	u32	guid;
> > > -	u32	base_offset;
> > > -};
> > > -
> > > =C2=A0struct telem_endpoint_info {
> > > =C2=A0	struct pci_dev		*pdev;
> > > -	struct telem_header	header;
> > > +	struct class_header	header;
> > > =C2=A0};
> > >=20
> > > =C2=A0/**
> > > @@ -47,7 +42,7 @@ unsigned long
> > pmt_telem_get_next_endpoint(unsigned long
> > > start);
> > > =C2=A0 * * endpoint=C2=A0=C2=A0=C2=A0 - On success returns pointer to=
 the telemetry endpoint
> > > =C2=A0 * * -ENXIO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - telemetry endpoint =
not found
> > > =C2=A0 */
> > > -struct telem_endpoint *pmt_telem_register_endpoint(int devid);
> > > +struct class_endpoint *pmt_telem_register_endpoint(int devid);
> > >=20
> > > =C2=A0/**
> > > =C2=A0 * pmt_telem_unregister_endpoint() - Unregister a telemetry end=
point
> > > @@ -55,7 +50,7 @@ struct telem_endpoint
> > *pmt_telem_register_endpoint(int
> > > devid);
> > > =C2=A0 *
> > > =C2=A0 * Decrements the kref usage counter for the endpoint.
> > > =C2=A0 */
> > > -void pmt_telem_unregister_endpoint(struct telem_endpoint *ep);
> > > +void pmt_telem_unregister_endpoint(struct class_endpoint *ep);
> > >=20
> > > =C2=A0/**
> > > =C2=A0 * pmt_telem_get_endpoint_info() - Get info for an endpoint fro=
m its
> > > devid
> > > @@ -80,8 +75,8 @@ int pmt_telem_get_endpoint_info(int devid, struct
> > > telem_endpoint_info *info);
> > > =C2=A0 * * endpoint=C2=A0=C2=A0=C2=A0 - On success returns pointer to=
 the telemetry endpoint
> > > =C2=A0 * * -ENXIO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - telemetry endpoint =
not found
> > > =C2=A0 */
> > > -struct telem_endpoint *pmt_telem_find_and_register_endpoint(struct
> > pci_dev
> > > *pcidev,
> > > -				u32 guid, u16 pos);
> > > +struct class_endpoint *pmt_telem_find_and_register_endpoint(struct
> > pci_dev
> > > *pcidev,
> > > +							=C2=A0=C2=A0=C2=A0 u32 guid, u16
> > > pos);
> > >=20
> > > =C2=A0/**
> > > =C2=A0 * pmt_telem_read() - Read qwords from counter sram using sampl=
e id
> > > @@ -101,7 +96,7 @@ struct telem_endpoint
> > > *pmt_telem_find_and_register_endpoint(struct pci_dev *pcid
> > > =C2=A0 * * -EPIPE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The device was remo=
ved during the read. Data written
> > > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but should be considered invalid.
> > > =C2=A0 */
> > > -int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32
> > count);
> > > +int pmt_telem_read(struct class_endpoint *ep, u32 id, u64 *data, u32
> > count);
> > >=20
> > > =C2=A0/**
> > > =C2=A0 * pmt_telem_read32() - Read qwords from counter sram using sam=
ple id
> > > @@ -121,6 +116,6 @@ int pmt_telem_read(struct telem_endpoint *ep, u32
> > id, u64
> > > *data, u32 count);
> > > =C2=A0 * * -EPIPE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The device was remo=
ved during the read. Data written
> > > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but should be considered invalid.
> > > =C2=A0 */
> > > -int pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data, u=
32
> > > count);
> > > +int pmt_telem_read32(struct class_endpoint *ep, u32 id, u32 *data, u=
32
> > > count);
> > >=20
> > > =C2=A0#endif
>=20


