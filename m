Return-Path: <stable+bounces-230554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKZ8NznIxWmgBgUAu9opvQ
	(envelope-from <stable+bounces-230554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:58:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EAA33D4FD
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FEED304DCA9
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2776359A87;
	Thu, 26 Mar 2026 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzXTorCY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC2E34D396;
	Thu, 26 Mar 2026 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569523; cv=none; b=auAD1aJA2A2AA2uzqP3v4OugV30p2qb7ji6o+8zB43URTb7iNS3krQO8CH2zIRnbjKI8jC3vICRk4syBr7cNxTAj+ENwTK7oViSduGyH+WiHUIG7RZR3ZoYPFFzan7hNvvdzvUNjPHkRYcXPPsKCzZ3+wqjOCgqkfGLoCgxKpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569523; c=relaxed/simple;
	bh=LTIx9ZvJ/AobNb/0Bn2IkvwWtBKN8rsMIGA0zemHHJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULdduVLVNBaTClbq8KAemGxv5ITdg3qHdPwm0MAPAdNw/0P4vCKyF3KZkMbOoF+QVMaiHTQNEc1tXNs53LDqWOZchWiD9iJE8Zmfyge+UtSvTi9MLr5hRCkhhLvHLDYo15eCz61xymkh1U17xNBUw7i7hV1D3jCy8UrbtY0YySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzXTorCY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774569522; x=1806105522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LTIx9ZvJ/AobNb/0Bn2IkvwWtBKN8rsMIGA0zemHHJ4=;
  b=DzXTorCYMvXs7E//CtYy0r2KzmQsJ0kgoJoOaHlVGfNP6HsFItROQrso
   x05Hs3dDUBrPdvQRA8Eufnz8L+alIAVfCiylTnFesV0ZqINLxR4Baq1JK
   VbtJEedkVKQc8ATf9SPtNV31BmwGaU6jHlqYZwmmL0FgCbLvwkqvpspHk
   MstotMWsZNDVUDmy/YtbOykkoqd3dPdkjsexWGF/FsAMwGSYrbqmo1/rl
   jvP2jljN3AyWlPlkcyjXEjKX0xjmI5ejSylDpM2sOR8b0/ZJye138xIWT
   Gs1jsHg36Fv2N2//u76boR83Hnz8bLbN9xtp10ak5aA8ImXxNMSQ05Qiu
   Q==;
X-CSE-ConnectionGUID: M6YIMUBjT6eOevfzYhbFXQ==
X-CSE-MsgGUID: 1gihSfFCT1WWDVWWE8Q4zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74824242"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="74824242"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 16:58:41 -0700
X-CSE-ConnectionGUID: 64SO2FiITcee6YyuwYuXYQ==
X-CSE-MsgGUID: DBqaYHV2SNmepwqmWpEZCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="222248947"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.106]) ([10.245.244.106])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 16:58:36 -0700
Message-ID: <bed5a8c0-2611-464a-bfd3-b00a8648727b@linux.intel.com>
Date: Fri, 27 Mar 2026 01:58:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] usb: core: use dedicated spinlock for offload
 state
To: Guan-Yu Lin <guanyulin@google.com>, gregkh@linuxfoundation.org,
 mathias.nyman@intel.com, perex@perex.cz, tiwai@suse.com,
 quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de,
 xiaopei01@kylinos.cn, wesley.cheng@oss.qualcomm.com, hannelotta@gmail.com,
 sakari.ailus@linux.intel.com, eadavis@qq.com, stern@rowland.harvard.edu,
 amardeep.rai@intel.com, xu.yang_2@nxp.com,
 andriy.shevchenko@linux.intel.com, nkapron@google.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20260324203851.4091193-1-guanyulin@google.com>
 <20260324203851.4091193-2-guanyulin@google.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260324203851.4091193-2-guanyulin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230554-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,linuxfoundation.org,intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,kylinos.cn,oss.qualcomm.com,gmail.com,linux.intel.com,qq.com,rowland.harvard.edu,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 42EAA33D4FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

On 3/24/26 22:38, Guan-Yu Lin wrote:
> Replace the coarse USB device lock with a dedicated offload_lock
> spinlock to reduce contention during offload operations. Use
> offload_pm_locked to synchronize with PM transitions and replace
> the legacy offload_at_suspend flag.
> 
> Optimize usb_offload_get/put by switching from auto-resume/suspend
> to pm_runtime_get_if_active(). This ensures offload state is only
> modified when the device is already active, avoiding unnecessary
> power transitions.
> 
> Cc: stable@vger.kernel.org
> Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---

> diff --git a/drivers/usb/core/offload.c b/drivers/usb/core/offload.c
> index 7c699f1b8d2b..c24945294d7e 100644
> --- a/drivers/usb/core/offload.c
> +++ b/drivers/usb/core/offload.c
> @@ -25,33 +25,30 @@
>    */
>   int usb_offload_get(struct usb_device *udev)
>   {
> -	int ret;
> +	int ret = 0;
>   
> -	usb_lock_device(udev);
> -	if (udev->state == USB_STATE_NOTATTACHED) {
> -		usb_unlock_device(udev);
> +	if (!usb_get_dev(udev))
>   		return -ENODEV;
> -	}
>   
> -	if (udev->state == USB_STATE_SUSPENDED ||
> -		   udev->offload_at_suspend) {
> -		usb_unlock_device(udev);
> -		return -EBUSY;
> +	if (pm_runtime_get_if_active(&udev->dev) != 1) {
> +		ret = -EBUSY;
> +		goto err_rpm;
>   	}
>   
> -	/*
> -	 * offload_usage could only be modified when the device is active, since
> -	 * it will alter the suspend flow of the device.
> -	 */
> -	ret = usb_autoresume_device(udev);
> -	if (ret < 0) {
> -		usb_unlock_device(udev);
> -		return ret;
> +	spin_lock(&udev->offload_lock);
> +
> +	if (udev->offload_pm_locked) {

Could we get rid of 'udev->offload_pm_locked' and 'usb_offload_set_pm_locked()'
by calling a synchronous pm_runtime_get_sync() or pm_runtime_resume_and_get()?

This way we can ensure udev->offload_usage isn't modified mid runtime suspend or
resume as resume is guaranteed to have finished and suspend won't be called,
at least not for the runtime case.

> +		ret = -EAGAIN;
> +		goto err;
>   	}
>   
>   	udev->offload_usage++;
> -	usb_autosuspend_device(udev);
> -	usb_unlock_device(udev);
> +
> +err:
> +	spin_unlock(&udev->offload_lock);
> +	pm_runtime_put_autosuspend(&udev->dev);
> +err_rpm:
> +	usb_put_dev(udev);
>   
>   	return ret;
>   }
> @@ -69,35 +66,32 @@ EXPORT_SYMBOL_GPL(usb_offload_get);
>    */
>   int usb_offload_put(struct usb_device *udev)
>   {
> -	int ret;
> +	int ret = 0;
>   
> -	usb_lock_device(udev);
> -	if (udev->state == USB_STATE_NOTATTACHED) {
> -		usb_unlock_device(udev);
> +	if (!usb_get_dev(udev))
>   		return -ENODEV;
> -	}
>   
> -	if (udev->state == USB_STATE_SUSPENDED ||
> -		   udev->offload_at_suspend) {
> -		usb_unlock_device(udev);
> -		return -EBUSY;
> +	if (pm_runtime_get_if_active(&udev->dev) != 1) {
> +		ret = -EBUSY;
> +		goto err_rpm;
>   	}
>   
> -	/*
> -	 * offload_usage could only be modified when the device is active, since
> -	 * it will alter the suspend flow of the device.
> -	 */
> -	ret = usb_autoresume_device(udev);
> -	if (ret < 0) {
> -		usb_unlock_device(udev);
> -		return ret;
> +	spin_lock(&udev->offload_lock);
> +
> +	if (udev->offload_pm_locked) {
> +		ret = -EAGAIN;
> +		goto err;


Ending up here is about unlucky timing, i.e. usb_offload_put() is called while
device is pretending to suspend/resume. Result here is that udev->offload_usage is
not decremented, and usb device won't properly suspend anymore even if device is
no longer offloaded.


>   	}
>   
>   	/* Drop the count when it wasn't 0, ignore the operation otherwise. */
>   	if (udev->offload_usage)
>   		udev->offload_usage--;
> -	usb_autosuspend_device(udev);
> -	usb_unlock_device(udev);
> +
> +err:
> +	spin_unlock(&udev->offload_lock);
> +	pm_runtime_put_autosuspend(&udev->dev);
> +err_rpm:
> +	usb_put_dev(udev);
>   
>   	return ret;
>   }
> @@ -112,25 +106,52 @@ EXPORT_SYMBOL_GPL(usb_offload_put);
>    * management.
>    *
>    * The caller must hold @udev's device lock. In addition, the caller should
> - * ensure downstream usb devices are all either suspended or marked as
> - * "offload_at_suspend" to ensure the correctness of the return value.
> + * ensure downstream usb devices are all marked as "offload_pm_locked" to
> + * ensure the correctness of the return value.
>    *
>    * Returns true on any offload activity, false otherwise.
>    */
>   bool usb_offload_check(struct usb_device *udev) __must_hold(&udev->dev->mutex)
>   {
>   	struct usb_device *child;
> -	bool active;
> +	bool active = false;
>   	int port1;
>   
> +	spin_lock(&udev->offload_lock);
> +	if (udev->offload_usage)
> +		active = true;
> +	spin_unlock(&udev->offload_lock);
> +> +	if (active)
> +		return true;

Not sure what the purpose of the spinlock is above

> +
>   	usb_hub_for_each_child(udev, port1, child) {
>   		usb_lock_device(child);
>   		active = usb_offload_check(child);
>   		usb_unlock_device(child);
> +
>   		if (active)
> -			return true;
> +			break;
>   	}
>   
> -	return !!udev->offload_usage;
> +	return active;
>   }
>   EXPORT_SYMBOL_GPL(usb_offload_check);
> +
> +/**
> + * usb_offload_set_pm_locked - set the PM lock state of a USB device
> + * @udev: the USB device to modify
> + * @locked: the new lock state
> + *
> + * Setting @locked to true prevents offload_usage from being modified. This
> + * ensures that offload activities cannot be started or stopped during critical
> + * power management transitions, maintaining a stable state for the duration
> + * of the transition.
> + */
> +void usb_offload_set_pm_locked(struct usb_device *udev, bool locked)
> +{
> +	spin_lock(&udev->offload_lock);
> +	udev->offload_pm_locked = locked;
> +	spin_unlock(&udev->offload_lock);
> 

spinlock usage unclear here as well

Thanks
Mathias


