Return-Path: <stable+bounces-126713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18E2A71824
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 15:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B72E171919
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6361F2369;
	Wed, 26 Mar 2025 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="dg2WFhk7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD281F30CC
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998320; cv=none; b=O+9pGAMJ28WAldSzmA0wpFkP/aoR2iNoKUsyyLJrOl5iJWaYeAK1tL0enc95//GsAvIBznvPS/sbFb8pCazIuE1VZsWdplsHE/MmCUaW+3uCBOoxHBtCU3JdoMw9B3TknLarP3n+mDoaDOGero22MX6ds7NNmBUMfTEoG7h/DA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998320; c=relaxed/simple;
	bh=yXtz2926jy2R/WRj7oe5ZqUVxpPtrQBW9y6HOZP7ZoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6A91HPYvOn6AGaX5FWu4RSpLBOPBzTCT39n4rSbgPXNeXU5VQZEcLLNVLM6qTW6l+IkSK+kRxl/bpw6e8VmHlGbUQU6yDUVqxBcb5b+ZDrgt9Ed97cWaQTzSS0ELEqBtWXsnb00ERu15EM9mOVFWTTHsNHezq2jXVn2amvepLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=dg2WFhk7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476a304a8edso61372821cf.3
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1742998316; x=1743603116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/yJeop5/9lZPmW3LTcIpQF3Z1hxE5T9Z8IMFMo+YuI4=;
        b=dg2WFhk7u5LYiIVloCKyw93R82LDagTN4QY6LLBGJ3p6hd9iO7Au6/23lDeWUuirXw
         lNVVJdn70jt68EP6blBQhXhYRhx4WNW2Wl8rLDgtNM5CK8PFDFvsmyZvOgqDUTeJT0bi
         2ERa+DNhfKb+bSb5hT0BLjIlomeHYtKIHHinCHuvnV3wvpzdWnpUiE4zqH+4uToiR7M9
         j8kBdO8d15Qi3M+wrRnxSIquIbrDV7FeAwduonrphUgKQrLgs0+Iq3gZdCu1ODkDrrbr
         zDfwhGa9mBA1eoLeqZ6Gy7xiiOwW1fU1jHbA3+x26n/ueEXp0gADr1uQ4reOwdaKkXmy
         ccDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998316; x=1743603116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yJeop5/9lZPmW3LTcIpQF3Z1hxE5T9Z8IMFMo+YuI4=;
        b=Ux6sbyiJd146iW+ygp9OqnkbeJbnd/nGWqvhf5xQvoj99Gxdc6epoKjTile6OC/S4M
         Mmoeb8wNAtwEdty+6mnPxsTb+7fpRp0776e0tgyuF58VBFCq7Xl8RWp6Dz+SZSNVCdqO
         oUPRuftrqdrteYfnHFYRqu7rXtC6f+yA9DpBChiCXpcNDB7w6qNgq2uDqdvs3+EM84Xq
         GhdjEgJTIQp+7XAE34QsxhJdnfm8F9bF0GEndFFdciLNmJSFibHGUaJxCaIrrJ5MG2uG
         9ddR7DU2dppNwmK1LFC2ikMjmo9H0SG3TliL2EV3xp0Fi6/p+8u5a9IoLSoiZFyIWjYB
         gwoA==
X-Forwarded-Encrypted: i=1; AJvYcCXWC8WXWIGY5adubtTgEk+ZMgG6vbvlCzLaH16d5GrUncgS9Y2aFWX5ejUfUgStgTvIHzyKEBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHZ1F4Bb/w2o6YG+zkqBetlu20u1RMS86uSC7rmAPmlNrcGRn
	LEDJeiiilhrz43VQBf4/hnvpSbGQt0MEDvF64do4iXjg1zK3UwQ6veC+7aZHkg==
X-Gm-Gg: ASbGncuOBduJV/tjl1HZJsy2I5BeK3gWamQAvjHotIqgGwj5KMuIjsRwBsOBqZaOhVn
	snWBJEGZMQy7/5egEe0VXqEBHDcka9ip/JwvlRb941ojyYtWS8Z4V+Rxgp5O4jElEA/d7ofBP9O
	6/eQyj8Gx3IceRMfZ6N87+r8CG8sdM0fVl4GrwgcueyTe2RO7UH8xgGoeMqy478Su269OztK7DK
	aRJ3AsH2nZ7cEFqb1M7a2L1Ul3aXy3iqxuKlDtEGfB/8gzSvyPS9AkTtQXssOyxj7F7lj5t/sCE
	PLbgs3HkG0s8LAERIFoiwptSpKqJilXeGxQMUMhxktgkv2wqFYpzKu0csyXMkjw=
X-Google-Smtp-Source: AGHT+IFZCtFXRFi1B9VodvEj5Mj7HA1YzrBpLpz2+TIPt+Odd8LHmFlysvBHDrxXPsEe1PHedgDd0A==
X-Received: by 2002:a05:622a:248e:b0:476:b56d:eb46 with SMTP id d75a77b69052e-4771dd77d25mr324475231cf.15.1742998311539;
        Wed, 26 Mar 2025 07:11:51 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d15a193sm72082021cf.14.2025.03.26.07.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:11:51 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:11:48 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mingcong Bai <jeffbai@aosc.io>
Subject: Re: [PATCH] USB: OHCI: Add quirk for LS7A OHCI controller (rev 0x02)
Message-ID: <ab64291d-2684-4558-8362-9195cce1de07@rowland.harvard.edu>
References: <20250326102355.2320755-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326102355.2320755-1-chenhuacai@loongson.cn>

On Wed, Mar 26, 2025 at 06:23:55PM +0800, Huacai Chen wrote:
> The OHCI controller (rev 0x02) under LS7A PCI host has a hardware flaw.
> MMIO register with offset 0x60/0x64 is treated as legacy PS2-compatible
> keyboard/mouse interface, which confuse the OHCI controller. Since OHCI
> only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB BAR
> is wrapped around (the second 4KB BAR space is the same as the first 4KB
> internally). So we can add an 4KB offset (0x1000) to the OHCI registers
> (from the PCI BAR resource) as a quirk.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Mingcong Bai <jeffbai@aosc.io>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/usb/host/ohci-pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
> index 900ea0d368e0..38e535aa09fe 100644
> --- a/drivers/usb/host/ohci-pci.c
> +++ b/drivers/usb/host/ohci-pci.c
> @@ -165,6 +165,15 @@ static int ohci_quirk_amd700(struct usb_hcd *hcd)
>  	return 0;
>  }
>  
> +static int ohci_quirk_loongson(struct usb_hcd *hcd)
> +{
> +	struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
> +
> +	hcd->regs += (pdev->revision == 0x2) ? 0x1000 : 0x0;

Please add a comment explaining why the quirk is needed and how it fixes 
the problem.

Alan Stern

> +
> +	return 0;
> +}
> +
>  static int ohci_quirk_qemu(struct usb_hcd *hcd)
>  {
>  	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
> @@ -224,6 +233,10 @@ static const struct pci_device_id ohci_pci_quirks[] = {
>  		PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4399),
>  		.driver_data = (unsigned long)ohci_quirk_amd700,
>  	},
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a24),
> +		.driver_data = (unsigned long)ohci_quirk_loongson,
> +	},
>  	{
>  		.vendor		= PCI_VENDOR_ID_APPLE,
>  		.device		= 0x003f,
> -- 
> 2.47.1
> 

