Return-Path: <stable+bounces-3695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEA9801B13
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 08:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E6C1F21144
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 07:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0028C16;
	Sat,  2 Dec 2023 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="DPfoABis";
	dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="RIPmwQbH"
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 1362 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 23:06:09 PST
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E9198
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 23:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lJ6CLBPmn1Z2D81iRRarPRH80dMiJ6ru3Jjv1I7wNzc=; t=1701499406; x=1704091406; 
	b=DPfoABisNRE3n26aa7zZssyFWugSjMc6/7/FGKYXNU/8ABhFjX57YTq8BInatWYpVZV++yT7sbh
	aaj6wiPOuKxbptussw4BCje/4oNVpf/UcHiGfK61HYvkKF1mPrDBvPBFI1ede+q2tAiBPcadTPxoy
	GxNFN2kI2FABHEWIToTSsZ9bT4VFbTHSwfN3CGzPZgzKaN+FUt7QmS1VBx0aut5AsgVk8c4mix3m1
	O1y19s9hLwyBxDI2455C3aIXjyl8Ua9VQr8E6QVR33onW6XUDjBd1bR3OPlZJYKIgbmG8uKzmuS2h
	e0/O8ILVCcO5nFnFXUbgpLWpCWczZF9wfCCA==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lJ6CLBPmn1Z2D81iRRarPRH80dMiJ6ru3Jjv1I7wNzc=; t=1701499406; x=1704091406; 
	b=RIPmwQbHp1jIwXjrGbXjcwqlxzk8tljpr/ZQNLNoPIhERBr1VaxcnOdjtaun7K+jfBVWLEb5PwZ
	vAtvnsbtJCg==;
Message-ID: <6a710423-e76c-437e-ba59-b9cefbda3194@moonlit-rail.com>
Date: Sat, 2 Dec 2023 01:43:16 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
To: Greg KH <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-bluetooth@vger.kernel.org,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
 <2023120119-bonus-judgingly-bf57@gregkh>
Content-Language: en-US, en-GB
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
In-Reply-To: <2023120119-bonus-judgingly-bf57@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Fri, Dec 01, 2023 at 07:33:03AM +0100, Thorsten Leemhuis wrote:
>> CCing a few lists and people. Greg is among them, who might know if this
>> is a known issue that 6.6.4-rc1 et. al. might already fix.
> 
> Not known to me, bisection is needed so we can track down the problem
> please.

And the winner is...

> commit 14a51fa544225deb9ac2f1f9f3c10dedb29f5d2f
> Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Date:   Thu Oct 19 13:29:19 2023 +0300
> 
>     xhci: Loosen RPM as default policy to cover for AMD xHC 1.1
>     
>     [ Upstream commit 4baf1218150985ee3ab0a27220456a1f027ea0ac ]
>     
>     The AMD USB host controller (1022:43f7) isn't going into PCI D3 by default
>     without anything connected. This is because the policy that was introduced
>     by commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on all
>     xHC 1.2 or later devices") only covered 1.2 or later.
>     
> [ snip ]
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index b9ae5c2a2527..bde43cef8846 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -535,6 +535,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>         /* xHC spec requires PCI devices to support D3hot and D3cold */
>         if (xhci->hci_version >= 0x120)
>                 xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> +       else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
> +               xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>  
>         if (xhci->quirks & XHCI_RESET_ON_RESUME)
>                 xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,


Huh, OK, I was expecting this to be a patch made to the bluetooth code, 
as it caused bluetoothd to bomb with "opcode 0x0c03 failed".  But I just 
verified I did the bisect correctly by backing this two-liner out of 
vanilla 6.6.3, and bluetooth returned to normal operation.  Huzzah!

Just a brief recap:

This bug appears to be rather hardware-specific, as only a few folks 
have reported it.  In my case, the hardware is an ASrock "X470 Taichi" 
motherboard, and its on-board bluetooth hardware, reporting itself as:
lspci: 0f:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] 
Zeppelin USB 3.0 xHCI Compliant Host Controller
lsusb: ID 8087:0aa7 Intel Corp. Wireless-AC 3168 Bluetooth

When Basavaraj's patch is applied (in mainline 6.6.2+), bluetooth stops 
functioning on my motherboard.

Originally from bugzilla #218142

-- 
Kris

