Return-Path: <stable+bounces-3696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C221E801B23
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 08:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48411C20A05
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 07:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBFCBE67;
	Sat,  2 Dec 2023 07:24:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE071B2;
	Fri,  1 Dec 2023 23:24:49 -0800 (PST)
Received: from [192.168.0.2] (ip5f5af70b.dynamic.kabel-deutschland.de [95.90.247.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 64ACF61E5FE01;
	Sat,  2 Dec 2023 08:23:56 +0100 (CET)
Message-ID: <55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de>
Date: Sat, 2 Dec 2023 08:23:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
Content-Language: en-US
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 linux-bluetooth@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
 <2023120119-bonus-judgingly-bf57@gregkh>
 <6a710423-e76c-437e-ba59-b9cefbda3194@moonlit-rail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <6a710423-e76c-437e-ba59-b9cefbda3194@moonlit-rail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +Mario, Mathias, linux-usb]

Am 02.12.23 um 07:43 schrieb Kris Karas (Bug Reporting):
> Greg KH wrote:
>> On Fri, Dec 01, 2023 at 07:33:03AM +0100, Thorsten Leemhuis wrote:
>>> CCing a few lists and people. Greg is among them, who might know if this
>>> is a known issue that 6.6.4-rc1 et. al. might already fix.
>>
>> Not known to me, bisection is needed so we can track down the problem
>> please.
> 
> And the winner is...
> 
>> commit 14a51fa544225deb9ac2f1f9f3c10dedb29f5d2f
>> Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> Date:   Thu Oct 19 13:29:19 2023 +0300
>>
>>     xhci: Loosen RPM as default policy to cover for AMD xHC 1.1
>> >>     [ Upstream commit 4baf1218150985ee3ab0a27220456a1f027ea0ac ]
>>
>>     The AMD USB host controller (1022:43f7) isn't going into PCI D3 by default
>>     without anything connected. This is because the policy that was introduced
>>     by commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on all
>>     xHC 1.2 or later devices") only covered 1.2 or later.
>> [ snip ]
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index b9ae5c2a2527..bde43cef8846 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -535,6 +535,8 @@ static void xhci_pci_quirks(struct device *dev, 
>> struct xhci_hcd *xhci)
>>         /* xHC spec requires PCI devices to support D3hot and D3cold */
>>         if (xhci->hci_version >= 0x120)
>>                 xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>> +       else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
>> +               xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>>
>>         if (xhci->quirks & XHCI_RESET_ON_RESUME)
>>                 xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
> 
> 
> Huh, OK, I was expecting this to be a patch made to the bluetooth code, 
> as it caused bluetoothd to bomb with "opcode 0x0c03 failed".  But I just 
> verified I did the bisect correctly by backing this two-liner out of 
> vanilla 6.6.3, and bluetooth returned to normal operation.  Huzzah!
> 
> Just a brief recap:
> 
> This bug appears to be rather hardware-specific, as only a few folks 
> have reported it.  In my case, the hardware is an ASrock "X470 Taichi" 
> motherboard, and its on-board bluetooth hardware, reporting itself as:
> lspci: 0f:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Zeppelin USB 3.0 xHCI Compliant Host Controller
> lsusb: ID 8087:0aa7 Intel Corp. Wireless-AC 3168 Bluetooth
> 
> When Basavaraj's patch is applied (in mainline 6.6.2+), bluetooth stops 
> functioning on my motherboard.
> 
> Originally from bugzilla #218142 [1]
[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218142

