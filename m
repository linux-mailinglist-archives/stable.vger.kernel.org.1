Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E1A7D970C
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 13:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbjJ0Lzf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 07:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbjJ0Lzf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 07:55:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D5186;
        Fri, 27 Oct 2023 04:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=xKkgQbSQCEpZQloC8PIwFH82W161i281OBtZkhnuCC8=; b=TX9atbL1jQWE81Enyh8HJrA9xI
        K2Ysh8YrtMMYUX6cwdcHb7MJCV9OL9/8XNYhnrwF8fYHCNdvtYXmA98KPpbjRKU5XLWdrZkBdlVj2
        c6FwQpC2+rAx0UevgxpPwl/3TFYpt9Dmeo/U+IipSCOW+tHtpINI325wE7zCHnjBmbhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qwLQq-000Ko8-Nf; Fri, 27 Oct 2023 13:55:16 +0200
Date:   Fri, 27 Oct 2023 13:55:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc:     netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Juergen Beisert <jbe@pengutronix.de>,
        Jerry Ray <jerry.ray@microchip.com>,
        Mans Rullgard <mans@mansr.com>, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: lan9303: consequently nested-lock physical MDIO
Message-ID: <f0e67b6e-e226-46fc-9e7c-60da35938d3f@lunn.ch>
References: <20231027065741.534971-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027065741.534971-1-alexander.sverdlin@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 27, 2023 at 08:57:38AM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> When LAN9303 is MDIO-connected two callchains exist into
> mdio->bus->write():
> 
> 1. switch ports 1&2 ("physical" PHYs):
> 
> virtual (switch-internal) MDIO bus (lan9303_switch_ops->phy_{read|write})->
>   lan9303_mdio_phy_{read|write} -> mdiobus_{read|write}_nested
> 
> 2. LAN9303 virtual PHY:
> 
> virtual MDIO bus (lan9303_phy_{read|write}) ->
>   lan9303_virt_phy_reg_{read|write} -> regmap -> lan9303_mdio_{read|write}


> Cc: stable@vger.kernel.org
> Fixes: dc7005831523 ("net: dsa: LAN9303: add MDIO managed mode support")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
