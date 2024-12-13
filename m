Return-Path: <stable+bounces-104136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A2E9F1226
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 17:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09381880A51
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409501E3768;
	Fri, 13 Dec 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRUb/G8m"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76F1E0B75
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107380; cv=none; b=XuNoVyHuE2tMx4BvaWIaNZ2mJ9meZxGdp/u6lVWQpPzOK7G86xoTWKp9ttDcuu+m1jHR+kmG6Itzw+kq5CFAEheHM79JhnO1jk7C/7mOLvdTRbMdOlq5J96mmF9LyGKz3kMnvuSBjlO/o0jGdc31O/kCV3jpTon0Oerv5mmaLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107380; c=relaxed/simple;
	bh=AnVP2N+Docix5tFf4PjFVOoDujSnbIn0HYZoojpcaVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Np+GjeBNBoAWIQk8oqX5eDQW4LZxjsUbIwfgQVR+vZPwXu5f5UvZ7NcG7E0Gn3cKU6xTYDfPq938hS5CR1m2AhPZEFaCzMZtNaJt6NkA0SOy/OViIrnbQC1EKIkSClUntSOhKdxNf8ocOV1sz27ABQmy+6R5nAuGXQExiJsOni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRUb/G8m; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734107378; x=1765643378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AnVP2N+Docix5tFf4PjFVOoDujSnbIn0HYZoojpcaVI=;
  b=mRUb/G8mdeDr2NylvEF0FrpVPzk+mUYHmvxUGlqqeqJhGsubMAPevMzB
   LOmBI8UFKjUONQf08sDDU5fkIewcSE68tflc1BWokKCWSYdX2beROimxf
   FtZ4AczTcX0r4wTuaG4X/mQlW5ReIX1CMvR3gL8WQlJhpaPAZ966Z9Oir
   mV/3CQplHN47dPzDOk4oVat4LIxzFjXS2xiC+IWNno12LNtIZdCt6UhGQ
   WNm7VN9aMv8R0JNmYACik5ywe8L8Nlr4SBBKw7WXvi/Ru6WGuNQkgvnJO
   sA5+9uhffNWT4BC/4shhyDTLZiv/kDLxd1nHbYEwAS/6mBwylCgnMJlS3
   Q==;
X-CSE-ConnectionGUID: A1ccfDJlTKGL9IKUcHY6Fw==
X-CSE-MsgGUID: w4VYFQggTR6iNU2hYdESdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="37411016"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="37411016"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 08:29:37 -0800
X-CSE-ConnectionGUID: KN5+1kAMTOG4CBn3izs6gw==
X-CSE-MsgGUID: DRrRWAk0Tr2jOPsmc2I3WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127577628"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.161])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 08:29:34 -0800
Date: Fri, 13 Dec 2024 17:29:30 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Imre Deak <imre.deak@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>, Maarten@intel.com,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/display: use ERR_PTR on DP tunnel manager
 creation fail
Message-ID: <Z1xg6hOJJiBWixC6@ashyti-mobl2.lan>
References: <7q4fpnmmztmchczjewgm6igy55qt6jsm7tfd4fl4ucfq6yg2oy@q4lxtsu6445c>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7q4fpnmmztmchczjewgm6igy55qt6jsm7tfd4fl4ucfq6yg2oy@q4lxtsu6445c>

Hi,

who is going to take this patch? Can I merge it in
drm-intel-next?

Thanks,
Andi

On Thu, Dec 12, 2024 at 11:00:41AM +0000, Krzysztof Karas wrote:
> Instead of returning a generic NULL on error from
> drm_dp_tunnel_mgr_create(), use error pointers with informative codes
> to align the function with stub that is executed when
> CONFIG_DRM_DISPLAY_DP_TUNNEL is unset. This will also trigger IS_ERR()
> in current caller (intel_dp_tunnerl_mgr_init()) instead of bypassing it
> via NULL pointer.
> 
> v2: use error codes inside drm_dp_tunnel_mgr_create() instead of handling
>  on caller's side (Michal, Imre)
> 
> v3: fixup commit message and add "CC"/"Fixes" lines (Andi),
>  mention aligning function code with stub
>     
> Fixes: 91888b5b1ad2 ("drm/i915/dp: Add support for DP tunnel BW allocation")
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: <stable@vger.kernel.org> # v6.9+
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
>  drivers/gpu/drm/display/drm_dp_tunnel.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
> index 48b2df120086..90fe07a89260 100644
> --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
> +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
> @@ -1896,8 +1896,8 @@ static void destroy_mgr(struct drm_dp_tunnel_mgr *mgr)
>   *
>   * Creates a DP tunnel manager for @dev.
>   *
> - * Returns a pointer to the tunnel manager if created successfully or NULL in
> - * case of an error.
> + * Returns a pointer to the tunnel manager if created successfully or error
> + * pointer in case of failure.
>   */
>  struct drm_dp_tunnel_mgr *
>  drm_dp_tunnel_mgr_create(struct drm_device *dev, int max_group_count)
> @@ -1907,7 +1907,7 @@ drm_dp_tunnel_mgr_create(struct drm_device *dev, int max_group_count)
>  
>  	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
>  	if (!mgr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	mgr->dev = dev;
>  	init_waitqueue_head(&mgr->bw_req_queue);
> @@ -1916,7 +1916,7 @@ drm_dp_tunnel_mgr_create(struct drm_device *dev, int max_group_count)
>  	if (!mgr->groups) {
>  		kfree(mgr);
>  
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
>  #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
> @@ -1927,7 +1927,7 @@ drm_dp_tunnel_mgr_create(struct drm_device *dev, int max_group_count)
>  		if (!init_group(mgr, &mgr->groups[i])) {
>  			destroy_mgr(mgr);
>  
> -			return NULL;
> +			return ERR_PTR(-ENOMEM);
>  		}
>  
>  		mgr->group_count++;
> -- 
> 2.34.1

