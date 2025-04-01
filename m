Return-Path: <stable+bounces-127350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E6EA781AD
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 19:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630857A4408
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D671CD21C;
	Tue,  1 Apr 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUsu23yy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0361494DB
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743529850; cv=none; b=CqUTWSkDgZ4ZnE+SNod2WLuOio9sWkuKFtcQLzg2ViopSc8OYDXbqhCRqL8l9QPL5PxFP5QxDiTVMTCGa7SjU7c4iZh19mCbcHBUFybFAlXKmqxOeCRoqVL5F4yLupeFBS6cts1NOtMcUf7h1DAOf4v1xSLV5qOxDNwUMZDtqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743529850; c=relaxed/simple;
	bh=pn9TC+0VtTDCfOS49JIjo04AVqs+OWCEk8H3qFPWgIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxa1ngRuV3Bzsvae9eY3ebEHIZo69yy0Ue7cTd1Rrp9bc9fKjVMz6bDsT57+doQBv5GFpcoTJ+s2Rm22MwZ3vGPbAeE8nUXm/d8gyfRzdZbtpUMiilVbkeYuc+9XCNDpHdxDPyUA2zT2GwblfIiAFRsJtmS6onIElSrO3TM4Fwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUsu23yy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743529850; x=1775065850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pn9TC+0VtTDCfOS49JIjo04AVqs+OWCEk8H3qFPWgIU=;
  b=BUsu23yyQ4qyBEWN6ilPsoBDh/E472NnwaRNHZ33T4EkBDOnDXbvWGxk
   yESU6wn76q9RiQf8uOefIYMnlZdDBowadLKm5pURJPrT27fdeDWemSfIc
   D+Gv+L+dFgK9U3FZlikOFozofFTg+tKmX7aNlp7a3AP9e5C69ZNysrX0C
   crTx+yY/ejurI2i5rhxEiaIAVpdm9NiBpPRaELJexs/iC/OfcuVyNqqCv
   i2hV6kTa6IvFYNirDgQwrhnj/PAJD7x0DsHBSy+wzZgZJwARg1SF8p8tH
   16v++MtTjY/tEkw3ysiao6UtZIY7vBMF0OdxQHAZp/cyXhmjD/j9t/f+7
   g==;
X-CSE-ConnectionGUID: IlCO28mTQYWHL6truVLkwQ==
X-CSE-MsgGUID: mEq3MngFT2a7KVE9xy86CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="48534254"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="48534254"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 10:50:49 -0700
X-CSE-ConnectionGUID: 4AHHUBbfRs2e1rLqttcjuw==
X-CSE-MsgGUID: M2EBa5JTSZOzrre7lE1ghw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="131659252"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 01 Apr 2025 10:50:47 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 01 Apr 2025 20:50:45 +0300
Date: Tue, 1 Apr 2025 20:50:45 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 3/4] drm/i915/gem: Allow EXEC_CAPTURE on recoverable
 contexts on DG1
Message-ID: <Z-wndcsylr5eK0F8@intel.com>
References: <20250401163752.6412-1-ville.syrjala@linux.intel.com>
 <20250401163752.6412-4-ville.syrjala@linux.intel.com>
 <Z-wjk-9ZVEpBVw0G@ashyti-mobl2.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-wjk-9ZVEpBVw0G@ashyti-mobl2.lan>
X-Patchwork-Hint: comment

On Tue, Apr 01, 2025 at 07:34:11PM +0200, Andi Shyti wrote:
> Hi Ville,
> 
> On Tue, Apr 01, 2025 at 07:37:51PM +0300, Ville Syrjala wrote:
> > The intel-media-driver is currently broken on DG1 because
> > it uses EXEC_CAPTURE with recovarable contexts. Relax the
> > check to allow that.
> > 
> > I've also submitted a fix for the intel-media-driver:
> > https://github.com/intel/media-driver/pull/1920
> 
> ...
> 
> >  		if (i915_gem_context_is_recoverable(eb->gem_context) &&
> > -		    (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 0)))
> > +		    GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
> 
> How is this is more relaxed than the old version?

It doesn't trip on DG1 (ip ver == 12.10)

-- 
Ville Syrjälä
Intel

