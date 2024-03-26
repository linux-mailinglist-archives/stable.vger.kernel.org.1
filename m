Return-Path: <stable+bounces-32315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC588C1EC
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 13:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEF11C39996
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC156F529;
	Tue, 26 Mar 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sky6Ll09"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B41848
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455621; cv=none; b=JMiV1q/a0ZXIrTPJG0qmkutLzU4XdOXBSpa8qfywugbRLyVT+8gEbc3xTDJOBcY04S6/Rze4PUMy5ycfsPVi+rQSxZuix27N5ToqfD3pX2BKzWBsObGgLkdSqgyWNpm/qckeYTFBHcEf5c2fANJ/Xpoht4ozrUwroZTHVnIYZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455621; c=relaxed/simple;
	bh=bqqUgsswySbKHsGHIkPLfJ+fPYsgPb6K85jHwhXowHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfkemgKVsjnGXV+9oi1lJk6vOxNXl6spQjU/vEAE/VI6O6Xg+OQfNL8+VZkenX/WFvpIRaaL+X177UjLoghmYChwF77ZomHSEj5j4kHN6wuntrZvGlcfspntcmRfFi2ezAO9BiLNKnF2k6npBFAybQ8mna2Dz5UoEUmkVSWUojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sky6Ll09; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711455620; x=1742991620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bqqUgsswySbKHsGHIkPLfJ+fPYsgPb6K85jHwhXowHw=;
  b=Sky6Ll09oa9b+oWGfmxHjLm19aygvbvF/xc8w/QvWGQjSglk8hXg6Prw
   +PP5hqaaMopg7zpraegeewVIHzczcKJQnIy/qFkhwfOm4ljle/xeK/JeU
   AE+Nyn/qqPtJ6ziqoAXbicPDLjLuvUUGJewKj2+TOuP8xyY75ZqRrpD6x
   pZeAJUrBnJIALsJzpqzNQ9OF3wp4aZadqsYmJNmyUFrgwzkLAZ2IE4n/X
   xHMJQpX0alQGyXUpIxzhoeX0a9+ZqH1lGhVoZyY/EzsMp8vhvTlJRJ/pF
   pzgfHucxGmwPHKIbDFKmGmTQfIGKATrfkijj/I/unDuKNWoIrIbGfU2yg
   g==;
X-CSE-ConnectionGUID: zHgmXXDbQwOb9S0MTkLVhw==
X-CSE-MsgGUID: xJIJiDBWS2e+11A7KxqLSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6396810"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6396810"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 05:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="827785215"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="827785215"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 26 Mar 2024 05:20:16 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 26 Mar 2024 14:20:16 +0200
Date: Tue, 26 Mar 2024 14:20:16 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Pre-populate the cursor physical dma address
Message-ID: <ZgK9gFwhNjqMEd-h@intel.com>
References: <20240325175738.3440-1-ville.syrjala@linux.intel.com>
 <20240325182135.GGZgHAr9jz8I-geZff@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325182135.GGZgHAr9jz8I-geZff@fat_crate.local>
X-Patchwork-Hint: comment

On Mon, Mar 25, 2024 at 07:21:35PM +0100, Borislav Petkov wrote:
> On Mon, Mar 25, 2024 at 07:57:38PM +0200, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > Calling i915_gem_object_get_dma_address() from the vblank
> > evade critical section triggers might_sleep().
> > 
> > While we know that we've already pinned the framebuffer
> > and thus i915_gem_object_get_dma_address() will in fact
> > not sleep in this case, it seems reasonable to keep the
> > unconditional might_sleep() for maximum coverage.
> > 
> > So let's instead pre-populate the dma address during
> > fb pinning, which all happens before we enter the
> > vblank evade critical section.
> > 
> > We can use u32 for the dma address as this class of
> > hardware doesn't support >32bit addresses.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 0225a90981c8 ("drm/i915: Make cursor plane registers unlocked")
> > Link: https://lore.kernel.org/intel-gfx/20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local/
> > Reported-by: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Thanks for the fix - splat is gone.
> 
> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thanks. Pushed to drm-intel-next.

-- 
Ville Syrjälä
Intel

