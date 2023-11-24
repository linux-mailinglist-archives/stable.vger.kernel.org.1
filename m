Return-Path: <stable+bounces-320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3257F799E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA28B20E4F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D5B33CD9;
	Fri, 24 Nov 2023 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AIQz2QC5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34D364B6
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F287C433C7;
	Fri, 24 Nov 2023 16:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700844250;
	bh=4YVMVmjPrTW2TIFuAJnBY/7AgogWLRpIcz8Y90vhuDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIQz2QC5rAw+TOPeb3uzcKGXESonDd3tJyZCqRLeVTPnHqy7VqkIkG9nJRkGLG3z7
	 JgqY0Fe/DcPK2x96tI4+Ua9bky9XwomWBkXGG6sanLvWj0TEm79QxnkakXdWX/D8dS
	 iJohmkpatTfELRzvoOW3SbNjFtD/7T1Px0TqpKsM=
Date: Fri, 24 Nov 2023 16:44:08 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	stable <stable@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	James Clark <james.clark@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5.15.y] driver core: Release all resources during unbind
 before updating device links
Message-ID: <2023112401-willing-drove-581c@gregkh>
References: <2023112330-squealer-strife-0ecc@gregkh>
 <20231123132835.486026-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123132835.486026-1-u.kleine-koenig@pengutronix.de>

On Thu, Nov 23, 2023 at 02:28:36PM +0100, Uwe Kleine-König wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> [ Upstream commit 2e84dc37920012b458e9458b19fc4ed33f81bc74 ]
> 
> This commit fixes a bug in commit 9ed9895370ae ("driver core: Functional
> dependencies tracking support") where the device link status was
> incorrectly updated in the driver unbind path before all the device's
> resources were released.
> 
> Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> Cc: stable <stable@kernel.org>
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Closes: https://lore.kernel.org/all/20231014161721.f4iqyroddkcyoefo@pengutronix.de/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: James Clark <james.clark@arm.com>
> Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Tested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Link: https://lore.kernel.org/r/20231018013851.3303928-1-saravanak@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this needed some conflict resolution around commit
> 9ad307213fa4 ("driver core: Refactor multiple copies of device
> cleanup").
> 
> Best regards
> Uwe
> 
>  drivers/base/dd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index ab0b2eb5fa07..0bd166ad6f13 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1228,8 +1228,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  		else if (drv->remove)
>  			drv->remove(dev);
>  
> -		device_links_driver_cleanup(dev);
> -
>  		devres_release_all(dev);
>  		arch_teardown_dma_ops(dev);
>  		kfree(dev->dma_range_map);
> @@ -1241,6 +1239,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  		pm_runtime_reinit(dev);
>  		dev_pm_set_driver_flags(dev, 0);
>  
> +		device_links_driver_cleanup(dev);
> +
>  		klist_remove(&dev->p->knode_driver);
>  		device_pm_check_callbacks(dev);
>  		if (dev->bus)
> 
> base-commit: 2a910f4af54d11deaefdc445f895724371645a97

Thanks, I've queued this up now.

greg k-h

