Return-Path: <stable+bounces-20792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A7B85B8B8
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 11:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9CB5B2AC95
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA1460ED4;
	Tue, 20 Feb 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNFNESr7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E165BC5
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423892; cv=none; b=B/4X7WFeKbeBbsUw9thxFviXnP/7mAkz2sJ1LIooyg9rdhnTzek5rPqjHkWUMCGy9T2UfG+wlhOb0fX1bm3zsTeZyRf8hm+wEUtBZQVYf1b5kwqicTHvHVrRDVtZzEKRnXpUK4y+61iFft5qjkKgkOU6BEJSXRhWSrq7dtkUMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423892; c=relaxed/simple;
	bh=J+RrAvgAZ/dBGAykNGTMqVRFNALZHRz2/TPDIvHsrzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgPliMOu5JW4vogID2Cyxc+sOAEpXFya0cZY6T8SRzlgXFx2HRkHvVkLOYKI0f8Uec3os7e+B+B/8oRDWgPDQXwh5mrhSBkdedtjPgbc1IX3HOfWo8XqN1L6PIlp1y6zk0t411y3JYEqwE1wx+hGTlP8QFAqL8/3aCVljq0t2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNFNESr7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708423891; x=1739959891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J+RrAvgAZ/dBGAykNGTMqVRFNALZHRz2/TPDIvHsrzk=;
  b=CNFNESr76ZpkcQn+G3P+fAhVisB1j71/JiOMgz0zAfCyyHjWOEy0TTvS
   Q1I+mOZUVFvhM6OqtnN6GDiaXiOqVrDl/Brd4geIM3vUaFts1/hJHgeYQ
   YY9Bgt7cSe1QykyOSEeTxRnH6IeIMDoumL83j9hKUJgTOTNDaGAbJ5Yc3
   vhQfXMOPS12Er0I3gYk63Eyu29u6RAP2HGjWBNasDjxFNssMpBcpQ23EC
   OMYuh+poSbnZmY2Mhhv/txJvQb+39AE9crPayLJU8HZZSBFrE7jmIy6cx
   HW0cJiVY2j14pRVR7HNqQ8TrjM1S858UEmhEeAqAIrM5X3bSUiKdq9CUF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2392153"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2392153"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913048490"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913048490"
Received: from alichtma-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.34.74])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:11:27 -0800
Date: Tue, 20 Feb 2024 11:11:25 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 2/2] drm/i915/gt: Set default CCS mode '1'
Message-ID: <ZdR6zeDlKXqR1mvZ@ashyti-mobl2.lan>
References: <20240215135924.51705-1-andi.shyti@linux.intel.com>
 <20240215135924.51705-3-andi.shyti@linux.intel.com>
 <d61391f6-ff1d-4241-bd9e-2a3bee53c860@linux.intel.com>
 <c63a2d0e-fc57-4252-ad3d-2aa7615e062d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c63a2d0e-fc57-4252-ad3d-2aa7615e062d@linux.intel.com>

Hi Tvrtko,

On Mon, Feb 19, 2024 at 12:51:44PM +0000, Tvrtko Ursulin wrote:
> On 19/02/2024 11:16, Tvrtko Ursulin wrote:
> > On 15/02/2024 13:59, Andi Shyti wrote:

...

> > > +/*
> > > + * Exclude unavailable engines.
> > > + *
> > > + * Only the first CCS engine is utilized due to the disabling of
> > > CCS auto load
> > > + * balancing. As a result, all CCS engines operate collectively,
> > > functioning
> > > + * essentially as a single CCS engine, hence the count of active
> > > CCS engines is
> > > + * considered '1'.
> > > + * Currently, this applies to platforms with more than one CCS engine,
> > > + * specifically DG2.
> > > + */
> > > +#define for_each_available_uabi_engine(engine__, i915__) \
> > > +    for_each_uabi_engine(engine__, i915__) \
> > > +        if ((IS_DG2(i915__)) && \
> > > +            ((engine__)->uabi_class == I915_ENGINE_CLASS_COMPUTE) && \
> > > +            ((engine__)->uabi_instance)) { } \
> > > +        else
> > > +
> > 
> > If you don't want userspace to see some engines, just don't add them to
> > the uabi list in intel_engines_driver_register or thereabouts?

It will be dynamic. In next series I am preparing the user will
be able to increase the number of CCS engines he wants to use.

> > Similar as we do for gsc which uses I915_NO_UABI_CLASS, although for ccs
> > you can choose a different approach, whatever is more elegant.
> > 
> > That is also needed for i915->engine_uabi_class_count to be right, so
> > userspace stats which rely on it are correct.

Oh yes. Will update it.

> I later realized it is more than that - everything that uses
> intel_engine_lookup_user to look up class instance passed in from userspace
> relies on the engine not being on the user list otherwise userspace could
> bypass the fact engine query does not list it. Like PMU, Perf/POA, context
> engine map and SSEU context query.

Correct, will look into that, thank you!

Andi

