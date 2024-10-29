Return-Path: <stable+bounces-89248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035349B52E4
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 20:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AA81C21D24
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B31C20720A;
	Tue, 29 Oct 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koEojtsX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952EF1DDA2D
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231047; cv=none; b=Y5bKu9epaCmdS7yED55zxJpU+Bgfmc2WWY2xnFp2lO3QPDnQshYKShXXAONMznUTLJNNy9OyIffMucsV98NuQ9lAoREuodsQOedK9JuKm8PJgPwaaXiqN93FDkD4JcC6Cdtcl5G5l1ZIDHYpXQyDIk5/upgCw41RW4Ta3VwuiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231047; c=relaxed/simple;
	bh=ttfYce/qdS8k+Pf1rnYy3K6/GAxjaXHWUHY9aSkQTbY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=To7KFfJpYBEAPkhm0KJeA8uOEirxxehzLOh0MWNDGxA7K+sarWzeCMeozI3Tk+KdwEAyg+IbAEZO9FuemBbOdbZ45zUetNpOZcTi14U/XiPanVoyz628TDDDoPljVJ6A9LNq8cgMRZaCT/f4CcHFXUiJ75OQa24+pmyiufWrfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koEojtsX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730231045; x=1761767045;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version;
  bh=ttfYce/qdS8k+Pf1rnYy3K6/GAxjaXHWUHY9aSkQTbY=;
  b=koEojtsXDqDGqySBl7foHdsL2TiQGr4nJbRfapxUy/FEbUhCnwDVqbyU
   CUwDJIXlVuSltRVPORZ1uRdXQZexbXwIpKEfG+ZYAZZgHtH7WjHxtaEGn
   e+286x9h2lO39NBOE9xkJTImxoomJIfMqF2tiQmLfy2iErmafwLQ6Zzbd
   oQ5oSBopoYeSliUBxHxHLfQF326DeiXKPGrp9WGpXJfvsjJIPQ1H2hiuV
   c2BfhF1tD2iKi1ksBwD+Yu1/wXA1sQtkYaFNjM8duDSW/ehudPE4Lbmrh
   NF66QCORmVMAB8d1Ec5vfDXJ4YsteiY2BnkLWF3oDu1oDeTDXPtakgELz
   A==;
X-CSE-ConnectionGUID: sDNXf00MRFaqMFqdlP7OhA==
X-CSE-MsgGUID: tZMRcITQRZm6oHiOcbqfcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="47379855"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="47379855"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 12:44:03 -0700
X-CSE-ConnectionGUID: qe5UP9JHSliZYhpJGWaD8Q==
X-CSE-MsgGUID: mYyN7FgiScyE34+Tap/hcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82401301"
Received: from orsosgc001.jf.intel.com (HELO orsosgc001.intel.com) ([10.165.21.142])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 12:44:03 -0700
Date: Tue, 29 Oct 2024 12:44:02 -0700
Message-ID: <85zfmmy9rx.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	intel-xe@lists.freedesktop.org,
	saurabhg.gupta@intel.com,
	alex.zuo@intel.com,
	umesh.nerlige.ramappa@intel.com,
	john.c.harrison@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
In-Reply-To: <20241029193313.GY4891@mdroper-desk1.amr.corp.intel.com>
References: <20241023200716.82624-1-jonathan.cavitt@intel.com>
	<pug6v3ckrvxd7hkrfmppwxck7nxz3ta36sorzcekpzdwgk5ljt@4hxdgwvuctwj>
	<854j4uzv79.wl-ashutosh.dixit@intel.com>
	<brnhn6qx55xqnldy5sw6dahr4rkfwegew2wav5ao65kkah4kwv@kwkps2xwmsil>
	<20241029193313.GY4891@mdroper-desk1.amr.corp.intel.com>
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

On Tue, 29 Oct 2024 12:33:13 -0700, Matt Roper wrote:
>
> On Tue, Oct 29, 2024 at 12:32:54PM -0500, Lucas De Marchi wrote:
> > On Tue, Oct 29, 2024 at 10:15:54AM -0700, Ashutosh Dixit wrote:
> > > On Tue, 29 Oct 2024 09:23:49 -0700, Lucas De Marchi wrote:
> > > >
> > > > On Wed, Oct 23, 2024 at 08:07:15PM +0000, Jonathan Cavitt wrote:
> > > > > Several OA registers and allowlist registers were missing from the
> > > > > save/restore list for GuC and could be lost during an engine reset.  Add
> > > > > them to the list.
> > > > >
> > > > > v2:
> > > > > - Fix commit message (Umesh)
> > > > > - Add missing closes (Ashutosh)
> > > > >
> > > > > v3:
> > > > > - Add missing fixes (Ashutosh)
> > > > >
> > > > > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2249
> > > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > > > > Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> > > > > Suggested-by: John Harrison <john.c.harrison@intel.com>
> > > > > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > > > > CC: stable@vger.kernel.org # v6.11+
> > > > > Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > > > > Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> > > > > ---
> > > > > drivers/gpu/drm/xe/xe_guc_ads.c | 14 ++++++++++++++
> > > > > 1 file changed, 14 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> > > > > index 4e746ae98888..a196c4fb90fc 100644
> > > > > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> > > > > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> > > > > @@ -15,6 +15,7 @@
> > > > > #include "regs/xe_engine_regs.h"
> > > > > #include "regs/xe_gt_regs.h"
> > > > > #include "regs/xe_guc_regs.h"
> > > > > +#include "regs/xe_oa_regs.h"
> > > > > #include "xe_bo.h"
> > > > > #include "xe_gt.h"
> > > > > #include "xe_gt_ccs_mode.h"
> > > > > @@ -740,6 +741,11 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
> > > > >		guc_mmio_regset_write_one(ads, regset_map, e->reg, count++);
> > > > >	}
> > > > >
> > > > > +	for (i = 0; i < RING_MAX_NONPRIV_SLOTS; i++)
> > > > > +		guc_mmio_regset_write_one(ads, regset_map,
> > > > > +					  RING_FORCE_TO_NONPRIV(hwe->mmio_base, i),
> > > > > +					  count++);
> > > >
> > > > this is not the proper place. See drivers/gpu/drm/xe/xe_reg_whitelist.c.
> > >
> > > Yikes, this got merged yesterday.
> > >
> > > >
> > > > The loop just before these added lines should be sufficient to go over
> > > > all engine save/restore register and give them to guc.
> > >
> > > You probably mean this one?
> > >
> > >	xa_for_each(&hwe->reg_sr.xa, idx, entry)
> > >		guc_mmio_regset_write_one(ads, regset_map, entry->reg, count++);
> > >
> > > But then how come this patch fixed GL #2249?
> >
> > it fixes, it just doesn't put it in the right place according to the
> > driver arch. Whitelists should be in that other file so it shows up in
> > debugfs, (/sys/kernel/debug/dri/*/*/register-save-restore), detect
> > clashes when we try to add the same register, etc.
>
> Also, this patch failed pre-merge BAT since it added new regset entries
> that we never actually allocated storage space for.  Now that it's been
> applied, we're seeing CI failures on lots of tests from this:
>
> https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3295

Wow, truly sorry, completely missed that BAT failures were due to this
patch. How about we just revert this patch for now and redo it later?
Unless you or Lucas know how to fix this immediately (I don't).

Thanks.
--
Ashutosh

