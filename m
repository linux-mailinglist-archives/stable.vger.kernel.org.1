Return-Path: <stable+bounces-139175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C576BAA4E07
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8BC1BC82A0
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CAB25C71C;
	Wed, 30 Apr 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9A3Plc+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A4227BA5;
	Wed, 30 Apr 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021797; cv=none; b=sddLLRaucW7tP6jg8OZJA0gF1G2s9Kzjx2P8PR6A35KZ/m52EEBpAHVIocD703x8psy/u7i5o9jiYRtZfWLCSQkrgSqUmhUk0/+R3DZjgofHmtiXRkSTRCqBQZLwHmFRqWJk1g5baTbCOL+yPLe0cdrUu+98Kzr/POyKy7p+fWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021797; c=relaxed/simple;
	bh=tFKRH3ssDxD0XU72FHVvaNJ5AvTLJMsVkPj5Pv6HziM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6tnhN6UBQBn/7co+8cfQrG5sTFJ/vQ8PTbHLOu5DyVAuB5AG0cnSIqiS5Ca8rqbfsEek+V9ssqlNJl7U1VprCvg0oWT6gGv/SNTzI/qDDSHFDlPG/3yJwF/iewyf21CU0zNiDNtwm/nVbhvp59dyEzmsN1T2LZBicchp/QJ70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9A3Plc+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746021796; x=1777557796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tFKRH3ssDxD0XU72FHVvaNJ5AvTLJMsVkPj5Pv6HziM=;
  b=e9A3Plc+w5/V5hC/mGtOp9/oeyqFWdf3AuEPjLaFg278U0o3m32tFNxl
   +vN1lmH4nwz255v1Lcf/1yXqqUXMeM3RxtEHm1Vnse1FLF6qbVSwZ7v5L
   ljDSJFbF4LnH4p4//Sym5ifMxs/6sV+usDP4TbVIc17yrpcLS/SF+Q0K3
   8wCjAEsBVCqD9CzbMryC7lbGAl3C7ZpAjmxebxth2YEI6HCCO85BTdXOz
   tu3zoCr9K0waHGgl4/VzcU9YBcmaRewM3mVCl3OqE6Cq630SIlCudqMJP
   6RIPq/dh6TxcwFY94WXiYx88FBHT37K9FhSRBLugqRU4zDTzGf+7IS6k5
   g==;
X-CSE-ConnectionGUID: QBQeshcgRWmuhKlSzvC7FA==
X-CSE-MsgGUID: ZHUjjH9uSJa/LOY03j/zlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47565352"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47565352"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 07:03:15 -0700
X-CSE-ConnectionGUID: pPn0XfRjQxKYs9msR76QPA==
X-CSE-MsgGUID: UhsEz+66R2+1velNb5Qo7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="165215624"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa001.fm.intel.com with SMTP; 30 Apr 2025 07:03:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 30 Apr 2025 17:03:11 +0300
Date: Wed, 30 Apr 2025 17:03:11 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: badhri@google.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: apply vbus before data bringup in
 tcpm_src_attach
Message-ID: <aBItn7_wakw5RqoH@kuha.fi.intel.com>
References: <20250429234743.3749129-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429234743.3749129-2-rdbabiera@google.com>

On Tue, Apr 29, 2025 at 11:47:42PM +0000, RD Babiera wrote:
> This patch fixes Type-C compliance test TD 4.7.6 - Try.SNK DRP Connect
> SNKAS.
> 
> tVbusON has a limit of 275ms when entering SRC_ATTACHED. Compliance
> testers can interpret the TryWait.Src to Attached.Src transition after
> Try.Snk as being in Attached.Src the entire time, so ~170ms is lost
> to the debounce timer.
> 
> Setting the data role can be a costly operation in host mode, and when
> completed after 100ms can cause Type-C compliance test check TD 4.7.5.V.4
> to fail.
> 
> Turn VBUS on before tcpm_set_roles to meet timing requirement.
> 
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 784fa23102f9..e099a3c4428d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4355,17 +4355,6 @@ static int tcpm_src_attach(struct tcpm_port *port)
>  
>  	tcpm_enable_auto_vbus_discharge(port, true);
>  
> -	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
> -			     TYPEC_SOURCE, tcpm_data_role_for_source(port));
> -	if (ret < 0)
> -		return ret;
> -
> -	if (port->pd_supported) {
> -		ret = port->tcpc->set_pd_rx(port->tcpc, true);
> -		if (ret < 0)
> -			goto out_disable_mux;
> -	}
> -
>  	/*
>  	 * USB Type-C specification, version 1.2,
>  	 * chapter 4.5.2.2.8.1 (Attached.SRC Requirements)
> @@ -4375,13 +4364,24 @@ static int tcpm_src_attach(struct tcpm_port *port)
>  	    (polarity == TYPEC_POLARITY_CC2 && port->cc1 == TYPEC_CC_RA)) {
>  		ret = tcpm_set_vconn(port, true);
>  		if (ret < 0)
> -			goto out_disable_pd;
> +			return ret;
>  	}
>  
>  	ret = tcpm_set_vbus(port, true);
>  	if (ret < 0)
>  		goto out_disable_vconn;
>  
> +	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB, TYPEC_SOURCE,
> +			     tcpm_data_role_for_source(port));
> +	if (ret < 0)
> +		goto out_disable_vbus;
> +
> +	if (port->pd_supported) {
> +		ret = port->tcpc->set_pd_rx(port->tcpc, true);
> +		if (ret < 0)
> +			goto out_disable_mux;
> +	}
> +
>  	port->pd_capable = false;
>  
>  	port->partner = NULL;
> @@ -4392,14 +4392,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
>  
>  	return 0;
>  
> -out_disable_vconn:
> -	tcpm_set_vconn(port, false);
> -out_disable_pd:
> -	if (port->pd_supported)
> -		port->tcpc->set_pd_rx(port->tcpc, false);
>  out_disable_mux:
>  	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
>  		     TYPEC_ORIENTATION_NONE);
> +out_disable_vbus:
> +	tcpm_set_vbus(port, false);
> +out_disable_vconn:
> +	tcpm_set_vconn(port, false);
> +
>  	return ret;
>  }
>  
> 
> base-commit: 615dca38c2eae55aff80050275931c87a812b48c
> -- 
> 2.49.0.967.g6a0df3ecc3-goog

-- 
heikki

