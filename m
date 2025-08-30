Return-Path: <stable+bounces-176741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3EAB3CB6F
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA21A56579E
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3941F26E142;
	Sat, 30 Aug 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tMMs3s2B"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EDC21FF38;
	Sat, 30 Aug 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756564123; cv=none; b=Fs24PPkTtjDmo1gqhrGF0lpj7DJ8DKew3oJ42Eu5ghRb4kZuXh3Yp0bzSFjVY+BldX8yAFmMgMxnwXJulHBZWgTAfQRtgbzPn8INAAeyPoT0PLsou+ArzAJ13nyttZWsqC/+2QL2WQJwKxQWjlgQRxMOJvBzWSWr/1L3T0R21v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756564123; c=relaxed/simple;
	bh=YAQ0j9K3lE/r4icyyZ1fXa638JamIoz0p/DY3KBwcxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYLKt3JC+oVIZBSKhJn+stNfEj2sUfeiqJ1tD9BLqIxMu8piFXpkXgRQnxjmaFG10du1Md9x6MHtjuQqEWo/8ElSmv5/qgwzN/pNyXeFLXezLVA4xHGMgOgZvanFcRuTSYQt6lFqsKHSU9XC8lUShqjFnn+a4KW4o3hu4l0EolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tMMs3s2B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qiWlM2z4pFliC1XU4x388n2RlecYZAWxMBbF4rNFKuE=; b=tMMs3s2Bv49/CDpwA723uiir1p
	qqvH8Rxz2MH401QCv025poOkKVLrmg6/q6oBajgOsAOGQl2EXKVcQGNzn3EPlaDhLlYIm+Gum8iHg
	oB5G0m3QHVppbEasHIYAM+xLV9dIF7mBK47VBdX3MqVQcU98wh+ql4Iop7ASmi1Sob6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1usMZB-006aDf-52; Sat, 30 Aug 2025 16:28:29 +0200
Date: Sat, 30 Aug 2025 16:28:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Fix fwnode reference leaks in
 mv88e6xxx_port_setup_leds
Message-ID: <7797e6a1-6721-4330-a1de-f068f8901f92@lunn.ch>
References: <20250830085508.2107507-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830085508.2107507-1-linmq006@gmail.com>

> diff --git a/drivers/net/dsa/mv88e6xxx/leds.c b/drivers/net/dsa/mv88e6xxx/leds.c
> index 1c88bfaea46b..dcc765066f9c 100644
> --- a/drivers/net/dsa/mv88e6xxx/leds.c
> +++ b/drivers/net/dsa/mv88e6xxx/leds.c
> @@ -779,6 +779,8 @@ int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
>  			continue;
>  		if (led_num > 1) {
>  			dev_err(dev, "invalid LED specified port %d\n", port);
> +			fwnode_handle_put(led);
> +			fwnode_handle_put(leds);
>  			return -EINVAL;
>  		}
>  
> @@ -823,17 +825,23 @@ int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
>  		init_data.devname_mandatory = true;
>  		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d:0%d", chip->info->name,
>  						 port, led_num);
> -		if (!init_data.devicename)
> +		if (!init_data.devicename) {
> +			fwnode_handle_put(led);
> +			fwnode_handle_put(leds);
>  			return -ENOMEM;
> +		}
>  
>  		ret = devm_led_classdev_register_ext(dev, l, &init_data);
>  		kfree(init_data.devicename);
>  
>  		if (ret) {
>  			dev_err(dev, "Failed to init LED %d for port %d", led_num, port);
> +			fwnode_handle_put(led);
> +			fwnode_handle_put(leds);
>  			return ret;
>  		}
>  	}
>  
> +	fwnode_handle_put(leds);
>  	return 0;

Since you need this three times, please put the cleanup at the end and
use a goto:

    Andrew

---
pw-bot: cr

