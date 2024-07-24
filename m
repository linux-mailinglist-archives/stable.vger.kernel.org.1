Return-Path: <stable+bounces-61263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE30B93AF8C
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 12:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7F81F226B8
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99514A4C5;
	Wed, 24 Jul 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mObwESGX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235B13B585;
	Wed, 24 Jul 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815414; cv=none; b=YP+Dd/NuZ5AG3zgCnw0mmy7AT+ZdCAP0u/f73NWqQpqOqi1Yro/C1mGULjNbrvOE4f+htaGLScMnn6wnid4S6ziFBy+pylbpcfLlAX2sXyEwZB68VIl/+og2as/U2opx4AMjUv1zIyTKATqV+LoARgTyy++6WqbNFIwFz9ie7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815414; c=relaxed/simple;
	bh=r3nR0REmG7kZooPJAnuqkwEZtqjXLXvOL4nx11JK9vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k7ASxjTENQwT/l49D+5g1TpJ/t3DG1mQa+ZEj2gFEvsfQ1kuKc/WZYrf8OBXPtc6JhhpxYbb27toZIcqAFOqPffPawRYR6Jv/vlkeAWbjplmYSyYj/I02s/0bShmVPqpJkcaVR0G99+JHMs+x2gpiMOwOexhjgseHcR4fm84Yu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mObwESGX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721815412; x=1753351412;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=r3nR0REmG7kZooPJAnuqkwEZtqjXLXvOL4nx11JK9vc=;
  b=mObwESGXtgpWWUEpqxgx78mWEglPkYVwH3fCgBacYBqE0ZbLsL9fknbW
   WNfc2NSEm3Bhiz1rqpSww8Xm6DCxwl8OBSoxUnma+DWHSlYQ/KsMpYgXW
   N9oOnlzFe4tlqszqTdYbsAWMW0MN47FCmobz3Dismbjtym0tcLasKKeb3
   45ZuCVd0yEKH4ndIq3HICvFM7FZb9aH7NeIUsTg+wVAXsP9knfAPgmmxd
   Y4dhjeoMENCc4fwAjjIz6piG1PjnsPCS9Ds9Ur1fiEcF9THCu8z4ta3NX
   o8bOgOtojRAXeI61f6/7OdcsW6QrAu+us62CbnlcsCrSQCDiBbJVwTlo0
   g==;
X-CSE-ConnectionGUID: ALcDYnmZQFCKtD0jNMTEGQ==
X-CSE-MsgGUID: fPX7H/ZoQiGjlVPenBnqZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="12685353"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="12685353"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 03:03:30 -0700
X-CSE-ConnectionGUID: IiEjLHfJSbe1p3AJwHagfg==
X-CSE-MsgGUID: byMzT0Y5QOaj0BWYkyeRuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="83543849"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 03:03:27 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ma Ke <make24@iscas.ac.cn>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch, sam@ravnborg.org, noralf@tronnes.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ma Ke
 <make24@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/client: fix null pointer dereference in
 drm_client_modeset_probe
In-Reply-To: <20240724094505.1514854-1-make24@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240724094505.1514854-1-make24@iscas.ac.cn>
Date: Wed, 24 Jul 2024 13:03:22 +0300
Message-ID: <87ikwvf6ol.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 24 Jul 2024, Ma Ke <make24@iscas.ac.cn> wrote:
> In drm_client_modeset_probe(), the return value of drm_mode_duplicate() is
> assigned to modeset->mode, which will lead to a possible NULL pointer
> dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.
>
> Cc: stable@vger.kernel.org
> Fixes: cf13909aee05 ("drm/fb-helper: Move out modeset config code")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - modified patch as suggestions, returned error directly when failing to 
> get modeset->mode.

This is not what I suggested, and you can't just return here either.

BR,
Jani.


> Changes in v2:
> - added the recipient's email address, due to the prolonged absence of a 
> response from the recipients.
> - added Cc stable.
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index 31af5cf37a09..750b8dce0f90 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -880,6 +880,9 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
>  
>  			kfree(modeset->mode);
>  			modeset->mode = drm_mode_duplicate(dev, mode);
> +			if (!modeset->mode)
> +				return 0;
> +
>  			drm_connector_get(connector);
>  			modeset->connectors[modeset->num_connectors++] = connector;
>  			modeset->x = offset->x;

-- 
Jani Nikula, Intel

