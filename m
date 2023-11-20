Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6977F18A5
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 17:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjKTQbd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 11:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKTQbc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 11:31:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295CA93;
        Mon, 20 Nov 2023 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700497885; x=1732033885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N33YVYiHABybOzRhuldyA57LP3y4GhXc9m4C5cGpqGI=;
  b=amRZbPPm2nh47WLe5BPmlav9KPVLNpZCcLLcCOQvjjLO713Gjfvg8RbN
   rAFFM3SA0C+7tsZUiMPZJ3GVI9vDrGNtm2IM90ZX5CLtYoupu00r29rQS
   /HCzHGAoSLXpP+Jazkw+A0RKpjgRgjYw6Eo99iZF7XNCQo8ffzWlFEjld
   SVsO5LTgMhSi0uBP+3NqgIBLi0tUwDOvQJl6zWBNJlrgaeY75JjuffeKf
   DApud7ZsXMGVof6gPmNE6SW5wR4zsPQx9PjsycaWg1/J2HVz+lj02AhEp
   HPgrALMfNeMSiQRF70G0E8UtXGvdAFB2AoIv0VVg8kYRcEvFuJSaiKuqO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="394500547"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="394500547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 08:31:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="14220853"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 08:31:09 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id B9FD411FAC4;
        Mon, 20 Nov 2023 18:31:05 +0200 (EET)
Date:   Mon, 20 Nov 2023 16:31:05 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     stable@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michal Simek <michal.simek@amd.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: Patch "media: v4l: async: Rename async nf functions, clean up
 long lines" has been added to the 5.15-stable tree
Message-ID: <ZVuJyREX0ETQWBgR@kekkonen.localdomain>
References: <20231120152238.707760-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120152238.707760-1-sashal@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi folks,

On Mon, Nov 20, 2023 at 10:22:33AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     media: v4l: async: Rename async nf functions, clean up long lines

This patch doesn't fix anything, it just renames a number of long function
names in a number of places. Why should it be backported to 5.15?

> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      media-v4l-async-rename-async-nf-functions-clean-up-l.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 3464203cfff9f4f40ce445a7be3175ddbf41e21d
> Author: Sakari Ailus <sakari.ailus@linux.intel.com>
> Date:   Fri Mar 5 18:13:12 2021 +0100
> 
>     media: v4l: async: Rename async nf functions, clean up long lines
>     
>     [ Upstream commit 3c8c153914812a98eaa0b5a6cf09c511a06aafbe ]
>     
>     Rename V4L2 async notifier functions, replacing "notifier" with "nf" and
>     removing "_subdev" at the end of the function names adding subdevs as you
>     can only add subdevs to a notifier. Also wrap and otherwise clean up long
>     lines.
>     
>     Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>     Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
>     Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com> (imx7)
>     Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     Stable-dep-of: b2701715301a ("media: cadence: csi2rx: Unregister v4l2 async notifier")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/Documentation/driver-api/media/v4l2-subdev.rst b/Documentation/driver-api/media/v4l2-subdev.rst
> index 7736da077fb87..08ea2673b19e3 100644
> --- a/Documentation/driver-api/media/v4l2-subdev.rst
> +++ b/Documentation/driver-api/media/v4l2-subdev.rst
> @@ -191,21 +191,21 @@ registered this way are stored in a global list of subdevices, ready to be
>  picked up by bridge drivers.
>  
>  Bridge drivers in turn have to register a notifier object. This is
> -performed using the :c:func:`v4l2_async_notifier_register` call. To
> +performed using the :c:func:`v4l2_async_nf_register` call. To
>  unregister the notifier the driver has to call
> -:c:func:`v4l2_async_notifier_unregister`. The former of the two functions
> +:c:func:`v4l2_async_nf_unregister`. The former of the two functions
>  takes two arguments: a pointer to struct :c:type:`v4l2_device` and a
>  pointer to struct :c:type:`v4l2_async_notifier`.
>  
>  Before registering the notifier, bridge drivers must do two things: first, the
> -notifier must be initialized using the :c:func:`v4l2_async_notifier_init`.
> +notifier must be initialized using the :c:func:`v4l2_async_nf_init`.
>  Second, bridge drivers can then begin to form a list of subdevice descriptors
>  that the bridge device needs for its operation. Several functions are available
>  to add subdevice descriptors to a notifier, depending on the type of device and
>  the needs of the driver.
>  
> -:c:func:`v4l2_async_notifier_add_fwnode_remote_subdev` and
> -:c:func:`v4l2_async_notifier_add_i2c_subdev` are for bridge and ISP drivers for
> +:c:func:`v4l2_async_nf_add_fwnode_remote` and
> +:c:func:`v4l2_async_nf_add_i2c` are for bridge and ISP drivers for
>  registering their async sub-devices with the notifier.
>  
>  :c:func:`v4l2_async_register_subdev_sensor` is a helper function for
> @@ -230,8 +230,8 @@ These functions allocate an async sub-device descriptor which is of type struct
>  
>  	...
>  
> -	my_asd = v4l2_async_notifier_add_fwnode_remote_subdev(&notifier, ep,
> -							      struct my_async_subdev);
> +	my_asd = v4l2_async_nf_add_fwnode_remote(&notifier, ep,
> +						 struct my_async_subdev);
>  	fwnode_handle_put(ep);
>  
>  	if (IS_ERR(asd))
> diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
> index 1b9beaee6bea7..b5fed8a52c44b 100644
> --- a/drivers/media/i2c/max9286.c
> +++ b/drivers/media/i2c/max9286.c
> @@ -609,19 +609,18 @@ static int max9286_v4l2_notifier_register(struct max9286_priv *priv)
>  	if (!priv->nsources)
>  		return 0;
>  
> -	v4l2_async_notifier_init(&priv->notifier);
> +	v4l2_async_nf_init(&priv->notifier);
>  
>  	for_each_source(priv, source) {
>  		unsigned int i = to_index(priv, source);
>  		struct max9286_asd *mas;
>  
> -		mas = v4l2_async_notifier_add_fwnode_subdev(&priv->notifier,
> -							    source->fwnode,
> -							    struct max9286_asd);
> +		mas = v4l2_async_nf_add_fwnode(&priv->notifier, source->fwnode,
> +					       struct max9286_asd);
>  		if (IS_ERR(mas)) {
>  			dev_err(dev, "Failed to add subdev for source %u: %ld",
>  				i, PTR_ERR(mas));
> -			v4l2_async_notifier_cleanup(&priv->notifier);
> +			v4l2_async_nf_cleanup(&priv->notifier);
>  			return PTR_ERR(mas);
>  		}
>  
> @@ -630,10 +629,10 @@ static int max9286_v4l2_notifier_register(struct max9286_priv *priv)
>  
>  	priv->notifier.ops = &max9286_notify_ops;
>  
> -	ret = v4l2_async_subdev_notifier_register(&priv->sd, &priv->notifier);
> +	ret = v4l2_async_subdev_nf_register(&priv->sd, &priv->notifier);
>  	if (ret) {
>  		dev_err(dev, "Failed to register subdev_notifier");
> -		v4l2_async_notifier_cleanup(&priv->notifier);
> +		v4l2_async_nf_cleanup(&priv->notifier);
>  		return ret;
>  	}
>  
> @@ -645,8 +644,8 @@ static void max9286_v4l2_notifier_unregister(struct max9286_priv *priv)
>  	if (!priv->nsources)
>  		return;
>  
> -	v4l2_async_notifier_unregister(&priv->notifier);
> -	v4l2_async_notifier_cleanup(&priv->notifier);
> +	v4l2_async_nf_unregister(&priv->notifier);
> +	v4l2_async_nf_cleanup(&priv->notifier);
>  }
>  
>  static int max9286_s_stream(struct v4l2_subdev *sd, int enable)
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index cf55c57a79707..f8615d95b4826 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -881,11 +881,10 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
>  	bridge->rx = ep;
>  
>  	/* register async notifier so we get noticed when sensor is connected */
> -	v4l2_async_notifier_init(&bridge->notifier);
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -					&bridge->notifier,
> -					of_fwnode_handle(ep_node),
> -					struct v4l2_async_subdev);
> +	v4l2_async_nf_init(&bridge->notifier);
> +	asd = v4l2_async_nf_add_fwnode_remote(&bridge->notifier,
> +					      of_fwnode_handle(ep_node),
> +					      struct v4l2_async_subdev);
>  	of_node_put(ep_node);
>  
>  	if (IS_ERR(asd)) {
> @@ -895,10 +894,9 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
>  	}
>  	bridge->notifier.ops = &mipid02_notifier_ops;
>  
> -	ret = v4l2_async_subdev_notifier_register(&bridge->sd,
> -						  &bridge->notifier);
> +	ret = v4l2_async_subdev_nf_register(&bridge->sd, &bridge->notifier);
>  	if (ret)
> -		v4l2_async_notifier_cleanup(&bridge->notifier);
> +		v4l2_async_nf_cleanup(&bridge->notifier);
>  
>  	return ret;
>  
> @@ -1036,8 +1034,8 @@ static int mipid02_probe(struct i2c_client *client)
>  	return 0;
>  
>  unregister_notifier:
> -	v4l2_async_notifier_unregister(&bridge->notifier);
> -	v4l2_async_notifier_cleanup(&bridge->notifier);
> +	v4l2_async_nf_unregister(&bridge->notifier);
> +	v4l2_async_nf_cleanup(&bridge->notifier);
>  power_off:
>  	mipid02_set_power_off(bridge);
>  entity_cleanup:
> @@ -1053,8 +1051,8 @@ static int mipid02_remove(struct i2c_client *client)
>  	struct v4l2_subdev *sd = i2c_get_clientdata(client);
>  	struct mipid02_dev *bridge = to_mipid02_dev(sd);
>  
> -	v4l2_async_notifier_unregister(&bridge->notifier);
> -	v4l2_async_notifier_cleanup(&bridge->notifier);
> +	v4l2_async_nf_unregister(&bridge->notifier);
> +	v4l2_async_nf_cleanup(&bridge->notifier);
>  	v4l2_async_unregister_subdev(&bridge->sd);
>  	mipid02_set_power_off(bridge);
>  	media_entity_cleanup(&bridge->sd.entity);
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
> index 162ab089124f3..00e2225f1ea3d 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
> @@ -1478,8 +1478,9 @@ static int cio2_parse_firmware(struct cio2_device *cio2)
>  		if (ret)
>  			goto err_parse;
>  
> -		s_asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -				&cio2->notifier, ep, struct sensor_async_subdev);
> +		s_asd = v4l2_async_nf_add_fwnode_remote(&cio2->notifier, ep,
> +							struct
> +							sensor_async_subdev);
>  		if (IS_ERR(s_asd)) {
>  			ret = PTR_ERR(s_asd);
>  			goto err_parse;
> @@ -1502,7 +1503,7 @@ static int cio2_parse_firmware(struct cio2_device *cio2)
>  	 * suspend.
>  	 */
>  	cio2->notifier.ops = &cio2_async_ops;
> -	ret = v4l2_async_notifier_register(&cio2->v4l2_dev, &cio2->notifier);
> +	ret = v4l2_async_nf_register(&cio2->v4l2_dev, &cio2->notifier);
>  	if (ret)
>  		dev_err(&cio2->pci_dev->dev,
>  			"failed to register async notifier : %d\n", ret);
> @@ -1804,7 +1805,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
>  	if (r)
>  		goto fail_v4l2_device_unregister;
>  
> -	v4l2_async_notifier_init(&cio2->notifier);
> +	v4l2_async_nf_init(&cio2->notifier);
>  
>  	/* Register notifier for subdevices we care */
>  	r = cio2_parse_firmware(cio2);
> @@ -1824,8 +1825,8 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
>  	return 0;
>  
>  fail_clean_notifier:
> -	v4l2_async_notifier_unregister(&cio2->notifier);
> -	v4l2_async_notifier_cleanup(&cio2->notifier);
> +	v4l2_async_nf_unregister(&cio2->notifier);
> +	v4l2_async_nf_cleanup(&cio2->notifier);
>  	cio2_queues_exit(cio2);
>  fail_v4l2_device_unregister:
>  	v4l2_device_unregister(&cio2->v4l2_dev);
> @@ -1844,8 +1845,8 @@ static void cio2_pci_remove(struct pci_dev *pci_dev)
>  	struct cio2_device *cio2 = pci_get_drvdata(pci_dev);
>  
>  	media_device_unregister(&cio2->media_dev);
> -	v4l2_async_notifier_unregister(&cio2->notifier);
> -	v4l2_async_notifier_cleanup(&cio2->notifier);
> +	v4l2_async_nf_unregister(&cio2->notifier);
> +	v4l2_async_nf_cleanup(&cio2->notifier);
>  	cio2_queues_exit(cio2);
>  	cio2_fbpt_exit_dummy(cio2);
>  	v4l2_device_unregister(&cio2->v4l2_dev);
> diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
> index c1ce93efc6559..38fe7f67d51e5 100644
> --- a/drivers/media/platform/am437x/am437x-vpfe.c
> +++ b/drivers/media/platform/am437x/am437x-vpfe.c
> @@ -2298,7 +2298,7 @@ vpfe_get_pdata(struct vpfe_device *vpfe)
>  
>  	dev_dbg(dev, "vpfe_get_pdata\n");
>  
> -	v4l2_async_notifier_init(&vpfe->notifier);
> +	v4l2_async_nf_init(&vpfe->notifier);
>  
>  	if (!IS_ENABLED(CONFIG_OF) || !dev->of_node)
>  		return dev->platform_data;
> @@ -2366,9 +2366,10 @@ vpfe_get_pdata(struct vpfe_device *vpfe)
>  			goto cleanup;
>  		}
>  
> -		pdata->asd[i] = v4l2_async_notifier_add_fwnode_subdev(
> -			&vpfe->notifier, of_fwnode_handle(rem),
> -			struct v4l2_async_subdev);
> +		pdata->asd[i] = v4l2_async_nf_add_fwnode(&vpfe->notifier,
> +							 of_fwnode_handle(rem),
> +							 struct
> +							 v4l2_async_subdev);
>  		of_node_put(rem);
>  		if (IS_ERR(pdata->asd[i]))
>  			goto cleanup;
> @@ -2378,7 +2379,7 @@ vpfe_get_pdata(struct vpfe_device *vpfe)
>  	return pdata;
>  
>  cleanup:
> -	v4l2_async_notifier_cleanup(&vpfe->notifier);
> +	v4l2_async_nf_cleanup(&vpfe->notifier);
>  	of_node_put(endpoint);
>  	return NULL;
>  }
> @@ -2466,7 +2467,7 @@ static int vpfe_probe(struct platform_device *pdev)
>  	}
>  
>  	vpfe->notifier.ops = &vpfe_async_ops;
> -	ret = v4l2_async_notifier_register(&vpfe->v4l2_dev, &vpfe->notifier);
> +	ret = v4l2_async_nf_register(&vpfe->v4l2_dev, &vpfe->notifier);
>  	if (ret) {
>  		vpfe_err(vpfe, "Error registering async notifier\n");
>  		ret = -EINVAL;
> @@ -2478,7 +2479,7 @@ static int vpfe_probe(struct platform_device *pdev)
>  probe_out_v4l2_unregister:
>  	v4l2_device_unregister(&vpfe->v4l2_dev);
>  probe_out_cleanup:
> -	v4l2_async_notifier_cleanup(&vpfe->notifier);
> +	v4l2_async_nf_cleanup(&vpfe->notifier);
>  	return ret;
>  }
>  
> @@ -2491,8 +2492,8 @@ static int vpfe_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(&pdev->dev);
>  
> -	v4l2_async_notifier_unregister(&vpfe->notifier);
> -	v4l2_async_notifier_cleanup(&vpfe->notifier);
> +	v4l2_async_nf_unregister(&vpfe->notifier);
> +	v4l2_async_nf_cleanup(&vpfe->notifier);
>  	v4l2_device_unregister(&vpfe->v4l2_dev);
>  	video_unregister_device(&vpfe->video_dev);
>  
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index f768be3c40595..24807782c9e50 100644
> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> @@ -2217,8 +2217,8 @@ void isc_subdev_cleanup(struct isc_device *isc)
>  	struct isc_subdev_entity *subdev_entity;
>  
>  	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
> -		v4l2_async_notifier_unregister(&subdev_entity->notifier);
> -		v4l2_async_notifier_cleanup(&subdev_entity->notifier);
> +		v4l2_async_nf_unregister(&subdev_entity->notifier);
> +		v4l2_async_nf_cleanup(&subdev_entity->notifier);
>  	}
>  
>  	INIT_LIST_HEAD(&isc->subdev_entities);
> diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
> index 095d80c4f59e7..4d15814e4481c 100644
> --- a/drivers/media/platform/atmel/atmel-isi.c
> +++ b/drivers/media/platform/atmel/atmel-isi.c
> @@ -1159,12 +1159,11 @@ static int isi_graph_init(struct atmel_isi *isi)
>  	if (!ep)
>  		return -EINVAL;
>  
> -	v4l2_async_notifier_init(&isi->notifier);
> +	v4l2_async_nf_init(&isi->notifier);
>  
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -						&isi->notifier,
> -						of_fwnode_handle(ep),
> -						struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode_remote(&isi->notifier,
> +					      of_fwnode_handle(ep),
> +					      struct v4l2_async_subdev);
>  	of_node_put(ep);
>  
>  	if (IS_ERR(asd))
> @@ -1172,10 +1171,10 @@ static int isi_graph_init(struct atmel_isi *isi)
>  
>  	isi->notifier.ops = &isi_graph_notify_ops;
>  
> -	ret = v4l2_async_notifier_register(&isi->v4l2_dev, &isi->notifier);
> +	ret = v4l2_async_nf_register(&isi->v4l2_dev, &isi->notifier);
>  	if (ret < 0) {
>  		dev_err(isi->dev, "Notifier registration failed\n");
> -		v4l2_async_notifier_cleanup(&isi->notifier);
> +		v4l2_async_nf_cleanup(&isi->notifier);
>  		return ret;
>  	}
>  
> @@ -1327,8 +1326,8 @@ static int atmel_isi_remove(struct platform_device *pdev)
>  			isi->p_fb_descriptors,
>  			isi->fb_descriptors_phys);
>  	pm_runtime_disable(&pdev->dev);
> -	v4l2_async_notifier_unregister(&isi->notifier);
> -	v4l2_async_notifier_cleanup(&isi->notifier);
> +	v4l2_async_nf_unregister(&isi->notifier);
> +	v4l2_async_nf_cleanup(&isi->notifier);
>  	v4l2_device_unregister(&isi->v4l2_dev);
>  
>  	return 0;
> diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> index 7421bc51709c4..a1fd240c6aeb8 100644
> --- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> +++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> @@ -499,13 +499,14 @@ static int atmel_isc_probe(struct platform_device *pdev)
>  
>  	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
>  		struct v4l2_async_subdev *asd;
> +		struct fwnode_handle *fwnode =
> +			of_fwnode_handle(subdev_entity->epn);
>  
> -		v4l2_async_notifier_init(&subdev_entity->notifier);
> +		v4l2_async_nf_init(&subdev_entity->notifier);
>  
> -		asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -					&subdev_entity->notifier,
> -					of_fwnode_handle(subdev_entity->epn),
> -					struct v4l2_async_subdev);
> +		asd = v4l2_async_nf_add_fwnode_remote(&subdev_entity->notifier,
> +						      fwnode,
> +						      struct v4l2_async_subdev);
>  
>  		of_node_put(subdev_entity->epn);
>  		subdev_entity->epn = NULL;
> @@ -517,8 +518,8 @@ static int atmel_isc_probe(struct platform_device *pdev)
>  
>  		subdev_entity->notifier.ops = &isc_async_ops;
>  
> -		ret = v4l2_async_notifier_register(&isc->v4l2_dev,
> -						   &subdev_entity->notifier);
> +		ret = v4l2_async_nf_register(&isc->v4l2_dev,
> +					     &subdev_entity->notifier);
>  		if (ret) {
>  			dev_err(dev, "fail to register async notifier\n");
>  			goto cleanup_subdev;
> diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> index a4defc30cf412..366f2afcda193 100644
> --- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> +++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> @@ -493,13 +493,14 @@ static int microchip_xisc_probe(struct platform_device *pdev)
>  
>  	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
>  		struct v4l2_async_subdev *asd;
> +		struct fwnode_handle *fwnode =
> +			of_fwnode_handle(subdev_entity->epn);
>  
> -		v4l2_async_notifier_init(&subdev_entity->notifier);
> +		v4l2_async_nf_init(&subdev_entity->notifier);
>  
> -		asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -					&subdev_entity->notifier,
> -					of_fwnode_handle(subdev_entity->epn),
> -					struct v4l2_async_subdev);
> +		asd = v4l2_async_nf_add_fwnode_remote(&subdev_entity->notifier,
> +						      fwnode,
> +						      struct v4l2_async_subdev);
>  
>  		of_node_put(subdev_entity->epn);
>  		subdev_entity->epn = NULL;
> @@ -511,8 +512,8 @@ static int microchip_xisc_probe(struct platform_device *pdev)
>  
>  		subdev_entity->notifier.ops = &isc_async_ops;
>  
> -		ret = v4l2_async_notifier_register(&isc->v4l2_dev,
> -						   &subdev_entity->notifier);
> +		ret = v4l2_async_nf_register(&isc->v4l2_dev,
> +					     &subdev_entity->notifier);
>  		if (ret) {
>  			dev_err(dev, "fail to register async notifier\n");
>  			goto cleanup_subdev;
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index f2b4ddd31177b..7b44ab2b8c9ad 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -401,21 +401,19 @@ static int csi2rx_parse_dt(struct csi2rx_priv *csi2rx)
>  		return -EINVAL;
>  	}
>  
> -	v4l2_async_notifier_init(&csi2rx->notifier);
> +	v4l2_async_nf_init(&csi2rx->notifier);
>  
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(&csi2rx->notifier,
> -							   fwh,
> -							   struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode_remote(&csi2rx->notifier, fwh,
> +					      struct v4l2_async_subdev);
>  	of_node_put(ep);
>  	if (IS_ERR(asd))
>  		return PTR_ERR(asd);
>  
>  	csi2rx->notifier.ops = &csi2rx_notifier_ops;
>  
> -	ret = v4l2_async_subdev_notifier_register(&csi2rx->subdev,
> -						  &csi2rx->notifier);
> +	ret = v4l2_async_subdev_nf_register(&csi2rx->subdev, &csi2rx->notifier);
>  	if (ret)
> -		v4l2_async_notifier_cleanup(&csi2rx->notifier);
> +		v4l2_async_nf_cleanup(&csi2rx->notifier);
>  
>  	return ret;
>  }
> @@ -471,7 +469,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_cleanup:
> -	v4l2_async_notifier_cleanup(&csi2rx->notifier);
> +	v4l2_async_nf_cleanup(&csi2rx->notifier);
>  err_free_priv:
>  	kfree(csi2rx);
>  	return ret;
> diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
> index c034e25dd9aae..ae92e2c206d04 100644
> --- a/drivers/media/platform/davinci/vpif_capture.c
> +++ b/drivers/media/platform/davinci/vpif_capture.c
> @@ -1506,7 +1506,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>  	struct vpif_capture_chan_config *chan;
>  	unsigned int i;
>  
> -	v4l2_async_notifier_init(&vpif_obj.notifier);
> +	v4l2_async_nf_init(&vpif_obj.notifier);
>  
>  	/*
>  	 * DT boot: OF node from parent device contains
> @@ -1582,9 +1582,10 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>  		dev_dbg(&pdev->dev, "Remote device %pOF found\n", rem);
>  		sdinfo->name = rem->full_name;
>  
> -		pdata->asd[i] = v4l2_async_notifier_add_fwnode_subdev(
> -			&vpif_obj.notifier, of_fwnode_handle(rem),
> -			struct v4l2_async_subdev);
> +		pdata->asd[i] = v4l2_async_nf_add_fwnode(&vpif_obj.notifier,
> +							 of_fwnode_handle(rem),
> +							 struct
> +							 v4l2_async_subdev);
>  		if (IS_ERR(pdata->asd[i]))
>  			goto err_cleanup;
>  
> @@ -1602,7 +1603,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>  err_cleanup:
>  	of_node_put(rem);
>  	of_node_put(endpoint);
> -	v4l2_async_notifier_cleanup(&vpif_obj.notifier);
> +	v4l2_async_nf_cleanup(&vpif_obj.notifier);
>  
>  	return NULL;
>  }
> @@ -1692,8 +1693,8 @@ static __init int vpif_probe(struct platform_device *pdev)
>  			goto probe_subdev_out;
>  	} else {
>  		vpif_obj.notifier.ops = &vpif_async_ops;
> -		err = v4l2_async_notifier_register(&vpif_obj.v4l2_dev,
> -						   &vpif_obj.notifier);
> +		err = v4l2_async_nf_register(&vpif_obj.v4l2_dev,
> +					     &vpif_obj.notifier);
>  		if (err) {
>  			vpif_err("Error registering async notifier\n");
>  			err = -EINVAL;
> @@ -1711,7 +1712,7 @@ static __init int vpif_probe(struct platform_device *pdev)
>  vpif_free:
>  	free_vpif_objs();
>  cleanup:
> -	v4l2_async_notifier_cleanup(&vpif_obj.notifier);
> +	v4l2_async_nf_cleanup(&vpif_obj.notifier);
>  
>  	return err;
>  }
> @@ -1727,8 +1728,8 @@ static int vpif_remove(struct platform_device *device)
>  	struct channel_obj *ch;
>  	int i;
>  
> -	v4l2_async_notifier_unregister(&vpif_obj.notifier);
> -	v4l2_async_notifier_cleanup(&vpif_obj.notifier);
> +	v4l2_async_nf_unregister(&vpif_obj.notifier);
> +	v4l2_async_nf_cleanup(&vpif_obj.notifier);
>  	v4l2_device_unregister(&vpif_obj.v4l2_dev);
>  
>  	kfree(vpif_obj.sd);
> diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
> index b19d7c8ddc06b..b2d8b2c0ab4d6 100644
> --- a/drivers/media/platform/exynos4-is/media-dev.c
> +++ b/drivers/media/platform/exynos4-is/media-dev.c
> @@ -464,9 +464,9 @@ static int fimc_md_parse_one_endpoint(struct fimc_md *fmd,
>  		return -EINVAL;
>  	}
>  
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -		&fmd->subdev_notifier, of_fwnode_handle(ep),
> -		struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode_remote(&fmd->subdev_notifier,
> +					      of_fwnode_handle(ep),
> +					      struct v4l2_async_subdev);
>  
>  	of_node_put(ep);
>  
> @@ -557,7 +557,7 @@ static int fimc_md_register_sensor_entities(struct fimc_md *fmd)
>  
>  cleanup:
>  	of_node_put(ports);
> -	v4l2_async_notifier_cleanup(&fmd->subdev_notifier);
> +	v4l2_async_nf_cleanup(&fmd->subdev_notifier);
>  	pm_runtime_put(fmd->pmf);
>  	return ret;
>  }
> @@ -1479,7 +1479,7 @@ static int fimc_md_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, fmd);
>  
> -	v4l2_async_notifier_init(&fmd->subdev_notifier);
> +	v4l2_async_nf_init(&fmd->subdev_notifier);
>  
>  	ret = fimc_md_register_platform_entities(fmd, dev->of_node);
>  	if (ret)
> @@ -1507,8 +1507,8 @@ static int fimc_md_probe(struct platform_device *pdev)
>  		fmd->subdev_notifier.ops = &subdev_notifier_ops;
>  		fmd->num_sensors = 0;
>  
> -		ret = v4l2_async_notifier_register(&fmd->v4l2_dev,
> -						&fmd->subdev_notifier);
> +		ret = v4l2_async_nf_register(&fmd->v4l2_dev,
> +					     &fmd->subdev_notifier);
>  		if (ret)
>  			goto err_clk_p;
>  	}
> @@ -1520,7 +1520,7 @@ static int fimc_md_probe(struct platform_device *pdev)
>  err_attr:
>  	device_remove_file(&pdev->dev, &dev_attr_subdev_conf_mode);
>  err_cleanup:
> -	v4l2_async_notifier_cleanup(&fmd->subdev_notifier);
> +	v4l2_async_nf_cleanup(&fmd->subdev_notifier);
>  err_m_ent:
>  	fimc_md_unregister_entities(fmd);
>  err_clk:
> @@ -1540,8 +1540,8 @@ static int fimc_md_remove(struct platform_device *pdev)
>  		return 0;
>  
>  	fimc_md_unregister_clk_provider(fmd);
> -	v4l2_async_notifier_unregister(&fmd->subdev_notifier);
> -	v4l2_async_notifier_cleanup(&fmd->subdev_notifier);
> +	v4l2_async_nf_unregister(&fmd->subdev_notifier);
> +	v4l2_async_nf_cleanup(&fmd->subdev_notifier);
>  
>  	v4l2_device_unregister(&fmd->v4l2_dev);
>  	device_remove_file(&pdev->dev, &dev_attr_subdev_conf_mode);
> diff --git a/drivers/media/platform/marvell-ccic/cafe-driver.c b/drivers/media/platform/marvell-ccic/cafe-driver.c
> index 9aa374fa8b364..b61b9d9551af5 100644
> --- a/drivers/media/platform/marvell-ccic/cafe-driver.c
> +++ b/drivers/media/platform/marvell-ccic/cafe-driver.c
> @@ -544,12 +544,11 @@ static int cafe_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto out_pdown;
>  
> -	v4l2_async_notifier_init(&mcam->notifier);
> +	v4l2_async_nf_init(&mcam->notifier);
>  
> -	asd = v4l2_async_notifier_add_i2c_subdev(&mcam->notifier,
> -					i2c_adapter_id(cam->i2c_adapter),
> -					ov7670_info.addr,
> -					struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_i2c(&mcam->notifier,
> +				    i2c_adapter_id(cam->i2c_adapter),
> +				    ov7670_info.addr, struct v4l2_async_subdev);
>  	if (IS_ERR(asd)) {
>  		ret = PTR_ERR(asd);
>  		goto out_smbus_shutdown;
> diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/media/platform/marvell-ccic/mcam-core.c
> index 58f9463f3b8ce..ad4a7922d0d74 100644
> --- a/drivers/media/platform/marvell-ccic/mcam-core.c
> +++ b/drivers/media/platform/marvell-ccic/mcam-core.c
> @@ -1877,7 +1877,7 @@ int mccic_register(struct mcam_camera *cam)
>  	cam->mbus_code = mcam_def_mbus_code;
>  
>  	cam->notifier.ops = &mccic_notify_ops;
> -	ret = v4l2_async_notifier_register(&cam->v4l2_dev, &cam->notifier);
> +	ret = v4l2_async_nf_register(&cam->v4l2_dev, &cam->notifier);
>  	if (ret < 0) {
>  		cam_warn(cam, "failed to register a sensor notifier");
>  		goto out;
> @@ -1914,9 +1914,9 @@ int mccic_register(struct mcam_camera *cam)
>  	return 0;
>  
>  out:
> -	v4l2_async_notifier_unregister(&cam->notifier);
> +	v4l2_async_nf_unregister(&cam->notifier);
>  	v4l2_device_unregister(&cam->v4l2_dev);
> -	v4l2_async_notifier_cleanup(&cam->notifier);
> +	v4l2_async_nf_cleanup(&cam->notifier);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(mccic_register);
> @@ -1936,9 +1936,9 @@ void mccic_shutdown(struct mcam_camera *cam)
>  	if (cam->buffer_mode == B_vmalloc)
>  		mcam_free_dma_bufs(cam);
>  	v4l2_ctrl_handler_free(&cam->ctrl_handler);
> -	v4l2_async_notifier_unregister(&cam->notifier);
> +	v4l2_async_nf_unregister(&cam->notifier);
>  	v4l2_device_unregister(&cam->v4l2_dev);
> -	v4l2_async_notifier_cleanup(&cam->notifier);
> +	v4l2_async_nf_cleanup(&cam->notifier);
>  }
>  EXPORT_SYMBOL_GPL(mccic_shutdown);
>  
> diff --git a/drivers/media/platform/marvell-ccic/mmp-driver.c b/drivers/media/platform/marvell-ccic/mmp-driver.c
> index f2f09cea751d8..343ab4f7d807b 100644
> --- a/drivers/media/platform/marvell-ccic/mmp-driver.c
> +++ b/drivers/media/platform/marvell-ccic/mmp-driver.c
> @@ -239,10 +239,10 @@ static int mmpcam_probe(struct platform_device *pdev)
>  	if (!ep)
>  		return -ENODEV;
>  
> -	v4l2_async_notifier_init(&mcam->notifier);
> +	v4l2_async_nf_init(&mcam->notifier);
>  
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(&mcam->notifier, ep,
> -							   struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode_remote(&mcam->notifier, ep,
> +					      struct v4l2_async_subdev);
>  	fwnode_handle_put(ep);
>  	if (IS_ERR(asd)) {
>  		ret = PTR_ERR(asd);
> diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
> index 3222c98b83630..beafe85f28cca 100644
> --- a/drivers/media/platform/omap3isp/isp.c
> +++ b/drivers/media/platform/omap3isp/isp.c
> @@ -2003,7 +2003,7 @@ static int isp_remove(struct platform_device *pdev)
>  {
>  	struct isp_device *isp = platform_get_drvdata(pdev);
>  
> -	v4l2_async_notifier_unregister(&isp->notifier);
> +	v4l2_async_nf_unregister(&isp->notifier);
>  	isp_unregister_entities(isp);
>  	isp_cleanup_modules(isp);
>  	isp_xclk_cleanup(isp);
> @@ -2013,7 +2013,7 @@ static int isp_remove(struct platform_device *pdev)
>  	__omap3isp_put(isp, false);
>  
>  	media_entity_enum_cleanup(&isp->crashed);
> -	v4l2_async_notifier_cleanup(&isp->notifier);
> +	v4l2_async_nf_cleanup(&isp->notifier);
>  
>  	kfree(isp);
>  
> @@ -2172,8 +2172,9 @@ static int isp_parse_of_endpoints(struct isp_device *isp)
>  		ret = v4l2_fwnode_endpoint_parse(ep, &vep);
>  
>  		if (!ret) {
> -			isd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -				&isp->notifier, ep, struct isp_async_subdev);
> +			isd = v4l2_async_nf_add_fwnode_remote(&isp->notifier,
> +							      ep, struct
> +							      isp_async_subdev);
>  			if (!IS_ERR(isd))
>  				isp_parse_of_parallel_endpoint(isp->dev, &vep, &isd->bus);
>  		}
> @@ -2211,8 +2212,10 @@ static int isp_parse_of_endpoints(struct isp_device *isp)
>  		}
>  
>  		if (!ret) {
> -			isd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -				&isp->notifier, ep, struct isp_async_subdev);
> +			isd = v4l2_async_nf_add_fwnode_remote(&isp->notifier,
> +							      ep,
> +							      struct
> +							      isp_async_subdev);
>  
>  			if (!IS_ERR(isd)) {
>  				switch (vep.bus_type) {
> @@ -2289,7 +2292,7 @@ static int isp_probe(struct platform_device *pdev)
>  
>  	mutex_init(&isp->isp_mutex);
>  	spin_lock_init(&isp->stat_lock);
> -	v4l2_async_notifier_init(&isp->notifier);
> +	v4l2_async_nf_init(&isp->notifier);
>  	isp->dev = &pdev->dev;
>  
>  	ret = isp_parse_of_endpoints(isp);
> @@ -2427,7 +2430,7 @@ static int isp_probe(struct platform_device *pdev)
>  
>  	isp->notifier.ops = &isp_subdev_notifier_ops;
>  
> -	ret = v4l2_async_notifier_register(&isp->v4l2_dev, &isp->notifier);
> +	ret = v4l2_async_nf_register(&isp->v4l2_dev, &isp->notifier);
>  	if (ret)
>  		goto error_register_entities;
>  
> @@ -2446,7 +2449,7 @@ static int isp_probe(struct platform_device *pdev)
>  	isp_xclk_cleanup(isp);
>  	__omap3isp_put(isp, false);
>  error:
> -	v4l2_async_notifier_cleanup(&isp->notifier);
> +	v4l2_async_nf_cleanup(&isp->notifier);
>  	mutex_destroy(&isp->isp_mutex);
>  error_release_isp:
>  	kfree(isp);
> diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
> index ec4c010644cae..3ba00b0f93200 100644
> --- a/drivers/media/platform/pxa_camera.c
> +++ b/drivers/media/platform/pxa_camera.c
> @@ -2249,10 +2249,9 @@ static int pxa_camera_pdata_from_dt(struct device *dev,
>  	if (ep.bus.parallel.flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
>  		pcdev->platform_flags |= PXA_CAMERA_PCLK_EN;
>  
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -				&pcdev->notifier,
> -				of_fwnode_handle(np),
> -				struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode_remote(&pcdev->notifier,
> +					      of_fwnode_handle(np),
> +					      struct v4l2_async_subdev);
>  	if (IS_ERR(asd))
>  		err = PTR_ERR(asd);
>  out:
> @@ -2289,7 +2288,7 @@ static int pxa_camera_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcdev->clk))
>  		return PTR_ERR(pcdev->clk);
>  
> -	v4l2_async_notifier_init(&pcdev->notifier);
> +	v4l2_async_nf_init(&pcdev->notifier);
>  	pcdev->res = res;
>  	pcdev->pdata = pdev->dev.platform_data;
>  	if (pcdev->pdata) {
> @@ -2297,11 +2296,10 @@ static int pxa_camera_probe(struct platform_device *pdev)
>  
>  		pcdev->platform_flags = pcdev->pdata->flags;
>  		pcdev->mclk = pcdev->pdata->mclk_10khz * 10000;
> -		asd = v4l2_async_notifier_add_i2c_subdev(
> -				&pcdev->notifier,
> -				pcdev->pdata->sensor_i2c_adapter_id,
> -				pcdev->pdata->sensor_i2c_address,
> -				struct v4l2_async_subdev);
> +		asd = v4l2_async_nf_add_i2c(&pcdev->notifier,
> +					    pcdev->pdata->sensor_i2c_adapter_id,
> +					    pcdev->pdata->sensor_i2c_address,
> +					    struct v4l2_async_subdev);
>  		if (IS_ERR(asd))
>  			err = PTR_ERR(asd);
>  	} else if (pdev->dev.of_node) {
> @@ -2402,13 +2400,13 @@ static int pxa_camera_probe(struct platform_device *pdev)
>  		goto exit_notifier_cleanup;
>  
>  	pcdev->notifier.ops = &pxa_camera_sensor_ops;
> -	err = v4l2_async_notifier_register(&pcdev->v4l2_dev, &pcdev->notifier);
> +	err = v4l2_async_nf_register(&pcdev->v4l2_dev, &pcdev->notifier);
>  	if (err)
>  		goto exit_notifier_cleanup;
>  
>  	return 0;
>  exit_notifier_cleanup:
> -	v4l2_async_notifier_cleanup(&pcdev->notifier);
> +	v4l2_async_nf_cleanup(&pcdev->notifier);
>  	v4l2_device_unregister(&pcdev->v4l2_dev);
>  exit_deactivate:
>  	pxa_camera_deactivate(pcdev);
> @@ -2432,8 +2430,8 @@ static int pxa_camera_remove(struct platform_device *pdev)
>  	dma_release_channel(pcdev->dma_chans[1]);
>  	dma_release_channel(pcdev->dma_chans[2]);
>  
> -	v4l2_async_notifier_unregister(&pcdev->notifier);
> -	v4l2_async_notifier_cleanup(&pcdev->notifier);
> +	v4l2_async_nf_unregister(&pcdev->notifier);
> +	v4l2_async_nf_cleanup(&pcdev->notifier);
>  
>  	v4l2_device_unregister(&pcdev->v4l2_dev);
>  
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index ef100d5f77636..be091c50a3c0c 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -886,9 +886,9 @@ static int camss_of_parse_ports(struct camss *camss)
>  			goto err_cleanup;
>  		}
>  
> -		csd = v4l2_async_notifier_add_fwnode_subdev(
> -			&camss->notifier, of_fwnode_handle(remote),
> -			struct camss_async_subdev);
> +		csd = v4l2_async_nf_add_fwnode(&camss->notifier,
> +					       of_fwnode_handle(remote),
> +					       struct camss_async_subdev);
>  		of_node_put(remote);
>  		if (IS_ERR(csd)) {
>  			ret = PTR_ERR(csd);
> @@ -1361,7 +1361,7 @@ static int camss_probe(struct platform_device *pdev)
>  		goto err_free;
>  	}
>  
> -	v4l2_async_notifier_init(&camss->notifier);
> +	v4l2_async_nf_init(&camss->notifier);
>  
>  	num_subdevs = camss_of_parse_ports(camss);
>  	if (num_subdevs < 0) {
> @@ -1397,8 +1397,8 @@ static int camss_probe(struct platform_device *pdev)
>  	if (num_subdevs) {
>  		camss->notifier.ops = &camss_subdev_notifier_ops;
>  
> -		ret = v4l2_async_notifier_register(&camss->v4l2_dev,
> -						   &camss->notifier);
> +		ret = v4l2_async_nf_register(&camss->v4l2_dev,
> +					     &camss->notifier);
>  		if (ret) {
>  			dev_err(dev,
>  				"Failed to register async subdev nodes: %d\n",
> @@ -1436,7 +1436,7 @@ static int camss_probe(struct platform_device *pdev)
>  err_register_entities:
>  	v4l2_device_unregister(&camss->v4l2_dev);
>  err_cleanup:
> -	v4l2_async_notifier_cleanup(&camss->notifier);
> +	v4l2_async_nf_cleanup(&camss->notifier);
>  err_free:
>  	kfree(camss);
>  
> @@ -1478,8 +1478,8 @@ static int camss_remove(struct platform_device *pdev)
>  {
>  	struct camss *camss = platform_get_drvdata(pdev);
>  
> -	v4l2_async_notifier_unregister(&camss->notifier);
> -	v4l2_async_notifier_cleanup(&camss->notifier);
> +	v4l2_async_nf_unregister(&camss->notifier);
> +	v4l2_async_nf_cleanup(&camss->notifier);
>  	camss_unregister_entities(camss);
>  
>  	if (atomic_read(&camss->ref_count) == 0)
> diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
> index 5a280d8ff7dd0..d1786aa8a7ecd 100644
> --- a/drivers/media/platform/rcar-vin/rcar-core.c
> +++ b/drivers/media/platform/rcar-vin/rcar-core.c
> @@ -535,9 +535,8 @@ static int rvin_mc_parse_of(struct rvin_dev *vin, unsigned int id)
>  		goto out;
>  	}
>  
> -	asd = v4l2_async_notifier_add_fwnode_subdev(&vin->group->notifier,
> -						    fwnode,
> -						    struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode(&vin->group->notifier, fwnode,
> +				       struct v4l2_async_subdev);
>  	if (IS_ERR(asd)) {
>  		ret = PTR_ERR(asd);
>  		goto out;
> @@ -557,8 +556,8 @@ static void rvin_group_notifier_cleanup(struct rvin_dev *vin)
>  {
>  	mutex_lock(&vin->group->lock);
>  	if (&vin->v4l2_dev == vin->group->notifier.v4l2_dev) {
> -		v4l2_async_notifier_unregister(&vin->group->notifier);
> -		v4l2_async_notifier_cleanup(&vin->group->notifier);
> +		v4l2_async_nf_unregister(&vin->group->notifier);
> +		v4l2_async_nf_cleanup(&vin->group->notifier);
>  	}
>  	mutex_unlock(&vin->group->lock);
>  }
> @@ -586,7 +585,7 @@ static int rvin_mc_parse_of_graph(struct rvin_dev *vin)
>  
>  	mutex_unlock(&vin->group->lock);
>  
> -	v4l2_async_notifier_init(&vin->group->notifier);
> +	v4l2_async_nf_init(&vin->group->notifier);
>  
>  	/*
>  	 * Have all VIN's look for CSI-2 subdevices. Some subdevices will
> @@ -611,11 +610,10 @@ static int rvin_mc_parse_of_graph(struct rvin_dev *vin)
>  		return 0;
>  
>  	vin->group->notifier.ops = &rvin_group_notify_ops;
> -	ret = v4l2_async_notifier_register(&vin->v4l2_dev,
> -					   &vin->group->notifier);
> +	ret = v4l2_async_nf_register(&vin->v4l2_dev, &vin->group->notifier);
>  	if (ret < 0) {
>  		vin_err(vin, "Notifier registration failed\n");
> -		v4l2_async_notifier_cleanup(&vin->group->notifier);
> +		v4l2_async_nf_cleanup(&vin->group->notifier);
>  		return ret;
>  	}
>  
> @@ -899,8 +897,8 @@ static int rvin_parallel_parse_of(struct rvin_dev *vin)
>  		goto out;
>  	}
>  
> -	asd = v4l2_async_notifier_add_fwnode_subdev(&vin->notifier, fwnode,
> -						    struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode(&vin->notifier, fwnode,
> +				       struct v4l2_async_subdev);
>  	if (IS_ERR(asd)) {
>  		ret = PTR_ERR(asd);
>  		goto out;
> @@ -917,15 +915,15 @@ static int rvin_parallel_parse_of(struct rvin_dev *vin)
>  
>  static void rvin_parallel_cleanup(struct rvin_dev *vin)
>  {
> -	v4l2_async_notifier_unregister(&vin->notifier);
> -	v4l2_async_notifier_cleanup(&vin->notifier);
> +	v4l2_async_nf_unregister(&vin->notifier);
> +	v4l2_async_nf_cleanup(&vin->notifier);
>  }
>  
>  static int rvin_parallel_init(struct rvin_dev *vin)
>  {
>  	int ret;
>  
> -	v4l2_async_notifier_init(&vin->notifier);
> +	v4l2_async_nf_init(&vin->notifier);
>  
>  	ret = rvin_parallel_parse_of(vin);
>  	if (ret)
> @@ -939,10 +937,10 @@ static int rvin_parallel_init(struct rvin_dev *vin)
>  		to_of_node(vin->parallel.asd->match.fwnode));
>  
>  	vin->notifier.ops = &rvin_parallel_notify_ops;
> -	ret = v4l2_async_notifier_register(&vin->v4l2_dev, &vin->notifier);
> +	ret = v4l2_async_nf_register(&vin->v4l2_dev, &vin->notifier);
>  	if (ret < 0) {
>  		vin_err(vin, "Notifier registration failed\n");
> -		v4l2_async_notifier_cleanup(&vin->notifier);
> +		v4l2_async_nf_cleanup(&vin->notifier);
>  		return ret;
>  	}
>  
> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> index 0c5e2f7e04beb..5e9cb72676e39 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -926,19 +926,18 @@ static int rcsi2_parse_dt(struct rcar_csi2 *priv)
>  
>  	dev_dbg(priv->dev, "Found '%pOF'\n", to_of_node(fwnode));
>  
> -	v4l2_async_notifier_init(&priv->notifier);
> +	v4l2_async_nf_init(&priv->notifier);
>  	priv->notifier.ops = &rcar_csi2_notify_ops;
>  
> -	asd = v4l2_async_notifier_add_fwnode_subdev(&priv->notifier, fwnode,
> -						    struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode(&priv->notifier, fwnode,
> +				       struct v4l2_async_subdev);
>  	fwnode_handle_put(fwnode);
>  	if (IS_ERR(asd))
>  		return PTR_ERR(asd);
>  
> -	ret = v4l2_async_subdev_notifier_register(&priv->subdev,
> -						  &priv->notifier);
> +	ret = v4l2_async_subdev_nf_register(&priv->subdev, &priv->notifier);
>  	if (ret)
> -		v4l2_async_notifier_cleanup(&priv->notifier);
> +		v4l2_async_nf_cleanup(&priv->notifier);
>  
>  	return ret;
>  }
> @@ -1301,8 +1300,8 @@ static int rcsi2_probe(struct platform_device *pdev)
>  	return 0;
>  
>  error:
> -	v4l2_async_notifier_unregister(&priv->notifier);
> -	v4l2_async_notifier_cleanup(&priv->notifier);
> +	v4l2_async_nf_unregister(&priv->notifier);
> +	v4l2_async_nf_cleanup(&priv->notifier);
>  
>  	return ret;
>  }
> @@ -1311,8 +1310,8 @@ static int rcsi2_remove(struct platform_device *pdev)
>  {
>  	struct rcar_csi2 *priv = platform_get_drvdata(pdev);
>  
> -	v4l2_async_notifier_unregister(&priv->notifier);
> -	v4l2_async_notifier_cleanup(&priv->notifier);
> +	v4l2_async_nf_unregister(&priv->notifier);
> +	v4l2_async_nf_cleanup(&priv->notifier);
>  	v4l2_async_unregister_subdev(&priv->subdev);
>  
>  	pm_runtime_disable(&pdev->dev);
> diff --git a/drivers/media/platform/rcar_drif.c b/drivers/media/platform/rcar_drif.c
> index 1e3b68a8743af..a505d991548bb 100644
> --- a/drivers/media/platform/rcar_drif.c
> +++ b/drivers/media/platform/rcar_drif.c
> @@ -1212,7 +1212,7 @@ static int rcar_drif_parse_subdevs(struct rcar_drif_sdr *sdr)
>  	struct fwnode_handle *fwnode, *ep;
>  	struct v4l2_async_subdev *asd;
>  
> -	v4l2_async_notifier_init(notifier);
> +	v4l2_async_nf_init(notifier);
>  
>  	ep = fwnode_graph_get_next_endpoint(of_fwnode_handle(sdr->dev->of_node),
>  					    NULL);
> @@ -1229,8 +1229,8 @@ static int rcar_drif_parse_subdevs(struct rcar_drif_sdr *sdr)
>  		return -EINVAL;
>  	}
>  
> -	asd = v4l2_async_notifier_add_fwnode_subdev(notifier, fwnode,
> -						    struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode(notifier, fwnode,
> +				       struct v4l2_async_subdev);
>  	fwnode_handle_put(fwnode);
>  	if (IS_ERR(asd))
>  		return PTR_ERR(asd);
> @@ -1346,7 +1346,7 @@ static int rcar_drif_sdr_probe(struct rcar_drif_sdr *sdr)
>  	sdr->notifier.ops = &rcar_drif_notify_ops;
>  
>  	/* Register notifier */
> -	ret = v4l2_async_notifier_register(&sdr->v4l2_dev, &sdr->notifier);
> +	ret = v4l2_async_nf_register(&sdr->v4l2_dev, &sdr->notifier);
>  	if (ret < 0) {
>  		dev_err(sdr->dev, "failed: notifier register ret %d\n", ret);
>  		goto cleanup;
> @@ -1355,7 +1355,7 @@ static int rcar_drif_sdr_probe(struct rcar_drif_sdr *sdr)
>  	return ret;
>  
>  cleanup:
> -	v4l2_async_notifier_cleanup(&sdr->notifier);
> +	v4l2_async_nf_cleanup(&sdr->notifier);
>  error:
>  	v4l2_device_unregister(&sdr->v4l2_dev);
>  
> @@ -1365,8 +1365,8 @@ static int rcar_drif_sdr_probe(struct rcar_drif_sdr *sdr)
>  /* V4L2 SDR device remove */
>  static void rcar_drif_sdr_remove(struct rcar_drif_sdr *sdr)
>  {
> -	v4l2_async_notifier_unregister(&sdr->notifier);
> -	v4l2_async_notifier_cleanup(&sdr->notifier);
> +	v4l2_async_nf_unregister(&sdr->notifier);
> +	v4l2_async_nf_cleanup(&sdr->notifier);
>  	v4l2_device_unregister(&sdr->v4l2_dev);
>  }
>  
> diff --git a/drivers/media/platform/renesas-ceu.c b/drivers/media/platform/renesas-ceu.c
> index f432032c7084f..9376eb363748b 100644
> --- a/drivers/media/platform/renesas-ceu.c
> +++ b/drivers/media/platform/renesas-ceu.c
> @@ -1513,12 +1513,12 @@ static int ceu_parse_platform_data(struct ceu_device *ceudev,
>  
>  		/* Setup the ceu subdevice and the async subdevice. */
>  		async_sd = &pdata->subdevs[i];
> -		ceu_sd = v4l2_async_notifier_add_i2c_subdev(&ceudev->notifier,
> -				async_sd->i2c_adapter_id,
> -				async_sd->i2c_address,
> -				struct ceu_subdev);
> +		ceu_sd = v4l2_async_nf_add_i2c(&ceudev->notifier,
> +					       async_sd->i2c_adapter_id,
> +					       async_sd->i2c_address,
> +					       struct ceu_subdev);
>  		if (IS_ERR(ceu_sd)) {
> -			v4l2_async_notifier_cleanup(&ceudev->notifier);
> +			v4l2_async_nf_cleanup(&ceudev->notifier);
>  			return PTR_ERR(ceu_sd);
>  		}
>  		ceu_sd->mbus_flags = async_sd->flags;
> @@ -1576,9 +1576,9 @@ static int ceu_parse_dt(struct ceu_device *ceudev)
>  		}
>  
>  		/* Setup the ceu subdevice and the async subdevice. */
> -		ceu_sd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -				&ceudev->notifier, of_fwnode_handle(ep),
> -				struct ceu_subdev);
> +		ceu_sd = v4l2_async_nf_add_fwnode_remote(&ceudev->notifier,
> +							 of_fwnode_handle(ep),
> +							 struct ceu_subdev);
>  		if (IS_ERR(ceu_sd)) {
>  			ret = PTR_ERR(ceu_sd);
>  			goto error_cleanup;
> @@ -1592,7 +1592,7 @@ static int ceu_parse_dt(struct ceu_device *ceudev)
>  	return num_ep;
>  
>  error_cleanup:
> -	v4l2_async_notifier_cleanup(&ceudev->notifier);
> +	v4l2_async_nf_cleanup(&ceudev->notifier);
>  	of_node_put(ep);
>  	return ret;
>  }
> @@ -1669,7 +1669,7 @@ static int ceu_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto error_pm_disable;
>  
> -	v4l2_async_notifier_init(&ceudev->notifier);
> +	v4l2_async_nf_init(&ceudev->notifier);
>  
>  	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
>  		ceu_data = of_device_get_match_data(dev);
> @@ -1691,8 +1691,7 @@ static int ceu_probe(struct platform_device *pdev)
>  
>  	ceudev->notifier.v4l2_dev	= &ceudev->v4l2_dev;
>  	ceudev->notifier.ops		= &ceu_notify_ops;
> -	ret = v4l2_async_notifier_register(&ceudev->v4l2_dev,
> -					   &ceudev->notifier);
> +	ret = v4l2_async_nf_register(&ceudev->v4l2_dev, &ceudev->notifier);
>  	if (ret)
>  		goto error_cleanup;
>  
> @@ -1701,7 +1700,7 @@ static int ceu_probe(struct platform_device *pdev)
>  	return 0;
>  
>  error_cleanup:
> -	v4l2_async_notifier_cleanup(&ceudev->notifier);
> +	v4l2_async_nf_cleanup(&ceudev->notifier);
>  error_v4l2_unregister:
>  	v4l2_device_unregister(&ceudev->v4l2_dev);
>  error_pm_disable:
> @@ -1718,9 +1717,9 @@ static int ceu_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(ceudev->dev);
>  
> -	v4l2_async_notifier_unregister(&ceudev->notifier);
> +	v4l2_async_nf_unregister(&ceudev->notifier);
>  
> -	v4l2_async_notifier_cleanup(&ceudev->notifier);
> +	v4l2_async_nf_cleanup(&ceudev->notifier);
>  
>  	v4l2_device_unregister(&ceudev->v4l2_dev);
>  
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 560f928c37520..b6a4522c2970d 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -246,7 +246,7 @@ static int rkisp1_subdev_notifier(struct rkisp1_device *rkisp1)
>  	unsigned int next_id = 0;
>  	int ret;
>  
> -	v4l2_async_notifier_init(ntf);
> +	v4l2_async_nf_init(ntf);
>  
>  	while (1) {
>  		struct v4l2_fwnode_endpoint vep = {
> @@ -265,8 +265,9 @@ static int rkisp1_subdev_notifier(struct rkisp1_device *rkisp1)
>  		if (ret)
>  			goto err_parse;
>  
> -		rk_asd = v4l2_async_notifier_add_fwnode_remote_subdev(ntf, ep,
> -							struct rkisp1_sensor_async);
> +		rk_asd = v4l2_async_nf_add_fwnode_remote(ntf, ep,
> +							 struct
> +							 rkisp1_sensor_async);
>  		if (IS_ERR(rk_asd)) {
>  			ret = PTR_ERR(rk_asd);
>  			goto err_parse;
> @@ -286,16 +287,16 @@ static int rkisp1_subdev_notifier(struct rkisp1_device *rkisp1)
>  		continue;
>  err_parse:
>  		fwnode_handle_put(ep);
> -		v4l2_async_notifier_cleanup(ntf);
> +		v4l2_async_nf_cleanup(ntf);
>  		return ret;
>  	}
>  
>  	if (next_id == 0)
>  		dev_dbg(rkisp1->dev, "no remote subdevice found\n");
>  	ntf->ops = &rkisp1_subdev_notifier_ops;
> -	ret = v4l2_async_notifier_register(&rkisp1->v4l2_dev, ntf);
> +	ret = v4l2_async_nf_register(&rkisp1->v4l2_dev, ntf);
>  	if (ret) {
> -		v4l2_async_notifier_cleanup(ntf);
> +		v4l2_async_nf_cleanup(ntf);
>  		return ret;
>  	}
>  	return 0;
> @@ -542,8 +543,8 @@ static int rkisp1_remove(struct platform_device *pdev)
>  {
>  	struct rkisp1_device *rkisp1 = platform_get_drvdata(pdev);
>  
> -	v4l2_async_notifier_unregister(&rkisp1->notifier);
> -	v4l2_async_notifier_cleanup(&rkisp1->notifier);
> +	v4l2_async_nf_unregister(&rkisp1->notifier);
> +	v4l2_async_nf_cleanup(&rkisp1->notifier);
>  
>  	rkisp1_params_unregister(rkisp1);
>  	rkisp1_stats_unregister(rkisp1);
> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
> index 6110718645a4f..e1b17c05229cf 100644
> --- a/drivers/media/platform/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
> @@ -1833,11 +1833,11 @@ static int dcmi_graph_init(struct stm32_dcmi *dcmi)
>  		return -EINVAL;
>  	}
>  
> -	v4l2_async_notifier_init(&dcmi->notifier);
> +	v4l2_async_nf_init(&dcmi->notifier);
>  
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -		&dcmi->notifier, of_fwnode_handle(ep),
> -		struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode_remote(&dcmi->notifier,
> +					      of_fwnode_handle(ep),
> +					      struct v4l2_async_subdev);
>  
>  	of_node_put(ep);
>  
> @@ -1848,10 +1848,10 @@ static int dcmi_graph_init(struct stm32_dcmi *dcmi)
>  
>  	dcmi->notifier.ops = &dcmi_graph_notify_ops;
>  
> -	ret = v4l2_async_notifier_register(&dcmi->v4l2_dev, &dcmi->notifier);
> +	ret = v4l2_async_nf_register(&dcmi->v4l2_dev, &dcmi->notifier);
>  	if (ret < 0) {
>  		dev_err(dcmi->dev, "Failed to register notifier\n");
> -		v4l2_async_notifier_cleanup(&dcmi->notifier);
> +		v4l2_async_nf_cleanup(&dcmi->notifier);
>  		return ret;
>  	}
>  
> @@ -2063,7 +2063,7 @@ static int dcmi_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_cleanup:
> -	v4l2_async_notifier_cleanup(&dcmi->notifier);
> +	v4l2_async_nf_cleanup(&dcmi->notifier);
>  err_media_entity_cleanup:
>  	media_entity_cleanup(&dcmi->vdev->entity);
>  err_device_release:
> @@ -2083,8 +2083,8 @@ static int dcmi_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(&pdev->dev);
>  
> -	v4l2_async_notifier_unregister(&dcmi->notifier);
> -	v4l2_async_notifier_cleanup(&dcmi->notifier);
> +	v4l2_async_nf_unregister(&dcmi->notifier);
> +	v4l2_async_nf_cleanup(&dcmi->notifier);
>  	media_entity_cleanup(&dcmi->vdev->entity);
>  	v4l2_device_unregister(&dcmi->v4l2_dev);
>  	media_device_cleanup(&dcmi->mdev);
> diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
> index 8d40a7acba9c4..94e98e470aff7 100644
> --- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
> +++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
> @@ -122,7 +122,7 @@ static int sun4i_csi_notifier_init(struct sun4i_csi *csi)
>  	struct fwnode_handle *ep;
>  	int ret;
>  
> -	v4l2_async_notifier_init(&csi->notifier);
> +	v4l2_async_nf_init(&csi->notifier);
>  
>  	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(csi->dev), 0, 0,
>  					     FWNODE_GRAPH_ENDPOINT_NEXT);
> @@ -135,8 +135,8 @@ static int sun4i_csi_notifier_init(struct sun4i_csi *csi)
>  
>  	csi->bus = vep.bus.parallel;
>  
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(&csi->notifier, ep,
> -							   struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode_remote(&csi->notifier, ep,
> +					      struct v4l2_async_subdev);
>  	if (IS_ERR(asd)) {
>  		ret = PTR_ERR(asd);
>  		goto out;
> @@ -244,7 +244,7 @@ static int sun4i_csi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_unregister_media;
>  
> -	ret = v4l2_async_notifier_register(&csi->v4l, &csi->notifier);
> +	ret = v4l2_async_nf_register(&csi->v4l, &csi->notifier);
>  	if (ret) {
>  		dev_err(csi->dev, "Couldn't register our notifier.\n");
>  		goto err_unregister_media;
> @@ -268,8 +268,8 @@ static int sun4i_csi_remove(struct platform_device *pdev)
>  {
>  	struct sun4i_csi *csi = platform_get_drvdata(pdev);
>  
> -	v4l2_async_notifier_unregister(&csi->notifier);
> -	v4l2_async_notifier_cleanup(&csi->notifier);
> +	v4l2_async_nf_unregister(&csi->notifier);
> +	v4l2_async_nf_cleanup(&csi->notifier);
>  	vb2_video_unregister_device(&csi->vdev);
>  	media_device_unregister(&csi->mdev);
>  	sun4i_csi_dma_unregister(csi);
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index 27935f1e9555e..08df0c833423b 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -717,8 +717,8 @@ static int sun6i_csi_fwnode_parse(struct device *dev,
>  static void sun6i_csi_v4l2_cleanup(struct sun6i_csi *csi)
>  {
>  	media_device_unregister(&csi->media_dev);
> -	v4l2_async_notifier_unregister(&csi->notifier);
> -	v4l2_async_notifier_cleanup(&csi->notifier);
> +	v4l2_async_nf_unregister(&csi->notifier);
> +	v4l2_async_nf_cleanup(&csi->notifier);
>  	sun6i_video_cleanup(&csi->video);
>  	v4l2_device_unregister(&csi->v4l2_dev);
>  	v4l2_ctrl_handler_free(&csi->ctrl_handler);
> @@ -737,7 +737,7 @@ static int sun6i_csi_v4l2_init(struct sun6i_csi *csi)
>  		 "platform:%s", dev_name(csi->dev));
>  
>  	media_device_init(&csi->media_dev);
> -	v4l2_async_notifier_init(&csi->notifier);
> +	v4l2_async_nf_init(&csi->notifier);
>  
>  	ret = v4l2_ctrl_handler_init(&csi->ctrl_handler, 0);
>  	if (ret) {
> @@ -759,16 +759,17 @@ static int sun6i_csi_v4l2_init(struct sun6i_csi *csi)
>  	if (ret)
>  		goto unreg_v4l2;
>  
> -	ret = v4l2_async_notifier_parse_fwnode_endpoints(csi->dev,
> -							 &csi->notifier,
> -							 sizeof(struct v4l2_async_subdev),
> -							 sun6i_csi_fwnode_parse);
> +	ret = v4l2_async_nf_parse_fwnode_endpoints(csi->dev,
> +						   &csi->notifier,
> +						   sizeof(struct
> +							  v4l2_async_subdev),
> +						   sun6i_csi_fwnode_parse);
>  	if (ret)
>  		goto clean_video;
>  
>  	csi->notifier.ops = &sun6i_csi_async_ops;
>  
> -	ret = v4l2_async_notifier_register(&csi->v4l2_dev, &csi->notifier);
> +	ret = v4l2_async_nf_register(&csi->v4l2_dev, &csi->notifier);
>  	if (ret) {
>  		dev_err(csi->dev, "notifier registration failed\n");
>  		goto clean_video;
> @@ -783,7 +784,7 @@ static int sun6i_csi_v4l2_init(struct sun6i_csi *csi)
>  free_ctrl:
>  	v4l2_ctrl_handler_free(&csi->ctrl_handler);
>  clean_media:
> -	v4l2_async_notifier_cleanup(&csi->notifier);
> +	v4l2_async_nf_cleanup(&csi->notifier);
>  	media_device_cleanup(&csi->media_dev);
>  
>  	return ret;
> diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
> index 35d62eb1321fb..0e583120266ff 100644
> --- a/drivers/media/platform/ti-vpe/cal.c
> +++ b/drivers/media/platform/ti-vpe/cal.c
> @@ -781,7 +781,7 @@ static int cal_async_notifier_register(struct cal_dev *cal)
>  	unsigned int i;
>  	int ret;
>  
> -	v4l2_async_notifier_init(&cal->notifier);
> +	v4l2_async_nf_init(&cal->notifier);
>  	cal->notifier.ops = &cal_async_notifier_ops;
>  
>  	for (i = 0; i < cal->data->num_csi2_phy; ++i) {
> @@ -793,9 +793,9 @@ static int cal_async_notifier_register(struct cal_dev *cal)
>  			continue;
>  
>  		fwnode = of_fwnode_handle(phy->source_node);
> -		casd = v4l2_async_notifier_add_fwnode_subdev(&cal->notifier,
> -							     fwnode,
> -							     struct cal_v4l2_async_subdev);
> +		casd = v4l2_async_nf_add_fwnode(&cal->notifier,
> +						fwnode,
> +						struct cal_v4l2_async_subdev);
>  		if (IS_ERR(casd)) {
>  			phy_err(phy, "Failed to add subdev to notifier\n");
>  			ret = PTR_ERR(casd);
> @@ -805,7 +805,7 @@ static int cal_async_notifier_register(struct cal_dev *cal)
>  		casd->phy = phy;
>  	}
>  
> -	ret = v4l2_async_notifier_register(&cal->v4l2_dev, &cal->notifier);
> +	ret = v4l2_async_nf_register(&cal->v4l2_dev, &cal->notifier);
>  	if (ret) {
>  		cal_err(cal, "Error registering async notifier\n");
>  		goto error;
> @@ -814,14 +814,14 @@ static int cal_async_notifier_register(struct cal_dev *cal)
>  	return 0;
>  
>  error:
> -	v4l2_async_notifier_cleanup(&cal->notifier);
> +	v4l2_async_nf_cleanup(&cal->notifier);
>  	return ret;
>  }
>  
>  static void cal_async_notifier_unregister(struct cal_dev *cal)
>  {
> -	v4l2_async_notifier_unregister(&cal->notifier);
> -	v4l2_async_notifier_cleanup(&cal->notifier);
> +	v4l2_async_nf_unregister(&cal->notifier);
> +	v4l2_async_nf_cleanup(&cal->notifier);
>  }
>  
>  /* ------------------------------------------------------------------
> diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
> index 905005e271ca9..fda8fc0e48143 100644
> --- a/drivers/media/platform/video-mux.c
> +++ b/drivers/media/platform/video-mux.c
> @@ -360,7 +360,7 @@ static int video_mux_async_register(struct video_mux *vmux,
>  	unsigned int i;
>  	int ret;
>  
> -	v4l2_async_notifier_init(&vmux->notifier);
> +	v4l2_async_nf_init(&vmux->notifier);
>  
>  	for (i = 0; i < num_input_pads; i++) {
>  		struct v4l2_async_subdev *asd;
> @@ -380,8 +380,8 @@ static int video_mux_async_register(struct video_mux *vmux,
>  		}
>  		fwnode_handle_put(remote_ep);
>  
> -		asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -			&vmux->notifier, ep, struct v4l2_async_subdev);
> +		asd = v4l2_async_nf_add_fwnode_remote(&vmux->notifier, ep,
> +						      struct v4l2_async_subdev);
>  
>  		fwnode_handle_put(ep);
>  
> @@ -395,8 +395,7 @@ static int video_mux_async_register(struct video_mux *vmux,
>  
>  	vmux->notifier.ops = &video_mux_notify_ops;
>  
> -	ret = v4l2_async_subdev_notifier_register(&vmux->subdev,
> -						  &vmux->notifier);
> +	ret = v4l2_async_subdev_nf_register(&vmux->subdev, &vmux->notifier);
>  	if (ret)
>  		return ret;
>  
> @@ -477,8 +476,8 @@ static int video_mux_probe(struct platform_device *pdev)
>  
>  	ret = video_mux_async_register(vmux, num_pads - 1);
>  	if (ret) {
> -		v4l2_async_notifier_unregister(&vmux->notifier);
> -		v4l2_async_notifier_cleanup(&vmux->notifier);
> +		v4l2_async_nf_unregister(&vmux->notifier);
> +		v4l2_async_nf_cleanup(&vmux->notifier);
>  	}
>  
>  	return ret;
> @@ -489,8 +488,8 @@ static int video_mux_remove(struct platform_device *pdev)
>  	struct video_mux *vmux = platform_get_drvdata(pdev);
>  	struct v4l2_subdev *sd = &vmux->subdev;
>  
> -	v4l2_async_notifier_unregister(&vmux->notifier);
> -	v4l2_async_notifier_cleanup(&vmux->notifier);
> +	v4l2_async_nf_unregister(&vmux->notifier);
> +	v4l2_async_nf_cleanup(&vmux->notifier);
>  	v4l2_async_unregister_subdev(sd);
>  	media_entity_cleanup(&sd->entity);
>  
> diff --git a/drivers/media/platform/xilinx/xilinx-vipp.c b/drivers/media/platform/xilinx/xilinx-vipp.c
> index 5896a662da3ba..0a16c218a50a7 100644
> --- a/drivers/media/platform/xilinx/xilinx-vipp.c
> +++ b/drivers/media/platform/xilinx/xilinx-vipp.c
> @@ -382,9 +382,8 @@ static int xvip_graph_parse_one(struct xvip_composite_device *xdev,
>  			continue;
>  		}
>  
> -		xge = v4l2_async_notifier_add_fwnode_subdev(
> -			&xdev->notifier, remote,
> -			struct xvip_graph_entity);
> +		xge = v4l2_async_nf_add_fwnode(&xdev->notifier, remote,
> +					       struct xvip_graph_entity);
>  		fwnode_handle_put(remote);
>  		if (IS_ERR(xge)) {
>  			ret = PTR_ERR(xge);
> @@ -395,7 +394,7 @@ static int xvip_graph_parse_one(struct xvip_composite_device *xdev,
>  	return 0;
>  
>  err_notifier_cleanup:
> -	v4l2_async_notifier_cleanup(&xdev->notifier);
> +	v4l2_async_nf_cleanup(&xdev->notifier);
>  	fwnode_handle_put(ep);
>  	return ret;
>  }
> @@ -420,7 +419,7 @@ static int xvip_graph_parse(struct xvip_composite_device *xdev)
>  		entity = to_xvip_entity(asd);
>  		ret = xvip_graph_parse_one(xdev, entity->asd.match.fwnode);
>  		if (ret < 0) {
> -			v4l2_async_notifier_cleanup(&xdev->notifier);
> +			v4l2_async_nf_cleanup(&xdev->notifier);
>  			break;
>  		}
>  	}
> @@ -497,8 +496,8 @@ static void xvip_graph_cleanup(struct xvip_composite_device *xdev)
>  	struct xvip_dma *dmap;
>  	struct xvip_dma *dma;
>  
> -	v4l2_async_notifier_unregister(&xdev->notifier);
> -	v4l2_async_notifier_cleanup(&xdev->notifier);
> +	v4l2_async_nf_unregister(&xdev->notifier);
> +	v4l2_async_nf_cleanup(&xdev->notifier);
>  
>  	list_for_each_entry_safe(dma, dmap, &xdev->dmas, list) {
>  		xvip_dma_cleanup(dma);
> @@ -533,7 +532,7 @@ static int xvip_graph_init(struct xvip_composite_device *xdev)
>  	/* Register the subdevices notifier. */
>  	xdev->notifier.ops = &xvip_graph_notify_ops;
>  
> -	ret = v4l2_async_notifier_register(&xdev->v4l2_dev, &xdev->notifier);
> +	ret = v4l2_async_nf_register(&xdev->v4l2_dev, &xdev->notifier);
>  	if (ret < 0) {
>  		dev_err(xdev->dev, "notifier registration failed\n");
>  		goto done;
> @@ -597,7 +596,7 @@ static int xvip_composite_probe(struct platform_device *pdev)
>  
>  	xdev->dev = &pdev->dev;
>  	INIT_LIST_HEAD(&xdev->dmas);
> -	v4l2_async_notifier_init(&xdev->notifier);
> +	v4l2_async_nf_init(&xdev->notifier);
>  
>  	ret = xvip_composite_v4l2_init(xdev);
>  	if (ret < 0)
> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
> index cd9e78c63791b..0404267f1ae4f 100644
> --- a/drivers/media/v4l2-core/v4l2-async.c
> +++ b/drivers/media/v4l2-core/v4l2-async.c
> @@ -24,9 +24,9 @@
>  #include <media/v4l2-fwnode.h>
>  #include <media/v4l2-subdev.h>
>  
> -static int v4l2_async_notifier_call_bound(struct v4l2_async_notifier *n,
> -					  struct v4l2_subdev *subdev,
> -					  struct v4l2_async_subdev *asd)
> +static int v4l2_async_nf_call_bound(struct v4l2_async_notifier *n,
> +				    struct v4l2_subdev *subdev,
> +				    struct v4l2_async_subdev *asd)
>  {
>  	if (!n->ops || !n->ops->bound)
>  		return 0;
> @@ -34,9 +34,9 @@ static int v4l2_async_notifier_call_bound(struct v4l2_async_notifier *n,
>  	return n->ops->bound(n, subdev, asd);
>  }
>  
> -static void v4l2_async_notifier_call_unbind(struct v4l2_async_notifier *n,
> -					    struct v4l2_subdev *subdev,
> -					    struct v4l2_async_subdev *asd)
> +static void v4l2_async_nf_call_unbind(struct v4l2_async_notifier *n,
> +				      struct v4l2_subdev *subdev,
> +				      struct v4l2_async_subdev *asd)
>  {
>  	if (!n->ops || !n->ops->unbind)
>  		return;
> @@ -44,7 +44,7 @@ static void v4l2_async_notifier_call_unbind(struct v4l2_async_notifier *n,
>  	n->ops->unbind(n, subdev, asd);
>  }
>  
> -static int v4l2_async_notifier_call_complete(struct v4l2_async_notifier *n)
> +static int v4l2_async_nf_call_complete(struct v4l2_async_notifier *n)
>  {
>  	if (!n->ops || !n->ops->complete)
>  		return 0;
> @@ -215,7 +215,7 @@ v4l2_async_find_subdev_notifier(struct v4l2_subdev *sd)
>  
>  /* Get v4l2_device related to the notifier if one can be found. */
>  static struct v4l2_device *
> -v4l2_async_notifier_find_v4l2_dev(struct v4l2_async_notifier *notifier)
> +v4l2_async_nf_find_v4l2_dev(struct v4l2_async_notifier *notifier)
>  {
>  	while (notifier->parent)
>  		notifier = notifier->parent;
> @@ -227,7 +227,7 @@ v4l2_async_notifier_find_v4l2_dev(struct v4l2_async_notifier *notifier)
>   * Return true if all child sub-device notifiers are complete, false otherwise.
>   */
>  static bool
> -v4l2_async_notifier_can_complete(struct v4l2_async_notifier *notifier)
> +v4l2_async_nf_can_complete(struct v4l2_async_notifier *notifier)
>  {
>  	struct v4l2_subdev *sd;
>  
> @@ -239,7 +239,7 @@ v4l2_async_notifier_can_complete(struct v4l2_async_notifier *notifier)
>  			v4l2_async_find_subdev_notifier(sd);
>  
>  		if (subdev_notifier &&
> -		    !v4l2_async_notifier_can_complete(subdev_notifier))
> +		    !v4l2_async_nf_can_complete(subdev_notifier))
>  			return false;
>  	}
>  
> @@ -251,7 +251,7 @@ v4l2_async_notifier_can_complete(struct v4l2_async_notifier *notifier)
>   * sub-devices have been bound; v4l2_device is also available then.
>   */
>  static int
> -v4l2_async_notifier_try_complete(struct v4l2_async_notifier *notifier)
> +v4l2_async_nf_try_complete(struct v4l2_async_notifier *notifier)
>  {
>  	/* Quick check whether there are still more sub-devices here. */
>  	if (!list_empty(&notifier->waiting))
> @@ -266,14 +266,14 @@ v4l2_async_notifier_try_complete(struct v4l2_async_notifier *notifier)
>  		return 0;
>  
>  	/* Is everything ready? */
> -	if (!v4l2_async_notifier_can_complete(notifier))
> +	if (!v4l2_async_nf_can_complete(notifier))
>  		return 0;
>  
> -	return v4l2_async_notifier_call_complete(notifier);
> +	return v4l2_async_nf_call_complete(notifier);
>  }
>  
>  static int
> -v4l2_async_notifier_try_all_subdevs(struct v4l2_async_notifier *notifier);
> +v4l2_async_nf_try_all_subdevs(struct v4l2_async_notifier *notifier);
>  
>  static int v4l2_async_match_notify(struct v4l2_async_notifier *notifier,
>  				   struct v4l2_device *v4l2_dev,
> @@ -287,7 +287,7 @@ static int v4l2_async_match_notify(struct v4l2_async_notifier *notifier,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = v4l2_async_notifier_call_bound(notifier, sd, asd);
> +	ret = v4l2_async_nf_call_bound(notifier, sd, asd);
>  	if (ret < 0) {
>  		v4l2_device_unregister_subdev(sd);
>  		return ret;
> @@ -315,15 +315,15 @@ static int v4l2_async_match_notify(struct v4l2_async_notifier *notifier,
>  	 */
>  	subdev_notifier->parent = notifier;
>  
> -	return v4l2_async_notifier_try_all_subdevs(subdev_notifier);
> +	return v4l2_async_nf_try_all_subdevs(subdev_notifier);
>  }
>  
>  /* Test all async sub-devices in a notifier for a match. */
>  static int
> -v4l2_async_notifier_try_all_subdevs(struct v4l2_async_notifier *notifier)
> +v4l2_async_nf_try_all_subdevs(struct v4l2_async_notifier *notifier)
>  {
>  	struct v4l2_device *v4l2_dev =
> -		v4l2_async_notifier_find_v4l2_dev(notifier);
> +		v4l2_async_nf_find_v4l2_dev(notifier);
>  	struct v4l2_subdev *sd;
>  
>  	if (!v4l2_dev)
> @@ -367,7 +367,7 @@ static void v4l2_async_cleanup(struct v4l2_subdev *sd)
>  
>  /* Unbind all sub-devices in the notifier tree. */
>  static void
> -v4l2_async_notifier_unbind_all_subdevs(struct v4l2_async_notifier *notifier)
> +v4l2_async_nf_unbind_all_subdevs(struct v4l2_async_notifier *notifier)
>  {
>  	struct v4l2_subdev *sd, *tmp;
>  
> @@ -376,9 +376,9 @@ v4l2_async_notifier_unbind_all_subdevs(struct v4l2_async_notifier *notifier)
>  			v4l2_async_find_subdev_notifier(sd);
>  
>  		if (subdev_notifier)
> -			v4l2_async_notifier_unbind_all_subdevs(subdev_notifier);
> +			v4l2_async_nf_unbind_all_subdevs(subdev_notifier);
>  
> -		v4l2_async_notifier_call_unbind(notifier, sd, sd->asd);
> +		v4l2_async_nf_call_unbind(notifier, sd, sd->asd);
>  		v4l2_async_cleanup(sd);
>  
>  		list_move(&sd->async_list, &subdev_list);
> @@ -389,8 +389,8 @@ v4l2_async_notifier_unbind_all_subdevs(struct v4l2_async_notifier *notifier)
>  
>  /* See if an async sub-device can be found in a notifier's lists. */
>  static bool
> -__v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
> -				       struct v4l2_async_subdev *asd)
> +__v4l2_async_nf_has_async_subdev(struct v4l2_async_notifier *notifier,
> +				 struct v4l2_async_subdev *asd)
>  {
>  	struct v4l2_async_subdev *asd_y;
>  	struct v4l2_subdev *sd;
> @@ -416,9 +416,8 @@ __v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
>   * If @this_index < 0, search the notifier's entire @asd_list.
>   */
>  static bool
> -v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
> -				     struct v4l2_async_subdev *asd,
> -				     int this_index)
> +v4l2_async_nf_has_async_subdev(struct v4l2_async_notifier *notifier,
> +			       struct v4l2_async_subdev *asd, int this_index)
>  {
>  	struct v4l2_async_subdev *asd_y;
>  	int j = 0;
> @@ -435,15 +434,15 @@ v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
>  
>  	/* Check that an asd does not exist in other notifiers. */
>  	list_for_each_entry(notifier, &notifier_list, list)
> -		if (__v4l2_async_notifier_has_async_subdev(notifier, asd))
> +		if (__v4l2_async_nf_has_async_subdev(notifier, asd))
>  			return true;
>  
>  	return false;
>  }
>  
> -static int v4l2_async_notifier_asd_valid(struct v4l2_async_notifier *notifier,
> -					 struct v4l2_async_subdev *asd,
> -					 int this_index)
> +static int v4l2_async_nf_asd_valid(struct v4l2_async_notifier *notifier,
> +				   struct v4l2_async_subdev *asd,
> +				   int this_index)
>  {
>  	struct device *dev =
>  		notifier->v4l2_dev ? notifier->v4l2_dev->dev : NULL;
> @@ -454,8 +453,7 @@ static int v4l2_async_notifier_asd_valid(struct v4l2_async_notifier *notifier,
>  	switch (asd->match_type) {
>  	case V4L2_ASYNC_MATCH_I2C:
>  	case V4L2_ASYNC_MATCH_FWNODE:
> -		if (v4l2_async_notifier_has_async_subdev(notifier, asd,
> -							 this_index)) {
> +		if (v4l2_async_nf_has_async_subdev(notifier, asd, this_index)) {
>  			dev_dbg(dev, "subdev descriptor already listed in this or other notifiers\n");
>  			return -EEXIST;
>  		}
> @@ -469,13 +467,13 @@ static int v4l2_async_notifier_asd_valid(struct v4l2_async_notifier *notifier,
>  	return 0;
>  }
>  
> -void v4l2_async_notifier_init(struct v4l2_async_notifier *notifier)
> +void v4l2_async_nf_init(struct v4l2_async_notifier *notifier)
>  {
>  	INIT_LIST_HEAD(&notifier->asd_list);
>  }
> -EXPORT_SYMBOL(v4l2_async_notifier_init);
> +EXPORT_SYMBOL(v4l2_async_nf_init);
>  
> -static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
> +static int __v4l2_async_nf_register(struct v4l2_async_notifier *notifier)
>  {
>  	struct v4l2_async_subdev *asd;
>  	int ret, i = 0;
> @@ -486,18 +484,18 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
>  	mutex_lock(&list_lock);
>  
>  	list_for_each_entry(asd, &notifier->asd_list, asd_list) {
> -		ret = v4l2_async_notifier_asd_valid(notifier, asd, i++);
> +		ret = v4l2_async_nf_asd_valid(notifier, asd, i++);
>  		if (ret)
>  			goto err_unlock;
>  
>  		list_add_tail(&asd->list, &notifier->waiting);
>  	}
>  
> -	ret = v4l2_async_notifier_try_all_subdevs(notifier);
> +	ret = v4l2_async_nf_try_all_subdevs(notifier);
>  	if (ret < 0)
>  		goto err_unbind;
>  
> -	ret = v4l2_async_notifier_try_complete(notifier);
> +	ret = v4l2_async_nf_try_complete(notifier);
>  	if (ret < 0)
>  		goto err_unbind;
>  
> @@ -512,7 +510,7 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
>  	/*
>  	 * On failure, unbind all sub-devices registered through this notifier.
>  	 */
> -	v4l2_async_notifier_unbind_all_subdevs(notifier);
> +	v4l2_async_nf_unbind_all_subdevs(notifier);
>  
>  err_unlock:
>  	mutex_unlock(&list_lock);
> @@ -520,8 +518,8 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
>  	return ret;
>  }
>  
> -int v4l2_async_notifier_register(struct v4l2_device *v4l2_dev,
> -				 struct v4l2_async_notifier *notifier)
> +int v4l2_async_nf_register(struct v4l2_device *v4l2_dev,
> +			   struct v4l2_async_notifier *notifier)
>  {
>  	int ret;
>  
> @@ -530,16 +528,16 @@ int v4l2_async_notifier_register(struct v4l2_device *v4l2_dev,
>  
>  	notifier->v4l2_dev = v4l2_dev;
>  
> -	ret = __v4l2_async_notifier_register(notifier);
> +	ret = __v4l2_async_nf_register(notifier);
>  	if (ret)
>  		notifier->v4l2_dev = NULL;
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(v4l2_async_notifier_register);
> +EXPORT_SYMBOL(v4l2_async_nf_register);
>  
> -int v4l2_async_subdev_notifier_register(struct v4l2_subdev *sd,
> -					struct v4l2_async_notifier *notifier)
> +int v4l2_async_subdev_nf_register(struct v4l2_subdev *sd,
> +				  struct v4l2_async_notifier *notifier)
>  {
>  	int ret;
>  
> @@ -548,21 +546,21 @@ int v4l2_async_subdev_notifier_register(struct v4l2_subdev *sd,
>  
>  	notifier->sd = sd;
>  
> -	ret = __v4l2_async_notifier_register(notifier);
> +	ret = __v4l2_async_nf_register(notifier);
>  	if (ret)
>  		notifier->sd = NULL;
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(v4l2_async_subdev_notifier_register);
> +EXPORT_SYMBOL(v4l2_async_subdev_nf_register);
>  
>  static void
> -__v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier)
> +__v4l2_async_nf_unregister(struct v4l2_async_notifier *notifier)
>  {
>  	if (!notifier || (!notifier->v4l2_dev && !notifier->sd))
>  		return;
>  
> -	v4l2_async_notifier_unbind_all_subdevs(notifier);
> +	v4l2_async_nf_unbind_all_subdevs(notifier);
>  
>  	notifier->sd = NULL;
>  	notifier->v4l2_dev = NULL;
> @@ -570,17 +568,17 @@ __v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier)
>  	list_del(&notifier->list);
>  }
>  
> -void v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier)
> +void v4l2_async_nf_unregister(struct v4l2_async_notifier *notifier)
>  {
>  	mutex_lock(&list_lock);
>  
> -	__v4l2_async_notifier_unregister(notifier);
> +	__v4l2_async_nf_unregister(notifier);
>  
>  	mutex_unlock(&list_lock);
>  }
> -EXPORT_SYMBOL(v4l2_async_notifier_unregister);
> +EXPORT_SYMBOL(v4l2_async_nf_unregister);
>  
> -static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
> +static void __v4l2_async_nf_cleanup(struct v4l2_async_notifier *notifier)
>  {
>  	struct v4l2_async_subdev *asd, *tmp;
>  
> @@ -601,24 +599,24 @@ static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
>  	}
>  }
>  
> -void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
> +void v4l2_async_nf_cleanup(struct v4l2_async_notifier *notifier)
>  {
>  	mutex_lock(&list_lock);
>  
> -	__v4l2_async_notifier_cleanup(notifier);
> +	__v4l2_async_nf_cleanup(notifier);
>  
>  	mutex_unlock(&list_lock);
>  }
> -EXPORT_SYMBOL_GPL(v4l2_async_notifier_cleanup);
> +EXPORT_SYMBOL_GPL(v4l2_async_nf_cleanup);
>  
> -int __v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
> -				   struct v4l2_async_subdev *asd)
> +int __v4l2_async_nf_add_subdev(struct v4l2_async_notifier *notifier,
> +			       struct v4l2_async_subdev *asd)
>  {
>  	int ret;
>  
>  	mutex_lock(&list_lock);
>  
> -	ret = v4l2_async_notifier_asd_valid(notifier, asd, -1);
> +	ret = v4l2_async_nf_asd_valid(notifier, asd, -1);
>  	if (ret)
>  		goto unlock;
>  
> @@ -628,12 +626,12 @@ int __v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
>  	mutex_unlock(&list_lock);
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(__v4l2_async_notifier_add_subdev);
> +EXPORT_SYMBOL_GPL(__v4l2_async_nf_add_subdev);
>  
>  struct v4l2_async_subdev *
> -__v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
> -					struct fwnode_handle *fwnode,
> -					unsigned int asd_struct_size)
> +__v4l2_async_nf_add_fwnode(struct v4l2_async_notifier *notifier,
> +			   struct fwnode_handle *fwnode,
> +			   unsigned int asd_struct_size)
>  {
>  	struct v4l2_async_subdev *asd;
>  	int ret;
> @@ -645,7 +643,7 @@ __v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
>  	asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
>  	asd->match.fwnode = fwnode_handle_get(fwnode);
>  
> -	ret = __v4l2_async_notifier_add_subdev(notifier, asd);
> +	ret = __v4l2_async_nf_add_subdev(notifier, asd);
>  	if (ret) {
>  		fwnode_handle_put(fwnode);
>  		kfree(asd);
> @@ -654,12 +652,12 @@ __v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
>  
>  	return asd;
>  }
> -EXPORT_SYMBOL_GPL(__v4l2_async_notifier_add_fwnode_subdev);
> +EXPORT_SYMBOL_GPL(__v4l2_async_nf_add_fwnode);
>  
>  struct v4l2_async_subdev *
> -__v4l2_async_notifier_add_fwnode_remote_subdev(struct v4l2_async_notifier *notif,
> -					       struct fwnode_handle *endpoint,
> -					       unsigned int asd_struct_size)
> +__v4l2_async_nf_add_fwnode_remote(struct v4l2_async_notifier *notif,
> +				  struct fwnode_handle *endpoint,
> +				  unsigned int asd_struct_size)
>  {
>  	struct v4l2_async_subdev *asd;
>  	struct fwnode_handle *remote;
> @@ -668,21 +666,19 @@ __v4l2_async_notifier_add_fwnode_remote_subdev(struct v4l2_async_notifier *notif
>  	if (!remote)
>  		return ERR_PTR(-ENOTCONN);
>  
> -	asd = __v4l2_async_notifier_add_fwnode_subdev(notif, remote,
> -						      asd_struct_size);
> +	asd = __v4l2_async_nf_add_fwnode(notif, remote, asd_struct_size);
>  	/*
> -	 * Calling __v4l2_async_notifier_add_fwnode_subdev grabs a refcount,
> +	 * Calling __v4l2_async_nf_add_fwnode grabs a refcount,
>  	 * so drop the one we got in fwnode_graph_get_remote_port_parent.
>  	 */
>  	fwnode_handle_put(remote);
>  	return asd;
>  }
> -EXPORT_SYMBOL_GPL(__v4l2_async_notifier_add_fwnode_remote_subdev);
> +EXPORT_SYMBOL_GPL(__v4l2_async_nf_add_fwnode_remote);
>  
>  struct v4l2_async_subdev *
> -__v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
> -				     int adapter_id, unsigned short address,
> -				     unsigned int asd_struct_size)
> +__v4l2_async_nf_add_i2c(struct v4l2_async_notifier *notifier, int adapter_id,
> +			unsigned short address, unsigned int asd_struct_size)
>  {
>  	struct v4l2_async_subdev *asd;
>  	int ret;
> @@ -695,7 +691,7 @@ __v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
>  	asd->match.i2c.adapter_id = adapter_id;
>  	asd->match.i2c.address = address;
>  
> -	ret = __v4l2_async_notifier_add_subdev(notifier, asd);
> +	ret = __v4l2_async_nf_add_subdev(notifier, asd);
>  	if (ret) {
>  		kfree(asd);
>  		return ERR_PTR(ret);
> @@ -703,7 +699,7 @@ __v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
>  
>  	return asd;
>  }
> -EXPORT_SYMBOL_GPL(__v4l2_async_notifier_add_i2c_subdev);
> +EXPORT_SYMBOL_GPL(__v4l2_async_nf_add_i2c);
>  
>  int v4l2_async_register_subdev(struct v4l2_subdev *sd)
>  {
> @@ -725,7 +721,7 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
>  
>  	list_for_each_entry(notifier, &notifier_list, list) {
>  		struct v4l2_device *v4l2_dev =
> -			v4l2_async_notifier_find_v4l2_dev(notifier);
> +			v4l2_async_nf_find_v4l2_dev(notifier);
>  		struct v4l2_async_subdev *asd;
>  
>  		if (!v4l2_dev)
> @@ -739,7 +735,7 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
>  		if (ret)
>  			goto err_unbind;
>  
> -		ret = v4l2_async_notifier_try_complete(notifier);
> +		ret = v4l2_async_nf_try_complete(notifier);
>  		if (ret)
>  			goto err_unbind;
>  
> @@ -761,10 +757,10 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
>  	 */
>  	subdev_notifier = v4l2_async_find_subdev_notifier(sd);
>  	if (subdev_notifier)
> -		v4l2_async_notifier_unbind_all_subdevs(subdev_notifier);
> +		v4l2_async_nf_unbind_all_subdevs(subdev_notifier);
>  
>  	if (sd->asd)
> -		v4l2_async_notifier_call_unbind(notifier, sd, sd->asd);
> +		v4l2_async_nf_call_unbind(notifier, sd, sd->asd);
>  	v4l2_async_cleanup(sd);
>  
>  	mutex_unlock(&list_lock);
> @@ -780,8 +776,8 @@ void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
>  
>  	mutex_lock(&list_lock);
>  
> -	__v4l2_async_notifier_unregister(sd->subdev_notifier);
> -	__v4l2_async_notifier_cleanup(sd->subdev_notifier);
> +	__v4l2_async_nf_unregister(sd->subdev_notifier);
> +	__v4l2_async_nf_cleanup(sd->subdev_notifier);
>  	kfree(sd->subdev_notifier);
>  	sd->subdev_notifier = NULL;
>  
> @@ -790,7 +786,7 @@ void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
>  
>  		list_add(&sd->asd->list, &notifier->waiting);
>  
> -		v4l2_async_notifier_call_unbind(notifier, sd, sd->asd);
> +		v4l2_async_nf_call_unbind(notifier, sd, sd->asd);
>  	}
>  
>  	v4l2_async_cleanup(sd);
> @@ -825,7 +821,7 @@ static void print_waiting_subdev(struct seq_file *s,
>  }
>  
>  static const char *
> -v4l2_async_notifier_name(struct v4l2_async_notifier *notifier)
> +v4l2_async_nf_name(struct v4l2_async_notifier *notifier)
>  {
>  	if (notifier->v4l2_dev)
>  		return notifier->v4l2_dev->name;
> @@ -843,7 +839,7 @@ static int pending_subdevs_show(struct seq_file *s, void *data)
>  	mutex_lock(&list_lock);
>  
>  	list_for_each_entry(notif, &notifier_list, list) {
> -		seq_printf(s, "%s:\n", v4l2_async_notifier_name(notif));
> +		seq_printf(s, "%s:\n", v4l2_async_nf_name(notif));
>  		list_for_each_entry(asd, &notif->waiting, list)
>  			print_waiting_subdev(s, asd);
>  	}
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> index 5d2eaad1fa684..eb14193cc5aed 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -790,11 +790,11 @@ int v4l2_fwnode_device_parse(struct device *dev,
>  EXPORT_SYMBOL_GPL(v4l2_fwnode_device_parse);
>  
>  static int
> -v4l2_async_notifier_fwnode_parse_endpoint(struct device *dev,
> -					  struct v4l2_async_notifier *notifier,
> -					  struct fwnode_handle *endpoint,
> -					  unsigned int asd_struct_size,
> -					  parse_endpoint_func parse_endpoint)
> +v4l2_async_nf_fwnode_parse_endpoint(struct device *dev,
> +				    struct v4l2_async_notifier *notifier,
> +				    struct fwnode_handle *endpoint,
> +				    unsigned int asd_struct_size,
> +				    parse_endpoint_func parse_endpoint)
>  {
>  	struct v4l2_fwnode_endpoint vep = { .bus_type = 0 };
>  	struct v4l2_async_subdev *asd;
> @@ -832,7 +832,7 @@ v4l2_async_notifier_fwnode_parse_endpoint(struct device *dev,
>  	if (ret < 0)
>  		goto out_err;
>  
> -	ret = __v4l2_async_notifier_add_subdev(notifier, asd);
> +	ret = __v4l2_async_nf_add_subdev(notifier, asd);
>  	if (ret < 0) {
>  		/* not an error if asd already exists */
>  		if (ret == -EEXIST)
> @@ -850,12 +850,11 @@ v4l2_async_notifier_fwnode_parse_endpoint(struct device *dev,
>  }
>  
>  static int
> -__v4l2_async_notifier_parse_fwnode_ep(struct device *dev,
> -				      struct v4l2_async_notifier *notifier,
> -				      size_t asd_struct_size,
> -				      unsigned int port,
> -				      bool has_port,
> -				      parse_endpoint_func parse_endpoint)
> +__v4l2_async_nf_parse_fwnode_ep(struct device *dev,
> +				struct v4l2_async_notifier *notifier,
> +				size_t asd_struct_size, unsigned int port,
> +				bool has_port,
> +				parse_endpoint_func parse_endpoint)
>  {
>  	struct fwnode_handle *fwnode;
>  	int ret = 0;
> @@ -884,11 +883,10 @@ __v4l2_async_notifier_parse_fwnode_ep(struct device *dev,
>  				continue;
>  		}
>  
> -		ret = v4l2_async_notifier_fwnode_parse_endpoint(dev,
> -								notifier,
> -								fwnode,
> -								asd_struct_size,
> -								parse_endpoint);
> +		ret = v4l2_async_nf_fwnode_parse_endpoint(dev, notifier,
> +							  fwnode,
> +							  asd_struct_size,
> +							  parse_endpoint);
>  		if (ret < 0)
>  			break;
>  	}
> @@ -899,16 +897,15 @@ __v4l2_async_notifier_parse_fwnode_ep(struct device *dev,
>  }
>  
>  int
> -v4l2_async_notifier_parse_fwnode_endpoints(struct device *dev,
> -					   struct v4l2_async_notifier *notifier,
> -					   size_t asd_struct_size,
> -					   parse_endpoint_func parse_endpoint)
> +v4l2_async_nf_parse_fwnode_endpoints(struct device *dev,
> +				     struct v4l2_async_notifier *notifier,
> +				     size_t asd_struct_size,
> +				     parse_endpoint_func parse_endpoint)
>  {
> -	return __v4l2_async_notifier_parse_fwnode_ep(dev, notifier,
> -						     asd_struct_size, 0,
> -						     false, parse_endpoint);
> +	return __v4l2_async_nf_parse_fwnode_ep(dev, notifier, asd_struct_size,
> +					       0, false, parse_endpoint);
>  }
> -EXPORT_SYMBOL_GPL(v4l2_async_notifier_parse_fwnode_endpoints);
> +EXPORT_SYMBOL_GPL(v4l2_async_nf_parse_fwnode_endpoints);
>  
>  /*
>   * v4l2_fwnode_reference_parse - parse references for async sub-devices
> @@ -952,9 +949,8 @@ static int v4l2_fwnode_reference_parse(struct device *dev,
>  	     index++) {
>  		struct v4l2_async_subdev *asd;
>  
> -		asd = v4l2_async_notifier_add_fwnode_subdev(notifier,
> -							    args.fwnode,
> -							    struct v4l2_async_subdev);
> +		asd = v4l2_async_nf_add_fwnode(notifier, args.fwnode,
> +					       struct v4l2_async_subdev);
>  		fwnode_handle_put(args.fwnode);
>  		if (IS_ERR(asd)) {
>  			/* not an error if asd already exists */
> @@ -1253,8 +1249,8 @@ v4l2_fwnode_reference_parse_int_props(struct device *dev,
>  	     index++) {
>  		struct v4l2_async_subdev *asd;
>  
> -		asd = v4l2_async_notifier_add_fwnode_subdev(notifier, fwnode,
> -							    struct v4l2_async_subdev);
> +		asd = v4l2_async_nf_add_fwnode(notifier, fwnode,
> +					       struct v4l2_async_subdev);
>  		fwnode_handle_put(fwnode);
>  		if (IS_ERR(asd)) {
>  			ret = PTR_ERR(asd);
> @@ -1270,7 +1266,7 @@ v4l2_fwnode_reference_parse_int_props(struct device *dev,
>  }
>  
>  /**
> - * v4l2_async_notifier_parse_fwnode_sensor - parse common references on
> + * v4l2_async_nf_parse_fwnode_sensor - parse common references on
>   *					     sensors for async sub-devices
>   * @dev: the device node the properties of which are parsed for references
>   * @notifier: the async notifier where the async subdevs will be added
> @@ -1279,7 +1275,7 @@ v4l2_fwnode_reference_parse_int_props(struct device *dev,
>   * sensor and set up async sub-devices for them.
>   *
>   * Any notifier populated using this function must be released with a call to
> - * v4l2_async_notifier_release() after it has been unregistered and the async
> + * v4l2_async_nf_release() after it has been unregistered and the async
>   * sub-devices are no longer in use, even in the case the function returned an
>   * error.
>   *
> @@ -1288,8 +1284,8 @@ v4l2_fwnode_reference_parse_int_props(struct device *dev,
>   *	   -EINVAL if property parsing failed
>   */
>  static int
> -v4l2_async_notifier_parse_fwnode_sensor(struct device *dev,
> -					struct v4l2_async_notifier *notifier)
> +v4l2_async_nf_parse_fwnode_sensor(struct device *dev,
> +				  struct v4l2_async_notifier *notifier)
>  {
>  	static const char * const led_props[] = { "led" };
>  	static const struct v4l2_fwnode_int_props props[] = {
> @@ -1330,13 +1326,13 @@ int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
>  	if (!notifier)
>  		return -ENOMEM;
>  
> -	v4l2_async_notifier_init(notifier);
> +	v4l2_async_nf_init(notifier);
>  
> -	ret = v4l2_async_notifier_parse_fwnode_sensor(sd->dev, notifier);
> +	ret = v4l2_async_nf_parse_fwnode_sensor(sd->dev, notifier);
>  	if (ret < 0)
>  		goto out_cleanup;
>  
> -	ret = v4l2_async_subdev_notifier_register(sd, notifier);
> +	ret = v4l2_async_subdev_nf_register(sd, notifier);
>  	if (ret < 0)
>  		goto out_cleanup;
>  
> @@ -1349,10 +1345,10 @@ int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
>  	return 0;
>  
>  out_unregister:
> -	v4l2_async_notifier_unregister(notifier);
> +	v4l2_async_nf_unregister(notifier);
>  
>  out_cleanup:
> -	v4l2_async_notifier_cleanup(notifier);
> +	v4l2_async_nf_cleanup(notifier);
>  	kfree(notifier);
>  
>  	return ret;
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index bb1305c9daaf5..45f9d797b9da6 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -1924,7 +1924,7 @@ static int imx_csi_async_register(struct csi_priv *priv)
>  	unsigned int port;
>  	int ret;
>  
> -	v4l2_async_notifier_init(&priv->notifier);
> +	v4l2_async_nf_init(&priv->notifier);
>  
>  	/* get this CSI's port id */
>  	ret = fwnode_property_read_u32(dev_fwnode(priv->dev), "reg", &port);
> @@ -1935,8 +1935,8 @@ static int imx_csi_async_register(struct csi_priv *priv)
>  					     port, 0,
>  					     FWNODE_GRAPH_ENDPOINT_NEXT);
>  	if (ep) {
> -		asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -			&priv->notifier, ep, struct v4l2_async_subdev);
> +		asd = v4l2_async_nf_add_fwnode_remote(&priv->notifier, ep,
> +						      struct v4l2_async_subdev);
>  
>  		fwnode_handle_put(ep);
>  
> @@ -1950,8 +1950,7 @@ static int imx_csi_async_register(struct csi_priv *priv)
>  
>  	priv->notifier.ops = &csi_notify_ops;
>  
> -	ret = v4l2_async_subdev_notifier_register(&priv->sd,
> -						  &priv->notifier);
> +	ret = v4l2_async_subdev_nf_register(&priv->sd, &priv->notifier);
>  	if (ret)
>  		return ret;
>  
> @@ -2040,8 +2039,8 @@ static int imx_csi_probe(struct platform_device *pdev)
>  	return 0;
>  
>  cleanup:
> -	v4l2_async_notifier_unregister(&priv->notifier);
> -	v4l2_async_notifier_cleanup(&priv->notifier);
> +	v4l2_async_nf_unregister(&priv->notifier);
> +	v4l2_async_nf_cleanup(&priv->notifier);
>  free:
>  	v4l2_ctrl_handler_free(&priv->ctrl_hdlr);
>  	mutex_destroy(&priv->lock);
> @@ -2055,8 +2054,8 @@ static int imx_csi_remove(struct platform_device *pdev)
>  
>  	v4l2_ctrl_handler_free(&priv->ctrl_hdlr);
>  	mutex_destroy(&priv->lock);
> -	v4l2_async_notifier_unregister(&priv->notifier);
> -	v4l2_async_notifier_cleanup(&priv->notifier);
> +	v4l2_async_nf_unregister(&priv->notifier);
> +	v4l2_async_nf_cleanup(&priv->notifier);
>  	v4l2_async_unregister_subdev(sd);
>  	media_entity_cleanup(&sd->entity);
>  
> diff --git a/drivers/staging/media/imx/imx-media-dev-common.c b/drivers/staging/media/imx/imx-media-dev-common.c
> index 4d873726a461b..80b69a9a752cb 100644
> --- a/drivers/staging/media/imx/imx-media-dev-common.c
> +++ b/drivers/staging/media/imx/imx-media-dev-common.c
> @@ -381,7 +381,7 @@ struct imx_media_dev *imx_media_dev_init(struct device *dev,
>  
>  	INIT_LIST_HEAD(&imxmd->vdev_list);
>  
> -	v4l2_async_notifier_init(&imxmd->notifier);
> +	v4l2_async_nf_init(&imxmd->notifier);
>  
>  	return imxmd;
>  
> @@ -405,11 +405,10 @@ int imx_media_dev_notifier_register(struct imx_media_dev *imxmd,
>  
>  	/* prepare the async subdev notifier and register it */
>  	imxmd->notifier.ops = ops ? ops : &imx_media_notifier_ops;
> -	ret = v4l2_async_notifier_register(&imxmd->v4l2_dev,
> -					   &imxmd->notifier);
> +	ret = v4l2_async_nf_register(&imxmd->v4l2_dev, &imxmd->notifier);
>  	if (ret) {
>  		v4l2_err(&imxmd->v4l2_dev,
> -			 "v4l2_async_notifier_register failed with %d\n", ret);
> +			 "v4l2_async_nf_register failed with %d\n", ret);
>  		return ret;
>  	}
>  
> diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
> index 338b8bd0bb076..f85462214e221 100644
> --- a/drivers/staging/media/imx/imx-media-dev.c
> +++ b/drivers/staging/media/imx/imx-media-dev.c
> @@ -94,7 +94,7 @@ static int imx_media_probe(struct platform_device *pdev)
>  	return 0;
>  
>  cleanup:
> -	v4l2_async_notifier_cleanup(&imxmd->notifier);
> +	v4l2_async_nf_cleanup(&imxmd->notifier);
>  	v4l2_device_unregister(&imxmd->v4l2_dev);
>  	media_device_cleanup(&imxmd->md);
>  
> @@ -113,9 +113,9 @@ static int imx_media_remove(struct platform_device *pdev)
>  		imxmd->m2m_vdev = NULL;
>  	}
>  
> -	v4l2_async_notifier_unregister(&imxmd->notifier);
> +	v4l2_async_nf_unregister(&imxmd->notifier);
>  	imx_media_unregister_ipu_internal_subdevs(imxmd);
> -	v4l2_async_notifier_cleanup(&imxmd->notifier);
> +	v4l2_async_nf_cleanup(&imxmd->notifier);
>  	media_device_unregister(&imxmd->md);
>  	v4l2_device_unregister(&imxmd->v4l2_dev);
>  	media_device_cleanup(&imxmd->md);
> diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
> index b677cf0e0c849..59f1eb7b62bcd 100644
> --- a/drivers/staging/media/imx/imx-media-of.c
> +++ b/drivers/staging/media/imx/imx-media-of.c
> @@ -29,9 +29,9 @@ int imx_media_of_add_csi(struct imx_media_dev *imxmd,
>  	}
>  
>  	/* add CSI fwnode to async notifier */
> -	asd = v4l2_async_notifier_add_fwnode_subdev(&imxmd->notifier,
> -						    of_fwnode_handle(csi_np),
> -						    struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode(&imxmd->notifier,
> +				       of_fwnode_handle(csi_np),
> +				       struct v4l2_async_subdev);
>  	if (IS_ERR(asd)) {
>  		ret = PTR_ERR(asd);
>  		if (ret == -EEXIST)
> diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
> index 9de0ebd439dc6..a0941fc2907b7 100644
> --- a/drivers/staging/media/imx/imx6-mipi-csi2.c
> +++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
> @@ -647,7 +647,7 @@ static int csi2_async_register(struct csi2_dev *csi2)
>  	struct fwnode_handle *ep;
>  	int ret;
>  
> -	v4l2_async_notifier_init(&csi2->notifier);
> +	v4l2_async_nf_init(&csi2->notifier);
>  
>  	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(csi2->dev), 0, 0,
>  					     FWNODE_GRAPH_ENDPOINT_NEXT);
> @@ -663,8 +663,8 @@ static int csi2_async_register(struct csi2_dev *csi2)
>  	dev_dbg(csi2->dev, "data lanes: %d\n", vep.bus.mipi_csi2.num_data_lanes);
>  	dev_dbg(csi2->dev, "flags: 0x%08x\n", vep.bus.mipi_csi2.flags);
>  
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -		&csi2->notifier, ep, struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode_remote(&csi2->notifier, ep,
> +					      struct v4l2_async_subdev);
>  	fwnode_handle_put(ep);
>  
>  	if (IS_ERR(asd))
> @@ -672,8 +672,7 @@ static int csi2_async_register(struct csi2_dev *csi2)
>  
>  	csi2->notifier.ops = &csi2_notify_ops;
>  
> -	ret = v4l2_async_subdev_notifier_register(&csi2->sd,
> -						  &csi2->notifier);
> +	ret = v4l2_async_subdev_nf_register(&csi2->sd, &csi2->notifier);
>  	if (ret)
>  		return ret;
>  
> @@ -768,8 +767,8 @@ static int csi2_probe(struct platform_device *pdev)
>  	return 0;
>  
>  clean_notifier:
> -	v4l2_async_notifier_unregister(&csi2->notifier);
> -	v4l2_async_notifier_cleanup(&csi2->notifier);
> +	v4l2_async_nf_unregister(&csi2->notifier);
> +	v4l2_async_nf_cleanup(&csi2->notifier);
>  	clk_disable_unprepare(csi2->dphy_clk);
>  pllref_off:
>  	clk_disable_unprepare(csi2->pllref_clk);
> @@ -783,8 +782,8 @@ static int csi2_remove(struct platform_device *pdev)
>  	struct v4l2_subdev *sd = platform_get_drvdata(pdev);
>  	struct csi2_dev *csi2 = sd_to_dev(sd);
>  
> -	v4l2_async_notifier_unregister(&csi2->notifier);
> -	v4l2_async_notifier_cleanup(&csi2->notifier);
> +	v4l2_async_nf_unregister(&csi2->notifier);
> +	v4l2_async_nf_cleanup(&csi2->notifier);
>  	v4l2_async_unregister_subdev(sd);
>  	clk_disable_unprepare(csi2->dphy_clk);
>  	clk_disable_unprepare(csi2->pllref_clk);
> diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> index 1271837329124..2288dadb2683a 100644
> --- a/drivers/staging/media/imx/imx7-media-csi.c
> +++ b/drivers/staging/media/imx/imx7-media-csi.c
> @@ -1099,13 +1099,13 @@ static int imx7_csi_async_register(struct imx7_csi *csi)
>  	struct fwnode_handle *ep;
>  	int ret;
>  
> -	v4l2_async_notifier_init(&csi->notifier);
> +	v4l2_async_nf_init(&csi->notifier);
>  
>  	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(csi->dev), 0, 0,
>  					     FWNODE_GRAPH_ENDPOINT_NEXT);
>  	if (ep) {
> -		asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -			&csi->notifier, ep, struct v4l2_async_subdev);
> +		asd = v4l2_async_nf_add_fwnode_remote(&csi->notifier, ep,
> +						      struct v4l2_async_subdev);
>  
>  		fwnode_handle_put(ep);
>  
> @@ -1119,7 +1119,7 @@ static int imx7_csi_async_register(struct imx7_csi *csi)
>  
>  	csi->notifier.ops = &imx7_csi_notify_ops;
>  
> -	ret = v4l2_async_subdev_notifier_register(&csi->sd, &csi->notifier);
> +	ret = v4l2_async_subdev_nf_register(&csi->sd, &csi->notifier);
>  	if (ret)
>  		return ret;
>  
> @@ -1210,12 +1210,12 @@ static int imx7_csi_probe(struct platform_device *pdev)
>  	return 0;
>  
>  subdev_notifier_cleanup:
> -	v4l2_async_notifier_unregister(&csi->notifier);
> -	v4l2_async_notifier_cleanup(&csi->notifier);
> +	v4l2_async_nf_unregister(&csi->notifier);
> +	v4l2_async_nf_cleanup(&csi->notifier);
>  
>  cleanup:
> -	v4l2_async_notifier_unregister(&imxmd->notifier);
> -	v4l2_async_notifier_cleanup(&imxmd->notifier);
> +	v4l2_async_nf_unregister(&imxmd->notifier);
> +	v4l2_async_nf_cleanup(&imxmd->notifier);
>  	v4l2_device_unregister(&imxmd->v4l2_dev);
>  	media_device_unregister(&imxmd->md);
>  	media_device_cleanup(&imxmd->md);
> @@ -1232,15 +1232,15 @@ static int imx7_csi_remove(struct platform_device *pdev)
>  	struct imx7_csi *csi = v4l2_get_subdevdata(sd);
>  	struct imx_media_dev *imxmd = csi->imxmd;
>  
> -	v4l2_async_notifier_unregister(&imxmd->notifier);
> -	v4l2_async_notifier_cleanup(&imxmd->notifier);
> +	v4l2_async_nf_unregister(&imxmd->notifier);
> +	v4l2_async_nf_cleanup(&imxmd->notifier);
>  
>  	media_device_unregister(&imxmd->md);
>  	v4l2_device_unregister(&imxmd->v4l2_dev);
>  	media_device_cleanup(&imxmd->md);
>  
> -	v4l2_async_notifier_unregister(&csi->notifier);
> -	v4l2_async_notifier_cleanup(&csi->notifier);
> +	v4l2_async_nf_unregister(&csi->notifier);
> +	v4l2_async_nf_cleanup(&csi->notifier);
>  	v4l2_async_unregister_subdev(sd);
>  
>  	mutex_destroy(&csi->lock);
> diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
> index d35e523741168..9ea723bb5f209 100644
> --- a/drivers/staging/media/imx/imx7-mipi-csis.c
> +++ b/drivers/staging/media/imx/imx7-mipi-csis.c
> @@ -1160,7 +1160,7 @@ static int mipi_csis_async_register(struct csi_state *state)
>  	unsigned int i;
>  	int ret;
>  
> -	v4l2_async_notifier_init(&state->notifier);
> +	v4l2_async_nf_init(&state->notifier);
>  
>  	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(state->dev), 0, 0,
>  					     FWNODE_GRAPH_ENDPOINT_NEXT);
> @@ -1185,8 +1185,8 @@ static int mipi_csis_async_register(struct csi_state *state)
>  	dev_dbg(state->dev, "data lanes: %d\n", state->bus.num_data_lanes);
>  	dev_dbg(state->dev, "flags: 0x%08x\n", state->bus.flags);
>  
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(
> -		&state->notifier, ep, struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode_remote(&state->notifier, ep,
> +					      struct v4l2_async_subdev);
>  	if (IS_ERR(asd)) {
>  		ret = PTR_ERR(asd);
>  		goto err_parse;
> @@ -1196,7 +1196,7 @@ static int mipi_csis_async_register(struct csi_state *state)
>  
>  	state->notifier.ops = &mipi_csis_notify_ops;
>  
> -	ret = v4l2_async_subdev_notifier_register(&state->sd, &state->notifier);
> +	ret = v4l2_async_subdev_nf_register(&state->sd, &state->notifier);
>  	if (ret)
>  		return ret;
>  
> @@ -1427,8 +1427,8 @@ static int mipi_csis_probe(struct platform_device *pdev)
>  	mipi_csis_debugfs_exit(state);
>  cleanup:
>  	media_entity_cleanup(&state->sd.entity);
> -	v4l2_async_notifier_unregister(&state->notifier);
> -	v4l2_async_notifier_cleanup(&state->notifier);
> +	v4l2_async_nf_unregister(&state->notifier);
> +	v4l2_async_nf_cleanup(&state->notifier);
>  	v4l2_async_unregister_subdev(&state->sd);
>  disable_clock:
>  	mipi_csis_clk_disable(state);
> @@ -1443,8 +1443,8 @@ static int mipi_csis_remove(struct platform_device *pdev)
>  	struct csi_state *state = mipi_sd_to_csis_state(sd);
>  
>  	mipi_csis_debugfs_exit(state);
> -	v4l2_async_notifier_unregister(&state->notifier);
> -	v4l2_async_notifier_cleanup(&state->notifier);
> +	v4l2_async_nf_unregister(&state->notifier);
> +	v4l2_async_nf_cleanup(&state->notifier);
>  	v4l2_async_unregister_subdev(&state->sd);
>  
>  	pm_runtime_disable(&pdev->dev);
> diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> index 1d28313dbed7d..3b9fa75efac6b 100644
> --- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> +++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> @@ -640,7 +640,7 @@ static int imx8mq_mipi_csi_async_register(struct csi_state *state)
>  	unsigned int i;
>  	int ret;
>  
> -	v4l2_async_notifier_init(&state->notifier);
> +	v4l2_async_nf_init(&state->notifier);
>  
>  	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(state->dev), 0, 0,
>  					     FWNODE_GRAPH_ENDPOINT_NEXT);
> @@ -666,8 +666,8 @@ static int imx8mq_mipi_csi_async_register(struct csi_state *state)
>  		state->bus.num_data_lanes,
>  		state->bus.flags);
>  
> -	asd = v4l2_async_notifier_add_fwnode_remote_subdev(&state->notifier,
> -							   ep, struct v4l2_async_subdev);
> +	asd = v4l2_async_nf_add_fwnode_remote(&state->notifier, ep,
> +					      struct v4l2_async_subdev);
>  	if (IS_ERR(asd)) {
>  		ret = PTR_ERR(asd);
>  		goto err_parse;
> @@ -677,7 +677,7 @@ static int imx8mq_mipi_csi_async_register(struct csi_state *state)
>  
>  	state->notifier.ops = &imx8mq_mipi_csi_notify_ops;
>  
> -	ret = v4l2_async_subdev_notifier_register(&state->sd, &state->notifier);
> +	ret = v4l2_async_subdev_nf_register(&state->sd, &state->notifier);
>  	if (ret)
>  		return ret;
>  
> @@ -957,8 +957,8 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
>  	imx8mq_mipi_csi_runtime_suspend(&pdev->dev);
>  
>  	media_entity_cleanup(&state->sd.entity);
> -	v4l2_async_notifier_unregister(&state->notifier);
> -	v4l2_async_notifier_cleanup(&state->notifier);
> +	v4l2_async_nf_unregister(&state->notifier);
> +	v4l2_async_nf_cleanup(&state->notifier);
>  	v4l2_async_unregister_subdev(&state->sd);
>  icc:
>  	imx8mq_mipi_csi_release_icc(pdev);
> @@ -973,8 +973,8 @@ static int imx8mq_mipi_csi_remove(struct platform_device *pdev)
>  	struct v4l2_subdev *sd = platform_get_drvdata(pdev);
>  	struct csi_state *state = mipi_sd_to_csi2_state(sd);
>  
> -	v4l2_async_notifier_unregister(&state->notifier);
> -	v4l2_async_notifier_cleanup(&state->notifier);
> +	v4l2_async_nf_unregister(&state->notifier);
> +	v4l2_async_nf_cleanup(&state->notifier);
>  	v4l2_async_unregister_subdev(&state->sd);
>  
>  	pm_runtime_disable(&pdev->dev);
> diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
> index d321790b07d95..69d9787d53384 100644
> --- a/drivers/staging/media/tegra-video/vi.c
> +++ b/drivers/staging/media/tegra-video/vi.c
> @@ -1272,7 +1272,7 @@ static int tegra_channel_init(struct tegra_vi_channel *chan)
>  	}
>  
>  	if (!IS_ENABLED(CONFIG_VIDEO_TEGRA_TPG))
> -		v4l2_async_notifier_init(&chan->notifier);
> +		v4l2_async_nf_init(&chan->notifier);
>  
>  	return 0;
>  
> @@ -1811,8 +1811,8 @@ static int tegra_vi_graph_parse_one(struct tegra_vi_channel *chan,
>  			continue;
>  		}
>  
> -		tvge = v4l2_async_notifier_add_fwnode_subdev(&chan->notifier, remote,
> -							     struct tegra_vi_graph_entity);
> +		tvge = v4l2_async_nf_add_fwnode(&chan->notifier, remote,
> +						struct tegra_vi_graph_entity);
>  		if (IS_ERR(tvge)) {
>  			ret = PTR_ERR(tvge);
>  			dev_err(vi->dev,
> @@ -1834,7 +1834,7 @@ static int tegra_vi_graph_parse_one(struct tegra_vi_channel *chan,
>  
>  cleanup:
>  	dev_err(vi->dev, "failed parsing the graph: %d\n", ret);
> -	v4l2_async_notifier_cleanup(&chan->notifier);
> +	v4l2_async_nf_cleanup(&chan->notifier);
>  	of_node_put(node);
>  	return ret;
>  }
> @@ -1868,13 +1868,12 @@ static int tegra_vi_graph_init(struct tegra_vi *vi)
>  			continue;
>  
>  		chan->notifier.ops = &tegra_vi_async_ops;
> -		ret = v4l2_async_notifier_register(&vid->v4l2_dev,
> -						   &chan->notifier);
> +		ret = v4l2_async_nf_register(&vid->v4l2_dev, &chan->notifier);
>  		if (ret < 0) {
>  			dev_err(vi->dev,
>  				"failed to register channel %d notifier: %d\n",
>  				chan->portnos[0], ret);
> -			v4l2_async_notifier_cleanup(&chan->notifier);
> +			v4l2_async_nf_cleanup(&chan->notifier);
>  		}
>  	}
>  
> @@ -1887,8 +1886,8 @@ static void tegra_vi_graph_cleanup(struct tegra_vi *vi)
>  
>  	list_for_each_entry(chan, &vi->vi_chans, list) {
>  		vb2_video_unregister_device(&chan->video);
> -		v4l2_async_notifier_unregister(&chan->notifier);
> -		v4l2_async_notifier_cleanup(&chan->notifier);
> +		v4l2_async_nf_unregister(&chan->notifier);
> +		v4l2_async_nf_cleanup(&chan->notifier);
>  	}
>  }
>  
> diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
> index fa4901162663b..13ff3ad948f43 100644
> --- a/include/media/v4l2-async.h
> +++ b/include/media/v4l2-async.h
> @@ -123,45 +123,45 @@ struct v4l2_async_notifier {
>  void v4l2_async_debug_init(struct dentry *debugfs_dir);
>  
>  /**
> - * v4l2_async_notifier_init - Initialize a notifier.
> + * v4l2_async_nf_init - Initialize a notifier.
>   *
>   * @notifier: pointer to &struct v4l2_async_notifier
>   *
>   * This function initializes the notifier @asd_list. It must be called
>   * before adding a subdevice to a notifier, using one of:
> - * v4l2_async_notifier_add_fwnode_remote_subdev(),
> - * v4l2_async_notifier_add_fwnode_subdev(),
> - * v4l2_async_notifier_add_i2c_subdev(),
> - * __v4l2_async_notifier_add_subdev() or
> - * v4l2_async_notifier_parse_fwnode_endpoints().
> + * v4l2_async_nf_add_fwnode_remote(),
> + * v4l2_async_nf_add_fwnode(),
> + * v4l2_async_nf_add_i2c(),
> + * __v4l2_async_nf_add_subdev() or
> + * v4l2_async_nf_parse_fwnode_endpoints().
>   */
> -void v4l2_async_notifier_init(struct v4l2_async_notifier *notifier);
> +void v4l2_async_nf_init(struct v4l2_async_notifier *notifier);
>  
>  /**
> - * __v4l2_async_notifier_add_subdev - Add an async subdev to the
> + * __v4l2_async_nf_add_subdev - Add an async subdev to the
>   *				notifier's master asd list.
>   *
>   * @notifier: pointer to &struct v4l2_async_notifier
>   * @asd: pointer to &struct v4l2_async_subdev
>   *
>   * \warning: Drivers should avoid using this function and instead use one of:
> - * v4l2_async_notifier_add_fwnode_subdev(),
> - * v4l2_async_notifier_add_fwnode_remote_subdev() or
> - * v4l2_async_notifier_add_i2c_subdev().
> + * v4l2_async_nf_add_fwnode(),
> + * v4l2_async_nf_add_fwnode_remote() or
> + * v4l2_async_nf_add_i2c().
>   *
>   * Call this function before registering a notifier to link the provided @asd to
>   * the notifiers master @asd_list. The @asd must be allocated with k*alloc() as
>   * it will be freed by the framework when the notifier is destroyed.
>   */
> -int __v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
> -				   struct v4l2_async_subdev *asd);
> +int __v4l2_async_nf_add_subdev(struct v4l2_async_notifier *notifier,
> +			       struct v4l2_async_subdev *asd);
>  
>  struct v4l2_async_subdev *
> -__v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
> -					struct fwnode_handle *fwnode,
> -					unsigned int asd_struct_size);
> +__v4l2_async_nf_add_fwnode(struct v4l2_async_notifier *notifier,
> +			   struct fwnode_handle *fwnode,
> +			   unsigned int asd_struct_size);
>  /**
> - * v4l2_async_notifier_add_fwnode_subdev - Allocate and add a fwnode async
> + * v4l2_async_nf_add_fwnode - Allocate and add a fwnode async
>   *				subdev to the notifier's master asd_list.
>   *
>   * @notifier: pointer to &struct v4l2_async_notifier
> @@ -175,16 +175,15 @@ __v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
>   * notifiers @asd_list. The function also gets a reference of the fwnode which
>   * is released later at notifier cleanup time.
>   */
> -#define v4l2_async_notifier_add_fwnode_subdev(notifier, fwnode, type)	\
> -	((type *)__v4l2_async_notifier_add_fwnode_subdev(notifier, fwnode, \
> -							   sizeof(type)))
> +#define v4l2_async_nf_add_fwnode(notifier, fwnode, type)		\
> +	((type *)__v4l2_async_nf_add_fwnode(notifier, fwnode, sizeof(type)))
>  
>  struct v4l2_async_subdev *
> -__v4l2_async_notifier_add_fwnode_remote_subdev(struct v4l2_async_notifier *notif,
> -					       struct fwnode_handle *endpoint,
> -					       unsigned int asd_struct_size);
> +__v4l2_async_nf_add_fwnode_remote(struct v4l2_async_notifier *notif,
> +				  struct fwnode_handle *endpoint,
> +				  unsigned int asd_struct_size);
>  /**
> - * v4l2_async_notifier_add_fwnode_remote_subdev - Allocate and add a fwnode
> + * v4l2_async_nf_add_fwnode_remote - Allocate and add a fwnode
>   *						  remote async subdev to the
>   *						  notifier's master asd_list.
>   *
> @@ -200,20 +199,18 @@ __v4l2_async_notifier_add_fwnode_remote_subdev(struct v4l2_async_notifier *notif
>   * function also gets a reference of the fwnode which is released later at
>   * notifier cleanup time.
>   *
> - * This is just like v4l2_async_notifier_add_fwnode_subdev(), but with the
> + * This is just like v4l2_async_nf_add_fwnode(), but with the
>   * exception that the fwnode refers to a local endpoint, not the remote one.
>   */
> -#define v4l2_async_notifier_add_fwnode_remote_subdev(notifier, ep, type) \
> -	((type *)							\
> -	 __v4l2_async_notifier_add_fwnode_remote_subdev(notifier, ep,	\
> -							sizeof(type)))
> +#define v4l2_async_nf_add_fwnode_remote(notifier, ep, type) \
> +	((type *)__v4l2_async_nf_add_fwnode_remote(notifier, ep, sizeof(type)))
>  
>  struct v4l2_async_subdev *
> -__v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
> -				     int adapter_id, unsigned short address,
> -				     unsigned int asd_struct_size);
> +__v4l2_async_nf_add_i2c(struct v4l2_async_notifier *notifier,
> +			int adapter_id, unsigned short address,
> +			unsigned int asd_struct_size);
>  /**
> - * v4l2_async_notifier_add_i2c_subdev - Allocate and add an i2c async
> + * v4l2_async_nf_add_i2c - Allocate and add an i2c async
>   *				subdev to the notifier's master asd_list.
>   *
>   * @notifier: pointer to &struct v4l2_async_notifier
> @@ -223,59 +220,59 @@ __v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
>   *	  v4l2_async_subdev shall be the first member of the driver's async
>   *	  sub-device struct, i.e. both begin at the same memory address.
>   *
> - * Same as v4l2_async_notifier_add_fwnode_subdev() but for I2C matched
> + * Same as v4l2_async_nf_add_fwnode() but for I2C matched
>   * sub-devices.
>   */
> -#define v4l2_async_notifier_add_i2c_subdev(notifier, adapter, address, type) \
> -	((type *)__v4l2_async_notifier_add_i2c_subdev(notifier, adapter, \
> -						      address, sizeof(type)))
> +#define v4l2_async_nf_add_i2c(notifier, adapter, address, type) \
> +	((type *)__v4l2_async_nf_add_i2c(notifier, adapter, address, \
> +					 sizeof(type)))
>  
>  /**
> - * v4l2_async_notifier_register - registers a subdevice asynchronous notifier
> + * v4l2_async_nf_register - registers a subdevice asynchronous notifier
>   *
>   * @v4l2_dev: pointer to &struct v4l2_device
>   * @notifier: pointer to &struct v4l2_async_notifier
>   */
> -int v4l2_async_notifier_register(struct v4l2_device *v4l2_dev,
> -				 struct v4l2_async_notifier *notifier);
> +int v4l2_async_nf_register(struct v4l2_device *v4l2_dev,
> +			   struct v4l2_async_notifier *notifier);
>  
>  /**
> - * v4l2_async_subdev_notifier_register - registers a subdevice asynchronous
> + * v4l2_async_subdev_nf_register - registers a subdevice asynchronous
>   *					 notifier for a sub-device
>   *
>   * @sd: pointer to &struct v4l2_subdev
>   * @notifier: pointer to &struct v4l2_async_notifier
>   */
> -int v4l2_async_subdev_notifier_register(struct v4l2_subdev *sd,
> -					struct v4l2_async_notifier *notifier);
> +int v4l2_async_subdev_nf_register(struct v4l2_subdev *sd,
> +				  struct v4l2_async_notifier *notifier);
>  
>  /**
> - * v4l2_async_notifier_unregister - unregisters a subdevice
> + * v4l2_async_nf_unregister - unregisters a subdevice
>   *	asynchronous notifier
>   *
>   * @notifier: pointer to &struct v4l2_async_notifier
>   */
> -void v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier);
> +void v4l2_async_nf_unregister(struct v4l2_async_notifier *notifier);
>  
>  /**
> - * v4l2_async_notifier_cleanup - clean up notifier resources
> + * v4l2_async_nf_cleanup - clean up notifier resources
>   * @notifier: the notifier the resources of which are to be cleaned up
>   *
>   * Release memory resources related to a notifier, including the async
>   * sub-devices allocated for the purposes of the notifier but not the notifier
>   * itself. The user is responsible for calling this function to clean up the
>   * notifier after calling
> - * v4l2_async_notifier_add_fwnode_remote_subdev(),
> - * v4l2_async_notifier_add_fwnode_subdev(),
> - * v4l2_async_notifier_add_i2c_subdev(),
> - * __v4l2_async_notifier_add_subdev() or
> - * v4l2_async_notifier_parse_fwnode_endpoints().
> + * v4l2_async_nf_add_fwnode_remote(),
> + * v4l2_async_nf_add_fwnode(),
> + * v4l2_async_nf_add_i2c(),
> + * __v4l2_async_nf_add_subdev() or
> + * v4l2_async_nf_parse_fwnode_endpoints().
>   *
> - * There is no harm from calling v4l2_async_notifier_cleanup() in other
> + * There is no harm from calling v4l2_async_nf_cleanup() in other
>   * cases as long as its memory has been zeroed after it has been
>   * allocated.
>   */
> -void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier);
> +void v4l2_async_nf_cleanup(struct v4l2_async_notifier *notifier);
>  
>  /**
>   * v4l2_async_register_subdev - registers a sub-device to the asynchronous
> @@ -295,7 +292,7 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd);
>   *
>   * This function is just like v4l2_async_register_subdev() with the exception
>   * that calling it will also parse firmware interfaces for remote references
> - * using v4l2_async_notifier_parse_fwnode_sensor() and registers the
> + * using v4l2_async_nf_parse_fwnode_sensor() and registers the
>   * async sub-devices. The sub-device is similarly unregistered by calling
>   * v4l2_async_unregister_subdev().
>   *
> diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
> index 7ab033b819eb0..9c97f1dbd1c68 100644
> --- a/include/media/v4l2-fwnode.h
> +++ b/include/media/v4l2-fwnode.h
> @@ -463,7 +463,7 @@ typedef int (*parse_endpoint_func)(struct device *dev,
>  				  struct v4l2_async_subdev *asd);
>  
>  /**
> - * v4l2_async_notifier_parse_fwnode_endpoints - Parse V4L2 fwnode endpoints in a
> + * v4l2_async_nf_parse_fwnode_endpoints - Parse V4L2 fwnode endpoints in a
>   *						device node
>   * @dev: the device the endpoints of which are to be parsed
>   * @notifier: notifier for @dev
> @@ -496,7 +496,7 @@ typedef int (*parse_endpoint_func)(struct device *dev,
>   * to retain that configuration, the user needs to allocate memory for it.
>   *
>   * Any notifier populated using this function must be released with a call to
> - * v4l2_async_notifier_cleanup() after it has been unregistered and the async
> + * v4l2_async_nf_cleanup() after it has been unregistered and the async
>   * sub-devices are no longer in use, even if the function returned an error.
>   *
>   * Return: %0 on success, including when no async sub-devices are found
> @@ -505,10 +505,10 @@ typedef int (*parse_endpoint_func)(struct device *dev,
>   *	   Other error codes as returned by @parse_endpoint
>   */
>  int
> -v4l2_async_notifier_parse_fwnode_endpoints(struct device *dev,
> -					   struct v4l2_async_notifier *notifier,
> -					   size_t asd_struct_size,
> -					   parse_endpoint_func parse_endpoint);
> +v4l2_async_nf_parse_fwnode_endpoints(struct device *dev,
> +				     struct v4l2_async_notifier *notifier,
> +				     size_t asd_struct_size,
> +				     parse_endpoint_func parse_endpoint);
>  
>  /* Helper macros to access the connector links. */
>  

-- 
Regards,

Sakari Ailus
