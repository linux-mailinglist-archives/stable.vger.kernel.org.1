Return-Path: <stable+bounces-50158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39C903DAF
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278B1288430
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815717D881;
	Tue, 11 Jun 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dS3iKkAr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F017D355
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113177; cv=none; b=ATlYFFGqxn2GRhDDmEdMW98jlqE2upo0UvBl71OTQKk6OgS1rT38WS+/znrsBelbrE6j0SgHrJhlsRgrAGuAbv8Apcp/BambROKn8RjzpqVJ2lC1qRswTZZME6Go9ety4S+RS3LxhgzRsQy/rv/LY8EmAdZrtL+15P/bmguUSLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113177; c=relaxed/simple;
	bh=SHwuFHzzuuY/Z4NVxhj+TjLfZsXMqwNT+yZ7Pw0xkQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsiAZ2Q6uHJ68J2qPkc5h+VfuesJH6pI9k3uJV/h+GtlBE5zteAt/eCUpOXOud3vxUWpM2fxq5UOGxGZijaJeqdrZW0oTDYrP3WJqrEjL3KzhrMv0QPjOShT0FxknMYfBcqJENC4CmCtVoscTR0N5F8DMEuxLGTZomjNhXAa53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dS3iKkAr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718113176; x=1749649176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SHwuFHzzuuY/Z4NVxhj+TjLfZsXMqwNT+yZ7Pw0xkQ4=;
  b=dS3iKkArERjk98GcFTQxs3dUaFRn4PKn1V4+tHWGvaPLYwey8LX+qPOb
   uCS07efHKoaPmleh7DjpZocagnT8VRoZ2DWeE4kMtJlHDdsl8mUKDhVwY
   42wB4EcG+LP0beCk/EGcLPsLeVSNEPOC7Bp1EUoPQgO0vvwnEeZ0jSdZc
   /ONlMILk5cnkwR5MCMAWac+TJia97FMSNeMjTlnjZYwT6nGLrMwFvPGD/
   OrrtkxM6bNvtceewwuGkUdF/wo3fSNy8rfvwEmYf/4f88kdMqX2y4V6Zx
   4C4v4V25Y1qSS5Gt9P3JICc5dx9dggkDFwPfcrb5nPDxx9F4w2XOdArJE
   Q==;
X-CSE-ConnectionGUID: cf9LmkirQXO9pmnrreUE8Q==
X-CSE-MsgGUID: 4qWVgz2lTAqTs5HBJ/nNvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25495682"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="25495682"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:32:04 -0700
X-CSE-ConnectionGUID: Lo+7YCVNTAWxXNdxeSRLVg==
X-CSE-MsgGUID: +11mErGHS7aByOpCpVDqtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="76901248"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:32:01 -0700
Date: Tue, 11 Jun 2024 15:31:57 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	John Harrison <John.C.Harrison@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt/uc: Evaluate GuC priority within locks
Message-ID: <ZmhRzRa9axjlaIl3@ashyti-mobl2.lan>
References: <20240606001702.59005-1-andi.shyti@linux.intel.com>
 <185a4d70-4f1b-4b95-acc2-d2e26cb0052b@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <185a4d70-4f1b-4b95-acc2-d2e26cb0052b@intel.com>

Hi Daniele,

thanks for checking this patch.

> > diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
> > index 0eaa1064242c..1181043bc5e9 100644
> > --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
> > +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
> > @@ -4267,13 +4267,18 @@ static void guc_bump_inflight_request_prio(struct i915_request *rq,
> >   	u8 new_guc_prio = map_i915_prio_to_guc_prio(prio);
> >   	/* Short circuit function */
> > -	if (prio < I915_PRIORITY_NORMAL ||
> > -	    rq->guc_prio == GUC_PRIO_FINI ||
> > -	    (rq->guc_prio != GUC_PRIO_INIT &&
> > -	     !new_guc_prio_higher(rq->guc_prio, new_guc_prio)))
> > +	if (prio < I915_PRIORITY_NORMAL)
> >   		return;
> 
> My understanding was that those checks are purposely done outside of the
> lock to avoid taking it when not needed and that the early exit is not racy.
> In particular:
> 
> - GUC_PRIO_FINI is the end state for the priority, so if we're there that's
> not changing anymore and therefore the lock is not required.

yeah... then I thought that the lock should either remove it
completely or have everything inside the lock.

> - the priority only goes up with the bumping, so if new_guc_prio_higher() is
> false that's not going to be changed by a different thread running at the
> same time and increasing the priority even more.
> 
> I think there is still a possible race is if new_guc_prio_higher() is true
> when we check it outside the lock but then changes before we execute the
> protected chunk inside, so a fix would still be required for that.

This is the reason why I made the patch :-)

> All this said, I don't really have anything against moving the whole thing
> inside the lock since this isn't on a critical path, just wanted to point
> out that it's not all strictly required.
> 
> One nit on the code below.
> 
> >   	spin_lock(&ce->guc_state.lock);
> > +
> > +	if (rq->guc_prio == GUC_PRIO_FINI)
> > +		goto exit;
> > +
> > +	if (rq->guc_prio != GUC_PRIO_INIT &&
> > +	    !new_guc_prio_higher(rq->guc_prio, new_guc_prio))
> > +		goto exit;
> > +
> >   	if (rq->guc_prio != GUC_PRIO_FINI) {
> 
> You're now checking for rq->guc_prio == GUC_PRIO_FINI inside the lock, so no
> need to check it again here as it can't have changed.

True, will resend.

Thanks, Daniele!

Andi

