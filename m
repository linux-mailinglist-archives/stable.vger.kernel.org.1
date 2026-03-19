Return-Path: <stable+bounces-227242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCtYA2vBu2n1ngIAu9opvQ
	(envelope-from <stable+bounces-227242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:27:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 627F82C8A22
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05DA23337762
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477F03B4E81;
	Thu, 19 Mar 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yGHPBicx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1133B3BEA;
	Thu, 19 Mar 2026 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911894; cv=none; b=jwlHRAdBpkQZgtLvJn/ZzvTx/iKhqwg76b7eqWW5oRRX/NTnNPc0D1Sz8gYaOsNCcKx+LKjWZpOEaRo25iMmgvt8f7tQKOd8/AhoLeQ7Diaa0jvGoDQaZ4L9gC9z+FbGPt4BjPVdMPRAJpvmz+rD8EEmUurIFtFQfQoXf89RW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911894; c=relaxed/simple;
	bh=2Sbgx7BJLM8VYFSFWGj5NA3lz7SXzMtXgHrvjl8Gb8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ70JdUcgXM0wfttXv4Y15BKFG+2sZU5Kb80mdtpZ6S5/LwZOaQzC3lvfpebrVnF3DECAvSmknLZzCTDvpiFrmHu1a3mdfozuP2nMx6wSBsMFPy8TqtAblmnj8zVgyTXrwU7r9kW+nV44eKxXSS3HGsvUOHEAwwmZBG/Qfnx5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yGHPBicx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D20FC2BC87;
	Thu, 19 Mar 2026 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773911893;
	bh=2Sbgx7BJLM8VYFSFWGj5NA3lz7SXzMtXgHrvjl8Gb8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yGHPBicxtc39zEzkgMssRXgdyOtYmzq4RDLaGJGbkSS8fgoDAv8jVedtrBf+rJ3PT
	 9sB4haMCXGUBnwQTZHYgObu3PPTELS/xYYD3DX0cSRybtPKwD0i6agCyQFCzIjwhmt
	 USs1WMbCy1KtNBRbvAiheBZb4l3hwPdGrcKFxj7c=
Date: Thu, 19 Mar 2026 10:18:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jimmy Hu <hhhuuu@google.com>
Cc: Dan Vacura <w36195@motorola.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: f_uvc: fix NULL pointer dereference
 during unbind race
Message-ID: <2026031947-unroll-rectified-72d8@gregkh>
References: <20260319084640.478695-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319084640.478695-1-hhhuuu@google.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227242-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[motorola.com,rowland.harvard.edu,ideasonboard.com,xs4all.nl,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 627F82C8A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 04:46:40PM +0800, Jimmy Hu wrote:
> Commit b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanly
> shutdown") introduced two stages of synchronization waits totaling 1500ms
> in uvc_function_unbind() to prevent several types of kernel panics.
> However, this timing-based approach is insufficient during power
> management (PM) transitions.
> 
> When the PM subsystem starts freezing user space processes, the
> wait_event_interruptible_timeout() is aborted early, which allows the
> unbind thread to proceed and nullify the gadget pointer
> (cdev->gadget = NULL):
> 
> [  814.123447][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_unbind()
> [  814.178583][ T3173] PM: suspend entry (deep)
> [  814.192487][ T3173] Freezing user space processes
> [  814.197668][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_unbind no clean disconnect, wait for release
> 
> When the PM subsystem resumes or aborts the suspend and tasks are
> restarted, the V4L2 release path is executed and attempts to access the
> already nullified gadget pointer, triggering a kernel panic:
> 
> [  814.292597][    C0] PM: pm_system_irq_wakeup: 479 triggered dhdpcie_host_wake
> [  814.386727][ T3173] Restarting tasks ...
> [  814.403522][ T4558] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> [  814.404021][ T4558] pc : usb_gadget_deactivate+0x14/0xf4
> [  814.404031][ T4558] lr : usb_function_deactivate+0x54/0x94
> [  814.404078][ T4558] Call trace:
> [  814.404080][ T4558]  usb_gadget_deactivate+0x14/0xf4
> [  814.404083][ T4558]  usb_function_deactivate+0x54/0x94
> [  814.404087][ T4558]  uvc_function_disconnect+0x1c/0x5c
> [  814.404092][ T4558]  uvc_v4l2_release+0x44/0xac
> [  814.404095][ T4558]  v4l2_release+0xcc/0x130
> 
> This patch fixes these issues by:
> 
> 1. State Synchronization (flag + mutex)
> Introduce a 'func_unbound' flag in struct uvc_device. This allows
> uvc_function_disconnect() to safely skip accessing the nullified
> cdev->gadget pointer. As suggested by Alan Stern, this flag is protected
> by a new mutex (uvc->lock) to ensure proper memory ordering and prevent
> instruction reordering or speculative loads.
> 
> 2. Explicit Synchronization (completion)
> Use a completion to synchronize uvc_function_unbind() with the
> uvc_vdev_release() callback. This prevents Use-After-Free (UAF) by
> ensuring struct uvc_device is freed after all video device resources
> are released.
> 
> Fixes: b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanly shutdown")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> ---
> v2 -> v3:
> - Replaced pr_info() with pr_debug() instead of uvcg_info() to stay quiet 
>   and avoided potential NULL pointer dereferences on cdev->gadget, as 
>   suggested by Greg KH.
> - Replaced kref-based lifecycle management with a completion to synchronize 
>   uvc_function_unbind() with the video device release callback, avoiding 
>   redundant reference counting, as suggested by Greg KH.
> - Added a proper comment for 'lock' in struct uvc_device to describe 
>   what it protects, as suggested by Greg KH.
> 
> v1 -> v2:
> - Renamed 'func_unbinding' to 'func_unbound' for clearer state semantics.
> - Added a mutex (uvc->lock) to protect the 'func_unbound' flag and ensure
>   proper memory ordering, as suggested by Alan Stern.
> - Integrated kref to manage the struct uvc_device lifecycle, allowing the 
>   removal of redundant buffer cleanup skip logic in uvc_v4l2_disable().
> 
> v2: https://lore.kernel.org/all/20260309053107.2591494-1-hhhuuu@google.com/
> v1: https://lore.kernel.org/all/20260224083955.1375032-1-hhhuuu@google.com/
> 
>  drivers/usb/gadget/function/f_uvc.c | 35 ++++++++++++++++++++++++++++-
>  drivers/usb/gadget/function/uvc.h   |  3 +++
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 494fdbc4e85b..390156e70df9 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -413,8 +413,18 @@ uvc_function_disconnect(struct uvc_device *uvc)
>  {
>  	int ret;
>  
> +	mutex_lock(&uvc->lock);
> +	if (uvc->func_unbound) {
> +		pr_debug("%s: %s unbound, skipping function deactivate\n",
> +			 uvc->func.name, uvc->func.fi->group.cg_item.ci_name);

You have a pointer to many different devices in uvc, so why not use
dev_dbg() instead?  At the very least, use the v4l2_device one, right?

> +		goto unlock;
> +	}
> +
>  	if ((ret = usb_function_deactivate(&uvc->func)) < 0)
>  		uvcg_info(&uvc->func, "UVC disconnect failed with %d\n", ret);
> +
> +unlock:
> +	mutex_unlock(&uvc->lock);

Why not just use a guard()?

>  }
>  
>  /* --------------------------------------------------------------------------
> @@ -431,6 +441,15 @@ static ssize_t function_name_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(function_name);
>  
> +static void uvc_vdev_release(struct video_device *vdev)
> +{
> +	struct uvc_device *uvc = video_get_drvdata(vdev);
> +
> +	/* Signal uvc_function_unbind() that the video device has been released */
> +	if (uvc->vdev_release_done)
> +		complete(uvc->vdev_release_done);
> +}
> +
>  static int
>  uvc_register_video(struct uvc_device *uvc)
>  {
> @@ -443,7 +462,7 @@ uvc_register_video(struct uvc_device *uvc)
>  	uvc->vdev.v4l2_dev->dev = &cdev->gadget->dev;
>  	uvc->vdev.fops = &uvc_v4l2_fops;
>  	uvc->vdev.ioctl_ops = &uvc_v4l2_ioctl_ops;
> -	uvc->vdev.release = video_device_release_empty;
> +	uvc->vdev.release = uvc_vdev_release;
>  	uvc->vdev.vfl_dir = VFL_DIR_TX;
>  	uvc->vdev.lock = &uvc->video.mutex;
>  	uvc->vdev.device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
> @@ -659,6 +678,9 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
>  	int ret = -EINVAL;
>  
>  	uvcg_info(f, "%s()\n", __func__);
> +	mutex_lock(&uvc->lock);
> +	uvc->func_unbound = false;
> +	mutex_unlock(&uvc->lock);
>  
>  	opts = fi_to_f_uvc_opts(f->fi);
>  	/* Sanity check the streaming endpoint module parameters. */
> @@ -992,8 +1014,13 @@ static void uvc_function_unbind(struct usb_configuration *c,
>  	struct uvc_device *uvc = to_uvc(f);
>  	struct uvc_video *video = &uvc->video;
>  	long wait_ret = 1;
> +	DECLARE_COMPLETION_ONSTACK(vdev_release_done);
>  
>  	uvcg_info(f, "%s()\n", __func__);
> +	mutex_lock(&uvc->lock);
> +	uvc->func_unbound = true;
> +	uvc->vdev_release_done = &vdev_release_done;
> +	mutex_unlock(&uvc->lock);
>  
>  	kthread_cancel_work_sync(&video->hw_submit);
>  
> @@ -1029,6 +1056,10 @@ static void uvc_function_unbind(struct usb_configuration *c,
>  		uvcg_dbg(f, "done waiting for release with ret: %ld\n", wait_ret);
>  	}
>  
> +	/* Wait for the video device to be released */
> +	wait_for_completion(&vdev_release_done);
> +	uvc->vdev_release_done = NULL;
> +
>  	usb_ep_free_request(cdev->gadget->ep0, uvc->control_req);
>  	kfree(uvc->control_buf);
>  
> @@ -1047,6 +1078,8 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
>  		return ERR_PTR(-ENOMEM);
>  
>  	mutex_init(&uvc->video.mutex);
> +	mutex_init(&uvc->lock);
> +	uvc->func_unbound = true;
>  	uvc->state = UVC_STATE_DISCONNECTED;
>  	init_waitqueue_head(&uvc->func_connected_queue);
>  	opts = fi_to_f_uvc_opts(fi);
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> index 676419a04976..6fa98a173a35 100644
> --- a/drivers/usb/gadget/function/uvc.h
> +++ b/drivers/usb/gadget/function/uvc.h
> @@ -155,6 +155,9 @@ struct uvc_device {
>  	enum uvc_state state;
>  	struct usb_function func;
>  	struct uvc_video video;
> +	struct completion *vdev_release_done;
> +	struct mutex lock;	/* protects func_unbound flag */
> +	bool func_unbound;

A lock to only protect one flag?  How are all of the other flags in this
structure protected?  Why not use whatever lock is used there, OR use
this lock to protect them?

thanks,

greg k-h

