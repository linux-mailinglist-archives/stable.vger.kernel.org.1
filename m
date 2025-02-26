Return-Path: <stable+bounces-119701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A284FA4656F
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671341891376
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46322227BA6;
	Wed, 26 Feb 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mY6lRRlO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814A14F102
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584466; cv=none; b=XwbmIfJiwCD8qey2fq4d7FP6ppKqJHZ7zaHM5RCy5+ooiLEtyIHOw+31/IYAMyd3QAjAI1Nq3Ge704y0kDKR/XgSMs01cYUK65DJtxX0KnOXPZDH7hDC/e7mpeoUe6x0pyBhEWmEmdxs+M8QTwbur8Lm7rG6J2tqD0BqE4uD5cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584466; c=relaxed/simple;
	bh=mAZj9xUptGoteuTSIbE1ycIDHvOGsQuTozeWdMNuhos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lol+u9bojdQMlGvgVlVEdQKTiQmd5edVNOmMwZ0cQWSvNpgMIucOlbRIdWAzDiMY9TkxeFnJwQ7vhBl86WsLD9m+1VZSSzepVsFVREkoX5jJePd92e5//G66pxdh318EjcPU9ho4nsYGgPrBLuD6p3S6m9C0/imP4hSFDxwMRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mY6lRRlO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740584464; x=1772120464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mAZj9xUptGoteuTSIbE1ycIDHvOGsQuTozeWdMNuhos=;
  b=mY6lRRlOZUjgBUyti5frIFr/x0UcqGNehyghuYy8DOG+MFgFv4U37fap
   oNXqrsHOjO55bVFXG/jutltSwzb9f7WML3eFEGXZWS1UCMswYYQNGDoB6
   rqavGv/vHavCfrXzObZmyR/A130AyP4WE8oxI1e2kNGhtMQLnCR0rFI0/
   BYqx+6wzNjc4QFo9YxwD8CP+pYAGPO23+X7VxqHdH2UyXaCB8aKG4X+ao
   avDWCrfo2PJDo6LumcpADxfaPXaxelafSZ0i4K/5y7zIHcVCrcbLziiqg
   6s/7NggNEMCYkoCUoOPxhFp3og/NmRDUszF5Z40LpCheAt/yXA45AQcVZ
   A==;
X-CSE-ConnectionGUID: 9lTdsyfWQ1qzvJ3Ym8MONQ==
X-CSE-MsgGUID: L8+DAUANSvWIVFX0uai2xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41690185"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="41690185"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:41:00 -0800
X-CSE-ConnectionGUID: 1BuFcQL0RFCl5bewuCxFrg==
X-CSE-MsgGUID: 5mBmrXXuSmCNm+M3sorDxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121988606"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 26 Feb 2025 07:40:57 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 26 Feb 2025 17:40:56 +0200
Date: Wed, 26 Feb 2025 17:40:56 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org, Imre Deak <imre.deak@intel.com>
Subject: Re: [PATCH] drm/i915/mst: update max stream count to match number of
 pipes
Message-ID: <Z782CKSDNBjlmjct@intel.com>
References: <20250226135626.1956012-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226135626.1956012-1-jani.nikula@intel.com>
X-Patchwork-Hint: comment

On Wed, Feb 26, 2025 at 03:56:26PM +0200, Jani Nikula wrote:
> We create the stream encoders and attach connectors for each pipe we
> have. As the number of pipes has increased, we've failed to update the
> topology manager maximum number of payloads to match that. Bump up the
> max stream count to match number of pipes, enabling the fourth stream on
> platforms that support four pipes.
> 
> Cc: stable@vger.kernel.org
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index 167e4a70ab12..822218d8cfd4 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -1896,7 +1896,8 @@ intel_dp_mst_encoder_init(struct intel_digital_port *dig_port, int conn_base_id)
>  	/* create encoders */
>  	mst_stream_encoders_create(dig_port);
>  	ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, display->drm,
> -					   &intel_dp->aux, 16, 3, conn_base_id);
> +					   &intel_dp->aux, 16,
> +					   INTEL_NUM_PIPES(display), conn_base_id);
>  	if (ret) {
>  		intel_dp->mst_mgr.cbs = NULL;
>  		return ret;
> -- 
> 2.39.5

-- 
Ville Syrjälä
Intel

