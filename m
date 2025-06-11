Return-Path: <stable+bounces-152434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C96AD56FB
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F3917D3EB
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46528851A;
	Wed, 11 Jun 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUff7qQY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8C288CBA;
	Wed, 11 Jun 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648571; cv=none; b=PbLDCXBIcISo8n7p3Yk8Cs4VgfqSvxuYvNENsHfTWlbcI4bFzhkw9EodaBAG5DxqgqHfzR4YAUplvDW/oNg5WBEWxSV0blb1saE3Sv8m7NBQLy6PGf0Rx73GsxnmJxWAncgS8S1yQXlAE6U4XIRDG5TIglqpeEwoJgIY4jYzwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648571; c=relaxed/simple;
	bh=d2mcdUmO+BYF/qbSZuCE4ru87gtgJ35/TnOg6YcwVQY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=okNu9tkTcOS2JSWqMDwl+qGKJWFCjssWe32uSFea3e7ICKwaYRULyMzAOG7wtb9Aw5zmGsfLOmXgvELphmoSMdgqPMQaVCZAOtr1pSEcVzX79HdhrbLOo5x/Ju17q1FZdpLjHCU2nqhqhHNQHyQbMXVUFWlcgBGnL+XwIkaUd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUff7qQY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749648570; x=1781184570;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=d2mcdUmO+BYF/qbSZuCE4ru87gtgJ35/TnOg6YcwVQY=;
  b=MUff7qQYh2kYXzFlHtDzhnt7jmf9dYNppkAApeukzCt0KNQX5/KoVVgW
   l19lEheBab7zemrM/Ei6nPFEEyphFAx58ESmZ6cn56kDzhKPJR2di8zt8
   nueH+TtEDqlN4qZ6UhVcLuOLJF6NERyVvFGNM3riPTVxe2nycU76me+xF
   3UE1bYL2RAp329weSkarx/5J3dLDilAIAqENjpgjBIYylnRxL93YBA1Ax
   /UofL/8kd1FKgmxwpbpgnuML+RdT/g8HevSMrMbBBp+F7FuA4Mxam/DVh
   o3eVnUp223um+DjHgYI6yN6zBCaR8JgkRdGWw8c5XEliXQqyMKPkHgm3C
   A==;
X-CSE-ConnectionGUID: iqOei3iRRP2AR8t93woZ6w==
X-CSE-MsgGUID: ObQ/5tDlSbaqF2NtxSiK6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51783995"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51783995"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:29:29 -0700
X-CSE-ConnectionGUID: V0dsG4E1QFq903s7ubTtcA==
X-CSE-MsgGUID: NL47asc7TUKj245eMOh51Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="150995910"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:29:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 16:29:21 +0300 (EEST)
To: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
cc: "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    "De Marchi, Lucas" <lucas.demarchi@intel.com>, 
    "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, 
    "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>, 
    "airlied@gmail.com" <airlied@gmail.com>, 
    "simona@ffwll.ch" <simona@ffwll.ch>, 
    "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>, 
    "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v4 01/10] platform/x86/intel/pmt: fix a crashlog NULL
 pointer access
In-Reply-To: <IA1PR11MB6418026EFDD6B6EAD882CA95C175A@IA1PR11MB6418.namprd11.prod.outlook.com>
Message-ID: <1530a75b-fe92-b6de-6c97-bf8de20241be@linux.intel.com>
References: <20250610211225.1085901-1-michael.j.ruhl@intel.com> <20250610211225.1085901-2-michael.j.ruhl@intel.com> <e4f3a1e0-5332-212d-6ad0-8a72dcaf554a@linux.intel.com> <IA1PR11MB6418026EFDD6B6EAD882CA95C175A@IA1PR11MB6418.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1373891594-1749648561=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1373891594-1749648561=:957
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Ruhl, Michael J wrote:

> >-----Original Message-----
> >From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> >Sent: Wednesday, June 11, 2025 6:42 AM
> >To: Ruhl, Michael J <michael.j.ruhl@intel.com>
> >Cc: platform-driver-x86@vger.kernel.org; intel-xe@lists.freedesktop.org;=
 Hans
> >de Goede <hdegoede@redhat.com>; De Marchi, Lucas
> ><lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>;
> >thomas.hellstrom@linux.intel.com; airlied@gmail.com; simona@ffwll.ch;
> >david.e.box@linux.intel.com; stable@vger.kernel.org
> >Subject: Re: [PATCH v4 01/10] platform/x86/intel/pmt: fix a crashlog NUL=
L
> >pointer access
> >
> >On Tue, 10 Jun 2025, Michael J. Ruhl wrote:
> >
> >> Usage of the intel_pmt_read() for binary sysfs, requires a pcidev.  Th=
e
> >> current use of the endpoint value is only valid for telemetry endpoint
> >> usage.
> >>
> >> Without the ep, the crashlog usage causes the following NULL pointer
> >> exception:
> >>
> >> BUG: kernel NULL pointer dereference, address: 0000000000000000
> >> Oops: Oops: 0000 [#1] SMP NOPTI
> >> RIP: 0010:intel_pmt_read+0x3b/0x70 [pmt_class]
> >> Code:
> >> Call Trace:
> >>  <TASK>
> >>  ? sysfs_kf_bin_read+0xc0/0xe0
> >>  kernfs_fop_read_iter+0xac/0x1a0
> >>  vfs_read+0x26d/0x350
> >>  ksys_read+0x6b/0xe0
> >>  __x64_sys_read+0x1d/0x30
> >>  x64_sys_call+0x1bc8/0x1d70
> >>  do_syscall_64+0x6d/0x110
> >>
> >> Augment the inte_pmt_entry to include the pcidev to allow for access t=
o
> >
> >intel_pmt_entry
>=20
> I have also been told that should be "intel_pmt_entry()"....  when I redo=
, is that
> more correct?

?? For structs, don't use (). Use () after any name that refers to a=20
C function or a function like macro.

You could also say the struct intel_pmt_entry to indicate unambiguously to=
=20
the reader what kind of object sits behind the name.

> Thanks,
>=20
> M
>=20
> >> the pcidev and avoid the NULL pointer exception.
> >>
> >> Fixes: 416eeb2e1fc7 ("platform/x86/intel/pmt: telemetry: Export API to=
 read
> >telemetry")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> >> ---
> >>  drivers/platform/x86/intel/pmt/class.c | 3 ++-
> >>  drivers/platform/x86/intel/pmt/class.h | 1 +
> >>  2 files changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/platform/x86/intel/pmt/class.c
> >b/drivers/platform/x86/intel/pmt/class.c
> >> index 7233b654bbad..d046e8752173 100644
> >> --- a/drivers/platform/x86/intel/pmt/class.c
> >> +++ b/drivers/platform/x86/intel/pmt/class.c
> >> @@ -97,7 +97,7 @@ intel_pmt_read(struct file *filp, struct kobject *ko=
bj,
> >>  =09if (count > entry->size - off)
> >>  =09=09count =3D entry->size - off;
> >>
> >> -=09count =3D pmt_telem_read_mmio(entry->ep->pcidev, entry->cb, entry-
> >>header.guid, buf,
> >> +=09count =3D pmt_telem_read_mmio(entry->pcidev, entry->cb, entry-
> >>header.guid, buf,
> >>  =09=09=09=09    entry->base, off, count);
> >>
> >>  =09return count;
> >> @@ -252,6 +252,7 @@ static int intel_pmt_populate_entry(struct
> >intel_pmt_entry *entry,
> >>  =09=09return -EINVAL;
> >>  =09}
> >>
> >> +=09entry->pcidev =3D pci_dev;
> >>  =09entry->guid =3D header->guid;
> >>  =09entry->size =3D header->size;
> >>  =09entry->cb =3D ivdev->priv_data;
> >> diff --git a/drivers/platform/x86/intel/pmt/class.h
> >b/drivers/platform/x86/intel/pmt/class.h
> >> index b2006d57779d..f6ce80c4e051 100644
> >> --- a/drivers/platform/x86/intel/pmt/class.h
> >> +++ b/drivers/platform/x86/intel/pmt/class.h
> >> @@ -39,6 +39,7 @@ struct intel_pmt_header {
> >>
> >>  struct intel_pmt_entry {
> >>  =09struct telem_endpoint=09*ep;
> >> +=09struct pci_dev=09=09*pcidev;
> >>  =09struct intel_pmt_header=09header;
> >>  =09struct bin_attribute=09pmt_bin_attr;
> >>  =09struct kobject=09=09*kobj;
> >>
> >
> >--
> > i.
>=20

--=20
 i.

--8323328-1373891594-1749648561=:957--

