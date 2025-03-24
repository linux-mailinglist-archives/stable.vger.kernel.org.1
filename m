Return-Path: <stable+bounces-125875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C657A6D7D2
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16D13B323E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34325DAF7;
	Mon, 24 Mar 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2sJKe8t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6A25C6F5;
	Mon, 24 Mar 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809432; cv=none; b=Fe5wy5MQ+sgZn3ldpCLoMNOXgH5ABK7PF2vGzEs8i7Q8gapgnP5hIVjL5yY/2P5SPTIED5/zHZlif/QF7NGkCVjhMRSdBNeqFqLmPiCjmTI99zgrPadX70Xjy5JO2EO5Y0p86Twcl5rEjX78TXmDP5lZEhGV+ytj0Kdadib1Gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809432; c=relaxed/simple;
	bh=l0EsM4WPrsP2/dZGbpiEOfdu9H02HYDRq1VyCp+kVqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnwI+9vIp7KjGxTTJtDcU/exCHA4HiytlhG4MwXCEjB6sbeYlLpzPTLIiigyFWZqh8VNEWXXdyNbvKtFvqXu9HQ7nyXmXrNLjZhjkyBQY6DSTwQvOVaLHh1LD/iYQtHQ5rzM0xPGX44r/InNbFNef9i/s3fr2QWLgUJZQT+v/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2sJKe8t; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742809431; x=1774345431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l0EsM4WPrsP2/dZGbpiEOfdu9H02HYDRq1VyCp+kVqE=;
  b=T2sJKe8t+2Xth1CtHgvTt0oOv2oItSfgvMIpdcBEB0QE80vK2hxbmeTv
   hSEB9I1RJC46cD/WBVt98otxe6Q7OhwxlfHc/4TXi3UC6u6NUOYNB/fyq
   za+d2BdV75VkHHSYr3W19t4qzET1jFts63DAsFoPqZ2lnI8stlYNr0gZW
   KNLCKgmpg0OwOf7/VgAbnvGQGVCwDRHFDyiLK7hO8ZWBarasak1+aYLbz
   5mQtCHZ2omR4Zfv9guDFG0QEdoadqbBzB9HbKs9cu5shRMUrqfeXj0qvL
   5/L9Jl/V9Up6DXSeVeUKrq1veW7f50dfmrs8cktDzhBhaI6YJYaRRpP7A
   w==;
X-CSE-ConnectionGUID: CThS8P3qSV6Y1KgBp/FvLg==
X-CSE-MsgGUID: 0lUoxiwJSdiYM7DZ18Ww/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="69360685"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="69360685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 02:43:50 -0700
X-CSE-ConnectionGUID: Pvmb/+8MRqW99/1pzmVESQ==
X-CSE-MsgGUID: IFoLYrjuRQOhNS12ivjZTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="161232721"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa001.jf.intel.com with SMTP; 24 Mar 2025 02:43:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 Mar 2025 11:43:46 +0200
Date: Mon, 24 Mar 2025 11:43:46 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: class: Invalidate USB device pointers on
 partner unregistration
Message-ID: <Z-EpUlA9VOBO9yd4@kuha.fi.intel.com>
References: <20250321143728.4092417-1-akuchynski@chromium.org>
 <20250321143728.4092417-3-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321143728.4092417-3-akuchynski@chromium.org>

On Fri, Mar 21, 2025 at 02:37:27PM +0000, Andrei Kuchynski wrote:
> To avoid using invalid USB device pointers after a Type-C partner
> disconnects, this patch clears the pointers upon partner unregistration.
> This ensures a clean state for future connections.
> 
> Cc: stable@vger.kernel.org
> Fixes: 59de2a56d127 ("usb: typec: Link enumerated USB devices with Type-C partner")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index eadb150223f8..3df3e3736916 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1086,10 +1086,14 @@ void typec_unregister_partner(struct typec_partner *partner)
>  	port = to_typec_port(partner->dev.parent);
>  
>  	mutex_lock(&port->partner_link_lock);
> -	if (port->usb2_dev)
> +	if (port->usb2_dev) {
>  		typec_partner_unlink_device(partner, port->usb2_dev);
> -	if (port->usb3_dev)
> +		port->usb2_dev = NULL;
> +	}
> +	if (port->usb3_dev) {
>  		typec_partner_unlink_device(partner, port->usb3_dev);
> +		port->usb3_dev = NULL;
> +	}
>  
>  	device_unregister(&partner->dev);
>  	mutex_unlock(&port->partner_link_lock);
> -- 
> 2.49.0.395.g12beb8f557-goog

-- 
heikki

