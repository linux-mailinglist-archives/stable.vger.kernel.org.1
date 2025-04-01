Return-Path: <stable+bounces-127365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDD1A78523
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 01:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C3816D56F
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 23:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8832101AE;
	Tue,  1 Apr 2025 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQNhtTxE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6E1E5B9C
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743549235; cv=none; b=O5iNBsMJxtWj+r9RxrfrGScq4JrNcgfcK3SAAKBFxonhveUeRIq5f6FR38jBiEojxvW7UXlnN0RqQfsklnquoyFqLllLANoPF0WpkvdYGwrBG+OzPI8yIyfrrl8jOk01b6WlUft42YAjfXfysnPO8ItJruX098ydMr87RcGVVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743549235; c=relaxed/simple;
	bh=d7FKJIWSPnUFbOLMp9eByP0D+uD/TvJurbFJi56Eykc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j89AyvESdnfJppu3n++CT5HGRz52YOsByst+tc2fZ/oVrnzwXwvNdYPw1cttS/vUnSnkN2lH59UrPz+Xm73W3yBTFrLJIBshs71nRkFIBREMAnGTt1pWxS5wAGmZrmnnxBkTh2cAHkoVlIq6TzCm4xq5NwAPgtChuEX/ytfSBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQNhtTxE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743549234; x=1775085234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d7FKJIWSPnUFbOLMp9eByP0D+uD/TvJurbFJi56Eykc=;
  b=VQNhtTxEWGMg+meJXbO1pdOxcV6MmvSNuiyPTFTEBpOWSzN7+TUgUb/6
   IZicI1NO9WyT85LsoKfEGv44ujyt9tqmrdeCh3sN/ZzybcqtLEAzmezFU
   XLo7GRvxkkcby2E7ngBKTVfDuiM8kWAXjRrN67v9iB2QoicuqS7U69jG5
   cSTFOi3zbBoIUGH13Tnk7oOrkr4mLjhSTenniFBZx/3+/klXpJv98PV4R
   fDDfq60dkAWXcUFuqrGhzzWN01eQpLEbgVcFkQwg0e6pYR+YdTmTpNAvb
   cSqTTFjbx5SQF3srGwkO0SWezlMCBNVyI49vbtcVCgN7i9oSCL03FXgu2
   w==;
X-CSE-ConnectionGUID: CaX1vHWYTFiAFDIbb28VZA==
X-CSE-MsgGUID: GuuAM1+gRbCmdYcWWtS9Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="56260962"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="56260962"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:13:52 -0700
X-CSE-ConnectionGUID: cO9dKsswSJ2JTiXrZuWOUg==
X-CSE-MsgGUID: Tlb3YrxjTrqP4kuWNrIt4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="131717226"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.184])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:13:50 -0700
Date: Wed, 2 Apr 2025 01:13:48 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-15?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 3/4] drm/i915/gem: Allow EXEC_CAPTURE on recoverable
 contexts on DG1
Message-ID: <Z-xzLIqdjhU3RVOA@ashyti-mobl2.lan>
References: <20250401163752.6412-1-ville.syrjala@linux.intel.com>
 <20250401163752.6412-4-ville.syrjala@linux.intel.com>
 <Z-wjk-9ZVEpBVw0G@ashyti-mobl2.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-wjk-9ZVEpBVw0G@ashyti-mobl2.lan>

Hi Ville,

> >  		if (i915_gem_context_is_recoverable(eb->gem_context) &&
> > -		    (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 0)))
> > +		    GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
> 
> How is this is more relaxed than the old version?

nevermind...

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

