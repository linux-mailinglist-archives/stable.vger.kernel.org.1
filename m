Return-Path: <stable+bounces-20822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEBA85BEDD
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BBE283CCB
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A56A32C;
	Tue, 20 Feb 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXPitlYR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43D6627F3
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439674; cv=none; b=ZVzU8fT8ZQqNW7olsa8xiXagvHyuUh2+QoFk337J4KpyoMB/fwUjNXsQmzFADHjHxX9pexSqLimjh+4+1lL1xTb6KRe0tjdcZlpiO25MybiKaprrXM/BCDzUNtAwm+WnBeOCTqmRV0GI9XHTbgiXvqP3N1OTKsuYxElJlbzLUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439674; c=relaxed/simple;
	bh=f3O+4m4HaBjm0z8H1sKrXMCClwRO1cpcmSYTOrXl0eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGfl+aStCDoC/sEbDth6B8uC6rlcPvSsu1b4fAwGI4SN/g4bo34ykMRiI15SMLo1EmqQitMx3+stY8idUMh8u2dhSWnZYsqdqJHh20a+qUoUyYLNXlGGB6Kh5qBgDJAvEg8PFeRLvmdtyrTZRTpW2u0WP+sR0Ou9fD4x4qQ0GfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXPitlYR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708439673; x=1739975673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f3O+4m4HaBjm0z8H1sKrXMCClwRO1cpcmSYTOrXl0eA=;
  b=DXPitlYRbTAuL1zgYLlRNZq4Cm0cTWS9Sd0Rf557VUZN8uh1EHA5Erfa
   Hmbo91SbzJEtw1Vllwr3thvXujo7aREfLw8IxKcTJhjsVyPuu1LB5opjB
   v+CPWuknxT37jD7qzeAJElzntZfNaHGR4wsUBsY6EyPMI7OEpdluM1Pdq
   aVNR+EuRZVuSv1WDYw3dssyo5Z3fFQxd3kWBIzZImzM1qJ+Y8qynmzh/R
   sAljDkPkYxoDi5YaXGD7sUsfdoe/jewN3PC9hKF8Myh5euRg+DCvFxXQB
   DgJhccPw0BgrDnKLu0on+YHRwkvARqKPu0xhpYvVpSnHhU+RUIcUX227t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2684591"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2684591"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4756361"
Received: from alichtma-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.34.74])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:34:29 -0800
Date: Tue, 20 Feb 2024 15:34:26 +0100
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
Subject: Re: [PATCH 0/2] Disable automatic load CCS load balancing
Message-ID: <ZdS4clVznjgskl1d@ashyti-mobl2.lan>
References: <20240220142034.257370-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220142034.257370-1-andi.shyti@linux.intel.com>

Please, ignore, I sent V1 again.

Sorry about the noise!

Andi

On Tue, Feb 20, 2024 at 03:20:32PM +0100, Andi Shyti wrote:
> Hi,
> 
> this series does basically two things:
> 
> 1. Disables automatic load balancing as adviced by the hardware
>    workaround.
> 
> 2. Forces the sharing of the load submitted to CCS among all the
>    CCS available (as of now only DG2 has more than one CCS). This
>    way the user, when sending a query, will see only one CCS
>    available.
> 
> Andi
> 
> Andi Shyti (2):
>   drm/i915/gt: Disable HW load balancing for CCS
>   drm/i915/gt: Set default CCS mode '1'
> 
>  drivers/gpu/drm/i915/gt/intel_gt.c          | 11 +++++++++++
>  drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  3 +++
>  drivers/gpu/drm/i915/gt/intel_workarounds.c |  6 ++++++
>  drivers/gpu/drm/i915/i915_drv.h             | 17 +++++++++++++++++
>  drivers/gpu/drm/i915/i915_query.c           |  5 +++--
>  5 files changed, 40 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0

