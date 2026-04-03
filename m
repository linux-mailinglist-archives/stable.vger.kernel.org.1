Return-Path: <stable+bounces-233152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ie5Kpxmz2ngvwYAu9opvQ
	(envelope-from <stable+bounces-233152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 09:05:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 442BB391905
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 09:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F657302FF08
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 07:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF13332EC8;
	Fri,  3 Apr 2026 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ztYzWYrz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A1D18DB01;
	Fri,  3 Apr 2026 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199896; cv=none; b=OPsuzG0LjRB765WD/m+NhZS9vZHDCnphlVYUCLXtfFquk50zwt5H/+r/428+waKIaKItFYGkhv0YeY6NVmTy+UmuVGwOZmj6w3QE2oIMXvB13ZDkbMDdOVeEhELN+NEGiTn4kdybWA1lJIig0Y413U6FTA+D4hqQtQ/BvIePTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199896; c=relaxed/simple;
	bh=zIq4bRUdbB9hChVlNkwCmJZfurFLFqGlwxfhps8H2eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuTarrzYmfJ+ZX/8tTVTfAkxIfe+9LVAKzH5E5orUzcJMtVDV2lhI0WYx4niU0LiZqGAp9vwYfaPtiMrz/j8MonU6vaw+K8SsrNWWbG6Ni22dNugGdXBXYB6LBDUsFeJlZzp+6A2ZSIem8jA09YRk2WZ0bktLbTa1IZPzPl0a1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ztYzWYrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E427EC4CEF7;
	Fri,  3 Apr 2026 07:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775199895;
	bh=zIq4bRUdbB9hChVlNkwCmJZfurFLFqGlwxfhps8H2eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ztYzWYrz09zJhbTpz6iFRo71bGRCF0ougbZNSvKkCFcWt3eoRNMgWLYU2p+FXVE2L
	 XViWaezTRngGPU3xm/pdGnfnfQqm4Nki1Rwd0y+LMoFuHMf/Xnp/rWzF8MR/Ae6wyT
	 OJe2XCpmRZlhMFHQq42XXvEEiUmxBV8VR8o9vMSQ=
Date: Fri, 3 Apr 2026 09:04:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] driver core: Don't let a device probe until it's
 ready
Message-ID: <2026040319-seventeen-humorless-5541@gregkh>
References: <20260403005005.30424-1-dianders@chromium.org>
 <20260402174925.v3.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402174925.v3.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233152-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 442BB391905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 05:49:47PM -0700, Douglas Anderson wrote:
> The moment we link a "struct device" into the list of devices for the
> bus, it's possible probe can happen. This is because another thread
> can load the driver at any time and that can cause the device to
> probe. This has been seen in practice with a stack crawl that looks
> like this [1]:
> 
>   really_probe()
>   __driver_probe_device()
>   driver_probe_device()
>   __driver_attach()
>   bus_for_each_dev()
>   driver_attach()
>   bus_add_driver()
>   driver_register()
>   __platform_driver_register()
>   init_module() [some module]
>   do_one_initcall()
>   do_init_module()
>   load_module()
>   __arm64_sys_finit_module()
>   invoke_syscall()
> 
> As a result of the above, it was seen that device_links_driver_bound()
> could be called for the device before "dev->fwnode->dev" was
> assigned. This prevented __fw_devlink_pickup_dangling_consumers() from
> being called which meant that other devices waiting on our driver's
> sub-nodes were stuck deferring forever.
> 
> It's believed that this problem is showing up suddenly for two
> reasons:
> 1. Android has recently (last ~1 year) implemented an optimization to
>    the order it loads modules [2]. When devices opt-in to this faster
>    loading, modules are loaded one-after-the-other very quickly. This
>    is unlike how other distributions do it. The reproduction of this
>    problem has only been seen on devices that opt-in to Android's
>    "parallel module loading".
> 2. Android devices typically opt-in to fw_devlink, and the most
>    noticeable issue is the NULL "dev->fwnode->dev" in
>    device_links_driver_bound(). fw_devlink is somewhat new code and
>    also not in use by all Linux devices.
> 
> Even though the specific symptom where "dev->fwnode->dev" wasn't
> assigned could be fixed by moving that assignment higher in
> device_add(), other parts of device_add() (like the call to
> device_pm_add()) are also important to run before probe. Only moving
> the "dev->fwnode->dev" assignment would likely fix the current
> symptoms but lead to difficult-to-debug problems in the future.
> 
> Fix the problem by preventing probe until device_add() has run far
> enough that the device is ready to probe. If somehow we end up trying
> to probe before we're allowed, __driver_probe_device() will return
> -EPROBE_DEFER which will make certain the device is noticed.
> 
> In the race condition that was seen with Android's faster module
> loading, we will temporarily add the device to the deferred list and
> then take it off immediately when device_add() probes the device.
> 
> Instead of adding another flag to the bitfields already in "struct
> device", instead add a new "flags" field and use that. This allows us
> to freely change the bit from different thread without holding the
> device lock and without worrying about corrupting nearby bits.
> 
> [1] Captured on a machine running a downstream 6.6 kernel
> [2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libmodprobe/libmodprobe.cpp?q=LoadModulesParallel
> 
> Cc: stable@vger.kernel.org
> Fixes: 2023c610dc54 ("Driver core: add new device to bus's list before probing")
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> v1: https://lore.kernel.org/r/20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid
> v2: https://lore.kernel.org/r/20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid
> 
> As of v2 this feels like a very safe change. It doesn't change the
> ordering of any steps of probe and it _just_ prevents the early probe
> from happening.
> 
> I ran tests where I turned the printout "Device not ready_to_probe" on
> and I could see the printout happening, evidence of the race occurring
> from other printouts, and things successfully being resolved.
> 
> I kept Alan and Rafael's Reviewed-by tags in v3 even though I changed
> the implementation to use "flags" as per Danilo's request. This didn't
> seem like a major enough change to remove tags, but please shout if
> you'd like your tag removed.
> 
> Changes in v3:
> - Use a new "flags" bitfield
> - Add missing \n in probe error message
> 
> Changes in v2:
> - Instead of adjusting the ordering, use "ready_to_probe" flag
> 
>  drivers/base/core.c    | 13 +++++++++++++
>  drivers/base/dd.c      | 12 ++++++++++++
>  include/linux/device.h | 15 +++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 09b98f02f559..8d4028a2165f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3688,6 +3688,19 @@ int device_add(struct device *dev)
>  		fw_devlink_link_device(dev);
>  	}
>  
> +	/*
> +	 * The moment the device was linked into the bus's "klist_devices" in
> +	 * bus_add_device() then it's possible that probe could have been
> +	 * attempted in a different thread via userspace loading a driver
> +	 * matching the device. "DEV_FLAG_READY_TO_PROBE" being unset would have
> +	 * blocked those attempts. Now that all of the above initialization has
> +	 * happened, unblock probe. If probe happens through another thread
> +	 * after this point but before bus_probe_device() runs then it's fine.
> +	 * bus_probe_device() -> device_initial_probe() -> __device_attach()
> +	 * will notice (under device_lock) that the device is already bound.
> +	 */
> +	set_bit(DEV_FLAG_READY_TO_PROBE, &dev->flags);
> +
>  	bus_probe_device(dev);
>  
>  	/*
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 37c7e54e0e4c..3aead51173f8 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -848,6 +848,18 @@ static int __driver_probe_device(const struct device_driver *drv, struct device
>  	if (dev->driver)
>  		return -EBUSY;
>  
> +	/*
> +	 * In device_add(), the "struct device" gets linked into the subsystem's
> +	 * list of devices and broadcast to userspace (via uevent) before we're
> +	 * quite ready to probe. Those open pathways to driver probe before
> +	 * we've finished enough of device_add() to reliably support probe.
> +	 * Detect this and tell other pathways to try again later. device_add()
> +	 * itself will also try to probe immediately after setting
> +	 * "DEV_FLAG_READY_TO_PROBE".
> +	 */
> +	if (!test_bit(DEV_FLAG_READY_TO_PROBE, &dev->flags))
> +		return dev_err_probe(dev, -EPROBE_DEFER, "Device not ready to probe\n");
> +
>  	dev->can_match = true;
>  	dev_dbg(dev, "bus: '%s': %s: matched device with driver %s\n",
>  		drv->bus->name, __func__, drv->name);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index e65d564f01cd..5b7ace5921aa 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -458,6 +458,18 @@ struct device_physical_location {
>  	bool lid;
>  };
>  
> +/**
> + * enum struct_device_flags - Flags in struct device
> + *
> + * Should be accessed with thread-safe bitops.
> + *
> + * @DEV_FLAG_READY_TO_PROBE: If set then device_add() has finished enough
> + *		initialization that probe could be called.
> + */
> +enum struct_device_flags {
> +	DEV_FLAG_READY_TO_PROBE,
> +};

If you are going to want this to be a bit value, please use BIT(X) and
not an enum, as that's going to just get confusing over time.

Also, none of this manual test_bit()/set_bit() stuff, please give us
real "accessors" for this like:
	bool device_ready_to_probe(struct device *dev);

so that it's obvious what is happening.

thanks,

greg k-h

