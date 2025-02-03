Return-Path: <stable+bounces-112031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3660DA25DAB
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D4616AC5C
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E867209669;
	Mon,  3 Feb 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGrxU8yF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47D1D63C4
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593996; cv=none; b=GuXYlzSez2sxy7wdUH5aKXSnMkAFZUxs3OgXAxJpAlmDVU38kIbuuM62Es8qcDSWk6hILArQKyRxu3jAf4/FYO5NFK+O4kjtvCjpIAaQvV4PeiEgWets35wVkjBPJ1E6F2g2heirguSAZbB10xPeGp4zk9U0hYEwegaRSy66uVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593996; c=relaxed/simple;
	bh=YpO1v529RKKL3vHoxGSx62bSIEbYwmYgE0YlW2dyMV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHpXH0maodBN+U4ALmhWOlKTWD7exFozCFHm4tMJ7Qx4fFaFS2lvECc33XXbBimkLi4jIpRR/A8uXefN7IrOStDeo3XUATNPfF2+DmWw8GccCl1NuoV50HQtvV9iBxV2+Y0em8QePrXdpBh4eAaSMWFJSr2ST/arCqLoit7M5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGrxU8yF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738593994; x=1770129994;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YpO1v529RKKL3vHoxGSx62bSIEbYwmYgE0YlW2dyMV4=;
  b=iGrxU8yFRVG1wwJXgy7R/2tX7X2meKjHreQ27kncxORr28SLk3utxOVr
   4eHZZha+pIR3qUm5miXrWbwq5oW1Fat2oO8RjtaObXUjw8TvNTSd7efTH
   ePztsGrg1ZCASuQoJc0j7H8/gwYnotndaYLbWM/VXe3yVXpABuUrsplXj
   7wpOzWubCTeyZijyGZLumNXM8nDBIfw4ICpEZmw2BFPf7gJsC7lxYGU32
   EOTe4NuI85uLL8iFpuZFI8TE9Pdo0PduTNGWCerDOQjDIOnNz0vgqZaYs
   7KW9uqsp27b1ilB+sLhomGToZIS3Q8VkWt5ywdvRVZxxFSxY5shtGhyE6
   A==;
X-CSE-ConnectionGUID: NS8+dhEPQQmHZVxLCIEZmQ==
X-CSE-MsgGUID: xfjhmUcVTziNtLtnwQ0mtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49742702"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="49742702"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 06:46:33 -0800
X-CSE-ConnectionGUID: T9qOx0TzRWW25SZjUc4I5A==
X-CSE-MsgGUID: iUVBEVtMRBq7tzZArjaNIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="115302792"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.71])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 06:46:31 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: imre.deak@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Ankit
 Nautiyal <ankit.k.nautiyal@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/14] drm/i915/dp: Iterate DSC BPP from high to low on
 all platforms
In-Reply-To: <Z5zQ9BjEkA_PN9Ns@ideak-desk.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1738327620.git.jani.nikula@intel.com>
 <3bba67923cbcd13a59d26ef5fa4bb042b13c8a9b.1738327620.git.jani.nikula@intel.com>
 <Z5zQ9BjEkA_PN9Ns@ideak-desk.fi.intel.com>
Date: Mon, 03 Feb 2025 16:46:28 +0200
Message-ID: <87ikpr6q7v.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 31 Jan 2025, Imre Deak <imre.deak@intel.com> wrote:
> On Fri, Jan 31, 2025 at 02:49:54PM +0200, Jani Nikula wrote:
>> Commit 1c56e9a39833 ("drm/i915/dp: Get optimal link config to have best
>> compressed bpp") tries to find the best compressed bpp for the
>> link. However, it iterates from max to min bpp on display 13+, and from
>> min to max on other platforms. This presumably leads to minimum
>> compressed bpp always being chosen on display 11-12.
>> 
>> Iterate from high to low on all platforms to actually use the best
>> possible compressed bpp.
>> 
>> Fixes: 1c56e9a39833 ("drm/i915/dp: Get optimal link config to have best compressed bpp")
>> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> Cc: Imre Deak <imre.deak@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.7+
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Reviewed-by: Imre Deak <imre.deak@intel.com>

Thanks for the swift reviews! Pushed the lot to drm-intel-next.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/i915/display/intel_dp.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
>> index d1b4fd542a1f..ecf192262eb9 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>> @@ -2073,11 +2073,10 @@ icl_dsc_compute_link_config(struct intel_dp *intel_dp,
>>  	/* Compressed BPP should be less than the Input DSC bpp */
>>  	dsc_max_bpp = min(dsc_max_bpp, output_bpp - 1);
>>  
>> -	for (i = 0; i < ARRAY_SIZE(valid_dsc_bpp); i++) {
>> -		if (valid_dsc_bpp[i] < dsc_min_bpp)
>> +	for (i = ARRAY_SIZE(valid_dsc_bpp) - 1; i >= 0; i--) {
>> +		if (valid_dsc_bpp[i] < dsc_min_bpp ||
>> +		    valid_dsc_bpp[i] > dsc_max_bpp)
>>  			continue;
>> -		if (valid_dsc_bpp[i] > dsc_max_bpp)
>> -			break;
>>  
>>  		ret = dsc_compute_link_config(intel_dp,
>>  					      pipe_config,
>> -- 
>> 2.39.5
>> 

-- 
Jani Nikula, Intel

