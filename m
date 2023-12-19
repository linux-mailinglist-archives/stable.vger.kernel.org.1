Return-Path: <stable+bounces-7912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D6818747
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 13:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E553A2856F8
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F67B17757;
	Tue, 19 Dec 2023 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew76LuJ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BD1802D;
	Tue, 19 Dec 2023 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2340c803c6so317307966b.0;
        Tue, 19 Dec 2023 04:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702988437; x=1703593237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6TxmZzSrla4vvXDQC7Cn74njvru9m/j+6El3HghLS4=;
        b=Ew76LuJ4whOny86D5q8FcStaWDAWlWbWeASoT3VZRE0jCGZhc3RmcN8Y1cagCHVwZp
         zFbkWs4VtdLwC63WMXXomtVvXkK4c5nuvG1hih8FXzH25DPmdIsPPpgK2L9uC9qdx1ma
         Wo0gjsPvLA0SNGEMF3c84O9DkifBSypf7IM4hF7WMsKwOV6N1kvbldTSOunPL6F/hzmt
         79PHchHebXMJpHSk3A8pxXxfgsTUAngdzBdXmyL5X1BaEg9bX7re3/792To+NustZZZY
         JH8ZzJy57lcSVXpt3joCqOhXJoAMvAEqW3dvtXSSb9CWy5/9X9Q0caJR6q5QK+sQEOWe
         ao+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702988437; x=1703593237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6TxmZzSrla4vvXDQC7Cn74njvru9m/j+6El3HghLS4=;
        b=wex245zs0S6J8HJFymv2Z7oIe6SuhawGnTSdis0tGGUHOxVeulhaA3FRKjzaKyUYpq
         iAEEUP7FNes0Qadklxm+LCGbKErUsgbQFHcf5uw/c0ovoZr/DGSL1XeTj5XTtuKOCnQF
         3keTEERkx5X6j6dc5psKqG0YxTibZKaIxBexiMqP5YjhaE0Y+Hc7q6HHhLKeNzw7EC5G
         0i566ZoZMRrcMmA/Pwc+ErX7YcsILhG0jxh25OrVhZfxtfiGLU1FWyM+rjmpbLt4os4o
         wLxNjPK4JYM+OUMwhP5pgGRZsxED4JWpkWTeeN3ZSUAJtNUhd+HqeSnwuC3UYLesD/tJ
         EwNA==
X-Gm-Message-State: AOJu0YyZUa6dMswQ6O8ItfCiY4CEpI7RaYGuSeEXhRydj6vWa3qtziDM
	59+4BVPLs1iXXA0Jyr6yrNU=
X-Google-Smtp-Source: AGHT+IEF85zDgPhfMUFpTsLoXGcLUVBLjiYkSXZm9jyM0zEWCF6zNqlV9cTbyQPPvo84zRJXC5qRFg==
X-Received: by 2002:a17:906:b0d4:b0:a1d:7792:cdbe with SMTP id bk20-20020a170906b0d400b00a1d7792cdbemr7007558ejb.146.1702988437094;
        Tue, 19 Dec 2023 04:20:37 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id lm11-20020a17090718cb00b00a1cf3fce937sm15284866ejc.162.2023.12.19.04.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:20:36 -0800 (PST)
Date: Tue, 19 Dec 2023 14:20:34 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking COE
Message-ID: <20231219122034.pg2djgrosa4irubh@skbuf>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <20231218162326.173127-2-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218162326.173127-2-romain.gantois@bootlin.com>

Hi Romain,

On Mon, Dec 18, 2023 at 05:23:23PM +0100, Romain Gantois wrote:
> Some stmmac cores have Checksum Offload Engines that cannot handle DSA tags
> properly. These cores find the IP/TCP headers on their own and end up
> computing an incorrect checksum when a DSA tag is inserted between the MAC
> header and IP header.
> 
> Add an additional check on stmmac link up so that COE is deactivated
> when the stmmac device is used as a DSA conduit.
> 
> Add a new dma_feature flag to allow cores to signal that their COEs can't
> handle DSA tags on TX.
> 
> Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
> Cc: stable@vger.kernel.org
> Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> Closes: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
> Reported-by: Romain Gantois <romain.gantois@bootlin.com>
> Closes: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---

DSA_TAG_PROTO_LAN9303, DSA_TAG_PROTO_SJA1105 and DSA_TAG_PROTO_SJA1110
construct tags with ETH_P_8021Q as EtherType. Do you still think it
would be correct to say that all DSA tags break COE on the stmmac, as
this patch assumes?

The NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM convention is not about
statically checking whether the interface using DSA, but about looking
at each packet before deciding whether to use the offload engine or to
call skb_checksum_help().

You can experiment with any tagging protocol on the stmmac driver, and
thus with the controller's response to any kind of traffic, even if the
port is not attached to a hardware switch. You need to enable the
CONFIG_NET_DSA_LOOP option, edit the return value of dsa_loop_get_protocol()
and the "netdev" field of dsa_loop_pdata. The packets need to be
analyzed on the link partner with a packet analysis tool, since there is
no switch to strip the DSA tag.

>  drivers/net/ethernet/stmicro/stmmac/common.h     |  1 +
>  .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c  |  1 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 +++++++++++++++-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index daf79cdbd3ec..50686cdc3320 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -264,6 +264,7 @@ static int dwmac1000_get_hw_feature(void __iomem *ioaddr,
>  	dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
>  	/* Alternate (enhanced) DESC mode */
>  	dma_cap->enh_desc = (hw_cap & DMA_HW_FEAT_ENHDESSEL) >> 24;
> +	dma_cap->dsa_breaks_tx_coe = 1;
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a9b6b383e863..733348c65e04 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -42,6 +42,7 @@
>  #include <net/page_pool/helpers.h>
>  #include <net/pkt_cls.h>
>  #include <net/xdp_sock_drv.h>
> +#include <net/dsa.h>
>  #include "stmmac_ptp.h"
>  #include "stmmac.h"
>  #include "stmmac_xdp.h"
> @@ -993,8 +994,11 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>  			       int speed, int duplex,
>  			       bool tx_pause, bool rx_pause)
>  {
> -	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> +	struct net_device *ndev = to_net_dev(config->dev);
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	unsigned int tx_queue_cnt;
>  	u32 old_ctrl, ctrl;
> +	int queue;
>  
>  	if ((priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP) &&
>  	    priv->plat->serdes_powerup)
> @@ -1102,6 +1106,16 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>  
>  	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
>  		stmmac_hwtstamp_correct_latency(priv, priv);
> +
> +	/* DSA tags break COEs on some cores. Disable TX checksum
> +	 * offloading on those cores if the netdevice is a DSA conduit.
> +	 */
> +	if (priv->dma_cap.dsa_breaks_tx_coe && netdev_uses_dsa(ndev)) {
> +		tx_queue_cnt = priv->plat->tx_queues_to_use;
> +		for (queue = 0; queue < tx_queue_cnt; queue++)
> +			priv->plat->tx_queues_cfg[queue].coe_unsupported = true;
> +	}
> +

The DSA switch driver can load after stmmac_mac_link_up() runs.
This implementation is racy anyway.

>  }
>  
>  static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
> -- 
> 2.43.0
> 
> 

pw-bot: cr

