Return-Path: <stable+bounces-9219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7214822286
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 21:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FB6284754
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 20:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40ED16412;
	Tue,  2 Jan 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBsfq3pD"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261C16408;
	Tue,  2 Jan 2024 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb53e20a43so8135421b6e.1;
        Tue, 02 Jan 2024 12:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704227202; x=1704832002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ND+OLXd8ysMaukWUwVdTBQu9Bq4kTBqMzqgELsTouEM=;
        b=YBsfq3pDDMy/mC7Lw+noJpuwqpNYAXJIjEa99/XV3Gwbyh4YXdI3y5M/kjoDiD5Kka
         C9Hd7B3H6KhAOygoiRXPwPyiBNljrj5gz+RCgmkNNkGqBmkgEYokQgUxfdGOs9hqFLqm
         nlDzoO8fbxZ4bkNotvjoCYXt8dKV3mBKahUx5438VM5bNdhjU/sI1Jxb0qTPu2kl1YEz
         rKL3JX8t+JHgkSng9QvLWmbFhF6zeNjb1FnUPkxsMmFRl+xRQuXM2zae480ynOsHGhSu
         D48xjgEqS+jAzQ8KrzEHoY3zYikr6GokNoNwYq8U8/p2lbNGjNC+b0nYyj3cqd/53w4f
         DMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704227202; x=1704832002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ND+OLXd8ysMaukWUwVdTBQu9Bq4kTBqMzqgELsTouEM=;
        b=uFBWlBi4eqNKaQfaRGF0rV9a9/4EUb0AnlhQwRqL6xZtifh5IQAnsYAxsMpdOAUjad
         hF2AT73IHa5mGO1Og5YbDQJwBSfu+PQaObiJhnBQQ3GXsw0+n5I9n/pheRIDJceXHNq/
         myTy+oidOQ9ktuj+rG+m+NKr2uAOfdqrPqvGYYFi9qlHC1uOyUP0/ZO+MdUAdr/hbOkL
         E9x5Ejq6IFoJItavoU1tUgirG7vlpF+60xVLUrVHzgcr7QLRi8EcZdp0Fq9Gepfs53Em
         k5jnfAKoOx4nuPXMi+sUxWPqibaDEN7SxeCyv/mmKeizaK/1PDHSLwPTuk71YoX1AUac
         lhyQ==
X-Gm-Message-State: AOJu0YwMOkxTIBS5zyOjW/J9GG8fWQ91z/uCkWdUoWsvfDd/X50sXWLa
	ZLkcwkOEvrjHSyzSYMQqg/0=
X-Google-Smtp-Source: AGHT+IECf2pCqyhQfLb0z19B9usr5kRSPtS6GrVnfDloU3HnQVX6HP0jstc9NMMeueOf/oK5pNIl0A==
X-Received: by 2002:a05:6808:18a8:b0:3bc:187b:545c with SMTP id bi40-20020a05680818a800b003bc187b545cmr1915272oib.57.1704227201778;
        Tue, 02 Jan 2024 12:26:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n3-20020ad444a3000000b00680b1090832sm1898429qvt.146.2024.01.02.12.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 12:26:40 -0800 (PST)
Message-ID: <e2250240-db19-4cb6-93ca-2384a382cdd5@gmail.com>
Date: Tue, 2 Jan 2024 12:26:36 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: stmmac: Prevent DSA tags from breaking
 COE on stmmac
Content-Language: en-US
To: Romain Gantois <romain.gantois@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Sylvain Girard <sylvain.girard@se.com>, Vladimir Oltean <olteanv@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Pascal EBERHARD <pascal.eberhard@se.com>,
 Richard Tresidder <rtresidd@electromag.com.au>,
 Linus Walleij <linus.walleij@linaro.org>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20240102162718.268271-1-romain.gantois@bootlin.com>
 <20240102162718.268271-2-romain.gantois@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240102162718.268271-2-romain.gantois@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/2/24 08:27, Romain Gantois wrote:
> Some DSA tagging protocols change the EtherType field in the MAC header
> e.g.  DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105). On TX these tagged
> frames are ignored by the checksum offload engine and IP header checker of
> some stmmac cores.
> 
> On RX, the stmmac driver wrongly assumes that checksums have been computed
> for these tagged packets, and sets CHECKSUM_UNNECESSARY.
> 
> Add an additional check in the stmmac tx and rx hotpaths so that COE is
> deactivated for packets with ethertypes that will not trigger the COE and
> ip header checks.
> 
> Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
> Cc: stable@vger.kernel.org
> Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> Closes: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
> Reported-by: Romain Gantois <romain.gantois@bootlin.com>
> Closes: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/

Fairly sure those should be Link: and Closes: should be used for bug 
tracker entries.

> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 ++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 37e64283f910..bb2ae6b32b2f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4371,6 +4371,17 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>   	return NETDEV_TX_OK;
>   }
>   
> +/* Check if ethertype will trigger IP
> + * header checks/COE in hardware
> + */
> +static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb)
> +{
> +	__be16 proto = eth_header_parse_protocol(skb);
> +
> +	return (proto == htons(ETH_P_IP)) || (proto == htons(ETH_P_IPV6)) ||
> +		(proto == htons(ETH_P_8021Q));

Do you need to include ETH_P_8021AD in that list as well or is not 
stmmac capable of checksuming beyond a single VLAN tag?

Thanks!
-- 
Florian


