Return-Path: <stable+bounces-105178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF3E9F6A79
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 16:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6DA7A51F6
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFD1F2C4A;
	Wed, 18 Dec 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="cLPhWavj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F91E9B0D
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537188; cv=none; b=szlemiLFBZjj7jdlgaXqrWCY9zde2cb2Kt7HwHzFnExD9/rV9j/dR1kswlC04plOIeT3WjWY50NIZxZAJBuSTgAX1z0TzY5HTggt3mgcYH0rsir2ngtrmZIvIjihvOWQa3PwzL3MnBy470Y2/O8+dZGmt1NRCW3X6EuOnXCmw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537188; c=relaxed/simple;
	bh=BnK3wVR9GmW8tGs6cZLrsURMtarGred4qj5H81H6sqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6taQXeClYltDSbKAJ4jGgeJDGIbuAx+uStXRsSyKU7t80w3ZwbrsLs+umRYC8lwBM4GZ2zQrghju3EujvHQNYCbQGFKJVc+9AmNSbTWVYg1ziqDTg7cG3uemVux9/VYp1M8hlnITiis2a39b+xZh0stsrChKBYf5RS16+T6k04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=cLPhWavj; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6ea711805so646405185a.1
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 07:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1734537186; x=1735141986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMOV2KSeWDmaAVxI5NOfNysJIN/FRYl6Ew3xZQr7LpQ=;
        b=cLPhWavj+YaaBX3CJaQd/HDpOd+M1euoqMxR9Rq5/WPMCZ1tY8o9AYRFXO0ChEauzb
         4qEYc6t4AFGb8IsKqt1o3/T2u/LYt8lVXdI4dmbmLuFxXSOZiKLtiVFpqhAaTpnBRd0q
         SiukUocZHxxvFYSgQGs7ESn3MnY/WFnjWEeYmpv9808D3czUg5GFdprhXpdX7vLbJl1F
         VBXQATxavXC6q4OZ3wNiIvQH4yPsl7hHWzFkJLPNNgCtCgyDOvH19MxHyvLgoitxXcNA
         uIn+8nPW3a3liKxaccKTRKof5Bm9ZgMlXh4e3kzEO2qb7aEMDgOvWnlA1DorTcjUeOqX
         p5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734537186; x=1735141986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMOV2KSeWDmaAVxI5NOfNysJIN/FRYl6Ew3xZQr7LpQ=;
        b=QE+VU9/c538SZnowoPaE9Yc+c24aQQUcWlaD99YHs4ubkV3G/VLudzLpsP8kKtyUOG
         9673XSzMBGdpYovyph2iF5hHmEZN1DOm6Fn2z/a1ndrpYCeEpfu2WLhChCwXO+Ti4HYu
         qhtg5VhkmP0vZyoUwFpaIyBAqg9PUCR7mkGoWUubvraxbcgEteM6r7wKXQsi0mC8aoXZ
         +LyShF9HDiABVc5xyeyfBQjQ7pNZq2vuHFHp883FKZ6SBlOSKUSW3riSx6BhwRGk9KbW
         sTPWxZIJ5csEVuXULC3Ryjh9V/kpqVwylX626FHWix24eco/lYRJH2MxAuTFB4u45fZP
         c9XA==
X-Forwarded-Encrypted: i=1; AJvYcCV5gsLTgp6Yrw1+4861DqL/qN67oXLC1yQ6VCuymSC+SOdn+Raaeneb1DRuKfAvWWPMXKGofLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiOe2uawZi5WSycsQry3cqfK0liy/Bftwxn/2eBSqL/8xAgj/P
	A82RStMHrgo1+JYJ96SfB7rNxVSmgeL1YeYGiRz8OcreRLW9I9c6kCDor5oe7A==
X-Gm-Gg: ASbGnct4Z6jSYSQS1Dpm4eyXex3QErhpN3VZVN8/RpBS9vB5dbghIbErF/TUU75h6tZ
	fLuZ7B7JPVmX5k4SBjpX7jv3xrTAOI58OLBsaPb+HvxX9xyPOg8n39iXq7ihtem5vlqBDiEvnd2
	lgjiiE7vG7bUVvp7zyxZ1sGSX+L4YoAUYRxYk1bUlQYqc/YyTeiRtyjFV7gtglDfwCgREBSdIG6
	60OnE6saLEA4+8J367hvHvJly2uLyFE7uCB82leOTGVVZyAh5CrUDDRfDqvQa5IVh2tLwIRoTg=
X-Google-Smtp-Source: AGHT+IFGGX03Kfd20xEKu/qFp/fE1GeTEV7IIr2GodHMNusC7rm1+e4VNX/bjgCGnrG8PjOp9zLXsw==
X-Received: by 2002:a05:620a:17aa:b0:7b6:c3e2:45f9 with SMTP id af79cd13be357-7b8638b4bdamr490545885a.48.1734537186265;
        Wed, 18 Dec 2024 07:53:06 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2c72fa9sm52123051cf.12.2024.12.18.07.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 07:53:05 -0800 (PST)
Date: Wed, 18 Dec 2024 10:53:03 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Ma Ke <make_ruc2021@163.com>
Cc: gregkh@linuxfoundation.org, quic_ugoswami@quicinc.com,
	stanley_chang@realtek.com, christophe.jaillet@wanadoo.fr,
	oneukum@suse.com, javier.carrasco@wolfvision.net,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: fix reference leak in usb_new_device()
Message-ID: <b564bbbb-f931-45d2-8d74-206c250b77f2@rowland.harvard.edu>
References: <20241218071346.2973980-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218071346.2973980-1-make_ruc2021@163.com>

On Wed, Dec 18, 2024 at 03:13:46PM +0800, Ma Ke wrote:
> When device_add(&udev->dev) succeeds and a later call fails,
> usb_new_device() does not properly call device_del(). As comment of
> device_add() says, 'if device_add() succeeds, you should call
> device_del() when you want to get rid of it. If device_add() has not
> succeeded, use only put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9f8b17e643fe ("USB: make usbdevices export their device nodes instead of using a separate class")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
> Changes in v3:
> - modified the bug description according to the changes of the patch;
> - removed redundant put_device() in patch v2 as suggestions.
> Changes in v2:
> - modified the bug description to make it more clear;
> - added the missed part of the patch.
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/core/hub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 4b93c0bd1d4b..21ac9b464696 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2663,13 +2663,13 @@ int usb_new_device(struct usb_device *udev)
>  		err = sysfs_create_link(&udev->dev.kobj,
>  				&port_dev->dev.kobj, "port");
>  		if (err)
> -			goto fail;
> +			goto out_del_dev;
>  
>  		err = sysfs_create_link(&port_dev->dev.kobj,
>  				&udev->dev.kobj, "device");
>  		if (err) {
>  			sysfs_remove_link(&udev->dev.kobj, "port");
> -			goto fail;
> +			goto out_del_dev;
>  		}
>  
>  		if (!test_and_set_bit(port1, hub->child_usage_bits))
> @@ -2683,6 +2683,8 @@ int usb_new_device(struct usb_device *udev)
>  	pm_runtime_put_sync_autosuspend(&udev->dev);
>  	return err;
>  
> +out_del_dev:
> +	device_del(&udev->dev);
>  fail:
>  	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
>  	pm_runtime_disable(&udev->dev);
> -- 
> 2.25.1
> 

