Return-Path: <stable+bounces-104530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1909F50CB
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA81B188064A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEA81FBCB7;
	Tue, 17 Dec 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="alRyg0p0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8D1FBCAD
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452057; cv=none; b=mPf7pNWALf4Red1AEM47SEX5izVambWzZLZZ/KRCSfHLXjY3b66N0XJUzGezYMuStPo6KodDrIFmys37vwg7N9dxaqyXPHnvbKsI8YWNzfsEgVfA3sa38htCmdBKe1bfv/NkZjZitPuvsOt955Q9Rb+JNBzyLb+dgD22UE8diYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452057; c=relaxed/simple;
	bh=J6QwD7x+lm5XadIBl1uLohp69xgLjMMyXU1tNM/lWUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM8WM/n8KqSjMTGJ0tdJCd/R8LiTG2HYH98owlHJy6ybFrySG/dEfm0xxxZX/4C2qEyB3BzHBKp4pVqo/2Y+X4TCCcxpCOiXLdKrXFnz9725BvwuO9Go2zALGLks6n5ob8qY6MKvk+BHt9/82tw+GcbQ7KNuhlxkotCwGQnfpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=alRyg0p0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467838e75ffso68110571cf.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1734452055; x=1735056855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3Rccgquk3pMB0e8JLxIrtXCYyTNacSqTIXQ+I+xU6k=;
        b=alRyg0p0eHkzRig8i/llDqD5OHw4O0W9NCPLdS58FsCVY5l8WPkKQVcUHowOt8Lqvv
         ckxpSQNtc/Si53S84tmV/mQ4zSnGiVi+pn1aeMYkqZmOUeitXCtacuAxQ4mPivZelgwJ
         iRbKDZcsRZSeZ7PoZf3WWUBxulwQy+rz48VuGRH0LEUO0Mnli+xYBYu00/cy4EwvaR5w
         zPbaxlFceemxWvlISPIMWyyt2fr7sSYYPhkt8pcO8u7p+oq4lpCELX6QWOGdJXO/Vwpj
         yJ1MyIxYNPlhRACjG9G/YGzrU7TThO/ZMVJcQYtGLmh5xKdU4l6prlMHrj9i9MZ9YZx2
         dO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734452055; x=1735056855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3Rccgquk3pMB0e8JLxIrtXCYyTNacSqTIXQ+I+xU6k=;
        b=TbDvm4ViAom6kUhnUDk+ufQGnnEgbt92aV8nE+Y9Ba168LBWbt5gIYX5TMHa0xiw2Z
         c9iFufTb/oayyVkVgb3XkhgLEZIjsrc/eTRIUzxKvhm/rkzNkMbkQoRizSGYcMz1d6T9
         xD2KjLeUhN5l+O5pjs7Ms4cQE/WeZFziKvUgDJi5PpRCVmEX6xyl5hDyNS/bNxgXhpS/
         IRhw/SVz3vgP76SseKIY8rYyFCTsZ/twsyWpb+9DbiPapcuQt0JAu3KGo+JYPp2/3K7S
         rz2UyL+uvVrZCne+34cXLs/bSf24kZoHJRcd6vF6PU84bwbNmwBuSWRIGA/EUf69uU9i
         WhLA==
X-Forwarded-Encrypted: i=1; AJvYcCXqfG990an91RYrOi2WiQwn6qB283QcQZ/yghPCzMQdjhQbNba1zDYImHBwM+6N/SdJTxRy88o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+QczOHbCyLmRttthQ5L9cwZw7swSuEqZG/TgDc7dK1rEQiEnW
	SDcy4bnsTQWslbLsZ09+x60/V/BkfHMEu2g4bpSIWphaCS1OfGgizqmf8X45hw==
X-Gm-Gg: ASbGnct35Z8QHHQZlUGiqUMveVykjBYvnP0nibvEJMtgyjnzcPU70pkhsoDapJeA1DB
	qNgSAERyiVO1CFrAqYCzO7EcLUigz95deSXMF+HaObRDlWTR0W2/YlN31bs1n1fExhhpEZS8f7d
	4nPJifGaQXIr1zLsLnzU88EA3oYOEcjmtCH1mxJ2F7LMd8utpNndLurbqvZldx7Mu1F7dKGovTM
	6u9gwou9A9jZEuyvzupqicMasDePbXLS5PAqPnlI9prK4AY310lb1ufxQ==
X-Google-Smtp-Source: AGHT+IFoPz5nV0F70qkjNPbX4NA7B77WNReqNOXg8KtZoNW+iEe5zl1EB6kQNtekItrIEdv6nU0pbQ==
X-Received: by 2002:ac8:5741:0:b0:467:6cd9:3093 with SMTP id d75a77b69052e-467a582a976mr334266611cf.46.1734452054891;
        Tue, 17 Dec 2024 08:14:14 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::ba54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e84db6sm40614951cf.54.2024.12.17.08.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:14:14 -0800 (PST)
Date: Tue, 17 Dec 2024 11:14:11 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Ma Ke <make_ruc2021@163.com>
Cc: gregkh@linuxfoundation.org, mka@chromium.org,
	christophe.jaillet@wanadoo.fr, quic_ugoswami@quicinc.com,
	oneukum@suse.com, stanley_chang@realtek.com,
	javier.carrasco@wolfvision.net, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: fix reference leak in usb_new_device()
Message-ID: <ccc1083b-5ae8-490b-b357-52e162ba0a1f@rowland.harvard.edu>
References: <20241217035353.2891942-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217035353.2891942-1-make_ruc2021@163.com>

On Tue, Dec 17, 2024 at 11:53:52AM +0800, Ma Ke wrote:
> When device_add(&udev->dev) failed, calling put_device() to explicitly
> release udev->dev. Otherwise, it could cause double free problem.

If you're worried that the same object might be freed more than once 
(double free), how can calling put_device() help?  Won't that cause 
udev->dev to be freed a third time?

> Found by code review.

In your code review, did you check to see whether the routine which 
calls usb_new_device() will do the put_device() when an error occurs?

> Cc: stable@vger.kernel.org
> Fixes: 9f8b17e643fe ("USB: make usbdevices export their device nodes instead of using a separate class")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/usb/core/hub.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 4b93c0bd1d4b..05b778d2ad63 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2651,6 +2651,7 @@ int usb_new_device(struct usb_device *udev)
>  	err = device_add(&udev->dev);
>  	if (err) {
>  		dev_err(&udev->dev, "can't device_add, error %d\n", err);
> +		put_device(&udev->dev);
>  		goto fail;
>  	}
>  
> @@ -2683,6 +2684,9 @@ int usb_new_device(struct usb_device *udev)
>  	pm_runtime_put_sync_autosuspend(&udev->dev);
>  	return err;
>  
> +out_del_dev:
> +	device_del(&udev->dev);
> +	put_device(&udev->dev);

You added a new statement label but you did not add any jumps to that 
label.  As a result, these two lines will never be executed.

Alan Stern

>  fail:
>  	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
>  	pm_runtime_disable(&udev->dev);
> -- 
> 2.25.1
> 

