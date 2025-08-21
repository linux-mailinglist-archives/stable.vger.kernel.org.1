Return-Path: <stable+bounces-171951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B78B2EF1F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 09:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C8F1BC512D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 07:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B6227C162;
	Thu, 21 Aug 2025 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irO0xXAu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CFD279DC0;
	Thu, 21 Aug 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760338; cv=none; b=RclSg5+On8VDdD5CbB8nDEz3bYaBY3qtjrf2E6fO50Uag3SgIg+PmMWxPsEuQ0RGF/LpQPsXSEGjTNaS9PwOsctoxEg2Fz8owVAoI/f5TCjg0JG4GW3R1Kvj2nj4JSc1INSW4ieVGDL5oIuxJi+YwJGU1TntwIrSwzOqbNYUaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760338; c=relaxed/simple;
	bh=lr4D5fV6cnI7hsQ5qLXAT96WUbLBpR119AG6A5Mz2TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsRtLbFErHmHR4vCSdladg7DATWMSHs9ykiysbKq9LFhIJLXgWs/4F1xhJRls/ZekGU6tSKtCn5hk1mDlhMs0hq4qHeDk2szVDKCjPvqoKEwpUTzJTT4KeYwWzy3ifDtPZs4RyMIDlNwSFT0bdskI91b9DegGpK731kMRojzkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irO0xXAu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755760337; x=1787296337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lr4D5fV6cnI7hsQ5qLXAT96WUbLBpR119AG6A5Mz2TA=;
  b=irO0xXAuXRpd12RlegxghA5ho4d+heos006BtQ0ENvwQcGIqfxWTRH1x
   VgNvFdc9mKgjo4KzLKyAJfHpDHeH7dp9mHE9iS2wb+vRQhX+YEUHFbmsS
   fxmGZuwuUDUAAmXzMc/OW2mU/nyZqtEoFgbQLwOguXjshkaZVXAMjWOWt
   Z6+Mp7k2dhfeYMzIKj0yvUumDmvcSP938r+eBhaC6t/1rjJeUL3CRaSi4
   Fhex7g1aeVEzJYs/39F1QSZqbIUe79gQBmDD4BfOA69AbYtgjysGuNEFM
   J4x0kfk/qbWgkB0SbKWJBtn1rY1xqs34qmVYmnFHNEVLvUJsJt72SW6sP
   Q==;
X-CSE-ConnectionGUID: sB+3UW04TN65ppKihMz3Hg==
X-CSE-MsgGUID: /dL4vzMLRTucuddBoPoowQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57955715"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57955715"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 00:12:15 -0700
X-CSE-ConnectionGUID: o5XmDyGLSHq8vHC5nX00Fg==
X-CSE-MsgGUID: J3CLriOXT2WsFDZUwvOT7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167557895"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa010.jf.intel.com with SMTP; 21 Aug 2025 00:12:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Aug 2025 10:12:10 +0300
Date: Thu, 21 Aug 2025 10:12:10 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2 2/2] usb: typec: maxim_contaminant: re-enable cc
 toggle if cc is open and port is clean
Message-ID: <aKbGyj5eoP0xzUK4@kuha.fi.intel.com>
References: <20250815-fix-upstream-contaminant-v2-0-6c8d6c3adafb@google.com>
 <20250815-fix-upstream-contaminant-v2-2-6c8d6c3adafb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-fix-upstream-contaminant-v2-2-6c8d6c3adafb@google.com>

On Fri, Aug 15, 2025 at 11:31:52AM -0700, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Presently in `max_contaminant_is_contaminant()` if there's no
> contaminant detected previously, CC is open & stopped toggling and no
> contaminant is currently present, TCPC.RC would be programmed to do DRP
> toggling. However, it didn't actively look for a connection. This would
> lead to Type-C not detect *any* new connections. Hence, in the above
> situation, re-enable toggling & program TCPC to look for a new
> connection.
> 
> Also, return early if TCPC was looking for connection as this indicates
> TCPC has neither detected a potential connection nor a change in
> contaminant state.
> 
> In addition, once dry detection is complete (port is dry), restart
> toggling.
> 
> Fixes: 02b332a06397e ("usb: typec: maxim_contaminant: Implement check_contaminant callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/maxim_contaminant.c | 53 ++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
> index 818cfe226ac7716de2fcbce205c67ea16acba592..af8da6dc60ae0bc5900f6614514d51f41eded8ab 100644
> --- a/drivers/usb/typec/tcpm/maxim_contaminant.c
> +++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
> @@ -329,6 +329,39 @@ static int max_contaminant_enable_dry_detection(struct max_tcpci_chip *chip)
>  	return 0;
>  }
>  
> +static int max_contaminant_enable_toggling(struct max_tcpci_chip *chip)
> +{
> +	struct regmap *regmap = chip->data.regmap;
> +	int ret;
> +
> +	/* Disable dry detection if enabled. */
> +	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
> +				 FIELD_PREP(CCLPMODESEL,
> +					    LOW_POWER_MODE_DISABLE));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL1, CCCONNDRY, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = max_tcpci_write8(chip, TCPC_ROLE_CTRL, TCPC_ROLE_CTRL_DRP |
> +			       FIELD_PREP(TCPC_ROLE_CTRL_CC1,
> +					  TCPC_ROLE_CTRL_CC_RD) |
> +			       FIELD_PREP(TCPC_ROLE_CTRL_CC2,
> +					  TCPC_ROLE_CTRL_CC_RD));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL,
> +				 TCPC_TCPC_CTRL_EN_LK4CONN_ALRT,
> +				 TCPC_TCPC_CTRL_EN_LK4CONN_ALRT);
> +	if (ret)
> +		return ret;
> +
> +	return max_tcpci_write8(chip, TCPC_COMMAND, TCPC_CMD_LOOK4CONNECTION);
> +}
> +
>  bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce,
>  				    bool *cc_handled)
>  {
> @@ -345,6 +378,12 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
>  	if (ret < 0)
>  		return false;
>  
> +	if (cc_status & TCPC_CC_STATUS_TOGGLING) {
> +		if (chip->contaminant_state == DETECTED)
> +			return true;
> +		return false;
> +	}
> +
>  	if (chip->contaminant_state == NOT_DETECTED || chip->contaminant_state == SINK) {
>  		if (!disconnect_while_debounce)
>  			msleep(100);
> @@ -377,6 +416,12 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
>  				max_contaminant_enable_dry_detection(chip);
>  				return true;
>  			}
> +
> +			ret = max_contaminant_enable_toggling(chip);
> +			if (ret)
> +				dev_err(chip->dev,
> +					"Failed to enable toggling, ret=%d",
> +					ret);
>  		}
>  	} else if (chip->contaminant_state == DETECTED) {
>  		if (!(cc_status & TCPC_CC_STATUS_TOGGLING)) {
> @@ -384,6 +429,14 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
>  			if (chip->contaminant_state == DETECTED) {
>  				max_contaminant_enable_dry_detection(chip);
>  				return true;
> +			} else {
> +				ret = max_contaminant_enable_toggling(chip);
> +				if (ret) {
> +					dev_err(chip->dev,
> +						"Failed to enable toggling, ret=%d",
> +						ret);
> +					return true;
> +				}
>  			}
>  		}
>  	}
> 
> -- 
> 2.51.0.rc1.167.g924127e9c0-goog
> 

-- 
heikki

