Return-Path: <stable+bounces-211382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDpjM+Z4c2kfwAAAu9opvQ
	(envelope-from <stable+bounces-211382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:34:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C27764CE
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 297B43016813
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 13:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4286314B79;
	Fri, 23 Jan 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgVcz3C3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8ED3242AD
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175267; cv=none; b=nuGvT4DzTjd/qfLL1Zqk8J61pXwLV7c3J2oxVDKZkk2lPm4F5rNsUDOC/qamg54m75uHHZlPOLO8upU0xS/UwCSgksiOrrqbnOt/tFtdl+EdBVZ1FP7L2G/o+JeWUNMYR6gukY3CBsmvLwz58ZhoXOQz2f13b2Dow8VNTOgfOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175267; c=relaxed/simple;
	bh=7oayTD6co6QgsQ4//6MfuYdj5SZ6hyLjyd7xM1Ok0pU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kvRil38P1yljmE4D59wroocy3Mjg8ioQAKMZZPQDpnQv7KX9ACPfbn2z/SQ4LpEDE8eOnDQ/Y5fN+iaDL/lRDpLU+Ay+lRqZUw71wccPfsqrsz8j8273YF8TAlUpigkLiEekWzFedqsY1L+fRbgVJ6NDJtrqc8NRUHPPZhuhxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgVcz3C3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769175265; x=1800711265;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7oayTD6co6QgsQ4//6MfuYdj5SZ6hyLjyd7xM1Ok0pU=;
  b=OgVcz3C334PSVJFU1hykppQC90dYibGxTtDBvPSDYswG2obo9wPyJrWZ
   u+5OLE5owMFCB2tbasR7y5ddv+yqhYhGV28eRFN3qQj+9sir4GVoxtmF7
   A66TxHlvlkaUVsmqngd0wqfiwIP0vj1XlvMVtHu8TITNp6movMLYvxtUP
   D912S0ca+3u+ZTW7fBKf9OU+Eu4fz3xXolvGloSe+jNzURDyB5g3FlTDl
   0wfOMFZXyr+okDWiQVqt/S6CBzUXc4QVxxqnIPsXUS0XB9kEAtSdEO+wu
   eeP6+SS619969r5sdrtSU8baXaG3tUrqjhCDMHQhJYK9VtPydYbksUAc8
   Q==;
X-CSE-ConnectionGUID: hSrCDTtCQRWHjrZ6hUoSaQ==
X-CSE-MsgGUID: lQCcuRuPSZOWN8aTqzI2rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="95897313"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="95897313"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 05:34:24 -0800
X-CSE-ConnectionGUID: FKcDDHE4SgW+MZ2YqpLZBQ==
X-CSE-MsgGUID: B3VAN+lBSxuV05gpRtUVyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211898362"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.177]) ([10.245.244.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 05:34:22 -0800
Message-ID: <34532068b6414d35264bc1d2f0a33b0a1be8fb3e.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] drm, drm/xe: Fix xe userptr in the absence of
 CONFIG_DEVICE_PRIVATE
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>, 
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, 	dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Date: Fri, 23 Jan 2026 14:34:19 +0100
In-Reply-To: <aW/D6ehR6DB2SVlf@lstrano-desk.jf.intel.com>
References: <20260120143459.9485-1-thomas.hellstrom@linux.intel.com>
	 <20260120143459.9485-2-thomas.hellstrom@linux.intel.com>
	 <aW/D6ehR6DB2SVlf@lstrano-desk.jf.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-211382-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,linux.intel.com:mid,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39C27764CE
X-Rspamd-Action: no action

On Tue, 2026-01-20 at 10:05 -0800, Matthew Brost wrote:
> On Tue, Jan 20, 2026 at 03:34:58PM +0100, Thomas Hellstr=C3=B6m wrote:
> > CONFIG_DEVICE_PRIVATE is not selected by default by some distros,
> > for example Fedora, and that leads to a regression in the xe driver
> > since userptr support gets compiled out.
> >=20
> > It turns out that DRM_GPUSVM, which is needed for xe userptr
> > support
> > compiles also without CONFIG_DEVICE_PRIVATE, but doesn't compile
> > without CONFIG_ZONE_DEVICE.
> > Exclude the drm_pagemap files from compilation with
> > !CONFIG_ZONE_DEVICE,
> > and remove the CONFIG_DEVICE_PRIVATE dependency from
> > CONFIG_DRM_GPUSVM and
> > the xe driver's selection of it, re-enabling xe userptr for those
> > configs.
> >=20
> > v2:
> > - Don't compile the drm_pagemap files unless CONFIG_ZONE_DEVICE is
> > set.
> > - Adjust the drm_pagemap.h header accordingly.
> >=20
> > Fixes: 9e9787414882 ("drm/xe/userptr: replace xe_hmm with gpusvm")
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: "Thomas Hellstr=C3=B6m" <thomas.hellstrom@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v6.18+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/gpu/drm/Makefile=C2=A0=C2=A0 |=C2=A0 4 +++-
> > =C2=A0drivers/gpu/drm/xe/Kconfig |=C2=A0 2 +-
> > =C2=A0include/drm/drm_pagemap.h=C2=A0 | 18 ++++++++++++++----
> > =C2=A04 files changed, 19 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index a33b90251530..d3d52310c9cc 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -210,7 +210,7 @@ config DRM_GPUVM
> > =C2=A0
> > =C2=A0config DRM_GPUSVM
> > =C2=A0	tristate
> > -	depends on DRM && DEVICE_PRIVATE
> > +	depends on DRM
> > =C2=A0	select HMM_MIRROR
> > =C2=A0	select MMU_NOTIFIER
> > =C2=A0	help
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 0deee72ef935..0c21029c446f 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -108,9 +108,11 @@ obj-$(CONFIG_DRM_EXEC) +=3D drm_exec.o
> > =C2=A0obj-$(CONFIG_DRM_GPUVM) +=3D drm_gpuvm.o
> > =C2=A0
> > =C2=A0drm_gpusvm_helper-y :=3D \
> > -	drm_gpusvm.o\
> > +	drm_gpusvm.o
> > +drm_gpusvm_helper-$(CONFIG_ZONE_DEVICE) +=3D \
> > =C2=A0	drm_pagemap.o\
> > =C2=A0	drm_pagemap_util.o
> > +
> > =C2=A0obj-$(CONFIG_DRM_GPUSVM) +=3D drm_gpusvm_helper.o
> > =C2=A0
> > =C2=A0obj-$(CONFIG_DRM_BUDDY) +=3D drm_buddy.o
> > diff --git a/drivers/gpu/drm/xe/Kconfig
> > b/drivers/gpu/drm/xe/Kconfig
> > index 4b288eb3f5b0..c34be1be155b 100644
> > --- a/drivers/gpu/drm/xe/Kconfig
> > +++ b/drivers/gpu/drm/xe/Kconfig
> > @@ -39,7 +39,7 @@ config DRM_XE
> > =C2=A0	select DRM_TTM
> > =C2=A0	select DRM_TTM_HELPER
> > =C2=A0	select DRM_EXEC
> > -	select DRM_GPUSVM if !UML && DEVICE_PRIVATE
> > +	select DRM_GPUSVM if !UML
> > =C2=A0	select DRM_GPUVM
> > =C2=A0	select DRM_SCHED
> > =C2=A0	select MMU_NOTIFIER
> > diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> > index 46e9c58f09e0..2baf0861f78f 100644
> > --- a/include/drm/drm_pagemap.h
> > +++ b/include/drm/drm_pagemap.h
> > @@ -243,6 +243,8 @@ struct drm_pagemap_devmem_ops {
> > =C2=A0			=C2=A0=C2=A0 struct dma_fence *pre_migrate_fence);
> > =C2=A0};
> > =C2=A0
> > +#if IS_ENABLED(CONFIG_ZONE_DEVICE)
> > +
>=20
> What happens if we select ZONE_DEVICE but not DEVICE_PRIVATE?

This code builds, and in theory would work for DEVICE_COHERENT but the
device-private checks in the code always return false as I understand
it.=20

So should be safe for our userptr code, and SVM still requires /
selects DEVICE_PRIVATE.

Thomas


>=20
> Matt
>=20
> > =C2=A0int drm_pagemap_init(struct drm_pagemap *dpagemap,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 struct dev_pagemap *pagemap,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_device *drm,
> > @@ -252,17 +254,22 @@ struct drm_pagemap *drm_pagemap_create(struct
> > drm_device *drm,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dev_pagemap
> > *pagemap,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct
> > drm_pagemap_ops *ops);
> > =C2=A0
> > -#if IS_ENABLED(CONFIG_DRM_GPUSVM)
> > +struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page
> > *page);
> > =C2=A0
> > =C2=A0void drm_pagemap_put(struct drm_pagemap *dpagemap);
> > =C2=A0
> > =C2=A0#else
> > =C2=A0
> > +static inline struct drm_pagemap
> > *drm_pagemap_page_to_dpagemap(struct page *page)
> > +{
> > +	return NULL;
> > +}
> > +
> > =C2=A0static inline void drm_pagemap_put(struct drm_pagemap *dpagemap)
> > =C2=A0{
> > =C2=A0}
> > =C2=A0
> > -#endif /* IS_ENABLED(CONFIG_DRM_GPUSVM) */
> > +#endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * drm_pagemap_get() - Obtain a reference on a struct drm_pagemap
> > @@ -334,6 +341,8 @@ struct drm_pagemap_migrate_details {
> > =C2=A0	u32 source_peer_migrates : 1;
> > =C2=A0};
> > =C2=A0
> > +#if IS_ENABLED(CONFIG_ZONE_DEVICE)
> > +
> > =C2=A0int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem
> > *devmem_allocation,
> > =C2=A0				=C2=A0 struct mm_struct *mm,
> > =C2=A0				=C2=A0 unsigned long start, unsigned
> > long end,
> > @@ -343,8 +352,6 @@ int drm_pagemap_evict_to_ram(struct
> > drm_pagemap_devmem *devmem_allocation);
> > =C2=A0
> > =C2=A0const struct dev_pagemap_ops *drm_pagemap_pagemap_ops_get(void);
> > =C2=A0
> > -struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page
> > *page);
> > -
> > =C2=A0void drm_pagemap_devmem_init(struct drm_pagemap_devmem
> > *devmem_allocation,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev, struct mm_struct
> > *mm,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_pagemap_devmem_ops
> > *ops,
> > @@ -359,4 +366,7 @@ int drm_pagemap_populate_mm(struct drm_pagemap
> > *dpagemap,
> > =C2=A0void drm_pagemap_destroy(struct drm_pagemap *dpagemap, bool
> > is_atomic_or_reclaim);
> > =C2=A0
> > =C2=A0int drm_pagemap_reinit(struct drm_pagemap *dpagemap);
> > +
> > +#endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
> > +
> > =C2=A0#endif
> > --=20
> > 2.52.0
> >=20

