Return-Path: <stable+bounces-98277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9563A9E3836
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 12:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD3E28235F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 11:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A7F1AF0BE;
	Wed,  4 Dec 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1NkxUx9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197861B0F2E
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310259; cv=none; b=NQzuzUWMNhg6Dvcw8MvkGxAHRN20JRqZb9ypiYhsGCJeZFHQB2Kb8Ho+KXCsIpq+mHLbqFImjQ0M9bIESVqkVZcF1pwDVdtXqL4nKPGCDJY4+Q5DROSIK4ocrKvIsVL4Md1ostSPHDyAV8F56Pq29Kr4+s+XwpiI7zzbmOwOrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310259; c=relaxed/simple;
	bh=ahqqkIb7p/gDv+P32bHbeqCtkNEt52o5QFlR+Ugs8qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af8YddN2pQzHpdGMHs2vAEcioFEhyrsMQgYDalLB3CGTyOV51BpA0xooowF5TQaZyl+DbDYv3HAbsqOI5A/fP69ub0HhbJ1gxJY1FB8dJJFwSyd4/5gVoszei3lYF9TXgO1rFu+V81cdiT+hfd5kjg0aR5NVbO7tjr79b6ubTHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1NkxUx9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733310258; x=1764846258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ahqqkIb7p/gDv+P32bHbeqCtkNEt52o5QFlR+Ugs8qc=;
  b=H1NkxUx9f+ZFPUn6wYcRmO8jqL+/0iHWwObu0lrFBVXWIBVAmfjwYZJ/
   PiwRwcrB3+uxmQRV7PPszIRe/QpQsskV8iV1rwoweBxccaYzuW2CTTvqo
   8gmPV+lwqO/JRJ6l9jonE5nAtYkQ31epn6acVR7t8mChXo7XUm++Zdnap
   vljcAIAAaEmVL8RASmVhw7lCi15gvD56kQnOS32N5j0ybJNp0aiSI/ZBn
   s0IvIkIIWiHSmBeZIUweKlDbYBOzL6V+ahsogd4q3KMrelixxWZ7uYj5x
   HOMsHl+g/9C9t5FjN56C32CaIR0Fmv4xUqcSPH7wz0XRKjzsJC3ips6gK
   g==;
X-CSE-ConnectionGUID: lOqsCHx2TTe9okBeydkA5Q==
X-CSE-MsgGUID: ldLtfVDbQleKYQpegidY4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44947296"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44947296"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:04:17 -0800
X-CSE-ConnectionGUID: VaWeAFJjQX6/qMGyzCvWOw==
X-CSE-MsgGUID: FqJ9Z4gYRpuC4SbEePceog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="116983800"
Received: from slindbla-desk.ger.corp.intel.com (HELO intel.com) ([10.245.246.225])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:04:14 -0800
Date: Wed, 4 Dec 2024 12:04:11 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Eugene Kobyak <eugene.kobyak@intel.com>,
	intel-gfx@lists.freedesktop.org, John.C.Harrison@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] drm/i915: Fix NULL pointer dereference in
 capture_engine
Message-ID: <Z1A3K2djcF6UqelX@ashyti-mobl2.lan>
References: <xmsgfynkhycw3cf56akp4he2ffg44vuratocsysaowbsnhutzi@augnqbm777at>
 <053cc89a-0b20-4fb0-b93c-1e864a6b6f6a@intel.com>
 <Z1Avw4f93LlBULI2@ashyti-mobl2.lan>
 <87frn33elv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frn33elv.fsf@intel.com>

Hi Jani,

On Wed, Dec 04, 2024 at 12:51:56PM +0200, Jani Nikula wrote:
> On Wed, 04 Dec 2024, Andi Shyti <andi.shyti@linux.intel.com> wrote:
> > Hi Michal,
> >
> >> > +	if (rq && !i915_request_started(rq)) {
> >> > +		/*
> >> > +		* We want to know also what is the gcu_id of the context,
> >> 
> >> typo: guc_id
> >> 
> >> > +		* but if we don't have the context reference, then skip
> >> > +		* printing it.
> >> > +		*/
> >> 
> >> but IMO this comment is redundant as it's quite obvious that without
> >> context pointer you can't print guc_id member
> >
> > I recommended to add a comment because there is some code
> > redundancy that, I think, needs some explanation; someone might
> > not spot immediately the need for ce, unless goes a the end of
> > the drm_info parameter's list.
> >
> >> > +		if (ce)
> >> > +			drm_info(&engine->gt->i915->drm,
> >> > +				"Got hung context on %s with active request %lld:%lld [0x%04X] not yet started\n",
> >> > +				engine->name, rq->fence.context, rq->fence.seqno, ce->guc_id.id);
> >> > +		else
> >> > +			drm_info(&engine->gt->i915->drm,
> >> > +				"Got hung context on %s with active request %lld:%lld not yet started\n",
> >> > +				engine->name, rq->fence.context, rq->fence.seqno);
> >> 
> >> since you are touching drm_info() where we use engine->gt then maybe
> >> it's good time to switch to gt_info() to get better per-GT message?
> >
> > I think the original reason for using drm_info is because we are
> > outside the GT. But, because the engine belongs to the GT, it
> > makes also sense to use gt_info(), I don't oppose.
> >
> > It would make more sense to move this function completely into
> > gt/.
> 
> Can we converge on the patch instead of diverge, please?
> 
> It's a Cc: stable null pointer dereference fix.
> 
> It's already been iterated for two weeks to reach v6.
> 
> Fix the comment typo while applying, but there's nothing inherently
> wrong here AFAICT. Merge it and move on.

Thanks for the feedback, will go ahead and merge.

All other gt/ adjustments can be done later.

Andi

