Return-Path: <stable+bounces-89233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2A49B5031
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 18:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3531F23B93
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0611193407;
	Tue, 29 Oct 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbLGFvba"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE42107
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222157; cv=none; b=Qhv10fQwXYaCsN6i5fiS2sH1lsDzy1U4JilFDCGup6wIt/9/8TTR0F3eGU4VAJSy0DuQY6bqadQiNlVtgXhnI6S+yfmfhI3LryePUfbNKYRjX3SeItweRgq54gnNGeVdn1XkwYgxUAepdrzQVnZ/oELAr0dKbUDjwxBU+OTUxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222157; c=relaxed/simple;
	bh=F1ejSdSbYOl/2gaEyfMAiuQUNXpuAxf8FcidA+2eR0o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdTilbFmzKTnUGfeawbOtkjLC/s4JMH6ZPqi8uJha4r/x3o/d4Sl7d1lCCRfiI3RUaxlQrhaO1Le6z8F7QIhHwtEDj42eZkJdYpNNTKRymAVf1kb7kDi8qb8PSHHiZ7HAe9omj1Ixwl51MSJ3qUgJYl3++Xl0ShwHt8OXgP6NbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbLGFvba; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730222155; x=1761758155;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version;
  bh=F1ejSdSbYOl/2gaEyfMAiuQUNXpuAxf8FcidA+2eR0o=;
  b=RbLGFvbaLTJr1lUVTiN1oRm7UQ2vW0uAzldACwRS0RZKr67QOm3AC3oo
   vsdy3vCF765L20LmHDEx3P2MRbgLqQwEkWXF1s38p6neYwqvSIaZDXxuZ
   LL4sqNXF61ExLITdbYuqEUIbN8qWZ7hak0hi4B2HBcdNZUBqQ/eNpfkJs
   0y/OOEzv9BoVPpGy0va2vXrNsGUs9qgqV1Bed4v++kirkkKm6U3CVxqcD
   SCNLdeZ3CwIEUmS9ck/iSWK2/PGBcJv7ot5+aBoMrmHTmfOphcQmVBIF0
   D5A9c7bagAlNOmwhM1LtniNqHFVLuq3w/rMBJjG/NZl6I0y71wXTuJS31
   A==;
X-CSE-ConnectionGUID: rDCJHHGGRUOWi8uvm0E2Ow==
X-CSE-MsgGUID: VvNMcG4xQJO3mX1bmynBjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29993780"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29993780"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:15:54 -0700
X-CSE-ConnectionGUID: Dy921Ny7R+eF3uBwMcBQ3w==
X-CSE-MsgGUID: ac+l93g3Q6OgQG5zx7OmOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82101376"
Received: from orsosgc001.jf.intel.com (HELO orsosgc001.intel.com) ([10.165.21.142])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:15:54 -0700
Date: Tue, 29 Oct 2024 10:15:54 -0700
Message-ID: <854j4uzv79.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>, <intel-xe@lists.freedesktop.org>,
 <saurabhg.gupta@intel.com>, <alex.zuo@intel.com>, <umesh.nerlige.ramappa@intel.com>,
 <john.c.harrison@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
In-Reply-To: <pug6v3ckrvxd7hkrfmppwxck7nxz3ta36sorzcekpzdwgk5ljt@4hxdgwvuctwj>
References: <20241023200716.82624-1-jonathan.cavitt@intel.com>	<pug6v3ckrvxd7hkrfmppwxck7nxz3ta36sorzcekpzdwgk5ljt@4hxdgwvuctwj>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/28.2 (x86_64-redhat-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII

On Tue, 29 Oct 2024 09:23:49 -0700, Lucas De Marchi wrote:
>
> On Wed, Oct 23, 2024 at 08:07:15PM +0000, Jonathan Cavitt wrote:
> > Several OA registers and allowlist registers were missing from the
> > save/restore list for GuC and could be lost during an engine reset.  Add
> > them to the list.
> >
> > v2:
> > - Fix commit message (Umesh)
> > - Add missing closes (Ashutosh)
> >
> > v3:
> > - Add missing fixes (Ashutosh)
> >
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2249
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> > Suggested-by: John Harrison <john.c.harrison@intel.com>
> > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > CC: stable@vger.kernel.org # v6.11+
> > Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> > ---
> > drivers/gpu/drm/xe/xe_guc_ads.c | 14 ++++++++++++++
> > 1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> > index 4e746ae98888..a196c4fb90fc 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> > @@ -15,6 +15,7 @@
> > #include "regs/xe_engine_regs.h"
> > #include "regs/xe_gt_regs.h"
> > #include "regs/xe_guc_regs.h"
> > +#include "regs/xe_oa_regs.h"
> > #include "xe_bo.h"
> > #include "xe_gt.h"
> > #include "xe_gt_ccs_mode.h"
> > @@ -740,6 +741,11 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
> >		guc_mmio_regset_write_one(ads, regset_map, e->reg, count++);
> >	}
> >
> > +	for (i = 0; i < RING_MAX_NONPRIV_SLOTS; i++)
> > +		guc_mmio_regset_write_one(ads, regset_map,
> > +					  RING_FORCE_TO_NONPRIV(hwe->mmio_base, i),
> > +					  count++);
>
> this is not the proper place. See drivers/gpu/drm/xe/xe_reg_whitelist.c.

Yikes, this got merged yesterday.

>
> The loop just before these added lines should be sufficient to go over
> all engine save/restore register and give them to guc.

You probably mean this one?

	xa_for_each(&hwe->reg_sr.xa, idx, entry)
		guc_mmio_regset_write_one(ads, regset_map, entry->reg, count++);

But then how come this patch fixed GL #2249?

Ashutosh

