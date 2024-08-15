Return-Path: <stable+bounces-69233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CF2953A39
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22F1282405
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B88C57CB4;
	Thu, 15 Aug 2024 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YluXFRO2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4F52F9B;
	Thu, 15 Aug 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747028; cv=none; b=jlta5hOBqwEU7jgWUeFTkQo0wcgw0/41GiNLYEcTf40azJjYYwku+iyOgo/ndBj5Kn1WCRUH7O1+mR5EFd8W70S1a9TzY2jzOcZAQT0hidleJUdLpD8jdGvkSz1WGq8PjlmmY1lK6LeRJkDNONBgW0RZ0n8islGd84XD8i787uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747028; c=relaxed/simple;
	bh=4lG2s/rEVm2gjXFIWtarixG3gAlFPSX+ad51Mmftc1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iru73gL7NwnP3mfCZwt1t50wqMcvVUWnrkd0+CxcGzqmsEnaXqHkARlxsFf+ys6vSExiuTlsj5mIw/LWf16T796U8U9fuFMXLNWOweX1izJ7jvcUXqw+EZ7cifXyCK4su5RTsYKVKyAuN0alVekrMZHX9hZR8PqsZYwz3oa2yBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YluXFRO2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201f44ad998so5008395ad.0;
        Thu, 15 Aug 2024 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723747025; x=1724351825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKTqjT3TquwJ/r4IxNLWBpgHb1WkHVd2dOTyt8t8Mag=;
        b=YluXFRO2/deCKe/VQK6EC8n84jZyOj2LGZuobgj7JjXuStf4aFP+KGNEDp4FpuVlYf
         gF/I8zIuJIUYMJbp81HqjWFRrgCfEZFccNvpXIeUM5pbm92IqViSvd8sd6ZUW5c2jAr3
         wkiEn8nCoTg0xYvt5KmD9o3XvYapG7w23z7ujN/0cV5wWrHHD3z08lPkDP0BgEkPLlF1
         wemKiWBZEQj+wr3PP8nYXVppfS6mrs9ztcZj7AM71J+VY2PjAvo/fKGz0b0BZff1ZYl+
         Bz0dxawymp+nSraB07S0dHzQJE/w2AH7E8aQrKUlPv5IuRwSR/+2GB3Fv1q1HoWmQwAH
         yyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747025; x=1724351825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKTqjT3TquwJ/r4IxNLWBpgHb1WkHVd2dOTyt8t8Mag=;
        b=EcQFHA9hguS0CtNUk6zl86Js0KQ5p2EkjhYPH7l+9MRECDAeljgd1+/xw/NVUGuXTa
         ji+pfKDMW4y/F4DjkW33NGQhoNoDtasFS/Mj5TtGUIQn0nHEfQAspUAva5jYXUwCj6aj
         dXRYxvPE+8pycVQuOZZAE4VFJDcHjgI2ocuErYahmORfDbZEMTvCaAf5yq6na/6xIA1j
         c8B81ChdldhUBSqb2Q38MN/uHnWW1LY+OIAv/wkSiceZq3IF8Q/yUIZk+YhFBUhTiwVC
         GggC8d86o8+7quRWFxYpq9G97r0NSFAZYA8tyi31FfEwFTkZO6LL9q18xqAa1LCESjHW
         wzlw==
X-Gm-Message-State: AOJu0Yzv1KhbOuiUgPXcp2EZQaCw/TAUZFBmillAWiNSOortAdorilQW
	9JFxsb2tn7zmKjAPbAvJdYqBBO/NXYttx1Xh/6g+gRsaZMg0Lcfe3NXeAA==
X-Google-Smtp-Source: AGHT+IFvQoh+5iEK4YTMqw3Pbc5USAXefKLvdjZzPfx2L8B8aUMLk5wwA8vterucXvmbo0xxCOtT+A==
X-Received: by 2002:a17:903:2303:b0:1fb:9b91:d7d9 with SMTP id d9443c01a7336-202062963e7mr2105505ad.26.1723747025294;
        Thu, 15 Aug 2024 11:37:05 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1ffe:470a:d451:c59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03756f6sm13013345ad.172.2024.08.15.11.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:37:04 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:37:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, javier.carrasco.cruz@gmail.com,
	Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: Patch "Input: bcm5974 - check endpoint type before starting
 traffic" has been added to the 6.6-stable tree
Message-ID: <Zr5KzoHvfO_F5e6k@google.com>
References: <20240815122130.72190-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815122130.72190-1-sashal@kernel.org>

On Thu, Aug 15, 2024 at 08:21:29AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     Input: bcm5974 - check endpoint type before starting traffic
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      input-bcm5974-check-endpoint-type-before-starting-tr.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I am confused why to pick this up only to have to pick up the revert? It
was not tagged for stable explicitly.

I'd expects stable scripts to check for reverts that happen almost
immediately...

> 
> 
> 
> commit 16ae8b10b473f96b7f63add2e928d8d437c83b07
> Author: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Date:   Sat Oct 14 12:20:15 2023 +0200
> 
>     Input: bcm5974 - check endpoint type before starting traffic
>     
>     [ Upstream commit 2b9c3eb32a699acdd4784d6b93743271b4970899 ]
>     
>     syzbot has found a type mismatch between a USB pipe and the transfer
>     endpoint, which is triggered by the bcm5974 driver[1].
>     
>     This driver expects the device to provide input interrupt endpoints and
>     if that is not the case, the driver registration should terminate.
>     
>     Repros are available to reproduce this issue with a certain setup for
>     the dummy_hcd, leading to an interrupt/bulk mismatch which is caught in
>     the USB core after calling usb_submit_urb() with the following message:
>     "BOGUS urb xfer, pipe 1 != type 3"
>     
>     Some other device drivers (like the appletouch driver bcm5974 is mainly
>     based on) provide some checking mechanism to make sure that an IN
>     interrupt endpoint is available. In this particular case the endpoint
>     addresses are provided by a config table, so the checking can be
>     targeted to the provided endpoints.
>     
>     Add some basic checking to guarantee that the endpoints available match
>     the expected type for both the trackpad and button endpoints.
>     
>     This issue was only found for the trackpad endpoint, but the checking
>     has been added to the button endpoint as well for the same reasons.
>     
>     Given that there was never a check for the endpoint type, this bug has
>     been there since the first implementation of the driver (f89bd95c5c94).
>     
>     [1] https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622
>     
>     Fixes: f89bd95c5c94 ("Input: bcm5974 - add driver for Macbook Air and Pro Penryn touchpads")
>     Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>     Reported-and-tested-by: syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
>     Link: https://lore.kernel.org/r/20231007-topic-bcm5974_bulk-v3-1-d0f38b9d2935@gmail.com
>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index ca150618d32f1..953992b458e9f 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -19,6 +19,7 @@
>   * Copyright (C) 2006	   Nicolas Boichat (nicolas@boichat.ch)
>   */
>  
> +#include "linux/usb.h"
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/slab.h>
> @@ -193,6 +194,8 @@ enum tp_type {
>  
>  /* list of device capability bits */
>  #define HAS_INTEGRATED_BUTTON	1
> +/* maximum number of supported endpoints (currently trackpad and button) */
> +#define MAX_ENDPOINTS	2
>  
>  /* trackpad finger data block size */
>  #define FSIZE_TYPE1		(14 * sizeof(__le16))
> @@ -891,6 +894,18 @@ static int bcm5974_resume(struct usb_interface *iface)
>  	return error;
>  }
>  
> +static bool bcm5974_check_endpoints(struct usb_interface *iface,
> +				    const struct bcm5974_config *cfg)
> +{
> +	u8 ep_addr[MAX_ENDPOINTS + 1] = {0};
> +
> +	ep_addr[0] = cfg->tp_ep;
> +	if (cfg->tp_type == TYPE1)
> +		ep_addr[1] = cfg->bt_ep;
> +
> +	return usb_check_int_endpoints(iface, ep_addr);
> +}
> +
>  static int bcm5974_probe(struct usb_interface *iface,
>  			 const struct usb_device_id *id)
>  {
> @@ -903,6 +918,11 @@ static int bcm5974_probe(struct usb_interface *iface,
>  	/* find the product index */
>  	cfg = bcm5974_get_config(udev);
>  
> +	if (!bcm5974_check_endpoints(iface, cfg)) {
> +		dev_err(&iface->dev, "Unexpected non-int endpoint\n");
> +		return -ENODEV;
> +	}
> +
>  	/* allocate memory for our device state and initialize it */
>  	dev = kzalloc(sizeof(struct bcm5974), GFP_KERNEL);
>  	input_dev = input_allocate_device();

Thanks.

-- 
Dmitry

