Return-Path: <stable+bounces-231252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMZ5C7Oaymmg+QUAu9opvQ
	(envelope-from <stable+bounces-231252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:45:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 830D835E1CC
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF7A8300A62B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EFF364E84;
	Mon, 30 Mar 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo67GrZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9136308A
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774885019; cv=none; b=UJBqvUJyty3SJEr+HlcimM5Gr9ykD+r2pgYcea+eWOg+RyyKvqZx1Wgrwi0PNeGHLkTdFl7A/XWP+YWxx1eMCmtjyNDNyVCJitwwhM/9liA3nN6TfyQRjT7hJIJ5sm7QJlJJdu2OMfHg2jjlIhv5R3oCASCe7OzL1W2a+ymfokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774885019; c=relaxed/simple;
	bh=bu7ebmUimIfKYxRtaAiu36rS7ei7eIe+dYDVb3Ft9HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBiCIOowvRF3D2Q9PNkW7L01DeDCbB9c+7QCCUKnyXHlkIaOTCTmT0ammoXN3entR+WcWGXxuVkJ9Hp7wuZyiWJLI1nSCDUnNZqYLUQFlCZk3OcV5j5pTRvR+6qEhZhGlGMPzOlfJMnwEldgPe6lLfZkL6uUPleMtYimNDmVm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo67GrZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B414C2BCB9
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774885019;
	bh=bu7ebmUimIfKYxRtaAiu36rS7ei7eIe+dYDVb3Ft9HU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zo67GrZVoY1r8/GPF6zkrcirHcsSbhTxlMuDof2IA4eJXz8ZQ+ttn7xRg3sbGz0m9
	 MOJGGFC6FzdrvhYJA5QzMIA3rwHXql3FBkoU2DSh8HlAyd/r064ontT5kYMcALGwL3
	 GtLNOfuElQL7UDFYZ2LEHDkHOxa3/OVwt1ochHzaJei6oOphLEw1kc+aiLQyZ2keh3
	 IM0jdlXSUBuBOQCLyDW/sDhKTKgHcqB6mt3g03B2F0iSKqivhYYyhOYQp8KHRTCBB/
	 N0HgKzTX0aNIpQ4ZCy3l0WTW6rpG0JDCPIVyyFmuSIdcMXb8Ym68keeENG4Qdu62aQ
	 7gqM4DZgWKD1g==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-67e09232daeso2742798eaf.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:36:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVa8kXQLzXLM06TwEbbnjacmLBTRUIiD94+RweD2/tinKt1kfNlNSLQsbgLGJAzFQaYXDX64cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq0BciIMVx0PHqPhJcsoVEEqDM0Q08C1WYyQZEpEpqC6ORuv/P
	SLRg59z35t8bUvWVyi3mmI/aJ7PIt18ilO6BdQ5d1ld5ubHtqorr6kkQ7GWaivPj5ziAbe1HATV
	JaeaE2L6wY5O5ikJBf7SREHxv6Pp5uzk=
X-Received: by 2002:a05:6820:210a:b0:67e:3985:e110 with SMTP id
 006d021491bc7-67e3985e144mr827925eaf.56.1774885018139; Mon, 30 Mar 2026
 08:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
In-Reply-To: <20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Mar 2026 17:36:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ha2OqzXotG033Dh+ua72xr1kaMT7fx+zsKEJgJuhFsBg@mail.gmail.com>
X-Gm-Features: AQROBzBnkZGUjF4VcYvBDOZtcYi-LRHD2QZkvxWUiU2k6YhllRfgP-P_k7oePTM
Message-ID: <CAJZ5v0ha2OqzXotG033Dh+ua72xr1kaMT7fx+zsKEJgJuhFsBg@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Don't let a device probe until it's ready
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Kay Sievers <kay.sievers@vrfy.org>, Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231252-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,android.com:url]
X-Rspamd-Queue-Id: 830D835E1CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 4:29=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
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
> [1] Captured on a machine running a downstream 6.6 kernel
> [2] https://cs.android.com/android/platform/superproject/main/+/main:syst=
em/core/libmodprobe/libmodprobe.cpp?q=3DLoadModulesParallel
>
> Cc: stable@vger.kernel.org
> Fixes: 2023c610dc54 ("Driver core: add new device to bus's list before pr=
obing")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> v1: https://lore.kernel.org/r/20260320200656.RFC.1.Id750b0fbcc94f23ed04b7=
aecabcead688d0d8c17@changeid
>
> This v2 feels like a very safe change. It doesn't change the ordering
> of any steps of probe and it _just_ prevents the early probe from
> happening.
>
> I ran tests where I turned the printout "Device not ready_to_probe" on
> and I could see the printout happening, evidence of the race occurring
> from other printouts, and things successfully being resolved.
>
> Changes in v2:
> - Instead of adjusting the ordering, use "ready_to_probe" flag
>
>  drivers/base/core.c    | 15 +++++++++++++++
>  drivers/base/dd.c      | 12 ++++++++++++
>  include/linux/device.h |  3 +++
>  3 files changed, 30 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 09b98f02f559..4caa3fd1ecdb 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3688,6 +3688,21 @@ int device_add(struct device *dev)
>                 fw_devlink_link_device(dev);
>         }
>
> +       /*
> +        * The moment the device was linked into the bus's "klist_devices=
" in
> +        * bus_add_device() then it's possible that probe could have been
> +        * attempted in a different thread via userspace loading a driver
> +        * matching the device. "ready_to_probe" being false would have b=
locked
> +        * those attempts. Now that all of the above initialization has
> +        * happened, unblock probe. If probe happens through another thre=
ad
> +        * after this point but before bus_probe_device() runs then it's =
fine.
> +        * bus_probe_device() -> device_initial_probe() -> __device_attac=
h()
> +        * will notice (under device_lock) that the device is already bou=
nd.
> +        */
> +       device_lock(dev);
> +       dev->ready_to_probe =3D true;
> +       device_unlock(dev);
> +
>         bus_probe_device(dev);
>
>         /*
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 37c7e54e0e4c..a1762254828f 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -848,6 +848,18 @@ static int __driver_probe_device(const struct device=
_driver *drv, struct device
>         if (dev->driver)
>                 return -EBUSY;
>
> +       /*
> +        * In device_add(), the "struct device" gets linked into the subs=
ystem's
> +        * list of devices and broadcast to userspace (via uevent) before=
 we're
> +        * quite ready to probe. Those open pathways to driver probe befo=
re
> +        * we've finished enough of device_add() to reliably support prob=
e.
> +        * Detect this and tell other pathways to try again later. device=
_add()
> +        * itself will also try to probe immediately after setting
> +        * "ready_to_probe".
> +        */
> +       if (!dev->ready_to_probe)
> +               return dev_err_probe(dev, -EPROBE_DEFER, "Device not read=
y_to_probe");
> +
>         dev->can_match =3D true;
>         dev_dbg(dev, "bus: '%s': %s: matched device with driver %s\n",
>                 drv->bus->name, __func__, drv->name);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index e65d564f01cd..e2f83384b627 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -553,6 +553,8 @@ struct device_physical_location {
>   * @dma_skip_sync: DMA sync operations can be skipped for coherent buffe=
rs.
>   * @dma_iommu: Device is using default IOMMU implementation for DMA and
>   *             doesn't rely on dma_ops structure.
> + * @ready_to_probe: If set to %true then device_add() has finished enoug=
h
> + *             initialization that probe could be called.
>   *
>   * At the lowest level, every device in a Linux system is represented by=
 an
>   * instance of struct device. The device structure contains the informat=
ion
> @@ -675,6 +677,7 @@ struct device {
>  #ifdef CONFIG_IOMMU_DMA
>         bool                    dma_iommu:1;
>  #endif
> +       bool                    ready_to_probe:1;
>  };
>
>  /**
> --
> 2.53.0.1018.g2bb0e51243-goog
>

