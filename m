Return-Path: <stable+bounces-95703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA309DB6E5
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 12:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938A0281CEA
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77B19AD87;
	Thu, 28 Nov 2024 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArYOpwNG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52606199385;
	Thu, 28 Nov 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794527; cv=none; b=G5dpIlw7hWGwp3D+ZNktsEo63BWYoiwUbMU6YNSpdW8vlaMrv2CNW8cYqO54pn4QdUGLYAvVT6aT8ayeZWKhekBPiJgcH6UwimgKpRpqSwMxtOdEtniqE/FLjgDSLB11dkbciHnMZSEBNtpsZkLng8xI46Ba8XnArlMxCF4riv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794527; c=relaxed/simple;
	bh=1z7JkOtGu3oguHkHpEdwAnaqNk5e6McbHqCPM/nUY5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvNLJLrPE/phe6BZs5LuhAqce6fP95goDXgdH4noMpvQP/8kGzChigLlVGgYldoCSgQ7epTC5ztJ46FYvmid/rE7LdiZWJjB/Y0ARcmFArJtJK8KSsqm3XR9kp+Ss1Qg6cSbWf2tYn5Z4LJE2Qu4EGdflAdFdEXvTveDo8FY8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArYOpwNG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732794526; x=1764330526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1z7JkOtGu3oguHkHpEdwAnaqNk5e6McbHqCPM/nUY5g=;
  b=ArYOpwNGN3AsgsedkGBwKjZvF8FBJh/zIRHyzeRro6F1cqdR1xj8HTSz
   sXPdeMhJjnTPxrJesr0lRnGJdFYuRvZ3MDFMYLRYXgKUWG2QE5LR9KEg5
   ibrjmMvWhM9Z7/+J2vEQvVOir2sMdBvGZclVXEBYZOnomIh4cu32DbuWH
   Lz/JU40ULKbX12mk1ICrERQsD2CV0zWwDZjm3/EbZlXPZMX34XWcpOolk
   hG3dIyoYXJbR8B4Oul6pTG/hlgKcz7hpM+FKyaV6CZnPgba0f0aKD2AMI
   2Cd8AXzW7EDlRpUQsJobE4rrxAkQqEkd4FWvdh6BCw6W+zz8Gl6BvmlHQ
   w==;
X-CSE-ConnectionGUID: crIqH/D9SPWaolTU0qw/yw==
X-CSE-MsgGUID: LsLwO/rCSHWgmEReH097gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="33268089"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="33268089"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 03:48:45 -0800
X-CSE-ConnectionGUID: YCpBMwp+TGy9HtqSxvOd+A==
X-CSE-MsgGUID: W8jUaiktQs+93EeM8vuljg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="96311749"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.166])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 03:48:40 -0800
Date: Thu, 28 Nov 2024 12:48:36 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: nirmoy.das@linux.intel.com, jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
	tursulin@ursulin.net, airlied@gmail.com, daniel@ffwll.ch,
	chris@chris-wilson.co.uk, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@outlook.com>,
	stable@vger.kernel.org, Nirmoy Das <nirmoy.das@intel.com>
Subject: Re: [PATCH RESEND v2] drm/i915: Fix memory leak by correcting cache
 object name in error handler
Message-ID: <Z0hYlNey1zyinvby@ashyti-mobl2.lan>
References: <20241127201042.29620-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127201042.29620-1-jiashengjiangcool@gmail.com>

Hi Jiasheng,

On Wed, Nov 27, 2024 at 08:10:42PM +0000, Jiasheng Jiang wrote:
> From: Jiasheng Jiang <jiashengjiangcool@outlook.com>
> 
> Replace "slab_priorities" with "slab_dependencies" in the error handler
> to avoid memory leak.
> 
> Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")
> Cc: <stable@vger.kernel.org> # v5.2+
> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

