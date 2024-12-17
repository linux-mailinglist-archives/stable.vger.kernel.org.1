Return-Path: <stable+bounces-104472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BA9F496E
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD84188CED5
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB611E1A25;
	Tue, 17 Dec 2024 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I93WlFFv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA51D47D9;
	Tue, 17 Dec 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734433244; cv=none; b=XOIRyu5xp21F5JUOtMxAGM3QDE09N6FLtnR61y0XIo+ab/cqddPoCXgwVSsZCeGftzGPPUPCcekCKDnOOG15gguase6ASE9gZCR5CTg0W5SrwBmMTtTCmsmUJ+/VP+C5B2F/l0IPTTXQWbj4NHl7PPeEXyTNxVCWVeBZNQ1jpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734433244; c=relaxed/simple;
	bh=Ukwhi6S20vX1tufgGPGNsLoeekXDaAXaZdLMk0uo4BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYLfWzoaMhrTffMWCc5RsfWWb2XX1rL/hQdCE3tj09maGp5/Ru9T87zGhfG0MosSm0N/Kx5f+S08xlXJtwWl3XyKcYelIjFKyQGIZdpyONQwBziMWPIQeRD/JQ+SQtpXPSoU5vwuqpx3MFwhMT9AHjRE/bAN0z1UWWGij3dQibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I93WlFFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E555C4CED3;
	Tue, 17 Dec 2024 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734433244;
	bh=Ukwhi6S20vX1tufgGPGNsLoeekXDaAXaZdLMk0uo4BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I93WlFFvQqdOZEHji3kk4m+ZKdvA9CALUX1vTKKF21BEEVGJ/O8uhAsVlkr5IWKZJ
	 puZYVnllE8JkBv73Hb0sbE9qOq5BVHU68XyRD74o/gWOv/QWQGEJsjIXB05vrW06ca
	 f2Nj7uksG6KRtcNYarz31aCJMEU5+ujQT1G8sLes=
Date: Tue, 17 Dec 2024 12:00:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: stern@rowland.harvard.edu, mka@chromium.org,
	christophe.jaillet@wanadoo.fr, quic_ugoswami@quicinc.com,
	oneukum@suse.com, stanley_chang@realtek.com,
	javier.carrasco@wolfvision.net, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: fix reference leak in usb_new_device()
Message-ID: <2024121730-erratic-irregular-1b2d@gregkh>
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
> 
> Found by code review.
> 
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
>  fail:
>  	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
>  	pm_runtime_disable(&udev->dev);

How was this change tested?

thanks,

greg k-h

