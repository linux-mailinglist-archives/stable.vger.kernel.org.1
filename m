Return-Path: <stable+bounces-125874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E85A6D7B9
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31A016D4C5
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F90625D8E1;
	Mon, 24 Mar 2025 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8XtmqNu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC1D1A0739;
	Mon, 24 Mar 2025 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809370; cv=none; b=NCPuD+oLS6gUH60N41/4R29BhNSve36H5hSLKODL5LKr4oqkGQ9BmrCSpb7wUHmBXuSnoIoKs09/mwbycEA8s1dOeb2fM2XQhQlyZmUoCpa+cdxL34xaGgLAwCZ5nCQvXeRJRpPpTRJ0pWTZH2wFc4UKo95y6x34kEewVcciqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809370; c=relaxed/simple;
	bh=RFzYTWQ4Y+y7xyQLjsfX2uiUzOqhWOXMh+X8f0EG3qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3zwSqJ/+uMcZTggVrIaeg9Z/Ka4KCPfODdOOcy8m0BNrRFZXXwrAuis73LSHnhhqJGiN8Fkg/GmJ+l9hw4RFtYlBK8JtRB4u6eTOVFgc7K3U6p+8NuwFKNYhkJYJINGkEnm+suHvIh7UWcota/sMK6EVMrfByR09ETcVdBeYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8XtmqNu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742809368; x=1774345368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RFzYTWQ4Y+y7xyQLjsfX2uiUzOqhWOXMh+X8f0EG3qU=;
  b=H8XtmqNuvgjMwN3phNhKX+uo61thrhq5a/DRZooiS80MpS1JCKSxtSCa
   O7j4IeEWpCyTpVqSF2cMASHqwvd1KBIM3rSISoNovwj/u44oSG0Gd8Y9C
   +va8b4Pnrhw5c/fSYOyCXm3s3eITejcordVQ10mdM5hU3Ch++FsgDTrbo
   rkBwaQ6W9voxH0iuwpKEMkojtWEkOEc41NqZyRZaQLH9Fy359/BXcyNqM
   Dkfj8Tcl+YDhM00bIkPWMBtrC0YRAyX2GCc5TcFM4KI4HobuqAfrYGxDG
   FLLUIK2F8MRjGFDrNorXwx+s3/ws5FyslZqcoqpMyGKGaMMtVD8ukXZkC
   w==;
X-CSE-ConnectionGUID: qe45EVqSQk205Vcdp4rD3A==
X-CSE-MsgGUID: B7Of/ZifRea6xzTlbd0rcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="55382463"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="55382463"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 02:42:47 -0700
X-CSE-ConnectionGUID: M0YvMUT/Qn+YFACk0zF6QA==
X-CSE-MsgGUID: NEojajlIR3Owy/e1Z2cKog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="123714017"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa009.jf.intel.com with SMTP; 24 Mar 2025 02:42:44 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 Mar 2025 11:42:43 +0200
Date: Mon, 24 Mar 2025 11:42:43 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: class: Fix NULL pointer access
Message-ID: <Z-EpEyEAQnmIzHoS@kuha.fi.intel.com>
References: <20250321143728.4092417-1-akuchynski@chromium.org>
 <20250321143728.4092417-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321143728.4092417-2-akuchynski@chromium.org>

On Fri, Mar 21, 2025 at 02:37:26PM +0000, Andrei Kuchynski wrote:
> Concurrent calls to typec_partner_unlink_device can lead to a NULL pointer
> dereference. This patch adds a mutex to protect USB device pointers and
> prevent this issue. The same mutex protects both the device pointers and
> the partner device registration.
> 
> Cc: stable@vger.kernel.org
> Fixes: 59de2a56d127 ("usb: typec: Link enumerated USB devices with Type-C partner")       
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 15 +++++++++++++--
>  drivers/usb/typec/class.h |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 9c76c3d0c6cf..eadb150223f8 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1052,6 +1052,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
>  		partner->usb_mode = USB_MODE_USB3;
>  	}
>  
> +	mutex_lock(&port->partner_link_lock);
>  	ret = device_register(&partner->dev);
>  	if (ret) {
>  		dev_err(&port->dev, "failed to register partner (%d)\n", ret);
> @@ -1063,6 +1064,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
>  		typec_partner_link_device(partner, port->usb2_dev);
>  	if (port->usb3_dev)
>  		typec_partner_link_device(partner, port->usb3_dev);
> +	mutex_unlock(&port->partner_link_lock);
>  
>  	return partner;
>  }
> @@ -1083,12 +1085,14 @@ void typec_unregister_partner(struct typec_partner *partner)
>  
>  	port = to_typec_port(partner->dev.parent);
>  
> +	mutex_lock(&port->partner_link_lock);
>  	if (port->usb2_dev)
>  		typec_partner_unlink_device(partner, port->usb2_dev);
>  	if (port->usb3_dev)
>  		typec_partner_unlink_device(partner, port->usb3_dev);
>  
>  	device_unregister(&partner->dev);
> +	mutex_unlock(&port->partner_link_lock);
>  }
>  EXPORT_SYMBOL_GPL(typec_unregister_partner);
>  
> @@ -2041,10 +2045,11 @@ static struct typec_partner *typec_get_partner(struct typec_port *port)
>  static void typec_partner_attach(struct typec_connector *con, struct device *dev)
>  {
>  	struct typec_port *port = container_of(con, struct typec_port, con);
> -	struct typec_partner *partner = typec_get_partner(port);
> +	struct typec_partner *partner;
>  	struct usb_device *udev = to_usb_device(dev);
>  	enum usb_mode usb_mode;
>  
> +	mutex_lock(&port->partner_link_lock);
>  	if (udev->speed < USB_SPEED_SUPER) {
>  		usb_mode = USB_MODE_USB2;
>  		port->usb2_dev = dev;
> @@ -2053,18 +2058,22 @@ static void typec_partner_attach(struct typec_connector *con, struct device *dev
>  		port->usb3_dev = dev;
>  	}
>  
> +	partner = typec_get_partner(port);
>  	if (partner) {
>  		typec_partner_set_usb_mode(partner, usb_mode);
>  		typec_partner_link_device(partner, dev);
>  		put_device(&partner->dev);
>  	}
> +	mutex_unlock(&port->partner_link_lock);
>  }
>  
>  static void typec_partner_deattach(struct typec_connector *con, struct device *dev)
>  {
>  	struct typec_port *port = container_of(con, struct typec_port, con);
> -	struct typec_partner *partner = typec_get_partner(port);
> +	struct typec_partner *partner;
>  
> +	mutex_lock(&port->partner_link_lock);
> +	partner = typec_get_partner(port);
>  	if (partner) {
>  		typec_partner_unlink_device(partner, dev);
>  		put_device(&partner->dev);
> @@ -2074,6 +2083,7 @@ static void typec_partner_deattach(struct typec_connector *con, struct device *d
>  		port->usb2_dev = NULL;
>  	else if (port->usb3_dev == dev)
>  		port->usb3_dev = NULL;
> +	mutex_unlock(&port->partner_link_lock);
>  }
>  
>  /**
> @@ -2614,6 +2624,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  
>  	ida_init(&port->mode_ids);
>  	mutex_init(&port->port_type_lock);
> +	mutex_init(&port->partner_link_lock);
>  
>  	port->id = id;
>  	port->ops = cap->ops;
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index b3076a24ad2e..db2fe96c48ff 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -59,6 +59,7 @@ struct typec_port {
>  	enum typec_port_type		port_type;
>  	enum usb_mode			usb_mode;
>  	struct mutex			port_type_lock;
> +	struct mutex			partner_link_lock;
>  
>  	enum typec_orientation		orientation;
>  	struct typec_switch		*sw;
> -- 
> 2.49.0.395.g12beb8f557-goog

-- 
heikki

