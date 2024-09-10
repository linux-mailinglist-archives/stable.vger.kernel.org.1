Return-Path: <stable+bounces-75729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E990B9740DF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5DD1C252BC
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166221A76CE;
	Tue, 10 Sep 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wa0z0WBC"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7F1A707C
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990048; cv=none; b=nsL4dt+UIVLztnP3SyVrd1qPshKvM7KqVLYzphuFe53V/HH5IUxaIHESrbRTRleDWSVw4SM+NkHj0MWvRHpNyuACTVedTXwCJSLGDUY3NloFofc9qAP2J9HXvw5iuIh4c6exCRnvgoMzjMNjq0fNmHCnytcZyQZgDzuP1AXVSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990048; c=relaxed/simple;
	bh=gm6pkDPNqL8B1rD4PuIfY7C8eqdXdRGMw+p++Kt8Amc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELPBSGKfMD0f7y2CVnvypghJOdiGdorR6vh7o6GnmRJMjhd2Nu8UvGmdaGmnym8LTkzbE/FpMew6vb4vNIla0vZr5sXe0/PZfU8/QfI/H53CIHCV+vrSTlfHkR2r2AUWRLHEDC6MCnxFB4rrPeVhtWjPTzKozEaM6qEJVHqYxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wa0z0WBC; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c35618056aso29356936d6.1
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725990046; x=1726594846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KWiNzFgnhVTIr2U5XjVoFFKWQp70DaD9UbVVHcdtg9s=;
        b=Wa0z0WBCU3rqAejTgRSCoFT4lnTDFHKa72zhz7lhs3kLhz0YE4r8MEeIxLXX9Qxyeg
         8IYBN+11d/QPAtp2hYvYvloWKrQcJJK3xiEUb5+KhrW2WqWKCO4j06UK8e6ep2B1xNis
         XJFkLaEnNI+2/jMWzHrYnteU9oWe7k+1RfbjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990046; x=1726594846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWiNzFgnhVTIr2U5XjVoFFKWQp70DaD9UbVVHcdtg9s=;
        b=fbwmGqtQdMDFc0loCmzUQfET4bLOiIiplI9kxeT5lVkyfx2oYKQKTAsCRzPnyQ6UGR
         QGFUsqWJtN4IBeDOQTMq+THkEXQA+2fZ30UHKwWx5U9Xa8K2AXB3cl8extDxbTN3F1ZL
         YD0D0e0hwcKUH7wzZ5C8yXKUJvAq/jcyUnXcRBbA3Du5T9cJDjoIg931w9ToBwCClbia
         ozHDIuICX2YQ91csx+yb3kARXiUWmguPibi7Qu8v+LV4398a4DgXXjuKWEhNyUG/g0gy
         ExdWWqw4g7czbN3wzUdjfSd+YDkvLX2RBDqLhthIgQ/+ltmejfN9NgzXoT6W1n9GwVDE
         JrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlc7e/GkmdSz9NtO/Dc/KAMKVrlooDxnre/7ZsHWPFocjFdEv5kRxmbFIzh+L7OudQFKIyoK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jKkK1UkWgTh1TJsAVDVjLgA+Qftpy7Ef2exjd5DVHMliNRrT
	jFyB7rnpk8TSPo4+zwSr6wUm73C4SRyXPzoTrXiGNvAYxoW5Ny3vfMVAfXjCIg==
X-Google-Smtp-Source: AGHT+IGz2GsDK4EAX2RRXqgrurkXiUEF+O3nF/sGJkyNvVVDZ7mgEWRLVZAnLKq/fgLp0Ujnay4gnA==
X-Received: by 2002:a05:6214:440c:b0:6c3:58b7:d703 with SMTP id 6a1803df08f44-6c5284fff35mr166317166d6.22.1725990045599;
        Tue, 10 Sep 2024 10:40:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474f79fsm31885006d6.80.2024.09.10.10.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:40:44 -0700 (PDT)
Message-ID: <b6604e07-9add-4e93-ad6b-f1efc336e3bf@broadcom.com>
Date: Tue, 10 Sep 2024 10:40:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, netdev@vger.kernel.org
Cc: =?UTF-8?B?QXIxbsOnIMOcTkFM?= <arinc.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 linux-mediatek@lists.infradead.org, bridge@lists.linux.dev,
 stable@vger.kernel.org
References: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
 <20240910130321.337154-2-alexander.sverdlin@siemens.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20240910130321.337154-2-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 06:03, 'A. Sverdlin' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> There are multiple races of zeroing dsa_ptr in struct net_device (on
> shutdown/remove) against asynchronous dereferences all over the net
> code. Widespread pattern is as follows:
> 
> CPU0					CPU1
> if (netdev_uses_dsa())
> 					dev->dsa_ptr = NULL;
>          dev->dsa_ptr->...
> 
> One of the possible crashes:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> CPU: 0 PID: 12 Comm: ksoftirqd/0 Tainted: G O 6.1.99+ #1
> pc : lan9303_rcv
> lr : lan9303_rcv
> Call trace:
>   lan9303_rcv
>   dsa_switch_rcv
>   __netif_receive_skb_list_core
>   netif_receive_skb_list_internal
>   napi_gro_receive
>   fec_enet_rx_napi
>   __napi_poll
>   net_rx_action
> ...
> 
> RCU-protect dsa_ptr and use rcu_dereference() or rtnl_dereference()
> depending on the calling context.
> 
> Rename netdev_uses_dsa() into __netdev_uses_dsa_currently()
> (assumes ether RCU or RTNL lock held) and netdev_uses_dsa_currently()
> variants which better reflect the uselessness of the function's
> return value, which becomes outdated right after the call.
> 
> Fixes: ee534378f005 ("net: dsa: fix panic when DSA master device unbinds on shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Thanks for doing this work, just a few nits below. This is likely to be 
difficult to backport to stable trees.

> ---
>   drivers/net/dsa/mt7530.c                    |   3 +-
>   drivers/net/dsa/ocelot/felix.c              |   3 +-
>   drivers/net/dsa/qca/qca8k-8xxx.c            |   3 +-
>   drivers/net/ethernet/broadcom/bcmsysport.c  |   8 +-
>   drivers/net/ethernet/mediatek/airoha_eth.c  |   2 +-
>   drivers/net/ethernet/mediatek/mtk_eth_soc.c |  22 +++--
>   drivers/net/ethernet/mediatek/mtk_ppe.c     |  15 ++-
>   include/linux/netdevice.h                   |   2 +-
>   include/net/dsa.h                           |  36 +++++--
>   include/net/dsa_stubs.h                     |   6 +-
>   net/bridge/br_input.c                       |   2 +-
>   net/core/dev.c                              |   3 +-
>   net/core/flow_dissector.c                   |  19 ++--
>   net/dsa/conduit.c                           |  66 ++++++++-----
>   net/dsa/dsa.c                               |  19 ++--
>   net/dsa/port.c                              |   3 +-
>   net/dsa/tag.c                               |   3 +-
>   net/dsa/tag.h                               |  19 ++--
>   net/dsa/tag_8021q.c                         |  10 +-
>   net/dsa/tag_brcm.c                          |   2 +-
>   net/dsa/tag_dsa.c                           |   8 +-
>   net/dsa/tag_qca.c                           |  10 +-
>   net/dsa/tag_sja1105.c                       |  22 +++--
>   net/dsa/user.c                              | 104 +++++++++++---------
>   net/ethernet/eth.c                          |   2 +-
>   25 files changed, 240 insertions(+), 152 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index ec18e68bf3a8..82d3f1786156 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -20,6 +20,7 @@
>   #include <linux/reset.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/gpio/driver.h>
> +#include <linux/rtnetlink.h>
>   #include <net/dsa.h>
>   
>   #include "mt7530.h"
> @@ -3092,7 +3093,7 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
>   			    const struct net_device *conduit,
>   			    bool operational)
>   {
> -	struct dsa_port *cpu_dp = conduit->dsa_ptr;
> +	struct dsa_port *cpu_dp = rtnl_dereference(conduit->dsa_ptr);

Out of curiosity, only sparse will likely be able to recognize the __rcu 
annotation of net_device::dsa_ptr so there is still unfortunately room 
for programmers to forget about using rtnl_dereference(), this should 
hopefully be caught by CI when patches are submitted.

>   	struct mt7530_priv *priv = ds->priv;
>   	int val = 0;
>   	u8 mask;
> diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> index 4a705f7333f4..f6bc0ff0c116 100644
> --- a/drivers/net/dsa/ocelot/felix.c
> +++ b/drivers/net/dsa/ocelot/felix.c
> @@ -21,6 +21,7 @@
>   #include <linux/of_net.h>
>   #include <linux/pci.h>
>   #include <linux/of.h>
> +#include <linux/rtnetlink.h>
>   #include <net/pkt_sched.h>
>   #include <net/dsa.h>
>   #include "felix.h"
> @@ -57,7 +58,7 @@ static int felix_cpu_port_for_conduit(struct dsa_switch *ds,
>   		return lag;
>   	}
>   
> -	cpu_dp = conduit->dsa_ptr;
> +	cpu_dp = rtnl_dereference(conduit->dsa_ptr);
>   	return cpu_dp->index;
>   }
>   
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index f8d8c70642c4..10b4d7e9be2f 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -20,6 +20,7 @@
>   #include <linux/gpio/consumer.h>
>   #include <linux/etherdevice.h>
>   #include <linux/dsa/tag_qca.h>
> +#include <linux/rtnetlink.h>
>   
>   #include "qca8k.h"
>   #include "qca8k_leds.h"
> @@ -1754,7 +1755,7 @@ static void
>   qca8k_conduit_change(struct dsa_switch *ds, const struct net_device *conduit,
>   		     bool operational)
>   {
> -	struct dsa_port *dp = conduit->dsa_ptr;
> +	struct dsa_port *dp = rtnl_dereference(conduit->dsa_ptr);
>   	struct qca8k_priv *priv = ds->priv;
>   
>   	/* Ethernet MIB/MDIO is only supported for CPU port 0 */
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index c9faa8540859..bd9bc081346d 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -145,7 +145,7 @@ static void bcm_sysport_set_rx_csum(struct net_device *dev,
>   	 * sure we tell the RXCHK hardware to expect a 4-bytes Broadcom
>   	 * tag after the Ethernet MAC Source Address.
>   	 */
> -	if (netdev_uses_dsa(dev))
> +	if (__netdev_uses_dsa_currently(dev))

I appreciate the thought given into the function name, though I am not 
sure it is warranted to suffix with _currently().

>   		reg |= RXCHK_BRCM_TAG_EN;
>   	else
>   		reg &= ~RXCHK_BRCM_TAG_EN;
> @@ -173,7 +173,7 @@ static void bcm_sysport_set_tx_csum(struct net_device *dev,
>   	 * checksum to be computed correctly when using VLAN HW acceleration,
>   	 * else it has no effect, so it can always be turned on.
>   	 */
> -	if (netdev_uses_dsa(dev))
> +	if (__netdev_uses_dsa_currently(dev))
>   		reg |= tdma_control_bit(priv, SW_BRCM_TAG);
>   	else
>   		reg &= ~tdma_control_bit(priv, SW_BRCM_TAG);
> @@ -1950,7 +1950,7 @@ static inline void gib_set_pad_extension(struct bcm_sysport_priv *priv)
>   
>   	reg = gib_readl(priv, GIB_CONTROL);
>   	/* Include Broadcom tag in pad extension and fix up IPG_LENGTH */
> -	if (netdev_uses_dsa(priv->netdev)) {
> +	if (__netdev_uses_dsa_currently(priv->netdev)) {
>   		reg &= ~(GIB_PAD_EXTENSION_MASK << GIB_PAD_EXTENSION_SHIFT);
>   		reg |= ENET_BRCM_TAG_LEN << GIB_PAD_EXTENSION_SHIFT;
>   	}
> @@ -2299,7 +2299,7 @@ static u16 bcm_sysport_select_queue(struct net_device *dev, struct sk_buff *skb,
>   	struct bcm_sysport_tx_ring *tx_ring;
>   	unsigned int q, port;
>   
> -	if (!netdev_uses_dsa(dev))
> +	if (!__netdev_uses_dsa_currently(dev))
>   		return netdev_pick_tx(dev, skb, NULL);
>   
>   	/* DSA tagging layer will have configured the correct queue */
> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
> index 1c5b85a86df1..f7425d393b22 100644
> --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> @@ -2255,7 +2255,7 @@ static int airoha_dev_open(struct net_device *dev)
>   	if (err)
>   		return err;
>   
> -	if (netdev_uses_dsa(dev))
> +	if (__netdev_uses_dsa_currently(dev))
>   		airoha_fe_set(eth, REG_GDM_INGRESS_CFG(port->id),
>   			      GDM_STAG_EN_MASK);
>   	else
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 16ca427cf4c3..82a828349323 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -24,6 +24,7 @@
>   #include <linux/pcs/pcs-mtk-lynxi.h>
>   #include <linux/jhash.h>
>   #include <linux/bitfield.h>
> +#include <linux/rcupdate.h>
>   #include <net/dsa.h>
>   #include <net/dst_metadata.h>
>   #include <net/page_pool/helpers.h>
> @@ -1375,7 +1376,8 @@ static void mtk_tx_set_dma_desc_v2(struct net_device *dev, void *txd,
>   		/* tx checksum offload */
>   		if (info->csum)
>   			data |= TX_DMA_CHKSUM_V2;
> -		if (mtk_is_netsys_v3_or_greater(eth) && netdev_uses_dsa(dev))
> +		if (mtk_is_netsys_v3_or_greater(eth) &&
> +		    __netdev_uses_dsa_currently(dev))
>   			data |= TX_DMA_SPTAG_V3;
>   	}
>   	WRITE_ONCE(desc->txd5, data);
> @@ -2183,7 +2185,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>   		 * hardware treats the MTK special tag as a VLAN and untags it.
>   		 */
>   		if (mtk_is_netsys_v1(eth) && (trxd.rxd2 & RX_DMA_VTAG) &&
> -		    netdev_uses_dsa(netdev)) {
> +		    __netdev_uses_dsa_currently(netdev)) {
>   			unsigned int port = RX_DMA_VPID(trxd.rxd3) & GENMASK(2, 0);
>   
>   			if (port < ARRAY_SIZE(eth->dsa_meta) &&
> @@ -3304,7 +3306,7 @@ static void mtk_gdm_config(struct mtk_eth *eth, u32 id, u32 config)
>   
>   	val |= config;
>   
> -	if (eth->netdev[id] && netdev_uses_dsa(eth->netdev[id]))
> +	if (eth->netdev[id] && __netdev_uses_dsa_currently(eth->netdev[id]))
>   		val |= MTK_GDMA_SPECIAL_TAG;
>   
>   	mtk_w32(eth, val, MTK_GDMA_FWD_CFG(id));
> @@ -3313,12 +3315,16 @@ static void mtk_gdm_config(struct mtk_eth *eth, u32 id, u32 config)
>   
>   static bool mtk_uses_dsa(struct net_device *dev)
>   {
> +	bool ret = false;
>   #if IS_ENABLED(CONFIG_NET_DSA)
> -	return netdev_uses_dsa(dev) &&
> -	       dev->dsa_ptr->tag_ops->proto == DSA_TAG_PROTO_MTK;
> -#else
> -	return false;
> +	struct dsa_port *dp;
> +
> +	rcu_read_lock();
> +	dp = rcu_dereference(dev->dsa_ptr);
> +	ret = dp && dp->tag_ops->proto == DSA_TAG_PROTO_MTK;
> +	rcu_read_unlock();

This pattern repeats in mtk_ppe.c, a possible factoring for later.
-- 
Florian

