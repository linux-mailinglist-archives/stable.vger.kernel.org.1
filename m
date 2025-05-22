Return-Path: <stable+bounces-146061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A687AC08D7
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6083A65CA
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411E7267F5D;
	Thu, 22 May 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDdnXFq3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD533DB
	for <stable@vger.kernel.org>; Thu, 22 May 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906513; cv=none; b=kAPvzmdvQoRk93i6bbLCvWMt2arvdNItz2dzT69IvtKHdJpS/0IKY4prK80CDuxKrvrCmA0CSFtQxtmbntqjUpGsSqr5dTXOlphXkJBKxiccg/KGtomw33s5RofgeqhyyKao7pPuzsOekO1aPKRerC7auhKT/ALteKgHB4uLpYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906513; c=relaxed/simple;
	bh=Z+jLKNsxkqIWqQE8myT0MpIZfPTXS0E7a1P5MPHCQjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwe4BMHDolGStheoMLyl9b8e8Vv9c63hmnAeeRQfzai/PY7Cs467ly6pezBSuNR36sGjQzXzceI6+eF0IvKNgR56xbF3a6Qy1c21as/s8B1E6fsJe7GbfXmTZc33ozyjeRZZyek7HrOWPgldeX2OUqLjWDEzFPHjwGKZInsQP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDdnXFq3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747906512; x=1779442512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z+jLKNsxkqIWqQE8myT0MpIZfPTXS0E7a1P5MPHCQjA=;
  b=SDdnXFq3iRCeq0a1PJc5nwFD3Na3o4/fu+FigtApeWcIi58KFBxokf4A
   VKxmEUASfxTVKuPQ5GbjHBx17jiVW7/DF5nGBy10T+22Y1FaApdqYQpB6
   CASFkt4lTsV2LC00nI769UtgcGI+st8dXJn689qxHl2C66Npv5iIIq8/1
   EVqrr2iGyE8rrXDh5+n9ugjtBGSINX6wkPtAxK/t3uoYMKEHjoJLegK0E
   DqpwBLWq86aL6Y85e4XbqsIUSWTuTV7uTYOWzJNND3UULfO3yrqFnlcfB
   gZpjtijMHDOW9dludqA4dkDWGn1IHo+AhVa4AFihmmQcdIXLOISz6B2Fk
   g==;
X-CSE-ConnectionGUID: 76QsREm3SlSgDbgPQufKIg==
X-CSE-MsgGUID: obZzDpwIT3ekklLRWAJ4tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="72446650"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="72446650"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 02:35:10 -0700
X-CSE-ConnectionGUID: j+Fzz2/8Q8qgd8dpaZ+2+w==
X-CSE-MsgGUID: WUskt9GISkaCGl1a8MdVKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="145666591"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO stinkbox) ([10.245.245.173])
  by orviesa005.jf.intel.com with SMTP; 22 May 2025 02:35:07 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 22 May 2025 12:35:05 +0300
Date: Thu, 22 May 2025 12:35:05 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, Tvrtko Ursulin <tursulin@ursulin.net>,
	stable@vger.kernel.org, Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v2 1/2] drm/i915/gem: Allow EXEC_CAPTURE on recoverable
 contexts on DG1
Message-ID: <aC7vyURBb6k8TqBI@intel.com>
References: <20250411144313.11660-1-ville.syrjala@linux.intel.com>
 <20250411144313.11660-2-ville.syrjala@linux.intel.com>
 <174789510455.12498.1410930072009074388@jlahtine-mobl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174789510455.12498.1410930072009074388@jlahtine-mobl>
X-Patchwork-Hint: comment

On Thu, May 22, 2025 at 09:25:04AM +0300, Joonas Lahtinen wrote:
> (+ Tvrkto)
> 
> Quoting Ville Syrjala (2025-04-11 17:43:12)
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > The intel-media-driver is currently broken on DG1 because
> > it uses EXEC_CAPTURE with recovarable contexts. Relax the
> > check to allow that.
> > 
> > I've also submitted a fix for the intel-media-driver:
> > https://github.com/intel/media-driver/pull/1920
> > 
> > Cc: stable@vger.kernel.org
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Testcase: igt/gem_exec_capture/capture-invisible
> > Fixes: 71b1669ea9bd ("drm/i915/uapi: tweak error capture on recoverable contexts")
> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> > index ca7e9216934a..ea9d5063ce78 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> > @@ -2013,7 +2013,7 @@ static int eb_capture_stage(struct i915_execbuffer *eb)
> >                         continue;
> >  
> >                 if (i915_gem_context_is_recoverable(eb->gem_context) &&
> > -                   (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 0)))
> > +                   GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
> 
> The IS_DGFX check was there because the error capture is expected to be
> broken on anything with VRAM.

I don't care. It's a regression that prevents current userspace
from working.

> 
> If we have already submitted an userspace fix to remove that flag, that
> would be the right way to go.

There has a been an open pull request for that for who knows how long
without any action.

> 
> So reverting this for now.

*You* make sure a userspace fix actually gets released then.

-- 
Ville Syrjälä
Intel

