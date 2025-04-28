Return-Path: <stable+bounces-136891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179F4A9F218
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 15:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1C73AC00A
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11B265CA3;
	Mon, 28 Apr 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+VNtlt7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897B70810;
	Mon, 28 Apr 2025 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846614; cv=none; b=k+wYGHzrmb5QqpACKxtObagVFSJwusgOaTnQ5lf5AOKgV3NAXPa8ykMtGTcHpIH+6CKPXSADCKX++vZiYvtdxxRwRTxsh/lTkyafZlVBYymlUchKgf1xapNOunzScT9aqWXS3TqNDHjKzBnOEmUCDHO5EgpWhTGVajAbAPD9VFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846614; c=relaxed/simple;
	bh=335MrcHvnvENFyHo54UTERg/dHu7eoyK/wd1W1y27ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI6OfGZORkp4G7N1Jri9Irdb7y8quC5uPlNLDPJ4EudkuoN38RSZ/Zf72tsXyrdT7wwZx6jYm49qeAMZf4B8I8Kp0sxeVCTikzKcu/KufAJiMtIiGlGJ+ZBkkSd3Z08Isvr2+aMKS8cH69fkluRxmuGVY7zNiETjUs7YNuRb9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+VNtlt7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745846612; x=1777382612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=335MrcHvnvENFyHo54UTERg/dHu7eoyK/wd1W1y27ug=;
  b=n+VNtlt7ZACCOGriZCkXBVlMtobkdKKBJWDkonwcpymNhbLd1B/qX2Hv
   GJtc9wgnDO4e+m2mGNsb6wJLyEEiE4MFICeZrBvluIXZpeAHadEfLVu6Y
   icDV5XiTyL0UsmKD2avru8hNAyaAdhF/HkrV5dPhRQb8X/LyP6nQh4m0w
   Iws5rO2QfX/kNFufN0uj8qIHDj3QKlWFWGMk++qMQkVSx6qnIWKZMZcYt
   XKuy/C4IzbGc463q4l29m74OIEPQ35Km9MMicHxvOg0Ki+U8wmekFpDm+
   xjj+sbrNpWr8fSElLYgfzpVQdzLqXF8Jd1tAtv0ibKqJOtNQNphOUlKXT
   w==;
X-CSE-ConnectionGUID: DBAqw15jTKGSzPy1AGGHQA==
X-CSE-MsgGUID: ASY64+tcQSWG4NvVzZ5Z6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="58422018"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="58422018"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 06:23:31 -0700
X-CSE-ConnectionGUID: CcSuqomNR++Tkv1FqcBimw==
X-CSE-MsgGUID: qUzk6fo9TuKy8UWhQBuc7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="164483064"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa002.jf.intel.com with SMTP; 28 Apr 2025 06:23:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 28 Apr 2025 16:23:26 +0300
Date: Mon, 28 Apr 2025 16:23:26 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Madhu M <madhu.m@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: typec: ucsi: displayport: Fix deadlock
Message-ID: <aA-BTrunTaYxtrps@kuha.fi.intel.com>
References: <20250424084429.3220757-1-akuchynski@chromium.org>
 <20250424084429.3220757-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424084429.3220757-2-akuchynski@chromium.org>

On Thu, Apr 24, 2025 at 08:44:28AM +0000, Andrei Kuchynski wrote:
> This patch introduces the ucsi_con_mutex_lock / ucsi_con_mutex_unlock
> functions to the UCSI driver. ucsi_con_mutex_lock ensures the connector
> mutex is only locked if a connection is established and the partner pointer
> is valid. This resolves a deadlock scenario where
> ucsi_displayport_remove_partner holds con->mutex waiting for
> dp_altmode_work to complete while dp_altmode_work attempts to acquire it.
> 
> Cc: stable@vger.kernel.org
> Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/displayport.c | 19 +++++++++-------
>  drivers/usb/typec/ucsi/ucsi.c        | 34 ++++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h        |  2 ++
>  3 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> index 420af5139c70..acd053d4e38c 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -54,7 +54,8 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
>  	u8 cur = 0;
>  	int ret;
>  
> -	mutex_lock(&dp->con->lock);
> +	if (!ucsi_con_mutex_lock(dp->con))
> +		return -ENOTCONN;
>  
>  	if (!dp->override && dp->initialized) {
>  		const struct typec_altmode *p = typec_altmode_get_partner(alt);
> @@ -100,7 +101,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
>  	schedule_work(&dp->work);
>  	ret = 0;
>  err_unlock:
> -	mutex_unlock(&dp->con->lock);
> +	ucsi_con_mutex_unlock(dp->con);
>  
>  	return ret;
>  }
> @@ -112,7 +113,8 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
>  	u64 command;
>  	int ret = 0;
>  
> -	mutex_lock(&dp->con->lock);
> +	if (!ucsi_con_mutex_lock(dp->con))
> +		return -ENOTCONN;
>  
>  	if (!dp->override) {
>  		const struct typec_altmode *p = typec_altmode_get_partner(alt);
> @@ -144,7 +146,7 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
>  	schedule_work(&dp->work);
>  
>  out_unlock:
> -	mutex_unlock(&dp->con->lock);
> +	ucsi_con_mutex_unlock(dp->con);
>  
>  	return ret;
>  }
> @@ -202,20 +204,21 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
>  	int cmd = PD_VDO_CMD(header);
>  	int svdm_version;
>  
> -	mutex_lock(&dp->con->lock);
> +	if (!ucsi_con_mutex_lock(dp->con))
> +		return -ENOTCONN;
>  
>  	if (!dp->override && dp->initialized) {
>  		const struct typec_altmode *p = typec_altmode_get_partner(alt);
>  
>  		dev_warn(&p->dev,
>  			 "firmware doesn't support alternate mode overriding\n");
> -		mutex_unlock(&dp->con->lock);
> +		ucsi_con_mutex_unlock(dp->con);
>  		return -EOPNOTSUPP;
>  	}
>  
>  	svdm_version = typec_altmode_get_svdm_version(alt);
>  	if (svdm_version < 0) {
> -		mutex_unlock(&dp->con->lock);
> +		ucsi_con_mutex_unlock(dp->con);
>  		return svdm_version;
>  	}
>  
> @@ -259,7 +262,7 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
>  		break;
>  	}
>  
> -	mutex_unlock(&dp->con->lock);
> +	ucsi_con_mutex_unlock(dp->con);
>  
>  	return 0;
>  }
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index e8c7e9dc4930..01ce858a1a2b 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1922,6 +1922,40 @@ void ucsi_set_drvdata(struct ucsi *ucsi, void *data)
>  }
>  EXPORT_SYMBOL_GPL(ucsi_set_drvdata);
>  
> +/**
> + * ucsi_con_mutex_lock - Acquire the connector mutex
> + * @con: The connector interface to lock
> + *
> + * Returns true on success, false if the connector is disconnected
> + */
> +bool ucsi_con_mutex_lock(struct ucsi_connector *con)
> +{
> +	bool mutex_locked = false;
> +	bool connected = true;
> +
> +	while (connected && !mutex_locked) {
> +		mutex_locked = mutex_trylock(&con->lock) != 0;
> +		connected = UCSI_CONSTAT(con, CONNECTED);
> +		if (connected && !mutex_locked)
> +			msleep(20);
> +	}
> +
> +	connected = connected && con->partner;
> +	if (!connected && mutex_locked)
> +		mutex_unlock(&con->lock);
> +
> +	return connected;
> +}
> +
> +/**
> + * ucsi_con_mutex_unlock - Release the connector mutex
> + * @con: The connector interface to unlock
> + */
> +void ucsi_con_mutex_unlock(struct ucsi_connector *con)
> +{
> +	mutex_unlock(&con->lock);
> +}
> +
>  /**
>   * ucsi_create - Allocate UCSI instance
>   * @dev: Device interface to the PPM (Platform Policy Manager)
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 3a2c1762bec1..9c5278a0c5d4 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -94,6 +94,8 @@ int ucsi_register(struct ucsi *ucsi);
>  void ucsi_unregister(struct ucsi *ucsi);
>  void *ucsi_get_drvdata(struct ucsi *ucsi);
>  void ucsi_set_drvdata(struct ucsi *ucsi, void *data);
> +bool ucsi_con_mutex_lock(struct ucsi_connector *con);
> +void ucsi_con_mutex_unlock(struct ucsi_connector *con);
>  
>  void ucsi_connector_change(struct ucsi *ucsi, u8 num);
>  
> -- 
> 2.49.0.805.g082f7c87e0-goog

-- 
heikki

