Return-Path: <stable+bounces-72667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510DF967F73
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 08:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC70282737
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D2154C0B;
	Mon,  2 Sep 2024 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFHG5q7l"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC882AE99;
	Mon,  2 Sep 2024 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258352; cv=none; b=o7gdTA4h8rXPBb4AkGcfBvG6KuhPgtfE8xm8ZTyN6ooZMjcvVKGE1jQVXq+a2hYDIjuwmuD83wlWym3WouEXrb8PWoDQ+4LD53m9VC8Tmi45EI/wzqjipQd4IEydY30sM2BuZQqBXBsQIPxnSNQpJCVr8nH5y9YyM+d3W4hM2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258352; c=relaxed/simple;
	bh=Qm60XZcXus5TzNfwuwzlg6erlxSQTD2UVGZkSm4cvNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWQTTZahcRezKgHY8lhRHEuPtyzxejUwQaNRlikIZ59OMwjMoJAtgoW/qwh02aWvzGiR7M8M3t0tztgJAgnZMRT6Cy56nxAGszuAisuTzW4ZUwFsHcx5jjuNO0wvYZWEMFRu9zDIZsgkXfk/dL+DXv+wjXDVHO/E/mI1JqTHZ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFHG5q7l; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725258351; x=1756794351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qm60XZcXus5TzNfwuwzlg6erlxSQTD2UVGZkSm4cvNE=;
  b=IFHG5q7lffQpOx4Rv8wtlTbYefu4aMqE1MUPC+acJCV5FRu1hcD+VJxX
   oaz0Mrw/BRjCm0PHFA8vUoCjySCcGAtgrfKOGnAJfDnhwT5vWgi47qRgX
   yAb5R07eL9tGaedD/KgA3c9m0E7m0F+Sfh3PI8FhAGszVOAtuHXQmSUs9
   H+ODImouBxzryPEnDsW3taLQ6tGhwimbr6vWS6H4eAuGrCVJzgGoGzbbo
   GhiiwElBF8LuMa2sdlRimk/92BDOlIBK1uGlsEGxjXg8ibU2vQGdQHbR9
   Kr83GtuSbipDGpWoqzUa/UY80HUX4zC8Wkh8VS/Qp9CdnYyXL+zlBvZXc
   w==;
X-CSE-ConnectionGUID: HD24oM1nSfGAy0nEsbAqng==
X-CSE-MsgGUID: VcQjD2fXT3CZKL8cg/tj+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="35190625"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="35190625"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 23:25:49 -0700
X-CSE-ConnectionGUID: 6T7HJvObR4qpPVEgoOJ4vg==
X-CSE-MsgGUID: ilOsKXwmQGKi8phbzHE/1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64519409"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa008.fm.intel.com with SMTP; 01 Sep 2024 23:25:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 02 Sep 2024 09:25:44 +0300
Date: Mon, 2 Sep 2024 09:25:44 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-usb@vger.kernel.org,
	Charles Yo <charlesyo@google.com>, Kyle Tso <kyletso@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>, Ondrej Jirman <megi@xff.cz>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 6.6] usb: typec: fix up incorrectly backported "usb:
 typec: tcpm: unregister existing source caps before re-registration"
Message-ID: <ZtVaaFD5wbmYlLCa@kuha.fi.intel.com>
References: <2024083008-granddad-unmoving-828c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024083008-granddad-unmoving-828c@gregkh>

On Fri, Aug 30, 2024 at 04:00:09PM +0200, Greg Kroah-Hartman wrote:
> In commit b16abab1fb64 ("usb: typec: tcpm: unregister existing source
> caps before re-registration"), quilt, and git, applied the diff to the
> incorrect function, which would cause bad problems if exercised in a
> device with these capabilities.
> 
> Fix this all up (including the follow-up fix in commit 04c05d50fa79
> ("usb: typec: tcpm: fix use-after-free case in
> tcpm_register_source_caps") to be in the correct function.
> 
> Fixes: 04c05d50fa79 ("usb: typec: tcpm: fix use-after-free case in tcpm_register_source_caps")
> Fixes: b16abab1fb64 ("usb: typec: tcpm: unregister existing source caps before re-registration")
> Reported-by: Charles Yo <charlesyo@google.com>
> Cc: Kyle Tso <kyletso@google.com>
> Cc: Amit Sunil Dhamne <amitsd@google.com>
> Cc: Ondrej Jirman <megi@xff.cz>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Note, this is also needed for 6.1, I'll fix up the git ids when
> committing it to the stable tree there as well.
> 
>  drivers/usb/typec/tcpm/tcpm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 7db9c382c354..e053b6e99b9e 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2403,7 +2403,7 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
>  {
>  	struct usb_power_delivery_desc desc = { port->negotiated_rev };
>  	struct usb_power_delivery_capabilities_desc caps = { };
> -	struct usb_power_delivery_capabilities *cap;
> +	struct usb_power_delivery_capabilities *cap = port->partner_source_caps;
>  
>  	if (!port->partner_pd)
>  		port->partner_pd = usb_power_delivery_register(NULL, &desc);
> @@ -2413,6 +2413,11 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
>  	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
>  	caps.role = TYPEC_SOURCE;
>  
> +	if (cap) {
> +		usb_power_delivery_unregister_capabilities(cap);
> +		port->partner_source_caps = NULL;
> +	}
> +
>  	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
>  	if (IS_ERR(cap))
>  		return PTR_ERR(cap);
> @@ -2426,7 +2431,7 @@ static int tcpm_register_sink_caps(struct tcpm_port *port)
>  {
>  	struct usb_power_delivery_desc desc = { port->negotiated_rev };
>  	struct usb_power_delivery_capabilities_desc caps = { };
> -	struct usb_power_delivery_capabilities *cap = port->partner_source_caps;
> +	struct usb_power_delivery_capabilities *cap;
>  
>  	if (!port->partner_pd)
>  		port->partner_pd = usb_power_delivery_register(NULL, &desc);
> @@ -2436,11 +2441,6 @@ static int tcpm_register_sink_caps(struct tcpm_port *port)
>  	memcpy(caps.pdo, port->sink_caps, sizeof(u32) * port->nr_sink_caps);
>  	caps.role = TYPEC_SINK;
>  
> -	if (cap) {
> -		usb_power_delivery_unregister_capabilities(cap);
> -		port->partner_source_caps = NULL;
> -	}
> -
>  	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
>  	if (IS_ERR(cap))
>  		return PTR_ERR(cap);
> -- 
> 2.46.0

-- 
heikki

