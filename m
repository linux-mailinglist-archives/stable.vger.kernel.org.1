Return-Path: <stable+bounces-148935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DC9ACAC7D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 12:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B2717E8E3
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2FD1F55F8;
	Mon,  2 Jun 2025 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIP4mXox"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D21B6D01;
	Mon,  2 Jun 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860317; cv=none; b=myV14vZi7pRR0BNat/mNf/roBiV+EsHekOVsybC/scgXc0G2VKVmgCkJBhjusWRM/541enHtcTQqjXxIN4VRyB1OAwkU2wTkzBXyoOPuYEaTxY+tHeMzw1c7xvf4iUyWGxsOaTRvQTdGzZ80eEZn7LEqItf70SJtjx2pNjKESj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860317; c=relaxed/simple;
	bh=oHOOJhTmnQGVZ5MYI/DR57V7yNtGs00I9F7S37IbaMw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k+l049Df2dkw6Yjzd+c6NyiEkCNOSRTUSuxu5QPofa9aD7Go93WcxUEOyWP9m8tJWXiGdR5DfFceCfxIboBd5Cy/XsWPe40AvqOSj+Ni2ssMy2x2b/zU0OR6RQ0TRzmveiQxS08OHlNiNRNeq47+E1/3O1t9AZ9lOi0kGuGe8IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIP4mXox; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748860315; x=1780396315;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oHOOJhTmnQGVZ5MYI/DR57V7yNtGs00I9F7S37IbaMw=;
  b=TIP4mXoxby54Vfs6IftXRZo+4Qnp/B03Th6EbI9dLQ8sKIH2gnZNnA2E
   9yJV9ip7e5w4zba7qJaXIRZyZT0W+4G1cUg4fgg3/876AwBArNDz7GaWA
   HA+fsZueCLIxkLDgD6dUBCfaEA9rcxPHDSSQYvP6P0y6OWFLjRws/7azf
   LYiYpcMnS7IbelwpIwsz2aBG7DP90eG40LErjuutAAx3Q6azcwjQHakUR
   tQOb0j4Tc9FWZRbhtNgnCsYDGzKUl+fM83zJvj85+0bT8XEXmZSjeK1rE
   Afv87kh5XMicSWYwQWux/NwGHcxUFtYoTk7vpcFN9wUjjTfG5hktkhwtr
   Q==;
X-CSE-ConnectionGUID: 3HqxtwvuQraKPcVgGOYwng==
X-CSE-MsgGUID: c9/dzUdDQW2yCNDTBCdt7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="54663190"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="54663190"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 03:31:54 -0700
X-CSE-ConnectionGUID: upffi4pmToyCms5RGbbhLg==
X-CSE-MsgGUID: 70AqVy+mQyaUZfPdmCMFEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="175482926"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.134])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 03:31:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Jun 2025 13:31:49 +0300 (EEST)
To: Max Staudt <max@enpas.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tty: Fix race against tty_open() in
 tty_register_device_attr()
In-Reply-To: <20250528132816.11433-2-max@enpas.org>
Message-ID: <6068387e-7064-0c2b-700a-3817bea1045b@linux.intel.com>
References: <20250528132816.11433-1-max@enpas.org> <20250528132816.11433-2-max@enpas.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 May 2025, Max Staudt wrote:

> Since the chardev is now created before the class device is registered,
> an attempt to tty_[k]open() the chardev between these two steps will
> lead to tty->dev being assigned NULL by alloc_tty_struct().
> 
> alloc_tty_struct() is called via tty_init_dev() when the tty is firstly
> opened, and is entered with tty_mutex held, so let's lock the critical
> section in tty_register_device_attr() with the same global mutex.
> This guarantees that tty->dev can be assigned a sane value.
> 
> Fixes: 6a7e6f78c235 ("tty: close race between device register and open")
> Signed-off-by: Max Staudt <max@enpas.org>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/tty/tty_io.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e922b84524d2..94768509e2d2 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3258,6 +3258,8 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
>  	else
>  		tty_line_name(driver, index, name);
>  
> +	mutex_lock(&tty_mutex);

Use guard() so you don't need to change the returns and rollback path.

> +
>  	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
>  		/*
>  		 * Free any saved termios data so that the termios state is
> @@ -3271,7 +3273,7 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
>  
>  		retval = tty_cdev_add(driver, devt, index, 1);
>  		if (retval)
> -			return ERR_PTR(retval);
> +			goto err_unlock;
>  
>  		cdev_added = true;
>  	}
> @@ -3294,6 +3296,8 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
>  	if (retval)
>  		goto err_put;
>  
> +	mutex_unlock(&tty_mutex);
> +
>  	return dev;
>  
>  err_put:
> @@ -3309,6 +3313,9 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
>  		driver->cdevs[index] = NULL;
>  	}
>  
> +err_unlock:
> +	mutex_unlock(&tty_mutex);
> +
>  	return ERR_PTR(retval);
>  }
>  EXPORT_SYMBOL_GPL(tty_register_device_attr);
> 

-- 
 i.


