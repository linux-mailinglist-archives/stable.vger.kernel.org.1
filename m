Return-Path: <stable+bounces-89247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C614B9B52D7
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 20:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87F81C21B1B
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9BA206E92;
	Tue, 29 Oct 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/c2JyQK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0A1DDA2D
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230686; cv=none; b=k/ulPdrYWNoe4RzISrgEFz7sGtE7IvFF6gz6NDUOv6k6ILmvPWVZck0BHLR5dxzDtdXQvLKTxEjv6iV7eBbI4wlwH7z2yLqPHbWmLbeV6fESTXOqNvIyJtFJHtA6p7Ev4zv5k1JAkfdj2C8dSnLYfzjb5gc2WmzIywUNhFPGGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230686; c=relaxed/simple;
	bh=hXz4X8ZZsN0ytOXUdxqUDajmCbaNjiR++T+JHviDyCc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPXKNasb9W0OY5s2BS98Jfp12vCRkliQelsWwYPZY/ckdCpoUJxsv+0WtqyaLsnUdvu7Ka76mCt7sHdy8ermw10NJOaOtBM13oCB7Glse9HiwZG0hdk6fPxqwwOMEXQVcd+LhZa75alEYjoE6P6JZXe5mQf/rtryMNzkbuvKq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/c2JyQK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730230683; x=1761766683;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version;
  bh=hXz4X8ZZsN0ytOXUdxqUDajmCbaNjiR++T+JHviDyCc=;
  b=H/c2JyQKdCK7vdlfr/qkwg8nF+FNJBfVwrxU5qaLwdMaKHZXWcvBhtoB
   QVpoKHLfUKHLthXYo0zboblSFwdPWIAXAwiQukl/EqNY0fo5SiTVc7kqP
   oWxD8K7afDp+EMywJzxF70k/ESkz3CUi+6cQkPm1X9VIlBrz/9pQx71du
   vk+1OlZlLqVem0TaLgD86llUysVZXZ4Oomikcnt601gSxL/TILl6X4hu1
   Dgy75uy1/bpRdnT2g8ha8Bt0LfjpgatsoT+8vl4P8NIJ9ZTr8DL3H2bs1
   PZaw0ActxZCfcRrePQajAJnH5hX4R2do3j10KwlOm4g74mYo7D4rsxV9d
   A==;
X-CSE-ConnectionGUID: 69K5ip8+Q+O5oaikzHtMGQ==
X-CSE-MsgGUID: xfEayJP1QNSxAAUeSs988g==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="30011290"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="30011290"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 12:38:03 -0700
X-CSE-ConnectionGUID: kTnvgR/2TSiCxlgYPgLGdA==
X-CSE-MsgGUID: AehZYGipQ2WunCrWm/BSHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81987295"
Received: from orsosgc001.jf.intel.com (HELO orsosgc001.intel.com) ([10.165.21.142])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 12:38:03 -0700
Date: Tue, 29 Oct 2024 12:38:02 -0700
Message-ID: <8534kezomd.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>, intel-xe@lists.freedesktop.org,
 saurabhg.gupta@intel.com, alex.zuo@intel.com, umesh.nerlige.ramappa@intel.com,
 john.c.harrison@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
In-Reply-To: <brnhn6qx55xqnldy5sw6dahr4rkfwegew2wav5ao65kkah4kwv@kwkps2xwmsil>
References: <20241023200716.82624-1-jonathan.cavitt@intel.com>	<pug6v3ckrvxd7hkrfmppwxck7nxz3ta36sorzcekpzdwgk5ljt@4hxdgwvuctwj>	<854j4uzv79.wl-ashutosh.dixit@intel.com>	<brnhn6qx55xqnldy5sw6dahr4rkfwegew2wav5ao65kkah4kwv@kwkps2xwmsil>
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

On Tue, 29 Oct 2024 10:32:54 -0700, Lucas De Marchi wrote:
>

Hi Lucas,

> On Tue, Oct 29, 2024 at 10:15:54AM -0700, Ashutosh Dixit wrote:
> > On Tue, 29 Oct 2024 09:23:49 -0700, Lucas De Marchi wrote:
> >>
> >> On Wed, Oct 23, 2024 at 08:07:15PM +0000, Jonathan Cavitt wrote:
> >> > Several OA registers and allowlist registers were missing from the
> >> > save/restore list for GuC and could be lost during an engine reset.  Add
> >> > them to the list.
> >> >
> >> > v2:
> >> > - Fix commit message (Umesh)
> >> > - Add missing closes (Ashutosh)
> >> >
> >> > v3:
> >> > - Add missing fixes (Ashutosh)
> >> >
> >> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2249
> >> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> >> > Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> >> > Suggested-by: John Harrison <john.c.harrison@intel.com>
> >> > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> >> > CC: stable@vger.kernel.org # v6.11+
> >> > Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> >> > Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> >> > ---
> >> > drivers/gpu/drm/xe/xe_guc_ads.c | 14 ++++++++++++++
> >> > 1 file changed, 14 insertions(+)
> >> >
> >> > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> >> > index 4e746ae98888..a196c4fb90fc 100644
> >> > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> >> > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> >> > @@ -15,6 +15,7 @@
> >> > #include "regs/xe_engine_regs.h"
> >> > #include "regs/xe_gt_regs.h"
> >> > #include "regs/xe_guc_regs.h"
> >> > +#include "regs/xe_oa_regs.h"
> >> > #include "xe_bo.h"
> >> > #include "xe_gt.h"
> >> > #include "xe_gt_ccs_mode.h"
> >> > @@ -740,6 +741,11 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
> >> >		guc_mmio_regset_write_one(ads, regset_map, e->reg, count++);
> >> >	}
> >> >
> >> > +	for (i = 0; i < RING_MAX_NONPRIV_SLOTS; i++)
> >> > +		guc_mmio_regset_write_one(ads, regset_map,
> >> > +					  RING_FORCE_TO_NONPRIV(hwe->mmio_base, i),
> >> > +					  count++);
> >>
> >> this is not the proper place. See drivers/gpu/drm/xe/xe_reg_whitelist.c.
> >
> > Yikes, this got merged yesterday.
> >
> >>
> >> The loop just before these added lines should be sufficient to go over
> >> all engine save/restore register and give them to guc.
> >
> > You probably mean this one?
> >
> >	xa_for_each(&hwe->reg_sr.xa, idx, entry)
> >		guc_mmio_regset_write_one(ads, regset_map, entry->reg, count++);
> >
> > But then how come this patch fixed GL #2249?
>
> it fixes, it just doesn't put it in the right place according to the
> driver arch. Whitelists should be in that other file so it shows up in
> debugfs, (/sys/kernel/debug/dri/*/*/register-save-restore), detect
> clashes when we try to add the same register, etc.

Sorry, still not following. OA registers are in xe_reg_whitelist.c (see
entries for "oa_reg_render" and "oa_reg_compute" in that file). To
whiteliest registers, the registers need to be added to NONPRIV
registers. This loop mentioned above:

	xa_for_each(&hwe->reg_sr.xa, idx, entry)
		guc_mmio_regset_write_one(ads, regset_map, entry->reg, count++);

seems to add the original OA registers to GuC save/restore list. But this
new code:

	for (i = 0; i < RING_MAX_NONPRIV_SLOTS; i++)
		guc_mmio_regset_write_one(ads, regset_map,
					  RING_FORCE_TO_NONPRIV(hwe->mmio_base, i),
					  count++);

Now adds the NONPRIV registers to GuC save/restore list (which fixes GL
#2249). So not sure what is not in the right place, adding to GuC
save/restore list is right here where the code is added.

Also we don't want to whitelist NONPRIV registers, we only want to add them
to GuC save/restore list.

Thanks.
--
Ashutosh

