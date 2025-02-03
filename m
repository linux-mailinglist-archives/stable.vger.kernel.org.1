Return-Path: <stable+bounces-112041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D6A25F70
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 17:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2591654EA
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459820A5CB;
	Mon,  3 Feb 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="TaioHuJd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA45202C2F
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738598562; cv=none; b=dxihH6c41kalI8eiopI5dUWrGVX5jzx4zsbLMHHQjlucoAxyYT6qYuBzq6CZ9R6/jWDak6uEqmpGF8pmDAIEx86li3o3SWs0hSjN7wrLoeY1YZq7uimhP4fPlLJfLl6pAN+CpKy6BQP8rOxKukOgAbxMCdaLxdGMIU90CbZOxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738598562; c=relaxed/simple;
	bh=sDk+aBkk9q+OypnxJbdPIdTa9fK9F+Kj7CyFeHwcuUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK7KYPoRgjQ3oFnM0mO4l2g3aFQftQK/r/Kg+7bOtCSes8DQQMP/CJBskFEdG2q0vEYCxhTNb5HamU0oa1htLIJnq/VUKN7LS9OfI8yBBZl2JtcfpUb0k2OL30xHQp9+xC4BhwMg3FCvnyRdrynLU0OZpV8pvlb0xTLAPSO8TIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=TaioHuJd; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46c8474d8f6so34503061cf.3
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 08:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1738598560; x=1739203360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6y7ZNUaq1V6kS4V4CjLbL07j92Sevuw+/xeWgjypQrQ=;
        b=TaioHuJdQRVwxYmDvIiytqEDmGZK4FdJ2HSdNNI47A4TfHxYrjs7Req92VKYcuNSQn
         Z9C06f2SRIEAMw8wiHYq/2ohWo6aUn1qGDRBoV3Dal1IZXFmrsRowTE1fiEvauIyw3Ei
         yyeDp81WgInFIZU3SRvhGzfXQkIy/CpjXEK5JK26vSRSJCb5O+4+CiMhTEGdsUi1uUip
         Zix3FrP86SpERYkwep4fwm+Z1Clm9+ro5gvaogI3ZbDtV6iJMRh65z1tVXBeXwxDYLpg
         Omsb+IJlgqA8qGj6kdoY6j3bZcakzfys34UdB+Uog1xpr/TVqm6TrFh1rXyHupZ7hA6J
         UtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738598560; x=1739203360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6y7ZNUaq1V6kS4V4CjLbL07j92Sevuw+/xeWgjypQrQ=;
        b=fqHr9xem3CNvQjNBxfkf2CQgsuMe9PHphbQ2OK1bxHqD/ba3YDam8l8iMpiHYV0lC1
         3VX8+mqiHH0/S98VPzOq1tp2MXFuKas7NCrikQBDZ446PJW5ejIfagTIcCC3KrlXPrew
         s5Gmiws3pND441dXg2YhO5b0C1M/glJ4jI5NyivLORoOILJrwTI/JljYYdQQo3w3m4De
         /osspm/m0065JgP41vE8GPctFo9DEM2IKzPzfDo8xY6K2Sm9JX2sA7JyxE5JuR5dkUbA
         gcLerTOEEc/MJDAACQ14pulLe4+SqsyKGLVnVYHVpd2tGKoJJ0JsPhKv2OICPGOjmkqP
         0kgA==
X-Forwarded-Encrypted: i=1; AJvYcCUN33RD0ah3X6+6plQQ5GZQA81BpaE5BJaoaASSiAjEJBVqnviSRVtPp7rfIDoMRnpuX/1NNkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgoRcSSCgdwj6F1vRlyZlINCTT6lZCibnrU2sTaPjMSUDk0+V
	hpfSUkNN3lE6df5FbwN/NsL5EksL16GadNaARBzhNZX/gLan9z1/4nMt4krCkw==
X-Gm-Gg: ASbGnctpJ8HsJgeisVF7zhnR9/udizQFT1jHICWJbk8SgyX+y2UEmIrAawua5Lle0+C
	arIXf53orC1lF4lcQRVjTXbLN//Bchb+LiJV9jYGVnmn8tvUHf8RaLu3qtSjiVvmyYtZL8zhtAz
	aYGIng/+hlGPvuCXxcMcdmNtPyu6mqz5zGDgBoGNTSt7IeRHSols1Wz/MaZdO8oHXa/d3BOqGEo
	ORliKixL5ceInUkXBOQfZ/pmCj6Ay4zHPGYU+XL7nJ4SirR/ZtXszI6TxFdsE237A8SmTb74BDB
	YUcel75W02w2clKiq+WcoICbwS87ub7+Uw==
X-Google-Smtp-Source: AGHT+IFcbbmmge+3vZw0NuSyEFXhPY//WibCANRMTGQbBY4sp5JCdlKvRshBkh9waSTBcHXSETI5Uw==
X-Received: by 2002:a05:622a:118c:b0:467:4fc5:9d72 with SMTP id d75a77b69052e-46fd0b6b823mr283818731cf.36.1738598559880;
        Mon, 03 Feb 2025 08:02:39 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf1740bcsm50017611cf.64.2025.02.03.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:02:39 -0800 (PST)
Date: Mon, 3 Feb 2025 11:02:37 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: gregkh@linuxfoundation.org, francesco.dolcini@toradex.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: core: fix pipe creation for get_bMaxPacketSize0
Message-ID: <aa0c06f6-f997-4bcf-a5a3-6b17f6355fca@rowland.harvard.edu>
References: <20250203105840.17539-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203105840.17539-1-eichest@gmail.com>

On Mon, Feb 03, 2025 at 11:58:24AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> When usb_control_msg is used in the get_bMaxPacketSize0 function, the
> USB pipe does not include the endpoint device number. This can cause
> failures when a usb hub port is reinitialized after encountering a bad
> cable connection. As a result, the system logs the following error
> messages:
> usb usb2-port1: cannot reset (err = -32)
> usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
> usb usb2-port1: attempt power cycle
> usb 2-1: new high-speed USB device number 5 using ci_hdrc
> usb 2-1: device descriptor read/8, error -71
> 
> The problem began after commit 85d07c556216 ("USB: core: Unite old
> scheme and new scheme descriptor reads"). There
> usb_get_device_descriptor was replaced with get_bMaxPacketSize0. Unlike
> usb_get_device_descriptor, the get_bMaxPacketSize0 function uses the
> macro usb_rcvaddr0pipe, which does not include the endpoint device
> number. usb_get_device_descriptor, on the other hand, used the macro
> usb_rcvctrlpipe, which includes the endpoint device number.
> 
> By modifying the get_bMaxPacketSize0 function to use usb_rcvctrlpipe
> instead of usb_rcvaddr0pipe, the issue can be resolved. This change will
> ensure that the endpoint device number is included in the USB pipe,
> preventing reinitialization failures. If the endpoint has not set the
> device number yet, it will still work because the device number is 0 in
> udev.
> 
> Cc: stable@vger.kernel.org
> Fixes: 85d07c556216 ("USB: core: Unite old scheme and new scheme descriptor reads")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
> Before commit  85d07c556216 ("USB: core: Unite old scheme and new scheme
> descriptor reads") usb_rcvaddr0pipe was used in hub_port_init. With this
> proposed change, usb_rcvctrlpipe will be used which includes devnum for
> the pipe. I'm not sure if this might have some side effects. However, my
> understanding is that devnum is set to the right value (might also be 0
> if not initialised) before get_bMaxPacketSize0 is called. Therefore,
> this should work but please let me know if I'm wrong on this.

I believe you are correct.  This is a pretty glaring mistake; I'm 
surprised that it hasn't show up before now.  Thanks for fixing it.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

In fact, it looks like usb_sndaddr0pipe is used in only one place and it 
can similarly be replaced by usb_sndctrlpipe, if you want to make that 
change as well (although this usage is not actually a mistake).

Alan Stern

> ---
>  drivers/usb/core/hub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index c3f839637cb5..59e38780f76d 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -4698,7 +4698,6 @@ void usb_ep0_reinit(struct usb_device *udev)
>  EXPORT_SYMBOL_GPL(usb_ep0_reinit);
>  
>  #define usb_sndaddr0pipe()	(PIPE_CONTROL << 30)
> -#define usb_rcvaddr0pipe()	((PIPE_CONTROL << 30) | USB_DIR_IN)
>  
>  static int hub_set_address(struct usb_device *udev, int devnum)
>  {
> @@ -4804,7 +4803,7 @@ static int get_bMaxPacketSize0(struct usb_device *udev,
>  	for (i = 0; i < GET_MAXPACKET0_TRIES; ++i) {
>  		/* Start with invalid values in case the transfer fails */
>  		buf->bDescriptorType = buf->bMaxPacketSize0 = 0;
> -		rc = usb_control_msg(udev, usb_rcvaddr0pipe(),
> +		rc = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
>  				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
>  				USB_DT_DEVICE << 8, 0,
>  				buf, size,
> -- 
> 2.45.2
> 

