Return-Path: <stable+bounces-115124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E9FA33E08
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 12:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD3B3A7778
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F382227E91;
	Thu, 13 Feb 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rc5YUrNt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109A227E8B;
	Thu, 13 Feb 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445944; cv=none; b=HZnIhc1EZgKhSfkVRlT6dyEvEiug+oBPXJ628G/nEAEUcXWfDTPeiE+G6fPelzfcWf4aYcHsEZlyTpaV65FwX1m0rLnu7ZszChH5gb8nNNMvJDlPM+RDUxEiL5OPeqKYeASzoa2rV2D5CnkX0YnnahiD0I9hw9Sz3DciJZcmV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445944; c=relaxed/simple;
	bh=EVAUuBDBMmfoOHTQ3D16fxtASQyPWClWKsW6lBNhEzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/qCESuG1ZM8kQCVIgjesPwRNF20LWxao5ph4RSkmujTJG5mai0eHk1QsDTewmOopUVfeHnwirl0BzWx5CP7UkiO6mbTkmL/qg31YlC5OK5kNp63MEBRoK8oJA/RF3nF9Hms1+2/Pkv058p7J+SVrZuclHVj0JCoCCCjyF0EA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rc5YUrNt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739445943; x=1770981943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EVAUuBDBMmfoOHTQ3D16fxtASQyPWClWKsW6lBNhEzg=;
  b=Rc5YUrNtSUxrPBtbJB2wQdLrnQpyYWvzOqxx1I9Za4CZpiTKdfdLywTE
   OHU8pSGumQhBq3fERmj1NBBkb3QqBE3cmV8lUmu5tm85owNJ/Ip/r8+06
   4dd2q9ZazkHbRzj5Tpgog6Lj8h//DGxJB9Hq6ZQo7+x6ALn5gD7wZ4nig
   fu5bzlgUdgScH2L3Bw37uiEHPfR8xYPQNxR02RvU3ZCDqghWR3xQUN/FQ
   Q6AN/er2gJ7J3lZ7kTWT9KpBuuOUeEt6kzj4x5tRqR/BezMLFSLN9bGKd
   gew0A/KAZAVtVs36fs3s4hBMycfEVZ6WpXw3iwzCI4cZVv/KzE95soDcx
   A==;
X-CSE-ConnectionGUID: f7hjgxBeRjCiItQq7oYKqQ==
X-CSE-MsgGUID: zU49gNWfTeWfOB+tmEI/fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="43911389"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43911389"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 03:25:42 -0800
X-CSE-ConnectionGUID: eASTbBQoRtKW+uWVNLxbOA==
X-CSE-MsgGUID: e7u4gQZ2Rn6BPVjTgQ5C7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112951902"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa010.jf.intel.com with SMTP; 13 Feb 2025 03:25:39 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Feb 2025 13:25:38 +0200
Date: Thu, 13 Feb 2025 13:25:38 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc: gregkh@linuxfoundation.org, xu.yang_2@nxp.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: roles: set switch registered flag early on
Message-ID: <Z63Wsng27QfhyjLd@kuha.fi.intel.com>
References: <20250206193950.22421-1-quic_eserrao@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206193950.22421-1-quic_eserrao@quicinc.com>

On Thu, Feb 06, 2025 at 11:39:50AM -0800, Elson Roy Serrao wrote:
> The role switch registration and set_role() can happen in parallel as they
> are invoked independent of each other. There is a possibility that a driver
> might spend significant amount of time in usb_role_switch_register() API
> due to the presence of time intensive operations like component_add()
> which operate under common mutex. This leads to a time window after
> allocating the switch and before setting the registered flag where the set
> role notifications are dropped. Below timeline summarizes this behavior
> 
> Thread1				|	Thread2
> usb_role_switch_register()	|
> 	|			|
> 	---> allocate switch	|
> 	|			|
> 	---> component_add()	|	usb_role_switch_set_role()
> 	|			|	|
> 	|			|	--> Drop role notifications
> 	|			|	    since sw->registered
> 	|			|	    flag is not set.
> 	|			|
> 	--->Set registered flag.|
> 
> To avoid this, set the registered flag early on in the switch register
> API.
> 
> Fixes: b787a3e78175 ("usb: roles: don't get/set_role() when usb_role_switch is unregistered")
> cc: stable@vger.kernel.org
> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
>  - Set the switch registered flag from the get-go as suggested by
>    Heikki.
>  - Modified subject line and commit next as per the new logic.
>  - Link to v1: https://lore.kernel.org/all/20250127230715.6142-1-quic_eserrao@quicinc.com/
> 
>  drivers/usb/roles/class.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index c58a12c147f4..30482d4cf826 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -387,8 +387,11 @@ usb_role_switch_register(struct device *parent,
>  	dev_set_name(&sw->dev, "%s-role-switch",
>  		     desc->name ? desc->name : dev_name(parent));
>  
> +	sw->registered = true;
> +
>  	ret = device_register(&sw->dev);
>  	if (ret) {
> +		sw->registered = false;
>  		put_device(&sw->dev);
>  		return ERR_PTR(ret);
>  	}
> @@ -399,8 +402,6 @@ usb_role_switch_register(struct device *parent,
>  			dev_warn(&sw->dev, "failed to add component\n");
>  	}
>  
> -	sw->registered = true;
> -
>  	/* TODO: Symlinks for the host port and the device controller. */
>  
>  	return sw;
> -- 
> 2.17.1

-- 
heikki

