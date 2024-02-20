Return-Path: <stable+bounces-20828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F3985BF00
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50AE288746
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434EE6A8CA;
	Tue, 20 Feb 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maRDBZSA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42D2F2C
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440177; cv=none; b=dmVJ7nQqbe+xmj0d4xd5HuhBNZqywfOr+VdlLRjLVNDLcli6gVKaoy656kC2bc1vLzRABeY86DzI79QsiPaDiBWhKJJgFbizY3h7TovaF3K09ggu9U+XEXzb22H898tXSfFyDOKsK7vsMlbIHnjh+rlM5DvYwIjHDB9xnbueSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440177; c=relaxed/simple;
	bh=kNn7awcjh//PjUungTG8A1H2uT/756QuzdLQvdLsh7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5eVQAjdYKSj5Z5WKxGRa9sdcNJqr0J3m6jMGXo2XQ/SVG1ZxiFPuikPEbZ3dYhvO1Rz8pvCxx51g6r5cwN0QCucKCUgn6o0jZVtyxzVQWT92OMiJW+4lrhVllqBgstU2EaklFYzOwREIK0HngQ03mfXGTnPO9KoNZUoWNV6PPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maRDBZSA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708440175; x=1739976175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kNn7awcjh//PjUungTG8A1H2uT/756QuzdLQvdLsh7g=;
  b=maRDBZSAEvhuZZ0i4HH6FYDTMlYbrMmNaHl4UmuY+cy+YwJggcOjWrwB
   TbG9JTbF8uk3mK2NxR9g+xu+2m1mEfd+dUHJj5VYSWfSJ2bmJ7oWmTrbA
   A7KrsWq9GKDQftKCRqHwykH4IIpvG8lpKCQWeKkJ3Ye8oXupatFtkpPlB
   xZF3XyuQMFFql0X5rYgMM3DUvdt9Pfie9fVE7/hpXKHJsah1QBrUnFz/I
   RZDcMSvxV4GNf04vM+rEGe1GbE4J3aOsR/RPdHirH1j7gOzgAo5uaIxez
   2THG3chb+CQVd684Qzap1pHLv6SZdHFXDUaFTCeOxR23SRbdzp0kTKwmT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2405531"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2405531"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:42:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4841629"
Received: from alichtma-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.34.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:42:52 -0800
Date: Tue, 20 Feb 2024 15:42:49 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	stable@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v2 2/2] drm/i915/gt: Enable only one CCS for compute
 workload
Message-ID: <ZdS6aTy88pMIt-z0@ashyti-mobl2.lan>
References: <20240220143526.259109-1-andi.shyti@linux.intel.com>
 <20240220143526.259109-3-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220143526.259109-3-andi.shyti@linux.intel.com>

Hi,

[...]

> diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
> index 3baa2f54a86e..d5a5143971f5 100644
> --- a/drivers/gpu/drm/i915/i915_query.c
> +++ b/drivers/gpu/drm/i915/i915_query.c
> @@ -124,6 +124,7 @@ static int query_geometry_subslices(struct drm_i915_private *i915,
>  	return fill_topology_info(sseu, query_item, sseu->geometry_subslice_mask);
>  }
>  
> +

sorry, this is a leftover from the cleanup.

Andi

>  static int
>  query_engine_info(struct drm_i915_private *i915,
>  		  struct drm_i915_query_item *query_item)
> -- 
> 2.43.0

