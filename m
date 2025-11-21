Return-Path: <stable+bounces-196045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4734C79BC4
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBC40380EB2
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D834E753;
	Fri, 21 Nov 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edBjU6ro"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336D3A291;
	Fri, 21 Nov 2025 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732402; cv=none; b=BO2LFxemsBfy4NLpG+WnsfkDuExS9PXr6rEtsjTWYaUJAhrG+PH7sK5IDtp0hu+SmatAEpR6+uzl8UMD3Pn2ghhn/1dsp2Y96PUzkMv/6hW6GgWOUnJN/YWFJHl66etZ87uLLOilVwwRTcFmvNFP4UBJqOsovjhgw+Nts/UToNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732402; c=relaxed/simple;
	bh=1igbDvimbF9tgis2I0LSgq4dbN1uIkr9O0rPMLxs+4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvMxufNoov0aaLm9uTC66CV4PLPaJwCMQy+WLCPnzE+Wh8fqGxhNaPfLMQBY/ftkovAyGw9JDHFHhod6oVr36ktYnuQkjnQLImi02fIA99E/iKyfWUjG0SCdIdnL/a2mLUZjfzWVovicyPeYKt7i9lWEaMpnzZKpUrsnE1pj2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edBjU6ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D4BC4CEF1;
	Fri, 21 Nov 2025 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763732402;
	bh=1igbDvimbF9tgis2I0LSgq4dbN1uIkr9O0rPMLxs+4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=edBjU6rorFMUp6iu3/xLWc1A3U5xw17X6YV7BVIFDiPpS2bCcsAtfHTx4e3vDWgI1
	 NPYRqMX/g1F0G+S96J3skxpNfXKAuJ0JVM2RwqxWdhqqQ7b2tS6xC/2Pm9lwcS5JZE
	 QZEKCIvC1whbDhFxekTWzd3PRupxcygpckp44nzwV3AijfIMxubJBVhkbEsAq/Nxu6
	 G4gzk8avvqbEwljgvVQjNdenQjZ/Y3oObg3dnlDPpTv59hWdYAgJHy//LhmUtWYath
	 Vxi2ropm2GQRmhfSSGBbcM+/pzKvKn/GyxOmsh4ssEFvaPJjYlVkCVGlODqUNfKSNo
	 s2PDJW4FXpgkA==
Message-ID: <58fdb603-6d42-443d-8ae6-57aced9eb104@kernel.org>
Date: Fri, 21 Nov 2025 14:39:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: intel: chtwc_int33fe: don't dereference
 swnode args
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20251121-int33fe-swnode-fix-v1-1-713e7b7c6046@linaro.org>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20251121-int33fe-swnode-fix-v1-1-713e7b7c6046@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 21-Nov-25 11:04 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Members of struct software_node_ref_args should not be dereferenced
> directly but set using the provided macros. Commit d7cdbbc93c56
> ("software node: allow referencing firmware nodes") changed the name of
> the software node member and caused a build failure. Remove all direct
> dereferences of the ref struct as a fix.
> 
> However, this driver also seems to abuse the software node interface by
> waiting for a node with an arbitrary name "intel-xhci-usb-sw" to appear
> in the system before setting up the reference for the I2C device, while
> the actual software node already exists in the intel-xhci-usb-role-switch
> module and should be used to set up a static reference. Add a FIXME for
> a future improvement.
> 
> Fixes: d7cdbbc93c56 ("software node: allow referencing firmware nodes")
> Fixes: 53c24c2932e5 ("platform/x86: intel_cht_int33fe: use inline reference properties")
> Cc: stable@vger.kernel.org
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20251121111534.7cdbfe5c@canb.auug.org.au/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> This should go into the reset tree as a fix to the regression introduced
> by the reset-gpio driver rework.

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Also ack for merging this through the reset tree.

Ilpo please do *not* pick this one up as it will be merged
through the reset tree.

Regards,

Hans




> ---
>  drivers/platform/x86/intel/chtwc_int33fe.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
> index 29e8b5432f4c9eea7dc45b83d94c0e00373f901b..d183aa53c318ba8d57c7124c38506e6956b3ee36 100644
> --- a/drivers/platform/x86/intel/chtwc_int33fe.c
> +++ b/drivers/platform/x86/intel/chtwc_int33fe.c
> @@ -77,7 +77,7 @@ static const struct software_node max17047_node = {
>   * software node.
>   */
>  static struct software_node_ref_args fusb302_mux_refs[] = {
> -	{ .node = NULL },
> +	SOFTWARE_NODE_REFERENCE(NULL),
>  };
>  
>  static const struct property_entry fusb302_properties[] = {
> @@ -190,11 +190,6 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
>  {
>  	software_node_unregister_node_group(node_group);
>  
> -	if (fusb302_mux_refs[0].node) {
> -		fwnode_handle_put(software_node_fwnode(fusb302_mux_refs[0].node));
> -		fusb302_mux_refs[0].node = NULL;
> -	}
> -
>  	if (data->dp) {
>  		data->dp->secondary = NULL;
>  		fwnode_handle_put(data->dp);
> @@ -202,7 +197,15 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
>  	}
>  }
>  
> -static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
> +static void cht_int33fe_put_swnode(void *data)
> +{
> +	struct fwnode_handle *fwnode = data;
> +
> +	fwnode_handle_put(fwnode);
> +	fusb302_mux_refs[0] = SOFTWARE_NODE_REFERENCE(NULL);
> +}
> +
> +static int cht_int33fe_add_nodes(struct device *dev, struct cht_int33fe_data *data)
>  {
>  	const struct software_node *mux_ref_node;
>  	int ret;
> @@ -212,17 +215,25 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>  	 * until the mux driver has created software node for the mux device.
>  	 * It means we depend on the mux driver. This function will return
>  	 * -EPROBE_DEFER until the mux device is registered.
> +	 *
> +	 * FIXME: the relevant software node exists in intel-xhci-usb-role-switch
> +	 * and - if exported - could be used to set up a static reference.
>  	 */
>  	mux_ref_node = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
>  	if (!mux_ref_node)
>  		return -EPROBE_DEFER;
>  
> +	ret = devm_add_action_or_reset(dev, cht_int33fe_put_swnode,
> +				       software_node_fwnode(mux_ref_node));
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Update node used in "usb-role-switch" property. Note that we
>  	 * rely on software_node_register_node_group() to use the original
>  	 * instance of properties instead of copying them.
>  	 */
> -	fusb302_mux_refs[0].node = mux_ref_node;
> +	fusb302_mux_refs[0] = SOFTWARE_NODE_REFERENCE(mux_ref_node);
>  
>  	ret = software_node_register_node_group(node_group);
>  	if (ret)
> @@ -345,7 +356,7 @@ static int cht_int33fe_typec_probe(struct platform_device *pdev)
>  		return fusb302_irq;
>  	}
>  
> -	ret = cht_int33fe_add_nodes(data);
> +	ret = cht_int33fe_add_nodes(dev, data);
>  	if (ret)
>  		return ret;
>  
> 
> ---
> base-commit: cba510406ba76569782ead6007a0e4eb5d34a7ab
> change-id: 20251121-int33fe-swnode-fix-e896da458560
> 
> Best regards,


