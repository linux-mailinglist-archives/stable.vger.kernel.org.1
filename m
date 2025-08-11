Return-Path: <stable+bounces-166992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B2FB1FF1C
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 08:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED49F7A3379
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 06:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3253D274B29;
	Mon, 11 Aug 2025 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSohH8w+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B5226D00;
	Mon, 11 Aug 2025 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754892971; cv=none; b=N/Za52DMMfv5npNz/Jpd/424Zo6PFABT7UgD/n2pGTKF3xrDFZVWv5npsty49LQRpl4bz489Mt7V1A9VW/djOKaztsngeJKcDRIWWF9mS3ZBRxtBs4EfxAmmrWMGM/WwzFk6C0orRgZ4YJfdHbb+6oG6Jg8hTjjS+kOIzkZpIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754892971; c=relaxed/simple;
	bh=qMlhxqBt7AJrdMARp3nZRbZd6w3HgcuSrxLDAmSjyXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUedf5jTwjqkVxgT1wI9AHj/9j6g9NNHO8b6KVslKQn+Xjxq8kMvxAN5pLI5aKifN1IeEZnEuaDijPlqYRFo/IdcpqxJbm7qzxCSb5Ii8rfgCCnvlcYjEdo7hpVhg9CSZe4qvhFDPczHUpv4ksdjMmQkB8ji/SOpZ2vlJJTODWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSohH8w+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEE0C4CEED;
	Mon, 11 Aug 2025 06:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754892970;
	bh=qMlhxqBt7AJrdMARp3nZRbZd6w3HgcuSrxLDAmSjyXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pSohH8w+uebTi3JK3r24WY9/nSzPXkdgAJsklDus+oACsMiKRrNpT1/6GDmT0ySUs
	 PBvS/WdDi+dwwmcMqc9eTtPTiPF/Vn/9U9Cma/cLgJG5Ibgv480EA7qFMSm5CgnG/M
	 hiuomdac492c4Wkd6QspIglev6CGhp5f5lY57vI/Nvq9BrmV/06PP9Vv2PPa+g//xB
	 Gt8IQneJqC4GCzKR/SeTqY8CUPz55pVrEPhg6O8qI/vPZrraePWFBmqxlemGceuRfJ
	 /z9di4aOYFQk/VqMLVRUXv6xJpoeazBJc6jmuIRxI6VDo5mSrpdVAnbycuOT0N9DtF
	 7Rd9IWnczyLoA==
Message-ID: <fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
Date: Mon, 11 Aug 2025 08:16:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
To: Mathias Nyman <mathias.nyman@linux.intel.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz_Bartosik?=
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23. 06. 25, 15:39, Mathias Nyman wrote:
> Hub driver warm-resets ports in SS.Inactive or Compliance mode to
> recover a possible connected device. The port reset code correctly
> detects if a connection is lost during reset, but hub driver
> port_event() fails to take this into account in some cases.
> port_event() ends up using stale values and assumes there is a
> connected device, and will try all means to recover it, including
> power-cycling the port.
> 
> Details:
> This case was triggered when xHC host was suspended with DbC (Debug
> Capability) enabled and connected. DbC turns one xHC port into a simple
> usb debug device, allowing debugging a system with an A-to-A USB debug
> cable.
> 
> xhci DbC code disables DbC when xHC is system suspended to D3, and
> enables it back during resume.
> We essentially end up with two hosts connected to each other during
> suspend, and, for a short while during resume, until DbC is enabled back.
> The suspended xHC host notices some activity on the roothub port, but
> can't train the link due to being suspended, so xHC hardware sets a CAS
> (Cold Attach Status) flag for this port to inform xhci host driver that
> the port needs to be warm reset once xHC resumes.
> 
> CAS is xHCI specific, and not part of USB specification, so xhci driver
> tells usb core that the port has a connection and link is in compliance
> mode. Recovery from complinace mode is similar to CAS recovery.
> 
> xhci CAS driver support that fakes a compliance mode connection was added
> in commit 8bea2bd37df0 ("usb: Add support for root hub port status CAS")
> 
> Once xHCI resumes and DbC is enabled back, all activity on the xHC
> roothub host side port disappears. The hub driver will anyway think
> port has a connection and link is in compliance mode, and hub driver
> will try to recover it.
> 
> The port power-cycle during recovery seems to cause issues to the active
> DbC connection.
> 
> Fix this by clearing connect_change flag if hub_port_reset() returns
> -ENOTCONN, thus avoiding the whole unnecessary port recovery and
> initialization attempt.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8bea2bd37df0 ("usb: Add support for root hub port status CAS")
> Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
>   drivers/usb/core/hub.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 6bb6e92cb0a4..f981e365be36 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5754,6 +5754,7 @@ static void port_event(struct usb_hub *hub, int port1)
>   	struct usb_device *hdev = hub->hdev;
>   	u16 portstatus, portchange;
>   	int i = 0;
> +	int err;
>   
>   	connect_change = test_bit(port1, hub->change_bits);
>   	clear_bit(port1, hub->event_bits);
> @@ -5850,8 +5851,11 @@ static void port_event(struct usb_hub *hub, int port1)
>   		} else if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
>   				|| udev->state == USB_STATE_NOTATTACHED) {
>   			dev_dbg(&port_dev->dev, "do warm reset, port only\n");
> -			if (hub_port_reset(hub, port1, NULL,
> -					HUB_BH_RESET_TIME, true) < 0)
> +			err = hub_port_reset(hub, port1, NULL,
> +					     HUB_BH_RESET_TIME, true);
> +			if (!udev && err == -ENOTCONN)
> +				connect_change = 0;
> +			else if (err < 0)
>   				hub_port_disable(hub, port1, 1);

This was reported to break the USB on one box:
> [Wed Aug  6 16:51:33 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
> [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
> [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
> [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
> [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: Device not responding to setup address.
> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: Device not responding to setup address.
> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: device not accepting address 12, error -71
> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: WARN: invalid context state for evaluate context command.
> [Wed Aug  6 16:51:36 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
> [Wed Aug  6 16:51:36 2025] [     C10] xhci_hcd 0000:0e:00.0: ERROR unknown event type 2
> [Wed Aug  6 16:51:36 2025] [ T355745] usb 1-2: Device not responding to setup address.
> [Wed Aug  6 16:51:37 2025] [     C10] xhci_hcd 0000:0e:00.0: ERROR unknown event type 2
> [Wed Aug  6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: Abort failed to stop command ring: -110
> [Wed Aug  6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: xHCI host controller not responding, assume dead
> [Wed Aug  6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: HC died; cleaning up
> [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-1: USB disconnect, device number 13
> [Wed Aug  6 16:52:50 2025] [ T355745] xhci_hcd 0000:0e:00.0: Timeout while waiting for setup device command
> [Wed Aug  6 16:52:50 2025] [ T362645] usb 2-3: USB disconnect, device number 2
> [Wed Aug  6 16:52:50 2025] [ T362839] cdc_acm 1-5:1.5: acm_port_activate - usb_submit_urb(ctrl irq) failed
> [Wed Aug  6 16:52:50 2025] [ T355745] usb 1-2: device not accepting address 12, error -62
> [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-2: USB disconnect, device number 12
> [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-3: USB disconnect, device number 4
> [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-3.1: USB disconnect, device number 6
> [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-4: USB disconnect, device number 16
> [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-5: USB disconnect, device number 15
> [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-7: USB disconnect, device number 8

Using 6.16 minus this 2521106fc732b0b makes it works again.

The same happens with 6.15.8 as this was backported there. (6.15.6 is fine).

lsusb --tree

> /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/12p, 480M
>     |__ Port 003: Dev 006, If 0, Class=Hub, Driver=hub/4p, 480M
>         |__ Port 001: Dev 008, If 0, Class=Human Interface Device, Driver=usbhid, 12M
>         |__ Port 001: Dev 008, If 1, Class=Human Interface Device, Driver=usbhid, 12M
>         |__ Port 001: Dev 008, If 2, Class=Chip/SmartCard, Driver=usbfs, 12M
>     |__ Port 004: Dev 007, If 0, Class=Audio, Driver=snd-usb-audio, 480M
>     |__ Port 004: Dev 007, If 1, Class=Audio, Driver=snd-usb-audio, 480M
>     |__ Port 004: Dev 007, If 2, Class=Application Specific Interface, Driver=[none], 480M
>     |__ Port 004: Dev 007, If 3, Class=Communications, Driver=cdc_acm, 480M
>     |__ Port 004: Dev 007, If 4, Class=CDC Data, Driver=cdc_acm, 480M
>     |__ Port 005: Dev 009, If 0, Class=Audio, Driver=snd-usb-audio, 480M
>     |__ Port 005: Dev 009, If 1, Class=Audio, Driver=snd-usb-audio, 480M
>     |__ Port 005: Dev 009, If 2, Class=Audio, Driver=snd-usb-audio, 480M
>     |__ Port 005: Dev 009, If 3, Class=Audio, Driver=snd-usb-audio, 480M
>     |__ Port 005: Dev 009, If 4, Class=Audio, Driver=snd-usb-audio, 480M
>     |__ Port 005: Dev 009, If 5, Class=Communications, Driver=cdc_acm, 480M
>     |__ Port 005: Dev 009, If 6, Class=CDC Data, Driver=cdc_acm, 480M
>     |__ Port 007: Dev 010, If 0, Class=Vendor Specific Class, Driver=[none], 12M
>     |__ Port 007: Dev 010, If 2, Class=Human Interface Device, Driver=usbhid, 12M
> /:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/5p, 20000M/x2
>     |__ Port 003: Dev 002, If 0, Class=Hub, Driver=hub/4p, 5000M
> /:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/12p, 480M
>     |__ Port 003: Dev 002, If 0, Class=Human Interface Device, Driver=usbhid, 12M
>     |__ Port 003: Dev 002, If 1, Class=Human Interface Device, Driver=usbhid, 12M
>     |__ Port 003: Dev 002, If 2, Class=Human Interface Device, Driver=usbhid, 12M
> /:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/5p, 20000M/x2
> /:  Bus 005.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/2p, 480M
> /:  Bus 006.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/2p, 10000M
> /:  Bus 007.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/2p, 480M
>     |__ Port 002: Dev 002, If 0, Class=Human Interface Device, Driver=usbhid, 480M
>     |__ Port 002: Dev 002, If 1, Class=Human Interface Device, Driver=usbhid, 480M
>     |__ Port 002: Dev 002, If 2, Class=Human Interface Device, Driver=usbhid, 480M
> /:  Bus 008.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/2p, 10000M
> /:  Bus 009.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/1p, 480M
> /:  Bus 010.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/0p, 5000M


Any ideas? What would you need to debug this?

thanks,
-- 
js
suse labs


