Return-Path: <stable+bounces-112023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B7A25A45
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 14:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECFE1886337
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB58204C1C;
	Mon,  3 Feb 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Pfqhfd+F"
X-Original-To: stable@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7481F9AAB;
	Mon,  3 Feb 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587668; cv=none; b=AgCPz+fPJqBd/CKf4mZ4FqGcz98GUnjPs1YgbRPgqaAQhts7rwQbtWwV1PmJf2+7RyTwS8LFjRIyqH3Yj9In57gyrrHtzVPszNsvHRXPEseriErW2FzYttVspW9Wc1dgkZGttIIrzmV4UUJaWwPt+zIDUFy7TlHB3gY0EYD1hNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587668; c=relaxed/simple;
	bh=jqWh2EWngA3RWMJaLWB+Q14fWJr8ao4+yiPwbt29/mI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VRCUIxQukP5uuiNVCFzuuSAmUtkIZsiUUE3JOm9LniJvbZpI4gndu53JBtQolF8+dbmv1v5nCwRnNnFEVqrAy9Txm07h23VDzApf6wq9X/Mn3D6DkqTS5Np8jW+GNoIIwIgIyK347+9KnHz7Dg2gLOhnR3g8uq6hFReKqcv6/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Pfqhfd+F; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C13CA1C21;
	Mon,  3 Feb 2025 14:00:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1738587657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJI4ZqNVFm8MO3lNKhEvrmia+9Yie1nZYMnxjuADB6Q=;
	b=Pfqhfd+Fx2Ou84vbEc65IiPsI9tlVoBDiZRZfOd/3VJroBWmRfky7590/YXV+CC660M1HV
	wC0iuc3d2oYa6tZDzudpWgFIHUh6LWGjuCeWxFYL5S4cxMHWMHYywyLSRmaZqY7o62iZvG
	tT6FhRUmXTNurmmjgyy2fTn83GFxIWDyadqee7idhTDbBHSv2JbUZnCfGwqw6YxUFJ2193
	V0PPZ+67PKEQiGGl8gZ7qdG4XqU0o7zu6dZ7cfucoJnun7EYFXXCJsKcpQOi+qXFrQXEIf
	n7Tb3pyOqyfCM7usg7ICbQr8leGSCS8m0TglaZ4YsLizqz6KzjkZeu0hfgNU2g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 14:00:55 +0100
From: nb@tipi-net.de
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Ben Hutchings
 <ben@decadent.org.uk>, n.buchwitz@kunbus.com, l.sanfilippo@kunbus.com,
 stable@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Restore Renesas uPD72020x support in xhci-pci
In-Reply-To: <2025020307-charity-snowfield-c975@gregkh>
References: <20250203120026.2010567-1-nb@tipi-net.de>
 <2025020307-charity-snowfield-c975@gregkh>
Message-ID: <5965e4219781df26f733a2e93bed9f37@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 3.2.2025 13:46, Greg Kroah-Hartman wrote:
> On Mon, Feb 03, 2025 at 01:00:26PM +0100, nb@tipi-net.de wrote:
>> From: Nicolai Buchwitz <nb@tipi-net.de>
>> 
>> Before commit 25f51b76f90f1 ("xhci-pci: Make xhci-pci-renesas a proper
>> modular driver"), the xhci-pci driver handled the Renesas uPD72020x 
>> USB3
>> PHY and only utilized features of xhci-pci-renesas when no external
>> firmware EEPROM was attached. This allowed devices with a valid 
>> firmware
>> stored in EEPROM to function without requiring xhci-pci-renesas.
>> 
>> That commit changed the behavior, making xhci-pci-renesas responsible 
>> for
>> handling these devices entirely, even when firmware was already 
>> present
>> in EEPROM. As a result, unnecessary warnings about missing firmware 
>> files
>> appeared, and more critically, USB functionality broke whens
>> CONFIG_USB_XHCI_PCI_RENESAS was not enabled—despite previously 
>> workings
>> without it.
>> 
>> Fix this by ensuring that devices are only handed over to 
>> xhci-pci-renesas
>> if the config option is enabled. Otherwise, restore the original 
>> behavior
>> and handle them as standard xhci-pci devices.
>> 
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>> Fixes: 25f51b76f90f ("xhci-pci: Make xhci-pci-renesas a proper modular 
>> driver")
>> ---
>>  drivers/usb/host/xhci-pci.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 2d1e205c14c60..4ce80d8ac603e 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -654,9 +654,11 @@ int xhci_pci_common_probe(struct pci_dev *dev, 
>> const struct pci_device_id *id)
>>  EXPORT_SYMBOL_NS_GPL(xhci_pci_common_probe, "xhci");
>> 
>>  static const struct pci_device_id pci_ids_reject[] = {
>> +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS)
>>  	/* handled by xhci-pci-renesas */
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0014) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0015) },
>> +#endif
>>  	{ /* end: all zeroes */ }
>>  };
> 
> Have you seen:
> 	https://lore.kernel.org/r/20250128104529.58a79bfc@foxbook
> ?
Hi Greg.

Thanks, I must have overlooked Michal's patch when I initially stumbled 
over the issue.
> 
> Which one is correct?

I guess both, as Michal is implementing the same slightly different.

My approach was to to keep the changes less invasive as possible and 
thus make it possible to use pci_ids_reject[] for further exceptions in 
the xhci-pci driver. In Michael's patch the list is specifically used 
for blacklisting the Renesas devices and cannot easily be expanded for 
other controllers. Either approach is fine with me, so lets move the 
discussion to the patch which came first.

> 
> thanks,
> 
> greg k-h

best,
Nicolai

