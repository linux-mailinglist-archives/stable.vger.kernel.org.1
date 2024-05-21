Return-Path: <stable+bounces-45516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5388CAFAF
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB21C222C5
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DD27711E;
	Tue, 21 May 2024 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpT0XP6i"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C455783;
	Tue, 21 May 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299613; cv=none; b=qfEsS1DH1szGVh96bIjfqROk0sjviGnVxH+4baLnTfb/SMby/XHBDXEC0FaZ/2JCCwJGO+XtKvo9N2Vodmm11ELMxkA+y/Lt4Js0BbpjgFcvzOnRqY47a56L6cKY5tWLoYEdcVdn6a44ihEYTTRJBG5t0WGT9dfQ/5fZeZTlf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299613; c=relaxed/simple;
	bh=oSPfbBS5fUMpH5podn+rXXCR+dtGnM4JAnkfz3GiD4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx9yvfakb+rSL0Xng7rrfAu+YlgOwPPP/2rZnyxTux73P2AXUIKrX09/3GFXzabJLPX7w20QK8j6wpUAFWXS0rW4ktoKbW22FimDMD/dza6UBk0jOTuruO2eJdlAOQrzY/KDtT8Q7GL/ZgrOmAaGP0L9ZHrbiSpe3x1wrLSmNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpT0XP6i; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716299612; x=1747835612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oSPfbBS5fUMpH5podn+rXXCR+dtGnM4JAnkfz3GiD4Q=;
  b=GpT0XP6inSN7RhdGu5W73jgeCjomltCqq5+2C4PDm6EyVHIC0TnOc+zU
   +nv+uvhp4XLgAH9Av9LBxgOu/j5nN/C5tPSw9SY/ef8OagJkxsdEgbKCY
   6XuJsizFWXAGS9/75ZzCuMaPLvJcBoRH2GeLl4+xCeLZaraXy5n6ubrxB
   uurUZ7TbMAvdS4L/PsHG4IpVuxSt+x79x287Uhqu1UEs1dQSfJBqgWeih
   ASgpeVnS4yninXmH4e21dItFdqavEer0RgNGde0ew1xK0izIV1darG2YN
   Wlikqb00+nnd7ebfsA/PH9yyljvo2McFPG/jh87BphIQAWHukqy7/2ZJn
   A==;
X-CSE-ConnectionGUID: qIOkbHtUTPKlOG3QLknsOg==
X-CSE-MsgGUID: fnpnCG7nSA+DCUH3ZJNYiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12284429"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="12284429"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 06:53:26 -0700
X-CSE-ConnectionGUID: O2Tne72EQj+xBI6uM0ueqQ==
X-CSE-MsgGUID: YH9JMsHxSgifuS1FwsUpmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="63761966"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa002.jf.intel.com with SMTP; 21 May 2024 06:53:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 May 2024 16:53:21 +0300
Date: Tue, 21 May 2024 16:53:21 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, megi@xff.cz,
	badhri@google.com, rdbabiera@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: fix use-after-free case in
 tcpm_register_source_caps
Message-ID: <ZkynURTFeB3fu8V6@kuha.fi.intel.com>
References: <20240514220134.2143181-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514220134.2143181-1-amitsd@google.com>

On Tue, May 14, 2024 at 03:01:31PM -0700, Amit Sunil Dhamne wrote:
> There could be a potential use-after-free case in
> tcpm_register_source_caps(). This could happen when:
>  * new (say invalid) source caps are advertised
>  * the existing source caps are unregistered
>  * tcpm_register_source_caps() returns with an error as
>    usb_power_delivery_register_capabilities() fails
> 
> This causes port->partner_source_caps to hold on to the now freed source
> caps.
> 
> Reset port->partner_source_caps value to NULL after unregistering
> existing source caps.
> 
> Fixes: 230ecdf71a64 ("usb: typec: tcpm: unregister existing source caps before re-registration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 8a1af08f71b6..be4127ef84e9 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3014,8 +3014,10 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
>  	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
>  	caps.role = TYPEC_SOURCE;
>  
> -	if (cap)
> +	if (cap) {
>  		usb_power_delivery_unregister_capabilities(cap);
> +		port->partner_source_caps = NULL;
> +	}
>  
>  	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
>  	if (IS_ERR(cap))
> 
> base-commit: 51474ab44abf907023a8a875e799b07de461e466
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog

-- 
heikki

