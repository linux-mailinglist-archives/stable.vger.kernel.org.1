Return-Path: <stable+bounces-151321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785CACDB71
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 11:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B34165A87
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8AD28CF53;
	Wed,  4 Jun 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WK+T8KJp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B81283159
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030811; cv=none; b=dPlygKMh6n8a3upJZoum1VUkJGz5pudOPUQoCRtfPlwAhX83KWRElWp+PQ3AjBdEV/AlyiAgeCoUH2QbHDJy3hC+Gegr+3HzmApR4kxBatCUFZvdNsUBd/wc5HU3ol2al7/s/mXuT0U31krK3q8854qnd3fX6gQIpyYqSweIx9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030811; c=relaxed/simple;
	bh=KbRUAm4RyvmymdxAzoWXejNZHiSqmFjxI5CD3AiI5b4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=slUf9XsrXq2/2m7sP5sr4JRLcGC8cydKOsDLfFm9MGnL6LGByHiOzoUMdeuwc0KcZ33rWUdjdne1Mu1wJY+ZV9r0AiU69JTMEkzamrzZUkQ2crtjXieJUq41l3DNTz6+JjaK36YPuirJ32ZoLo1m/6jgac8rPgoTIn3K9W1Ekfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WK+T8KJp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749030809; x=1780566809;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=KbRUAm4RyvmymdxAzoWXejNZHiSqmFjxI5CD3AiI5b4=;
  b=WK+T8KJp0IDlRIu/kUF/ha4LmdpggKl9IfIkQUD3QRFYkOid8BXGhUKX
   h1lVB82pAQVoUTfMzX4nKq7OoOWAgxwoYpYpPOQTRH7BEWb1amb45iPHT
   prdt6cGjlazPyP/echjkG5HE1K5TusVUaWWg6757rhfBIlcOMvYzpTUiu
   JHYw88kgMO2QyPRmIPf/pxoPmXNcedCOh/v3TEJLh5pn3yEmxibahWwiE
   +OuECK3wp+SX6kEKlWV+z2QfpkJYkWzdpFfWMXb1ZfZ4SpxNxDU/gyMJN
   tHhSD1pCbDqwziO5eNqjktLBTF2Y8VGtT124CefHtrRSWmJLlbOLM63Rh
   w==;
X-CSE-ConnectionGUID: atcYyugFTYyDjLJoOjviPA==
X-CSE-MsgGUID: Yc6MXAy9TFes5vYABswdBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62492961"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="62492961"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 02:53:28 -0700
X-CSE-ConnectionGUID: vk172RNDQn+6wgHiZ0INXw==
X-CSE-MsgGUID: +wIxuW3sQ9CoKCQBdDM77g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="168312276"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.101])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 02:53:26 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 1/4] drm/dp: Change AUX DPCD probe address from DPCD_REV
 to LANE0_1_STATUS
In-Reply-To: <20250603121543.17842-2-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250603121543.17842-1-imre.deak@intel.com>
 <20250603121543.17842-2-imre.deak@intel.com>
Date: Wed, 04 Jun 2025 12:53:23 +0300
Message-ID: <892023ee348a6bcad3fd553cafe6ff650974fa3f@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 03 Jun 2025, Imre Deak <imre.deak@intel.com> wrote:
> Reading DPCD registers has side-effects in general. In particular
> accessing registers outside of the link training register range
> (0x102-0x106, 0x202-0x207, 0x200c-0x200f, 0x2216) is explicitly
> forbidden by the DP v2.1 Standard, see
>
> 3.6.5.1 DPTX AUX Transaction Handling Mandates
> 3.6.7.4 128b/132b DP Link Layer LTTPR Link Training Mandates
>
> Based on my tests, accessing the DPCD_REV register during the link
> training of an UHBR TBT DP tunnel sink leads to link training failures.
>
> Solve the above by using the DP_LANE0_1_STATUS (0x202) register for the
> DPCD register access quirk.
>
> Cc: <stable@vger.kernel.org>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Imre Deak <imre.deak@intel.com>

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index f2a6559a27100..dc622c78db9d4 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -725,7 +725,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsi=
gned int offset,
>  	 * monitor doesn't power down exactly after the throw away read.
>  	 */
>  	if (!aux->is_remote) {
> -		ret =3D drm_dp_dpcd_probe(aux, DP_DPCD_REV);
> +		ret =3D drm_dp_dpcd_probe(aux, DP_LANE0_1_STATUS);
>  		if (ret < 0)
>  			return ret;
>  	}

--=20
Jani Nikula, Intel

