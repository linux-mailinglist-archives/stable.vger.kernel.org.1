Return-Path: <stable+bounces-27519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F6879D06
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 21:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97635B23404
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 20:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48331142907;
	Tue, 12 Mar 2024 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0dOAMSp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD701E529
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275885; cv=none; b=L9BiX81veChb8TO4T9vjs+Q99odz6VJams6AOHBQ38l8a4C39dMBXG3SodcRVjVJbBfNUmkImfOOBA448wxUR9/foGg0HXlWuDdFeOR/VG8mfEaumxsROirwigl4A8zAr2ONL50UAGcmrH7eAK+SueksBPM1Hcud0pOzphbLG18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275885; c=relaxed/simple;
	bh=wUxiOyax77zUtSgs22IqO/hNnlK6lYN7E6k4/7hTRDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyRlLYKRZVO7bWknSUi4nhB6tw28rYpk+BK5/YJkoZBuZE2ylR038fOVVA1ht5OCJRUXEq0RALZJd2Pc+VgwHp0OWYw7/V8X8rSeGFpFGZ7Kq/s23eR0ezdIW/cC8BxVbAf1n1jFhpfzd4v3uhuhxI9Qul7mBdJaVp47HUj21ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0dOAMSp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710275883; x=1741811883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wUxiOyax77zUtSgs22IqO/hNnlK6lYN7E6k4/7hTRDQ=;
  b=j0dOAMSpdIR83qQk7Wt70MODje5V9PzzNdqDvAk2AknVsCn3V4wdDaUL
   alUsWPwoKF6Zv61R/bLVlawgGeNH9uI745dR4Z28gVk0Oomw4LnSGAdJk
   fOU88JqTiZVQ3729I0ZjqpfUZCjVWcx7nbYN2vBrTgOjLCJ56dGmzcCVJ
   1cAxKkpWedPupkC2r30q4H105v9doF8Rlw2K0TqNUUyzSnGbrFr5+trXt
   rzgBoAylcYLkq1V5Kzq6Z0B8u2kZL/+kHVTt7gyc8/wZRA9CLhvVrxAmP
   4p/TcFvAmPuaPAuLlb/f+qc5RGRGEC9C4nWHuz/GBugeT6M+lwNhqnQB/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4861905"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4861905"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 13:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16311033"
Received: from unknown (HELO intel.com) ([10.247.118.142])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 13:37:56 -0700
Date: Tue, 12 Mar 2024 21:37:50 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	John Harrison <John.C.Harrison@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH v5 1/4] drm/i915/gt: Disable HW load balancing for CCS
Message-ID: <ZfC9Ho6zAxjZDQ-O@ashyti-mobl2.lan>
References: <20240308202223.406384-1-andi.shyti@linux.intel.com>
 <20240308202223.406384-2-andi.shyti@linux.intel.com>
 <20240312165825.GK718896@mdroper-desk1.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312165825.GK718896@mdroper-desk1.amr.corp.intel.com>

Hi Matt,

...

> >  #define GEN12_RCU_MODE				_MMIO(0x14800)
> >  #define   GEN12_RCU_MODE_CCS_ENABLE		REG_BIT(0)
> > +#define   XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE	REG_BIT(1)
> 
> Nitpick: we usually order register bits in descending order.  Aside from
> that,

I can take care of it.

> Reviewed-by: Matt Roper <matthew.d.roper@intel.com>

Thanks!
Andi

