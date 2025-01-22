Return-Path: <stable+bounces-110170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7126CA192A8
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F4D162D35
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF991BC064;
	Wed, 22 Jan 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJpXlEyv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4641BDCF;
	Wed, 22 Jan 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552895; cv=none; b=aXEjfh9GfTFUCkrETBEvGsVS/7HTjO+wSE8Sd7O19r2k7nNbzcmz85q4V8ZrnMU6vuhqW4aTAznek1zyvwuBhv6HEY4JssztM440xuRERuZ4tAMXKOKQGcGctdPl6uuWWGN5GvgmKA+yp0zTyI6awRfF3Tps8NU+PfOz6ctttBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552895; c=relaxed/simple;
	bh=7DfnBrMHaBayCccsD/q52Q3ilgtaRdWdr/x3Gw0r2XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX8bkL2TgxUU9VzuoIJNX2ZzUaRVxAE98ihw8U61yj5G7d2/E80kZbnCiI9HrE45JarX/1cawh8p/oKskUNUJFjYZPMX+KyzhCShFuvo2Vm2Td45U/bYeSkQPrU3SEzrEZ35DA9lVwKbwHfyj7kEa7SdfY3ERaSqgoqnT2n+l9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJpXlEyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227BBC4CED6;
	Wed, 22 Jan 2025 13:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737552895;
	bh=7DfnBrMHaBayCccsD/q52Q3ilgtaRdWdr/x3Gw0r2XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJpXlEyv7n9CG7ZRDA2nS+LWBnhs1o58kuVfKdat3ym/LC5WJVE5RRiXv4JLyu2DM
	 2PAOPTBFQI/WaUx8B7/CWkSeD1S42ZpsuT5UcxvBdgG7SjhddajSxgZUUCcJIIx6lf
	 ZkBJz7qMlR2Gslw1+daM2Io4wCJK9iYx5WUPfPqNHGtuVHp7Oqjsw+w3cDOxHCH7ly
	 S+q1AoVrZLQ9HamDm9OLRTnnrz6BKzrtI5WOlc4ov5IxxR4xlFA6rIVOsc7LDj8EN3
	 WmJVnW/2F1MuyzHQ++ag89h1Z++m0wlreyPh1/aNvJc4jXqdgdnYonsVvW4u4t4DLd
	 7L7ySImQEMs9w==
Date: Wed, 22 Jan 2025 13:34:50 +0000
From: Simon Horman <horms@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	loongarch@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Chong Qiao <qiaochong@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Yanteng Si <si.yanteng@linux.dev>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Set correct
 {tx,rx}_fifo_size
Message-ID: <20250122133450.GI390877@kernel.org>
References: <20250121093703.2660482-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121093703.2660482-1-chenhuacai@loongson.cn>

+ Feiyang Chen, Yanteng Si, Alexandre Torgue, Maxime Coquelin, Serge Semin,
  linux-arm-kernel

On Tue, Jan 21, 2025 at 05:37:03PM +0800, Huacai Chen wrote:
> Now for dwmac-loongson {tx,rx}_fifo_size are uninitialised, which means
> zero. This means dwmac-loongson doesn't support changing MTU, so set the
> correct tx_fifo_size and rx_fifo_size for it (16KB multiplied by channel
> counts).
> 
> Note: the Fixes tag is not exactly right, but it is a key commit of the
> dwmac-loongson series.
> 
> Cc: stable@vger.kernel.org
> Fixes: ad72f783de06827a1f ("net: stmmac: Add multi-channel support")
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Thanks, this change looks good to me.
And I agree that MTU setting cannot succeed without it.

Reviewed-by: Simon Horman <horms@kernel.org>

Some process notes regarding Networking patches to keep
in mind for next time.

1. Please set the target tree. In this case, as this is a fix
   for code present in net. In general, otherwise it would be net-next.

   Subject: [PATCH net] ...

2. Please generate a CC list using

   ./scripts/get_maintainer.pl this.patch

   The b4 tool can help with this.

Link: https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index bfe6e2d631bd..79acdf38c525 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -574,6 +574,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (ret)
>  		goto err_disable_device;
>  
> +	plat->tx_fifo_size = SZ_16K * plat->tx_queues_to_use;
> +	plat->rx_fifo_size = SZ_16K * plat->rx_queues_to_use;
> +
>  	if (dev_of_node(&pdev->dev))
>  		ret = loongson_dwmac_dt_config(pdev, plat, &res);
>  	else
> -- 
> 2.47.1
> 
> 

