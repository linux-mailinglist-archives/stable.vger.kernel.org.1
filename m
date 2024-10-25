Return-Path: <stable+bounces-88140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22BD9B001F
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 12:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A90D1F22578
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD01E3790;
	Fri, 25 Oct 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Grt0itPe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744F18B498;
	Fri, 25 Oct 2024 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852167; cv=none; b=EqhtJRRk/dmIESbiZT9j/dLBCjE6S/858Hd2hfg2xnXXHS7BGGuQXSbMFXXha2aLdpCmsTdpAx/eBeEkKABOXz6OV3B87uooWXA52viC6+1RX35VO/5rQ/fVnJVJcTS10vIT5MxSxBj8mbdhRcLtgMdjjvdytGtie8yxPw0loP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852167; c=relaxed/simple;
	bh=XnbGMnJ2hhZlL+/8qSiEcUKrbEyhjTcE5YaDRj3m8MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEUvWcVBrNHnwBoNonFpxT9jPz/tWBm3qhvRKTdAMq9PHmNerCjboA69oIDYK2WTxPXpZWLI2qxMluo2KU5P2Y6ag+j3nNzSpC+52+cBxaUnJBQvr1chYTZ0tE7XidO/+ob8BlfVKvXSf1qxau93VGbYE9xIqSncbnzLJ7dCI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Grt0itPe; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729852165; x=1761388165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XnbGMnJ2hhZlL+/8qSiEcUKrbEyhjTcE5YaDRj3m8MA=;
  b=Grt0itPeAHE8bSdvoKDPqqRbt0BQquSBaKLGwMlVouRJzW415roK+pZv
   r+m9IjMuk6Q2sTwS+3n3tPKeSRk7S4pmj803e8J1rU14U1pb7Qyach0DN
   f/tgV1qY3LXtO3qsFn0B3ZOHg/cF+GQe3xzdDIz9PJ+NoVdULKbYTQyN9
   /NNIwDS6SKM3UmQmYbdaat8cLxGnc9tknpbGAF0+2DGB2jZzjmwRb468T
   OI+vCELcZy4t5qu9dh9TZq1HXF/Of+HCsUqFDM9iO2dhZ4RRGV0+ye1WE
   QYNebvas2X7o7YC5/evlH2INUqt5d48EdRHBHq1c3gR4oQyqh9UzJSfvy
   w==;
X-CSE-ConnectionGUID: jQcm4xY3RoS0ewiRscugIA==
X-CSE-MsgGUID: YDZKUMuGSI23fhSC188iGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29646075"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29646075"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 03:29:25 -0700
X-CSE-ConnectionGUID: oo7rV6mMRwmK7AU0UKO9Iw==
X-CSE-MsgGUID: 2aYS0asATkumQ0frxpKOZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80793797"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa010.jf.intel.com with SMTP; 25 Oct 2024 03:29:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 25 Oct 2024 13:29:20 +0300
Date: Fri, 25 Oct 2024 13:29:20 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: gregkh@linuxfoundation.org, rdbabiera@google.com, badhri@google.com,
	xu.yang_2@nxp.com, sebastian.reichel@collabora.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: restrict
 SNK_WAIT_CAPABILITIES_TIMEOUT transitions to non self-powered devices
Message-ID: <ZxtzAGLlQ2c1J0dQ@kuha.fi.intel.com>
References: <20241024022233.3276995-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024022233.3276995-1-amitsd@google.com>

On Wed, Oct 23, 2024 at 07:22:30PM -0700, Amit Sunil Dhamne wrote:
> PD3.1 spec ("8.3.3.3.3 PE_SNK_Wait_for_Capabilities State") mandates
> that the policy engine perform a hard reset when SinkWaitCapTimer
> expires. Instead the code explicitly does a GET_SOURCE_CAP when the
> timer expires as part of SNK_WAIT_CAPABILITIES_TIMEOUT. Due to this the
> following compliance test failures are reported by the compliance tester
> (added excerpts from the PD Test Spec):
> 
> * COMMON.PROC.PD.2#1:
>   The Tester receives a Get_Source_Cap Message from the UUT. This
>   message is valid except the following conditions: [COMMON.PROC.PD.2#1]
>     a. The check fails if the UUT sends this message before the Tester
>        has established an Explicit Contract
>     ...
> 
> * TEST.PD.PROT.SNK.4:
>   ...
>   4. The check fails if the UUT does not send a Hard Reset between
>     tTypeCSinkWaitCap min and max. [TEST.PD.PROT.SNK.4#1] The delay is
>     between the VBUS present vSafe5V min and the time of the first bit
>     of Preamble of the Hard Reset sent by the UUT.
> 
> For the purpose of interoperability, restrict the quirk introduced in
> https://lore.kernel.org/all/20240523171806.223727-1-sebastian.reichel@collabora.com/
> to only non self-powered devices as battery powered devices will not
> have the issue mentioned in that commit.
> 
> Cc: stable@vger.kernel.org
> Fixes: 122968f8dda8 ("usb: typec: tcpm: avoid resets for missing source capability messages")
> Reported-by: Badhri Jagan Sridharan <badhri@google.com>
> Closes: https://lore.kernel.org/all/CAPTae5LAwsVugb0dxuKLHFqncjeZeJ785nkY4Jfd+M-tCjHSnQ@mail.gmail.com/
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d6f2412381cf..c8f467d24fbb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4515,7 +4515,8 @@ static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
>  		return ERROR_RECOVERY;
>  	if (port->pwr_role == TYPEC_SOURCE)
>  		return SRC_UNATTACHED;
> -	if (port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
> +	if (port->state == SNK_WAIT_CAPABILITIES ||
> +	    port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
>  		return SNK_READY;
>  	return SNK_UNATTACHED;
>  }
> @@ -5043,8 +5044,11 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_state(port, SNK_SOFT_RESET,
>  				       PD_T_SINK_WAIT_CAP);
>  		} else {
> -			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
> -				       PD_T_SINK_WAIT_CAP);
> +			if (!port->self_powered)
> +				upcoming_state = SNK_WAIT_CAPABILITIES_TIMEOUT;
> +			else
> +				upcoming_state = hard_reset_state(port);
> +			tcpm_set_state(port, upcoming_state, PD_T_SINK_WAIT_CAP);
>  		}
>  		break;
>  	case SNK_WAIT_CAPABILITIES_TIMEOUT:
> 
> base-commit: c6d9e43954bfa7415a1e9efdb2806ec1d8a8afc8
> -- 
> 2.47.0.105.g07ac214952-goog
> 

-- 
heikki

