Return-Path: <stable+bounces-43615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D08C400C
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE601F22BD7
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B114D2AA;
	Mon, 13 May 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="h02zrtwJ"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C2314F102;
	Mon, 13 May 2024 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600718; cv=none; b=qIdiFVm8QQvMmIe9/eNwZyOE8ewbWIbxLHLadmLVMwfH6+k+zc16WEtRCFrkxY0sfmmb66sq3TUH4iamIZ5V8H5OBoYOrTe6NeI9Cu5AYQMLbkKSdfHBgDF0wCM5vGUW0C/ysxA+RryYq7U2QhXAO52YmfvpZ23RZpFE2P2qkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600718; c=relaxed/simple;
	bh=eAyTMUMGGuqdLpsBgzQWqQ1HResoKyZy1l6rRRccU3g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acEYlAjWFqwwOLtgs0aUk0yH8Mc2qtM6sSWVLqtUc+MM3cZcvau2EixEYpW1WC0qBe0TjapZoxuoaspAlXghLvgSwyHUoseyTOzq6EfWL1P6kcdVvZNUCsSjIZUH4IRPZohhA57oQN7x7fjTjb4dfMEELidTzxd/incKvFI6H7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=h02zrtwJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715600716; x=1747136716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eAyTMUMGGuqdLpsBgzQWqQ1HResoKyZy1l6rRRccU3g=;
  b=h02zrtwJZyDDMuzOEnq/jEE9jZ2f+N0PnhzxjGCl05YUrAmpU14AyDVX
   JQ76mnVd6HeKDdLOMiwiIiIjpvmZxkVmfiepKuGlNcY6zfZ+WRNFyxUos
   R71tqeym9NSYkhbL6rxS/s6Nlqk3+KiuOscZQEu2An3r8W1RZNQOXUuOd
   DPAAknzJXWwfYsXkW1LFZd8dQntremg8mCbYE0RTo8SdcQbUVn250+FCl
   wA8j2WGSpuLTMgvbuTsxKDy4XEJUHzPUmnizeLCIavqlmNbJEuwIgpuhi
   cjh6toa+hJ6wQPHrd/tX1iC2BJdY6mqL18epah7G3YVPEOc8zrl/3SSbn
   Q==;
X-CSE-ConnectionGUID: bvZzCf3dQ5+hvTmN+nHzBQ==
X-CSE-MsgGUID: C9csftaRRSujjB9EEGCyAw==
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="24493015"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2024 04:44:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 04:44:08 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 13 May 2024 04:44:08 -0700
Date: Mon, 13 May 2024 13:44:07 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: <UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Allan Nielsen
	<allan.nielsen@microchip.com>, Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] net: lan966x: remove debugfs directory in probe()
 error path
Message-ID: <20240513114407.t2iqcx7txoxkbnlj@DEN-DL-M31836.microchip.com>
References: <20240513111853.58668-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240513111853.58668-1-herve.codina@bootlin.com>

Hi,

The 05/13/2024 13:18, Herve Codina wrote:
> 
> A debugfs directory entry is create early during probe(). This entry is
> not removed on error path leading to some "already present" issues in
> case of EPROBE_DEFER.
> 
> Create this entry later in the probe() code to avoid the need to change
> many 'return' in 'goto' and add the removal in the already present error
> path.
> 
> Fixes: 942814840127 ("net: lan966x: Add VCAP debugFS support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

This looks OK to me. As the debugfs_root is used inside lan966x_vcap_init
which is called at the end of the probe.

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 2635ef8958c8..61d88207eed4 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -1087,8 +1087,6 @@ static int lan966x_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, lan966x);
>         lan966x->dev = &pdev->dev;
> 
> -       lan966x->debugfs_root = debugfs_create_dir("lan966x", NULL);
> -
>         if (!device_get_mac_address(&pdev->dev, mac_addr)) {
>                 ether_addr_copy(lan966x->base_mac, mac_addr);
>         } else {
> @@ -1179,6 +1177,8 @@ static int lan966x_probe(struct platform_device *pdev)
>                 return dev_err_probe(&pdev->dev, -ENODEV,
>                                      "no ethernet-ports child found\n");
> 
> +       lan966x->debugfs_root = debugfs_create_dir("lan966x", NULL);
> +
>         /* init switch */
>         lan966x_init(lan966x);
>         lan966x_stats_init(lan966x);
> @@ -1257,6 +1257,8 @@ static int lan966x_probe(struct platform_device *pdev)
>         destroy_workqueue(lan966x->stats_queue);
>         mutex_destroy(&lan966x->stats_lock);
> 
> +       debugfs_remove_recursive(lan966x->debugfs_root);
> +
>         return err;
>  }
> 
> --
> 
> This patch was previously sent as part of a bigger series:
>   https://lore.kernel.org/lkml/20240430083730.134918-9-herve.codina@bootlin.com/
> As it is a simple fix, this v2 is the patch extracted from the series
> and sent alone to net.
> 
> Changes v1 -> v2
>   Add 'Reviewed-by: Andrew Lunn <andrew@lunn.ch>'
> 
> 2.44.0

-- 
/Horatiu

