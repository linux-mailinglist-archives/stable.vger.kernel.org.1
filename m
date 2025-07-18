Return-Path: <stable+bounces-163378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F8CB0A677
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 16:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD7C580EA3
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E82DC35E;
	Fri, 18 Jul 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlyUV3CB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45602BD590;
	Fri, 18 Jul 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849568; cv=none; b=p2XwGdI7cmwRVdeafr16O+lGKXvhjBGvSNnsdO3vzO0FEDUfcass3mZODUldH4xlE4pA/jXAmdOEwzSbpT+A9ee2BSWJd06W7Pu5wCcqKwTFHhFCMwODSlffN+ouruXFGaEs2rzJ/u7XWgCZRTY/933et+Lu/9lGMhVo5xHGFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849568; c=relaxed/simple;
	bh=eSe3PaphIUbFUY2NxCmQgAMvVeWuC8wFj75ybbFp9e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OchWp75O16ie8NeOl4xmapPPzzPyFNSQoL0ZhKeVMrTGwl3rWvpSk0e2kyP3gLogvd7CLa+XmzmlVL3iGiUhpriJ230YJmQwXgEcoNTC01nlHUYebthVcuT/beVDzO6bhb7aBa8epojkxyWUFaDLu97bMa6s1TXRoiN6cWIu778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlyUV3CB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0593CC4CEEB;
	Fri, 18 Jul 2025 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752849568;
	bh=eSe3PaphIUbFUY2NxCmQgAMvVeWuC8wFj75ybbFp9e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlyUV3CBq0Hchso6K0ioH3KWGr8XLmM91ibw6mAxKgRJNwP+sKkTfFWkeVP6XRudq
	 qp5+KckZBfOin2SvKAI/Q2oOTRT0kqkrAH04Y3aTDwNfMzqi7kc/oGBMGSKtudWPYJ
	 z7E832cCR3shkTWk7Rz6uL+abokA3dC6E/J3Q3OFEdMaYGmhBgS0DXaQCCUtjW0zyx
	 fJbY+dmvqlExOvXWMIcoFkk1RPFdKn1umivUYqpXN/ASrjUnc6kAaAOvb4H+cMxssC
	 fte4Q2/2ebiibde8AYF72AF/iw+4WOMttr+tmGVail7ncX3+Hx6G+v5vizc6cmLT4f
	 qzYqeEPzXw31A==
Date: Fri, 18 Jul 2025 15:39:23 +0100
From: Simon Horman <horms@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: ioana.ciornei@nxp.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH net v2 1/3] bus: fsl-mc: Fix potential double device
 reference in fsl_mc_get_endpoint()
Message-ID: <20250718143923.GF2459@horms.kernel.org>
References: <20250717022309.3339976-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717022309.3339976-1-make24@iscas.ac.cn>

On Thu, Jul 17, 2025 at 10:23:07AM +0800, Ma Ke wrote:
> The fsl_mc_get_endpoint() function may call fsl_mc_device_lookup() 
> twice, which would increment the device's reference count twice if 
> both lookups find a device. This could lead to a reference count leak.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1ac210d128ef ("bus: fsl-mc: add the fsl_mc_get_endpoint function")

I think this should be:

Fixes: 8567494cebe5 ("bus: fsl-mc: rescan devices if endpoint not found")

I've CCed Laurentiu, the author of that commit.

> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 7671bd158545..c1c0a4759c7e 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -943,6 +943,7 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
>  	struct fsl_mc_obj_desc endpoint_desc = {{ 0 }};
>  	struct dprc_endpoint endpoint1 = {{ 0 }};
>  	struct dprc_endpoint endpoint2 = {{ 0 }};
> +	struct fsl_mc_bus *mc_bus;
>  	int state, err;
>  
>  	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
> @@ -966,6 +967,8 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
>  	strcpy(endpoint_desc.type, endpoint2.type);
>  	endpoint_desc.id = endpoint2.id;
>  	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
> +	if (endpoint)
> +		return endpoint;
>  
>  	/*
>  	 * We know that the device has an endpoint because we verified by
> @@ -973,17 +976,13 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
>  	 * yet discovered by the fsl-mc bus, thus the lookup returned NULL.
>  	 * Force a rescan of the devices in this container and retry the lookup.
>  	 */
> -	if (!endpoint) {
> -		struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
> -
> -		if (mutex_trylock(&mc_bus->scan_mutex)) {
> -			err = dprc_scan_objects(mc_bus_dev, true);
> -			mutex_unlock(&mc_bus->scan_mutex);
> -		}
> -
> -		if (err < 0)
> -			return ERR_PTR(err);
> +	mc_bus = to_fsl_mc_bus(mc_bus_dev);
> +	if (mutex_trylock(&mc_bus->scan_mutex)) {
> +		err = dprc_scan_objects(mc_bus_dev, true);
> +		mutex_unlock(&mc_bus->scan_mutex);
>  	}
> +	if (err < 0)
> +		return ERR_PTR(err);
>  
>  	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
>  	/*
> -- 
> 2.25.1
> 

