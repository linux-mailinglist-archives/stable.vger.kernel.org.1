Return-Path: <stable+bounces-56916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381209254BA
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 09:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603901C2168B
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1421F4502F;
	Wed,  3 Jul 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUAuwzUN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6424DA14
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992238; cv=none; b=LVRHPBCTQoS6J8+YwXFNK2Y+nhZUf3DXKrdlSfF5pEF9yYxxfVAY92X4KfUKuOSxEUHCIvmLYWc6RO+JT8qAy2daiA5MMYgtOESeBiB1tQg/CsTfSW76rkOfFMms0wsn/V+JuiKrGhjPEhzfoNH8uy50L2LIsx3YJ74ok+BA+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992238; c=relaxed/simple;
	bh=3/2xUJWJqL2AVXcUeDubHF554/b8IyfHiqe+6Tj6uik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLuiieOHnDUuLPesK+LmSN8g95hgLxUwXfoP0ow64xI4SjRSGSJkQooJODkk4o5el8hOE6GF1R+wGOCVF3Z2IlTwCbSZdj9iByjdj/HsNIX5J8SPtOiFt1kEVy4981ojBi/Z6ksldtM+t5YcR3TcShRykrU1nTC0BC64frdb2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUAuwzUN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab8cso3348089a12.0
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719992235; x=1720597035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMl4iRO1YuDlX2Ud//wZYwgLTyyIvMk1jNwwBPa+My8=;
        b=BUAuwzUNHmuPeA4w6BL2Gbs5v3BlY+8gC49A5VjJ1CuEK6Rm4GIqzy78HHCX3RMJry
         sVtFAhfJFxWY6v/6G+3lIpmiSQy5VUAW50AyFkoSQu3RqDvfK1KhTNNIiOaSI/Ca2Deb
         mGDqR7ukR//tttk+fGov2PWwQSED4OiKtAvz5H2zR/e7KmjLHwjt4Of02mBmMColhXTB
         +vFZW06wEGVXUczESxfigb4LN/e2pFF2481nJGy/dAUfPvnOqhjqeOMwv9n8BGgat/d2
         Tyo7pC/EcoDHAG+ZopjEA9CtDwx+V3WuGysDLXv9iQatCnDRz8DH+wlU2gUvGbuLVUY9
         OrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719992235; x=1720597035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMl4iRO1YuDlX2Ud//wZYwgLTyyIvMk1jNwwBPa+My8=;
        b=Px05ElyAqIW8FauYNP56kJX6/GC19lYj4acWi9inZeeXT+t5cEprL7IVyoOq+n8TDS
         eAt/amqKs7L74YxVbod7YpD0dqA90ZG2yOahnAaUer7g1oadjcjVqzkU4L2lhRE8C7Sw
         22ZctC9778vcIP1BDnLwnrY1KfozyQekZNKSN8sD7HZAp/pheTBmA+Gje6I+qhYyoC8k
         /Z5VcLXfa///P0lYDZsNYuYey8PxX3Qb/2L+T95wOQSPUHzWdJkmRi1+mATe5clnu+wW
         wp5Fmpch8XbtghKNdI2nSMisxB6iKScQ9ZeUd1tHwVMaCmNwD+8q5lVPhLoNMWgaoBtt
         m6qg==
X-Gm-Message-State: AOJu0Yy+90FsgbekmUYp5TITeQRjjkVeY3KCGzwsgUti8Rsv5U8QLdQ/
	YzsEdDJXkrLPMSoj42afsM47x9YcEYG5EF1AxLpOcMfXwAdN5xDE
X-Google-Smtp-Source: AGHT+IH/ddLtxXmfcBR5QwiJFprQt4iRv2LQvAMdxb/ujTTIzlNpb3AJXn7VGlt51cO3XxyBPG+oBA==
X-Received: by 2002:a05:6402:440a:b0:57c:b7c3:99f1 with SMTP id 4fb4d7f45d1cf-5879f59a549mr7443851a12.11.1719992235377;
        Wed, 03 Jul 2024 00:37:15 -0700 (PDT)
Received: from eichest-laptop (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324f036sm6661701a12.34.2024.07.03.00.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:37:14 -0700 (PDT)
Date: Wed, 3 Jul 2024 09:37:13 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	francesco.dolcini@toradex.com
Subject: Re: [PATCH 6.1 091/128] serial: imx: set receiver level before
 starting uart
Message-ID: <ZoT_qUw9BGuZ0Alm@eichest-laptop>
References: <20240702170226.231899085@linuxfoundation.org>
 <20240702170229.664632784@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702170229.664632784@linuxfoundation.org>

Hi Greg,

On Tue, Jul 02, 2024 at 07:04:52PM +0200, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> commit a81dbd0463eca317eee44985a66aa6cc2ce5c101 upstream.
> 
> Set the receiver level to something > 0 before calling imx_uart_start_rx
> in rs485_config. This is necessary to avoid an interrupt storm that
> might prevent the system from booting. This was seen on an i.MX7 device
> when the rs485-rts-active-low property was active in the device tree.
> 
> Fixes: 6d215f83e5fc ("serial: imx: warn user when using unsupported configuration")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Link: https://lore.kernel.org/r/20240621153829.183780-1-eichest@gmail.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/imx.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1978,8 +1978,10 @@ static int imx_uart_rs485_config(struct
>  
>  	/* Make sure Rx is enabled in case Tx is active with Rx disabled */
>  	if (!(rs485conf->flags & SER_RS485_ENABLED) ||
> -	    rs485conf->flags & SER_RS485_RX_DURING_TX)
> +	    rs485conf->flags & SER_RS485_RX_DURING_TX) {
> +		imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
>  		imx_uart_start_rx(port);
> +	}
>  
>  	return 0;
>  }

Unfortunately, I introduced a regression with this patch. The problem
was detected by our automated tests when running a loopback test with
SDMA enabled. Please do not apply this  patch to any stable branch. I
could provide a fix for mainline on top of this change, or would you
prefer to revert it for now?

Sorry for the inconvenience,
Stefan

