Return-Path: <stable+bounces-203287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34DCD8A17
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 10:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A7D301FF5B
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C52832A3C8;
	Tue, 23 Dec 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlElb27O"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC125332E;
	Tue, 23 Dec 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766483134; cv=none; b=QVugF1pEEGzz2vVs9XWkerMWSEgJ/CoFaAfgsG4YNtyKmqnTMTNEMdQxTKQIi9fMlygJLJ+b9SiE7z/wSjwUrmBRZ0D/9oDVjG4Kes+VE595Qbnr8V5D3qJDx/IunfhOLv1P/LSfWDCB0Ytf4JgLAdk1tIoVIhDz1BYgUb/qxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766483134; c=relaxed/simple;
	bh=JIT7s4mkrg0x9eNtxjcBtH6tMkdPbvKyVrZ1rEvshKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo7Q6BqMTFmltbrno1L9pdpCW86yVUA3hmAS1lp6YwYApn5rN/lXV8VWJQBAADUA4AdY6VKVDSK65+u0Q/xap+BWPBjZmhfsHEvFKzzO/kbKcv8Z5g5Rdt+rJHFMslNMokDbHqmQevlwwzRTkqzOtUGs7+LTFEDvEsxmFRp+1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlElb27O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766483133; x=1798019133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JIT7s4mkrg0x9eNtxjcBtH6tMkdPbvKyVrZ1rEvshKY=;
  b=YlElb27OBndEka/0A9Li/dyDc7zyF+ynEOAFKlSFGbivYRAulxc+y31t
   lVGRpK8tezbqE3FeQQqeJdLsyMVIxptizDVrVedHMbAZTy3bWkLvYypHJ
   jrhtzWC9HYpIRkKwUp31rRUhXl++nesmCNoRR+kzfMECzjDX/cC83Q3xu
   LtDUdKhrHyAwZjI7QQ4TFbmC0kxMeNLDmgZySsEl0JfG3ddPgLshe033N
   R4Dyu4Ox/mevkiqPrll6pg2w5jNBfGcDmw5MKZbM1Wqx/HXFjoUg+HI3I
   giF4X/WhT9aJSqGzPgUIWmpvRSb4vJ9m+blBxgwtAbA8jRtkhsLQz+Co1
   w==;
X-CSE-ConnectionGUID: xKPCXMZ8T0WtO7sLp2yybQ==
X-CSE-MsgGUID: OyYaCGGrTOW0W9sI0AgC/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68375830"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="68375830"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 01:45:32 -0800
X-CSE-ConnectionGUID: H2ituatHQ8qy7cslV74rGQ==
X-CSE-MsgGUID: bAbJkXZtS9mO2pkyKGfOJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="200248521"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO kuha) ([10.124.220.158])
  by fmviesa009.fm.intel.com with SMTP; 23 Dec 2025 01:45:26 -0800
Received: by kuha (sSMTP sendmail emulation); Tue, 23 Dec 2025 11:45:10 +0200
Date: Tue, 23 Dec 2025 11:45:10 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tcpm: allow looking for role_sw device in the main node
Message-ID: <aUpkppyoAnoSTV15@kuha>
References: <20251127-fix-ppp-power-v1-1-52cdd74c0ee6@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127-fix-ppp-power-v1-1-52cdd74c0ee6@collabora.com>

Thu, Nov 27, 2025 at 03:04:15PM +0100, Arnaud Ferraris kirjoitti:
> When ports are defined in the tcpc main node, fwnode_usb_role_switch_get
> returns an error, meaning usb_role_switch_get (which would succeed)
> never gets a chance to run as port->role_sw isn't NULL, causing a
> regression on devices where this is the case.
> 
> Fix this by turning the NULL check into IS_ERR_OR_NULL, so
> usb_role_switch_get can actually run and the device get properly probed.
> 
> Fixes: 2d8713f807a4 ("tcpm: switch check for role_sw device with fw_node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index cc78770509dbc..37698204d48d2 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7877,7 +7877,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	port->partner_desc.identity = &port->partner_ident;
>  
>  	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
> -	if (!port->role_sw)
> +	if (IS_ERR_OR_NULL(port->role_sw))
>  		port->role_sw = usb_role_switch_get(port->dev);
>  	if (IS_ERR(port->role_sw)) {
>  		err = PTR_ERR(port->role_sw);
> 
> ---
> base-commit: 765e56e41a5af2d456ddda6cbd617b9d3295ab4e
> change-id: 20251127-fix-ppp-power-6d47f3a746f8
> 
> Best regards,
> -- 
> Arnaud Ferraris <arnaud.ferraris@collabora.com>

-- 
heikki

