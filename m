Return-Path: <stable+bounces-249620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNQRLN96DGoSiQUAu9opvQ
	(envelope-from <stable+bounces-249620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:59:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2045A58105E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B3B0305B995
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366732571D;
	Tue, 19 May 2026 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sidwTgeM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3423ABA8;
	Tue, 19 May 2026 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202780; cv=none; b=aW/6lyw4NnT/+kqEGexHPBGLdmsWW3l8E7a6QhTaTy7GKW1M8SeGcWabNbXpkiMcyzP9FxQ2mo8F7c1EIGO9jm/4LWnukd0UF41EX9TyEEJ8Qg5nyEnhMCdusVo+uqgZqu3m6GzNjfPL/PggMrKGW9zkxX3lXf2d3VyWeXOrhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202780; c=relaxed/simple;
	bh=flanUAL6j/XatzV13n8vGt5mXeXtWPKbp9m1bPEo+As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5rQ8qF3MVbQicStSg10ysovLg/yNLefHNhRU1Yl5T3WEsF58DgFX4m0CLCUCI8L879QqvkiRPRnSpLD6fwREbxvBWtfzyGhzpFXhI6jQuzum7S2HWie/EagS266S1cHWVRyzlXa4afoi95gCjrNaQRCtmYvbQIHikdtAbKmLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sidwTgeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7CEC2BCB3;
	Tue, 19 May 2026 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779202780;
	bh=flanUAL6j/XatzV13n8vGt5mXeXtWPKbp9m1bPEo+As=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sidwTgeMjTHkPzj3xmugqxTYjorDncQLXVtodiSirM16XpSdJ3fN5J/tzC1m1jiWW
	 dQKAeL2zqAg/DUVfb78cpbO6QKqdh3eE6/YnNwk49NNuuZ9deSgGbqBeD0JjoHr/U9
	 Ktv0xCmDCBJ1Sv9cnwNk5jIgxQ3jSL0J5UkQhljH0vrUkTqxQNYK1daAP+SkCX++Zt
	 Y8IfyPKf5POGdj+lEA2/Ci9V8uNU9dV5kCjqS6MqWSjASQ+SZ74a2X+Idoe2cZC/pq
	 +6ekHW6dfuGrJ3oBgY+YHK5Pt+vEiwAe1a6nrIrGoykP0pmnWjw7rxckO9cn2OD6Zg
	 M8VXBkLjJQpYg==
Message-ID: <a13529db-a85a-4cee-9269-17c0f8fc9781@kernel.org>
Date: Tue, 19 May 2026 15:59:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmem: layouts: Add fixed-layout driver
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com>
 <20260515-mathieu-nvmem-fixed-layout-v2-1-8ac215dd4016@bootlin.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260515-mathieu-nvmem-fixed-layout-v2-1-8ac215dd4016@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249620-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srini@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,essensium.com:email]
X-Rspamd-Queue-Id: 2045A58105E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/15/26 12:56 PM, Mathieu Dubois-Briand wrote:
> Current implementation isn't working well when device tree nodes have a
> phandle on a fixed-layout nvmem node. As the fixed layout is handled in
> nvmem core, no driver is ever associated with the layout, and the device
> consumer driver probe is deferred indefinitely.
> 
> Remove the specific handling of fixed-layout and add a layout driver.
> This makes the fixed-layout similar to all other layouts, fixing the
> whole issue.
> 
> Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  MAINTAINERS                          |  5 ++++
>  drivers/nvmem/core.c                 | 23 +---------------
>  drivers/nvmem/layouts.c              | 11 --------
>  drivers/nvmem/layouts/Makefile       |  1 +
>  drivers/nvmem/layouts/fixed-layout.c | 52 ++++++++++++++++++++++++++++++++++++
>  include/linux/nvmem-provider.h       |  7 +++++
>  6 files changed, 66 insertions(+), 33 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 882214b0e7db..c48c4e129736 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10018,6 +10018,11 @@ F:	drivers/base/firmware_loader/
>  F:	rust/kernel/firmware.rs
>  F:	include/linux/firmware.h
>  
> +FIXED-LAYOUT NVMEM LAYOUT DRIVER
> +M:	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> +S:	Maintained
> +F:	drivers/nvmem/layouts/fixed-layout.c
> +
>  FLEXTIMER FTM-QUADDEC DRIVER
>  M:	Patrick Havelange <patrick.havelange@essensium.com>
>  L:	linux-iio@vger.kernel.org
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 311cb2e5a5c0..0ec4924c4bda 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -786,7 +786,7 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
>  	return 0;
>  }
>  
> -static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
> +int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)

Export this in this patch itself.

>  {
>  	struct device *dev = &nvmem->dev;
>  	const __be32 *addr;
> @@ -840,23 +840,6 @@ static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
>  	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
>  }
>  
> -static int nvmem_add_cells_from_fixed_layout(struct nvmem_device *nvmem)
> -{
> -	struct device_node *layout_np;
> -	int err = 0;
> -
> -	layout_np = of_nvmem_layout_get_container(nvmem);
> -	if (!layout_np)
> -		return 0;
> -
> -	if (of_device_is_compatible(layout_np, "fixed-layout"))
> -		err = nvmem_add_cells_from_dt(nvmem, layout_np);
> -
> -	of_node_put(layout_np);
> -
> -	return err;
> -}
> -
>  int nvmem_layout_register(struct nvmem_layout *layout)
>  {
>  	int ret;
> @@ -1005,10 +988,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  			goto err_remove_cells;
>  	}
>  
> -	rval = nvmem_add_cells_from_fixed_layout(nvmem);
> -	if (rval)
> -		goto err_remove_cells;
> -
>  	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>  
>  	rval = device_add(&nvmem->dev);
> diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
> index b90584e1b99e..07a34be9669c 100644
> --- a/drivers/nvmem/layouts.c
> +++ b/drivers/nvmem/layouts.c
> @@ -125,11 +125,6 @@ static int nvmem_layout_create_device(struct nvmem_device *nvmem,
>  	return 0;
>  }
>  
> -static const struct of_device_id of_nvmem_layout_skip_table[] = {
> -	{ .compatible = "fixed-layout", },
> -	{}
> -};
> -
>  static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
>  				     struct device_node *layout_dn)
>  {
> @@ -142,12 +137,6 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
>  		return 0;
>  	}
>  
> -	/* Fixed layouts are parsed manually somewhere else for now */
> -	if (of_match_node(of_nvmem_layout_skip_table, layout_dn)) {
> -		pr_debug("%s() - skipping %pOF node\n", __func__, layout_dn);
> -		return 0;
> -	}
> -
>  	if (of_node_check_flag(layout_dn, OF_POPULATED_BUS)) {
>  		pr_debug("%s() - skipping %pOF, already populated\n",
>  			 __func__, layout_dn);
> diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
> index 4940c9db0665..dd6c6c70b1a9 100644
> --- a/drivers/nvmem/layouts/Makefile
> +++ b/drivers/nvmem/layouts/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for nvmem layouts.
>  #
>  
> +obj-$(CONFIG_NVMEM_LAYOUTS) += fixed-layout.o
>  obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
>  obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
>  obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
> diff --git a/drivers/nvmem/layouts/fixed-layout.c b/drivers/nvmem/layouts/fixed-layout.c
> new file mode 100644
> index 000000000000..bc7da9a904d4
> --- /dev/null
> +++ b/drivers/nvmem/layouts/fixed-layout.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2026 Bootlin
> + *
> + * Authors: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> + */
> +
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +
> +static int fixed_layout_add_cells(struct nvmem_layout *layout)
> +{
> +	struct device_node *np;
> +
> +	np = of_nvmem_layout_get_container(layout->nvmem);
> +	if (!np)
> +		return -ENOENT;
> +
> +	return nvmem_add_cells_from_dt(layout->nvmem, np);

np is leaking here.

> +}
> +
> +static int fixed_layout_probe(struct nvmem_layout *layout)
> +{
> +	layout->add_cells = fixed_layout_add_cells;
> +
> +	return nvmem_layout_register(layout);
> +}
> +
> +static void fixed_layout_remove(struct nvmem_layout *layout)
> +{
> +	nvmem_layout_unregister(layout);
> +}
> +
> +static const struct of_device_id fixed_layout_of_match_table[] = {
> +	{ .compatible = "fixed-layout", },
> +	{},
> +};
> +
> +static struct nvmem_layout_driver fixed_layout_layout = {
> +	.driver = {
> +		.name = "fixed-layout",
> +		.of_match_table = fixed_layout_of_match_table,
> +	},
> +	.probe = fixed_layout_probe,
> +	.remove = fixed_layout_remove,
> +};
> +module_nvmem_layout_driver(fixed_layout_layout);
> +
> +MODULE_AUTHOR("Mathieu Dubois-Briand");
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(of, fixed_layout_of_match_table);
> +MODULE_DESCRIPTION("NVMEM fixed-layout driver");
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index f3b13da78aac..e7eaa9a89b8b 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -176,6 +176,7 @@ int nvmem_add_one_cell(struct nvmem_device *nvmem,
>  
>  int nvmem_layout_register(struct nvmem_layout *layout);
>  void nvmem_layout_unregister(struct nvmem_layout *layout);
> +int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np);
>  
>  #define nvmem_layout_driver_register(drv) \
>  	__nvmem_layout_driver_register(drv, THIS_MODULE)
> @@ -214,6 +215,12 @@ static inline int nvmem_layout_register(struct nvmem_layout *layout)
>  
>  static inline void nvmem_layout_unregister(struct nvmem_layout *layout) {}
>  
> +static inline int nvmem_add_cells_from_dt(struct nvmem_device *nvmem,
> +					  struct device_node *np)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_NVMEM */
>  
>  #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
> 


