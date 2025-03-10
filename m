Return-Path: <stable+bounces-122877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7E8A5A19F
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228C83A82EF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D324F233155;
	Mon, 10 Mar 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="seh49vo2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C22309B0
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629995; cv=none; b=OQHL8aT/zH+7HiNsmpcVld2AqbqmjtahsnxpTU3WBUi+M/Wqqryd9peZJoqiVucbwdGNbXR7kbJaX3GXCgiT4qYaPrznSs1cUKvwTBswnYofmoOqqCxRJ4Y7z+x4vpyh2UJtR225sLgIthe58Zjydry9rV1nezE/q68FIrVvRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629995; c=relaxed/simple;
	bh=79NoslWFokmPF3M7/bKxqWenIFPB3+bRkcmISSkX+ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeOte9GPM0X6G9f7KQb2V6Q0P2+XLTLtsMk5r38qlk4A4sZb1gbIC+hXlYSV856sSTxLbG/xREXonM9T5thbM5dDh92GG6DG3ouzDv5mLOkLqcNvDwYZ1B2bIDwDKROwlOyuS1JVwQZJE7xad8JJnFXYd7smfSST1IxadFH8paU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=seh49vo2; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c3c4ff7d31so531610385a.1
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741629993; x=1742234793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCbplbGo+wXAErff6OKF5gDHtfLPjvXhdrCE0hTtOQY=;
        b=seh49vo2icOw7VzqrPiotl5ZTi9vDAfyUOdsDz/mdeHfmvCxLlGiWj4gj+qVFGxjYZ
         fe+jvgC+u9Bd4vvsTejtyEyrIwlFji5dP8StviOmbjR2PB7mmNqF0PNqIL4B87AUb6JS
         I0o0EgOYV8o8gQiLWjjaNwVas+KuWtMeSbeyJAnSZLsxNVZSajwp0DtE0EeyFyPOXA6H
         EdhuQTZcG6AaeauaLvtVoE2gH4ZolAlJfsB0KEyDYtK8gf69VWkU6vkiL9zje/EOsxRd
         ZXKcl194pWd9Jg3YxXklQYTWOxcSVoBgH6DH4FvzWaMgxYmP8/vdBXGpgSrnlLRwPyz8
         RB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741629993; x=1742234793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCbplbGo+wXAErff6OKF5gDHtfLPjvXhdrCE0hTtOQY=;
        b=DHbJljsw1rEGBU/XHRjAKPSpaUm/evdNH8f/RFKMs2szzAMyeERbS9OUubXkWk0cZV
         4nqS4Vfo/Ve+f+ZQsrafdDZ+WZBXDmyCqfOh6boxoddeiGS6RtbuVKrG7xwYAbNAQ84b
         RbRw2xx6539OeoYbOQoW6AHh+xFJG/1Ba9MRs4Rp6OaXgeY37RVmQ9ppd977a8AIJzXq
         X2QeXF3//1Tl65XMPei8eH6T7znW1jwNSvVyIlkraCb1ftFm5PNsCyS22ZlKkq/tEevk
         Xqw+Gu5YE+TnbjmVx7hZ4lWTkw5Zi6jl1zv4n5dMxkx4nNMwqKcl0KgBHXQ6IZ/jnP9e
         S4cg==
X-Forwarded-Encrypted: i=1; AJvYcCXvRM+jeWRMYg3TvqXCYZ5k6aOFaX/Th3NN2D4CzD8/V9EXfyBKS+lrIs+zibXnhAfS/AcIxpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQwgAWHwFBt7lSUGbuxtoiTsA5dFyFIhweNdP4xLj8pJ86iaC
	Mx4DqxCTvmYQOHS4KBlDa0UmucyIX6Sb7xA453qZU6xAgzrqvTkg8yt1gyYOKw==
X-Gm-Gg: ASbGncs1U8sab6qY8RZqn/1oUxzTUwrrW/BT3xY8sCsqgEE/4Mcx/7sn7V43xGNvAxC
	eIXQo4l7j5iBWsmAx87BAsmHOd45fGUy3fUE0UKSXkJk9U9fah4qXANiYIkQiu5q4M5o8xYf4Pt
	r8a+gEOQVJq1D09Z+KLqFEW9gGx52zdOq1rcxI17bph0vVN6OLKYdCKzGOqXySRa2Ta10Rfwu2c
	5L9h8DivYDjTuPT7UN8mcSOzAJ39DM7RWbe7TJgISw0Amc8pe+mpAzm11vSjz46FV3XnaDLmXVT
	Xek7L/iLoERRY6UUJxLNkihleUTm+N0jVxwsHED1MIRhqvIz1rLHfg3JUNPP5yu15qEY6J/q14x
	3X3GhWkxrKUsRWj28U+XC9nW6j6ndeKk5gSukdw==
X-Google-Smtp-Source: AGHT+IGBXTLd9FGucbRKIujIIutoo5xIGlcogc24jO38Y8DB5mhjUv+LLAgNLG3yRzzvwDJkN5rqHg==
X-Received: by 2002:a05:620a:84c4:b0:7c5:5a51:d2c0 with SMTP id af79cd13be357-7c55a51d82emr378482285a.52.1741629992671;
        Mon, 10 Mar 2025 11:06:32 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e54ffa55sm703579985a.81.2025.03.10.11.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:06:32 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:06:29 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: netdev@vger.kernel.org,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-list@raspberrypi.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: lan78xx: Enforce a minimum interrupt polling
 period
Message-ID: <d52e460d-2c73-4117-95b9-bed3892ac41d@rowland.harvard.edu>
References: <20250310165932.1201702-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310165932.1201702-1-fiona.klute@gmx.de>

On Mon, Mar 10, 2025 at 05:59:31PM +0100, Fiona Klute wrote:
> If a new reset event appears before the previous one has been
> processed, the device can get stuck into a reset loop. This happens
> rarely, but blocks the device when it does, and floods the log with
> messages like the following:
> 
>   lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
> 
> The only bit that the driver pays attention to in the interrupt data
> is "link was reset". If there's a flapping status bit in that endpoint
> data (such as if PHY negotiation needs a few tries to get a stable
> link), polling at a slower rate allows the state to settle.
> 
> This is a simplified version of a patch that's been in the Raspberry
> Pi downstream kernel since their 4.14 branch, see also:
> https://github.com/raspberrypi/linux/issues/2447
> 
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Cc: kernel-list@raspberrypi.com
> Cc: stable@vger.kernel.org
> ---
> For the stable crew: I've *tested* the patch with 6.12.7 and 6.13.5 on
> a Revolution Pi Connect 4 (Raspberry Pi CM4 based device with built-in
> LAN7800 as second ethernet port), according to the linked issue for
> the RPi downstream kernel the problem should be present in all
> maintained longterm kernel versions, too (based on how long they've
> carried a patch).
> 
>  drivers/net/usb/lan78xx.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index a91bf9c7e31d..7bf01a31a932 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -173,6 +173,12 @@
>  #define INT_EP_GPIO_1			(1)
>  #define INT_EP_GPIO_0			(0)
>  
> +/* highspeed device, so polling interval is in microframes (eight per
> + * millisecond)
> + */
> +#define INT_URB_MICROFRAMES_PER_MS	8
> +#define MIN_INT_URB_INTERVAL_MS		8
> +
>  static const char lan78xx_gstrings[][ETH_GSTRING_LEN] = {
>  	"RX FCS Errors",
>  	"RX Alignment Errors",
> @@ -4527,7 +4533,11 @@ static int lan78xx_probe(struct usb_interface *intf,
>  	if (ret < 0)
>  		goto out4;
>  
> -	period = ep_intr->desc.bInterval;
> +	period = max(ep_intr->desc.bInterval,
> +		     MIN_INT_URB_INTERVAL_MS * INT_URB_MICROFRAMES_PER_MS);

This calculation is completely wrong.  For high-speed interrupt 
endpoints, the bInterval value is encoded using a logarithmic scheme.  
The actual interval in microframes is given by 2^(bInterval - 1) (see 
Table 9-13 in the USB 2.0 spec).  Furthermore, when the value is passed 
to usb_fill_int_urb(), the interval argument must be encoded in the same 
way (see the kerneldoc for usb_fill_int_urb() in include/linux/usb.h).

The encoded value corresponding to 8 ms is 7, not 64, since 8 ms = 64 
uframes and 64 = 2^(7-1).

> +	dev_info(&intf->dev,
> +		 "interrupt urb period set to %d, bInterval is %d\n",
> +		 period, ep_intr->desc.bInterval);

I doubt that this dev_info() will be very helpful to anyone (in addition 
to being wrong since the value in "period" is not the actual period).

Alan Stern

