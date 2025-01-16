Return-Path: <stable+bounces-109249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B15FEA138E7
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84B4188435C
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE31DE3C0;
	Thu, 16 Jan 2025 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ci1Qpx7/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3424A7C2;
	Thu, 16 Jan 2025 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026735; cv=none; b=hrBZzJ7Rp2865j69ETCFWCJIdq9Ekz48ZyqeCuRwLxlVA/6WOi4X7x5j4kBZp2xPK8niSEuymHuUBP7TV8wORcYSHW8U0NquC1O8nbXZ0yBILjaL682zUMsoGmTGXGHUd9T1LZDX77L6KXylTnRpjzSmio5nDZP1mc89DFKuxcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026735; c=relaxed/simple;
	bh=HQn8hnOx0krH5GEg5JmI4lizNY21p9Dbh5oDRE/BXuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiLkpjZu4GYEf0qFP5a38hpL3GMgmGR4w2WR0riMjqce6GqNyyvOTpC22XgUACmoM6HLlAWMvfmtMQMXEJJrEwqCMDVbFaWfrZ+q53ftUEPSzJ+1EWdtRLeNnqgWFC0/9+XfeNTORU/4rrY9EMENOsNLLdsRMzG6OMEaDGYaRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ci1Qpx7/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737026733; x=1768562733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HQn8hnOx0krH5GEg5JmI4lizNY21p9Dbh5oDRE/BXuA=;
  b=ci1Qpx7/HyGXCWEBzEcp6bsU4o4G0io1zuikfNo5ftB0lY3AKHq4XFTv
   zwIwGwMTOBfA/hS+cmR+NvCbXj42TJEk8N4aYIMKdJTO3YqUc8DoKJHPA
   dfZmCox7irQht2dq+z9ycyyvuq2GnjvNfYmgREyvmZO7IJ6SE9MPWSoVl
   eyk1kxWhzZnXUZy+aWfKeNxrA8W1MNAGQIyMU+z6nRx3t2ribyzx/9T1Y
   jNiqsnRACI17X7gwVubTa/wVW5axIC50rbJe3Rq35aDOonA9cCHt1aEhA
   TcDPzWnZ53A2dYLkFUJQTu6qYRfr7fZxuXW9pGIaDPCV8VKColRPJWdol
   w==;
X-CSE-ConnectionGUID: K60WKY0eQli4ZZIrIEA3Gg==
X-CSE-MsgGUID: F7J9af10TGSRGuI2FBItWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="47996306"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="47996306"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 03:25:32 -0800
X-CSE-ConnectionGUID: E8S3DDXERcqehDA4vNllaw==
X-CSE-MsgGUID: k8V5PRfPRTOns957dhhvbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110440442"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 16 Jan 2025 03:25:28 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 16 Jan 2025 13:25:27 +0200
Date: Thu, 16 Jan 2025 13:25:27 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Kyle Tso <kyletso@google.com>
Cc: gregkh@linuxfoundation.org, andre.draszik@linaro.org,
	rdbabiera@google.com, m.felsch@pengutronix.de, xu.yang_2@nxp.com,
	u.kleine-koenig@baylibre.com, emanuele.ghidoli@toradex.com,
	badhri@google.com, amitsd@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpci: Prevent Sink disconnection before
 vPpsShutdown in SPR PPS
Message-ID: <Z4jsp4J6AX0X-uwX@kuha.fi.intel.com>
References: <20250114142435.2093857-1-kyletso@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114142435.2093857-1-kyletso@google.com>

On Tue, Jan 14, 2025 at 10:24:35PM +0800, Kyle Tso wrote:
> The Source can drop its output voltage to the minimum of the requested
> PPS APDO voltage range when it is in Current Limit Mode. If this voltage
> falls within the range of vPpsShutdown, the Source initiates a Hard
> Reset and discharges Vbus. However, currently the Sink may disconnect
> before the voltage reaches vPpsShutdown, leading to unexpected behavior.
> 
> Prevent premature disconnection by setting the Sink's disconnect
> threshold to the minimum vPpsShutdown value. Additionally, consider the
> voltage drop due to IR drop when calculating the appropriate threshold.
> This ensures a robust and reliable interaction between the Source and
> Sink during SPR PPS Current Limit Mode operation.
> 
> Fixes: 4288debeaa4e ("usb: typec: tcpci: Fix up sink disconnect thresholds for PD")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>

You've resend this, right? So is this v2 (or v1)?

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 13 +++++++++----
>  drivers/usb/typec/tcpm/tcpm.c  |  8 +++++---
>  include/linux/usb/tcpm.h       |  3 ++-
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 48762508cc86..19ab6647af70 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -27,6 +27,7 @@
>  #define	VPPS_NEW_MIN_PERCENT			95
>  #define	VPPS_VALID_MIN_MV			100
>  #define	VSINKDISCONNECT_PD_MIN_PERCENT		90
> +#define	VPPS_SHUTDOWN_MIN_PERCENT		85
>  
>  struct tcpci {
>  	struct device *dev;
> @@ -366,7 +367,8 @@ static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
>  }
>  
>  static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
> -						   bool pps_active, u32 requested_vbus_voltage_mv)
> +						   bool pps_active, u32 requested_vbus_voltage_mv,
> +						   u32 apdo_min_voltage_mv)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(dev);
>  	unsigned int pwr_ctrl, threshold = 0;
> @@ -388,9 +390,12 @@ static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum ty
>  		threshold = AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV;
>  	} else if (mode == TYPEC_PWR_MODE_PD) {
>  		if (pps_active)
> -			threshold = ((VPPS_NEW_MIN_PERCENT * requested_vbus_voltage_mv / 100) -
> -				     VSINKPD_MIN_IR_DROP_MV - VPPS_VALID_MIN_MV) *
> -				     VSINKDISCONNECT_PD_MIN_PERCENT / 100;
> +			/*
> +			 * To prevent disconnect when the source is in Current Limit Mode.
> +			 * Set the threshold to the lowest possible voltage vPpsShutdown (min)
> +			 */
> +			threshold = VPPS_SHUTDOWN_MIN_PERCENT * apdo_min_voltage_mv / 100 -
> +				    VSINKPD_MIN_IR_DROP_MV;
>  		else
>  			threshold = ((VSRC_NEW_MIN_PERCENT * requested_vbus_voltage_mv / 100) -
>  				     VSINKPD_MIN_IR_DROP_MV - VSRC_VALID_MIN_MV) *
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 460dbde9fe22..e4b85a09c3ae 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2973,10 +2973,12 @@ static int tcpm_set_auto_vbus_discharge_threshold(struct tcpm_port *port,
>  		return 0;
>  
>  	ret = port->tcpc->set_auto_vbus_discharge_threshold(port->tcpc, mode, pps_active,
> -							    requested_vbus_voltage);
> +							    requested_vbus_voltage,
> +							    port->pps_data.min_volt);
>  	tcpm_log_force(port,
> -		       "set_auto_vbus_discharge_threshold mode:%d pps_active:%c vbus:%u ret:%d",
> -		       mode, pps_active ? 'y' : 'n', requested_vbus_voltage, ret);
> +		       "set_auto_vbus_discharge_threshold mode:%d pps_active:%c vbus:%u pps_apdo_min_volt:%u ret:%d",
> +		       mode, pps_active ? 'y' : 'n', requested_vbus_voltage,
> +		       port->pps_data.min_volt, ret);
>  
>  	return ret;
>  }
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 061da9546a81..b22e659f81ba 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -163,7 +163,8 @@ struct tcpc_dev {
>  	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
>  	int (*enable_auto_vbus_discharge)(struct tcpc_dev *dev, bool enable);
>  	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
> -						 bool pps_active, u32 requested_vbus_voltage);
> +						 bool pps_active, u32 requested_vbus_voltage,
> +						 u32 pps_apdo_min_voltage);
>  	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
>  	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
>  	void (*check_contaminant)(struct tcpc_dev *dev);
> -- 
> 2.47.1.688.g23fc6f90ad-goog

-- 
heikki

