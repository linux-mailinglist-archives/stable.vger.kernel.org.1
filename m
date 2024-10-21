Return-Path: <stable+bounces-87552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBB59A6928
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248DB1C21614
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321831F4FCF;
	Mon, 21 Oct 2024 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBlnGlc+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D388A83A19;
	Mon, 21 Oct 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515346; cv=none; b=K7le15OXt1acsVtYKXamfNGFNkuEKvHcZl/ND1/OCBTHXLgnlmMzCLBHR6ORIbQmicjOJ6MJuynUCc9F5FWeyA8ax5mBhX/JUBxaO6WHe+q3Tu7JCGnpL7GgQqfSrxqFEKfcWM+5eS3VbgUyZRV8wn1lezobK0D50TSqyfo5i94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515346; c=relaxed/simple;
	bh=fEaE8f018pV07d6XEEeVpgv+m4EDKoKjC6oZtA9qIgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g07TbF9A19qRc0uuoJ3hVOOcPi0nGG3d5HA71u+1xz+YyAMMIvAfmuvOMMdiaYSbzxMc0ZetczZvD5YYiR1fsd39F0U3ipBpKU5cqbhdbxv2S6tkfN4p4oJlw12uiFjuHcmpDcNWjwKYIzSQC+ZsktV0ae+7C/cuBbkuLoiCzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBlnGlc+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729515344; x=1761051344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fEaE8f018pV07d6XEEeVpgv+m4EDKoKjC6oZtA9qIgI=;
  b=nBlnGlc+ubKESDuKVN0v1GlzfJ77VkOLE3pyueWu20sMgWs1J9NS9vuJ
   pBWgQfp2MIoIyUShkPMyM4KZoP7mDmIBEJwPOGdgxKWbmiUYDUq8zhOmL
   u+gpsx7s+WkrtrR3sA78azDf+UbumYn9gYXj3RTqbJOfPexX5xoqqZU68
   NcdVHvaIbowA/AKnUJ4aKi/ptZwhg1I7XsTqJLmU5TvtqpOHM4arE/gHl
   sHpt4cArS26T/GpCwVDWNwkZEgBvE90VC+BtLpEkVQkvG/a1TyM5REXYD
   YCkDP+isrXNFWz2Xd6gPS518oH/PcJxXhSCthwED65tMh79ioLvPW0kEe
   Q==;
X-CSE-ConnectionGUID: 269840pkTaC5TC2TEhanuQ==
X-CSE-MsgGUID: k2v8qNGHT0m/VpjcB3OK5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29092573"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="29092573"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 05:55:44 -0700
X-CSE-ConnectionGUID: rRMg32xfQZCwmFFa627Wmw==
X-CSE-MsgGUID: coehfDKnRweZleZGgFbgWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79463877"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa010.jf.intel.com with SMTP; 21 Oct 2024 05:55:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Oct 2024 15:55:39 +0300
Date: Mon, 21 Oct 2024 15:55:39 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fix unreleased fwnode_handle in
 typec_port_register_altmodes()
Message-ID: <ZxZPS7jt4mI1TUG-@kuha.fi.intel.com>
References: <20241019-typec-class-fwnode_handle_put-v1-1-a3b5a0a02795@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019-typec-class-fwnode_handle_put-v1-1-a3b5a0a02795@gmail.com>

On Sat, Oct 19, 2024 at 10:40:19PM +0200, Javier Carrasco wrote:
> The 'altmodes_node' fwnode_handle is never released after it is no
> longer required, which leaks the resource.
> 
> Add the required call to fwnode_handle_put() when 'altmodes_node' is no
> longer required.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b458a4c5d73 ("usb: typec: Add typec_port_register_altmodes()")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index d61b4c74648d..1eb240604cf6 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -2341,6 +2341,7 @@ void typec_port_register_altmodes(struct typec_port *port,
>  		altmodes[index] = alt;
>  		index++;
>  	}
> +	fwnode_handle_put(altmodes_node);
>  }
>  EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
>  
> 

-- 
heikki

