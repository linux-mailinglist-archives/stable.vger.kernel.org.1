Return-Path: <stable+bounces-203009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB607CCCD45
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F8CE3051317
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2276A3590C4;
	Thu, 18 Dec 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="J0z0AW9h"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E45347BD2
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073139; cv=none; b=BN8ug/3JlnwDv2og5+a5HGCVuFdFRNrgt9alYxSmcqHm6U4Rd4aJXNYVFlSTkMD3WClJps0mPICSSIT/WSHnpOKeg8cFu6CSd79sBDxYgz3L/ecpnTmKML6z4RkiZ8iOlTX+c4G72xpQVJxHu9kvG99X50mTVvM1ThGWYnwlYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073139; c=relaxed/simple;
	bh=Xh1E3qsm/qasJNMVvvqXFxuDKwQq6V1HA7yNPOSOlCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUJHU+iYybiw1EC6YenAXGr6b1x1noIn7qK4TFxk0RzIqzly7d1t1DrE70L6P34ujRPmeipZeDiHGf+SKW/s2dN1pF81H8u4ltXI5IOJemZyJrg0OS+O5x13g9jzMqeTjjFG3J6hjpXa+m98A3Ij1XFyUNAYuc8kUxs2h84X6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=J0z0AW9h; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so7835396d6.2
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 07:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1766073137; x=1766677937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cW1M7fqhwlN10fdEj0fPal9hwmmZjLYjufee+fkgnhM=;
        b=J0z0AW9hKzi615k9wVeEjklkDNiUsuVhMB73ArCAzXQFZEy98P6rsaOIlgu5bUa/Ve
         wA/h7ENiu+pb4HXbQN8Vgu1fZ9UXar6Cb72lIMmQpTgHbXJx4YB6iRe1VSa446LR+A6o
         o8HXVGmPS0yei3Bb94GpwY4aCgLGcou1BPnDHJL/SINWaJ3+6HrVfgsuRhkfdjcM6UcU
         HK3JiURUtsNRY46F/xMvb4LRh83y64W9qi1kaOXq8W6fE0dHah5C5SK2d/RGOL+bndRD
         fHzgKBCN31aT82S8FdM+AlZGIfG7ORh+yzGNk6b+iLowBGGOnUSKfFOjNmdgToJ/v/wV
         G5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766073137; x=1766677937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cW1M7fqhwlN10fdEj0fPal9hwmmZjLYjufee+fkgnhM=;
        b=hsb0BeBCkcQwAK2Px3w8Ze00E1wmr8PY6wtd8iRRrAUlb5HCE07qnL302XyRV4hIqm
         EDGNRS9AA/pO+f0kpAn3T+C5U1n9eZgICqSPA+uV0bYvwj5zavXJl0kPCc6GQBS9jHCm
         XQVrHbPnOgaNlkMZCw5BjrleNk6ROUo/h/UNEj4GQZQptk2SHTZKSDLWDq2vmdSwK69V
         c5LgKxXBKQAM5BcJCDvuJBA7SloOYXuaXQ42teqqqTWru0Ppq4cdtKXa9wlTU7nyKXfD
         ywOCNY7HTOH6BZrAFW2k0LIrH7YdESaQz+9a61mHqW3QsllfrYekA0OcsVDEJN8XfXbQ
         aN0A==
X-Forwarded-Encrypted: i=1; AJvYcCWLtL/6JcOLSdlmOv/IIUjRV+ld63wYcLSBZSECbcEuHto1XxDCrRvd+u55KSisV+HZAyCTx8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkeYI3SqtSfPT71QD0zz2X6KtSwI2QofqhWOvZjk+cijOIdYBY
	GFGx9+KrA7Yys62pRlTLWH0wYN+Bopvo32WT1Yr2Rz4SP2MKS3wIoCyz6mSzxhA6mQ==
X-Gm-Gg: AY/fxX5b5LJkFg3jTciVhU3gRjx3D/X+ENd5mkYONGPQPohVBzgNi1ZQCoiQMI9fM2j
	1kR3HWI13xah20MEwrtsyOv1f22uBXEOk3X3qQ6bRwWUB5JnYCjxIkk3qPquQETFwxqN409pWqJ
	uxg8y40eqShzgMhCiyjwItcS73sPZ/NUcNLWQuI03RqsSUO8c5HSJfzDv1PCVxn8NxWc7TMabfe
	v8k8EA16bIi1QhKiOXd8S4GfGrlpf83MHllxvKdXMuHn9Tp9RGz26UXCd6Suqm11FbSgSGoLpnN
	LIUgCeBONd/GfC9fJEVrfQpF7PE/XbVuTw8gVBXERyeVVeu/jYgfMVl0nsNGzvEFDALXTMl/woA
	2js3l1QwY83KKqMA44y+uwgw5E48SuZWw1RSEJAhUGnSM4GLXKebBKvKn6tNW4Vdfg0ryqlWlhn
	2PHcMKt93j9WTfoSMUMaCXZRaPHkGMYA==
X-Google-Smtp-Source: AGHT+IEVS0EMW5+YUzuROLbK1pP+erdv1sbXdrakeuxuQx1ssbC7QlrMadTMdJ49F/XbA4Ay1I+Whg==
X-Received: by 2002:a05:6214:4015:b0:880:5a06:3a64 with SMTP id 6a1803df08f44-88d855df020mr637876d6.66.1766073137178;
        Thu, 18 Dec 2025 07:52:17 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c616751b1sm20448046d6.54.2025.12.18.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:52:15 -0800 (PST)
Date: Thu, 18 Dec 2025 10:52:12 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Ma Ke <make24@iscas.ac.cn>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/5] usb: ohci-nxp: fix device leak on probe failure
Message-ID: <6c056004-666f-467f-bbbe-a67aec4d5dac@rowland.harvard.edu>
References: <20251218153519.19453-1-johan@kernel.org>
 <20251218153519.19453-4-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218153519.19453-4-johan@kernel.org>

On Thu, Dec 18, 2025 at 04:35:17PM +0100, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the PHY I2C device
> during probe on probe failure (e.g. probe deferral) and on driver
> unbind.
> 
> Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
> Cc: stable@vger.kernel.org	# 3.5
> Reported-by: Ma Ke <make24@iscas.ac.cn>
> Link: https://lore.kernel.org/lkml/20251117013428.21840-1-make24@iscas.ac.cn/
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

For this patch and the 5/5 patch:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

>  drivers/usb/host/ohci-nxp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
> index 24d5a1dc5056..509ca7d8d513 100644
> --- a/drivers/usb/host/ohci-nxp.c
> +++ b/drivers/usb/host/ohci-nxp.c
> @@ -223,6 +223,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
>  fail_resource:
>  	usb_put_hcd(hcd);
>  fail_disable:
> +	put_device(&isp1301_i2c_client->dev);
>  	isp1301_i2c_client = NULL;
>  	return ret;
>  }
> @@ -234,6 +235,7 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
>  	usb_remove_hcd(hcd);
>  	ohci_nxp_stop_hc();
>  	usb_put_hcd(hcd);
> +	put_device(&isp1301_i2c_client->dev);
>  	isp1301_i2c_client = NULL;
>  }
>  
> -- 
> 2.51.2
> 

