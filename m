Return-Path: <stable+bounces-43533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636618C247D
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 14:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951471C23771
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9B616EBE5;
	Fri, 10 May 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOs2jKN0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7D16EBFA
	for <stable@vger.kernel.org>; Fri, 10 May 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342527; cv=none; b=CMLLSzMNR4ycsBa4jH+vy3CAFwLQv0XHRU6ffnZosLFW6ilrkhlDlSHrZ7auWaKgxqLNF6ZHyc+0j5E0SF0nUFTyKomADpyU1DEvdNd/R4rzizktMxyH5sMBTjCtgsPhicLm9TyU3iW/HXgYwj1NnJ/bN5MTdqVvz3VHy88xwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342527; c=relaxed/simple;
	bh=4C7DOcXXxUjcar+h6n88HJ2Ag/CZKmZBqGERvtf4SHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QNZChNKqbUH+RCKuTF5dV7GDn+cs6hq3JDzabr29GwDEJqwytOs8CCLHfjO55PIXaZaowoHO+zsoMvKezJK4zSf9pOTJb0PlvDYoXWSEoEvJVPHLFD3/0VKz4CGLsR+Y8zfLw2SNG5FCAYrxdZmw0s9RUY1OSOKLpOcaKXm4RHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOs2jKN0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715342525; x=1746878525;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4C7DOcXXxUjcar+h6n88HJ2Ag/CZKmZBqGERvtf4SHE=;
  b=LOs2jKN0tHYCqzGSmhez4vHA4+dWD3J5PkOzAGLurdAkuTvrOXc5MXbC
   6W9obumERj96DhWwtqlOlqH5LiF7yLYahdrEPRhEmmbeR21EGkTVZCWnK
   rNw7wVE/0CRd67KHFRxYI5Jkv6p+/9sTBnpfrp04hzV919JZdCsOY5rWk
   GrsGu2WrsQAuHZ8O+ThQ+XZ6fjYaNgx+pDwoeJqvfB3OLgF8TLnGSopUP
   vZXDPZoMTgZzP9GEQ0wT6ZtOlTM+dXWzrbXP2lfioefnEN2KptdzwWchW
   loT7vPcBN0NROr1dJipYj5FDJfbeupvYdeiD1fDvOWQt+QMzEsXU63uFs
   Q==;
X-CSE-ConnectionGUID: ByjXBfz/SwS6v7YbhIg74g==
X-CSE-MsgGUID: QPsP/5CjRVe+ZBWJr7EveA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="33831122"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="33831122"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:01:46 -0700
X-CSE-ConnectionGUID: jNI7gh/hRZCBWO5ZAU9png==
X-CSE-MsgGUID: /Yq529mLQIq8URjE0F0t+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29542616"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:01:42 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@redhat.com, sean@poorly.run
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Robert Tarasov <tutankhamen@chromium.org>, Alex
 Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] drm/udl: Remove DRM_CONNECTOR_POLL_HPD
In-Reply-To: <20240410120928.26487-2-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240410120928.26487-1-tzimmermann@suse.de>
 <20240410120928.26487-2-tzimmermann@suse.de>
Date: Fri, 10 May 2024 15:01:39 +0300
Message-ID: <874jb5j2os.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 10 Apr 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> DisplayLink devices do not generate hotplug events. Remove the poll
> flag DRM_CONNECTOR_POLL_HPD, as it may not be specified together with
> DRM_CONNECTOR_POLL_CONNECT or DRM_CONNECTOR_POLL_DISCONNECT.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: afdfc4c6f55f ("drm/udl: Fixed problem with UDL adpater reconnection")
> Cc: Robert Tarasov <tutankhamen@chromium.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v4.15+

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/udl/udl_modeset.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> index 7702359c90c22..751da3a294c44 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> @@ -527,8 +527,7 @@ struct drm_connector *udl_connector_init(struct drm_device *dev)
>  
>  	drm_connector_helper_add(connector, &udl_connector_helper_funcs);
>  
> -	connector->polled = DRM_CONNECTOR_POLL_HPD |
> -			    DRM_CONNECTOR_POLL_CONNECT |
> +	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
>  			    DRM_CONNECTOR_POLL_DISCONNECT;
>  
>  	return connector;

-- 
Jani Nikula, Intel

