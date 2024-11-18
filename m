Return-Path: <stable+bounces-93820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 184BB9D177B
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C01B231A2
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD511C0DED;
	Mon, 18 Nov 2024 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xt6gsZNy"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF20199EB2
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952709; cv=none; b=E8/oK4q7v+zf7c404EZ03FLVdxqeQV74x4cJHj91+0sC51m72S+OCEe8WVTZXf+pdCLglOvimb0D8zDps627TyohrDD91bfZPqRNaz9yeZEkuSk1eqB3kZ1zQ4rG0EYTbiWZZfTphriLvCTMOtQpAYINnsEpBI3I2TejXoVDTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952709; c=relaxed/simple;
	bh=laZIAQktD4QzqPlaVyKPfOrBu4SfRyQ3/OCJp+BYGEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXBkS2tAUn8mBDgFZAxc4YHdMyQZeuTt5gdLh6Zyi8xg8XB0DvgDxxRWXVuIu2NC3o6O/DY8GgtvD2nSLlB3wLgcGzs2bMlTvMp9pXM4JbFBkSL71OvHP6Q2i5YeRbbw2jYkPvAV+ciYr2f39nH6eBH7zPhTbFnImprybc5mC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xt6gsZNy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53da4fd084dso4610488e87.0
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 09:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731952705; x=1732557505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QlLGnW7dtwwICLyvfGuSa1NcQ36vNNOBbZLVzsySdLE=;
        b=Xt6gsZNyA25zn3g2Sek8XJQDvzW8ZZCWx1YaqNPy10mtBbE1ZuVZUp8JVxqQwHok2c
         kLukUMEEog2WVZR0AlbMRFvy/vD0tQbcHc3blIKJT+hUWWFN+qwLvCDJNoIJyEqckdIJ
         sy52Byvc0sHVmnfvaMrLnnrQ1fLBaElJs7U90slxL5J0wPBrtw79iYsx3hc6knZ0Uz+4
         7ZRB7eny02MSn+rL/n5BTyLmyyUa57v6KEpfK2J6h/zcfswAcwfzKa9LqgP0oz1Dzbgm
         70Ri04EyxY7I9M9cRtO362z2nG24MekVyfv/TxJhL2V4eS679+B8CApyLZg3WHvI0Eyf
         f/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731952705; x=1732557505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlLGnW7dtwwICLyvfGuSa1NcQ36vNNOBbZLVzsySdLE=;
        b=EIrPgeqRybBF+dH3Y6fdAl6m3PW+49g2TIiK/QE3kvcuJ0W7Me/QUdZ/1W4cxZyfkS
         9Widu2TecQGWDTnroW3izd0l+xWlr6dwAhuFniSrP4F7T9t8M1Oxe6IG5+1na0vOztnd
         nE3qzC+XddQXL86+K5KiVnIUc1VzSSjoVZXSqWhLGYALKWHNR648SRdo1Frfni8Xdq08
         gzuAnjy3qwLaxDVI83eivaktOv4ZhrTKI/QMgMVlDjeQAQYIRMnMWFM9xSeCNdBgUru5
         5sH7bU8RxTxAZo3TvmQDyWNCGjWAkQvvvJ/4ZMACD5JSlYmzxk6gZeJDT228FcVLP/xW
         s3jw==
X-Forwarded-Encrypted: i=1; AJvYcCUFR//ZGLN8DczmD+uycgzvNvScW66xCcYQP7Thlx2/4XGcnsQPEJFLWUm66ra6WNrdXh1OsSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkwvRYROKW4q/HNRTsMdumcukgbZQo5OgPokNnIdoOfqS0vSuZ
	t78IsMfNMefC+bJQ+EdW3Cl+ySf9CRjcPeQQLRWtnMem7Zov9Gja0xJ6890Wciw=
X-Google-Smtp-Source: AGHT+IF+k106SySWsa5RW6D8wDsdbeikotHZLceTzJqS77LXkttXhrPKvuUPvkQI0pZUabYUcvomPg==
X-Received: by 2002:a05:6512:31c7:b0:539:f84d:bee1 with SMTP id 2adb3069b0e04-53dbd4a08b4mr104842e87.17.1731952704554;
        Mon, 18 Nov 2024 09:58:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd472359sm18758e87.198.2024.11.18.09.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 09:58:23 -0800 (PST)
Date: Mon, 18 Nov 2024 19:58:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Benson Leung <bleung@chromium.org>, Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: ucsi: Fix completion notifications
Message-ID: <5iacpnq5akk3gk7kdg5wkbaohbtwtuc6cl7xyubsh2apkteye3@2ztqtkpoauyg>
References: <20241104154252.1463188-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104154252.1463188-1-ukaszb@chromium.org>

On Mon, Nov 04, 2024 at 03:42:52PM +0000, Łukasz Bartosik wrote:
> OPM                         PPM                         LPM
>  |        1.send cmd         |                           |
>  |-------------------------->|                           |
>  |                           |--                         |
>  |                           |  | 2.set busy bit in CCI  |
>  |                           |<-                         |
>  |      3.notify the OPM     |                           |
>  |<--------------------------|                           |
>  |                           | 4.send cmd to be executed |
>  |                           |-------------------------->|
>  |                           |                           |
>  |                           |      5.cmd completed      |
>  |                           |<--------------------------|
>  |                           |                           |
>  |                           |--                         |
>  |                           |  | 6.set cmd completed    |
>  |                           |<-       bit in CCI        |
>  |                           |                           |
>  |   7.handle notification   |                           |
>  |   from point 3, read CCI  |                           |
>  |<--------------------------|                           |
>  |                           |                           |
>  |     8.notify the OPM      |                           |
>  |<--------------------------|                           |
>  |                           |                           |
> 
> When the PPM receives command from the OPM (p.1) it sets the busy bit
> in the CCI (p.2), sends notification to the OPM (p.3) and forwards the
> command to be executed by the LPM (p.4). When the PPM receives command
> completion from the LPM (p.5) it sets command completion bit in the CCI
> (p.6) and sends notification to the OPM (p.8). If command execution by
> the LPM is fast enough then when the OPM starts handling the notification
> from p.3 in p.7 and reads the CCI value it will see command completion bit
> and will call complete(). Then complete() might be called again when the
> OPM handles notification from p.8.

I think the change is fine, but I'd like to understand, what code path
causes the first read from the OPM side before the notification from
the PPM?

> 
> This fix replaces test_bit() with test_and_clear_bit()
> in ucsi_notify_common() in order to call complete() only
> once per request.
> 
> Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for command handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index e0f3925e401b..7a9b987ea80c 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -46,11 +46,11 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
>  		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
>  
>  	if (cci & UCSI_CCI_ACK_COMPLETE &&
> -	    test_bit(ACK_PENDING, &ucsi->flags))
> +	    test_and_clear_bit(ACK_PENDING, &ucsi->flags))
>  		complete(&ucsi->complete);
>  
>  	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> -	    test_bit(COMMAND_PENDING, &ucsi->flags))
> +	    test_and_clear_bit(COMMAND_PENDING, &ucsi->flags))
>  		complete(&ucsi->complete);
>  }
>  EXPORT_SYMBOL_GPL(ucsi_notify_common);
> -- 
> 2.47.0.199.ga7371fff76-goog
> 

-- 
With best wishes
Dmitry

