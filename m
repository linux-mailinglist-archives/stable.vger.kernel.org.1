Return-Path: <stable+bounces-120437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63682A50130
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB39188EA70
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8A24A058;
	Wed,  5 Mar 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjKuOcl+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FB230BC6;
	Wed,  5 Mar 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183168; cv=none; b=E0a3R/cpDloo0Sk+f6FPHfPO/hvNIOpu9venjale/vbm6DCaFfKcAMJFqcdfD5EwDIMQVGIlk+adVBYoxL/xKgoiJrlrnprDLy6tEgEvsTHSDzF1tWwKLNsrlFzPlrGlFe9MG2hh0dX2WXcVWDP/DkJih4d07fdb3VID16tNhkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183168; c=relaxed/simple;
	bh=5Bahw/UEbQRmZLJ4nhahFmsFs36Yex+SORkHSl0yfsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSLhLucrBfNyDd4xEwFcfl1Ugtys3GOaUeswf7AiM1p2GTIKvXMqmnwOhChfG9tjsgTkhijygh2lZfO/WOYvUIf0nh3pnW0ygSKx71P0VWoNv+5Xs9v9ahyy1rIoRhOYlJ3MJYYAqJeobUzcMWPhoaEOU5yjPPkDsjo4mLH9xGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjKuOcl+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741183167; x=1772719167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Bahw/UEbQRmZLJ4nhahFmsFs36Yex+SORkHSl0yfsw=;
  b=OjKuOcl+JHIhZ0Y36z/i2qEzOV2ruNrnYSCSry1/48qRiPZVNSfpIHWw
   KkZor4LYJgsQx59IowHpH1w6Oc8oliaemakV8ThC+CRVICuiOQ5n/hnXO
   xmXeMwnrotiI2oAzNpSgo7J2/522T6aqgOYPnvdxtnJ/jYyq4s50RTKVP
   4uphZB/o4hZ7dFkx7I2QnG/OIzeHy761J0T4Mcz+vcpWpgJyFZ1gb+U6F
   UI1F3IUYbzMaxuUzWG7eJExGejy2qZf1eJNwwvi/lBjLtPAXAwyxIU7Cx
   dzYfOxvgqhcgRAInxiu18NHdpaPuWy6H6xL6X3vFh3N3HyMEj4gi2ecIy
   Q==;
X-CSE-ConnectionGUID: peMnrPvRT7u7FxOY+RRCEw==
X-CSE-MsgGUID: saaTBf7yRgCYnCJY0A9qig==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42055561"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42055561"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:59:26 -0800
X-CSE-ConnectionGUID: B92M/0eFRUuxIvNT67XwrQ==
X-CSE-MsgGUID: xFPHFuS7TCOG/nnpmZz9PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="119197584"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa010.fm.intel.com with SMTP; 05 Mar 2025 05:59:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 05 Mar 2025 15:59:21 +0200
Date: Wed, 5 Mar 2025 15:59:21 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] usb: typec: ucsi: Fix NULL pointer access
Message-ID: <Z8hYuaesOQgmnfQ8@kuha.fi.intel.com>
References: <20250305111739.1489003-1-akuchynski@chromium.org>
 <20250305111739.1489003-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305111739.1489003-2-akuchynski@chromium.org>

On Wed, Mar 05, 2025 at 11:17:39AM +0000, Andrei Kuchynski wrote:
> Resources should be released only after all threads that utilize them
> have been destroyed.
> This commit ensures that resources are not released prematurely by waiting
> for the associated workqueue to complete before deallocating them.
> 
> Cc: stable@vger.kernel.org
> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index fcf499cc9458..43b4f8207bb3 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1825,11 +1825,11 @@ static int ucsi_init(struct ucsi *ucsi)
>  
>  err_unregister:
>  	for (con = connector; con->port; con++) {
> +		if (con->wq)
> +			destroy_workqueue(con->wq);
>  		ucsi_unregister_partner(con);
>  		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
>  		ucsi_unregister_port_psy(con);
> -		if (con->wq)
> -			destroy_workqueue(con->wq);
>  
>  		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
>  		con->port_sink_caps = NULL;
> @@ -2013,10 +2013,6 @@ void ucsi_unregister(struct ucsi *ucsi)
>  
>  	for (i = 0; i < ucsi->cap.num_connectors; i++) {
>  		cancel_work_sync(&ucsi->connector[i].work);
> -		ucsi_unregister_partner(&ucsi->connector[i]);
> -		ucsi_unregister_altmodes(&ucsi->connector[i],
> -					 UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(&ucsi->connector[i]);
>  
>  		if (ucsi->connector[i].wq) {
>  			struct ucsi_work *uwork;
> @@ -2032,6 +2028,11 @@ void ucsi_unregister(struct ucsi *ucsi)
>  			destroy_workqueue(ucsi->connector[i].wq);
>  		}
>  
> +		ucsi_unregister_partner(&ucsi->connector[i]);
> +		ucsi_unregister_altmodes(&ucsi->connector[i],
> +					 UCSI_RECIPIENT_CON);
> +		ucsi_unregister_port_psy(&ucsi->connector[i]);
> +
>  		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
>  		ucsi->connector[i].port_sink_caps = NULL;
>  		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog

-- 
heikki

