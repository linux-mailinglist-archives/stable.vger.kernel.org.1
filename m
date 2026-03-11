Return-Path: <stable+bounces-224683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJydEo1fsWl/uQIAu9opvQ
	(envelope-from <stable+bounces-224683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:26:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B198826396C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20EF4302D0A5
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E643E0249;
	Wed, 11 Mar 2026 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mtnbjkVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4A3DDDB5;
	Wed, 11 Mar 2026 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232008; cv=none; b=ZDZ/mXRYHhyBAM26y4COaMxNZOvL/3m24FPYaptev7PScpCPw0cZBkurpm01hnL3Dy+OSP/vAK7JBN+wGBu6YKeW+7vaISMdbZi1oTeQ+tDNdjS51zyPvn04lQnjV6hiEW3ngZyxE7/ZjWvyKHUyBs6zF64Dzd6Fk/x7fOF3ATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232008; c=relaxed/simple;
	bh=wkhLYTb3dUx5spk5PzkXfvYKQAFodBUsoXqoLotdRT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flLM+PG90KjfLUQI+VWeWcsuahEX7NJxfYBllLK1nZriGAra9FAm/S9ninLuq3/PUsunEbfR44dMRNjgOyBynbBGwgS3cr6RBLBjbxFY59sW/h2s88jtwZqPjZa3ttmAUXnOTYiQxeIiHifbNhomf4xmWV/ZT1UvTYF9vt+nzUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mtnbjkVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA75C116C6;
	Wed, 11 Mar 2026 12:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773232007;
	bh=wkhLYTb3dUx5spk5PzkXfvYKQAFodBUsoXqoLotdRT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtnbjkVigYJS4+MUXSjOwYMnuAsKnZ9xbtrj2IJrlvhqJ2bG+66/R6ZURJ4EVOhGO
	 cJwupph4PhLK8hgOdHsRJTYM6+SaRS3zWmJTkb9/pZul4Y8irIGBhv4uUurFT5d6lq
	 S0MPEf5t7u+5rT2KmfzVcrO84s/wQ0BNWcRYnxcU=
Date: Wed, 11 Mar 2026 13:26:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: mathias.nyman@intel.com, perex@perex.cz, tiwai@suse.com,
	quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de,
	christophe.jaillet@wanadoo.fr, xiaopei01@kylinos.cn,
	wesley.cheng@oss.qualcomm.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	stable@vger.kernel.org, Hailong Liu <hailong.liu@oppo.com>
Subject: Re: [PATCH v2 1/2] usb: offload: move device locking to callers in
 offload.c
Message-ID: <2026031134-uncover-siamese-cdf9@gregkh>
References: <20260309022205.28136-1-guanyulin@google.com>
 <20260309022205.28136-2-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309022205.28136-2-guanyulin@google.com>
X-Rspamd-Queue-Id: B198826396C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224683-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,wanadoo.fr,kylinos.cn,oss.qualcomm.com,vger.kernel.org,oppo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.910];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 02:22:04AM +0000, Guan-Yu Lin wrote:
> Update usb_offload_get() and usb_offload_put() to require that the
> caller holds the USB device lock. Remove the internal call to
> usb_lock_device() and add device_lock_assert() to ensure synchronization
> is handled by the caller. These functions continue to manage the
> device's power state via autoresume/autosuspend and update the
> offload_usage counter.
> 
> Additionally, decouple the xHCI sideband interrupter lifecycle from the
> offload usage counter by removing the calls to usb_offload_get() and
> usb_offload_put() from the interrupter creation and removal paths. This
> allows interrupters to be managed independently of the device's offload
> activity status.
> 
> Cc: stable@vger.kernel.org
> Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> Tested-by: Hailong Liu <hailong.liu@oppo.com>
> ---
>  drivers/usb/core/offload.c       | 34 +++++++++++---------------------
>  drivers/usb/host/xhci-sideband.c | 14 +------------
>  2 files changed, 13 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/core/offload.c b/drivers/usb/core/offload.c
> index 7c699f1b8d2b..e13a4c21d61b 100644
> --- a/drivers/usb/core/offload.c
> +++ b/drivers/usb/core/offload.c
> @@ -20,6 +20,7 @@
>   * enabled on this usb_device; that is, another entity is actively handling USB
>   * transfers. This information allows the USB driver to adjust its power
>   * management policy based on offload activity.
> + * The caller must hold @udev's device lock.

Ok, but:

>   *
>   * Return: 0 on success. A negative error code otherwise.
>   */
> @@ -27,31 +28,25 @@ int usb_offload_get(struct usb_device *udev)

Why are you not using the __must_hold() definition here?

>  {
>  	int ret;
>  
> -	usb_lock_device(udev);
> -	if (udev->state == USB_STATE_NOTATTACHED) {
> -		usb_unlock_device(udev);
> +	device_lock_assert(&udev->dev);

That's going to splat at runtime, not compile time, which is when you
really want to check for this, right?

And I thought all of the locking was messy before, and you cleaned it up
to be nicer here, why go back to the "old" way?  Having a caller be
forced to have a lock held is ripe for problems...

You also are not changing any callers to usb_offload_get() in this
patch, so does this leave the kernel tree in a broken state?  If not,
why not?  If so, that's not ok :(



> +
> +	if (udev->state == USB_STATE_NOTATTACHED)
>  		return -ENODEV;
> -	}
>  
>  	if (udev->state == USB_STATE_SUSPENDED ||
> -		   udev->offload_at_suspend) {
> -		usb_unlock_device(udev);
> +	    udev->offload_at_suspend)

Can't that really all be on one line?

>  		return -EBUSY;
> -	}
>  
>  	/*
>  	 * offload_usage could only be modified when the device is active, since
>  	 * it will alter the suspend flow of the device.
>  	 */
>  	ret = usb_autoresume_device(udev);
> -	if (ret < 0) {
> -		usb_unlock_device(udev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	udev->offload_usage++;
>  	usb_autosuspend_device(udev);
> -	usb_unlock_device(udev);
>  
>  	return ret;
>  }
> @@ -64,6 +59,7 @@ EXPORT_SYMBOL_GPL(usb_offload_get);
>   * The inverse operation of usb_offload_get, which drops the offload_usage of
>   * a USB device. This information allows the USB driver to adjust its power
>   * management policy based on offload activity.
> + * The caller must hold @udev's device lock.
>   *
>   * Return: 0 on success. A negative error code otherwise.
>   */
> @@ -71,33 +67,27 @@ int usb_offload_put(struct usb_device *udev)

Again, use __must_hold() here, to catch build time issues.

And again, I don't see any code changes to reflect this new requirement
:(

thanks,

greg k-h

