Return-Path: <stable+bounces-224685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBr5G9tksWnsugIAu9opvQ
	(envelope-from <stable+bounces-224685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:49:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB708263DAD
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A16C331CEAA1
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA0A23535E;
	Wed, 11 Mar 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0cpWtUl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4361CD2C;
	Wed, 11 Mar 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233168; cv=none; b=ngmJMj5hZafpfpzHJayi6jSVUXVQ6GmsKOMfn8NboKzQHcPDRn7UAc21Lmc+XGimM41QUAQL1ylwzDke04CdDqwBYUlNmUn0mPFTipr8/oC+gBGGmp4O3EnkFs9RdxH+q/ShsQu9KPG+b3B1x2h18wLc4cFNKJEPvz5y27nx0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233168; c=relaxed/simple;
	bh=yZkRn5xU19FhUS6a/p33ihysyKruq0MZr0bpn51hKGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeUZwVgtFTEqaBbkJ+UeLJ1vrEo9D7JnbHpKv8wgbuskVKdm4/7kFdOoQGkBt+Mh2hdOeq6ziyKxXRQ+Y+Nn78rsL5W0PGTpFx7zmV7MKBfen8Ey29PbbFmw2fwJ0fH1C5otJvahKLTl0MEaZBqJWB3KHnCeGl66at8mEJiThuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0cpWtUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509C9C2BC9E;
	Wed, 11 Mar 2026 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773233167;
	bh=yZkRn5xU19FhUS6a/p33ihysyKruq0MZr0bpn51hKGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0cpWtUlpmdPuT5JeBtlsStbrGlvW7YDP++g40OkGuyh+yH+EKaenhJXKkjuFyKix
	 aNy+WzG1U5trdVB75IsnbGWV1Lvmbu/y55k5bRMWLuhY+VzyojXRTGuR8Dz2G1FPlh
	 ZGgegTUpAglPZjxgTlLq42GEnGbVmZeU+ywCYO+k=
Date: Wed, 11 Mar 2026 13:46:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jimmy Hu <hhhuuu@google.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Dan Vacura <w36195@motorola.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	badhri@google.com
Subject: Re: [PATCH v2] usb: gadget: f_uvc: fix NULL pointer dereference
 during unbind race
Message-ID: <2026031109-supermom-treat-09b5@gregkh>
References: <20260224083955.1375032-1-hhhuuu@google.com>
 <20260309053107.2591494-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309053107.2591494-1-hhhuuu@google.com>
X-Rspamd-Queue-Id: DB708263DAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-224685-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,harvard.edu:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 01:31:07PM +0800, Jimmy Hu wrote:
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
> This patch introduces the following safeguards:
> 
> 1. State Synchronization (flag + mutex)
> Introduced a 'func_unbound' flag in struct uvc_device. This allows
> uvc_function_disconnect() to safely skip accessing the nullified
> cdev->gadget pointer. As suggested by Alan Stern, this flag is protected
> by a new mutex (uvc->lock) to ensure proper memory ordering and prevent
> instruction reordering or speculative loads.
> 
> 2. Lifecycle Management (kref)
> Introduced kref to manage the struct uvc_device lifecycle. This prevents
> Use-After-Free (UAF) by ensuring the structure is only freed after the
> final reference, including the V4L2 release path, is dropped.
> 
> Fixes: b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanly shutdown")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> ---
> v1 -> v2:
> - Renamed 'func_unbinding' to 'func_unbound' for clearer state semantics.
> - Added a mutex (uvc->lock) to protect the 'func_unbound' flag and ensure
>   proper memory ordering, as suggested by Alan Stern.
> - Integrated kref to manage the struct uvc_device lifecycle, allowing the 
>   removal of redundant buffer cleanup skip logic in uvc_v4l2_disable().
>   
> v1: https://patchwork.kernel.org/project/linux-usb/patch/20260224083955.1375032-1-hhhuuu@google.com/
> 
>  drivers/usb/gadget/function/f_uvc.c    | 27 +++++++++++++++++++++++++-
>  drivers/usb/gadget/function/uvc.h      |  4 ++++
>  drivers/usb/gadget/function/uvc_v4l2.c |  2 ++
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 494fdbc4e85b..485cd91770d5 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -413,8 +413,17 @@ uvc_function_disconnect(struct uvc_device *uvc)
>  {
>  	int ret;
>  
> +	mutex_lock(&uvc->lock);
> +	if (uvc->func_unbound) {
> +		pr_info("uvc: unbound, skipping function deactivate\n");

When drivers work properly, they are quiet.  Also, why are you not using
uvcg_info() here, this pr_info() gives no device specific information so
you know what device this is happening to.



> +		goto unlock;
> +	}
> +
>  	if ((ret = usb_function_deactivate(&uvc->func)) < 0)
>  		uvcg_info(&uvc->func, "UVC disconnect failed with %d\n", ret);
> +
> +unlock:
> +	mutex_unlock(&uvc->lock);
>  }
>  
>  /* --------------------------------------------------------------------------
> @@ -659,6 +668,9 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
>  	int ret = -EINVAL;
>  
>  	uvcg_info(f, "%s()\n", __func__);
> +	mutex_lock(&uvc->lock);
> +	uvc->func_unbound = false;
> +	mutex_unlock(&uvc->lock);
>  
>  	opts = fi_to_f_uvc_opts(f->fi);
>  	/* Sanity check the streaming endpoint module parameters. */
> @@ -974,6 +986,13 @@ static struct usb_function_instance *uvc_alloc_inst(void)
>  	return &opts->func_inst;
>  }
>  
> +void uvc_device_release(struct kref *kref)
> +{
> +	struct uvc_device *uvc = container_of(kref, struct uvc_device, kref);
> +
> +	kfree(uvc);
> +}
> +
>  static void uvc_free(struct usb_function *f)
>  {
>  	struct uvc_device *uvc = to_uvc(f);
> @@ -982,7 +1001,7 @@ static void uvc_free(struct usb_function *f)
>  	if (!opts->header)
>  		config_item_put(&uvc->header->item);
>  	--opts->refcnt;
> -	kfree(uvc);
> +	kref_put(&uvc->kref, uvc_device_release);
>  }
>  
>  static void uvc_function_unbind(struct usb_configuration *c,
> @@ -994,6 +1013,9 @@ static void uvc_function_unbind(struct usb_configuration *c,
>  	long wait_ret = 1;
>  
>  	uvcg_info(f, "%s()\n", __func__);
> +	mutex_lock(&uvc->lock);
> +	uvc->func_unbound = true;
> +	mutex_unlock(&uvc->lock);
>  
>  	kthread_cancel_work_sync(&video->hw_submit);
>  
> @@ -1046,8 +1068,11 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
>  	if (uvc == NULL)
>  		return ERR_PTR(-ENOMEM);
>  
> +	kref_init(&uvc->kref);
> +	mutex_init(&uvc->lock);
>  	mutex_init(&uvc->video.mutex);
>  	uvc->state = UVC_STATE_DISCONNECTED;
> +	uvc->func_unbound = true;
>  	init_waitqueue_head(&uvc->func_connected_queue);
>  	opts = fi_to_f_uvc_opts(fi);
>  
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> index 676419a04976..22b70f25607d 100644
> --- a/drivers/usb/gadget/function/uvc.h
> +++ b/drivers/usb/gadget/function/uvc.h
> @@ -155,6 +155,9 @@ struct uvc_device {
>  	enum uvc_state state;
>  	struct usb_function func;
>  	struct uvc_video video;
> +	struct kref kref;

But there is already a device reference count in the vdev structure,
right?  Are you now having 2 reference counts for the same device?
That's going to cause a lot of problems.

> +	struct mutex lock;

Please document what this lock is locking.

thanks,

greg k-h

