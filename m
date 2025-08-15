Return-Path: <stable+bounces-169703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60349B27876
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 07:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CBF5869E4
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 05:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D0D24886E;
	Fri, 15 Aug 2025 05:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xn/JxFyi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552F222562;
	Fri, 15 Aug 2025 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235880; cv=none; b=bKM7ndaTA00T9iNzUnSgQ3daA0kSqL7OVbSKaxwFVy+959ss+JOOtt9nGXS19Q4hHv9JvntiwV4BR1pKQ3cYCE0Npi5Vf5ZNmCmsjEoMhZK+PD/XpLDQ4zvRA+oRmX/gVpLisCuBSVFtjV3USCs0pM/tEK7+tXupEnAb7W0zXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235880; c=relaxed/simple;
	bh=n8lohO9Aan2c/4/4uAOOkLtbIarHe2IeP6N1mFvx7Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu98J6RyoPTyfDgYlnhiTAK4aHn8Ueo2rEpQjikK0+w27IKRohn5zzc66xhm14UrNHkscYTAQMLfkxeUWe1dh03JG2D+uIhG3Hsf8bkPgJNMQe/D7/xUTv9W5uuLT3iD0MkT/cEZACbSLYqlD+Gci525YBO73cFJGPkyKUAGOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xn/JxFyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF225C4CEEB;
	Fri, 15 Aug 2025 05:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755235880;
	bh=n8lohO9Aan2c/4/4uAOOkLtbIarHe2IeP6N1mFvx7Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xn/JxFyiZ4EAnQnz2lh38+e1Qo2YXv6e4cfRalHwERbbDlOst9n6JHX9Veh493GSG
	 s8OsVUb+GLnffQh1wZbh1MK90M7XO/APZhTq5OCon57Ymt+zDDqU9dkOlNrukwCZ6k
	 mTMNoRoB4KL/3ZVf4CjwOBFwglTSgytoxRqIlMVs=
Date: Fri, 15 Aug 2025 07:31:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: amitsd@google.com
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH 2/2] usb: typec: maxim_contaminant: re-enable cc toggle
 if cc is open and port is clean
Message-ID: <2025081508-pasted-small-645f@gregkh>
References: <20250814-fix-upstream-contaminant-v1-0-801ce8089031@google.com>
 <20250814-fix-upstream-contaminant-v1-2-801ce8089031@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-fix-upstream-contaminant-v1-2-801ce8089031@google.com>

On Thu, Aug 14, 2025 at 07:34:10PM -0700, Amit Sunil Dhamne via B4 Relay wrote:
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
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
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
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

