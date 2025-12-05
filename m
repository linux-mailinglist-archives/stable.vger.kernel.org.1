Return-Path: <stable+bounces-200144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91323CA7ADF
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 14:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D4113357626
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD89329C50;
	Fri,  5 Dec 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nx1woE49"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070F42D9484;
	Fri,  5 Dec 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764931926; cv=none; b=unopWqgs7Hs7T0gwaMrywJiR8iGa3ln5d69Pf8PdnBMEaN4hgGAWRmkevSQHLaQLgNrOSbSgrxrxQ64rCinzWc3Jp84BPp0c4NcE2muClIwhYshPiJUMfpDMozRViyOBQLNfd9C0XoswAr8Tufr48qU4ZdNfNf8q7tcb6Nx3aBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764931926; c=relaxed/simple;
	bh=8TJKTSSYoJhb8JT9UfGgZT22EaGUumMWt7DTMCgSPTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXW0PuMcxOn5j7CHcs+CQAbYtdV88TYreGgWAuIjgY9Ps02wPbg1r6EkfxRccJpIgTUywKNny45qQwjqQLBnf9uGOhwDdmMbpGeKmucIKl8svJNohZOgrc7LgoL9C55Jbw7HLThWgs2qonbehSstkmNSNwGgkaE4EPHcwPJsByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nx1woE49; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764931920; x=1796467920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8TJKTSSYoJhb8JT9UfGgZT22EaGUumMWt7DTMCgSPTY=;
  b=Nx1woE49JXkmPBP3C91UxqyI2HRjfBdThNWdoKQVmgmDgB9QhGioK7Cs
   YyeorhJysqhN5BvZwZ5pAh7K+6mUTNjsYwzdjtxf4E3HE++MZfFgniGSo
   2qbSRw+O6JRSJEOBAuaAYpLRfOpaJDlcyKqk9kOtiZTACCCQMmSHKPR2i
   NnHg96V3XzOOkHxS0kAQrb2sMCBEM7iNd1TYXBA2F03tPL5j1KVHav4dC
   crl2PbywwswCiu7tzZyG7lHDQvj2TZx0TCGL7Pse5zCIBEV0KCA4f0bfu
   UlUNLfw/yycE/L3aJJCm/wlEyYrmyzQT8OhEAFXSL7n6eVlozffUYt/QN
   Q==;
X-CSE-ConnectionGUID: C0sqGj3XQmu1YmIgiIWktA==
X-CSE-MsgGUID: wxrkH8RASDCnHqXcERDe+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="65965842"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="65965842"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 02:51:52 -0800
X-CSE-ConnectionGUID: qRuMIfx/RwqMSDAIjqKUsA==
X-CSE-MsgGUID: Akyn1ozmTPmYNZJ5BQtY2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="195293727"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha) ([10.124.220.222])
  by orviesa007.jf.intel.com with SMTP; 05 Dec 2025 02:51:48 -0800
Received: by kuha (sSMTP sendmail emulation); Fri, 05 Dec 2025 12:51:39 +0200
Date: Fri, 5 Dec 2025 12:51:39 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] usb: typec: ucsi: Get connector status after enable
 notifications
Message-ID: <aTK5O0PhQ6AD5zrI@kuha>
References: <20251205-ucsi-v6-1-e2ad16550242@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-ucsi-v6-1-e2ad16550242@chromium.org>

Fri, Dec 05, 2025 at 03:07:46PM +0800, Hsin-Te Yuan kirjoitti:
> Originally, the notification for connector change will be enabled after
> the first read of the connector status. Therefore, if the event happens
> during this window, it will be missing and make the status unsynced.
> 
> Get the connector status only after enabling the notification for
> connector change to ensure the status is synced.
> 
> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> Cc: stable@vger.kernel.org # v4.13+
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v6:
> - Free the locks in error path.
> - Link to v5: https://lore.kernel.org/r/20251205-ucsi-v5-1-488eb89bc9b8@chromium.org
> 
> Changes in v5:
> - Hold the lock of each connector during the initialization to avoid
>   race condition between initialization and other event handler
> - Add Fixes tag
> - Link to v4: https://lore.kernel.org/r/20251125-ucsi-v4-1-8c94568ddaa5@chromium.org
> 
> Changes in v4:
> - Handle a single connector in ucsi_init_port() and call it in a loop
> - Link to v3: https://lore.kernel.org/r/20251121-ucsi-v3-1-b1047ca371b8@chromium.org
> 
> Changes in v3:
> - Seperate the status checking part into a new function called
>   ucsi_init_port() and call it after enabling the notifications
> - Link to v2: https://lore.kernel.org/r/20251118-ucsi-v2-1-d314d50333e2@chromium.org
> 
> Changes in v2:
> - Remove unnecessary braces.
> - Link to v1: https://lore.kernel.org/r/20251117-ucsi-v1-1-1dcbc5ea642b@chromium.org
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 131 +++++++++++++++++++++++-------------------
>  1 file changed, 73 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 3f568f790f39b0271667e80816270274b8dd3008..3a0471fa4cc980c0512bc71776e3984e6cd2cdb7 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1560,11 +1560,70 @@ static struct fwnode_handle *ucsi_find_fwnode(struct ucsi_connector *con)
>  	return NULL;
>  }
>  
> +static void ucsi_init_port(struct ucsi *ucsi, struct ucsi_connector *con)
> +{
> +	enum usb_role u_role = USB_ROLE_NONE;
> +	int ret;
> +
> +	/* Get the status */
> +	ret = ucsi_get_connector_status(con, false);
> +	if (ret) {
> +		dev_err(ucsi->dev, "con%d: failed to get status\n", con->num);
> +		return;
> +	}
> +
> +	if (ucsi->ops->connector_status)
> +		ucsi->ops->connector_status(con);
> +
> +	switch (UCSI_CONSTAT(con, PARTNER_TYPE)) {
> +	case UCSI_CONSTAT_PARTNER_TYPE_UFP:
> +	case UCSI_CONSTAT_PARTNER_TYPE_CABLE_AND_UFP:
> +		u_role = USB_ROLE_HOST;
> +		fallthrough;
> +	case UCSI_CONSTAT_PARTNER_TYPE_CABLE:
> +		typec_set_data_role(con->port, TYPEC_HOST);
> +		break;
> +	case UCSI_CONSTAT_PARTNER_TYPE_DFP:
> +		u_role = USB_ROLE_DEVICE;
> +		typec_set_data_role(con->port, TYPEC_DEVICE);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* Check if there is already something connected */
> +	if (UCSI_CONSTAT(con, CONNECTED)) {
> +		typec_set_pwr_role(con->port, UCSI_CONSTAT(con, PWR_DIR));
> +		ucsi_register_partner(con);
> +		ucsi_pwr_opmode_change(con);
> +		ucsi_port_psy_changed(con);
> +		if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
> +			ucsi_get_partner_identity(con);
> +		if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
> +			ucsi_check_cable(con);
> +	}
> +
> +	/* Only notify USB controller if partner supports USB data */
> +	if (!(UCSI_CONSTAT(con, PARTNER_FLAG_USB)))
> +		u_role = USB_ROLE_NONE;
> +
> +	ret = usb_role_switch_set_role(con->usb_role_sw, u_role);
> +	if (ret)
> +		dev_err(ucsi->dev, "con:%d: failed to set usb role:%d\n",
> +			con->num, u_role);
> +
> +	if (con->partner && UCSI_CONSTAT(con, PWR_OPMODE) == UCSI_CONSTAT_PWR_OPMODE_PD) {
> +		ucsi_register_device_pdos(con);
> +		ucsi_get_src_pdos(con);
> +		ucsi_check_altmodes(con);
> +		ucsi_check_connector_capability(con);
> +	}
> +}
> +
>  static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  {
>  	struct typec_capability *cap = &con->typec_cap;
>  	enum typec_accessory *accessory = cap->accessory;
> -	enum usb_role u_role = USB_ROLE_NONE;
>  	u64 command;
>  	char *name;
>  	int ret;
> @@ -1659,62 +1718,6 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  		goto out;
>  	}
>  
> -	/* Get the status */
> -	ret = ucsi_get_connector_status(con, false);
> -	if (ret) {
> -		dev_err(ucsi->dev, "con%d: failed to get status\n", con->num);
> -		goto out;
> -	}
> -
> -	if (ucsi->ops->connector_status)
> -		ucsi->ops->connector_status(con);
> -
> -	switch (UCSI_CONSTAT(con, PARTNER_TYPE)) {
> -	case UCSI_CONSTAT_PARTNER_TYPE_UFP:
> -	case UCSI_CONSTAT_PARTNER_TYPE_CABLE_AND_UFP:
> -		u_role = USB_ROLE_HOST;
> -		fallthrough;
> -	case UCSI_CONSTAT_PARTNER_TYPE_CABLE:
> -		typec_set_data_role(con->port, TYPEC_HOST);
> -		break;
> -	case UCSI_CONSTAT_PARTNER_TYPE_DFP:
> -		u_role = USB_ROLE_DEVICE;
> -		typec_set_data_role(con->port, TYPEC_DEVICE);
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	/* Check if there is already something connected */
> -	if (UCSI_CONSTAT(con, CONNECTED)) {
> -		typec_set_pwr_role(con->port, UCSI_CONSTAT(con, PWR_DIR));
> -		ucsi_register_partner(con);
> -		ucsi_pwr_opmode_change(con);
> -		ucsi_port_psy_changed(con);
> -		if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
> -			ucsi_get_partner_identity(con);
> -		if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
> -			ucsi_check_cable(con);
> -	}
> -
> -	/* Only notify USB controller if partner supports USB data */
> -	if (!(UCSI_CONSTAT(con, PARTNER_FLAG_USB)))
> -		u_role = USB_ROLE_NONE;
> -
> -	ret = usb_role_switch_set_role(con->usb_role_sw, u_role);
> -	if (ret) {
> -		dev_err(ucsi->dev, "con:%d: failed to set usb role:%d\n",
> -			con->num, u_role);
> -		ret = 0;
> -	}
> -
> -	if (con->partner && UCSI_CONSTAT(con, PWR_OPMODE) == UCSI_CONSTAT_PWR_OPMODE_PD) {
> -		ucsi_register_device_pdos(con);
> -		ucsi_get_src_pdos(con);
> -		ucsi_check_altmodes(con);
> -		ucsi_check_connector_capability(con);
> -	}
> -
>  	trace_ucsi_register_port(con->num, con);
>  
>  out:
> @@ -1823,16 +1826,28 @@ static int ucsi_init(struct ucsi *ucsi)
>  			goto err_unregister;
>  	}
>  
> +	/* Delay other interactions with each connector until ucsi_init_port is done */
> +	for (i = 0; i < ucsi->cap.num_connectors; i++)
> +		mutex_lock(&connector[i].lock);
> +
>  	/* Enable all supported notifications */
>  	ntfy = ucsi_get_supported_notifications(ucsi);
>  	command = UCSI_SET_NOTIFICATION_ENABLE | ntfy;
>  	ret = ucsi_send_command(ucsi, command, NULL, 0);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		for (i = 0; i < ucsi->cap.num_connectors; i++)
> +			mutex_unlock(&connector[i].lock);
>  		goto err_unregister;
> +	}
>  
>  	ucsi->connector = connector;
>  	ucsi->ntfy = ntfy;
>  
> +	for (i = 0; i < ucsi->cap.num_connectors; i++) {
> +		ucsi_init_port(ucsi, &connector[i]);
> +		mutex_unlock(&connector[i].lock);
> +	}
> +
>  	mutex_lock(&ucsi->ppm_lock);
>  	ret = ucsi->ops->read_cci(ucsi, &cci);
>  	mutex_unlock(&ucsi->ppm_lock);
> 
> ---
> base-commit: 2061f18ad76ecaddf8ed17df81b8611ea88dbddd
> change-id: 20251117-ucsi-c2dfe8c006d7
> 
> Best regards,
> -- 
> Hsin-Te Yuan <yuanhsinte@chromium.org>

-- 
heikki

