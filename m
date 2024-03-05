Return-Path: <stable+bounces-26756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E8871B4F
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F345528187B
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91B5A4E0;
	Tue,  5 Mar 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKMcoSjC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3244548F5
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633941; cv=none; b=hCFOT13/AOLMO639aNCsCWOmH57TiQSI7dtSwuSIa2KWKLty0QRPf+H6V9EGkeXwUMIjNb9PicJnjyHLSm8iVseYMmBUUqmHkPd9jRLNzqfwrh7/Z27cKE4NU3BKwjYargvy2zMKex4Bm9Z0yBkzslZct21G5CS+IzqelLsCp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633941; c=relaxed/simple;
	bh=BF/pBSiXdbQyOEIM8kTA33A2GgG45f64qyPk+qc59Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow0x79MVl/VlmmvOrDst/yXJIcyh11nikKmjP/jM0AvvAm8+sebGsOnBIx+h+fXH9FVl6+AzJ45t9CnZiSgoy7SQm5LyjDp0PiCvwadHHzDcZIGc0c3RyDFLKlcsgQ5bj7E5BdzQbs5iFPQNOA1C4NluLzbpbVUWAQB/UN2vhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKMcoSjC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709633940; x=1741169940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BF/pBSiXdbQyOEIM8kTA33A2GgG45f64qyPk+qc59Eg=;
  b=UKMcoSjCvXi1ZMAzcg9A7qbPiizNYzspE9XO8FeE4Pbiyns1fIatZG89
   I3XFZKaHrvdFFBYQtc3tOsRKSzdYZ7XJr5qQzjkGz2n+6qGHrNzNeKfxC
   3sNoid7cV5NspmM5hI17+hFgfqlDQsG5vXbOPpCPytTW8nZMipdRMkZI1
   IaDZ4MKIBXMcB7NWUTHS/jfsJLpoPwwioJBoAbn3AevHL93p4YViWiZRu
   /cXPXfy6bUTtjUGdEBAucznqU1XJQ9uPDVzK0WmOKW9k+dE1AsG0IlrOC
   DdhJfDuAffSIr4tqYeHjAWYazFYcxvBoS4YmXgMrxzNZCwsOsdtsyNkPt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14821806"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14821806"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 02:18:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14003443"
Received: from unknown (HELO intel.com) ([10.247.118.75])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 02:18:52 -0800
Date: Tue, 5 Mar 2024 11:18:45 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	stable@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [PATCH v3 1/4] drm/i915/gt: Refactor uabi engine class/instance
 list creation
Message-ID: <ZebxhWK4axnMdLDd@ashyti-mobl2.lan>
References: <20240229232859.70058-1-andi.shyti@linux.intel.com>
 <20240229232859.70058-2-andi.shyti@linux.intel.com>
 <170963369058.35653.11240745207600457716@jlahtine-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170963369058.35653.11240745207600457716@jlahtine-mobl.ger.corp.intel.com>

Hi Joonas,

...

> >  void intel_engines_driver_register(struct drm_i915_private *i915)
> >  {
> > -       u16 name_instance, other_instance = 0;
> > +       u16 class_instance[I915_LAST_UABI_ENGINE_CLASS + 1] = { };
> 
> Do you mean this to be size I915_LAST_UABI_ENGINE_CLASS + 2? Because ...

Yes, this is an oversight. I was playing around with indexes to
optimize the code a bit more and I forgot to restore this back.

Thanks,
Andi

> <SNIP>
> 
> > @@ -222,15 +224,14 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
> >  
> >                 GEM_BUG_ON(engine->class >= ARRAY_SIZE(uabi_classes));
> >                 engine->uabi_class = uabi_classes[engine->class];
> > -               if (engine->uabi_class == I915_NO_UABI_CLASS) {
> > -                       name_instance = other_instance++;
> > -               } else {
> > -                       GEM_BUG_ON(engine->uabi_class >=
> > -                                  ARRAY_SIZE(i915->engine_uabi_class_count));
> > -                       name_instance =
> > -                               i915->engine_uabi_class_count[engine->uabi_class]++;
> > -               }
> > -               engine->uabi_instance = name_instance;
> > +
> > +               if (engine->uabi_class == I915_NO_UABI_CLASS)
> > +                       uabi_class = I915_LAST_UABI_ENGINE_CLASS + 1;
> 
> .. otherwise this ...
> 
> > +               else
> > +                       uabi_class = engine->uabi_class;
> > +
> > +               GEM_BUG_ON(uabi_class >= ARRAY_SIZE(class_instance));
> 
> .. will trigger this assertion?
> 
> Regards, Joonas

