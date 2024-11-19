Return-Path: <stable+bounces-94048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EEC9D2A71
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 17:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18822B30A8D
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDFA1D1E81;
	Tue, 19 Nov 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coRMDQG3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756231CC179;
	Tue, 19 Nov 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030812; cv=none; b=YmAQk2sOhGS9NHpRvkeS4yGjT4UA0ulUoZa+RDX9vAA8/ypByWLJxTu9AF2ev0O2u7iUPmeOFt+DwX7qjG5fwJV1zKOczfa8vFtQmc0ywZ2EZUYz/yxm1zKYLObQbdteSmdejEO/7U5fv8HF5uwgJ61+Abmm3hYGFZFUnOz3xAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030812; c=relaxed/simple;
	bh=wpO9kXG2AkJlN7uT0ycdfw1x+Hc2jk+LpAjzlT7Y6fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au/bkAsbrB4ifvyx/DYPEnWorNih7uwzxumhcmu8LLUIhD8MgaDq/hQ21N4tJpUbgTGcebXj/HP/bJmADh9N/7kAOZFqq/khm5xND6ZcSdPvMOJ3Qg4vPJkRuVHTIWiWzpEeZWZkB06IrR7lKSti6eGI2bdVekK4tBZtmLP+Eh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coRMDQG3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732030811; x=1763566811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wpO9kXG2AkJlN7uT0ycdfw1x+Hc2jk+LpAjzlT7Y6fI=;
  b=coRMDQG3erJLKp4KOqzd8Vzbx6vgpyxo5zOFYyLdsL8/cRklTOy5jL9h
   2+S+aeej7UvjMXPWYpO0ZV0pAZyJOs6Oqqp4zIatUmrWUzg7Oaw2VxNI2
   1q2rlZptjY/Il5VzTLueAoyTHiPUsV1Tn1ffVZ73Q2GFlx3G8/fL0ydwr
   rXsFPi4Q7MGCxJ7Jhof0v3d6is6A6mtXJ7hR/XbWDG5bufrs0f5bt0O8y
   dq+jFmQyr3UJNFuhFvc66M5BnWy9h3ZjtGAnzTe1tb3uZTB8CZhdC0geK
   bQ5QL2FW+v03pW71+pt5ylvhj1mrc1cwr3XllfugqHBW9hoMclJmDtAg9
   g==;
X-CSE-ConnectionGUID: HrLSNVOnRC23zrZXBBDqKQ==
X-CSE-MsgGUID: iVTNp1GDRMC2If2i7YeH8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="35710242"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="35710242"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:40:11 -0800
X-CSE-ConnectionGUID: drryZjE5RkK+uRjbIw7mKQ==
X-CSE-MsgGUID: v63POYoYQ5GN6K1F+TRazQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89600184"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa009.jf.intel.com with SMTP; 19 Nov 2024 07:40:09 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Nov 2024 17:40:07 +0200
Date: Tue, 19 Nov 2024 17:40:07 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: anx7411: fix OF node reference leaks in
 anx7411_typec_switch_probe()
Message-ID: <ZzyxV6xoMjgIEACe@kuha.fi.intel.com>
References: <20241116085503.3835860-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116085503.3835860-1-joe@pf.is.s.u-tokyo.ac.jp>

On Sat, Nov 16, 2024 at 05:55:03PM +0900, Joe Hattori wrote:
> The refcounts of the OF nodes obtained in by of_get_child_by_name()
> calls in anx7411_typec_switch_probe() are not decremented, so add
> fwnode_handle_put() calls to anx7411_unregister_switch() and
> anx7411_unregister_mux().
> 
> Fixes: e45d7337dc0e ("usb: typec: anx7411: Use of_get_child_by_name() instead of of_find_node_by_name()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> Changed in v2:
> - Add the Cc: stable@vger.kernel.org tag.
> ---
>  drivers/usb/typec/anx7411.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index cdb7e8273823..d3c5d8f410ca 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -29,6 +29,8 @@
>  #include <linux/workqueue.h>
>  #include <linux/power_supply.h>
>  
> +#include "mux.h"

This should not be necessary.

>  #define TCPC_ADDRESS1		0x58
>  #define TCPC_ADDRESS2		0x56
>  #define TCPC_ADDRESS3		0x54
> @@ -1094,6 +1096,7 @@ static void anx7411_unregister_mux(struct anx7411_data *ctx)
>  {
>  	if (ctx->typec.typec_mux) {
>  		typec_mux_unregister(ctx->typec.typec_mux);
> +		fwnode_handle_put(ctx->typec.typec_mux->dev.fwnode);
>  		ctx->typec.typec_mux = NULL;
>  	}
>  }
> @@ -1102,6 +1105,7 @@ static void anx7411_unregister_switch(struct anx7411_data *ctx)
>  {
>  	if (ctx->typec.typec_switch) {
>  		typec_switch_unregister(ctx->typec.typec_switch);
> +		fwnode_handle_put(ctx->typec.typec_switch->dev.fwnode);
>  		ctx->typec.typec_switch = NULL;
>  	}
>  }

Instead of accessing the fwnode like that, add members for them to
anx7411_data.

thanks,

-- 
heikki

