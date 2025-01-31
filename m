Return-Path: <stable+bounces-111795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81CCA23C7A
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 11:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CD81633F9
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364751B4F09;
	Fri, 31 Jan 2025 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iS6idcDf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14801CA81;
	Fri, 31 Jan 2025 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320510; cv=none; b=LfL56rxMDvCKKIOawYiN22qVBHufC37iDAex2wAhHcoyoenQJUIWC3b2Lw7DdLzJo0rj9lK2ZZvj96IGHk6CvgmNMm0P73wtkDvA8j8IrOZm9hzZgEWVeeFfAmoATVt7V3lvNVm8FahQ9VMww/oPChAG8itDm9UJ6X/x/rWUmh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320510; c=relaxed/simple;
	bh=mbcVU4/KYOCDqVBfV1Wmm4rFmFhpD+8bSrlKxn6+4W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7XTXn4LbLBdFF3CzRLMExfgYMmMGbnQ4cFlRxlR3tCpNhvmlEzUlqEYDn/Uib3cBwnZlgvZtYKJki2ZEpesNflNIa0vcU38DhEkv2XJkBdtjvp5HMj8QIsTeSySxMwidiYl+NySfCYXpZT/L7wbgQC4SxsflAPv2lvSNNsoZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iS6idcDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB62C4CED1;
	Fri, 31 Jan 2025 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738320510;
	bh=mbcVU4/KYOCDqVBfV1Wmm4rFmFhpD+8bSrlKxn6+4W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iS6idcDf46+1ZF0QPrJ+mG6y2lhOW6+egN5YwY6JjbkD7H9br1Gbfwrm3ePhfjBnL
	 tGRSEtp5FumQLHq+0ucmY79PH0w2/Ps8t5qIhkEOPLL/HxrJzZEsLc4BqDgyrU3B66
	 9NpuGRVrVvIrXAJFzgHFyTSEXY9SNtrLBNhzqvF4=
Date: Fri, 31 Jan 2025 11:48:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: Re: [PATCH] USB: pci-quirks: Fix HCCPARAMS register error for LS7A
 EHCI
Message-ID: <2025013107-droplet-reset-127e@gregkh>
References: <20250131100651.343015-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131100651.343015-1-chenhuacai@loongson.cn>

On Fri, Jan 31, 2025 at 06:06:51PM +0800, Huacai Chen wrote:
> LS7A EHCI controller doesn't have extended capabilities, so the EECP
> (EHCI Extended Capabilities Pointer) field of HCCPARAMS register should
> be 0x0, but it reads as 0xa0 now. This is a hardware flaw and will be
> fixed in future, now just clear the EECP field to avoid error messages
> on boot:
> 
> ......
> [    0.581675] pci 0000:00:04.1: EHCI: unrecognized capability ff
> [    0.581699] pci 0000:00:04.1: EHCI: unrecognized capability ff
> [    0.581716] pci 0000:00:04.1: EHCI: unrecognized capability ff
> [    0.581851] pci 0000:00:04.1: EHCI: unrecognized capability ff
> ......
> [    0.581916] pci 0000:00:05.1: EHCI: unrecognized capability ff
> [    0.581951] pci 0000:00:05.1: EHCI: unrecognized capability ff
> [    0.582704] pci 0000:00:05.1: EHCI: unrecognized capability ff
> [    0.582799] pci 0000:00:05.1: EHCI: unrecognized capability ff
> ......
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/usb/host/pci-quirks.c | 4 ++++
>  include/linux/pci_ids.h       | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 1f9c1b1435d8..7e3151400a5e 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -958,6 +958,10 @@ static void quirk_usb_disable_ehci(struct pci_dev *pdev)
>  	 * booting from USB disk or using a usb keyboard
>  	 */
>  	hcc_params = readl(base + EHCI_HCC_PARAMS);
> +	if (pdev->vendor == PCI_VENDOR_ID_LOONGSON &&
> +	    pdev->device == PCI_DEVICE_ID_LOONGSON_EHCI)
> +		hcc_params &= ~(0xffL << 8);
> +
>  	offset = (hcc_params >> 8) & 0xff;
>  	while (offset && --count) {
>  		pci_read_config_dword(pdev, offset, &cap);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index de5deb1a0118..74a84834d9eb 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -162,6 +162,7 @@
>  
>  #define PCI_VENDOR_ID_LOONGSON		0x0014
>  
> +#define PCI_DEVICE_ID_LOONGSON_EHCI     0x7a14

If you read the top of this file, does this patch meet the requirement
to add this entry here to this file?

thanks,

greg k-h

