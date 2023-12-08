Return-Path: <stable+bounces-5055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C34180AC04
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 19:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D601F2114A
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 18:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E89B1F17B;
	Fri,  8 Dec 2023 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWAGbetN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30FF90
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 10:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702059967; x=1733595967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jqFHB0k8ZhUAwFWbMY6IvDe2wVUzWSwqt2KAC2vmses=;
  b=XWAGbetNr8l+El91Yac+g3n0389kRaEGTyRadtbqPLsuJS3xFZjB9RJZ
   8M8hWvbAYGJKno3EuaeCpxJk9hwdcEems4TmPJGlQFLlaaF2/8FI6jxWn
   ZNYJYu3W6wOIifLyNyeIVugDrUeud3MXfhL+xjS51sJ8l9oC2XddKH2wp
   7Vt/sL6rd1agx1do0htdgoVBHam1ohDb7F0RrT6/QS0jJ9x08fIfC3Rm+
   ACwhO9eKf6uLz8HR7M9DkTg2U9GisK9bNr8Pga3xUVyAf8kX3m5d5gUkz
   DD5yoRmPWb44kbWFQuYH3OoDE8ZRtSRMd/v0SliED4NVyPkA+GBTcvHyh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="394186089"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="394186089"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 10:26:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="765564374"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="765564374"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 08 Dec 2023 10:26:04 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 08 Dec 2023 20:26:03 +0200
Date: Fri, 8 Dec 2023 20:26:03 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, bbaa <bbaa@bbaa.fun>,
	intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/edid: also call add modes in EDID
 connector update fallback
Message-ID: <ZXNfu6zcBy3JvbGd@intel.com>
References: <20231207093821.2654267-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207093821.2654267-1-jani.nikula@intel.com>
X-Patchwork-Hint: comment

On Thu, Dec 07, 2023 at 11:38:21AM +0200, Jani Nikula wrote:
> When the separate add modes call was added back in commit c533b5167c7e
> ("drm/edid: add separate drm_edid_connector_add_modes()"), it failed to
> address drm_edid_override_connector_update(). Also call add modes there.
> 
> Reported-by: bbaa <bbaa@bbaa.fun>
> Closes: https://lore.kernel.org/r/930E9B4C7D91FDFF+29b34d89-8658-4910-966a-c772f320ea03@bbaa.fun
> Fixes: c533b5167c7e ("drm/edid: add separate drm_edid_connector_add_modes()")
> Cc: <stable@vger.kernel.org> # v6.3+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/drm_edid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index cb4031d5dcbb..69c68804023f 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2311,7 +2311,8 @@ int drm_edid_override_connector_update(struct drm_connector *connector)
>  
>  	override = drm_edid_override_get(connector);
>  	if (override) {
> -		num_modes = drm_edid_connector_update(connector, override);
> +		if (drm_edid_connector_update(connector, override) == 0)
> +			num_modes = drm_edid_connector_add_modes(connector);
>  
>  		drm_edid_free(override);
>  
> -- 
> 2.39.2

-- 
Ville Syrjälä
Intel

