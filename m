Return-Path: <stable+bounces-25475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7487486C5EC
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262D1289588
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9385E62143;
	Thu, 29 Feb 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmuBrjBQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E24260DF2;
	Thu, 29 Feb 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199913; cv=none; b=qN4cLqbSnFEV/zLPBR4glkQV13H2btPF8Gsv0GwzF8Wm+YdCc37em2YBmoCGeGD80Jr0vgZ96hfxCb2gzWydTqgasHA37si+3ocPKiBiRx+64s+tmc8ghvyvFzLr632Usljz5I6FkIAQiieA/GFP7sor4inFbt+5mVoXa6Ch7Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199913; c=relaxed/simple;
	bh=N4ExwYK4obzpBCaotNTjUlxJUXpLOasw+lbaXcE8vr4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=hm4vI/0gQjOKu8ZfHe1w5bXAwvk5Lbi3IigPWm1k6bUPrBWW1+ToVuKwLl7ZmXCe1cdeAPd61BpeFzB3Pzm3OwG0N1M697Ul7I7QLsPlTFr87RqZbR9iY/fwZ0IAmUIGGByYL+yoF4sR8X0tXo5orjLOLtqoPFcT9ekZyB+SIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmuBrjBQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709199912; x=1740735912;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=N4ExwYK4obzpBCaotNTjUlxJUXpLOasw+lbaXcE8vr4=;
  b=OmuBrjBQw6PtbALOt6RXp5iJW1fGLyBEC8pQowrce1qaKchqPS3NY6ir
   7kY62pB+4uUKfZtg+QEwP8vF3412RDwKOZ7cwXcV4BRbmMjaSYE9OPwJb
   7RQ3VeKmvUQr0bohxkiY9CI24LsAGMM3jn5mHOCakGV2T8NtIN11zcUKS
   Cs9GXXl+Vs8OarEmUVYtv1cRz5AbfnMQMxkK17D6uyR+wRV3ts1p9PBxV
   G5M6zPyj/zrBDA1oXo2Frn2XNrpzvJj0ib2rECwlAvzYqZp3F18RAri8B
   8JL1bPkMzTG4qAhHWMddTlCigfGVsFfmIyaB3pTk++aylsl5JCJRkHhnW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21200864"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="21200864"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:45:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937035547"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937035547"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 01:45:06 -0800
Message-ID: <a1274e8a-c761-a39f-20a4-06989e8144c6@linux.intel.com>
Date: Thu, 29 Feb 2024 11:46:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com,
 linux-usb@vger.kernel.org
Cc: mario.limonciello@amd.com, stable@vger.kernel.org,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20240226152831.2147932-1-Basavaraj.Natikar@amd.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] xhci: Allow RPM on the USB controller (1022:43f7) by
 default
In-Reply-To: <20240226152831.2147932-1-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.2.2024 17.28, Basavaraj Natikar wrote:
> The AMD USB host controller (1022:43f7) does not enter PCI D3 by default
> when nothing is connected. This is due to the policy introduced by
> 'commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on all
> xHC 1.2 or later devices")', which only covers 1.2 or later devices.

This makes it seem like commit a611bf473d1 somehow restricted default runtime
PM when in fact it enabled it for all xHCI 1.2 hosts.

Before that only a few selected ones had runtime PM enabled by default.

How about something like:

Enable runtime PM by default for older AMD 1022:43f7 xHCI 1.1 host as it is
proven to work.
Driver enables runtime PM by default for newer xHCI 1.2 host.

> 
> Therefore, by default, allow RPM on the AMD USB controller [1022:43f7].
> 
> Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")

This was already reverted as it caused regression on some systems.
24be0b3c4059 Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"

> Link: https://lore.kernel.org/all/12335218.O9o76ZdvQC@natalenko.name/
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@vger.kernel.org

I'd skip Fixes and stable tags and add this as a feature to usb-next.

> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
> Changes in v2:
> 	- Added Cc: stable@vger.kernel.org
> 
>   drivers/usb/host/xhci-pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index b534ca9752be..1eb7a41a75d7 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -473,6 +473,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>   	/* xHC spec requires PCI devices to support D3hot and D3cold */
>   	if (xhci->hci_version >= 0x120)
>   		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> +	else if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43f7)
> +		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;

This would fit better earlier in the code among the rest of the AMD quirks.
See how this flag is set for some other hosts.

Thanks
Mathias


