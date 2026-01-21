Return-Path: <stable+bounces-210801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPofAccjcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:06:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7AB5BD2B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67EFD7EF418
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FE283FCF;
	Wed, 21 Jan 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USvVvRvO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302E31CA7B
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016336; cv=none; b=Wawxh8coytdYg1xZWvCEBWeZ36FoBeCZbjTKJarzr83C5iq52FoayVOPDhObSEVxDHBmVlJXOt04NvTRmwGCZyy2FHX6Y4zS1gZl8Ok4bHgvW6xaTXZjZijwyqOrD/dqQLNU/gNjJaCv86th4azMv+3+T0PPy4usxDBpjSBvZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016336; c=relaxed/simple;
	bh=N8gWTDmCu2/voer1RdP10E4nlB90rJQjCxhjRdPiuQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9lHWpafszUGTrSvov6n96eCBbqVdZyg2SxMctzw1zY3WT0NCK9KF+vOy8XjcrXh0agTX7CeCtp1JomTKvojR7Ru0PpLs90XLmc4yaaSL5Sm+6naFV0dlCYvPbtMWdEzTQxTY8/JQPtftC118fLuc+wLxl0ZdSI3u+MsVoUqN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USvVvRvO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769016334; x=1800552334;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=N8gWTDmCu2/voer1RdP10E4nlB90rJQjCxhjRdPiuQg=;
  b=USvVvRvOWUspOH71YlnQ5nOor8WIGFWxma7xxWhRwIexcfIh5hjhtOLU
   FIjCWv6e8ZUZQBb6B5FpuFV2TIurCZlu2ah4jm5UGO+v+uvljwdICZDe0
   KdV872QwCOP08+6POpNf/cFpemtQjzkytUcSCS0RNDvvTvsVf3MrBGqnT
   wH2SzVXlb9hbi1iWOfnbT5Pl1EmElKRmitrqggbEbiKdH00OXexRmeW6d
   Z3evMkb6ktnkVDiXVxmO4wKZlEacd4WHDbmOaSEFWWAE5yqH57S2aP41G
   TaK7lavZQN6D3mZIbO6mWdg68OUyOeScsm8yaST1EHh2wDReWOAwqOxxx
   A==;
X-CSE-ConnectionGUID: adGQNEgTSoOWeVAXmUdOYg==
X-CSE-MsgGUID: hx/Mvc0nT3WDkYsZk1i+LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70342961"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70342961"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 09:25:33 -0800
X-CSE-ConnectionGUID: ml0GjAmGSeehOJ4sDeCK3w==
X-CSE-MsgGUID: 6WHj4Cs3QGSy0fpRYaK0aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206929031"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.245.107]) ([10.245.245.107])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 09:25:31 -0800
Message-ID: <81331db882e57f7e7e8322ba7aba87081759465f.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] drm, drm/xe: Fix xe userptr in the absence of
 CONFIG_DEVICE_PRIVATE
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>, Matthew Brost
	 <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Date: Wed, 21 Jan 2026 18:25:28 +0100
In-Reply-To: <ad0efbfc-b7b3-4dc8-9499-8a7accd6c5e4@intel.com>
References: <20260121091048.41371-1-thomas.hellstrom@linux.intel.com>
	 <20260121091048.41371-2-thomas.hellstrom@linux.intel.com>
	 <ad0efbfc-b7b3-4dc8-9499-8a7accd6c5e4@intel.com>
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
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210801-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3B7AB5BD2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-01-21 at 17:19 +0000, Matthew Auld wrote:
> On 21/01/2026 09:10, Thomas Hellstr=C3=B6m wrote:
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
>=20
> Let me double check that while it does at least build it is also=20
> functional without DRM_XE_GPUSVM. I think it takes a different init
> path=20
> and maybe some other differences. Unless you already did?

I think I managed to test without DRM_XE_GPUSVM both with and without
ZONE_DEVICE, but since this is going to stable, a second check would be
great!

Thanks,
Thomas


>=20
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>=20
> > ---
> > =C2=A0 drivers/gpu/drm/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0 drivers/gpu/drm/Makefile=C2=A0=C2=A0 |=C2=A0 4 +++-
> > =C2=A0 drivers/gpu/drm/xe/Kconfig |=C2=A0 2 +-
> > =C2=A0 include/drm/drm_pagemap.h=C2=A0 | 18 ++++++++++++++----
> > =C2=A0 4 files changed, 19 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index a33b90251530..d3d52310c9cc 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -210,7 +210,7 @@ config DRM_GPUVM
> > =C2=A0=20
> > =C2=A0 config DRM_GPUSVM
> > =C2=A0=C2=A0	tristate
> > -	depends on DRM && DEVICE_PRIVATE
> > +	depends on DRM
> > =C2=A0=C2=A0	select HMM_MIRROR
> > =C2=A0=C2=A0	select MMU_NOTIFIER
> > =C2=A0=C2=A0	help
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 0deee72ef935..0c21029c446f 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -108,9 +108,11 @@ obj-$(CONFIG_DRM_EXEC) +=3D drm_exec.o
> > =C2=A0 obj-$(CONFIG_DRM_GPUVM) +=3D drm_gpuvm.o
> > =C2=A0=20
> > =C2=A0 drm_gpusvm_helper-y :=3D \
> > -	drm_gpusvm.o\
> > +	drm_gpusvm.o
> > +drm_gpusvm_helper-$(CONFIG_ZONE_DEVICE) +=3D \
> > =C2=A0=C2=A0	drm_pagemap.o\
> > =C2=A0=C2=A0	drm_pagemap_util.o
> > +
> > =C2=A0 obj-$(CONFIG_DRM_GPUSVM) +=3D drm_gpusvm_helper.o
> > =C2=A0=20
> > =C2=A0 obj-$(CONFIG_DRM_BUDDY) +=3D drm_buddy.o
> > diff --git a/drivers/gpu/drm/xe/Kconfig
> > b/drivers/gpu/drm/xe/Kconfig
> > index 4b288eb3f5b0..c34be1be155b 100644
> > --- a/drivers/gpu/drm/xe/Kconfig
> > +++ b/drivers/gpu/drm/xe/Kconfig
> > @@ -39,7 +39,7 @@ config DRM_XE
> > =C2=A0=C2=A0	select DRM_TTM
> > =C2=A0=C2=A0	select DRM_TTM_HELPER
> > =C2=A0=C2=A0	select DRM_EXEC
> > -	select DRM_GPUSVM if !UML && DEVICE_PRIVATE
> > +	select DRM_GPUSVM if !UML
> > =C2=A0=C2=A0	select DRM_GPUVM
> > =C2=A0=C2=A0	select DRM_SCHED
> > =C2=A0=C2=A0	select MMU_NOTIFIER
> > diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> > index 46e9c58f09e0..2baf0861f78f 100644
> > --- a/include/drm/drm_pagemap.h
> > +++ b/include/drm/drm_pagemap.h
> > @@ -243,6 +243,8 @@ struct drm_pagemap_devmem_ops {
> > =C2=A0=C2=A0			=C2=A0=C2=A0 struct dma_fence *pre_migrate_fence);
> > =C2=A0 };
> > =C2=A0=20
> > +#if IS_ENABLED(CONFIG_ZONE_DEVICE)
> > +
> > =C2=A0 int drm_pagemap_init(struct drm_pagemap *dpagemap,
> > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 struct dev_pagemap *pagemap,
> > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_device *drm,
> > @@ -252,17 +254,22 @@ struct drm_pagemap *drm_pagemap_create(struct
> > drm_device *drm,
> > =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dev_pagemap
> > *pagemap,
> > =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct
> > drm_pagemap_ops *ops);
> > =C2=A0=20
> > -#if IS_ENABLED(CONFIG_DRM_GPUSVM)
> > +struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page
> > *page);
> > =C2=A0=20
> > =C2=A0 void drm_pagemap_put(struct drm_pagemap *dpagemap);
> > =C2=A0=20
> > =C2=A0 #else
> > =C2=A0=20
> > +static inline struct drm_pagemap
> > *drm_pagemap_page_to_dpagemap(struct page *page)
> > +{
> > +	return NULL;
> > +}
> > +
> > =C2=A0 static inline void drm_pagemap_put(struct drm_pagemap *dpagemap)
> > =C2=A0 {
> > =C2=A0 }
> > =C2=A0=20
> > -#endif /* IS_ENABLED(CONFIG_DRM_GPUSVM) */
> > +#endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
> > =C2=A0=20
> > =C2=A0 /**
> > =C2=A0=C2=A0 * drm_pagemap_get() - Obtain a reference on a struct drm_p=
agemap
> > @@ -334,6 +341,8 @@ struct drm_pagemap_migrate_details {
> > =C2=A0=C2=A0	u32 source_peer_migrates : 1;
> > =C2=A0 };
> > =C2=A0=20
> > +#if IS_ENABLED(CONFIG_ZONE_DEVICE)
> > +
> > =C2=A0 int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem
> > *devmem_allocation,
> > =C2=A0=C2=A0				=C2=A0 struct mm_struct *mm,
> > =C2=A0=C2=A0				=C2=A0 unsigned long start, unsigned
> > long end,
> > @@ -343,8 +352,6 @@ int drm_pagemap_evict_to_ram(struct
> > drm_pagemap_devmem *devmem_allocation);
> > =C2=A0=20
> > =C2=A0 const struct dev_pagemap_ops *drm_pagemap_pagemap_ops_get(void);
> > =C2=A0=20
> > -struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page
> > *page);
> > -
> > =C2=A0 void drm_pagemap_devmem_init(struct drm_pagemap_devmem
> > *devmem_allocation,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev, struct mm_s=
truct
> > *mm,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_pagemap_devmem=
_ops
> > *ops,
> > @@ -359,4 +366,7 @@ int drm_pagemap_populate_mm(struct drm_pagemap
> > *dpagemap,
> > =C2=A0 void drm_pagemap_destroy(struct drm_pagemap *dpagemap, bool
> > is_atomic_or_reclaim);
> > =C2=A0=20
> > =C2=A0 int drm_pagemap_reinit(struct drm_pagemap *dpagemap);
> > +
> > +#endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
> > +
> > =C2=A0 #endif

