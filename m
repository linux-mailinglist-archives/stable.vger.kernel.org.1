Return-Path: <stable+bounces-5009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1496580A227
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 12:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFA12818A2
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 11:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D851B26C;
	Fri,  8 Dec 2023 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVtBXG+c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8510D8
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 03:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702034909; x=1733570909;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=qggrYi1PwK2HVbyQ3mLwNOjXHc5hsPBg+52S+9IUREo=;
  b=nVtBXG+cX4DFaMMdFz2WjztC3+W+A80ZpThsx4I2UnBTi+YEaBATRYwJ
   xAeYrfnQ5J4wHr5dWDvmZAmDwE9/XRMWFu7EK6ZSmYe41gwO+C3LtfxGP
   aCm4n6hj+IVKxeudn8CPhUB+NmJIjpxCT4wW/Zzx4LrWYv+qKo7m16VNz
   ZCR+nArMIvG1Kk5jIScAgPFcsbrzSqOhM4n98ELkM8YYZN4tZLIXtJAOH
   y2NFKxi0mt2ZbxXWIZ09zobBZoOSp/3UHfGaqxbwNbv4WMFbFLba6QUj3
   yx1RFvPMRue1Ru2blk112A4aZoAJCJ7JuwIM4fXWH9i6XwC82rvImMAYG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="384797253"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="384797253"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895509798"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="895509798"
Received: from mvafin-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.63.236])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:28:27 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Matt
 Roper
 <matthew.d.roper@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: fix display ver 12-13 fault error handling
In-Reply-To: <20231208112008.2904497-1-jani.nikula@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231208112008.2904497-1-jani.nikula@intel.com>
Date: Fri, 08 Dec 2023 13:28:24 +0200
Message-ID: <87jzppyluv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 08 Dec 2023, Jani Nikula <jani.nikula@intel.com> wrote:
> Unless I'm completely misreading the bspec, there are no defined bits
> for plane gtt fault errors in DE PIPE IIR for a display versions
> 12-14. This would explain why DG2 in the linked bug is getting thousands
> of fault errors.
>
> Bspec: 50335
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9769

Okay, looking at the bug, this seems optimistic, but it might clear the
ratelimited fault errors.

> Fixes: 99e2d8bcb887 ("drm/i915/rkl: Limit number of universal planes to 5=
")
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v5.9+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display_irq.c | 4 +++-
>  drivers/gpu/drm/i915/i915_reg.h                  | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c b/drivers/g=
pu/drm/i915/display/intel_display_irq.c
> index f8ed53f30b2e..7bede5b56286 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_irq.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
> @@ -834,7 +834,9 @@ static u32 gen8_de_port_aux_mask(struct drm_i915_priv=
ate *dev_priv)
>=20=20
>  static u32 gen8_de_pipe_fault_mask(struct drm_i915_private *dev_priv)
>  {
> -	if (DISPLAY_VER(dev_priv) >=3D 13 || HAS_D12_PLANE_MINIMIZATION(dev_pri=
v))
> +	if (DISPLAY_VER(dev_priv) >=3D 14)
> +		return MTL_DE_PIPE_IRQ_FAULT_ERRORS;
> +	else if (DISPLAY_VER(dev_priv) >=3D 12)
>  		return RKL_DE_PIPE_IRQ_FAULT_ERRORS;
>  	else if (DISPLAY_VER(dev_priv) >=3D 11)
>  		return GEN11_DE_PIPE_IRQ_FAULT_ERRORS;
> diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_=
reg.h
> index 27dc903f0553..fcf980694cb4 100644
> --- a/drivers/gpu/drm/i915/i915_reg.h
> +++ b/drivers/gpu/drm/i915/i915_reg.h
> @@ -4354,7 +4354,8 @@
>  	 GEN11_PIPE_PLANE7_FAULT | \
>  	 GEN11_PIPE_PLANE6_FAULT | \
>  	 GEN11_PIPE_PLANE5_FAULT)
> -#define RKL_DE_PIPE_IRQ_FAULT_ERRORS \
> +#define RKL_DE_PIPE_IRQ_FAULT_ERRORS	0
> +#define MTL_DE_PIPE_IRQ_FAULT_ERRORS \
>  	(GEN9_DE_PIPE_IRQ_FAULT_ERRORS | \
>  	 GEN11_PIPE_PLANE5_FAULT)

--=20
Jani Nikula, Intel

