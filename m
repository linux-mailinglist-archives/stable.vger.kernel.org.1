Return-Path: <stable+bounces-166658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9134B1BCFA
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 01:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB6E17E492
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 23:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08492566F5;
	Tue,  5 Aug 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lr94qVKg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0561B960;
	Tue,  5 Aug 2025 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754435844; cv=none; b=j83QXXX+46e9hSaT1x1rpQtY1odifOrhDtqj2NhNzW1Opo20Kt6+YbgAsPY37SCCnlQ2iwtaY6PRouQ65hHkiWT4yVwqpaleQ9CEXhPBtmDdMwyMPrqpizbFSUKkT+nGvt16gfdblw9VtjmN83x8QhiVzd1/59ervhRsf6RjlSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754435844; c=relaxed/simple;
	bh=hFv0BFfQpD8fW/Ro7OufaFPfvSDTPCQd+a6r37erHiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4Qwfg5gSBCaBqgF640s3xoXzsIhCNGYYQ4MI8rxKQtBpkACJlmaD1ye6M3CXhPEfCQ3JY6CyKr729dHXNPDwD+kIDXfSzsk04wOT1+06i1/0Y3gQxPSBifLvaOTbeX5YQr/89q3BZBNArsA8tsbbxJPm4/RVR10jUlioPAvUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lr94qVKg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754435843; x=1785971843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hFv0BFfQpD8fW/Ro7OufaFPfvSDTPCQd+a6r37erHiw=;
  b=lr94qVKgu9nTYfZh8c7dWpNl2jYg6nokiaGguo1Ap2cnNCMfjzPMs8ew
   6UElJrW1deo4iQ4ur84u/MDU7YMLWvYykvSDakFWZyIm0KB20nlGyKEhs
   R9wcxf0j8KI1GaGJDpPD/zB2h7bxK2EwZHY9omEVKScb2SeGExOR/c5u5
   JfS0fvh+51DHvbYo29e1n4ur+LL8ycPQRLdNC/+hJ9+uoCRMb6zGtydEY
   Ypn+dyyOWOFkGgnB60Xt/betTXVm5AhPMNVn1s7LB6d6BzxLqSxJVIDup
   7lQKLGIO43+LI3LOMPQHzecySb1bvmlXm1E/NNuTIuN8FcyKDgPFVneRn
   w==;
X-CSE-ConnectionGUID: V4wQspNsRWGcwb2y1a0KpQ==
X-CSE-MsgGUID: P5fs8LhQTZKrcb+wsvVJvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56707329"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56707329"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 16:17:23 -0700
X-CSE-ConnectionGUID: RmKcMRfzQcC1IvGdBZ3U1w==
X-CSE-MsgGUID: 3S9X//btS6GG3Q9IqNsOZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="195584817"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.87])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 16:17:21 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7D6D711FC4D;
	Wed,  6 Aug 2025 02:17:17 +0300 (EEST)
Date: Tue, 5 Aug 2025 23:17:17 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>, Joe Perches <joe@perches.com>,
	stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: intel_hdmi: Fix off-by-one error in
 __hdmi_lpe_audio_probe()
Message-ID: <aJKQ_WhAfjKvfB6U@kekkonen.localdomain>
References: <20250805190809.31150-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805190809.31150-1-thorsten.blum@linux.dev>

Hi Thorsten,

Thanks for the patch. 

On Tue, Aug 05, 2025 at 09:08:06PM +0200, Thorsten Blum wrote:
> In __hdmi_lpe_audio_probe(), strscpy() is incorrectly called with the
> length of the source string (excluding the NUL terminator) rather than
> the size of the destination buffer. This results in one character less
> being copied from 'card->shortname' to 'pcm->name'.
> 
> Since 'pcm->name' is a fixed-size buffer, we can safely omit the size
> argument and let strscpy() infer it using sizeof(). This ensures the
> card name is copied correctly.
> 
> Cc: stable@vger.kernel.org
> Fixes: 75b1a8f9d62e ("ALSA: Convert strlcpy to strscpy when return value is unused")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  sound/x86/intel_hdmi_audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
> index cc54539c6030..fbef0cbe8f1a 100644
> --- a/sound/x86/intel_hdmi_audio.c
> +++ b/sound/x86/intel_hdmi_audio.c
> @@ -1765,7 +1765,7 @@ static int __hdmi_lpe_audio_probe(struct platform_device *pdev)
>  		/* setup private data which can be retrieved when required */
>  		pcm->private_data = ctx;
>  		pcm->info_flags = 0;
> -		strscpy(pcm->name, card->shortname, strlen(card->shortname));
> +		strscpy(pcm->name, card->shortname);

Could you use three arguments here for backporting -- the two-argument
variant is a rather new addition and looks like 75b1a8f9d62e precedes it.

>  		/* setup the ops for playback */
>  		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
>  

-- 
Regards,

Sakari Ailus

