Return-Path: <stable+bounces-23357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2B185FD11
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07621282995
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1A114E2E8;
	Thu, 22 Feb 2024 15:52:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60A14D44C;
	Thu, 22 Feb 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617132; cv=none; b=KawgG8DDOXsUWrgqH6J0ZkFo3T+JehoI6Qz1WnsETQldnOpmWtQ76g44C499WvW3tpNF7kPqRFNDH9MG7L+4nM2vyOHB0qAu1UczurxwlIDZK+56It8dy3kEfHS8w68smletFKnVeWGcf3QLpTOabDyiCbZnAPcDyI6zEZLzpIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617132; c=relaxed/simple;
	bh=jVuLW6VuRNUR1+1AtUBWQPIkc6l0VQn/JByX1iGH/Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCs0oHou9k+MfuZa3vjq6hTTNW3TZZdx2P7bX1SVrfXZp5ERA2SxBNR4gTEY6EadNJF9pHZU3lzdtoIf7eSZc9RQsbnsmeAz0Uz9ST2vJxPTVmjPeimBUuRSwS9THykKlgp47+5z0Se/O/FhmQNzp9VwKueGAxB7nBEj/vW/Evc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 852D261E5FE05;
	Thu, 22 Feb 2024 16:51:51 +0100 (CET)
Message-ID: <ea027251-8fd1-4267-8484-452860e0c464@molgen.mpg.de>
Date: Thu, 22 Feb 2024 16:51:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: port: Don't try to peer unused USB ports based
 on location
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 stern@rowland.harvard.edu, stable@vger.kernel.org,
 Mike Jones <mike@mjones.io>
References: <20240222133819.4149388-1-mathias.nyman@linux.intel.com>
 <20240222133819.4149388-2-mathias.nyman@linux.intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240222133819.4149388-2-mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mathias,


Thank you for your patches fixing the problem.

Am 22.02.24 um 14:38 schrieb Mathias Nyman:
> Unused USB ports may have bogus location data in ACPI PLD tables.
> This causes port peering failures as these unused USB2 and USB3 ports
> location may match.

I comment here, although it should probably be in another branch of this 
thread.

If it is a firmware issue, this check should be added to FirmWare Test 
Suite (fwts) [1] too (I can report it there), and maybe some debug log 
should report this firmware error too.

> This is seen on DELL systems where all unused ports return zeroed
> location data.

As noted in the post scriptum in [2], much more systems seem to be affected.

> Don't try to peer or match ports that have connect type set to
> USB_PORT_NOT_USED.

When grepping the git history, pasting the warning message would help 
me. Maybe:

This fixes the warning below on the affected systems:

     usb: port power management may be unreliable

If you want to add add the Linux Kernel Bugzilla URLs:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218465
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218486

I wasn’t able to test the other two systems yet, but maybe it is obvious 
from the ACPI tables/ASL code:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218487 (Dell OptiPlex 
5055)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218490 (Dell PowerEdge 
T440)

> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
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


Thank you again and kind regards,

Paul


[1]: https://wiki.ubuntu.com/FirmwareTestSuite/
[2]: 
https://lore.kernel.org/linux-usb/5406d361-f5b7-4309-b0e6-8c94408f7d75@molgen.mpg.de/

