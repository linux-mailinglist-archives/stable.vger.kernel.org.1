Return-Path: <stable+bounces-23708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2738677F8
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 15:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0FF1C22520
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC5B12A14F;
	Mon, 26 Feb 2024 14:14:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DC31292E0;
	Mon, 26 Feb 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956856; cv=none; b=IuVvg59jQN+yfLmyKlr5telZlE663Ao4tDDe5g5awJys562J698MyzWrer0VvcWsmIJtgPGX7J5xU4UjuhRsNwYgQ4I1GcbPshEgUio91t/pAQ7ZZ+oqNoUhBitAf6fSNeYARhfptTJYnhr6rna+Ho81kvZsj6tbggVZyigM4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956856; c=relaxed/simple;
	bh=NyFakqApGDI7TfGmv5PnraoL1jqrvohUulDBNF8CH3k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RZVLXHO7pjTIRDtxAOO7RodPTWjHfznj+OTFiPSA9Xgg0bC7GB2Uif/q7e28bZwPl9+Kj4j7lBrWHFGXKqOCeakjpOE2cX1XKLMRZ1lXl/i2vnuf/vVr1BRFwP6zw5kKyaThlcO8+6XmB+3ftCPsAWwEB29wGpQzDU8eZq3BYd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5262661E5FE01;
	Mon, 26 Feb 2024 15:13:50 +0100 (CET)
Message-ID: <cb011279-4150-405d-9acd-30ebd537f142@molgen.mpg.de>
Date: Mon, 26 Feb 2024 15:13:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: port: Don't try to peer unused USB ports based on
 location
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 stern@rowland.harvard.edu, stable@vger.kernel.org
References: <20240222233343.71856-1-mathias.nyman@linux.intel.com>
 <6c24ec1b-0f82-4566-9a86-80b0c33a2b47@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <6c24ec1b-0f82-4566-9a86-80b0c33a2b47@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mathias,


Am 24.02.24 um 12:27 schrieb Paul Menzel:

> Thank you for version 2.
> 
> Am 23.02.24 um 00:33 schrieb Mathias Nyman:
>> Unused USB ports may have bogus location data in ACPI PLD tables.
>> This causes port peering failures as these unused USB2 and USB3 ports
>> location may match.
>>
>> Due to these failures the driver prints a
>> "usb: port power management may be unreliable" warning, and
>> unnecessarily blocks port power off during runtime suspend.
>>
>> This was debugged on a couple DELL systems where the unused ports
>> all returned zeroes in their location data.
>> Similar bugreports exist for other systems.
>>
>> Don't try to peer or match ports that have connect type set to
>> USB_PORT_NOT_USED.
>>
>> Fixes: 3bfd659baec8 ("usb: find internal hub tier mismatch via acpi")
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218465
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218486
>> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Link: https://lore.kernel.org/linux-usb/5406d361-f5b7-4309-b0e6-8c94408f7d75@molgen.mpg.de
>> Cc: stable@vger.kernel.org # v3.16+
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> ---
>> v1 -> v2
>>    - Improve commit message
>>    - Add missing Fixes, Closes and Link tags
>>    - send this patch separately for easier picking to usb-linus
>>
>>   drivers/usb/core/port.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index c628c1abc907..4d63496f98b6 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -573,7 +573,7 @@ static int match_location(struct usb_device 
>> *peer_hdev, void *p)
>>       struct usb_hub *peer_hub = usb_hub_to_struct_hub(peer_hdev);
>>       struct usb_device *hdev = 
>> to_usb_device(port_dev->dev.parent->parent);
>> -    if (!peer_hub)
>> +    if (!peer_hub || port_dev->connect_type == USB_PORT_NOT_USED)
>>           return 0;
>>       hcd = bus_to_hcd(hdev->bus);
>> @@ -584,7 +584,8 @@ static int match_location(struct usb_device 
>> *peer_hdev, void *p)
>>       for (port1 = 1; port1 <= peer_hdev->maxchild; port1++) {
>>           peer = peer_hub->ports[port1 - 1];
>> -        if (peer && peer->location == port_dev->location) {
>> +        if (peer && peer->connect_type != USB_PORT_NOT_USED &&
>> +            peer->location == port_dev->location) {
>>               link_peers_report(port_dev, peer);
>>               return 1; /* done */
>>           }
> 
> I tested the two versions from before
> 
>      8c849968dd165 usb: port: Don't try to peer unused USB ports based 
> on location
>      85704eb36e9f2 usb: usb-acpi: Set port connect type of not 
> connectable ports correctly
>      39133352cbed6 Merge tag 'for-linus' of 
> git://git.kernel.org/pub/scm/virt/kvm/kvm
> 
> on the Dell OptiPlex 5055 [1], but the USB keyboard and mouse were not 
> detected. I have to find out, if I screwed up the build – as network 
> also did not work –, but please wait until I get that test finished. On 
> the bright side, the warning was gone. ;-)

[…]

Sorry, wrong alarm. I guess I messed the module installation, and the 
modules were not found. I successfully tested it on a different Dell 
OptiPlex 5055 and uploaded the messages to the Linux Kernel Bugzilla 
issue [1].

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>

Sorry for the noise.


Kind regards,

Paul


> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218487

