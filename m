Return-Path: <stable+bounces-23565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924086247B
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 12:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB491F229FC
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F425761;
	Sat, 24 Feb 2024 11:28:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20D1B59B;
	Sat, 24 Feb 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774083; cv=none; b=Z9JagudJztwtNOQYVGVjmxs5dkEpfxGmp6jAs97FEpLspVn+pln5RPq8wg/5QTVGWVHouSqph5BiMl1yttx58wDoOzaWY5WQDdQe7sIeU0vhJ7cg9ZLYwUAsmwS2h8E3lJByktksb5uI/nS1VnBEk2xyjIbHvxlbx7qa6M/Bp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774083; c=relaxed/simple;
	bh=exkH8ZNaZUfFwdAAqNtVWy0CV7J13ZxsM3lkgaMhVaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHchWerPtUia/7geiz0hLyFM4dUY3F2+vpbyKUej0KflIOeUW2B7vFtAWsep4002dhGeXp1gsvvc5ZBTphs8ym6gCyWP2oz2Z5S0UBtyDm9JLU3GSG6c4zUwpxjuiiw8GaVHJ5HhJssC4gAvTeVahdQN6qIdLyz15W7mGyM/4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (unknown [95.90.246.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A5B5061E5FE04;
	Sat, 24 Feb 2024 12:27:32 +0100 (CET)
Message-ID: <6c24ec1b-0f82-4566-9a86-80b0c33a2b47@molgen.mpg.de>
Date: Sat, 24 Feb 2024 12:27:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: port: Don't try to peer unused USB ports based on
 location
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 stern@rowland.harvard.edu, stable@vger.kernel.org
References: <20240222233343.71856-1-mathias.nyman@linux.intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240222233343.71856-1-mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mathias,


Thank you for version 2.

Am 23.02.24 um 00:33 schrieb Mathias Nyman:
> Unused USB ports may have bogus location data in ACPI PLD tables.
> This causes port peering failures as these unused USB2 and USB3 ports
> location may match.
> 
> Due to these failures the driver prints a
> "usb: port power management may be unreliable" warning, and
> unnecessarily blocks port power off during runtime suspend.
> 
> This was debugged on a couple DELL systems where the unused ports
> all returned zeroes in their location data.
> Similar bugreports exist for other systems.
> 
> Don't try to peer or match ports that have connect type set to
> USB_PORT_NOT_USED.
> 
> Fixes: 3bfd659baec8 ("usb: find internal hub tier mismatch via acpi")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218465
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218486
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/linux-usb/5406d361-f5b7-4309-b0e6-8c94408f7d75@molgen.mpg.de
> Cc: stable@vger.kernel.org # v3.16+
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
> v1 -> v2
>    - Improve commit message
>    - Add missing Fixes, Closes and Link tags
>    - send this patch separately for easier picking to usb-linus
> 
>   drivers/usb/core/port.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index c628c1abc907..4d63496f98b6 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -573,7 +573,7 @@ static int match_location(struct usb_device *peer_hdev, void *p)
>   	struct usb_hub *peer_hub = usb_hub_to_struct_hub(peer_hdev);
>   	struct usb_device *hdev = to_usb_device(port_dev->dev.parent->parent);
>   
> -	if (!peer_hub)
> +	if (!peer_hub || port_dev->connect_type == USB_PORT_NOT_USED)
>   		return 0;
>   
>   	hcd = bus_to_hcd(hdev->bus);
> @@ -584,7 +584,8 @@ static int match_location(struct usb_device *peer_hdev, void *p)
>   
>   	for (port1 = 1; port1 <= peer_hdev->maxchild; port1++) {
>   		peer = peer_hub->ports[port1 - 1];
> -		if (peer && peer->location == port_dev->location) {
> +		if (peer && peer->connect_type != USB_PORT_NOT_USED &&
> +		    peer->location == port_dev->location) {
>   			link_peers_report(port_dev, peer);
>   			return 1; /* done */
>   		}

I tested the two versions from before

     8c849968dd165 usb: port: Don't try to peer unused USB ports based 
on location
     85704eb36e9f2 usb: usb-acpi: Set port connect type of not 
connectable ports correctly
     39133352cbed6 Merge tag 'for-linus' of 
git://git.kernel.org/pub/scm/virt/kvm/kvm

on the Dell OptiPlex 5055 [1], but the USB keyboard and mouse were not 
detected. I have to find out, if I screwed up the build – as network 
also did not work –, but please wait until I get that test finished. On 
the bright side, the warning was gone. ;-)

With 6.8-rc5 and the two patches:

     [    2.020312] usbcore: registered new interface driver usbfs
     [    2.021303] usbcore: registered new interface driver hub
     [    2.022307] usbcore: registered new device driver usb
     [    3.219725] usb usb2: We don't know the algorithms for LPM for 
this host, disabling LPM.
     [    3.285546] usb usb4: We don't know the algorithms for LPM for 
this host, disabling LPM.
     [    3.301819] usbcore: registered new interface driver usb-storage
     [    3.630824] usb 1-7: new low-speed USB device number 2 using 
xhci_hcd
     [    4.120826] usb 1-10: new low-speed USB device number 3 using 
xhci_hcd

With 6.6.12 and without your patches:

     [    2.746693] usbcore: registered new interface driver usbfs
     [    2.751684] usbcore: registered new interface driver hub
     [    2.756686] usbcore: registered new device driver usb
     [    4.095689] usb usb2: We don't know the algorithms for LPM for 
this host, disabling LPM.
     [    4.116406] usb: port power management may be unreliable
     [    4.182389] usb usb4: We don't know the algorithms for LPM for 
this host, disabling LPM.
     [    4.203353] usbcore: registered new interface driver usb-storage
     [    4.417466] usb 1-7: new low-speed USB device number 2 using 
xhci_hcd
     [    4.918470] usb 1-10: new low-speed USB device number 3 using 
xhci_hcd
     [   13.184956] usbcore: registered new interface driver usbhid
     [   13.191508] usbhid: USB HID core driver
     [   13.333554] input: Dell Dell USB Entry Keyboard as 
/devices/pci0000:00/0000:00:01.3/0000:01:00.0/usb1/1-7/1-7:1.0/0003:413C:2107.0001/input/input8
     [   13.421779] hid-generic 0003:413C:2107.0001: input,hidraw0: USB 
HID v1.10 Keyboard [Dell Dell USB Entry Keyboard] on 
usb-0000:01:00.0-7/input0
     [   13.446542] input: Logitech USB-PS/2 Optical Mouse as 
/devices/pci0000:00/0000:00:01.3/0000:01:00.0/usb1/1-10/1-10:1.0/0003:046D:C050.0002/input/input11
     [   13.473113] hid-generic 0003:046D:C050.0002: input,hidraw1: USB 
HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on 
usb-0000:01:00.0-10/input0

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218487

