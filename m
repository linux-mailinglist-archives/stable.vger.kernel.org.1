Return-Path: <stable+bounces-163010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A090EB0649F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 18:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8AB3A18D0
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49A026E6F1;
	Tue, 15 Jul 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPLcD8G7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC7186E2E;
	Tue, 15 Jul 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598287; cv=none; b=bwhDdSd3V8O6sUdTrzeGgHhKppqitMdKnZmrAlDUZNYM/thtWAOv0/Tz2u1Jtgd9zrpsUulhaSauiEXIh7gUS9xFurpN6txA3sDc+9se9Gd/J3MG01ucqXBtYvcPmt5bQD6v+RrW8tviCD/getYMvS4lHk5JRtGEk1xlovYYrkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598287; c=relaxed/simple;
	bh=QuDBPInlpwUSmQnRa356s40FHT7mdzjlze1wJQAFCMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxBJo8C0otgMXYqWfV8Ljk+rqKyNrZAcLgAJw6gPh0aPpSkq3eOLkFY5XdEj4C3IC87QjCr30dpjtDgugVGcgTunjeQrKk9A0Sp0Sf7zrKOwBuCAhbo/z/Uw+twYtBnWV0BO8EQvYKx0el7nsgUWMFZimStBmd23JKy35O4LHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPLcD8G7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1161C4CEE3;
	Tue, 15 Jul 2025 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752598287;
	bh=QuDBPInlpwUSmQnRa356s40FHT7mdzjlze1wJQAFCMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPLcD8G7MNGk/dz2KDumhfYrwMlPJUwqokkHYRL3S8oc44w7hTIVuHzfjy1acjRU4
	 E4FWoVB407lIX+rv+28pkXS1F26XdzUTSjhdfScexBuF8cJAlgTVXBkZDnT0Erbtd0
	 qfSWuUAz4EaELBi8vUO9Ghypn6a6AjiV+aux85SE6bkvyLkh+wUk0/BXtTIouksmCv
	 QGi9YEwTmCbcMY5Q4cXl79sdN0XgrJFboXCYQa8Le5AiRpEtHPrx7QL7tmUE5BZbcM
	 QwtQcvj2fgK6nArAFeiLo8EdfC1lPkJVLqfuGP7nFjgF8Gg5fG50/65Z5ZNyUv27QB
	 kKU6JepqO3cvw==
Date: Tue, 15 Jul 2025 17:51:22 +0100
From: Simon Horman <horms@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: dpaa2: Fix device reference count leak in MAC
 endpoint handling
Message-ID: <20250715165122.GF721198@horms.kernel.org>
References: <20250715120056.3274056-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715120056.3274056-1-make24@iscas.ac.cn>

On Tue, Jul 15, 2025 at 08:00:56PM +0800, Ma Ke wrote:
> The fsl_mc_get_endpoint() function uses device_find_child() for
> localization, which implicitly calls get_device() to increment the
> device's reference count before returning the pointer. However, the
> caller dpaa2_switch_port_connect_mac() and dpaa2_eth_connect_mac()
> fails to properly release this reference in multiple scenarios. We
> should call put_device() to decrement reference count properly.
> 
> As comment of device_find_child() says, 'NOTE: you will need to drop
> the reference with put_device() after use'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 719479230893 ("dpaa2-eth: add MAC/PHY support through phylink")
> Fixes: 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

As a fix for Networking code this should be targeted at the net tree.
That can be done like this:

Please also make sure that the patch compiles against the main branch
of the net tree. That doesn't appear to be the case with this patch.

> ---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 15 ++++++++++++---
>  .../net/ethernet/freescale/dpaa2/dpaa2-switch.c  | 15 ++++++++++++---

As this updates two drivers I have a week preference for two patches.
One with the prefix dpaa2-eth and the other with the prefix dpaa2-switch.

Subject: [PATCH net v2 1/2] dpaa2-eth: ...
Subject: [PATCH net v2 2/2] dpaa2-switch: ...

>  2 files changed, 25 insertions(+), 6 deletions(-)

I looked over fsl_mc_get_endpoint. I see that that it calls
device_find_child() indirectly via fsl_mc_device_lookup(). And I agree that
leaking references is a concern.

But if so, is it not also a concern that fsl_mc_get_endpoint()
can make two successful calls to to_fsl_mc_bus(). That is, the
reference count may be taken twice.

So I wonder if something like the following is appropriate.
(Compile tested only).

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 7671bd158545..c1c0a4759c7e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -943,6 +943,7 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 	struct fsl_mc_obj_desc endpoint_desc = {{ 0 }};
 	struct dprc_endpoint endpoint1 = {{ 0 }};
 	struct dprc_endpoint endpoint2 = {{ 0 }};
+	struct fsl_mc_bus *mc_bus;
 	int state, err;
 
 	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
@@ -966,6 +967,8 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 	strcpy(endpoint_desc.type, endpoint2.type);
 	endpoint_desc.id = endpoint2.id;
 	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
+	if (endpoint)
+		return endpoint;
 
 	/*
 	 * We know that the device has an endpoint because we verified by
@@ -973,17 +976,13 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 	 * yet discovered by the fsl-mc bus, thus the lookup returned NULL.
 	 * Force a rescan of the devices in this container and retry the lookup.
 	 */
-	if (!endpoint) {
-		struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
-
-		if (mutex_trylock(&mc_bus->scan_mutex)) {
-			err = dprc_scan_objects(mc_bus_dev, true);
-			mutex_unlock(&mc_bus->scan_mutex);
-		}
-
-		if (err < 0)
-			return ERR_PTR(err);
+	mc_bus = to_fsl_mc_bus(mc_bus_dev);
+	if (mutex_trylock(&mc_bus->scan_mutex)) {
+		err = dprc_scan_objects(mc_bus_dev, true);
+		mutex_unlock(&mc_bus->scan_mutex);
 	}
+	if (err < 0)
+		return ERR_PTR(err);
 
 	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
 	/*


> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> index b82f121cadad..f1543039a5b6 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> @@ -4666,12 +4666,19 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
>  		return PTR_ERR(dpmac_dev);
>  	}
>  
> -	if (IS_ERR(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
> +	if (IS_ERR(dpmac_dev))
>  		return 0;
>  
> +	if (dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type) {
> +		put_device(&dpmac_dev->dev);
> +		return 0;
> +	}
> +
>  	mac = kzalloc(sizeof(struct dpaa2_mac), GFP_KERNEL);
> -	if (!mac)
> +	if (!mac) {
> +		put_device(&dpmac_dev->dev);
>  		return -ENOMEM;
> +	}
>  
>  	mac->mc_dev = dpmac_dev;
>  	mac->mc_io = priv->mc_io;
> @@ -4679,7 +4686,7 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
>  
>  	err = dpaa2_mac_open(mac);
>  	if (err)
> -		goto err_free_mac;
> +		goto err_put_device;
>  
>  	if (dpaa2_mac_is_type_phy(mac)) {
>  		err = dpaa2_mac_connect(mac);
> @@ -4703,6 +4710,8 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
>  
>  err_close_mac:
>  	dpaa2_mac_close(mac);
> +err_put_device:
> +	put_device(&dpmac_dev->dev);
>  err_free_mac:
>  	kfree(mac);
>  	return err;

I think it would be best to construct the lader of unwind labels
such that they release resources in the reverse order to which
they were taken. This allows the ladder to be used consistently
to release the reources for all cases where that is needed.

E.g. (compile tested only!)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index b82f121cadad..2f553336b02f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4666,12 +4666,20 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 		return PTR_ERR(dpmac_dev);
 	}
 
-	if (IS_ERR(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
+
+	if (IS_ERR(dpmac_dev))
 		return 0;
 
+	if (dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type) {
+		err = 0;
+		goto out_put_device;
+	}
+
 	mac = kzalloc(sizeof(struct dpaa2_mac), GFP_KERNEL);
-	if (!mac)
-		return -ENOMEM;
+	if (!mac) {
+		err = -ENOMEM;
+		goto out_put_device;
+	}
 
 	mac->mc_dev = dpmac_dev;
 	mac->mc_io = priv->mc_io;
@@ -4705,6 +4713,8 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 	dpaa2_mac_close(mac);
 err_free_mac:
 	kfree(mac);
+out_put_device:
+	put_device(&dpmac_dev->dev);
 	return err;
 }
 
...

-- 
pw-bot: changes-requested

