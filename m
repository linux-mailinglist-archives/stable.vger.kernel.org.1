Return-Path: <stable+bounces-27123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE2875B3E
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 00:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE0D4B21D39
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 23:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4D047A76;
	Thu,  7 Mar 2024 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OG8hLxdQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEAF4FC
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855635; cv=none; b=fwsRks+XD/sHqjH8satb385/9PlHmjfJSMRQ63HmbV3QhgYOtzq/M6sf16AVunqZ7/V+egyK5YE7NVr2u8Ae3sPOJg4bnocD2fPm1ZooK8iDIYaxClnMa93MdjQ91wCMGIxOtOW5/cNBAuv3pVyIydc2aQ3LeU5Uvat09FkGX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855635; c=relaxed/simple;
	bh=oRMRLJaIOnXoiUMm1mzrGxqIAovQKaHNtAgi7eyje4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frNZHYJlwr2TEM6lUwSuXhy6WxrNtfCaoFi0xUv8cVHzTxd0NZohfgd16A+5jS7SUms2QGvRa6AqlIoxCw6OzlxN+hQnD//16oYKBQvaOcjmEBunUkMVruklEMZgD3SAGOTUjfVKgnkk0TkeOC1mwV03JDDN+T7CgjVaPlzLsjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OG8hLxdQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709855633; x=1741391633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oRMRLJaIOnXoiUMm1mzrGxqIAovQKaHNtAgi7eyje4A=;
  b=OG8hLxdQ4ihqEnxyPtOUxyLUB57yLW1mWkDpN06UzFZ2n80aq7vsQgL6
   r6q8kwyMsK3V9RlSvgH0RB989RNQB1AylB9bqvMKp1bdhX8ljA1EZZ8v9
   mxnkxf3etvePohVTJlCfsDVudTZYNE0UIvY7a4OnOubfHmf4GQr35+tGv
   efsYFwHzbFU+nHR9AbPaPvkkiYohsx9mu1A8uOeGXV4sGyqm8yI5k4KPT
   9mL+ErV2zAqwOfgBCkS67AP6/SziKVjqXuIff1wII8GFRVvSUJ3+NhxuK
   zioVSMEwoFvVvB6AKs9jOgCCcwiOOjpAXfOk0E+J9vJTXff1AvcHXTIfY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4437898"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4437898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 15:53:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="14844374"
Received: from unknown (HELO intel.com) ([10.247.118.98])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 15:53:47 -0800
Date: Fri, 8 Mar 2024 00:53:41 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: John Harrison <john.c.harrison@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	stable@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH v4 1/3] drm/i915/gt: Disable HW load balancing for CCS
Message-ID: <ZepThZYShdbxQOHi@ashyti-mobl2.lan>
References: <20240306012247.246003-1-andi.shyti@linux.intel.com>
 <20240306012247.246003-2-andi.shyti@linux.intel.com>
 <20240306234609.GF718896@mdroper-desk1.amr.corp.intel.com>
 <ZeodSUrgZXL_pjy0@ashyti-mobl2.lan>
 <11146c2d-726a-4b13-98a6-2360dbe77c3b@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11146c2d-726a-4b13-98a6-2360dbe77c3b@intel.com>

Hi John,

...

> > > > +
> > > > +		/*
> > > > +		 * Wa_14019159160: disable the automatic CCS load balancing
> > > I'm still a bit concerned that this doesn't really match what this
> > > specific workaround is asking us to do.  There seems to be an agreement
> > > on various internal email threads that we need to disable load
> > > balancing, but there's no single specific workaround that officially
> > > documents that decision.
> > > 
> > > This specific workaround asks us to do a bunch of different things, and
> > > the third item it asks for is to disable load balancing in very specific
> > > cases (i.e., while the RCS is active at the same time as one or more CCS
> > > engines).  Taking this workaround in isolation, it would be valid to
> > > keep load balancing active if you were just using the CCS engines and
> > > leaving the RCS idle, or if balancing was turned on/off by the GuC
> > > scheduler according to engine use at the moment, as the documented
> > > workaround seems to assume will be the case.
> > > 
> > > So in general I think we do need to disable load balancing based on
> > > other offline discussion, but blaming that entire change on
> > > Wa_14019159160 seems a bit questionable since it's not really what this
> > > specific workaround is asking us to do and someone may come back and try
> > > to "correct" the implementation of this workaround in the future without
> > > realizing there are other factors too.  It would be great if we could
> > > get hardware teams to properly document this expectation somewhere
> > > (either in a separate dedicated workaround, or in the MMIO tuning guide)
> > > so that we'll have a more direct and authoritative source for such a
> > > large behavioral change.
> > On one had I think you are right, on the other hand I think this
> > workaround has not properly developed in what we have been
> > describing later.
> I think it is not so much that the w/a is 'not properly developed'. It's
> more that this w/a plus others when taken in combination plus knowledge of
> future directions has led to an architectural decision that is beyond the
> scope of the w/a.
> 
> As such, I think Matt is definitely correct. Tagging a code change with a
> w/a number when that change does something very different to what is
> described in the w/a is wrong and a maintenance issue waiting to happen.
> 
> At the very least, you should just put in a comment explaining the
> situation. E.g.:
> 
>  /*
>  * Wa_14019159160: This w/a plus others cause significant issues with the use of
>  * load balancing. Hence an architectural level decision was taking to simply
>  * disable automatic CCS load balancing completely.
>  */
Good suggestion! I will anyway check tomorrow with Joonas if it's
worth the effort to set up a new "software" workaround.

Thanks,
Andi

