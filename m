Return-Path: <stable+bounces-60650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DD2938720
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 03:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060A81C20CC5
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 01:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F984A31;
	Mon, 22 Jul 2024 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="UqVoU5D4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A94C6E
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610448; cv=none; b=g6QLQGrsiX5IiyuAiuVBKDJ2cAbDyStGgXbl0Yjj8vXyhGF03pCWBaD9SCCV3hfR7hiKi+2c/CSik0A8W4PoYpl0OxdpTNEmcDsAZeuU9svEuN5VcfvsHrQc2jCSh/EZySwsqJqAEbNTMNX2KZ83kqc/3b9mQUhz5TMzQAuC+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610448; c=relaxed/simple;
	bh=TSmfXgnydARLwr7mv0kzl+RBgKIwOhswaVDeCGIIVsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEzHuHAsbmDEiWSVs9KfzpETaxW+YWcVMqXWJxCewhTqWZFn5yFn87yL27WbudUm99pfm4PJxprSx1HI+gsOpzqz2Ytg0/g6QwTfMozvEF32ND4HXrfLFJqHazRWFCMe0k0YektA7J4pyAcnY8qjFKftnrYqPMrV1RJHLG23vZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=UqVoU5D4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79f178e6225so239161885a.2
        for <stable@vger.kernel.org>; Sun, 21 Jul 2024 18:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721610445; x=1722215245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAHiE58iDMnOq7mpXPmqVzhRum0LLcYC2L+ZB58l620=;
        b=UqVoU5D4q4F3vw9mqbZxyGwMLKlzaY87cl2DV8Gnw1eiwWMk3yfXuyjmdBR2SIxOZA
         sncd2HrnE3LFegeDK4Sav1jlmcDG6En7b2hJG9JZfnd31ShVSIeD1pXjw9UZI0ViETzt
         UOCHW6iYE6VDWLxNZMju+0CNrvjHfBPg0FkMsVM9QfPH5GBy3EkB4kaC8H5LjfEDJs03
         gTrUS0s2X9ZqnJsQ1ICy208uCXUhBrGyMBD9Od6AV4yYLAtFvlXYgqLU7+JcDNkrIzTj
         2PABlgugPMsF6q3yCcBobwX0LR0DKr4WBYn3EPFmCIYNS4+DhaPgbFm7vcBPVGBf8vAX
         J8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721610445; x=1722215245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAHiE58iDMnOq7mpXPmqVzhRum0LLcYC2L+ZB58l620=;
        b=kWa1MNiVGL3159SXmSIiiQ/934eEw9ANddSKX4zvAW1LK5abTwhOOMKeN48m43Lx5/
         dE7umTde61GuzEPft+ep/I7Dpr6n3IS6O++2jivyC652S/sNUDhqBDL5xH6QkaV+/uTv
         wEkEw4ZgDTZoPhslZHEm2uSLqn06t4i7TdCgz++VRWQGXGxecKmfMWapWKF0ucVemvrk
         Bt2I2Vm+DyXlK5wjYHOs/Uj0aTHmYDjIEybL9GTtXZEiRk6DRHJSfAsgGGx58+YSbZRf
         X/I82fAr5ebvdrgf4YZzI/8j3RMz49sgUAo/sUGWaatQlfihEmx34SVBKDdqIrFucdGS
         blWA==
X-Forwarded-Encrypted: i=1; AJvYcCUOsED1TIhML8Nl95eTkH4ecs3n1ox0zsvAI3rupsj2zV8oTs60IIiArPiQOAAkIzJ/tl29Jy1kJWdEqW8vZJDZ86tYDeho
X-Gm-Message-State: AOJu0YyDBUwcB+fUhEOLp39Vp5oBxclWJU3EZW4H3A3t4uOniSGchAkp
	RNMtry6kk1Ji3kOmZWzYi8ncYIe6nBa9CAE+g3nTvXCa8PMHPaNDcZtcT99jww==
X-Google-Smtp-Source: AGHT+IH9pnVMRWIV3YKK+JwL6olh4K3erV80NpJ3mXsnmlqGMvAHvjzn6pvEYnaMSnwmCMPoU9uY+Q==
X-Received: by 2002:a05:620a:3954:b0:79f:4b5:3697 with SMTP id af79cd13be357-7a1a667f968mr641629585a.63.1721610445036;
        Sun, 21 Jul 2024 18:07:25 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::179c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198ff997esm308267985a.56.2024.07.21.18.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 18:07:24 -0700 (PDT)
Date: Sun, 21 Jul 2024 21:07:21 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: crwulff@gmail.com
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roy Luo <royluo@google.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: core: Check for unset descriptor
Message-ID: <29bc21ae-1f8a-47fd-b361-c761564f483a@rowland.harvard.edu>
References: <20240721192048.3530097-2-crwulff@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240721192048.3530097-2-crwulff@gmail.com>

On Sun, Jul 21, 2024 at 03:20:49PM -0400, crwulff@gmail.com wrote:
> From: Chris Wulff <crwulff@gmail.com>
> 
> Make sure the descriptor has been set before looking at maxpacket.
> This fixes a null pointer panic in this case.
> 
> This may happen if the gadget doesn't properly set up the endpoint
> for the current speed, or the gadget descriptors are malformed and
> the descriptor for the speed/endpoint are not found.

If that happens, doesn't it mean there's a bug in the gadget driver?  
And if there's a bug, don't we want to be told about it by a big 
impossible-to-miss error message, so the bug can be fixed?

> Fixes: 54f83b8c8ea9 ("USB: gadget: Reject endpoints with 0 maxpacket value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Wulff <crwulff@gmail.com>
> ---
>  drivers/usb/gadget/udc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 2dfae7a17b3f..36a5d5935889 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -118,7 +118,7 @@ int usb_ep_enable(struct usb_ep *ep)
>  		goto out;
>  
>  	/* UDC drivers can't handle endpoints with maxpacket size 0 */
> -	if (usb_endpoint_maxp(ep->desc) == 0) {
> +	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
>  		/*
>  		 * We should log an error message here, but we can't call
>  		 * dev_err() because there's no way to find the gadget

This will just hide the error.  That's not good.

Alan Stern

