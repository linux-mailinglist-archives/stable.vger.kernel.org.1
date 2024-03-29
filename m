Return-Path: <stable+bounces-33746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB28922C3
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 18:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CD3288888
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B552F79;
	Fri, 29 Mar 2024 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/AT2FbV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7462C6B1
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733367; cv=none; b=oWhbS+gzyDxh0k2yjId9Yr4JZPnd6GmO26E/e6gdm7J/Zm+BSnouqfHppv14Kw5jx8RFMwRme4hy8MwosKZ7bmk8Ybm5QVWsMDL7IAZ+yHORzepzfsicxYbipAurFr42I7wwpj+TEY14UJmLcWipC1awB9O7LvRmennA+D1V11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733367; c=relaxed/simple;
	bh=BE78lL2Did2HaNRVRmEexyAi2/OaSw1zM/iNQDPIMyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU4RbW4ZtQmi1tVCAnklzQE1EaJpPv44HWwgZx2chztydD6YyRCW+duJU9AYfthnIOtrcbUPtvuLA+Ge2UoLuNkYUcjz2vtNV+s/DaGQOQDxNF+1znnR73aLY4NfhI/z8MXy2LTPWuwNjeO9S221DGhQd/pC1vtV7xUNi32/ZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/AT2FbV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711733366; x=1743269366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BE78lL2Did2HaNRVRmEexyAi2/OaSw1zM/iNQDPIMyo=;
  b=A/AT2FbV2GkCSJ1/6InUPIsbKar6zTVRxgjhO8uI6+Nf639O05b12ZAx
   v9L92Pa5NNJFrXFvAO7YyAJLEqMb5M4qCM4/rLuqTly1G4EGoBUkhwXkc
   Vx0Wjp9leh3tvxh7mV87FNM1Gtj8hokOoh6KPvEIK+zf5eQUpgShoCr06
   3WY4wREHumi/gCjIk6labSVJ4yLbLi2iTNBkVVonJGPFjJIXmRQz3gIGJ
   Nwd6tfNfhC5mpxlc0kqt9SyaajfkshoIH1moj7oOqV2VLJCOazH9NFQck
   J2hUASgnqzpmd8qe5vhpBmwbVCBPu7lyDptPs1nxzfBy0dXqTLpWS8hAu
   Q==;
X-CSE-ConnectionGUID: GJy8vJrKRfORISxhFOG4Vg==
X-CSE-MsgGUID: PMxD3vGdRf2mCS4DeP8gYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7055415"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7055415"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="827787028"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="827787028"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 29 Mar 2024 10:29:23 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 29 Mar 2024 19:29:22 +0200
Date: Fri, 29 Mar 2024 19:29:22 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: v6.7+ stable backport request for drm/i915
Message-ID: <Zgb6coxpAvZQBNWf@intel.com>
References: <ZfnpxcS2dXkzlExH@intel.com>
 <2024032904-reformed-pupil-7519@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024032904-reformed-pupil-7519@gregkh>
X-Patchwork-Hint: comment

On Fri, Mar 29, 2024 at 02:15:12PM +0100, Greg KH wrote:
> On Tue, Mar 19, 2024 at 09:38:45PM +0200, Ville Syrjälä wrote:
> > Hi stable team,
> > 
> > Please backport the following the commits to 6.7/6.8 to fix
> > some i915 type-c/thunderbolt PLL issues:
> > commit 92b47c3b8b24 ("drm/i915: Replace a memset() with zero initialization")
> > commit ba407525f824 ("drm/i915: Try to preserve the current shared_dpll for fastset on type-c ports")
> > commit d283ee5662c6 ("drm/i915: Include the PLL name in the debug messages")
> > commit 33c7760226c7 ("drm/i915: Suppress old PLL pipe_mask checks for MG/TC/TBT PLLs")
> > 
> > 6.7 will need two additional dependencies:
> > commit f215038f4133 ("drm/i915: Use named initializers for DPLL info")
> > commit 58046e6cf811 ("drm/i915: Stop printing pipe name as hex")
> 
> All now queued up, thanks.

Thanks.

-- 
Ville Syrjälä
Intel

